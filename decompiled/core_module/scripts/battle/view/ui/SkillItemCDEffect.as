package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.utils.GraphicsUtils;
   
   public class SkillItemCDEffect extends Sprite
   {
      
      private var _mask:Sprite;
      
      private var _back:Sprite = ComponentFactory.Instance.creat("asset.battle.SkillItemCDAsset");
      
      private var _time:Number;
      
      private var _callback:Function;
      
      private var _update:Function;
      
      public var currentAngle:int = 0;
      
      private var _w:int = 44;
      
      private var _waitInv:uint;
      
      private var _templeteTime:int;
      
      private var _timerTween:TimerCDTween;
      
      public var isCding:Boolean;
      
      public function SkillItemCDEffect(param1:Number, param2:Function, param3:Function, param4:Number = 44)
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
         isCding = true;
         if(param2 == -1)
         {
            _time = _templeteTime;
         }
         else
         {
            _time = param2;
         }
         if(param1 > 0)
         {
            _waitInv = setTimeout(startRotate,param1);
         }
         else
         {
            startRotate();
         }
      }
      
      private function startRotate() : void
      {
         currentAngle = 360;
         GraphicsUtils.changeSectorAngle(_mask,0,0,50,0,360);
         if(_timerTween)
         {
            _timerTween.start(currentAngle,0,_time * 0.001);
         }
         else
         {
            _timerTween = new TimerCDTween(updateMask,cdComplete);
            _timerTween.start(currentAngle,0,_time * 0.001);
         }
      }
      
      private function cdComplete() : void
      {
         isCding = false;
         if(_timerTween)
         {
            _timerTween.dispose();
            _timerTween = null;
         }
         _callback();
      }
      
      private function updateMask() : void
      {
         currentAngle = _timerTween.getCurrent();
         _update();
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
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
      }
   }
}

import battle.BattleManager;
import com.pickgliss.toplevel.StageReferance;
import flash.events.TimerEvent;
import flash.utils.Timer;

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
   
   public function TimerCDTween(param1:Function, param2:Function)
   {
      super();
      _update = param1;
      _complete = param2;
   }
   
   public function start(param1:int, param2:int, param3:Number) : void
   {
      _from = param1;
      _to = param2;
      _time = param3;
      _current = _count = _from;
      _step = (_from - _to) / (_time * 1000 / 30);
      if(!_timer)
      {
         _timer = new Timer(30);
         _timer.addEventListener("timer",onTimer);
         _timer.start();
      }
   }
   
   private function onTimer(param1:TimerEvent) : void
   {
      var _loc4_:int = 0;
      var _loc2_:int = 0;
      var _loc3_:Number = Number(_step);
      if(BattleManager.getInstance().quickenControl)
      {
         _loc4_ = BattleManager.getInstance().quickenControl.getFps();
      }
      else
      {
         _loc4_ = _loc2_;
      }
      _loc2_ = StageReferance.stage.frameRate;
      if(_loc4_ > _loc2_ + 15)
      {
         _loc4_ = _loc2_ + 15;
      }
      if(_loc4_ < _loc2_ - 15)
      {
         _loc4_ = _loc2_ - 15;
      }
      _loc3_ /= _loc4_ / _loc2_;
      _count -= _loc3_;
      if(_count <= _to)
      {
         stopTimer();
         _complete();
      }
      else if(Math.floor(_count) < _current)
      {
         _current = Math.floor(_count);
         _update();
      }
   }
   
   private function stopTimer() : void
   {
      if(_timer)
      {
         _timer.stop();
         _timer.removeEventListener("timer",onTimer);
         _timer = null;
      }
   }
   
   public function getCurrent() : int
   {
      return _current;
   }
   
   public function dispose() : void
   {
      stopTimer();
   }
}
