package ui.events
{
   import flash.events.Event;
   
   public class UIBarEvent extends Event
   {
      
      public static const HIDE_TASK_TRACE:String = "HIDE_TASK_TRACE";
      
      public static const SHOW_TASK_TRACE:String = "SHOW_TASK_TRACE";
      
      public static const TASK_FRAME_OPENED:String = "taskFrameOpened";
      
      public static const HERO_FRAME_OPENED:String = "heroFrameOpened";
      
      public static const HERO_FRAME_CLOSED:String = "heroFrameClosed";
      
      public static const ALLOCATEPAWN_FRAM_OPENED:String = "allocatePawnFrameOpened";
      
      public static const SOTRE_FRAME:String = "store_frame";
      
      public static const MOREMENU:String = "moreMenu";
      
      public static const BAG_FRAME_OPENED:String = "bagFrameOpened";
      
      public static const BUY_BLOOD_SUCCESS:String = "BUY_BLOOD_SUCCESS";
      
      public static const BUTTON_ADDED:String = "BUTTON_ADDED";
      
      private var _data:Object;
      
      public function UIBarEvent(param1:String, param2:Object = null)
      {
         _data = param2;
         super(param1);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

