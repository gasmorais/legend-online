package yishi.view.base
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class VRollItemPanel extends Component
   {
      
      private var _lastBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _vbox:VBox;
      
      private var _list:Array = [];
      
      private var _boxMask:Shape;
      
      private var _stepIndex:int = 0;
      
      private var _initOffY:int = 0;
      
      private var _mouseState:int = 0;
      
      private var MAX_COUNT:int = 7;
      
      private var ITEM_H:int = 56;
      
      public function VRollItemPanel()
      {
         super();
      }
      
      public function initParams(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int) : void
      {
         _boxMask = new Shape();
         _vbox = ComponentFactory.Instance.creatCustomObject(param1);
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename(param2);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename(param3);
         addChild(_vbox);
         addChild(_lastBtn);
         addChild(_nextBtn);
         addChild(_boxMask);
         _boxMask.graphics.beginFill(0);
         _boxMask.graphics.drawRect(0,0,param6,param5 * param4);
         _boxMask.graphics.endFill();
         MAX_COUNT = param4;
         ITEM_H = param5;
         _initOffY = _boxMask.y = _vbox.y;
         _boxMask.x = _vbox.x;
         _vbox.mask = _boxMask;
         initEvent();
      }
      
      public function updateList(param1:Array) : void
      {
         _vbox.disposeAllChildren();
         _list.length = 0;
         _vbox.beginChanges();
         for each(var _loc2_:DisplayObject in param1)
         {
            _vbox.addChild(_loc2_);
            _list.push(_loc2_);
         }
         _vbox.commitChanges();
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
         _lastBtn.removeEventListener("mouseDown",__downLastHandler);
         _lastBtn.removeEventListener("mouseUp",__pageBtnUpHandler);
         _nextBtn.removeEventListener("mouseDown",__downNextHandler);
         _nextBtn.removeEventListener("mouseUp",__pageBtnUpHandler);
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
         TweenMax.to(_vbox,0.3,{
            "y":_stepIndex * ITEM_H + _initOffY,
            "onComplete":moveComplete,
            "ease":Linear.easeNone
         });
      }
      
      public function skip(param1:int) : void
      {
         var _loc2_:int = 0;
         if(param1 < _stepIndex || param1 >= _stepIndex + MAX_COUNT)
         {
            _loc2_ = param1;
            if(_list.length - MAX_COUNT < _loc2_)
            {
               _loc2_ = _list.length - MAX_COUNT;
            }
            _stepIndex = -_loc2_;
            _vbox.y = _stepIndex * ITEM_H + _initOffY;
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
      
      override public function dispose() : void
      {
         if(_vbox)
         {
            TweenMax.killTweensOf(_vbox);
         }
         removeEvent();
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            parent.removeChild(this);
         }
         _boxMask = null;
         _list = null;
         _lastBtn = null;
         _nextBtn = null;
         super.dispose();
      }
   }
}

