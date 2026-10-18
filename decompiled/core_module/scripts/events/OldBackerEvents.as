package events
{
   import flash.events.Event;
   
   public class OldBackerEvents extends Event
   {
      
      public static const REFRESH_VIEW_INFO:String = "REFRESH_VIEW_INFO";
      
      public var data:*;
      
      public function OldBackerEvents(param1:String, param2:* = null)
      {
         super(param1,false,false);
         data = param2;
      }
   }
}

