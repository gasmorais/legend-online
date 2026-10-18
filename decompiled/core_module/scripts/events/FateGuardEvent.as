package events
{
   import flash.events.Event;
   
   public class FateGuardEvent extends Event
   {
      
      public static const FATE_GUARD_GP:String = "fategpchange";
      
      public function FateGuardEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

