package events
{
   import flash.events.Event;
   
   public class TimeBoxEvent extends Event
   {
      
      public static const TIME_COMPLETE:String = "TIME_COMPLETE";
      
      public static const UPDATE_TIME_BOX:String = "UPDATE_TIME_BOX";
      
      public function TimeBoxEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

