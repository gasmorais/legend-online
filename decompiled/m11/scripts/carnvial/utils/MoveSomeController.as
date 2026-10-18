package carnvial.utils
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quint;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class MoveSomeController extends Sprite implements IEnterFrame
   {
      
      private const LEFT:int = 1;
      
      private const RIGHT:int = 2;
      
      private const UP:int = 3;
      
      private const DOWN:int = 4;
      
      private var _itemList:Array;
      
      private var _itemList2:Array;
      
      private var _itemLen:int;
      
      private var _itemSpace:int;
      
      private var _firstSp:Sprite;
      
      private var _secondSp:Sprite;
      
      private var _tempSp:Sprite;
      
      private var _way:int;
      
      private var _lessRun:int;
      
      private var _initSpeed:int;
      
      private var _initBackSpeed:int;
      
      private var _maskRect:Shape;
      
      private var _callBack:Function;
      
      private var _callParams:Array;
      
      private var _targetIdx:int;
      
      private var _enterTimes:int;
      
      private var _currIdx:int;
      
      private var _runSpace:int;
      
      private var _startTime:int;
      
      private var _runingPassTime:int;
      
      private var _speed:int;
      
      public function MoveSomeController(param1:Array, param2:Array, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Function = null)
      {
         super();
         _itemList = param1;
         _itemLen = _itemList ? _itemList.length : 0;
         _itemList2 = param2;
         _itemSpace = param3;
         _way = param4;
         _lessRun = param5;
         _initSpeed = param6;
         _initBackSpeed = param7;
         _callBack = param8;
         initView();
      }
      
      public function addCallParams(param1:Array) : void
      {
         _callParams = param1;
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         _maskRect = new Shape();
         _firstSp = new Sprite();
         _secondSp = new Sprite();
         addChild(_maskRect);
         addChild(_firstSp);
         addChild(_secondSp);
         var _loc4_:int = 0;
         switch(_way - 1)
         {
            case 0:
               _secondSp.x = _itemSpace * _itemLen;
               _loc1_ = _itemSpace;
               break;
            case 1:
               _secondSp.x = -_itemSpace * _itemLen;
               _loc1_ = -_itemSpace;
               break;
            case 2:
               _secondSp.y = _itemSpace * _itemLen;
               _loc1_ = _itemSpace;
               break;
            case 3:
               _secondSp.y = -_itemSpace * _itemLen;
               _loc1_ = -_itemSpace;
         }
         _loc4_ = 0;
         while(_loc4_ < _itemLen)
         {
            _loc2_ = _itemList[_loc4_];
            _loc3_ = _itemList2[_loc4_];
            if(_way == 3 || _way == 4)
            {
               _loc2_.y = _loc1_ * _loc4_;
               _loc3_.y = _loc1_ * _loc4_;
            }
            else if(_way == 1 || _way == 2)
            {
               _loc2_.x = _loc1_ * _loc4_;
               _loc3_.x = _loc1_ * _loc4_;
            }
            _firstSp.addChild(_loc2_);
            _secondSp.addChild(_loc3_);
            _loc4_++;
         }
      }
      
      public function initMask(param1:int, param2:int, param3:int = 0, param4:int = 0) : void
      {
         _maskRect.graphics.beginFill(16711680);
         _maskRect.graphics.drawRect(0,0,param1,param2);
         _maskRect.graphics.endFill();
         _maskRect.x = param3;
         _maskRect.y = param4;
         this.mask = _maskRect;
      }
      
      public function enterFrame() : void
      {
         _runingPassTime = getTimer() - _startTime;
         if(_runingPassTime >= _lessRun && _currIdx == _targetIdx)
         {
            stop();
         }
         else
         {
            _runSpace += _speed;
            switch(_way - 1)
            {
               case 0:
                  _firstSp.x -= _speed;
                  if(_secondSp.x - _speed <= 0)
                  {
                     _secondSp.x -= _speed;
                     _firstSp.x = _secondSp.x + _itemSpace * _itemLen;
                     _tempSp = _firstSp;
                     _firstSp = _secondSp;
                     _secondSp = _tempSp;
                  }
                  else
                  {
                     _secondSp.x -= _speed;
                  }
                  break;
               case 1:
                  _firstSp.x += _speed;
                  if(_secondSp.x + _speed >= 0)
                  {
                     _secondSp.x += _speed;
                     _firstSp.x = _secondSp.x - _itemSpace * _itemLen;
                     _tempSp = _firstSp;
                     _firstSp = _secondSp;
                     _secondSp = _tempSp;
                     break;
                  }
                  _secondSp.x += _speed;
                  break;
               case 2:
                  _firstSp.y -= _speed;
                  if(_secondSp.y - _speed <= 0)
                  {
                     _secondSp.y -= _speed;
                     _firstSp.y = _secondSp.y + _itemSpace * _itemLen;
                     _tempSp = _firstSp;
                     _firstSp = _secondSp;
                     _secondSp = _tempSp;
                  }
                  else
                  {
                     _secondSp.y -= _speed;
                  }
                  break;
               case 3:
                  _firstSp.y += _speed;
                  if(_secondSp.y + _speed >= 0)
                  {
                     _secondSp.y += _speed;
                     _firstSp.y = _secondSp.y - _itemSpace * _itemLen;
                     _tempSp = _firstSp;
                     _firstSp = _secondSp;
                     _secondSp = _tempSp;
                  }
                  else
                  {
                     _secondSp.y += _speed;
                  }
            }
            if(_runSpace >= _itemSpace * _enterTimes)
            {
               _enterTimes = _enterTimes + 1;
               _currIdx = _currIdx + 1;
               if(_currIdx >= _itemLen)
               {
                  _currIdx = 0;
               }
            }
         }
      }
      
      public function start(param1:int) : void
      {
         _targetIdx = param1;
         _enterTimes = 1;
         _runSpace = 0;
         _speed = _initSpeed;
         _startTime = getTimer();
         EnterFrameManager.instance.registeEnterFrame(this);
         var _loc2_:Number = _lessRun / 1000;
         TweenMax.to(this,_loc2_,{
            "speed":_initBackSpeed,
            "ease":Quint.easeInOut
         });
      }
      
      private function stop(param1:Boolean = true) : void
      {
         if(param1)
         {
            initIdx(_currIdx);
            if(_callBack != null)
            {
               _callBack.apply(null,_callParams);
            }
         }
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         TweenMax.killTweensOf(this);
      }
      
      public function initIdx(param1:int) : void
      {
         _currIdx = param1;
         switch(_way - 1)
         {
            case 0:
               _firstSp.x = -_currIdx * _itemSpace;
               _secondSp.x = _firstSp.x + _itemSpace * _itemLen;
               break;
            case 1:
               _firstSp.x = _currIdx * _itemSpace;
               _secondSp.x = _firstSp.x - _itemSpace * _itemLen;
               break;
            case 2:
               _firstSp.y = -_currIdx * _itemSpace;
               _secondSp.y = _firstSp.y + _itemSpace * _itemLen;
               break;
            case 3:
               _firstSp.y = _currIdx * _itemSpace;
               _secondSp.y = _firstSp.y - _itemSpace * _itemLen;
         }
      }
      
      public function get speed() : int
      {
         return _speed;
      }
      
      public function set speed(param1:int) : void
      {
         _speed = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         stop(false);
         for each(_loc1_ in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         for each(_loc1_ in _itemList2)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList2 = null;
         ObjectUtils.disposeObject(_firstSp);
         _firstSp = null;
         ObjectUtils.disposeObject(_secondSp);
         _secondSp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _callBack = null;
         _callParams = null;
      }
   }
}

