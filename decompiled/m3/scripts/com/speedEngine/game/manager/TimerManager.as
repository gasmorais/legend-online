package com.speedEngine.game.manager
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.timer.Timer;
   import com.speedEngine.game.timer.TimerQueue;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   use namespace basegame_internal;
   
   public class TimerManager extends BaseManager
   {
      
      private static var _instance:TimerManager;
      
      private var _timerCount:int = 0;
      
      private var _timers:Dictionary;
      
      private var _timerQueue:Vector.<Timer>;
      
      private var _oneQueue:TimerQueue;
      
      private var _secendQueue:TimerQueue;
      
      public function TimerManager(param1:SingleHelper)
      {
         super();
      }
      
      public static function get instance() : TimerManager
      {
         if(_instance == null)
         {
            _instance = new TimerManager(new SingleHelper());
         }
         return _instance;
      }
      
      override public function init() : void
      {
         _timerQueue = new Vector.<Timer>();
         _oneQueue = new TimerQueue();
         _secendQueue = new TimerQueue();
         _timers = new Dictionary(true);
         super.init();
      }
      
      override public function update() : void
      {
         var _loc2_:* = 0;
         var _loc1_:int = getTimer();
         if(_oneQueue.length > 0 && _loc1_ < _oneQueue.minTime)
         {
            return;
         }
         executeQueueTimer(_oneQueue,_loc1_);
         if(_secendQueue.length > 0 && _loc1_ < _secendQueue.minTime)
         {
            return;
         }
         executeQueueTimer(_secendQueue,_loc1_);
         _loc2_ = 0;
         while(_loc2_ < _timerQueue.length)
         {
            if(_timerQueue[_loc2_].excuteTime > _loc1_)
            {
               _loc2_++;
            }
            else if(!_timerQueue[_loc2_].execute())
            {
               _timerQueue.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
      }
      
      private function executeQueueTimer(param1:TimerQueue, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc3_:Timer = null;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1.getTimerAt(_loc4_);
            if(_loc3_.excuteTime <= param2)
            {
               if(!_loc3_.execute())
               {
                  param1.removeTimer(_loc3_);
               }
               else
               {
                  _loc4_++;
               }
            }
            else
            {
               _loc4_++;
            }
         }
      }
      
      basegame_internal function addTimer(param1:Number, param2:int = -1, param3:Function = null, param4:Function = null, param5:Boolean = false, param6:Object = null) : int
      {
         _timerCount = _timerCount + 1;
         Director.instance.trace(4,"添加{invalid_utf8=228}{invalid_utf8=184}?个定时器id=" + _timerCount);
         var _loc7_:Timer = new Timer(_timerCount,param1,param2,param3,param4,param5,param6);
         if(param1 <= 1000)
         {
            _loc7_.type = 1;
            _oneQueue.push(_loc7_);
         }
         else if(param1 <= 2000)
         {
            _loc7_.type = 2;
            _secendQueue.push(_loc7_);
         }
         else
         {
            insertQueue(_loc7_);
         }
         _timers[_loc7_.timerId] = _loc7_;
         return _loc7_.timerId;
      }
      
      basegame_internal function startTimer(param1:int) : void
      {
         var _loc2_:Timer = _timers[param1];
         if(_loc2_)
         {
            _loc2_.start();
         }
      }
      
      basegame_internal function stopTimer(param1:int) : void
      {
         var _loc2_:Timer = _timers[param1];
         if(_loc2_)
         {
            _loc2_.stop();
         }
      }
      
      basegame_internal function resetTimer(param1:int) : void
      {
         var _loc2_:Timer = _timers[param1];
         if(_loc2_)
         {
            Director.instance.trace(4,"重置定时器id=" + _loc2_.timerId);
            _loc2_.reset();
         }
      }
      
      basegame_internal function getTimerCurrCount(param1:int) : int
      {
         var _loc2_:Timer = _timers[param1];
         if(_loc2_)
         {
            return _loc2_.currentCount;
         }
         return -1;
      }
      
      basegame_internal function removeTimer(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Timer = _timers[param1];
         if(_loc4_)
         {
            if(_loc4_.type == 1)
            {
               _loc3_ = _oneQueue;
            }
            else if(_loc4_.type == 2)
            {
               _loc3_ = _secendQueue;
            }
            else if(_loc4_.type == 0)
            {
               _loc3_ = _timerQueue;
            }
            _loc2_ = int(_loc3_.indexOf(_loc4_));
            if(_loc2_ != -1)
            {
               _loc3_.splice(_loc2_,1);
               Director.instance.trace(4,"删除定时器id=" + _loc4_.timerId);
               _timers[_loc4_.timerId] = null;
            }
         }
      }
      
      private function insertQueue(param1:Timer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(_timerQueue.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_timerQueue[_loc3_].excuteTime > param1.excuteTime)
            {
               _timerQueue.splice(_loc3_,0,param1);
               return;
            }
            _loc3_++;
         }
         _timerQueue.push(param1);
      }
   }
}

class SingleHelper
{
   
   public function SingleHelper()
   {
      super();
   }
}
