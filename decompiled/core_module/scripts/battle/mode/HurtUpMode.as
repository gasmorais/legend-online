package battle.mode
{
   import battle.events.BattleEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   [Event(name="change",type="flash.events.Event")]
   public class HurtUpMode extends EventDispatcher
   {
      
      private var _countDown:int;
      
      private var _damageImprove:int = 0;
      
      private var _timer:Timer;
      
      private var _startDate:Date;
      
      private var _total:int;
      
      private var _skillId:int = -1;
      
      public var battleType:int;
      
      public function HurtUpMode()
      {
         super();
         _timer = new Timer(10);
         _timer.addEventListener("timer",onTimer,false,0,true);
      }
      
      public function reset(param1:int, param2:int = 0) : void
      {
         _total = param1;
         _countDown = param1;
         _damageImprove += param2;
         _startDate = new Date();
         if(_timer.running)
         {
            _timer.reset();
            _timer.start();
         }
         else
         {
            _timer.start();
         }
         dispatchEvent(new Event("change"));
      }
      
      public function resetChildArena(param1:int, param2:int = 0, param3:int = 0) : void
      {
         _total = param1;
         _countDown = param1;
         _damageImprove += param3;
         _skillId = param2;
         _startDate = new Date();
         if(_timer.running)
         {
            _timer.reset();
            _timer.start();
         }
         else
         {
            _timer.start();
         }
         dispatchEvent(new BattleEvent("START_COUNT_DOWN",null));
         dispatchEvent(new Event("change"));
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:Date = new Date();
         var _loc4_:int = _loc2_.getTime() - _startDate.getTime();
         _loc4_ = Math.floor(_loc4_ / 1000);
         var _loc3_:int = _total - _loc4_;
         if(_countDown > _loc3_)
         {
            _countDown = _countDown - 1;
            dispatchEvent(new Event("change"));
         }
         if(_countDown < 1)
         {
            _timer.stop();
         }
      }
      
      public function getTimeLeft() : int
      {
         return _countDown;
      }
      
      public function getDamageImprove() : int
      {
         return _damageImprove;
      }
      
      public function dispose() : void
      {
         _timer.removeEventListener("timer",onTimer);
         _timer.stop();
      }
      
      public function get skillId() : int
      {
         return _skillId;
      }
      
      public function set skillId(param1:int) : void
      {
         _skillId = param1;
      }
   }
}

