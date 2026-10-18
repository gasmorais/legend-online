package dayguide.manager
{
   import com.pickgliss.ui.core.Disposeable;
   import dayguide.LuckDrawGoodsItem;
   import events.DayGuideEvent;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class DayGuideTurnControl extends EventDispatcher implements Disposeable
   {
      
      private var _round:int;
      
      private var _speed:Array = [20,80,150,1000];
      
      private var _goodsItemList:Vector.<LuckDrawGoodsItem>;
      
      private var _currentItem:LuckDrawGoodsItem;
      
      private var _currentItemIndex:int;
      
      private var _finalSelecteIndex:int;
      
      private var _timer:Timer;
      
      private var _isBlessing:Boolean;
      
      private var _isDefaultTurn:Boolean;
      
      private var _delayTime:int;
      
      private var _timeId:int;
      
      private var _quickenNum:int;
      
      private var _addSpeed:int;
      
      private var _deceleratNum:int;
      
      private var _deceSpeed:int;
      
      public function DayGuideTurnControl()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _timer = new Timer(_delayTime,1);
      }
      
      public function defaultTurn(param1:Vector.<LuckDrawGoodsItem>) : void
      {
         _isBlessing = false;
         _isDefaultTurn = true;
         model.delayTime = 0;
         _delayTime = _speed[3];
         _goodsItemList = param1;
         startTurn();
         startTimer();
      }
      
      public function turnPlate(param1:int, param2:int = 3, param3:int = 5) : void
      {
         _isBlessing = true;
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
         if(_currentItem)
         {
            _currentItem.hideMoveBg(1.8);
         }
         startTurn();
         startTimer();
      }
      
      public function startTurn() : void
      {
         _timer.reset();
         _timer.addEventListener("timer",__timeComplete);
         _timer.repeatCount = _isDefaultTurn ? 1.7976931348623157e+308 : repeatCount;
         if(_isDefaultTurn)
         {
            return;
         }
         _timer.addEventListener("timerComplete",__timeRepeatComplete);
      }
      
      public function pauseTurn() : void
      {
         _timer.reset();
         _timer.addEventListener("timer",__timeComplete);
         _timer.repeatCount = _isDefaultTurn ? 1.7976931348623157e+308 : repeatCount;
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
         if(_currentItem != null)
         {
            _currentItem.flicker();
         }
         _timeId = setTimeout(turnComplete,1250);
      }
      
      private function turnComplete() : void
      {
         clearTimeout(_timeId);
         _currentItem.stopFlicker();
         NotificationManager.instance.dispatchEvent(new DayGuideEvent("ON_DRAW_COMPLETE"));
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
      
      private function get model() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function nextNode() : void
      {
         if(_currentItem)
         {
            _currentItem.selected = false;
         }
         _currentItem = _goodsItemList[_currentItemIndex];
         if(_currentItem)
         {
            _currentItem.selected = true;
         }
         _currentItemIndex = _currentItemIndex + 1;
         if(_currentItemIndex > _goodsItemList.length - 1)
         {
            _currentItemIndex = 0;
         }
      }
      
      private function uninit() : void
      {
         clearInterval(_timeId);
         _timer.stop();
         _timer.removeEventListener("timer",__timeComplete);
         _timer.removeEventListener("timerComplete",__timeRepeatComplete);
         _timer = null;
         if(_currentItem)
         {
            _currentItem.selected = false;
         }
         _currentItem = null;
         _goodsItemList = null;
      }
      
      public function dispose() : void
      {
         uninit();
      }
   }
}

