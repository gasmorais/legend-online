package carnvial.utils
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quint;
   import flash.utils.getTimer;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class LightTurnController implements IEnterFrame
   {
      
      private var _itemList:Array;
      
      private var _itemLen:int;
      
      private var _initSpace:int;
      
      private var _stopTargetIdx:int;
      
      private var _callBack:Function;
      
      private var _currIdx:int;
      
      private var _lastIdx:int;
      
      private var _stopLightTimes:int;
      
      private var _stopRun:int;
      
      private var _lastTimer:int = 0;
      
      private var _startTime:int;
      
      private var _runingPassTime:int;
      
      private var _spaceTime:Number;
      
      private var _runTime:int;
      
      private var _needRun:int;
      
      private var _avSpeed:int;
      
      private var _timeAdd:Number;
      
      private var _ft:Number = 0;
      
      private var _tweenSpeed:int = 0;
      
      private var _tweenId:int;
      
      private var _callParms:Array;
      
      private var _initIdx:int;
      
      public function LightTurnController(param1:Array, param2:int, param3:int, param4:int, param5:Function, param6:int = 0)
      {
         super();
         _itemList = param1;
         _itemLen = _itemList.length;
         _initSpace = param2;
         _needRun = param3;
         _avSpeed = param4;
         _callBack = param5;
         _stopLightTimes = param6;
      }
      
      public function enterFrame() : void
      {
         _runingPassTime = getTimer() - _startTime;
         if(_runingPassTime >= _needRun && _currIdx == _stopTargetIdx)
         {
            if(_stopLightTimes == 0)
            {
               stop();
            }
            else if(getTimer() - _lastTimer > 30)
            {
               _lastTimer = getTimer();
               stopLgiht();
            }
         }
         else
         {
            _spaceTime = _initSpace + _tweenSpeed;
            if(getTimer() - _lastTimer > _spaceTime)
            {
               _runTime = _runTime + 1;
               _currIdx = _currIdx + 1;
               if(_currIdx >= _itemLen)
               {
                  _currIdx = 0;
               }
               _lastTimer = getTimer();
               trunLight();
            }
         }
      }
      
      private function trunLight() : void
      {
         _itemList[_lastIdx].isLight = false;
         _lastIdx = _currIdx;
         _itemList[_currIdx].isLight = true;
      }
      
      private function stopLgiht() : void
      {
         var _loc1_:Boolean = Boolean(_itemList[_currIdx].isLight);
         _itemList[_currIdx].isLight = !_loc1_;
         _stopRun = _stopRun + 1;
         if(_stopRun >= _stopLightTimes)
         {
            _itemList[_currIdx].isLight = true;
            stop();
         }
      }
      
      public function start(param1:int, param2:Array = null) : void
      {
         if(param1 > _itemList.length - 1)
         {
            return;
         }
         _stopTargetIdx = param1;
         _lastTimer = getTimer();
         _startTime = _lastTimer;
         _tweenSpeed = 0;
         _callParms = param2;
         var _loc3_:Number = _needRun / 1000;
         TweenMax.to(this,_loc3_,{
            "tweenSpeed":_avSpeed,
            "ease":Quint.easeInOut
         });
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function stop(param1:Boolean = true) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         TweenMax.killTweensOf(this);
         if(param1 && _callBack != null)
         {
            _callBack.apply(this,_callParms);
         }
         _stopRun = 0;
         _runTime = 0;
         _ft = 0;
      }
      
      public function initIdx(param1:int) : void
      {
         _initIdx = param1;
         _currIdx = param1;
         _lastIdx = param1;
         if(_itemList[_currIdx])
         {
            _itemList[_currIdx].isLight = true;
         }
      }
      
      public function clearLight(param1:Boolean = false) : void
      {
         _itemList[_currIdx].isLight = false;
         if(param1)
         {
            _currIdx = _initIdx;
            _lastIdx = _initIdx;
         }
      }
      
      public function dispose() : void
      {
         stop(false);
         _itemList = null;
         _callBack = null;
         _callParms = null;
      }
      
      public function get tweenSpeed() : int
      {
         return _tweenSpeed;
      }
      
      public function set tweenSpeed(param1:int) : void
      {
         _tweenSpeed = param1;
      }
   }
}

