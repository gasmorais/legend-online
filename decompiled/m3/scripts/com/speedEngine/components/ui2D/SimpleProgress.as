package com.speedEngine.components.ui2D
{
   import com.speedEngine.game.view.BaseSprite;
   import flash.display.BitmapData;
   import flash.text.TextFormat;
   
   public class SimpleProgress extends TinyUI
   {
      
      public static const UP_DOWN:int = 1;
      
      public static const LEFT_RIGHT:int = 2;
      
      public static const DOWN_UP:int = 3;
      
      public static const RIGHT_LEFT:int = 4;
      
      private var _backgroundBmd:BitmapData;
      
      private var _progressBmd:BitmapData;
      
      private var _background:SimpleImage;
      
      private var _levelProgress:SimpleImage = new SimpleImage();
      
      private var _progressNumberTxt:SimpleNumber;
      
      private var _progressTxt:SimpleTextField;
      
      private var _textFormat:TextFormat;
      
      private var _isTextField:Boolean = true;
      
      private var _progressNumberOffset:int;
      
      private var _value:Number = 0;
      
      private var _max:Number = 100;
      
      private var _rect:BaseSprite;
      
      private var _container:TinyUI;
      
      private var _rectMaxWidth:Number;
      
      private var _rectMaxHeight:Number;
      
      private var _maskType:int = 4;
      
      private var _maskSide:String = "scaleX";
      
      private var _maskSign:int = 1;
      
      private var _type:int = 0;
      
      public function SimpleProgress()
      {
         super();
         _container = new TinyUI();
         _container.addChild(_levelProgress);
         addChild(_container);
      }
      
      private function newNumber() : void
      {
         _progressNumberTxt = new SimpleNumber();
         _progressNumberTxt.x = 205;
         _progressNumberTxt.align = "center";
         _progressNumberTxt.gap = _progressNumberOffset;
         _progressNumberTxt.y = _container.y;
         _progressNumberTxt.x = _container.x;
         addChild(_progressNumberTxt);
      }
      
      private function newTextField() : void
      {
         _progressTxt = new SimpleTextField();
         if(_textFormat == null)
         {
            _textFormat = new TextFormat();
         }
         _progressTxt.width = _levelProgress.width;
         _progressTxt.height = _levelProgress.height;
         _progressTxt.x = _container.x;
         _progressTxt.y = _container.y;
         _progressTxt.textFormat = _textFormat;
         _progressTxt.align = "center";
         addChild(_progressTxt);
      }
      
      private function setText(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         if(!_isTextField || _progressNumberTxt)
         {
            _progressNumberTxt.text = param1;
         }
         else
         {
            if(_progressTxt == null)
            {
               newTextField();
            }
            _progressTxt.text = param1;
         }
      }
      
      public function set textPosY(param1:Number) : void
      {
         if(_progressTxt)
         {
            _progressTxt.y = param1;
         }
         if(_progressNumberTxt)
         {
            _progressNumberTxt.y = param1;
         }
      }
      
      public function set textPosX(param1:Number) : void
      {
         if(_progressTxt)
         {
            _progressTxt.x = param1;
         }
         if(_progressNumberTxt)
         {
            _progressNumberTxt.x = param1;
         }
      }
      
      public function get isTextField() : Boolean
      {
         return _isTextField;
      }
      
      public function set isTextField(param1:Boolean) : void
      {
         _isTextField = param1;
      }
      
      public function get progressY() : Number
      {
         return _container.y;
      }
      
      public function set progressY(param1:Number) : void
      {
         _container.y = param1;
         if(_progressNumberTxt)
         {
            _progressNumberTxt.y = param1 + 2;
         }
      }
      
      public function get progressX() : Number
      {
         return _container.x;
      }
      
      public function set progressX(param1:Number) : void
      {
         _container.x = param1;
         if(_progressNumberTxt)
         {
            _progressNumberTxt.x = param1;
         }
      }
      
      public function get background() : BitmapData
      {
         return _backgroundBmd;
      }
      
      public function set background(param1:BitmapData) : void
      {
         if(_backgroundBmd == param1)
         {
            return;
         }
         _backgroundBmd = param1;
         if(!_background)
         {
            _background = new SimpleImage();
            addChildAt(_background,0);
         }
         _background.texture = _backgroundBmd;
         pushDisposeBitmap(param1);
      }
      
      public function get progressTexture() : BitmapData
      {
         return _progressBmd;
      }
      
      public function set progressTexture(param1:BitmapData) : void
      {
         _progressBmd = param1;
         _levelProgress.texture = _progressBmd;
         _rectMaxHeight = param1.height;
         _rectMaxWidth = param1.width;
         if(_progressNumberTxt)
         {
            _progressNumberTxt.width = param1.width;
         }
         pushDisposeBitmap(param1);
      }
      
      public function setProgress(param1:Number, param2:Number, param3:int = 0) : void
      {
         var _loc4_:String = null;
         if(_value != param1 || _max != param2)
         {
            _value = param1;
            _max = param2;
            if(_rect != null)
            {
               _rect[_maskSide] = _maskSign * _value / _max;
            }
            switch(param3 - 1)
            {
               case 0:
                  _loc4_ = (_value / _max * 100).toFixed(1);
                  break;
               case 1:
                  _loc4_ = param1 + "/" + param2;
            }
            setText(_loc4_);
         }
      }
      
      public function set numResPath(param1:String) : void
      {
         newNumber();
         _progressNumberTxt.resPath = param1;
      }
      
      public function get progressNumberOffset() : int
      {
         return _progressNumberOffset;
      }
      
      public function set progressNumberOffset(param1:int) : void
      {
         _progressNumberOffset = param1;
         if(_progressNumberTxt)
         {
            _progressNumberTxt.gap = param1;
         }
      }
      
      public function set font(param1:String) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.font = param1;
      }
      
      public function set size(param1:Object) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.size = param1;
      }
      
      public function set color(param1:Object) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.color = param1;
      }
      
      public function set bold(param1:Object) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.bold = param1;
      }
      
      override public function __onAfterProp() : void
      {
         if(_rect)
         {
            this.removeChild(_rect);
         }
         _rect = new BaseSprite();
         _rect.graphics.beginFill(0);
         _rect.graphics.drawRect(0,0,_rectMaxWidth,_rectMaxHeight);
         _rect.graphics.endFill();
         switch(_maskType - 1)
         {
            case 0:
               initMaskScale(false);
               _rect.y = _rectMaxHeight;
               _maskSign = -1;
               break;
            case 1:
               _rect.x = _rectMaxWidth;
               initMaskScale(true);
               _maskSign = -1;
               break;
            case 2:
               initMaskScale(false);
               _maskSign = 1;
               break;
            case 3:
               _maskSign = 1;
               initMaskScale(true);
         }
         _rect.mouseEnabled = false;
         _container.addChild(_rect);
         _container.mask = _rect;
         if(_progressNumberTxt)
         {
            _progressNumberTxt.width = _rectMaxWidth;
         }
      }
      
      private function initMaskScale(param1:Boolean) : void
      {
         if(param1)
         {
            _rect.scaleX = 0;
            _rect.scaleY = 1;
            _maskSide = "scaleX";
         }
         else
         {
            _rect.scaleX = 1;
            _rect.scaleY = 0;
            _maskSide = "scaleY";
         }
      }
      
      public function get value() : Number
      {
         return _value / _max;
      }
      
      public function set value(param1:Number) : void
      {
         var _loc2_:Number = param1 * _max;
         if(_value != _loc2_)
         {
            setProgress(_loc2_,_max,_type);
         }
      }
      
      override public function dispose() : void
      {
         if(_rect)
         {
            _rect.removeChildren();
            _rect = null;
         }
         super.dispose();
         removeChildren();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get maskType() : int
      {
         return _maskType;
      }
      
      public function set maskType(param1:int) : void
      {
         if(_maskType == param1)
         {
            return;
         }
         _maskType = param1;
      }
      
      public function get scaleGridBottom() : int
      {
         if(!_background)
         {
            return 0;
         }
         return _background.scaleGridBottom;
      }
      
      public function set scaleGridBottom(param1:int) : void
      {
         if(!_background)
         {
            return;
         }
         _background.scaleGridBottom = param1;
      }
      
      public function get scaleGridLeft() : int
      {
         if(!_background)
         {
            return 0;
         }
         return _background.scaleGridLeft;
      }
      
      public function set scaleGridLeft(param1:int) : void
      {
         if(!_background)
         {
            return;
         }
         _background.scaleGridLeft = param1;
      }
      
      public function get scaleGridRight() : int
      {
         if(!_background)
         {
            return 0;
         }
         return _background.scaleGridRight;
      }
      
      public function set scaleGridRight(param1:int) : void
      {
         if(!_background)
         {
            return;
         }
         _background.scaleGridRight = param1;
      }
      
      public function get scaleGridTop() : int
      {
         if(!_background)
         {
            return 0;
         }
         return _background.scaleGridTop;
      }
      
      public function set scaleGridTop(param1:int) : void
      {
         if(!_background)
         {
            return;
         }
         _background.scaleGridTop = param1;
      }
      
      public function get bgWidth() : int
      {
         if(!_background)
         {
            return 0;
         }
         return _background.width;
      }
      
      public function set bgWidth(param1:int) : void
      {
         if(!_background)
         {
            return;
         }
         _background.width = param1;
      }
      
      public function get bgHeight() : int
      {
         if(!_background)
         {
            return 0;
         }
         return _background.height;
      }
      
      public function set bgHeight(param1:int) : void
      {
         if(!_background)
         {
            return;
         }
         _background.height = param1;
      }
      
      public function get progressWidth() : int
      {
         return _levelProgress.width;
      }
      
      public function set progressWidth(param1:int) : void
      {
         _levelProgress.width = param1;
      }
      
      public function get progressHeight() : int
      {
         return _levelProgress.height;
      }
      
      public function set progressHeight(param1:int) : void
      {
         _levelProgress.height = param1;
      }
   }
}

