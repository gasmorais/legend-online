package battle.effect
{
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TransSceneEffect2 implements ITransSceneEffect
   {
      
      private var _complete:Function;
      
      private var _timer:Timer;
      
      protected var _cells:Array;
      
      protected var _cellSize:int;
      
      protected var _row:int;
      
      protected var _col:int;
      
      protected var _completeCount:int;
      
      private var _timeIndex:int;
      
      private var _tweenType:int;
      
      public function TransSceneEffect2(param1:Array, param2:int, param3:int, param4:int)
      {
         super();
         _cells = param1;
         _row = param2;
         _col = param3;
         _cellSize = param4;
      }
      
      public function start(param1:Function) : void
      {
         _complete = param1;
         _tweenType = Math.floor(Math.random() * 3) + 1;
         startTimer();
      }
      
      private function startTimer() : void
      {
         _timer = new Timer(20);
         _timer.addEventListener("timer",onTimer);
         _timer.start();
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc3_:Array = getCellsByIndex(_timeIndex);
         if(_loc3_ && _loc3_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ = _loc3_[_loc4_];
               cellEffect(_loc2_);
               _loc4_++;
            }
         }
         else
         {
            removeTimer();
         }
         _timeIndex = _timeIndex + 1;
      }
      
      protected function getCellsByIndex(param1:int) : Array
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(_timeIndex >= _col)
         {
            return null;
         }
         _loc4_ = 0;
         while(_loc4_ < _row)
         {
            _loc3_ = _cells[_loc4_ * _col + param1];
            _loc2_.push(_loc3_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function removeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTimer);
            _timer = null;
         }
      }
      
      protected function cellEffect(param1:DisplayObject) : void
      {
         switch(_tweenType - 1)
         {
            case 0:
               CellEffectUtils.zoomOut(param1,onTweenComplete);
               break;
            case 1:
               CellEffectUtils.fadeOut(param1,onTweenComplete);
               break;
            case 2:
               CellEffectUtils.rotate(param1,onTweenComplete);
               break;
            default:
               CellEffectUtils.fadeOut(param1,onTweenComplete);
         }
      }
      
      protected function onTweenComplete() : void
      {
         _completeCount = _completeCount + 1;
         if(_completeCount >= _cells.length)
         {
            if(_complete != null)
            {
               _complete();
               _complete = null;
            }
         }
      }
   }
}

