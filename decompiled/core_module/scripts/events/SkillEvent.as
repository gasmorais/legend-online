package events
{
   import flash.events.Event;
   
   public class SkillEvent extends Event
   {
      
      public static const SKILL_UPGRADE:String = "SKILL_UPGRADE";
      
      public static const SKILL_RESET:String = "SKILL_RESET";
      
      public static const OPEN_RUNE_VIEW:String = "OPEN_RUNE_VIEW";
      
      public static const SET_FAST_KEY:String = "SET_FAST_KEY";
      
      public static const FAST_KEY_MOVE:String = "FAST_KEY_MOVE";
      
      public static const REFRESH_LINE:String = "REFRESH_LINE";
      
      public var data:*;
      
      public function SkillEvent(param1:String, param2:*, param3:Boolean = false)
      {
         super(param1,param3,false);
         data = param2;
      }
   }
}

