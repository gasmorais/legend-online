package mvc.module.friends
{
   import flash.events.Event;
   
   public class IMEvent extends Event
   {
      
      public static const MSGBOX_SHINING_UPDATE:String = "MSGBOX_SHINING_UPDATE";
      
      public static const MSG_LIST_DEL:String = "MSG_LIST_DEL";
      
      public static const MSG_SEND_RESPONSE:String = "MSG_SEND_RESPONSE";
      
      public static const RECEIVE_MSG:String = "RECEIVE_MSG";
      
      private var _msg:BaseIMInfo;
      
      public function IMEvent(param1:String, param2:BaseIMInfo = null)
      {
         super(param1);
         _msg = param2;
      }
      
      override public function clone() : Event
      {
         return new IMEvent(type,msg);
      }
      
      public function get msg() : BaseIMInfo
      {
         return _msg;
      }
   }
}

