package com.pickgliss.ui.controls
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   [Event(name="change",type="flash.events.Event")]
   public class BaseButton extends Component
   {
      
      public static const P_backStyle:String = "backStyle";
      
      public static const P_backgoundRotation:String = "backgoundRotation";
      
      public static const P_pressEnable:String = "pressEnable";
      
      public static const P_transparentEnable:String = "transparentEnable";
      
      public static const P_autoSizeAble:String = "autoSizeAble";
      
      public static const P_lockStyle:String = "lockStyle";
      
      private var _offsetCount:int;
      
      protected var _PNGHitArea:Sprite;
      
      protected var _back:DisplayObject;
      
      protected var _backStyle:String;
      
      protected var _backgoundRotation:int;
      
      protected var _currentFrameIndex:int = 1;
      
      protected var _enable:Boolean = true;
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      protected var _pressEnable:Boolean;
      
      private var _displacementEnable:Boolean = true;
      
      private var _pressStartTimer:Timer;
      
      private var _pressStepTimer:Timer;
      
      private var _transparentEnable:Boolean;
      
      protected var _autoSizeAble:Boolean = true;
      
      protected var _enableMouseAble:Boolean = false;
      
      protected var _lockStyle:String;
      
      protected var _lockBit:DisplayObject;
      
      protected var _lock:Boolean;
      
      private var _clickHandle:Function;
      
      private var _supportTipsWhenGray:Boolean = false;
      
      private var _preClickTime:int;
      
      private var _delayClick:Boolean = false;
      
      private var _delayClickTime:int = 200;
      
      public var autoHideTip:Boolean = true;
      
      public function BaseButton()
      {
         super();
         init();
         addEvent();
      }
      
      public function get frameFilter() : Array
      {
         return _frameFilter;
      }
      
      public function set frameFilter(param1:Array) : void
      {
         _frameFilter = param1;
      }
      
      public function get enableMouseAble() : Boolean
      {
         return _enableMouseAble;
      }
      
      public function set enableMouseAble(param1:Boolean) : void
      {
         _enableMouseAble = param1;
      }
      
      public function set autoSizeAble(param1:Boolean) : void
      {
         if(_autoSizeAble == param1)
         {
            return;
         }
         _autoSizeAble = param1;
         onPropertiesChanged("autoSizeAble");
      }
      
      public function get autoSizeAble() : Boolean
      {
         return _autoSizeAble;
      }
      
      public function get backStyle() : String
      {
         return _backStyle;
      }
      
      public function set backStyle(param1:String) : void
      {
         if(param1 == _backStyle)
         {
            return;
         }
         _backStyle = param1;
         backgound = ComponentFactory.Instance.creat(_backStyle);
         onPropertiesChanged("backStyle");
      }
      
      public function get backgound() : DisplayObject
      {
         return _back;
      }
      
      public function set backgound(param1:DisplayObject) : void
      {
         if(_back == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_back);
         _back = param1;
         onPropertiesChanged("backStyle");
      }
      
      public function set backgoundRotation(param1:int) : void
      {
         if(_backgoundRotation == param1)
         {
            return;
         }
         _backgoundRotation = param1;
         onPropertiesChanged("backgoundRotation");
      }
      
      public function get displacement() : Boolean
      {
         return _displacementEnable;
      }
      
      public function set displacement(param1:Boolean) : void
      {
         _displacementEnable = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_clickHandle != null)
         {
            removeEventListener("click",_clickHandle);
            _clickHandle = null;
         }
         if(_back)
         {
            _back.filters = null;
         }
         ObjectUtils.disposeObject(_back);
         ObjectUtils.disposeObject(_PNGHitArea);
         ObjectUtils.disposeObject(_lockBit);
         _lockBit = null;
         _PNGHitArea = null;
         _back = null;
         _frameFilter = null;
         _pressStepTimer = null;
         _pressStartTimer = null;
         super.dispose();
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
         if(_supportTipsWhenGray)
         {
            mouseEnabled = true;
            if(!_enable)
            {
               addEventListener("click",__onMouseClick);
               removeEventListener("mouseDown",__onMousedown);
               if(_clickHandle != null)
               {
                  addEventListener("click",_clickHandle);
               }
            }
            else
            {
               removeEventListener("click",__onMouseClick);
               addEventListener("mouseDown",__onMousedown);
               if(_clickHandle != null)
               {
                  removeEventListener("click",_clickHandle);
               }
            }
         }
         else
         {
            mouseEnabled = _enable;
            if(_enable)
            {
               addEventListener("mouseDown",__onMousedown);
            }
            else
            {
               removeEventListener("mouseDown",__onMousedown);
            }
         }
         if(_enable)
         {
            buttonMode = true;
            setFrame(1);
         }
         else
         {
            buttonMode = false;
            setFrame(4);
         }
         if(_enableMouseAble)
         {
            mouseEnabled = true;
         }
         updatePosition();
      }
      
      public function set supportTipsWhenGray(param1:Boolean) : void
      {
         _supportTipsWhenGray = param1;
      }
      
      public function get supportTipsWhenGray() : Boolean
      {
         return _supportTipsWhenGray;
      }
      
      public function setClickHandle(param1:Function) : void
      {
         _clickHandle = param1;
         if(_enable)
         {
            addEventListener("click",_clickHandle);
         }
      }
      
      public function removeClickHandle(param1:Function) : void
      {
         removeEventListener("click",_clickHandle);
         _clickHandle = null;
      }
      
      private function updatePosition() : void
      {
         x += ComponentSetting.DISPLACEMENT_OFFSET * -_offsetCount;
         y += ComponentSetting.DISPLACEMENT_OFFSET * -_offsetCount;
         _offsetCount = 0;
      }
      
      public function set filterString(param1:String) : void
      {
         if(_filterString == param1)
         {
            return;
         }
         _filterString = param1;
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(_filterString);
      }
      
      public function get filterString() : String
      {
         return _filterString;
      }
      
      public function set pressEnable(param1:Boolean) : void
      {
         if(_pressEnable == param1)
         {
            return;
         }
         _pressEnable = param1;
         onPropertiesChanged("pressEnable");
      }
      
      public function get pressEnable() : Boolean
      {
         return _pressEnable;
      }
      
      public function get transparentEnable() : Boolean
      {
         return _transparentEnable;
      }
      
      public function set transparentEnable(param1:Boolean) : void
      {
         if(_transparentEnable == param1)
         {
            return;
         }
         _transparentEnable = param1;
         onPropertiesChanged("transparentEnable");
      }
      
      protected function __onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(autoHideTip)
         {
            ShowTipManager.Instance.hideTip(this);
         }
         if(_delayClick)
         {
            _loc2_ = getTimer();
            if(_loc2_ - _preClickTime < _delayClickTime)
            {
               param1.stopImmediatePropagation();
            }
            _preClickTime = _loc2_;
         }
         if(!_enable)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      public function set delayClick(param1:Boolean) : void
      {
         _delayClick = param1;
      }
      
      public function set delayClickTime(param1:int) : void
      {
         _delayClickTime = param1;
      }
      
      protected function adaptHitArea() : void
      {
         _PNGHitArea.x = _back.x;
         _PNGHitArea.y = _back.y;
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
      }
      
      override protected function addTopChildren() : void
      {
         if(_lockBit)
         {
            addChild(_lockBit);
         }
      }
      
      protected function addEvent() : void
      {
         addEventListener("click",__onMouseClick);
         addEventListener("rollOver",__onMouseRollover);
         addEventListener("rollOut",__onMouseRollout);
         addEventListener("mouseDown",__onMousedown);
      }
      
      protected function drawHitArea() : void
      {
         if(_PNGHitArea && contains(_PNGHitArea))
         {
            removeChild(_PNGHitArea);
         }
         if(_transparentEnable)
         {
            _PNGHitArea = PNGHitAreaFactory.drawHitArea(getBitmap());
            hitArea = _PNGHitArea;
            _PNGHitArea.alpha = 0;
            adaptHitArea();
            addChild(_PNGHitArea);
         }
         else if(_PNGHitArea && contains(_PNGHitArea))
         {
            removeChild(_PNGHitArea);
         }
      }
      
      protected function getBitmap() : Bitmap
      {
         var _loc1_:BitmapData = null;
         if(_back is Bitmap)
         {
            return Bitmap(_back);
         }
         if(_back is Component)
         {
            _loc1_ = new BitmapData(Component(_back).displayWidth,Component(_back).displayHeight);
         }
         else
         {
            _loc1_ = new BitmapData(_back.width,_back.height);
         }
         _loc1_.draw(_back);
         return new Bitmap(_loc1_);
      }
      
      override protected function init() : void
      {
         super.init();
         mouseChildren = false;
         buttonMode = true;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var _loc1_:Rectangle = null;
         super.onProppertiesUpdate();
         if(_changedPropeties["pressEnable"])
         {
            if(_pressEnable == true)
            {
               _pressStartTimer = new Timer(ComponentSetting.BUTTON_PRESS_START_TIME,1);
               _pressStepTimer = new Timer(ComponentSetting.BUTTON_PRESS_STEP_TIME);
            }
         }
         if(_changedPropeties["width"] || _changedPropeties["height"])
         {
            if(_back)
            {
               _back.width = _width;
               _back.height = _height;
            }
         }
         if(_changedPropeties["backStyle"] && _autoSizeAble)
         {
            if(_back && (_back.width > 0 || _back.height > 0))
            {
               _width = _back.width;
               _height = _back.height;
            }
         }
         if(_changedPropeties["backgoundRotation"])
         {
            if(_back)
            {
               _back.rotation = _backgoundRotation;
               _loc1_ = _back.getRect(this);
               _back.x = -_loc1_.x;
               _back.y = -_loc1_.y;
            }
         }
         if(_changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["backStyle"] || _changedPropeties["backgoundRotation"] || _changedPropeties["transparentEnable"])
         {
            drawHitArea();
         }
         setFrame(_currentFrameIndex);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",__onMouseClick);
         removeEventListener("rollOver",__onMouseRollover);
         removeEventListener("rollOut",__onMouseRollout);
         removeEventListener("mouseDown",__onMousedown);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseup);
         if(_pressStartTimer)
         {
            _pressStartTimer.removeEventListener("timer",__onPressedStart);
         }
         if(_pressStepTimer)
         {
            _pressStepTimer.removeEventListener("timer",__onPressStepTimer);
         }
      }
      
      public function setFrame(param1:int) : void
      {
         _currentFrameIndex = param1;
         DisplayUtils.setFrame(_back,_currentFrameIndex);
         if(_frameFilter == null || param1 <= 0 || param1 > _frameFilter.length)
         {
            return;
         }
         filters = _frameFilter[param1 - 1];
      }
      
      protected function __onMouseRollout(param1:MouseEvent) : void
      {
         if(_enable && !param1.buttonDown)
         {
            setFrame(1);
         }
         if(_pressEnable)
         {
            _pressStartTimer.stop();
            _pressStepTimer.stop();
            _pressStepTimer.removeEventListener("timer",__onPressStepTimer);
         }
      }
      
      protected function __onMouseRollover(param1:MouseEvent) : void
      {
         if(_enable && !param1.buttonDown)
         {
            setFrame(2);
         }
      }
      
      protected function __onMousedown(param1:MouseEvent) : void
      {
         if(param1.cancelable)
         {
            return;
         }
         if(_enable)
         {
            setFrame(3);
         }
         if(_displacementEnable && _offsetCount < 1)
         {
            x += ComponentSetting.DISPLACEMENT_OFFSET;
            y += ComponentSetting.DISPLACEMENT_OFFSET;
            _offsetCount = _offsetCount + 1;
         }
         StageReferance.stage.addEventListener("mouseUp",__onMouseup);
         if(_pressEnable)
         {
            __onPressStepTimer(null);
            _pressStartTimer.addEventListener("timer",__onPressedStart);
            _pressStartTimer.start();
         }
      }
      
      protected function __onMouseup(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onMouseup);
         if(!_enable)
         {
            return;
         }
         if(_displacementEnable && _offsetCount > -1)
         {
            x -= ComponentSetting.DISPLACEMENT_OFFSET;
            y -= ComponentSetting.DISPLACEMENT_OFFSET;
            _offsetCount = _offsetCount - 1;
         }
         if(!(param1.target is DisplayObject))
         {
            setFrame(1);
         }
         if(param1.target == this)
         {
            setFrame(2);
         }
         else
         {
            setFrame(1);
         }
         if(_pressEnable)
         {
            _pressStartTimer.stop();
            _pressStepTimer.stop();
            _pressStepTimer.removeEventListener("timer",__onPressStepTimer);
         }
      }
      
      private function __onPressStepTimer(param1:TimerEvent) : void
      {
         dispatchEvent(new Event("change"));
      }
      
      private function __onPressedStart(param1:TimerEvent) : void
      {
         _pressStartTimer.removeEventListener("timer",__onPressedStart);
         _pressStartTimer.reset();
         _pressStartTimer.stop();
         _pressStepTimer.start();
         _pressStepTimer.addEventListener("timer",__onPressStepTimer);
      }
      
      override public function get height() : Number
      {
         return displayHeight;
      }
      
      override public function get width() : Number
      {
         return displayWidth;
      }
      
      public function get lockStyle() : String
      {
         return _lockStyle;
      }
      
      public function set lockStyle(param1:String) : void
      {
         if(_lockStyle == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_lockStyle);
         _lockStyle = param1;
         _lockBit = ComponentFactory.Instance.creat(_lockStyle);
         _lockBit.visible = false;
         onPropertiesChanged("lockStyle");
      }
      
      public function get lock() : Boolean
      {
         return _lock;
      }
      
      public function set lock(param1:Boolean) : void
      {
         _lock = param1;
         if(_lockBit)
         {
            _lockBit.visible = _lock;
            enable = !_lock;
         }
      }
   }
}

