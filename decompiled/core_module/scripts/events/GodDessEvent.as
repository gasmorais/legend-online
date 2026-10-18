package events
{
   import flash.events.Event;
   
   public class GodDessEvent extends Event
   {
      
      public static const EVENT_LEVEL:String = "GodDessEvent.level";
      
      public static const EVENT_STEP:String = "GodDessEvent.step";
      
      public static const EVENT_DEVOTE:String = "GodDessEvent.devote";
      
      public static const EVENT_ISFIGHT:String = "GodDessEvent.isFight";
      
      public static const EVENT_ISACTIVE:String = "GodDessEvent.isActive";
      
      public static const EVENT_EXP_LEVEL:String = "GodDessEvent.expLevel";
      
      public static const EVENT_EXP_STEP:String = "GodDessEvent.expStep";
      
      public static const EVENT_EXP_DEVOTE:String = "GodDessEvent.expDevote";
      
      public static const EVENT_ACTIVE_SKILL:String = "GodDessEvent.activeSkill";
      
      public static const EVENT_DEFANCE_SKILL:String = "GodDessEvent.defanceSkill";
      
      public static const EVENT_CHOOSE:String = "GodDessEvent.choose";
      
      public static const EVENT_ARRAY_GODDESS_CHANGE:String = "EVENT_ARRAY_GODDESS_CHANGE";
      
      public static const EVENT_CHANGE_EQUIP:String = "EVENT_CHANGE_EQUIP";
      
      public static const EVENT_EQUIP_UPDATA:String = "EVENT_EQUIP_UPDATA";
      
      public var data:*;
      
      public function GodDessEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

