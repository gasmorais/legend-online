package yishi.view.base
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import yishi.manager.NotificationManager;
   
   public class ViewBaseFrame extends Frame
   {
      
      public function ViewBaseFrame()
      {
         super();
         initView();
         initEvent();
         initCompleted();
      }
      
      protected function initView() : void
      {
      }
      
      protected function initEvent(param1:Boolean = true) : void
      {
         if(param1)
         {
            addEventListener("response",_frameResponse);
         }
         else
         {
            addEventListener("response",_frameResponse);
         }
      }
      
      protected function initCompleted() : void
      {
      }
      
      protected function addEvent(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         NotificationManager.instance.addEventListener(param1,param2,param3,param4,param5);
      }
      
      protected function removeEvent(param1:String, param2:Function, param3:Boolean = false) : void
      {
         NotificationManager.instance.removeEventListener(param1,param2,param3);
      }
      
      protected function creatBitmap(param1:String) : Bitmap
      {
         return ComponentFactory.Instance.creatBitmap(param1);
      }
      
      protected function creatBitmapData(param1:String) : BitmapData
      {
         return ComponentFactory.Instance.creatBitmapData(param1);
      }
      
      protected function creatComponentByStylename(param1:String, param2:Array = null) : *
      {
         return ComponentFactory.Instance.creatComponentByStylename(param1,param2);
      }
      
      public function _frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
         }
      }
   }
}

