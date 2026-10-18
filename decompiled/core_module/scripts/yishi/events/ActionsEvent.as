package yishi.events
{
   import flash.events.Event;
   
   public class ActionsEvent extends Event
   {
      
      public static const ACTION_ALL_COMPLETE:String = "action_all_complete";
      
      public function ActionsEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

