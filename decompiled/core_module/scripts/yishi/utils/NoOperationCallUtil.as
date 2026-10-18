package yishi.utils
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class NoOperationCallUtil
   {
      
      private var _time:int;
      
      private var _timer:Timer;
      
      private var _noOperationCall:Function;
      
      private var _activeCall:Function;
      
      private var _isNeedActive:Boolean = false;
      
      public function NoOperationCallUtil(param1:int, param2:Function, param3:Function)
      {
         super();
         _time = param1;
         _noOperationCall = param2;
         _activeCall = param3;
         _timer = new Timer(_time,1);
         _timer.start();
         addEvent();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("mouseMove",__mouseMoveHandler);
         StageReferance.stage.addEventListener("keyDown",__keyDownHandler);
         _timer.addEventListener("timerComplete",__timeUpHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("mouseMove",__mouseMoveHandler);
         StageReferance.stage.removeEventListener("keyDown",__keyDownHandler);
         _timer.removeEventListener("timerComplete",__timeUpHandler);
      }
      
      private function __timeUpHandler(param1:TimerEvent) : void
      {
         if(_noOperationCall != null)
         {
            _noOperationCall();
            _isNeedActive = true;
         }
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         reset();
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         reset();
      }
      
      private function reset() : void
      {
         if(_isNeedActive && _activeCall != null)
         {
            _activeCall();
            _isNeedActive = false;
         }
         resetTimeOut();
      }
      
      private function resetTimeOut() : void
      {
         _timer.reset();
         _timer.start();
      }
      
      public function dispose() : void
      {
         removeEvent();
         _timer.stop();
         _timer = null;
         _noOperationCall = null;
         _activeCall = null;
      }
   }
}

