package events
{
   import flash.events.Event;
   
   public class PlatinumEvent extends Event
   {
      
      public static const PLATINA_ACTIVE_ITEMID:String = "PLATINA_ACTIVE_ITEMID";
      
      public static const PLATINA_ACTIVE_INFO:String = "PLATINA_ACTIVE_INFO";
      
      public static const PLATINA_ACTIVE_LUCKPASS_TIP:String = "PLATINA_ACTIVE_LUCKPASS_TIP";
      
      public static const PLATINA_ACTIVE_PERSONAL_TIP:String = "PLATINA_ACTIVE_PERSONAL_TIP";
      
      public var data:*;
      
      public function PlatinumEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

