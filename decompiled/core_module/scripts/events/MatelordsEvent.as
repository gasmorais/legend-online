package events
{
   import flash.events.Event;
   
   public class MatelordsEvent extends Event
   {
      
      public static const INFO_UPDATE:String = "INFO_UPDATE";
      
      public static const ACCESS_FINALLIST_UPDATE:String = "ACCESS_FINALLIST_UPDATE";
      
      public static const DEMON_LIST_UPDATE:String = "DEMON_LIST_UPDATE";
      
      public static const DEMON_SCORE_UPDATE:String = "DEMON_SCORE_UPDATE";
      
      private var _data:Object;
      
      public function MatelordsEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new MatelordsEvent(type,data,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

