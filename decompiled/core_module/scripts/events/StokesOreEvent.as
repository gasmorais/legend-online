package events
{
   import flash.events.Event;
   
   public class StokesOreEvent extends Event
   {
      
      public static const START_NEXT_ORE:String = "START_NEXT_ORE";
      
      public static const UPDATE_REWARDS_INFO:String = "UPDATE_REWARDS_INFO";
      
      public static const UPDATE_LUCK_SHOW_INFO:String = "UPDATE_LUCK_SHOW_INFO";
      
      public static const UPDATE_CROSSINFO:String = "UPDATE_CROSSINFO";
      
      public static const UPDATE_STATUS:String = "UPDATE_STATUS";
      
      public var data:*;
      
      public function StokesOreEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

