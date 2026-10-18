package map.internals.effect
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RedScreen extends Sprite
   {
      
      private var _redBm:ScaleBitmapImage;
      
      private var _timer:Timer;
      
      private var _isPlaying:Boolean;
      
      public function RedScreen()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _redBm = ComponentFactory.Instance.creatComponentByStylename("vehicel.redScreen");
         _redBm.visible = true;
         addChild(_redBm);
         mouseChildren = mouseEnabled = false;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         _redBm.width = param1;
         _redBm.height = param2;
      }
      
      public function play() : void
      {
         if(_isPlaying)
         {
            return;
         }
         _isPlaying = true;
         _redBm.visible = true;
         if(!_timer)
         {
            _timer = new Timer(500);
            _timer.addEventListener("timer",__onTimer);
         }
         _timer.start();
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         if(_redBm.alpha == 0.5)
         {
            _redBm.alpha = 1;
         }
         else
         {
            _redBm.alpha = 0.5;
         }
      }
      
      public function stop() : void
      {
         if(_timer)
         {
            _timer.stop();
         }
         _isPlaying = false;
         if(_redBm)
         {
            _redBm.visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
         if(_redBm)
         {
            ObjectUtils.disposeObject(_redBm);
            _redBm = null;
         }
      }
   }
}

