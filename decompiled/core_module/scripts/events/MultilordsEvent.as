package events
{
   import flash.events.Event;
   
   public class MultilordsEvent extends Event
   {
      
      public static const INFO_UPDATE:String = "INFO_UPDATE";
      
      public static const CUR_BETTING_CHANGE:String = "CUR_BETTING_CHANGE";
      
      public static const REWARD_STATE_CHANGE:String = "REWARD_STATE_CHANGE";
      
      public static const LAST_AWARDLIST_UPDATE:String = "LAST_AWARDLIST_UPDATE";
      
      public static const ACCESS_FINALLIST_UPDATE:String = "ACCESS_FINALLIST_UPDATE";
      
      public static const TOP_AVATAR_CHANGE:String = "TOP_AVATAR_CHANGE";
      
      private var _data:Object;
      
      public function MultilordsEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new MultilordsEvent(type,data,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

