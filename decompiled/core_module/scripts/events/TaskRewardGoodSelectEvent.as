package events
{
   import flash.events.Event;
   import mvc.module.task.TaskGoodsTemplate;
   
   public class TaskRewardGoodSelectEvent extends Event
   {
      
      public static const TASK_REWARD_GOOD_SELECTED:String = "task_good_selected";
      
      private var _good:TaskGoodsTemplate;
      
      public function TaskRewardGoodSelectEvent(param1:String, param2:TaskGoodsTemplate)
      {
         super(param1,false,false);
         _good = param2;
      }
      
      public function get good() : TaskGoodsTemplate
      {
         return _good;
      }
   }
}

