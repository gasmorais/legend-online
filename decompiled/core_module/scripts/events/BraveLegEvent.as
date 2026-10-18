package events
{
   import flash.events.Event;
   
   public class BraveLegEvent extends Event
   {
      
      public static const TEAMLIST_UPDATE:String = "BraveLegEvent.TEAMLIST_UPDATE";
      
      public static const TEAM_INSPIRE:String = "BraveLegEvent.TEAM_INSPIRE";
      
      public static const RANK_INFO:String = "BraveLegEvent.RANK_INFO";
      
      public static const INVITE_INFO:String = "BraveLegEvent.INVITE_INFO";
      
      public static const CLOSE_SIGNUP:String = "BraveLegEvent.CLOSE_SIGNUP";
      
      public static const CLOSE_TEAM:String = "BraveLegEvent.CLOSE_TEAM";
      
      private var _data:Object;
      
      public function BraveLegEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new BraveLegEvent(type,data,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

