package events
{
   import flash.events.Event;
   
   public class ChildPatrolEvent extends Event
   {
      
      public static const UPDATE_QUEUE_CHILDPATROL_TOWER:String = "UPDATE_QUEUE_CHILDPATROL_TOWER";
      
      public static const UPDATE_FRIENDS_STATE_CHILDPATROL:String = "UPDATE_FRIENDS_STATE_CHILDPATROL";
      
      public static const UPDATE_HEADQUARTERS_CHILDPATROL:String = "UPDATE_HEADQUARTERS_CHILDPATROL";
      
      public static const UPDATE_TOWERINFO_CHILDPATROL:String = "UPDATE_TOWERINFO_CHILDPATROL";
      
      public static const UPDATE_BOTTOM_CHILDLIST:String = "UPDATE_BOTTOM_CHILDLIST";
      
      public static const SELECT_ADD_CHILDPATROL:String = "SELECT_ADD_CHILDPATROL";
      
      public static const SELECT_DEL_CHILDPATROL:String = "SELECT_DEL_CHILDPATROL";
      
      public var data:Object;
      
      public function ChildPatrolEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

