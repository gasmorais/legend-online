package mvc.module.task
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TaskInfo extends EventDispatcher
   {
      
      public var userId:int;
      
      public var taskId:int;
      
      public var isComplete:Boolean;
      
      public var completeDate:Date;
      
      public var acceptDate:Date;
      
      public var condition1:int;
      
      public var condition2:int;
      
      public var condition3:int;
      
      public var condition4:int;
      
      public var isSelect:Boolean;
      
      public var repeatFinish:int;
      
      public var isExist:Boolean;
      
      private var _isRequired:Boolean;
      
      private var _isNew:Boolean;
      
      private var _isAchieved:Boolean;
      
      private var _sendTime:int;
      
      private var _checkTime:int;
      
      private var _phoneStr:String;
      
      public var checkNumber:int;
      
      private var _timer1:Timer;
      
      private var _timer2:Timer;
      
      public function TaskInfo()
      {
         super();
      }
      
      private function initTimer1() : void
      {
         if(!_timer1)
         {
            _timer1 = new Timer(1000);
         }
         _timer1.addEventListener("timer",__updateHandler1);
      }
      
      private function initTimer2() : void
      {
         if(!_timer2)
         {
            _timer2 = new Timer(1000);
         }
         _timer2.addEventListener("timer",__updateHandler2);
      }
      
      private function __updateHandler1(param1:TimerEvent) : void
      {
         _sendTime = _sendTime - 1;
         dispatchEvent(new Event("change"));
         if(_sendTime <= 0)
         {
            dispatchEvent(new Event("complete"));
            _timer1.stop();
            _timer1.removeEventListener("timer",__updateHandler1);
         }
      }
      
      private function __updateHandler2(param1:TimerEvent) : void
      {
         _checkTime = _checkTime - 1;
         dispatchEvent(new Event("change"));
         if(_checkTime <= 0)
         {
            dispatchEvent(new Event("complete"));
            _timer2.stop();
            _timer2.removeEventListener("timer",__updateHandler2);
         }
      }
      
      public function get sendTime() : int
      {
         return _sendTime;
      }
      
      public function set sendTime(param1:int) : void
      {
         _sendTime = param1;
         if(_sendTime > 0)
         {
            dispatchEvent(new Event("change"));
            initTimer1();
            _timer1.reset();
            _timer1.start();
         }
      }
      
      public function get checkTime() : int
      {
         return _checkTime;
      }
      
      public function set checkTime(param1:int) : void
      {
         _checkTime = param1;
         if(_checkTime > 0)
         {
            dispatchEvent(new Event("change"));
            initTimer2();
            _timer2.reset();
            _timer2.start();
         }
      }
      
      public function get phoneStr() : String
      {
         return _phoneStr;
      }
      
      public function set phoneStr(param1:String) : void
      {
         _phoneStr = param1;
      }
      
      public function get isRequired() : Boolean
      {
         return _isRequired;
      }
      
      public function set isRequired(param1:Boolean) : void
      {
         _isRequired = param1;
      }
      
      public function get isNew() : Boolean
      {
         return _isNew;
      }
      
      public function set isNew(param1:Boolean) : void
      {
         _isNew = param1;
      }
      
      public function get isAchieved() : Boolean
      {
         if(completeDate && completeDate.fullYear < 2050)
         {
            return false;
         }
         return true;
      }
      
      public function set isAchieved(param1:Boolean) : void
      {
         _isAchieved = param1;
      }
   }
}

