package events
{
   import flash.events.Event;
   
   public class ConsortiaMenuEvent extends Event
   {
      
      public static const SHOW_MEMBER_LIST:String = "SHOW_MEMBER_LIST";
      
      public function ConsortiaMenuEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

