package com.speedEngine.components.ui2D
{
   import com.speedEngine.utils.BitmapUtils;
   import com.speedEngine.utils.ObjectUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class SimpleImage extends TinyUI
   {
      
      public static var IMAGESIZE:String = "imagesize";
      
      private var _bitmap:Bitmap = new Bitmap();
      
      protected var _enabled:Boolean = true;
      
      protected var _originData:BitmapData;
      
      protected var _currentData:BitmapData;
      
      protected var _grayBitmapData:BitmapData;
      
      private var _scaleGridLeft:int = 0;
      
      private var _scaleGridRight:int = 0;
      
      private var _scaleGridTop:int = 0;
      
      private var _scaleGridBottom:int = 0;
      
      private var _pivotX:Number = 0;
      
      private var _pivotY:Number = 0;
      
      private var _rotation:Number = 0;
      
      private var _smoothing:Boolean = true;
      
      public function SimpleImage(param1:BitmapData = null)
      {
         super();
         _bitmap.bitmapData = param1;
         _bitmap.smoothing = _smoothing;
         addChild(_bitmap);
      }
      
      override public function get scaleX() : Number
      {
         return _bitmap.scaleX;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         _bitmap.scaleX = param1;
      }
      
      override public function get scaleY() : Number
      {
         return _bitmap.scaleY;
      }
      
      override public function set scaleY(param1:Number) : void
      {
         _bitmap.scaleY = param1;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
         if(_enabled)
         {
            if(_bitmap != null && _originData != null)
            {
               _bitmap.bitmapData = _currentData;
            }
         }
         else if(_bitmap != null && _originData != null)
         {
            if(_grayBitmapData == null)
            {
               _grayBitmapData = _currentData.clone();
               BitmapUtils.discolor(_grayBitmapData);
            }
            _bitmap.bitmapData = _grayBitmapData;
            pushDisposeBitmap(_grayBitmapData);
         }
      }
      
      public function get texture() : BitmapData
      {
         return _bitmap.bitmapData;
      }
      
      public function set texture(param1:BitmapData) : void
      {
         _currentData = param1;
         _originData = param1;
         _bitmap.bitmapData = param1;
         _bitmap.smoothing = _smoothing;
         pushDisposeBitmap(_originData);
         validate(IMAGESIZE);
         pivotX = _pivotX;
         pivotY = _pivotY;
      }
      
      public function clone() : SimpleImage
      {
         var _loc1_:SimpleImage = new SimpleImage();
         ObjectUtil.copyProperties(_loc1_,this);
         _loc1_.texture = this.texture;
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _originData = null;
         _grayBitmapData = null;
      }
      
      override public function render() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         super.render();
         if(validateDic[IMAGESIZE])
         {
            if(_tWidth > 0 || _tHeight > 0)
            {
               if((scaleGridLeft > 0 || scaleGridRight) && scaleGridTop == 0 && scaleGridBottom == 0)
               {
                  _currentData = BitmapUtils.getScale9Image(_originData,width,_originData.height,new Rectangle(scaleGridLeft,0,scaleGridRight - scaleGridLeft,_originData.height));
                  _bitmap.bitmapData = _currentData;
                  pushDisposeBitmap(_bitmap.bitmapData);
                  _bitmap.scaleX = _bitmap.scaleX > 0 ? 1 : -1;
               }
               else if((scaleGridTop > 0 || scaleGridBottom > 0) && scaleGridLeft == 0 && scaleGridRight == 0)
               {
                  _currentData = BitmapUtils.getScale9Image(_originData,_originData.width,height,new Rectangle(0,scaleGridTop,_originData.width,scaleGridBottom - scaleGridTop));
                  _bitmap.bitmapData = _currentData;
                  _bitmap.scaleY = _bitmap.scaleY > 0 ? 1 : -1;
                  pushDisposeBitmap(_bitmap.bitmapData);
               }
               else if(scaleGridTop > 0 || scaleGridBottom > 0 || (scaleGridLeft > 0 || scaleGridRight > 0))
               {
                  _currentData = BitmapUtils.getScale9Image(_originData,width,height,new Rectangle(scaleGridLeft,scaleGridTop,scaleGridRight - scaleGridLeft,scaleGridBottom - scaleGridTop));
                  _bitmap.bitmapData = _currentData;
                  _bitmap.scaleX = _bitmap.scaleX > 0 ? 1 : -1;
                  _bitmap.scaleY = _bitmap.scaleY > 0 ? 1 : -1;
                  pushDisposeBitmap(_bitmap.bitmapData);
               }
               else if(_bitmap.bitmapData)
               {
                  _loc2_ = _bitmap.scaleX;
                  _loc1_ = _bitmap.scaleY;
                  _bitmap.width = _tWidth;
                  _bitmap.height = _tHeight;
                  _bitmap.scaleX *= _loc2_ > 0 ? 1 : -1;
                  _bitmap.scaleY *= _loc1_ > 0 ? 1 : -1;
               }
            }
         }
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         validate(IMAGESIZE);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         validate(IMAGESIZE);
      }
      
      public function get scaleGridLeft() : int
      {
         return _scaleGridLeft;
      }
      
      public function set scaleGridLeft(param1:int) : void
      {
         _scaleGridLeft = param1;
         validate(IMAGESIZE);
      }
      
      public function get scaleGridRight() : int
      {
         return _scaleGridRight;
      }
      
      public function set scaleGridRight(param1:int) : void
      {
         _scaleGridRight = param1;
         validate(IMAGESIZE);
      }
      
      public function get scaleGridTop() : int
      {
         return _scaleGridTop;
      }
      
      public function set scaleGridTop(param1:int) : void
      {
         _scaleGridTop = param1;
         validate(IMAGESIZE);
      }
      
      public function get scaleGridBottom() : int
      {
         return _scaleGridBottom;
      }
      
      public function set scaleGridBottom(param1:int) : void
      {
         _scaleGridBottom = param1;
         validate(IMAGESIZE);
      }
      
      public function get pivotX() : Number
      {
         return _pivotX;
      }
      
      public function set pivotX(param1:Number) : void
      {
         _pivotX = param1;
         _pivotX = _pivotX > 1 ? 1 : (_pivotX < 0 ? 0 : _pivotX);
      }
      
      public function get pivotY() : Number
      {
         return _pivotY;
      }
      
      public function set pivotY(param1:Number) : void
      {
         _pivotY = param1;
         _pivotY = _pivotY > 1 ? 1 : (_pivotY < 0 ? 0 : _pivotY);
      }
      
      override public function set rotationZ(param1:Number) : void
      {
         if(_bitmap.bitmapData == null)
         {
            return;
         }
         param1 %= 360;
         var _loc4_:Matrix = _bitmap.transform.matrix;
         var _loc5_:Number = _pivotX * _bitmap.bitmapData.width;
         var _loc3_:Number = _pivotY * _bitmap.bitmapData.height;
         var _loc2_:Number = _rotation;
         _rotation = param1;
         _bitmap.smoothing = true;
         _loc4_.translate(-_loc5_,-_loc3_);
         _loc4_.rotate((_loc2_ - _rotation) * 3.141592653589793 / 180);
         _loc4_.translate(_loc5_,_loc3_);
         _bitmap.transform.matrix = _loc4_;
      }
      
      override public function get rotationZ() : Number
      {
         return _rotation;
      }
      
      public function get smoothing() : Boolean
      {
         return _smoothing;
      }
      
      public function set smoothing(param1:Boolean) : void
      {
         _smoothing = param1;
         _bitmap.smoothing = _smoothing;
      }
   }
}

