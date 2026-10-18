package events
{
   import flash.events.Event;
   
   public class NavigationEvent extends Event
   {
      
      public static const NAVIGATION_DATA_CHANGE:String = "NAVIGATION_DATA_CHANGE";
      
      public static const NAVIGATION_BOAT_CHANGE:String = "NAVIGATION_BOAT_CHANGE";
      
      public static const NAVIGATION_BOAT_PATROL:String = "NAVIGATION_BOAT_PATROL";
      
      public static const NAVIGATION_PATROL_CLOSE:String = "NAVIGATION_PATROL_CLOSE";
      
      public static const FISHING_STATE_CHANGE:String = "FISHING_STATE_CHANGE";
      
      public var data:Object;
      
      public function NavigationEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

