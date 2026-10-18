package events
{
   import flash.events.Event;
   
   public class WorldBossEvent extends Event
   {
      
      public static const UPDATE_WOUND_LIST:String = "UPDATE_WOUND_LIST";
      
      public static const UPDATE_STATE_LIST:String = "UPDATE_STATE_LIST";
      
      public static const UPDATE_WARFIGHT_STATE_LIST:String = "UPDATE_WARFIGHT_STATE_LIST";
      
      public static const REWARDS_INIT:String = "REWARDS_INIT";
      
      public var data:Object;
      
      public function WorldBossEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

