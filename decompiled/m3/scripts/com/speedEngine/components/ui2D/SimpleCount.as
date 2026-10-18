package com.speedEngine.components.ui2D
{
   import com.speedEngine.game.Director;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFormat;
   
   public class SimpleCount extends TinyUI
   {
      
      private var _background:Bitmap;
      
      private var _leftButton:LabelButton;
      
      private var _rightButton:LabelButton;
      
      private var _textField:SimpleTextField;
      
      private var _textFormat:TextFormat;
      
      private var _currNum:int = 0;
      
      private var _step:int = 1;
      
      private var _numMax:int = 2147483647;
      
      private var _numMin:int = 0;
      
      private var _textWidth:Number = 80;
      
      private var _textHeight:Number = 25;
      
      private var _changFunction:Function;
      
      public function SimpleCount()
      {
         super();
         _textField = new SimpleTextField();
         _textField.isInput = true;
         _textFormat = new TextFormat(null,14);
         _textFormat.align = "center";
         _textField.restrict = "[0-9,-,.]";
         _textField.inputFunciotn = inputFunction;
         addChild(_textField);
         newPreButton();
         newNextButton();
         initEvent();
      }
      
      private function initEvent() : void
      {
         if(_textField)
         {
            Director.instance.addEvent(_textField,"focusOut",__onFocusOut);
         }
      }
      
      private function removeEvent() : void
      {
         if(_textField)
         {
            Director.instance.removeEvent(_textField,"focusOut",__onFocusOut);
         }
      }
      
      private function __onFocusOut(param1:FocusEvent) : void
      {
         var _loc2_:Number = Number(_textField.text);
         if(_loc2_ > _numMax)
         {
            _loc2_ = _numMax;
         }
         else if(_loc2_ < _numMin)
         {
            _loc2_ = _numMin;
         }
         _textField.text = _loc2_ + "";
         currNum = _loc2_;
      }
      
      private function inputFunction(param1:TextEvent) : void
      {
         var _loc2_:String = _textField.text;
         if(_textField.selectedText != "")
         {
            _loc2_ = _loc2_.replace(_textField.selectedText,param1.text);
         }
         else
         {
            _loc2_ += param1.text;
         }
         var _loc3_:Number = Number(_loc2_);
         if(_loc3_ > _numMax)
         {
            param1.preventDefault();
            param1.stopPropagation();
            _textField.text = _numMax + "";
         }
         else if(_loc3_ < _numMin)
         {
            param1.preventDefault();
            param1.stopPropagation();
            _textField.text = _numMin + "";
         }
      }
      
      public function set restrict(param1:String) : void
      {
         if(_textField)
         {
            _textField.restrict = param1;
         }
      }
      
      public function get restrict() : String
      {
         if(_textField)
         {
            return _textField.restrict;
         }
         return "";
      }
      
      public function get maxChars() : int
      {
         if(_textField != null)
         {
            return _textField.maxChars;
         }
         return 0;
      }
      
      public function set maxChars(param1:int) : void
      {
         if(_textField != null)
         {
            _textField.maxChars = param1;
         }
      }
      
      public function set texture(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!_background)
         {
            _background = new Bitmap(param1);
         }
         _background.bitmapData = param1;
         pushDisposeBitmap(param1);
         addChildAt(_background,0);
      }
      
      public function get texture() : BitmapData
      {
         if(_background)
         {
            return _background.bitmapData;
         }
         return null;
      }
      
      private function newPreButton() : void
      {
         _leftButton = new LabelButton();
         _leftButton.downEffect = "";
         addChild(_leftButton);
      }
      
      private function newNextButton() : void
      {
         _rightButton = new LabelButton();
         _rightButton.downEffect = "";
         addChild(_rightButton);
      }
      
      public function set leftText(param1:String) : void
      {
         if(_leftButton == null)
         {
            newPreButton();
         }
         _leftButton.text = param1;
         validate(STYLE);
      }
      
      public function get leftText() : String
      {
         if(_leftButton)
         {
            return _leftButton.text;
         }
         return null;
      }
      
      public function get rightText() : String
      {
         if(_rightButton)
         {
            return _rightButton.text;
         }
         return null;
      }
      
      public function set rightText(param1:String) : void
      {
         if(_rightButton == null)
         {
            newNextButton();
         }
         _rightButton.text = param1;
         validate(STYLE);
      }
      
      public function set leftTexture(param1:BitmapData) : void
      {
         if(_leftButton == null)
         {
            newPreButton();
         }
         _leftButton.texture = param1;
         validate(STYLE);
      }
      
      public function get rightTexture() : BitmapData
      {
         if(_rightButton)
         {
            return _rightButton.texture;
         }
         return null;
      }
      
      public function get leftTexture() : BitmapData
      {
         if(_leftButton)
         {
            return _leftButton.texture;
         }
         return null;
      }
      
      public function get leftOverTexture() : BitmapData
      {
         if(_leftButton)
         {
            return _leftButton.overTexture;
         }
         return null;
      }
      
      public function get leftDownTexture() : BitmapData
      {
         if(_leftButton)
         {
            return _leftButton.downTexture;
         }
         return null;
      }
      
      public function get rightOverTexture() : BitmapData
      {
         if(_rightButton)
         {
            return _rightButton.overTexture;
         }
         return null;
      }
      
      public function get rightDownTexture() : BitmapData
      {
         if(_rightButton)
         {
            return _rightButton.downTexture;
         }
         return null;
      }
      
      public function set leftOverTexture(param1:BitmapData) : void
      {
         if(_leftButton == null)
         {
            newPreButton();
         }
         _leftButton.overTexture = param1;
         validate(STYLE);
      }
      
      public function set leftDownTexture(param1:BitmapData) : void
      {
         if(_leftButton == null)
         {
            newPreButton();
         }
         _leftButton.downTexture = param1;
         validate(STYLE);
      }
      
      public function set rightTexture(param1:BitmapData) : void
      {
         if(_rightButton == null)
         {
            newNextButton();
         }
         _rightButton.texture = param1;
         validate(STYLE);
      }
      
      public function set rightOverTexture(param1:BitmapData) : void
      {
         if(_rightButton == null)
         {
            newNextButton();
         }
         _rightButton.overTexture = param1;
         validate(STYLE);
      }
      
      public function set rightDownTexture(param1:BitmapData) : void
      {
         if(_rightButton == null)
         {
            newNextButton();
         }
         _rightButton.downTexture = param1;
         validate(STYLE);
      }
      
      override public function render() : void
      {
         _leftButton.x = 0;
         _leftButton.y = 0;
         _textField.textFormat = _textFormat;
         _textField.text = _currNum.toString();
         _textField.x = _leftButton.width;
         _textField.y = 0;
         _textField.width = _textWidth;
         _textField.height = _textHeight;
         _rightButton.x = _textField.x + _textField.width;
         _rightButton.y = 0;
         if(_background)
         {
            _leftButton.y = (_background.height - _leftButton.height) / 2;
            _textField.y = (_background.height - _textField.height) / 2;
            _rightButton.y = (_background.height - _rightButton.height) / 2;
         }
         _leftButton.onClickCallBack = onPreHandle;
         _rightButton.onClickCallBack = onNextHandle;
      }
      
      override public function __onAfterProp() : void
      {
      }
      
      private function onNextHandle(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(_textField.text);
         if(_loc2_ < _numMax)
         {
            currNum += _step;
         }
      }
      
      private function onPreHandle(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(_textField.text);
         if(_loc2_ > _numMin)
         {
            currNum -= _step;
         }
      }
      
      public function get currNum() : int
      {
         return _currNum;
      }
      
      public function set currNum(param1:int) : void
      {
         if(param1 >= _numMin && param1 <= _numMax)
         {
            if(_currNum != param1)
            {
               _currNum = param1;
               _textField.text = _currNum.toString();
               if(_changFunction != null)
               {
                  if(_changFunction.length == 1)
                  {
                     _changFunction.call(null,this);
                  }
                  else
                  {
                     _changFunction.call(null);
                  }
               }
            }
         }
         if(param1 >= _numMax)
         {
            _rightButton.enabled = false;
         }
         else
         {
            _rightButton.enabled = true;
         }
         if(param1 <= _numMin)
         {
            _leftButton.enabled = false;
         }
         else
         {
            _leftButton.enabled = true;
         }
      }
      
      public function set font(param1:String) : void
      {
         _textFormat.font = param1;
         validate(STYLE);
      }
      
      public function get font() : String
      {
         return _textFormat.font;
      }
      
      public function set size(param1:Object) : void
      {
         _textFormat.size = param1;
         validate(STYLE);
      }
      
      public function get size() : Object
      {
         return _textFormat.size;
      }
      
      public function set color(param1:Object) : void
      {
         _textFormat.color = param1;
         validate(STYLE);
      }
      
      public function get color() : Object
      {
         return _textFormat.color;
      }
      
      public function set bold(param1:Object) : void
      {
         _textFormat.bold = param1;
         validate(STYLE);
      }
      
      public function get bold() : Object
      {
         return _textFormat.bold;
      }
      
      public function get step() : int
      {
         return _step;
      }
      
      public function set step(param1:int) : void
      {
         _step = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_textField)
         {
            _textField.dispose();
            if(_textField.parent == this)
            {
               removeChild(_textField);
            }
         }
         if(_leftButton)
         {
            _leftButton.dispose();
            if(_leftButton.parent == this)
            {
               removeChild(_leftButton);
            }
         }
         if(_rightButton)
         {
            _rightButton.dispose();
            if(_rightButton.parent == this)
            {
               removeChild(_rightButton);
            }
         }
         super.dispose();
         _background = null;
         _textField = null;
         _textFormat = null;
      }
      
      public function get textWidth() : Number
      {
         return _textWidth;
      }
      
      public function set textWidth(param1:Number) : void
      {
         if(_textWidth == param1)
         {
            return;
         }
         _textWidth = param1;
         if(_textField != null)
         {
            width -= _textField.width - _textWidth;
            _textField.width = _textWidth;
         }
         validate(STYLE);
      }
      
      public function get textHeight() : Number
      {
         return _textHeight;
      }
      
      public function set textHeight(param1:Number) : void
      {
         if(_textHeight == param1)
         {
            return;
         }
         _textHeight = param1;
         if(_textField != null)
         {
            height -= _textField.height - _textHeight;
            _textField.height = _textHeight;
         }
         validate(STYLE);
      }
      
      public function get numMax() : int
      {
         return _numMax;
      }
      
      public function set numMax(param1:int) : void
      {
         _numMax = param1;
      }
      
      public function get numMin() : int
      {
         return _numMin;
      }
      
      public function set numMin(param1:int) : void
      {
         _numMin = param1;
      }
      
      public function get changFunction() : Function
      {
         return _changFunction;
      }
      
      public function set changFunction(param1:Function) : void
      {
         _changFunction = param1;
      }
   }
}

