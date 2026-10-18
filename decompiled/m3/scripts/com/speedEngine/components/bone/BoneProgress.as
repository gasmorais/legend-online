package com.speedEngine.components.bone
{
   import com.speedEngine.speedBones.display.DisplayObjectContainer;
   import com.speedEngine.speedBones.textures.AtfData;
   import flash.display.BitmapData;
   
   public class BoneProgress extends DisplayObjectContainer
   {
      
      public static const UP_DOWN:int = 1;
      
      public static const LEFT_RIGHT:int = 2;
      
      public static const DOWN_UP:int = 3;
      
      public static const RIGHT_LEFT:int = 4;
      
      public static const SET_ATTRIBUTE:String = "set_attribute";
      
      private var _backGroundImage:BoneImage;
      
      private var _progressImage:BoneImage;
      
      private var _type:int;
      
      private var _value:Number;
      
      private var _maxLen:Number;
      
      private var _progressX:Number;
      
      private var _progressY:Number;
      
      private var _XY:String;
      
      private var _lastXY:int;
      
      private var _WH:String;
      
      private var _XYMARK:int;
      
      private var _setMaxLen:Boolean;
      
      private var _backGroundTexture:AtfData;
      
      private var _progressTexture:AtfData;
      
      private var _backGroundBitmap:BitmapData;
      
      private var _progressBitmap:BitmapData;
      
      public function BoneProgress()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _maxLen = 0;
         _value = 1;
         _progressX = _progressY = 0;
         type = 2;
         _backGroundImage = new BoneImage();
         _progressImage = new BoneImage();
         addChild(_backGroundImage);
         addChild(_progressImage);
         pushRenderFunction("set_attribute",setAttribute);
      }
      
      private function setAttribute() : void
      {
         _progressImage.x = _progressX;
         _progressImage.y = _progressY;
         switch(_type - 1)
         {
            case 0:
            case 2:
               if(_setMaxLen && _maxLen > 0 && _backGroundImage)
               {
                  _backGroundImage.height = _maxLen;
               }
               if(!_setMaxLen)
               {
                  _maxLen = _progressImage.height;
               }
               _lastXY = _progressY;
               break;
            case 1:
            case 3:
               if(_setMaxLen && _maxLen > 0 && _backGroundImage)
               {
                  _backGroundImage.width = _maxLen;
               }
               if(!_setMaxLen)
               {
                  _maxLen = _progressImage.width;
               }
               _lastXY = _progressX;
               break;
            default:
               throw "type error";
         }
      }
      
      public function setProgress(param1:Number, param2:Number, param3:int = 0) : void
      {
         if(param2 == 0 && param1 == 0)
         {
            value = 1;
         }
         else if(param2 == 0)
         {
            value = 0;
         }
         else
         {
            value = param1 / param2;
         }
      }
      
      override protected function update() : void
      {
         var _loc1_:Number = NaN;
         super.update();
         if(_progressImage)
         {
            _loc1_ = _value * _maxLen;
            _progressImage[_WH] = _loc1_;
            _progressImage[_XY] = _lastXY + (_maxLen - _loc1_) * _XYMARK;
         }
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set value(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw "error";
         }
         _value = param1;
      }
      
      public function get maxLen() : Number
      {
         return _maxLen;
      }
      
      public function set maxLen(param1:Number) : void
      {
         if(_maxLen == param1)
         {
            return;
         }
         _maxLen = param1;
         _setMaxLen = true;
         validate("set_attribute");
      }
      
      public function get progressX() : Number
      {
         return _progressX;
      }
      
      public function set progressX(param1:Number) : void
      {
         _progressX = param1;
         validate("set_attribute");
      }
      
      public function get progressY() : Number
      {
         return _progressY;
      }
      
      public function set progressY(param1:Number) : void
      {
         _progressY = param1;
         validate("set_attribute");
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         switch(_type - 1)
         {
            case 0:
               _XYMARK = 0;
               _XY = "y";
               _WH = "height";
               break;
            case 1:
               _XYMARK = 0;
               _XY = "x";
               _WH = "width";
               break;
            case 2:
               _XYMARK = 1;
               _XY = "y";
               _WH = "height";
               break;
            case 3:
               _XYMARK = 1;
               _XY = "x";
               _WH = "width";
         }
         validate("set_attribute");
      }
      
      public function get backGroundImage() : BoneImage
      {
         return _backGroundImage;
      }
      
      public function set backGroundImage(param1:BoneImage) : void
      {
         if(_backGroundImage && _backGroundImage.public::parent == this)
         {
            removeChild(_backGroundImage);
         }
         _backGroundImage = param1;
         addChild(_backGroundImage);
         validate("set_attribute");
      }
      
      public function get progressImage() : BoneImage
      {
         return _progressImage;
      }
      
      public function set progressImage(param1:BoneImage) : void
      {
         if(_progressImage && _progressImage.public::parent == this)
         {
            removeChild(_progressImage);
         }
         _progressImage = param1;
         addChild(_progressImage);
         validate("set_attribute");
      }
      
      public function get background() : AtfData
      {
         return _backGroundTexture;
      }
      
      public function set background(param1:AtfData) : void
      {
         _backGroundTexture = param1;
         _backGroundImage.texture = param1;
         validate("set_attribute");
      }
      
      public function get progressTexture() : AtfData
      {
         return _progressTexture;
      }
      
      public function set progressTexture(param1:AtfData) : void
      {
         _progressTexture = param1;
         _progressImage.texture = param1;
         validate("set_attribute");
      }
      
      public function get backGroundBitmap() : BitmapData
      {
         return _backGroundBitmap;
      }
      
      public function set backGroundBitmap(param1:BitmapData) : void
      {
         _backGroundBitmap = param1;
         _backGroundImage.bitmapData = param1;
         validate("set_attribute");
      }
      
      public function get progressBitmap() : BitmapData
      {
         return _progressBitmap;
      }
      
      public function set progressBitmap(param1:BitmapData) : void
      {
         _progressBitmap = param1;
         _progressImage.bitmapData = param1;
         validate("set_attribute");
      }
   }
}

