package events
{
   import flash.events.Event;
   
   public class BottleEvent extends Event
   {
      
      public static const UPDATE_REWARDS_INFO:String = "UPDATE_REWARDS_INFO";
      
      public static const UPDATE_LUCK_SHOW_INFO:String = "UPDATE_LUCK_SHOW_INFO";
      
      public static const CT__UPDATE_BOX_STATUS:String = "CT__UPDATE_BOX_STATUS";
      
      public static const UPDATE_REWARD_USERINFO:String = "UPDATE_REWARD_USERINFO";
      
      public static const UPDATE_LAYER_SHOW_INFO:String = "UPDATE_LAYER_SHOW_INFO";
      
      public var data:*;
      
      public function BottleEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

