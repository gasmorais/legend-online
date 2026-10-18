package com.greensock.plugins
{
   import com.greensock.*;
   import com.greensock.core.*;
   import flash.display.*;
   import flash.filters.BlurFilter;
   import flash.geom.*;
   import flash.utils.getDefinitionByName;
   
   public class MotionBlurPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      private static const _DEG2RAD:Number = 0.017453292519943295;
      
      private static const _RAD2DEG:Number = 57.29577951308232;
      
      private static var _classInitted:Boolean;
      
      private static var _isFlex:Boolean;
      
      private static const _point:Point = new Point(0,0);
      
      private static const _ct:ColorTransform = new ColorTransform();
      
      private static const _blankArray:Array = [];
      
      protected var _target:DisplayObject;
      
      protected var _time:Number;
      
      protected var _xCurrent:Number;
      
      protected var _yCurrent:Number;
      
      protected var _bd:BitmapData;
      
      protected var _bitmap:Bitmap;
      
      protected var _strength:Number = 0.05;
      
      protected var _tween:TweenLite;
      
      protected var _blur:BlurFilter = new BlurFilter(0,0,2);
      
      protected var _matrix:Matrix = new Matrix();
      
      protected var _sprite:Sprite;
      
      protected var _rect:Rectangle;
      
      protected var _angle:Number;
      
      protected var _alpha:Number;
      
      protected var _xRef:Number;
      
      protected var _yRef:Number;
      
      protected var _mask:DisplayObject;
      
      protected var _padding:int;
      
      protected var _bdCache:BitmapData;
      
      protected var _rectCache:Rectangle;
      
      protected var _cos:Number;
      
      protected var _sin:Number;
      
      protected var _smoothing:Boolean;
      
      protected var _xOffset:Number;
      
      protected var _yOffset:Number;
      
      protected var _cached:Boolean;
      
      protected var _fastMode:Boolean;
      
      public function MotionBlurPlugin()
      {
         super();
         this.propName = "motionBlur";
         this.overwriteProps = ["motionBlur"];
         this.onComplete = disable;
         this.onDisable = onTweenDisable;
         this.priority = -2;
         this.activeDisable = true;
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!(param1 is DisplayObject))
         {
            throw new Error("motionBlur tweens only work for DisplayObjects.");
         }
         if(param2 == false)
         {
            _strength = 0;
         }
         else if(typeof param2 == "object")
         {
            _strength = (param2.strength || 1) * 0.05;
            _blur.quality = int(param2.quality) || 2;
            _fastMode = param2.fastMode == true;
         }
         if(!_classInitted)
         {
            try
            {
               _isFlex = Boolean(getDefinitionByName("mx.managers.SystemManager"));
            }
            catch(e:Error)
            {
               _isFlex = false;
            }
            _classInitted = true;
         }
         _target = param1 as DisplayObject;
         _tween = param3;
         _time = 0;
         _padding = "padding" in param2 ? int(param2.padding) : 10;
         _smoothing = _blur.quality > 1;
         _xCurrent = _xRef = _target.x;
         _yCurrent = _yRef = _target.y;
         _alpha = _target.alpha;
         if("x" in _tween.propTweenLookup && "y" in _tween.propTweenLookup && !_tween.propTweenLookup.x.isPlugin && !_tween.propTweenLookup.y.isPlugin)
         {
            _angle = 3.141592653589793 - Math.atan2(_tween.propTweenLookup.y.change,_tween.propTweenLookup.x.change);
         }
         else if(_tween.vars.x != null || _tween.vars.y != null)
         {
            _loc4_ = Number(_tween.vars.x || _target.x);
            _loc5_ = Number(_tween.vars.y || _target.y);
            _angle = 3.141592653589793 - Math.atan2(_loc5_ - _target.y,_loc4_ - _target.x);
         }
         else
         {
            _angle = 0;
         }
         _cos = Math.cos(_angle);
         _sin = Math.sin(_angle);
         _bd = new BitmapData(_target.width + _padding * 2,_target.height + _padding * 2,true,16777215);
         _bdCache = _bd.clone();
         _bitmap = new Bitmap(_bd);
         _bitmap.smoothing = _smoothing;
         _sprite = _isFlex ? new (getDefinitionByName("mx.core.UIComponent"))() : new Sprite();
         _sprite.mouseEnabled = _sprite.mouseChildren = false;
         _sprite.addChild(_bitmap);
         _rectCache = new Rectangle(0,0,_bd.width,_bd.height);
         _rect = _rectCache.clone();
         if(_target.mask)
         {
            _mask = _target.mask;
         }
         return true;
      }
      
      private function disable() : void
      {
         if(_strength != 0)
         {
            _target.alpha = _alpha;
         }
         if(_sprite.parent)
         {
            if(_isFlex && _sprite.parent.hasOwnProperty("removeElement"))
            {
               (_sprite.parent as Object).removeElement(_sprite);
            }
            else
            {
               _sprite.parent.removeChild(_sprite);
            }
         }
         if(_mask)
         {
            _target.mask = _mask;
         }
      }
      
      private function onTweenDisable() : void
      {
         if(_tween.cachedTime != _tween.cachedDuration && _tween.cachedTime != 0)
         {
            disable();
         }
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc11_:Array = null;
         var _loc7_:Boolean = false;
         var _loc8_:Rectangle = null;
         var _loc12_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = _tween.cachedTime - _time;
         if(_loc10_ < 0)
         {
            _loc10_ = -_loc10_;
         }
         if(_loc10_ < 1e-7)
         {
            return;
         }
         var _loc3_:Number = _target.x - _xCurrent;
         var _loc4_:Number = _target.y - _yCurrent;
         var _loc5_:Number = _target.x - _xRef;
         var _loc6_:Number = _target.y - _yRef;
         _changeFactor = param1;
         if(_loc5_ > 2 || _loc6_ > 2 || _loc5_ < -2 || _loc6_ < -2)
         {
            _angle = 3.141592653589793 - Math.atan2(_loc6_,_loc5_);
            _cos = Math.cos(_angle);
            _sin = Math.sin(_angle);
            _xRef = _target.x;
            _yRef = _target.y;
         }
         _blur.blurX = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_) * _strength / _loc10_;
         _xCurrent = _target.x;
         _yCurrent = _target.y;
         _time = _tween.cachedTime;
         if(param1 == 0 || _target.parent == null)
         {
            disable();
            return;
         }
         if(_sprite.parent != _target.parent && _target.parent)
         {
            if(_isFlex && _target.parent.hasOwnProperty("addElement"))
            {
               (_target.parent as Object).addElementAt(_sprite,(_target.parent as Object).getElementIndex(_target));
            }
            else
            {
               _target.parent.addChildAt(_sprite,_target.parent.getChildIndex(_target));
            }
            if(_mask)
            {
               _sprite.mask = _mask;
            }
         }
         if(!_fastMode || !_cached)
         {
            _loc11_ = _target.parent.filters;
            if(_loc11_.length != 0)
            {
               _target.parent.filters = _blankArray;
            }
            _target.x = _target.y = 20000;
            _loc7_ = _target.visible;
            _target.visible = true;
            _loc8_ = _target.getBounds(_target.parent);
            if(_loc8_.width + _blur.blurX * 2 > 2870)
            {
               _blur.blurX = _loc8_.width >= 2870 ? 0 : (2870 - _loc8_.width) * 0.5;
            }
            _xOffset = 20000 - _loc8_.x + _padding;
            _yOffset = 20000 - _loc8_.y + _padding;
            _loc8_.width += _padding * 2;
            _loc8_.height += _padding * 2;
            if(_loc8_.height > _bdCache.height || _loc8_.width > _bdCache.width)
            {
               _bdCache = new BitmapData(_loc8_.width,_loc8_.height,true,16777215);
               _rectCache = new Rectangle(0,0,_bdCache.width,_bdCache.height);
            }
            _matrix.tx = _padding - _loc8_.x;
            _matrix.ty = _padding - _loc8_.y;
            _matrix.a = _matrix.d = 1;
            _matrix.b = _matrix.c = 0;
            _loc8_.x = _loc8_.y = 0;
            if(_target.alpha == 0.00390625)
            {
               _target.alpha = _alpha;
            }
            else
            {
               _alpha = _target.alpha;
            }
            _bdCache.fillRect(_rectCache,16777215);
            _bdCache.draw(_target.parent,_matrix,_ct,"normal",_loc8_,_smoothing);
            _target.visible = _loc7_;
            _target.x = _xCurrent;
            _target.y = _yCurrent;
            if(_loc11_.length != 0)
            {
               _target.parent.filters = _loc11_;
            }
            _cached = true;
         }
         else if(_target.alpha != 0.00390625)
         {
            _alpha = _target.alpha;
         }
         _target.alpha = 0.00390625;
         _matrix.tx = _matrix.ty = 0;
         _matrix.a = _cos;
         _matrix.b = _sin;
         _matrix.c = -_sin;
         _matrix.d = _cos;
         _loc9_ = _matrix.a * _bdCache.width;
         if(_loc9_ < 0)
         {
            _matrix.tx = -_loc9_;
            _loc9_ = -_loc9_;
         }
         _loc2_ = _matrix.c * _bdCache.height;
         if(_loc2_ < 0)
         {
            _matrix.tx -= _loc2_;
            _loc9_ -= _loc2_;
         }
         else
         {
            _loc9_ += _loc2_;
         }
         _loc12_ = _matrix.d * _bdCache.height;
         if(_loc12_ < 0)
         {
            _matrix.ty = -_loc12_;
            _loc12_ = -_loc12_;
         }
         _loc2_ = _matrix.b * _bdCache.width;
         if(_loc2_ < 0)
         {
            _matrix.ty -= _loc2_;
            _loc12_ -= _loc2_;
         }
         else
         {
            _loc12_ += _loc2_;
         }
         _loc9_ += _blur.blurX * 2;
         _matrix.tx += _blur.blurX;
         if(_loc9_ > _bd.width || _loc12_ > _bd.height)
         {
            _bd = _bitmap.bitmapData = new BitmapData(_loc9_,_loc12_,true,16777215);
            _rect = new Rectangle(0,0,_bd.width,_bd.height);
            _bitmap.smoothing = _smoothing;
         }
         _bd.fillRect(_rect,16777215);
         _bd.draw(_bdCache,_matrix,_ct,"normal",_rect,_smoothing);
         _bd.applyFilter(_bd,_rect,_point,_blur);
         _bitmap.x = 0 - (_matrix.a * _xOffset + _matrix.c * _yOffset + _matrix.tx);
         _bitmap.y = 0 - (_matrix.d * _yOffset + _matrix.b * _xOffset + _matrix.ty);
         _matrix.b = -_sin;
         _matrix.c = _sin;
         _matrix.tx = _xCurrent;
         _matrix.ty = _yCurrent;
         _sprite.transform.matrix = _matrix;
      }
   }
}

