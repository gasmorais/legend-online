package com.speedEngine.components.ui2D
{
   import com.speedEngine.utils.BitmapUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class SimpleButton extends TinyUI
   {
      
      public static const MOVE:String = "move";
      
      public static const SCALE:String = "scale";
      
      public static var IMAGESIZE:String = "imagesize";
      
      public static var RECT:String = "rect";
      
      private var _scaleGridLeft:int = 0;
      
      private var _scaleGridRight:int = 0;
      
      private var _scaleGridTop:int = 0;
      
      private var _scaleGridBottom:int = 0;
      
      private var _downEffect:String = "";
      
      private var _overEffect:String = "";
      
      protected var _bitmap:Bitmap = new Bitmap();
      
      private var _rect:Rectangle;
      
      private var _isEnabled:Boolean = false;
      
      private var _isOpen:Boolean = true;
      
      private var _overTexture:BitmapData;
      
      private var _outTexture:BitmapData;
      
      private var _downTexture:BitmapData;
      
      private var _clickCallBack:Function;
      
      private var _overCallBack:Function;
      
      private var _doubleCallBack:Function;
      
      private var _outCallBack:Function;
      
      private var _unEnabledTexture:BitmapData;
      
      private var _offset:int = 2;
      
      private var _offScale:Number = 0.2;
      
      private var _overOffSet:Number = 10;
      
      private var _overOffScale:Number = 0.2;
      
      private var _isLight:Boolean = false;
      
      protected var _mask:TinyUI = new TinyUI();
      
      private var _srcDownBitmap:BitmapData;
      
      private var _srcBitmap:BitmapData;
      
      private var _srcOverBitmap:BitmapData;
      
      protected var _isDown:int;
      
      private var _pivotX:Number = 0;
      
      private var _pivotY:Number = 0;
      
      private var _rotation:Number = 0;
      
      private var _lastrotation:Number = 0;
      
      public function SimpleButton(param1:BitmapData = null)
      {
         super();
         addChild(_mask);
         addChild(_bitmap);
         this.buttonMode = true;
         if(param1 != null)
         {
            texture = param1;
         }
         enabled = true;
      }
      
      protected function initEvent() : void
      {
         this.addEventListener("click",__onEventAction);
         this.addEventListener("doubleClick",__onEventAction);
         this.addEventListener("mouseDown",__onEventAction);
         this.addEventListener("mouseUp",__onEventAction);
         this.addEventListener("mouseOver",__onEventAction);
         this.addEventListener("mouseOut",__onEventAction);
      }
      
      protected function removeEvent() : void
      {
         this.removeEventListener("click",__onEventAction);
         this.removeEventListener("doubleClick",__onEventAction);
         this.removeEventListener("mouseDown",__onEventAction);
         this.removeEventListener("mouseUp",__onEventAction);
         this.removeEventListener("mouseOver",__onEventAction);
         this.removeEventListener("mouseOut",__onEventAction);
      }
      
      protected function __onEventAction(param1:MouseEvent) : void
      {
         switch(param1.type)
         {
            case "click":
               click(param1);
               break;
            case "doubleClick":
               doubleClick(param1);
               break;
            case "mouseUp":
               up(param1);
               break;
            case "mouseDown":
               down(param1);
               break;
            case "mouseOut":
               out(param1);
               break;
            case "mouseOver":
               over(param1);
         }
      }
      
      protected function click(param1:MouseEvent) : void
      {
         if(_clickCallBack != null)
         {
            _clickCallBack.call(null,param1);
         }
      }
      
      protected function over(param1:MouseEvent) : void
      {
         playEffect(_overEffect,0,overOffSet,overOffScale,overOffScale,-1);
         if(enabled)
         {
            changTexture(_overTexture);
         }
         if(_overCallBack != null)
         {
            _overCallBack.call(null,param1);
         }
      }
      
      protected function out(param1:MouseEvent) : void
      {
         _isDown = _isDown == 1 ? -1 : 0;
         playEffect(_downEffect,offset,offset,offScale,offScale,_isDown);
         playEffect(_overEffect,0,overOffSet,overOffScale,overOffScale,1);
         changTexture(_outTexture);
         if(onOutCallBack != null)
         {
            onOutCallBack.call(null,param1);
         }
      }
      
      protected function down(param1:MouseEvent) : void
      {
         changTexture(_downTexture);
         _isDown = 1;
         playEffect(_downEffect,offset,offset,offScale,offScale,_isDown);
      }
      
      protected function up(param1:MouseEvent) : void
      {
         if(_overTexture)
         {
            changTexture(_overTexture);
         }
         else
         {
            changTexture(_outTexture);
         }
         _isDown = _isDown == 1 ? -1 : 0;
         playEffect(_downEffect,offset,offset,offScale,offScale,_isDown);
      }
      
      protected function doubleClick(param1:MouseEvent) : void
      {
         if(_doubleCallBack != null)
         {
            _doubleCallBack.call(null,param1);
         }
      }
      
      protected function playEffect(param1:String, param2:int, param3:int, param4:Number, param5:Number, param6:int) : void
      {
         switch(param1)
         {
            case "move":
               this.x += param6 * param2;
               this.y += param6 * param3;
               break;
            case "scale":
               this.scaleX += param6 * param4;
               this.scaleY += param6 * param5;
         }
      }
      
      protected function changTexture(param1:BitmapData) : void
      {
         if(param1)
         {
            if(isOpen || param1 == unEnabledTexture)
            {
               _bitmap.bitmapData = param1;
               pivotX = _pivotX;
               pivotY = _pivotY;
            }
         }
      }
      
      override public function render() : void
      {
         super.render();
         if(validateDic[STYLE])
         {
            if(!_outTexture && this.width > 0 && this.height > 0)
            {
               _outTexture = new BitmapData(this.width,this.height);
               pushDisposeBitmap(_outTexture);
            }
            if(isOpen)
            {
               changTexture(_outTexture);
            }
            else
            {
               changTexture(unEnabledTexture);
            }
            if(_isLight)
            {
               if(_overTexture == null || _srcOverBitmap == null)
               {
                  _overTexture = _outTexture.clone();
                  BitmapUtils.light(_overTexture);
               }
               if(_downTexture == null || _srcDownBitmap == null)
               {
                  _downTexture = _overTexture.clone();
                  BitmapUtils.lightDown(_downTexture);
               }
            }
            rotationImage();
         }
         if(validateDic[IMAGESIZE])
         {
            if(_tWidth > 0 || _tHeight > 0)
            {
               if(scaleGridLeft != 0 || scaleGridRight != 0 || scaleGridBottom != 0 && scaleGridTop != 0)
               {
                  _outTexture = getBitmapData(_srcBitmap);
                  _overTexture = getBitmapData(_srcOverBitmap);
                  _downTexture = getBitmapData(_srcDownBitmap);
                  pushDisposeBitmap(_outTexture);
                  pushDisposeBitmap(_overTexture);
                  pushDisposeBitmap(_downTexture);
                  if(!isOpen)
                  {
                     unEnabledTexture = _outTexture.clone();
                     BitmapUtils.discolor(unEnabledTexture);
                     changTexture(unEnabledTexture);
                  }
                  else
                  {
                     changTexture(_outTexture);
                  }
                  _bitmap.width = _outTexture.width;
               }
               else
               {
                  _bitmap.width = width;
                  _bitmap.height = height;
               }
            }
         }
         if(validateDic[RECT])
         {
            _mask.graphics.clear();
            _mask.graphics.beginFill(16711680,0);
            _mask.graphics.drawRect(0,0,_rect.width,_rect.height);
            _mask.graphics.endFill();
            _mask.x = _rect.x;
            _mask.x = _rect.y;
         }
      }
      
      protected function getBitmapData(param1:BitmapData) : BitmapData
      {
         if(!param1)
         {
            return null;
         }
         if(scaleGridLeft == 0 && scaleGridRight == 0 && (scaleGridTop > 0 || scaleGridBottom > 0))
         {
            return BitmapUtils.getScale9Image(param1,param1.width,height,new Rectangle(0,scaleGridTop,param1.width,scaleGridBottom - scaleGridTop));
         }
         if(scaleGridTop == 0 && scaleGridBottom == 0 && (scaleGridLeft > 0 || scaleGridRight > 0))
         {
            return BitmapUtils.getScale9Image(param1,width,_srcBitmap.height,new Rectangle(scaleGridLeft,0,scaleGridRight - scaleGridLeft,_srcBitmap.height));
         }
         if(scaleGridTop > 0 || scaleGridBottom > 0 || (scaleGridLeft > 0 || scaleGridRight > 0))
         {
            return BitmapUtils.getScale9Image(param1,width,height,new Rectangle(scaleGridLeft,scaleGridTop,scaleGridRight - scaleGridLeft,scaleGridBottom - scaleGridTop));
         }
         return param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeChildren();
         _clickCallBack = null;
         _overCallBack = null;
         _doubleCallBack = null;
         _outCallBack = null;
      }
      
      override public function __onAfterProp() : void
      {
         super.__onAfterProp();
      }
      
      public function get rect() : Rectangle
      {
         if(!_rect)
         {
            return this.getBounds(this);
         }
         return _rect;
      }
      
      public function set rect(param1:Rectangle) : void
      {
         if(_rect == null || !param1.equals(_rect))
         {
            _rect = param1;
            validate(RECT);
         }
      }
      
      public function get enabled() : Boolean
      {
         return _isEnabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(param1 != _isEnabled)
         {
            _isEnabled = param1;
            mouseEnabled = param1;
            isOpen = param1;
            if(!_isEnabled)
            {
               removeEvent();
            }
            else
            {
               initEvent();
            }
         }
         validate(STYLE);
      }
      
      public function get onClickCallBack() : Function
      {
         return _clickCallBack;
      }
      
      public function set onClickCallBack(param1:Function) : void
      {
         _clickCallBack = param1;
      }
      
      public function get doubleCallBack() : Function
      {
         return _doubleCallBack;
      }
      
      public function set doubleCallBack(param1:Function) : void
      {
         _doubleCallBack = param1;
      }
      
      public function get downTexture() : BitmapData
      {
         return _downTexture;
      }
      
      public function set downTexture(param1:BitmapData) : void
      {
         _srcDownBitmap = param1;
         _downTexture = param1;
         pushDisposeBitmap(param1);
      }
      
      public function get texture() : BitmapData
      {
         return _outTexture;
      }
      
      public function set texture(param1:BitmapData) : void
      {
         _srcBitmap = param1;
         _outTexture = param1;
         pushDisposeBitmap(param1);
         validate(STYLE);
         validate(IMAGESIZE);
         _mask.graphics.clear();
      }
      
      public function get overTexture() : BitmapData
      {
         return _overTexture;
      }
      
      public function set overTexture(param1:BitmapData) : void
      {
         _srcOverBitmap = param1;
         _overTexture = param1;
         pushDisposeBitmap(param1);
      }
      
      public function get downEffect() : String
      {
         return _downEffect;
      }
      
      public function set downEffect(param1:String) : void
      {
         _downEffect = param1;
      }
      
      public function get offset() : int
      {
         return _offset;
      }
      
      public function set offset(param1:int) : void
      {
         _offset = param1;
      }
      
      public function get offScale() : Number
      {
         return _offScale;
      }
      
      public function set offScale(param1:Number) : void
      {
         _offScale = param1;
      }
      
      public function get onOverCallBack() : Function
      {
         return _overCallBack;
      }
      
      public function set onOverCallBack(param1:Function) : void
      {
         _overCallBack = param1;
      }
      
      public function get isLight() : Boolean
      {
         return _isLight;
      }
      
      public function set isLight(param1:Boolean) : void
      {
         _isLight = param1;
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
      
      public function get overOffSet() : Number
      {
         return _overOffSet;
      }
      
      public function set overOffSet(param1:Number) : void
      {
         _overOffSet = param1;
      }
      
      public function get overOffScale() : Number
      {
         return _overOffScale;
      }
      
      public function set overOffScale(param1:Number) : void
      {
         _overOffScale = param1;
      }
      
      public function get onOutCallBack() : Function
      {
         return _outCallBack;
      }
      
      public function set onOutCallBack(param1:Function) : void
      {
         _outCallBack = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
         if(!_isOpen)
         {
            if(!unEnabledTexture && _outTexture)
            {
               unEnabledTexture = _outTexture.clone();
               BitmapUtils.discolor(unEnabledTexture);
            }
         }
         validate(STYLE);
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
      
      public function get overEffect() : String
      {
         return _overEffect;
      }
      
      public function set overEffect(param1:String) : void
      {
         _overEffect = param1;
      }
      
      public function get unEnabledTexture() : BitmapData
      {
         return _unEnabledTexture;
      }
      
      public function set unEnabledTexture(param1:BitmapData) : void
      {
         _unEnabledTexture = param1;
         pushDisposeBitmap(param1);
      }
      
      public function get scaleGridTop() : int
      {
         return _scaleGridTop;
      }
      
      public function set scaleGridTop(param1:int) : void
      {
         _scaleGridTop = param1;
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
      
      public function get imageRotationZ() : Number
      {
         return _rotation;
      }
      
      public function set imageRotationZ(param1:Number) : void
      {
         _rotation = param1;
         validate(STYLE);
      }
      
      protected function rotationImage() : void
      {
         if(_bitmap.bitmapData == null)
         {
            return;
         }
         _rotation %= 360;
         var _loc2_:Matrix = _bitmap.transform.matrix;
         var _loc3_:Number = _pivotX * _bitmap.bitmapData.width;
         var _loc1_:Number = _pivotY * _bitmap.bitmapData.height;
         _bitmap.smoothing = true;
         _loc2_.translate(-_loc3_,-_loc1_);
         _loc2_.rotate((_rotation - _lastrotation) * 3.141592653589793 / 180);
         _lastrotation = _rotation;
         _loc2_.translate(_loc3_,_loc1_);
         _bitmap.transform.matrix = _loc2_;
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
   }
}

