package events
{
   import flash.events.Event;
   
   public class AvengerEvent extends Event
   {
      
      public static const SKILL_ITEM_SELECT:String = "SKILL_ITEM_SELECT";
      
      public static const SKILL_INFO_UPDATE:String = "SKILL_INFO_UPDATE";
      
      public static const BODY_INFO_UPDATE:String = "BODY_INFO_UPDATE";
      
      public static const DEVIL_ARMOR_INFO_UPDATE:String = "DEVIL_ARMOR_INFO_UPDATE";
      
      public static const DEVIL_ARMOR_BAG_UPDATE:String = "DEVIL_ARMOR_BAG_UPDATE";
      
      public static const AVENGER_STORE_BAG_UPDATE:String = "AVENGER_STORE_BAG_UPDATE";
      
      public static const AVENGER_CHILDNS_UPDATE:String = "AVENGER_CHILDNS_UPDATE";
      
      public static const AVENGER_ALL_RESOLVE:String = "AVENGER_ALL_RESOLVE";
      
      public var data:Object;
      
      public function AvengerEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

