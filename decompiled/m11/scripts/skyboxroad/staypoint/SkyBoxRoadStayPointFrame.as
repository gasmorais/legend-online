package skyboxroad.staypoint
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.SkyboxRoadManager;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   
   public class SkyBoxRoadStayPointFrame extends Frame
   {
      
      private var border:Scale9CornerImage;
      
      private var back:Bitmap;
      
      private var alertText:FilterFrameText;
      
      private var hbox:HBox;
      
      private var itemList:Vector.<SkyBoxRoadStayPointItem>;
      
      public function SkyBoxRoadStayPointFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshView();
         SkyboxRoadManager.instance.sendPointOccupyRequest(8,model.currentPortalId);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointFrame.border");
         back = ComponentFactory.Instance.creatBitmap("asset.SkyBoxRoadStayPointFrame.back");
         hbox = ComponentFactory.Instance.creatCustomObject("SkyBoxRoadStayPointFrame.hbox");
         alertText = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadStayPointFrame.alertText");
         addToContent(border);
         addToContent(back);
         addToContent(hbox);
         addToContent(alertText);
         alertText.htmlText = LanguageMgr.GetTranslation("SkyBoxRoadStayPointFrame.alertText.text");
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SkyBoxRoadStayPointItem = null;
         itemList = new Vector.<SkyBoxRoadStayPointItem>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new SkyBoxRoadStayPointItem(_loc2_ + 1);
            hbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("SKYBOX_ROAD_OCCUPYLIST_UPDATE",this,__occupyListUpdate);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("SKYBOX_ROAD_OCCUPYLIST_UPDATE",this,__occupyListUpdate);
      }
      
      private function __occupyListUpdate(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SkyBoxRoadStayPointItem = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = itemList[_loc2_];
            _loc1_.data = model.getPointInfoByIndex(_loc2_ + 1);
            _loc2_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("SkyBoxRoadStayPointFrame.titleText.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeObject(hbox);
         hbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

