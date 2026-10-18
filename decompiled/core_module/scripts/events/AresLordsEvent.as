package events
{
   import flash.events.Event;
   
   public class AresLordsEvent extends Event
   {
      
      public static const INFO_UPDATE:String = "AresLordsEvent.INFO_UPDATE";
      
      public static const SKILL_INFO:String = "AresLordsEvent.SKILL_INFO";
      
      public static const RANK_INFO:String = "AresLordsEvent.RANK_INFO";
      
      private var _data:Object;
      
      public function AresLordsEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new AresLordsEvent(type,data,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

