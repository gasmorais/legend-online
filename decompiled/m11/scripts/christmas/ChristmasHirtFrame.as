package christmas
{
   import christmas.view.ChristmasHirtView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import mvc.module.christmas.ChristmasModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.NotificationManager;
   
   public class ChristmasHirtFrame extends Frame implements IManualSize
   {
      
      private var _view:ChristmasHirtView;
      
      public function ChristmasHirtFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = new ChristmasHirtView();
         addToContent(_view);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1043,651);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         ChristmasManager.instance.addEventListener("EVENT_UPDATE",updateHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         ChristmasManager.instance.removeEventListener("EVENT_UPDATE",updateHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(ChristmasManager.instance.model.result);
         if(_loc2_ > 0)
         {
            _view.play(_loc2_);
         }
         _view.updateView();
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
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
   }
}

