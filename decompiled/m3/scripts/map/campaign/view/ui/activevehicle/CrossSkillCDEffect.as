package map.campaign.view.ui.activevehicle
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.utils.GraphicsUtils;
   
   public class CrossSkillCDEffect extends Sprite implements Disposeable
   {
      
      private var _mask:Sprite;
      
      private var _back:Sprite = ComponentFactory.Instance.creat("asset.vehicle.SkillItemCDAsset");
      
      private var _time:Number;
      
      private var _callback:Function;
      
      private var _update:Function;
      
      public var currentAngle:int = 0;
      
      private var _w:int = 44;
      
      private var _cding:Boolean;
      
      private var _waitInv:uint;
      
      private var _templeteTime:int;
      
      private var _currentTime:int = 0;
      
      private var _timer:Timer;
      
      public function CrossSkillCDEffect(param1:Number, param2:Function, param3:Function)
      {
         _time = param1;
         _templeteTime = param1;
         _currentTime = _templeteTime * 0.001;
         _callback = param2;
         _update = param3;
         this.mouseChildren = this.mouseEnabled = false;
         addChild(_back);
         _mask = new Sprite();
         _mask.rotation = -90;
         _mask.x = _mask.y = _w * 0.5;
         addChild(_mask);
         _back.mask = _mask;
         _timer = new Timer(1000,_currentTime);
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
         if(param1 > 0)
         {
            if(_waitInv > 0)
            {
               clearTimeout(_waitInv);
            }
            _waitInv = 0;
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
         TweenLite.to(this,_time * 0.001,{
            "currentAngle":0,
            "onUpdate":updateMask,
            "onComplete":cdComplete,
            "ease":Linear.easeNone
         });
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(_currentTime > 0)
         {
            _currentTime = _currentTime - 1;
         }
      }
      
      private function cdComplete() : void
      {
         _timer.removeEventListener("timer",__timerHandler);
         _timer.reset();
         _currentTime = _templeteTime * 0.001;
         _cding = false;
         _callback();
      }
      
      public function get isCding() : Boolean
      {
         return _cding;
      }
      
      private function updateMask() : void
      {
         _update();
         GraphicsUtils.changeSectorAngle(_mask,0,0,50,0,currentAngle);
      }
      
      public function getLeftTime() : int
      {
         return _currentTime;
      }
      
      public function dispose() : void
      {
         if(_waitInv > 0)
         {
            clearTimeout(_waitInv);
         }
         _waitInv = 0;
         ObjectUtils.disposeAllChildren(_mask);
         _mask = null;
         ObjectUtils.disposeAllChildren(_back);
         _back = null;
         TweenLite.killTweensOf(this);
         ObjectUtils.disposeAllChildren(this);
         if(_timer)
         {
            _timer.removeEventListener("timer",__timerHandler);
            _timer.stop();
         }
         _timer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

