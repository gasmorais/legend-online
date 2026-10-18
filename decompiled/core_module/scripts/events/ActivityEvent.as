package events
{
   import flash.events.Event;
   
   public class ActivityEvent extends Event
   {
      
      public static const ACTIVITY_RESULT:String = "activity_result";
      
      public static const ACTIVITYLIST_CHANGED:String = "activitylist_changed";
      
      public var data:Object;
      
      public function ActivityEvent(param1:String, param2:Object)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

