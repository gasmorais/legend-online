package com.speedEngine.game.timer
{
   public class TimerQueue
   {
      
      private var _minTime:int;
      
      private var _queue:Vector.<Timer>;
      
      public function TimerQueue()
      {
         super();
         _queue = new Vector.<Timer>();
         _minTime = 2147483647;
      }
      
      public function get length() : int
      {
         return _queue.length;
      }
      
      public function indexOf(param1:Timer) : int
      {
         return _queue.indexOf(param1);
      }
      
      public function splice(param1:int, param2:int) : void
      {
         _queue.splice(param1,param2);
      }
      
      public function push(param1:Timer) : void
      {
         if(param1.excuteTime < _minTime)
         {
            _minTime = param1.excuteTime;
         }
         _queue.push(param1);
      }
      
      public function removeTimer(param1:Timer) : void
      {
         var _loc2_:int = _queue.indexOf(param1);
         if(_loc2_ > 0)
         {
            removeAt(_loc2_);
         }
      }
      
      public function getTimerAt(param1:int) : Timer
      {
         if(param1 >= 0 && param1 < _queue.length)
         {
            return _queue[param1];
         }
         return null;
      }
      
      public function removeAt(param1:int) : void
      {
         if(_queue.length == 0 || param1 < 0 || param1 >= _queue.length)
         {
            return;
         }
         var _loc2_:int = _queue[param1].excuteTime;
         _queue.splice(param1,1);
         if(_loc2_ == _minTime)
         {
            _minTime = getMinTime();
         }
      }
      
      private function getMinTime() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 2147483647;
         _loc2_ = 0;
         while(_loc2_ < _queue.length)
         {
            if(_queue[_loc2_].excuteTime < _loc1_)
            {
               _loc1_ = _queue[_loc2_].excuteTime;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get minTime() : int
      {
         return _minTime;
      }
   }
}

