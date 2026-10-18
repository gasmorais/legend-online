package mvc.module.dragonTitan
{
   import flash.events.Event;
   
   public class DragonTitanEvent extends Event
   {
      
      public static const TITAN_DATA:String = "DragonTitanEvent.TITAN_DATA";
      
      public static const TITAN_SET_SKILL:String = "DragonTitanEvent.TITAN_SET_SKILL";
      
      public static const TITAN_SET_SKILL_BACK:String = "DragonTitanEvent.TITAN_SET_SKILL_BACK";
      
      public static const TITAN_SKILL_USE:String = "DragonTitanEvent.TITAN_SKILL_USE";
      
      public static const TITAN_FAME_CLICK_SKILL:String = "TITAN_FAME_CLICK_SKILL";
      
      public static const TITAN_SKIL_SELECTED:String = "DragonTitanSkillSelected";
      
      public function DragonTitanEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}

