package events
{
   import flash.events.Event;
   
   public class LordTrialEvent extends Event
   {
      
      public static const UPDATE_VIEW:String = "UPDATE_VIEW";
      
      public static const UPDATEMOPUP:String = "UPDATEMOPUP";
      
      public static const UPDATE_RANKDATA:String = "UPDATE_RANKDATA";
      
      public static const INFO_UPDATE:String = "INFO_UPDATE";
      
      private var _data:Object;
      
      public function LordTrialEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new LordTrialEvent(type,data,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

