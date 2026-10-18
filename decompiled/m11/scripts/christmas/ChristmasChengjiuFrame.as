package christmas
{
   import christmas.view.ChristmasCjView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mvc.module.christmas.ChristmasModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.NotificationManager;
   
   public class ChristmasChengjiuFrame extends Frame implements IManualSize
   {
      
      private var _view:ChristmasCjView;
      
      private var _timer:Timer;
      
      public function ChristmasChengjiuFrame()
      {
         super();
         initView();
         initEvent();
         timeHandler(null);
      }
      
      private function initView() : void
      {
         _view = new ChristmasCjView();
         addToContent(_view);
         _timer = new Timer(60000);
         _timer.start();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1043,651);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         ChristmasManager.instance.addEventListener("christmas.TASK_UPDATE",taskUpdateHandler);
         _timer.addEventListener("timer",timeHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         ChristmasManager.instance.removeEventListener("christmas.TASK_UPDATE",taskUpdateHandler);
         _timer.stop();
         _timer.removeEventListener("timer",timeHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function timeHandler(param1:TimerEvent) : void
      {
         ChristmasManager.instance.opRequest(23);
      }
      
      private function taskUpdateHandler(param1:NotificationEvent) : void
      {
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
         _timer = null;
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

