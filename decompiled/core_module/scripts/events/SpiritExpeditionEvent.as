package events
{
   import flash.events.Event;
   
   public class SpiritExpeditionEvent extends Event
   {
      
      public static const EXPEDITION_INFO_UPDATE:String = "EXPEDITION_INFO_UPDATE";
      
      public static const FORMATION_INFO_UPDATE:String = "FORMATION_INFO_UPDATE";
      
      public static const CHILD_SKILL_SELECT:String = "CHILD_SKILL_SELECT";
      
      public var data:Object;
      
      public function SpiritExpeditionEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

