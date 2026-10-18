package airgarden
{
   import airgarden.item.AirGardenJoinPartyItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.AirGardenManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.airgarden.AirGardenModel;
   import yishi.utils.MsgMan;
   
   public class AirGardenJoinPartyFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _itemPanel:ScrollPanel;
      
      private var _itemVbox:VBox;
      
      public function AirGardenJoinPartyFrame()
      {
         super();
         initView();
         addEvent();
         AirGardenManager.instance.requestAirGarden(2);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,570,530);
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyFrame.border");
         _itemPanel = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyFrame.itemPanel");
         _itemVbox = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyFrame.itemVbox");
         addToContent(_border);
         addToContent(_itemPanel);
         _itemPanel.setView(_itemVbox);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("PARTY_LIST_UPDATE",this,__updatePartyListHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("PARTY_LIST_UPDATE",this,__updatePartyListHandler);
      }
      
      private function __updatePartyListHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:AirGardenJoinPartyItem = null;
         _itemVbox.removeAllChild();
         var _loc1_:Array = model.serverPartyList;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new AirGardenJoinPartyItem();
            _loc2_.data = _loc1_[_loc3_];
            _itemVbox.addChild(_loc2_);
            _loc3_++;
         }
         _itemPanel.beginChanges();
         _itemPanel.invalidateViewport();
         _itemPanel.commitChanges();
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("AirGardenJoinPartyFrame.title.text");
      }
      
      private function get model() : AirGardenModel
      {
         return AirGardenManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_itemPanel);
         _itemPanel = null;
         ObjectUtils.disposeObject(_itemVbox);
         _itemVbox = null;
         super.dispose();
      }
   }
}

