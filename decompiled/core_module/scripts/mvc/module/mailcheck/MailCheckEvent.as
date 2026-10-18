package mvc.module.mailcheck
{
   import flash.events.Event;
   
   public class MailCheckEvent extends Event
   {
      
      public static const STATE_UPDATE:String = "MailCheckEvent.STATE_UPDATE";
      
      public var data:Object;
      
      public function MailCheckEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

