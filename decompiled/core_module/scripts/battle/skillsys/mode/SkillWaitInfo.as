package battle.skillsys.mode
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SkillWaitInfo
   {
      
      public var roleId:int;
      
      public var count:int;
      
      private var _timer:Timer;
      
      private var _completeFun:Function;
      
      public function SkillWaitInfo()
      {
         super();
      }
      
      public function countDown(param1:Function) : void
      {
         _completeFun = param1;
         removeTimer();
         _timer = new Timer(300,1);
         _timer.addEventListener("timerComplete",onTimerComplete);
         _timer.start();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         removeTimer();
         _completeFun(this);
      }
      
      private function removeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timerComplete",onTimerComplete);
            _timer = null;
         }
      }
   }
}

