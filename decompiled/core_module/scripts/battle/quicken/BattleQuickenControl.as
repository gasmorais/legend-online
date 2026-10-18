package battle.quicken
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class BattleQuickenControl implements IEnterFrame
   {
      
      private var _model:BattleQuickenModel;
      
      private var _effects:Dictionary;
      
      private var _fps:int;
      
      private var _frameCount:int;
      
      private const CHECK_NUM:int = 10;
      
      private var _startTime:int;
      
      private var _sleep:Boolean;
      
      private var _sleepTimer:Timer;
      
      public function BattleQuickenControl(param1:BattleQuickenModel)
      {
         super();
         _model = param1;
         _effects = new Dictionary(true);
         EnterFrameManager.instance.registeEnterFrame(this);
         startCheck();
      }
      
      private function startCheck() : void
      {
         _frameCount = 0;
         _startTime = getTimer();
         _sleep = false;
      }
      
      public function enterFrame() : void
      {
         if(!_sleep)
         {
            _frameCount = _frameCount + 1;
            if(_frameCount == 10)
            {
               _frameCount = 0;
               _fps = 1000 * 10 / (getTimer() - _startTime);
               rolveSpeed();
               sleep();
            }
         }
      }
      
      private function rolveSpeed() : void
      {
         var _loc1_:int = 5 - Math.ceil(_fps / 5);
         if(_loc1_ > 5)
         {
            _loc1_ = 5;
         }
         else if(_loc1_ < 1)
         {
            _loc1_ = 1;
         }
         setSpeed(_loc1_);
      }
      
      private function sleep() : void
      {
         removeSleepTimer();
         _sleep = true;
         _sleepTimer = new Timer(500,1);
         _sleepTimer.addEventListener("timerComplete",onTimerComplete);
         _sleepTimer.start();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         _startTime = getTimer();
         removeSleepTimer();
         _sleep = false;
      }
      
      private function removeSleepTimer() : void
      {
         if(_sleepTimer)
         {
            _sleepTimer.stop();
            _sleepTimer.removeEventListener("timerComplete",onTimerComplete);
            _sleepTimer = null;
         }
      }
      
      public function setSpeed(param1:int) : void
      {
         if(_model.speed != param1)
         {
            _model.speed = param1;
            for each(var _loc2_:IQuickenEffect in _effects)
            {
               _loc2_.setSpeed(_model.speed);
            }
         }
      }
      
      public function getFps() : int
      {
         return _fps;
      }
      
      public function register(param1:IQuickenEffect) : void
      {
         _effects[param1] = param1;
      }
      
      public function unregister(param1:IQuickenEffect) : void
      {
         delete _effects[param1];
      }
      
      public function dispose() : void
      {
         removeSleepTimer();
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         ObjectUtils.clearDictionary(_effects);
         _model = null;
         _effects = null;
      }
   }
}

