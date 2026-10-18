package com.speedEngine.components.ui2D
{
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class LabelButton extends SimpleButton
   {
      
      protected var _textField:SimpleTextField;
      
      protected var _overTextField:SimpleTextField;
      
      protected var _outTextField:SimpleTextField;
      
      protected var _downTextField:SimpleTextField;
      
      private var _textX:int = -2147483648;
      
      private var _textY:int = -2147483648;
      
      private var _removeTinyUIList:Array = [];
      
      private var _lastTextField:SimpleTextField;
      
      public function LabelButton(param1:BitmapData = null)
      {
         super(param1);
         _outTextField = new SimpleTextField();
         _outTextField.mouseEnabled = false;
         _outTextField.autoSize = "left";
         _outTextField.align = "center";
         settextField(_outTextField);
      }
      
      protected function layout() : void
      {
         if(_textField.parent)
         {
            removeChild(_textField);
         }
         if(_textField.text == "")
         {
            return;
         }
         if(_textX != -2147483648)
         {
            _textField.x = _textX;
         }
         else
         {
            _textField.x = this._bitmap.width - _textField.width + 2 >> 1;
         }
         if(_textY != -2147483648)
         {
            _textField.y = _textY;
         }
         else
         {
            _textField.y = this._bitmap.height - _textField.height >> 1;
         }
         addChild(_textField);
      }
      
      override public function set isOpen(param1:Boolean) : void
      {
         super.isOpen = param1;
         if(_textField)
         {
            if(!isOpen)
            {
               _textField.filters = [disColorFilter()];
            }
            else
            {
               _textField.filters = null;
            }
         }
      }
      
      override protected function down(param1:MouseEvent) : void
      {
         super.down(param1);
         _lastTextField = _textField;
         settextField(_downTextField);
      }
      
      override protected function over(param1:MouseEvent) : void
      {
         super.over(param1);
         settextField(_overTextField);
      }
      
      override protected function out(param1:MouseEvent) : void
      {
         super.out(param1);
         settextField(_outTextField);
      }
      
      override protected function up(param1:MouseEvent) : void
      {
         super.up(param1);
         if(_lastTextField != null)
         {
            settextField(_lastTextField);
         }
      }
      
      public function disColorFilter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]);
      }
      
      public function set text(param1:String) : void
      {
         _textField.text = param1;
         if(param1 == null || param1 == "")
         {
            if(_textField.parent)
            {
               removeChild(_textField);
            }
            return;
         }
         if(!texture)
         {
            texture = new BitmapData(_textField.width,_textField.height,true,16777215);
         }
         validate(STYLE);
      }
      
      override public function render() : void
      {
         super.render();
         if(validateDic[STYLE] || validateDic[IMAGESIZE])
         {
            layout();
         }
      }
      
      override public function __onAfterProp() : void
      {
      }
      
      override public function dispose() : void
      {
         if(_outTextField && _outTextField.parent != this)
         {
            _outTextField.dispose();
         }
         if(_overTextField && _overTextField.parent != this)
         {
            _overTextField.dispose();
         }
         if(_downTextField && _downTextField.parent != this)
         {
            _downTextField.dispose();
         }
         super.dispose();
      }
      
      public function get text() : String
      {
         return _textField.text;
      }
      
      public function set fontSize(param1:int) : void
      {
         _textField.size = param1;
         validate(STYLE);
      }
      
      public function get fontSize() : int
      {
         return _textField.size;
      }
      
      public function set fontName(param1:String) : void
      {
         _textField.font = param1;
      }
      
      public function get fontName() : String
      {
         return _textField.font;
      }
      
      public function set fontColor(param1:uint) : void
      {
         _textField.fontColor = param1;
      }
      
      public function get fontColor() : uint
      {
         return _textField.fontColor;
      }
      
      public function get textX() : int
      {
         return _textX;
      }
      
      public function set textX(param1:int) : void
      {
         _textX = param1;
      }
      
      public function get textY() : int
      {
         return _textY;
      }
      
      public function set textY(param1:int) : void
      {
         _textY = param1;
      }
      
      private function settextField(param1:SimpleTextField) : void
      {
         if(param1 == null || param1 == _textField)
         {
            return;
         }
         if(_textField && _textField.parent == this)
         {
            removeChild(_textField);
         }
         _textField = param1;
         addChild(_textField);
         validate(STYLE);
      }
      
      public function get downTextField() : SimpleTextField
      {
         return _downTextField;
      }
      
      public function set downTextField(param1:SimpleTextField) : void
      {
         _downTextField = param1;
      }
      
      public function get outTextField() : SimpleTextField
      {
         return _outTextField;
      }
      
      public function set outTextField(param1:SimpleTextField) : void
      {
         _outTextField = param1;
         settextField(_outTextField);
      }
      
      public function get overTextField() : SimpleTextField
      {
         return _overTextField;
      }
      
      public function set overTextField(param1:SimpleTextField) : void
      {
         _overTextField = param1;
      }
      
      public function get textField() : SimpleTextField
      {
         return _textField;
      }
      
      public function get openStroke() : Boolean
      {
         return _textField.openStroke;
      }
      
      public function set openStroke(param1:Boolean) : void
      {
         _textField.openStroke = param1;
      }
      
      public function get strokeColor() : uint
      {
         return _textField.strokeColor;
      }
      
      public function set strokeColor(param1:uint) : void
      {
         _textField.strokeColor = param1;
      }
      
      public function get strokeSize() : int
      {
         return _textField.strokeSize;
      }
      
      public function set strokeSize(param1:int) : void
      {
         _textField.strokeSize = param1;
      }
      
      public function get isbold() : Boolean
      {
         return _textField.isbold;
      }
      
      public function set isbold(param1:Boolean) : void
      {
         _textField.isbold = param1;
      }
   }
}

