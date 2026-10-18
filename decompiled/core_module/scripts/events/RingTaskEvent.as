package events
{
   import flash.events.Event;
   import mvc.module.ringtask.RingTask;
   
   public class RingTaskEvent extends Event
   {
      
      public static const REFRESHRING:String = "REFRESHTING";
      
      public static const ADDRINGTASK:String = "ADDRINGTASK";
      
      public static const COMPLETETASK:String = "COMPLETETASK";
      
      private var _baseReward:RingTask;
      
      public function RingTaskEvent(param1:String, param2:RingTask)
      {
         super(param1,bubbles,cancelable);
         _baseReward = param2;
      }
      
      override public function clone() : Event
      {
         return new RingTaskEvent(type,data);
      }
      
      public function get data() : RingTask
      {
         return _baseReward;
      }
   }
}

