package events
{
   import flash.events.Event;
   
   public class AncientArtifactEvent extends Event
   {
      
      public static const ARMORY_BAG_UP_DATA:String = "ARMORY_BAG_UP_DATA";
      
      public static const ARMORY_EQUIP_BAG_UP_DATA:String = "ARMORY_EQUIP_BAG_UP_DATA";
      
      public static const RESONATE_INFO_UP_DATA:String = "RESONATE_INFO_UP_DATA";
      
      public static const ARMORY_CHOOSE_DATA:String = "ARMORY_CHOOSE_DATA";
      
      private var _data:Object;
      
      public function AncientArtifactEvent(param1:String, param2:Object = null, param3:Boolean = false)
      {
         _data = param2;
         super(param1,bubbles,param3);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

