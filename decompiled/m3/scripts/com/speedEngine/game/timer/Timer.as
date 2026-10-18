package com.speedEngine.game.timer
{
   import flash.utils.getTimer;
   
   public class Timer
   {
      
      private var _type:uint;
      
      private var _timerId:int;
      
      private var _isStop:Boolean;
      
      private var _excuteTime:int;
      
      private var _delay:Number;
      
      private var _currentCount:int;
      
      private var _repeatCount:int;
      
      private var _timer:Function;
      
      private var _timerComplete:Function;
      
      private var _isOnce:Boolean = false;
      
      private var _callArgs:Array = null;
      
      public function Timer(param1:int, param2:Number, param3:int = -1, param4:Function = null, param5:Function = null, param6:Boolean = false, param7:Object = null)
      {
         super();
         _type = 0;
         _timerId = param1;
         _delay = param2;
         _currentCount = 1;
         _repeatCount = param3;
         _timerComplete = param4;
         _timer = param5;
         _excuteTime = getTimer() + param2;
         _isStop = false;
         _isOnce = param6;
         _callArgs = [_timerId];
         if(param7 != null)
         {
            _callArgs.push(param7);
         }
      }
      
      public function execute() : Boolean
      {
         if(_isStop)
         {
            return true;
         }
         if(_repeatCount == -1 || _currentCount < _repeatCount)
         {
            if(_timer != null)
            {
               _timer.apply(null,_callArgs);
            }
            _currentCount = _currentCount + 1;
            _excuteTime += _delay;
            return true;
         }
         if(_timer != null)
         {
            _timer.apply(null,_callArgs);
         }
         if(_timerComplete != null)
         {
            _timerComplete.apply(null,_callArgs);
         }
         _isStop = true;
         return !_isOnce;
      }
      
      public function start() : void
      {
         _isStop = false;
      }
      
      public function stop() : void
      {
         _isStop = true;
      }
      
      public function reset() : void
      {
         start();
         _currentCount = 1;
         _excuteTime = getTimer() + delay;
      }
      
      public function get timerId() : int
      {
         return _timerId;
      }
      
      public function get delay() : Number
      {
         return _delay;
      }
      
      public function get repeatCount() : int
      {
         return _repeatCount;
      }
      
      public function get timerComplete() : Function
      {
         return _timerComplete;
      }
      
      public function get currentCount() : int
      {
         return _currentCount;
      }
      
      public function get excuteTime() : int
      {
         return _excuteTime;
      }
      
      public function get type() : uint
      {
         return _type;
      }
      
      public function set type(param1:uint) : void
      {
         _type = param1;
      }
      
      public function get isStop() : Boolean
      {
         return _isStop;
      }
      
      public function dispose() : void
      {
         _timer = null;
         _timerComplete = null;
      }
   }
}

