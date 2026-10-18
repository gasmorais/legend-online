package planeswar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesLayerInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.PlanesTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.TempleteManager;
   
   public class PlanesWarLayerMapFrame extends Frame
   {
      
      private var back:ScaleFrameImage;
      
      private var itemContiner:Component;
      
      private var layerArr:Array = [5,11,17];
      
      private var widthArr:Array = [265,470,668];
      
      private var itemPosArr:Array = [[-15,115],[30,10],[105,202],[67,115],[153,115],[218,115],[288,115],[335,202],[250,10],[320,55],[358,115],[415,115],[471,202],[530,175],[462,80],[430,10],[555,115]];
      
      private var itemList:Vector.<PlanesWarLayerItem>;
      
      public function PlanesWarLayerMapFrame()
      {
         super();
         initView();
         initItemListView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("PlanesWarLayerMapFrame.back");
         itemContiner = ComponentFactory.Instance.creatComponentByStylename("PlanesWarLayerMapFrame.itemContiner");
         addToContent(back);
         addToContent(itemContiner);
         if(planesTempInfo)
         {
            this.titleText = planesTempInfo.PlanesName;
         }
         back.setFrame(size + 1);
      }
      
      private function initItemListView() : void
      {
         var _loc4_:PlanesLayerInfo = null;
         var _loc3_:int = 0;
         var _loc1_:PlanesWarLayerItem = null;
         itemList = new Vector.<PlanesWarLayerItem>();
         var _loc2_:int = int(layerArr[size]);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = model.planesLayerList[_loc3_];
            _loc1_ = new PlanesWarLayerItem();
            _loc1_.x = itemPosArr[_loc3_][0];
            _loc1_.y = itemPosArr[_loc3_][1];
            itemContiner.addChild(_loc1_);
            _loc1_.data = _loc4_;
            itemList.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function refreshView() : void
      {
         if(!planesTempInfo)
         {
            return;
         }
      }
      
      private function get size() : int
      {
         if(!planesTempInfo)
         {
            return 0;
         }
         return layerArr.indexOf(planesTempInfo.TotalLayer);
      }
      
      private function get planesTempInfo() : PlanesTemplateInfo
      {
         return TempleteManager.instance.planesTemplateCate.getTemplateByID(model.planesWarInfo.planesTempId);
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         this.width = widthArr[size];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(itemContiner);
         itemContiner = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

