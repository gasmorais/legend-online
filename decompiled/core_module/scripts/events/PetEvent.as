package events
{
   import flash.events.Event;
   
   public class PetEvent extends Event
   {
      
      public static const PETINFO_CHANGE:String = "PETINFO_CHANGE";
      
      public static const PET_DATA:String = "PET_DATA";
      
      public static const PET_ADD:String = "PET_ADD";
      
      public static const PET_UPDATE:String = "PET_UPDATE";
      
      public static const PET_REMOVE:String = "PET_REMOVE";
      
      public static const ENTERWAR_PET_CHANGE:String = "PET_ENTERWAR_CHANGE";
      
      public static const PET_LEVEL_UP:String = "PET_LEVEL_UP";
      
      public static const PET_CHALLENGE_SKILL_CHANGE:String = "PET_CHALLENGE_SKILL_CHANGE";
      
      public static const PET_SKILL_CHANGE:String = "PET_SKILL_CHANGE";
      
      public static const PET_MAXCOUNT_CHANGE:String = "PET_MAXCOUNT_CHANGE";
      
      public static const PET_BOSS_ITEM_CLICK:String = "PetEvent.PET_BOSS_ITEM_CLICK";
      
      public static const PET_HALLOWS_HEAD_SELECT:String = "PET_HALLOWS_HEAD_SELECT";
      
      public static const PET_HALLOWS_MSG_UPDATE:String = "PET_HALLOWS_MSG_UPDATE";
      
      public static const PET_HALLOWS_MAINMC_UPDATE:String = "PET_HALLOWS_MAINMC_UPDATE";
      
      public static const PET_INSCRIPTION_LOCK_CHANGE:String = "PET_INSCRIPTION_LOCK_CHANGE";
      
      public var data:Object;
      
      public function PetEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         data = param2;
      }
   }
}

