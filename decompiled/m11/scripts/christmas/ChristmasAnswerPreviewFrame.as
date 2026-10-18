package christmas
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class ChristmasAnswerPreviewFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _bg:Bitmap;
      
      public function ChristmasAnswerPreviewFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,354,303);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChristmasAnswerPreviewItem = null;
         titleText = LanguageMgr.GetTranslation("ChristmasPrayPreviewFrame.titleText.txt");
         _border = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerPreviewFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerPreviewFrame.bg");
         addToContent(_border);
         addToContent(_bg);
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new ChristmasAnswerPreviewItem(_loc2_ + 1);
            _loc1_.x = 0;
            _loc1_.y = _loc2_ * 68;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         FrameControllerManager.instance.christmasController.setPreFrame("");
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         FrameControllerManager.instance.christmasController.setPreFrame("christmas");
      }
   }
}

