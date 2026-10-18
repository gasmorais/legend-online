package com.speedEngine.speedBones.filters
{
   import flash.geom.Rectangle;
   
   public class BlurFilter extends Filter
   {
      
      public static const BYTE_LENGTH:uint = 72;
      
      private static var MAX_SIGMA:Number = 2;
      
      private var _offsets:Vector.<Number>;
      
      private var _weights:Vector.<Number>;
      
      private var _blurY:int;
      
      private var _blurX:int;
      
      private var _isTinted:Boolean = false;
      
      private var _isGlow:Boolean = false;
      
      private var _color:uint;
      
      private var _alpha:Number;
      
      private var _isPhase:Boolean = false;
      
      public function BlurFilter(param1:int = 1, param2:int = 1)
      {
         super();
         _blurX = param1;
         _blurY = param2;
      }
      
      public static function getWeights(param1:Number, param2:int) : Vector.<Number>
      {
         var _loc10_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = -param2;
         var _loc5_:int = -param2;
         var _loc11_:Number = 0.5 / (3.141592653589793 * param1 * param1);
         var _loc4_:Number = 2 * param1 * param1;
         var _loc12_:Vector.<Number> = new Vector.<Number>(0);
         var _loc8_:Number = 0;
         var _loc7_:Number = 0;
         var _loc6_:Vector.<Number> = new Vector.<Number>(0);
         while(_loc5_ <= param2)
         {
            _loc9_ = -param2;
            while(_loc9_ <= param2)
            {
               if(_loc9_ == _loc5_ && _loc9_ == 0)
               {
                  _loc9_++;
               }
               else
               {
                  _loc8_ = _loc11_ * Math.exp(-(_loc9_ * _loc9_ + _loc5_ * _loc5_) / _loc4_);
                  _loc7_ += _loc8_;
                  _loc12_.push(_loc8_);
                  _loc6_.push(_loc5_ / 960,_loc9_ / 640,0,_loc8_);
                  _loc9_++;
               }
            }
            _loc5_++;
         }
         _loc3_ = int(_loc12_.length);
         _loc10_ = -1;
         while(++_loc10_ < _loc3_)
         {
            var _loc13_:Number = _loc10_;
            var _loc14_:Number = _loc12_[_loc13_] / _loc7_;
            _loc12_[_loc13_] = _loc14_;
            _loc6_[_loc10_ * 4 + 3] = _loc12_[_loc10_];
         }
         return _loc6_;
      }
      
      private static function updateParameters(param1:int, param2:int, param3:Number, param4:Number) : Array
      {
         var _loc13_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc9_:int = 0;
         var _loc14_:Vector.<Number> = new Vector.<Number>();
         var _loc16_:Vector.<Number> = new Vector.<Number>();
         var _loc12_:Vector.<Number> = new Vector.<Number>();
         _loc13_ = MAX_SIGMA;
         _loc11_ = 1 / param1;
         var _loc15_:Number = 2 * _loc13_ * _loc13_;
         var _loc8_:Number = 1 / Math.sqrt(_loc15_ * 3.141592653589793);
         _loc9_ = 0;
         while(_loc9_ < 5)
         {
            _loc12_[_loc9_] = _loc8_ * Math.exp(-_loc9_ * _loc9_ / _loc15_);
            _loc9_++;
         }
         _loc14_[0] = _loc12_[0];
         _loc14_[1] = _loc12_[1] + _loc12_[2];
         _loc14_[2] = _loc12_[3] + _loc12_[4];
         var _loc7_:Number = _loc14_[0] + 2 * _loc14_[1] + 2 * _loc14_[2];
         var _loc10_:Number = 1 / _loc7_;
         _loc14_[0] *= _loc10_;
         _loc14_[1] *= _loc10_;
         _loc14_[2] *= _loc10_;
         var _loc6_:Number = (_loc11_ * _loc12_[1] + 2 * _loc11_ * _loc12_[2]) / _loc14_[1];
         var _loc5_:Number = (3 * _loc11_ * _loc12_[3] + 4 * _loc11_ * _loc12_[4]) / _loc14_[2];
         _loc16_[0] = _loc6_;
         _loc16_[1] = 0;
         _loc16_[2] = _loc5_;
         _loc16_[3] = 0;
         return [_loc16_,_loc14_];
      }
      
      public static function createGlowFilter(param1:int = 5, param2:uint = 16711680, param3:Number = 2.5) : BlurFilter
      {
         var _loc4_:BlurFilter = new BlurFilter(param1,param1);
         _loc4_._isGlow = true;
         _loc4_._color = param2;
         _loc4_._alpha = param3;
         return _loc4_;
      }
      
      public static function createStrokeFilter(param1:uint = 16711680, param2:Number = 2.5) : BlurFilter
      {
         var _loc3_:BlurFilter = new BlurFilter(1,1);
         _loc3_._isTinted = true;
         _loc3_._color = param1;
         _loc3_._alpha = param2;
         return _loc3_;
      }
      
      public function get alpha() : Number
      {
         return _alpha;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get isTinted() : Boolean
      {
         return _isTinted;
      }
      
      public function get renderMode() : uint
      {
         var _loc1_:uint = 0;
         if(_isTinted)
         {
            _loc1_ = 13;
         }
         else if(_isGlow)
         {
            _loc1_ = 16;
         }
         else
         {
            _loc1_ = 12;
         }
         return _loc1_;
      }
      
      public function setTextureSize(param1:Rectangle) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(_isPhase)
         {
            return;
         }
         _isPhase = true;
         var _loc6_:Number = param1.width;
         var _loc4_:Number = param1.height;
         var _loc7_:Array = updateParameters(1024,1024,_blurX,_blurY);
         _offsets = _loc7_[0];
         _weights = _loc7_[1];
         _filterBytes.length = 72;
         _filterBytes.position = 0;
         _loc2_ = Math.ceil(_offsets.length / 4);
         _offsets.length = _loc2_ * 4;
         _loc5_ = -1;
         while(++_loc5_ < _loc2_)
         {
            _loc3_ = _loc5_ * 4;
            _filterBytes.writeFloat(_offsets[_loc3_]);
            _filterBytes.writeFloat(_offsets[_loc3_ + 1]);
            _filterBytes.writeFloat(_offsets[_loc3_ + 2]);
            _filterBytes.writeFloat(_offsets[_loc3_ + 3]);
         }
         _loc2_ = Math.ceil(_weights.length / 4);
         _weights.length = _loc2_ * 4;
         _loc5_ = -1;
         while(++_loc5_ < _loc2_)
         {
            _loc3_ = _loc5_ * 4;
            _filterBytes.writeFloat(_weights[_loc3_]);
            _filterBytes.writeFloat(_weights[_loc3_ + 1]);
            _filterBytes.writeFloat(_weights[_loc3_ + 2]);
            _filterBytes.writeFloat(_weights[_loc3_ + 3]);
         }
         _filterBytes.writeFloat(_loc6_);
         _filterBytes.writeFloat(_loc4_);
         _filterBytes.writeFloat(_blurX);
         _filterBytes.writeFloat(_blurY);
         _filterBytes.writeFloat(param1.x);
         _filterBytes.writeFloat(param1.y);
         if(_isTinted || _isGlow)
         {
            _filterBytes.writeFloat((_color >> 16 & 0xFF) / 255);
            _filterBytes.writeFloat((_color >> 8 & 0xFF) / 255);
            _filterBytes.writeFloat((_color & 0xFF) / 255);
            _filterBytes.writeFloat(_alpha);
         }
         _filterBytes.position = 0;
      }
      
      public function get isGlow() : Boolean
      {
         return _isGlow;
      }
      
      override public function dispose() : void
      {
         if(_offsets)
         {
            _offsets.length = 0;
            _offsets = null;
         }
         if(_weights)
         {
            _weights.length = 0;
            _weights = null;
         }
         super.dispose();
      }
   }
}

