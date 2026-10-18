package poker
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import yishi.utils.GraphicsUtils;
   
   public class PokerCDEffect extends Sprite
   {
      
      private var _mask:Sprite;
      
      private var _back:Sprite = ComponentFactory.Instance.creat("asset.poker.playerItemCDAsset");
      
      private var _time:Number;
      
      private var _callback:Function;
      
      private var _update:Function;
      
      public var currentAngle:int = 0;
      
      private var _w:int = 44;
      
      private var _cding:Boolean;
      
      private var _waitInv:uint;
      
      private var _templeteTime:int;
      
      private var _timerTween:TimerCDTween;
      
      private var _debugTime:int = 0;
      
      public function PokerCDEffect(param1:Number, param2:Function, param3:Function, param4:Number = 44)
      {
         _time = param1;
         _templeteTime = param1;
         _callback = param2;
         _update = param3;
         this.mouseChildren = this.mouseEnabled = false;
         addChild(_back);
         _back.width = _back.height = param4;
         _mask = new Sprite();
         _mask.rotation = -90;
         _mask.x = _mask.y = _back.width * 0.5 + _back.x;
         addChild(_mask);
         _back.mask = _mask;
         super();
      }
      
      public function start(param1:int = 0, param2:int = -1) : void
      {
         if(_cding)
         {
            return;
         }
         _cding = true;
         if(param2 == -1)
         {
            _time = _templeteTime;
         }
         else
         {
            _time = param2;
         }
         if(param1 > 0 && param1 < 5000)
         {
            _waitInv = setTimeout(startRotate,param1);
         }
         else
         {
            if(param1 + _time > 0)
            {
               _time += param1;
            }
            startRotate();
         }
         _update();
      }
      
      public function stop() : void
      {
         if(_timerTween && !_timerTween.isPause)
         {
            _timerTween.pause();
         }
      }
      
      public function resume() : void
      {
         if(_timerTween && _timerTween.isPause)
         {
            _timerTween.resume();
         }
      }
      
      private function startRotate() : void
      {
         _debugTime = getTimer();
         currentAngle = 360;
         GraphicsUtils.changeSectorAngle(_mask,0,0,50,0,360);
         _timerTween = new TimerCDTween(currentAngle,0,_time,updateMask,cdComplete);
         _timerTween.start();
      }
      
      private function cdComplete() : void
      {
         _cding = false;
         if(_timerTween)
         {
            _timerTween.dispose();
            _timerTween = null;
         }
         if(_callback is Function)
         {
            _callback();
         }
      }
      
      public function get isCding() : Boolean
      {
         return _cding;
      }
      
      private function updateMask() : void
      {
         currentAngle = _timerTween.getCurrent();
         if(_update is Function)
         {
            _update();
         }
         GraphicsUtils.changeSectorAngle(_mask,0,0,50,0,currentAngle);
      }
      
      public function getLeftTime() : int
      {
         return Math.ceil(currentAngle / 360 * _time * 0.001);
      }
      
      public function dispose() : void
      {
         clearTimeout(_waitInv);
         if(_timerTween)
         {
            _timerTween.dispose();
            _timerTween = null;
         }
         _callback = null;
         _update = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.getTimer;

class TimerCDTween
{
   
   private var _from:int;
   
   private var _to:int;
   
   private var _time:Number;
   
   private var _update:Function;
   
   private var _complete:Function;
   
   private var _timer:Timer;
   
   private var _step:Number;
   
   private var _count:Number;
   
   private var _current:int;
   
   private var _startDate:Date;
   
   private var _startTime:int;
   
   private var _gap:int;
   
   private var _pauseTime:Number = 0;
   
   private var _isPause:Boolean = false;
   
   public function TimerCDTween(param1:int, param2:int, param3:Number, param4:Function, param5:Function)
   {
      super();
      _from = param1;
      _to = param2;
      _time = param3;
      _update = param4;
      _complete = param5;
      _current = _count = _from;
      _gap = _to - _from;
   }
   
   public function start() : void
   {
      if(_timer)
      {
         return;
      }
      _step = (_from - _to) / (_time * 1000 / 25);
      _timer = new Timer(500);
      _timer.addEventListener("timer",onTimer);
      _timer.start();
      _startTime = getTimer();
   }
   
   private function onTimer(param1:TimerEvent) : void
   {
      var _loc3_:Number = Number(_step);
      var _loc4_:int = getTimer() - _startTime;
      var _loc2_:Number = _loc4_ / _time * _gap;
      _current = Math.floor(_loc2_ + _from);
      if(_current <= _to)
      {
         stopTimer();
         if(_complete is Function)
         {
            _complete();
         }
      }
      else if(_update is Function)
      {
         _update();
      }
   }
   
   public function stopTimer() : void
   {
      if(_timer)
      {
         _timer.stop();
         _timer.removeEventListener("timer",onTimer);
         _timer = null;
      }
   }
   
   public function pause() : void
   {
      if(_timer)
      {
         _timer.stop();
      }
      _pauseTime = getTimer();
      _isPause = true;
   }
   
   public function resume() : void
   {
      if(_timer)
      {
         _timer.start();
      }
      _startTime += getTimer() - _pauseTime;
      _isPause = false;
   }
   
   public function getCurrent() : int
   {
      return _current;
   }
   
   public function dispose() : void
   {
      stopTimer();
      _complete = null;
      _update = null;
   }
   
   public function get isPause() : Boolean
   {
      return _isPause;
   }
}
