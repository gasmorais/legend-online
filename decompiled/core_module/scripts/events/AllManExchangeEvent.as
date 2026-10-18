package events
{
   import flash.events.Event;
   
   public class AllManExchangeEvent extends Event
   {
      
      public static const UPDATE_INFO:String = "UPDATE_INFO";
      
      public var data:*;
      
      public function AllManExchangeEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

