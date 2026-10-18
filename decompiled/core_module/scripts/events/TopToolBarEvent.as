package events
{
   import flash.events.Event;
   
   public class TopToolBarEvent extends Event
   {
      
      public static const REFRESH_BTN_TEXT:String = "REFRESH_BTN_TEXT";
      
      public static const REFRESH_TIPSBTN_TEXT:String = "REFRESH_TIPSBTN_TEXT";
      
      public var data:*;
      
      public function TopToolBarEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

