package christmas
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.NotificationManager;
   
   public class ChristmasFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _timeTxt:FilterFrameText;
      
      private var _itemList:Array = [];
      
      public function ChristmasFrame()
      {
         super();
         initView();
         addEvent();
         ChristmasManager.instance.opRequest(1);
         __refreshTopToolsHandler(null);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1043,651);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("christmasFrame.bg");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("christmasFrame.timeTxt");
         addToContent(_bg);
         addToContent(_timeTxt);
         initItem();
         _timeTxt.htmlText = LanguageMgr.GetTranslation("ChristmasFrame.timeTxt.text",model.openTimeStr,model.stopTimeStr);
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChristmasItem = null;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ChristmasItem(_loc2_ + 1);
            _loc1_.x = 323 + int(_loc2_ % 4) * 145;
            _loc1_.y = 145 + int(_loc2_ / 4) * 187;
            _itemList.push(_loc1_);
            addToContent(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
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
      
      public function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChristmasItem = null;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
            _loc2_++;
         }
         _itemList = null;
         super.dispose();
      }
   }
}

