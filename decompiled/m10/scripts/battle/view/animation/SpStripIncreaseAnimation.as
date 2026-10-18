package battle.view.animation
{
   import battle.BattleManager;
   import battle.view.ui.StripUIView;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SpStripIncreaseAnimation
   {
      
      private static const X_OFFSET_1:int = -16;
      
      private static const X_OFFSET_2:int = -58;
      
      private static const Y_OFFSET_1:int = -11;
      
      private static const Y_OFFSET_2:int = -8;
      
      private static const PERSISTENT:int = 300;
      
      private static const GAP:int = 10;
      
      private var _container:Sprite;
      
      private var _strip:StripUIView;
      
      private var _timer:Timer;
      
      private var _startX_1:Number;
      
      private var _startX_2:Number;
      
      private var _oldSp:int;
      
      private var _spStep:int;
      
      private var _count:int;
      
      private var _current:int = 0;
      
      private var _interval:int;
      
      private var _isRunning:Boolean;
      
      private var _destValue:int;
      
      public function SpStripIncreaseAnimation(param1:Sprite, param2:StripUIView)
      {
         super();
         _container = param1;
         _strip = param2;
      }
      
      public function start(param1:int, param2:int) : void
      {
         _oldSp = param1;
         _destValue = param1 + param2;
         _isRunning = true;
         _startX_1 = _strip.x + _strip.maskWidth + -16;
         _startX_2 = _strip.x + _strip.maskWidth + -58;
         _count = Math.ceil(param2 / _strip.maxValue * 275 / 10);
         _interval = 300 / _count;
         _spStep = param2 / _count;
         startTimer();
      }
      
      public function getDestCurrent() : int
      {
         return _destValue;
      }
      
      private function startTimer() : void
      {
         _timer = new Timer(_interval);
         _timer.addEventListener("timer",onTimer);
         _timer.start();
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         if(_current < _count)
         {
            addOnce();
         }
         else
         {
            dispose();
         }
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
      
      private function addOnce() : void
      {
         var _loc1_:MovieClip = createAsset1();
         var _loc2_:MovieClip = createAsset2();
         _loc1_.x = _startX_1 + _current * 10;
         _loc1_.y = _strip.y + -11;
         _loc2_.x = _startX_2 + _current * 10;
         _loc2_.y = _strip.y + -8;
         _container.addChild(_loc2_);
         _container.addChild(_loc1_);
         var _loc3_:int = _oldSp + _spStep * _current;
         if(_loc3_ > 100)
         {
            _loc3_ = 100;
         }
         _strip.currentValue = _loc3_;
         _current = _current + 1;
         if(_current == _count)
         {
            dispose();
         }
      }
      
      private function createAsset1() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.battle.PowerIncrease1");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         return _loc1_;
      }
      
      private function createAsset2() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.battle.PowerIncrease2");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         return _loc1_;
      }
      
      public function isRunning() : Boolean
      {
         return _isRunning;
      }
      
      public function dispose() : void
      {
         if(_strip && BattleManager.getInstance().battleModel)
         {
            _strip.currentValue = BattleManager.getInstance().battleModel.selfHero.sp;
         }
         removeTimer();
         _isRunning = false;
         _container = null;
         _strip = null;
      }
   }
}

