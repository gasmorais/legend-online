package theseusgodhead.events
{
   import flash.events.Event;
   
   public class TaskEvent extends Event
   {
      
      public static const REWARD_RECEIVE:String = "taskRewardReceive";
      
      public var taskId:int;
      
      public function TaskEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.taskId = param2;
      }
      
      override public function clone() : Event
      {
         return new TaskEvent(type,taskId,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("TaskEvent","type","taskId","bubbles","cancelable");
      }
   }
}

