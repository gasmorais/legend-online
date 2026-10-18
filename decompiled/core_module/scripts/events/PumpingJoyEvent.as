package events
{
   import flash.events.Event;
   
   public class PumpingJoyEvent extends Event
   {
      
      public static const PUMPING_JOY_MSG_BACK:String = "PUMPING_JOY_MSG_BACK";
      
      public static const PUMPING_JOY_DRAW_BACK:String = "PUMPING_JOY_DRAW_BACK";
      
      public static const PUMPING_JOY_SHOW_REWARD:String = "PUMPING_JOY_SHOW_REWARD";
      
      public function PumpingJoyEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

