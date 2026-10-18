package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RedScreenEffect extends Sprite
   {
      
      private var _redBm:DisplayObject;
      
      private var _timer:Timer;
      
      public function RedScreenEffect()
      {
         this.mouseChildren = this.mouseEnabled = false;
         super();
         _redBm = ComponentFactory.Instance.creat("asset.battle.RedScreenBMD");
         _redBm.alpha = 0.5;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         _redBm.width = param1;
         _redBm.height = param2;
      }
      
      public function play() : void
      {
         addChild(_redBm);
         removeTimer();
         _timer = new Timer(200,1);
         _timer.addEventListener("timerComplete",onTimerComplete);
         _timer.start();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         removeTimer();
         if(_redBm && _redBm.parent)
         {
            _redBm.parent.removeChild(_redBm);
         }
      }
      
      private function removeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timerComplete",onTimerComplete);
            _timer = null;
         }
      }
      
      public function stop() : void
      {
         onTimerComplete(null);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_redBm);
         stop();
      }
   }
}

