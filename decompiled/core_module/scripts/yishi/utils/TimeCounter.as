package yishi.utils
{
   import flash.utils.getTimer;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class TimeCounter extends LogicObject implements IEnterFrame
   {
      
      private var _startTime:int;
      
      private var _deltaTime:int;
      
      private var _pauseTime:int;
      
      private var _offsetTime:int = 0;
      
      private var _isPause:Boolean = false;
      
      public function TimeCounter(param1:Boolean = true)
      {
         super();
         if(param1)
         {
            start();
         }
      }
      
      public function start() : void
      {
         resume();
         _startTime = getTimer();
         _offsetTime = 0;
         reFreshDeltaTime();
         addEvent();
      }
      
      public function stop() : void
      {
         _startTime = getTimer();
         _offsetTime = 0;
         reFreshDeltaTime();
         removeEvent();
      }
      
      public function pause() : void
      {
         if(_isPause == false)
         {
            _pauseTime = getTimer();
            removeEvent();
         }
         _isPause = true;
      }
      
      public function resume() : void
      {
         if(_isPause)
         {
            _offsetTime += getTimer() - _pauseTime;
            addEvent();
         }
         _isPause = false;
      }
      
      public function reset() : void
      {
         _startTime = getTimer();
         _offsetTime = 0;
         reFreshDeltaTime();
      }
      
      public function getTimeCount() : uint
      {
         return _deltaTime;
      }
      
      public function enterFrame() : void
      {
         if(!_isPause)
         {
            reFreshDeltaTime();
         }
      }
      
      private function reFreshDeltaTime() : void
      {
         _deltaTime = getTimer() - _offsetTime - _startTime;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
   }
}

