package com.speedEngine.speedBones.manager
{
   import com.speedEngine.speedBones.animation.Animation;
   import com.speedEngine.speedBones.display.DisplayObject;
   import com.speedEngine.speedBones.display.DisplayObjectContainer;
   import com.speedEngine.speedBones.display.Stage;
   import com.speedEngine.speedBones.events.Event;
   import com.speedEngine.speedBones.events.TouchEvent;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   use namespace speedBones_internal;
   
   public class TouchManager
   {
      
      private static var _instance:TouchManager;
      
      private var _animations:Vector.<DisplayObject>;
      
      private var _pointA:Point;
      
      private var _pointB:Point;
      
      private var _pointC:Point;
      
      private var _pointD:Point;
      
      private var _point:Point;
      
      private var _stage:flash.display.Stage;
      
      private var _currentOverAnimations:Dictionary;
      
      private var _berforeAnimations:Dictionary;
      
      private var _mouseDown:Boolean;
      
      private var _hasMouseDwonOrUp:Boolean;
      
      private var _lastDown:Point;
      
      private var _hinkScaleRect:Rectangle = new Rectangle();
      
      private var vShape:Shape;
      
      private var _isShow2D:Boolean = false;
      
      private var _isCtrlKey:Boolean = false;
      
      private var _isShiftKey:Boolean = false;
      
      private var _debugDraw:Boolean = false;
      
      private var _mouseOut:Boolean = false;
      
      private var _mistake:Number = 20;
      
      private var _stack:Array;
      
      private var _gy:Number;
      
      private var _gx:Number;
      
      public function TouchManager(param1:HelpClass)
      {
         super();
         if(param1 == null)
         {
            throw "single class";
         }
         _animations = new Vector.<DisplayObject>();
         _currentOverAnimations = new Dictionary();
         _berforeAnimations = new Dictionary();
         _pointA = new Point();
         _pointB = new Point();
         _pointC = new Point();
         _pointD = new Point();
         _point = new Point();
         vShape = new Shape();
         _stack = [];
         _lastDown = new Point();
      }
      
      public static function get instance() : TouchManager
      {
         if(_instance == null)
         {
            _instance = new TouchManager(new HelpClass());
         }
         return _instance;
      }
      
      public function onEnter() : void
      {
         var _loc2_:TouchEvent = null;
         var _loc7_:int = 0;
         var _loc11_:DisplayObject = null;
         var _loc8_:Dictionary = null;
         var _loc3_:Rectangle = null;
         var _loc10_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc13_:Array = _stage.getObjectsUnderPoint(new Point(_stage.mouseX,_stage.mouseY));
         var _loc1_:int = int(_loc13_.length);
         var _loc12_:Object = null;
         _loc7_ = 0;
         loop0:
         for(; _loc7_ < _loc1_; _loc7_++)
         {
            _loc12_ = _loc13_[_loc7_];
            while(_loc12_)
            {
               if(_loc12_ is InteractiveObject)
               {
                  break;
               }
               _loc12_ = _loc12_.parent;
            }
            if(_loc12_ is InteractiveObject)
            {
               if(_loc12_.mouseEnabled)
               {
                  _hasMouseDwonOrUp = false;
                  return;
               }
               if(_loc12_ is flash.display.DisplayObjectContainer)
               {
                  do
                  {
                     if(!_loc12_.parent)
                     {
                        continue loop0;
                     }
                  }
                  while(_loc12_ = _loc12_.parent, _loc12_.mouseChildren != false);
                  _hasMouseDwonOrUp = false;
                  return;
               }
            }
         }
         vShape.graphics.clear();
         vShape.graphics.lineStyle(2,16711680);
         if(_mouseOut)
         {
            if(_gx == Number.MIN_VALUE && _gy == Number.MIN_VALUE)
            {
               _hasMouseDwonOrUp = false;
               return;
            }
            _gx = Number.MIN_VALUE;
            _gy = Number.MIN_VALUE;
         }
         else
         {
            _gx = _stage.mouseX;
            _gy = _stage.mouseY;
         }
         var _loc5_:int = int(_animations.length);
         var _loc6_:Rectangle = new Rectangle();
         var _loc4_:Animation = null;
         com.speedEngine.speedBones.display.Stage.current.clearEventState();
         while(--_loc5_ >= 0)
         {
            _loc11_ = _animations[_loc5_];
            if(!(_loc11_ is com.speedEngine.speedBones.display.DisplayObjectContainer))
            {
               _loc3_ = _loc11_.getBounds();
               if(_loc3_ != null)
               {
                  _loc10_ = _loc11_.getInternalGX() + _loc11_.x;
                  _loc9_ = _loc11_.getInternalGY() + _loc11_.y;
                  if(_isShow2D)
                  {
                     vShape.graphics.moveTo(_loc3_.x + _loc10_,_loc3_.y + _loc9_);
                     vShape.graphics.lineStyle(2,16711680);
                     vShape.graphics.lineTo(_loc3_.x + _loc10_,_loc3_.bottom + _loc9_);
                     vShape.graphics.lineStyle(2,65280);
                     vShape.graphics.lineTo(_loc3_.right + _loc10_,_loc3_.bottom + _loc9_);
                     vShape.graphics.lineStyle(2,255);
                     vShape.graphics.lineTo(_loc3_.right + _loc10_,_loc3_.y + _loc9_);
                     vShape.graphics.lineStyle(2,16777215);
                     vShape.graphics.lineTo(_loc3_.x + _loc10_,_loc3_.y + _loc9_);
                  }
                  if(inRect(_loc10_ + _loc3_.x,_loc9_ + _loc3_.y,_loc10_ + _loc3_.right,_loc9_ + _loc3_.bottom,_gx,_gy))
                  {
                     _loc4_ = _loc11_ as Animation;
                     if(_loc4_ && _loc4_.hasHinderData)
                     {
                        if(_loc4_.checkHinder(_gx - _loc10_,_gy - _loc9_))
                        {
                           onTouchIn(_loc11_,_stage.mouseX,_stage.mouseY);
                           break;
                        }
                     }
                     else if(check(_loc11_.triangles,_gx - _loc10_,_gy - _loc9_,_loc10_,_loc9_))
                     {
                        onTouchIn(_loc11_,_stage.mouseX,_stage.mouseY);
                        break;
                     }
                  }
               }
            }
         }
         for(_loc11_ in _berforeAnimations)
         {
            if(!(_loc11_ in _currentOverAnimations))
            {
               onTouchOut(_loc11_,_stage.mouseX,_stage.mouseY);
            }
            delete _berforeAnimations[_loc11_];
         }
         _loc8_ = _berforeAnimations;
         _berforeAnimations = _currentOverAnimations;
         _currentOverAnimations = _loc8_;
         if(_hasMouseDwonOrUp)
         {
            if(_mouseDown)
            {
               _loc2_ = getTouchEvent("mouse_down",_gx,_gy,_gx,_gy);
               com.speedEngine.speedBones.display.Stage.current.dispathEventWidth(_loc2_);
               _lastDown.x = _gx;
               _lastDown.y = _gy;
            }
            else
            {
               _loc2_ = getTouchEvent("mouse_up",_gx,_gy,_gx,_gy);
               com.speedEngine.speedBones.display.Stage.current.dispathEventWidth(_loc2_);
               if(_lastDown.x != -1 || _lastDown.y != -1)
               {
                  _loc2_ = getTouchEvent("click",_gx,_gy,_gx,_gy);
                  com.speedEngine.speedBones.display.Stage.current.dispathEventWidth(_loc2_);
               }
               _lastDown.x = _lastDown.y = -1;
            }
         }
         _hasMouseDwonOrUp = false;
      }
      
      private function hinkScaleCheck(param1:Animation) : Rectangle
      {
         var _loc2_:Rectangle = param1.getBounds();
         if(param1.scaleX == 1 && param1.scaleY == 1 && param1.skewX == 0 && param1.skewY == 0)
         {
            return _loc2_;
         }
         return _hinkScaleRect;
      }
      
      private function onTouchOut(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         var _loc4_:TouchEvent = null;
         var _loc5_:Point = param1.speedBones_internal::globalToLocal(new Point(param2,param3));
         if(param1.lastMouseMovePoint != null)
         {
            _loc4_ = getTouchEvent("mouse_out",_loc5_.x,_loc5_.y,param2,param3);
         }
         param1.lastMouseMovePoint = null;
         param1.isDown = false;
         if(_loc4_)
         {
            param1.dispathEventWidth(_loc4_,true);
         }
      }
      
      private function inRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean
      {
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc9_:Number = NaN;
         _loc7_ = param1;
         _loc7_ = param3;
         param1 < param3 ? (_loc10_ = param1,_loc7_) : (_loc10_ = param3,_loc7_);
         _loc9_ = param2;
         _loc9_ = param4;
         param2 < param4 ? (_loc8_ = param2,_loc9_) : (_loc8_ = param4,_loc9_);
         if(param5 < _loc10_)
         {
            return false;
         }
         if(param5 > _loc7_)
         {
            return false;
         }
         if(param6 < _loc8_)
         {
            return false;
         }
         if(param6 > _loc9_)
         {
            return false;
         }
         return true;
      }
      
      public function addTouch(param1:DisplayObject) : void
      {
         _animations.push(param1);
      }
      
      public function removeTouch(param1:DisplayObject) : void
      {
         var _loc2_:int = _animations.indexOf(param1);
         if(_loc2_ > -1)
         {
            _animations.splice(_loc2_,1);
         }
      }
      
      public function removeAll() : void
      {
         _animations.length = 0;
      }
      
      public function onTouchIn(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         var _loc5_:TouchEvent = null;
         var _loc6_:Point = param1.speedBones_internal::globalToLocal(new Point(param2,param3));
         var _loc4_:Point = param1.lastMouseMovePoint;
         if(_loc4_ == null)
         {
            _loc5_ = getTouchEvent("mouse_over",_loc6_.x,_loc6_.y,param2,param3);
         }
         else if(_loc4_.x != _loc6_.x || _loc4_.y != _loc6_.y)
         {
            _loc5_ = getTouchEvent("mouse_move",_loc6_.x,_loc6_.y,param2,param3);
         }
         param1.lastMouseMovePoint = _loc6_;
         if(_loc5_)
         {
            param1.dispathEventWidth(_loc5_,true);
         }
         if(_hasMouseDwonOrUp)
         {
            if(_mouseDown)
            {
               param1.isDown = true;
               _loc5_ = getTouchEvent("mouse_down",_loc6_.x,_loc6_.y,param2,param3);
               param1.dispathEventWidth(_loc5_,true);
            }
            else
            {
               _loc5_ = getTouchEvent("mouse_up",_loc6_.x,_loc6_.y,param2,param3);
               param1.dispathEventWidth(_loc5_,true);
               if(param1.isDown)
               {
                  _loc5_ = getTouchEvent("click",_loc6_.x,_loc6_.y,param2,param3);
                  param1.dispathEventWidth(_loc5_,true);
               }
               param1.isDown = false;
            }
         }
         _currentOverAnimations[param1] = param1;
      }
      
      private function getTouchEvent(param1:String, param2:Number, param3:Number, param4:Number, param5:Number) : TouchEvent
      {
         return com.speedEngine.speedBones.events.Event.getEvent(TouchEvent,param1,null,param2,param3,param4,param5,_isCtrlKey,_isShiftKey);
      }
      
      private function check(param1:Vector.<Number>, param2:Number, param3:Number, param4:Number, param5:Number) : Boolean
      {
         var _loc6_:int = param1.length / 8;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         _point.x = param2;
         _point.y = param3;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc7_ * 8;
            _pointA.x = param1[_loc8_];
            _pointA.y = -param1[_loc8_ + 1];
            _pointB.x = param1[_loc8_ + 2];
            _pointB.y = -param1[_loc8_ + 3];
            _pointC.x = param1[_loc8_ + 4];
            _pointC.y = -param1[_loc8_ + 5];
            _pointD.x = param1[_loc8_ + 6];
            _pointD.y = -param1[_loc8_ + 7];
            if(_isShow2D)
            {
               vShape.graphics.moveTo(_pointA.x + param4,_pointA.y + param5);
               vShape.graphics.lineTo(_pointD.x + param4,_pointD.y + param5);
               vShape.graphics.lineTo(_pointB.x + param4,_pointB.y + param5);
               vShape.graphics.lineTo(_pointA.x + param4,_pointA.y + param5);
               vShape.graphics.moveTo(_pointB.x + param4,_pointB.y + param5);
               vShape.graphics.lineTo(_pointC.x + param4,_pointC.y + param5);
               vShape.graphics.lineTo(_pointD.x + param4,_pointD.y + param5);
               vShape.graphics.lineTo(_pointB.x + param4,_pointB.y + param5);
            }
            if(isInsideTriangle(_pointA,_pointD,_pointB,_point))
            {
               if(_isShow2D)
               {
                  _stage.addChild(vShape);
               }
               return true;
            }
            if(isInsideTriangle(_pointB,_pointC,_pointD,_point))
            {
               if(_isShow2D)
               {
                  _stage.addChild(vShape);
               }
               return true;
            }
            _loc7_++;
         }
         if(_isShow2D)
         {
            _stage.addChild(vShape);
         }
         return false;
      }
      
      private function isInsideTriangle(param1:Point, param2:Point, param3:Point, param4:Point) : Boolean
      {
         var _loc5_:Number = (param1.x - param4.x) * (param2.y - param4.y) - (param2.x - param4.x) * (param1.y - param4.y);
         var _loc6_:Number = (param2.x - param4.x) * (param3.y - param4.y) - (param3.x - param4.x) * (param2.y - param4.y);
         var _loc7_:Number = (param3.x - param4.x) * (param1.y - param4.y) - (param1.x - param4.x) * (param3.y - param4.y);
         return sign(_loc5_) == sign(_loc6_) && sign(_loc6_) == sign(_loc7_);
      }
      
      private function sign(param1:Number) : int
      {
         return param1 == 0 ? -1 : Math.abs(param1) / param1;
      }
      
      public function step(param1:flash.display.Stage) : void
      {
         _stage = param1;
         _stage.addEventListener("mouseDown",__onMouseDown);
         _stage.addEventListener("mouseUp",__onMouseUp);
         _stage.addEventListener("rollOut",__onMouseOut);
         _stage.addEventListener("mouseMove",__onMouseOver);
         _stage.addEventListener("mouseLeave",__onMouseOut);
         _stage.addEventListener("keyUp",__onKeyUp);
         _stage.addEventListener("keyDown",__onKeyDown);
      }
      
      protected function __onKeyDown(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 16)
         {
            case 0:
               _isShiftKey = true;
               break;
            case 1:
               _isCtrlKey = true;
         }
      }
      
      protected function __onKeyUp(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case 35:
               _isShow2D = !_isShow2D;
               break;
            case 17:
               _isCtrlKey = false;
               break;
            case 16:
               _isShiftKey = false;
         }
      }
      
      protected function __onMouseOver(param1:flash.events.Event) : void
      {
         _mouseOut = false;
         _stage.removeEventListener("mouseMove",__onMouseOver);
      }
      
      protected function __onMouseOut(param1:flash.events.Event) : void
      {
         _mouseDown = false;
         _mouseOut = true;
         _stage.addEventListener("mouseMove",__onMouseOver);
      }
      
      protected function __onMouseUp(param1:MouseEvent) : void
      {
         _hasMouseDwonOrUp = true;
         _mouseDown = false;
      }
      
      protected function __onMouseDown(param1:MouseEvent) : void
      {
         _hasMouseDwonOrUp = true;
         _mouseDown = true;
      }
      
      public function get isShow2D() : Boolean
      {
         return _isShow2D;
      }
      
      public function set isShow2D(param1:Boolean) : void
      {
         _isShow2D = param1;
      }
   }
}

class HelpClass
{
   
   public function HelpClass()
   {
      super();
   }
}
