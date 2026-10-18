package events
{
   import flash.events.Event;
   import mvc.module.task.TaskTemplate;
   
   public class TaskEvent extends Event
   {
      
      public static const TASK_DETAIL_CHANGE:String = "task_detail_change";
      
      public static const TASK_ADDED:String = "task_added";
      
      public static const MANUAL_TASK_ADDED:String = "manual_task_added";
      
      public static const TASK_REMOVE:String = "task_remove";
      
      public static const MANUAL_TASK_REMOVE:String = "manual_task_remove";
      
      public static const TASK_SHOWTIPS:String = "task_showtips";
      
      private var _data:TaskTemplate;
      
      public function TaskEvent(param1:String, param2:TaskTemplate)
      {
         super(param1,false,false);
         _data = param2;
      }
      
      public function get data() : TaskTemplate
      {
         return _data;
      }
   }
}

