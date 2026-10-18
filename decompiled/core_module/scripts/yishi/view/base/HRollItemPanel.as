package yishi.view.base
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class HRollItemPanel extends Component
   {
      
      private var _lastBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _hbox:HBox;
      
      private var _list:Array = [];
      
      private var _boxMask:Shape;
      
      private var _stepIndex:int = 0;
      
      private var _initOffX:int = 0;
      
      private var _mouseState:int = 0;
      
      private var MAX_COUNT:int = 7;
      
      private var ITEM_W:int = 56;
      
      public function HRollItemPanel()
      {
         super();
      }
      
      public function initParams(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int, param7:int = -9999) : void
      {
         _hbox = ComponentFactory.Instance.creatCustomObject(param1);
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename(param2);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename(param3);
         addChild(_hbox);
         addChild(_lastBtn);
         addChild(_nextBtn);
         MAX_COUNT = param4;
         if(param7 == -9999)
         {
            param7 = _hbox.spacing;
         }
         ITEM_W = param5 + param7;
         var _loc8_:int = param5 + ITEM_W * (param4 - 1);
         _boxMask = new Shape();
         _boxMask.graphics.beginFill(16711680);
         _boxMask.graphics.drawRect(0,0,_loc8_,param6);
         _boxMask.graphics.endFill();
         _initOffX = _hbox.x;
         _boxMask.x = _hbox.x;
         _boxMask.y = _hbox.y;
         _hbox.mask = _boxMask;
         addChild(_boxMask);
         initEvent();
      }
      
      public function set maskWd(param1:int) : void
      {
         _boxMask.width = param1;
      }
      
      public function updateList(param1:Array) : void
      {
         _hbox.disposeAllChildren();
         _list.length = 0;
         _hbox.beginChanges();
         for each(var _loc2_:DisplayObject in param1)
         {
            _hbox.addChild(_loc2_);
            _list.push(_loc2_);
         }
         _hbox.commitChanges();
         skip(0);
         setBtnState();
      }
      
      private function initEvent() : void
      {
         _lastBtn.addEventListener("mouseDown",__downLastHandler);
         _lastBtn.addEventListener("mouseUp",__pageBtnUpHandler);
         _nextBtn.addEventListener("mouseDown",__downNextHandler);
         _nextBtn.addEventListener("mouseUp",__pageBtnUpHandler);
      }
      
      private function removeEvent() : void
      {
         if(_lastBtn)
         {
            _lastBtn.removeEventListener("mouseDown",__downLastHandler);
         }
         if(_lastBtn)
         {
            _lastBtn.removeEventListener("mouseUp",__pageBtnUpHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("mouseDown",__downNextHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("mouseUp",__pageBtnUpHandler);
         }
      }
      
      private function __pageBtnUpHandler(param1:MouseEvent) : void
      {
         _mouseState = 0;
      }
      
      private function __downLastHandler(param1:Event) : void
      {
         turnBox(true);
         _mouseState = 1;
      }
      
      private function __downNextHandler(param1:Event) : void
      {
         turnBox(false);
         _mouseState = 2;
      }
      
      private function turnBox(param1:Boolean) : void
      {
         if(param1)
         {
            if(_stepIndex >= 0)
            {
               _mouseState = 0;
            }
            else
            {
               step(1);
            }
         }
         else if(_stepIndex <= MAX_COUNT - _list.length)
         {
            _mouseState = 0;
         }
         else
         {
            step(-1);
         }
         setBtnState();
      }
      
      public function step(param1:int = 1) : void
      {
         _stepIndex += param1;
         TweenMax.to(_hbox,0.3,{
            "x":_stepIndex * ITEM_W + _initOffX,
            "onComplete":moveComplete,
            "ease":Linear.easeNone
         });
      }
      
      public function skip(param1:int) : void
      {
         var _loc2_:int = 0;
         if(param1 > -_stepIndex + MAX_COUNT - 1 || param1 < -_stepIndex)
         {
            _loc2_ = param1;
            if(_list.length - MAX_COUNT < _loc2_)
            {
               _loc2_ = _list.length - MAX_COUNT;
            }
            _stepIndex = -_loc2_;
            _hbox.x = _stepIndex * ITEM_W + _initOffX;
         }
         setBtnState();
      }
      
      private function moveComplete() : void
      {
         if(_mouseState == 1)
         {
            turnBox(true);
         }
         else if(_mouseState == 2)
         {
            turnBox(false);
         }
      }
      
      private function setBtnState() : void
      {
         _lastBtn.enable = _stepIndex < 0;
         _nextBtn.enable = _stepIndex > MAX_COUNT - _list.length;
      }
      
      public function get stepIndex() : int
      {
         return _stepIndex;
      }
      
      override public function dispose() : void
      {
         if(_hbox)
         {
            TweenMax.killTweensOf(_hbox);
         }
         removeEvent();
         ObjectUtils.disposeObject(_hbox);
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            parent.removeChild(this);
         }
         _hbox = null;
         _boxMask = null;
         _list = null;
         _lastBtn = null;
         _nextBtn = null;
         super.dispose();
      }
   }
}

