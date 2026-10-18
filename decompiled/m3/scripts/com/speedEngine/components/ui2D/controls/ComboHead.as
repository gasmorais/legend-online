package com.speedEngine.components.ui2D.controls
{
   import com.speedEngine.components.ui2D.SimpleButton;
   import com.speedEngine.components.ui2D.SimpleImage;
   import com.speedEngine.components.ui2D.TinyUI;
   import flash.display.BitmapData;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ComboHead extends TinyUI
   {
      
      private var _bg:SimpleImage;
      
      private var _downBtn:SimpleButton;
      
      private var _textField:TextField;
      
      private var _format:TextFormat = new TextFormat();
      
      private var _text:String;
      
      private var _bgWidth:Number;
      
      private var _bgHeight:Number;
      
      public function ComboHead()
      {
         super();
         _bg = new SimpleImage();
         this.addChild(_bg);
         this.buttonMode = true;
      }
      
      private function newButton() : void
      {
         if(_downBtn == null)
         {
            _downBtn = new SimpleButton();
            _downBtn.downEffect = null;
            this.addChild(_downBtn);
         }
      }
      
      public function set textFormat(param1:TextFormat) : void
      {
         _format = param1;
         if(_textField)
         {
            _textField.defaultTextFormat = _format;
            _textField.text = _text;
         }
      }
      
      public function set background(param1:BitmapData) : void
      {
         _bg.texture = param1;
         if(_downBtn)
         {
            _downBtn.x = _bg.width - _bgWidth;
         }
         if(_text != null)
         {
            label = _text;
         }
         _textField.width = _bg.width;
         _textField.height = _bg.height;
      }
      
      public function get background() : BitmapData
      {
         return _bg.texture;
      }
      
      public function get texture() : BitmapData
      {
         if(_downBtn)
         {
            return _downBtn.texture;
         }
         return null;
      }
      
      public function get overTexture() : BitmapData
      {
         if(_downBtn)
         {
            return _downBtn.overTexture;
         }
         return null;
      }
      
      public function get downTexture() : BitmapData
      {
         if(_downBtn)
         {
            return _downBtn.downTexture;
         }
         return null;
      }
      
      public function set texture(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         newButton();
         _bgWidth = param1.width;
         _bgHeight = param1.height;
         _downBtn.texture = param1;
         _downBtn.x = _bg.width - param1.width;
      }
      
      public function set overTexture(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         newButton();
         _downBtn.overTexture = param1;
      }
      
      public function set downTexture(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         newButton();
         _downBtn.downTexture = param1;
      }
      
      public function set label(param1:String) : void
      {
         if(!_textField)
         {
            _textField = new TextField();
            _textField.width = _bg.width;
            _textField.height = _bg.height;
            _textField.mouseEnabled = false;
            _textField.defaultTextFormat = _format;
            this.addChild(_textField);
         }
         _textField.text = param1;
         _text = param1;
      }
      
      public function get label() : String
      {
         if(_textField)
         {
            return _textField.text;
         }
         return null;
      }
      
      public function set scaleGridBottom(param1:int) : void
      {
         if(param1 != 0)
         {
            _bg.scaleGridBottom = param1;
         }
      }
      
      public function set scaleGridRight(param1:int) : void
      {
         if(param1 != 0)
         {
            _bg.scaleGridRight = param1;
         }
      }
      
      public function set scaleGridTop(param1:int) : void
      {
         if(param1 != 0)
         {
            _bg.scaleGridTop = param1;
         }
      }
      
      public function set scaleGridLeft(param1:int) : void
      {
         if(param1 != 0)
         {
            _bg.scaleGridLeft = param1;
         }
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(_bg.width != param1)
         {
            _bg.width = param1;
         }
         validate(STYLE);
      }
      
      override public function set height(param1:Number) : void
      {
         if(_bg.height != param1)
         {
            _bg.height = param1;
         }
         validate(STYLE);
      }
      
      public function get isVisibleTextField() : Boolean
      {
         return _textField.visible;
      }
      
      public function set isVisibleTextField(param1:Boolean) : void
      {
         if(_textField)
         {
            _textField.visible = param1;
         }
      }
      
      override public function render() : void
      {
         if(validateDic[STYLE])
         {
            if(_downBtn)
            {
               _downBtn.x = _bg.width - _downBtn.width - 2;
               _downBtn.y = (_bg.height - _downBtn.height) / 2;
            }
            if(_textField)
            {
               _textField.width = _bg.width;
               _textField.height = _bg.height;
            }
         }
         super.render();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

