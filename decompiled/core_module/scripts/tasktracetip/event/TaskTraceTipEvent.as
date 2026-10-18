package tasktracetip.event
{
   import flash.events.Event;
   
   public class TaskTraceTipEvent extends Event
   {
      
      public static const UPDATE_TASK_TRACE_TIP:String = "UPDATE_TASK_TRACE_TIP";
      
      public function TaskTraceTipEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

