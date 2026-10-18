package mvc.module.guidetask
{
   public class SimpleTaskInfo
   {
      
      private var _taskId:int;
      
      private var _isComplete:int;
      
      private var _isShow:Boolean = true;
      
      public function SimpleTaskInfo()
      {
         super();
      }
      
      public function get taskId() : int
      {
         return _taskId;
      }
      
      public function set taskId(param1:int) : void
      {
         _taskId = param1;
      }
      
      public function get isComplete() : int
      {
         return _isComplete;
      }
      
      public function set isComplete(param1:int) : void
      {
         _isComplete = param1;
      }
      
      public function get isShow() : Boolean
      {
         return _isShow;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         _isShow = param1;
      }
   }
}

