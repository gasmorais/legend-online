package yishi.timer
{
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.getTimer;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   [Event(name="timer",type="flash.events.TimerEvent")]
   [Event(name="timerComplete",type="flash.events.TimerEvent")]
   public class TimerTicker extends EventDispatcher implements IEnterFrame
   {
      
      private var _currentCount:int = 0;
      
      private var _delay:Number;
      
      private var _repeatCount:int = 0;
      
      private var _currentTime:int = 0;
      
      private var _running:Boolean;
      
      public function TimerTicker(param1:Number, param2:int = 0)
      {
         super();
         _delay = param1;
         _repeatCount = param2;
      }
      
      public function start() : void
      {
         if(!_running)
         {
            _currentTime = getTimer();
            _running = true;
            EnterFrameManager.instance.registeEnterFrame(this);
         }
      }
      
      public function stop() : void
      {
         _running = false;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function reset() : void
      {
         _currentCount == 0;
         if(_running)
         {
            stop();
         }
      }
      
      public function enterFrame() : void
      {
         var _loc1_:int = getTimer();
         var _loc2_:int = _loc1_ - _currentTime;
         var _loc3_:int = Math.floor(_loc2_ / _delay);
         if(_loc3_ > 0)
         {
            _currentCount = _currentCount + 1;
            dispatchEvent(new TimerEvent("timer"));
            if(_repeatCount > 0 && _currentCount >= _repeatCount)
            {
               stop();
               dispatchEvent(new TimerEvent("timerComplete"));
            }
         }
         _currentTime = _loc1_ - _loc2_ % _delay;
      }
   }
}

