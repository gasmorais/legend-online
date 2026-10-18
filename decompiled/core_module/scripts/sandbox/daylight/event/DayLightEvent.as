package sandbox.daylight.event
{
   import flash.events.Event;
   
   public class DayLightEvent extends Event
   {
      
      public static const SANDBOX_INFO_UPDATE:String = "SANDBOX_INFO_UPDATE";
      
      public static const UNIT_INFO_LIST_UPDATE:String = "UNIT_INFO_LIST_UPDATE";
      
      public static const USER_INFO_RANK_LIST_UPDATE:String = "USER_INFO_RANK_LIST_UPDATE";
      
      public static const SELF_INFO_UPDATE:String = "SELF_INFO_UPDATE";
      
      public static const SKILL_USE_RESULT_UPDATE:String = "SKILL_USE_RESULT_UPDATE";
      
      public var data:Object;
      
      public function DayLightEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

