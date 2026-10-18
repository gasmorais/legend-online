package lottery
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import managers.LotteryManager;
   import mvc.module.lottery.LotteryModel;
   
   public class LotteryTurnControl
   {
      
      private var _speed:Array = [20,50,100,1000];
      
      private var _goodsItemList:Vector.<LotteryBoxItem>;
      
      private var _delayTime:int;
      
      private var _timer:Timer;
      
      private var _currentItemIndex:int;
      
      private var _finalSelecteIndex:int;
      
      private var _currentItem:LotteryBoxItem;
      
      private var _round:int;
      
      private var _quickenNum:int;
      
      private var _addSpeed:int;
      
      private var _deceleratNum:int;
      
      private var _deceSpeed:int;
      
      private var _timeId:int;
      
      private var _isDefaultTurn:Boolean;
      
      public function LotteryTurnControl()
      {
         super();
         _timer = new Timer(_delayTime,1);
      }
      
      public function defaultTurn(param1:Vector.<LotteryBoxItem>) : void
      {
         _isDefaultTurn = true;
         model.delayTime = 0;
         _delayTime = _speed[3];
         _goodsItemList = param1;
         startTurn();
         startTimer();
      }
      
      public function turnPlate(param1:int, param2:int = 2, param3:int = 2) : void
      {
         _isDefaultTurn = false;
         _round = Math.ceil(Math.random() * (param3 - param2) + param2);
         _quickenNum = Math.ceil(Math.random() * (param3 - param2) + param2);
         _deceleratNum = Math.ceil(Math.random() * (param3 - param2) + param2);
         _delayTime = _speed[2];
         _addSpeed = (_speed[2] - _speed[0]) / _quickenNum;
         _deceSpeed = (_speed[2] - _speed[1]) / _deceleratNum;
         _delayTime -= _addSpeed;
         _finalSelecteIndex = param1 - _currentItemIndex;
         model.delayTime = _delayTime;
         if(_currentItem && !_currentItem.isDie)
         {
            _currentItem.hideMoveBg(1.8);
         }
         startTurn();
         startTimer();
      }
      
      public function startTurn() : void
      {
         _timer.removeEventListener("timerComplete",__timeRepeatComplete);
         _timer.removeEventListener("timer",__timeComplete);
         _timer.reset();
         _timer.addEventListener("timer",__timeComplete);
         _timer.repeatCount = _isDefaultTurn ? 2147483647 : repeatCount;
         if(_isDefaultTurn)
         {
            return;
         }
         _timer.addEventListener("timerComplete",__timeRepeatComplete);
      }
      
      private function startTimer() : void
      {
         _timer.delay = _delayTime;
         _timer.start();
      }
      
      private function get repeatCount() : int
      {
         return _goodsItemList.length * _round + _finalSelecteIndex;
      }
      
      private function __timeRepeatComplete(param1:TimerEvent) : void
      {
         _timer.stop();
         _timer.reset();
         _timer.removeEventListener("timerComplete",__timeRepeatComplete);
         _timer.removeEventListener("timer",__timeComplete);
         _timeId = setTimeout(flicker,500);
      }
      
      private function flicker() : void
      {
         if(!_currentItem.isDie)
         {
            _currentItem.flicker();
         }
      }
      
      private function __timeComplete(param1:TimerEvent) : void
      {
         _timer.stop();
         if(!_isDefaultTurn)
         {
            updateDelayTime();
         }
         nextNode();
         startTimer();
      }
      
      private function updateDelayTime() : void
      {
         if(_timer.currentCount % _goodsItemList.length == 0)
         {
            _round = _round - 1;
            if(_round == 1)
            {
               _delayTime = _speed[1];
               model.delayTime = _delayTime;
            }
         }
         if(_timer.currentCount <= _quickenNum)
         {
            if(_timer.currentCount < _quickenNum)
            {
               _delayTime -= _addSpeed;
            }
            else
            {
               _delayTime = _speed[0];
            }
            model.delayTime = _delayTime;
         }
         if(_timer.currentCount >= _timer.repeatCount - _deceleratNum - 1)
         {
            if(_timer.currentCount == _timer.repeatCount - 1)
            {
               _delayTime = _speed[2];
            }
            else
            {
               _delayTime += _deceSpeed;
               model.delayTime = _delayTime;
            }
         }
      }
      
      private function nextNode() : void
      {
         if(_currentItem && !_currentItem.isDie)
         {
            _currentItem.selected = false;
         }
         _currentItem = _goodsItemList[_currentItemIndex];
         _currentItem.selected = true;
         _currentItemIndex = _currentItemIndex + 1;
         if(_currentItemIndex > _goodsItemList.length - 1)
         {
            _currentItemIndex = 0;
         }
      }
      
      private function get model() : LotteryModel
      {
         return LotteryManager.Instance.model;
      }
      
      private function uninit() : void
      {
         clearInterval(_timeId);
         if(_currentItem)
         {
            _currentItem.dispose();
         }
         _currentItem = null;
         if(_timer)
         {
            _timer.stop();
         }
         if(_timer)
         {
            _timer.removeEventListener("timer",__timeComplete);
         }
         if(_timer)
         {
            _timer.removeEventListener("timerComplete",__timeRepeatComplete);
         }
         _timer = null;
         _speed = null;
         _goodsItemList = null;
      }
      
      public function dispose() : void
      {
         uninit();
      }
   }
}

