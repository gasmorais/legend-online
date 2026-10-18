package com.speedEngine.components.ui2D
{
   import com.speedEngine.utils.ObjectUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.filters.ConvolutionFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientBevelFilter;
   import flash.geom.Matrix;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class SimpleTextField extends TinyUI
   {
      
      public static const FILTER:String = "filter";
      
      public static const FORMAT:String = "format";
      
      private var _textStr:String = "";
      
      private var _textField:TextField;
      
      private var _textFormat:TextFormat;
      
      private var _maskTextField:TextField;
      
      private var _openStroke:Boolean = false;
      
      private var _strokeColor:uint = 0;
      
      private var _strokeSize:int = 10;
      
      private var _strokeBmd:BitmapData;
      
      private var _strokeBmp:Bitmap = null;
      
      private var _isGradients:Boolean = false;
      
      private var _gradientColor:Array;
      
      private var _gradientSize:int = 1;
      
      private var _isColorSlow:Boolean = false;
      
      private var _slowColors:Array;
      
      private var _slowRoation:Array;
      
      private var _slowAlphas:Array;
      
      private var _sprite:Sprite;
      
      private var _bitmap:Bitmap;
      
      private var _slowAngle:int;
      
      private var _isConvolution:Boolean = false;
      
      private var _inputFunciotn:Function;
      
      private var _textLinkFunction:Function;
      
      private var _filter:Array;
      
      private var _filterNum:Array;
      
      private var _shape:Shape;
      
      public function SimpleTextField(param1:TextFormat = null)
      {
         var format:TextFormat = param1;
         super();
         _filter = [];
         _filterNum = [];
         _slowColors = [0,16777215];
         _slowRoation = [0,255];
         _slowAlphas = [0,1];
         _textField = new TextField();
         _maskTextField = new TextField();
         _sprite = new Sprite();
         _shape = new Shape();
         _bitmap = new Bitmap();
         _textField.width = 100;
         _textField.height = 25;
         if(format)
         {
            _textFormat = format;
         }
         else
         {
            _textFormat = new TextFormat("宋体",12,0,false,null,null,null,null,"left");
         }
         _textField.defaultTextFormat = _textFormat;
         addChild(_textField);
         _textField.addEventListener("change",function(param1:Event):void
         {
            param1.stopImmediatePropagation();
            dispatchEvent(new Event("change",true));
         });
         _textField.addEventListener("textInput",__onTextInput);
         _textField.addEventListener("link",_textLink);
         mouseEnabled = false;
      }
      
      protected function _textLink(param1:TextEvent) : void
      {
         if(_textLinkFunction != null)
         {
            _textLinkFunction.call(null,param1);
         }
      }
      
      override public function set mouseEnabled(param1:Boolean) : void
      {
         super.mouseEnabled = param1;
         _textField.mouseEnabled = param1;
      }
      
      public function getTextCount(param1:String) : uint
      {
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc4_:uint = 0;
         var _loc3_:RegExp = /^[{invalid_utf8=228}{invalid_utf8=184}?-龥豈-鶴]+$/;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = param1.charAt(_loc5_);
            if(_loc3_.test(_loc2_))
            {
               _loc4_ += 2;
            }
            else
            {
               _loc4_ += 1;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      protected function __onTextInput(param1:TextEvent) : void
      {
         var _loc2_:int = int(getTextCount(_textField.text + param1.text));
         if(_textField.maxChars > 0 && _loc2_ > _textField.maxChars)
         {
            param1.preventDefault();
            param1.stopPropagation();
         }
         else if(_inputFunciotn != null)
         {
            _inputFunciotn.call(null,param1);
         }
      }
      
      public function insterText(param1:String) : void
      {
         var _loc3_:int = _textField.caretIndex;
         if(_loc3_ == _textField.text.length)
         {
            appendText(param1);
            return;
         }
         var _loc2_:String = _textField.text;
         text = _loc2_.substr(0,_loc3_) + param1 + _loc2_.substring(_loc3_);
         _textField.setSelection(_loc3_ + param1.length,_loc3_ + param1.length);
      }
      
      public function moveTextMiddle() : void
      {
         _textField.height = _textField.textHeight + 4;
         _textField.x = (this.width - _textField.textWidth) / 2;
         _textField.y = (this.height - _textField.textHeight) / 2;
      }
      
      private function refreshStroke() : void
      {
      }
      
      public function returnFilter(param1:int) : Object
      {
         _filterNum.push(param1);
         switch(param1 - 1)
         {
            case 0:
               return createGlowFilter();
            case 1:
               return createGradientBevelFilter();
            case 2:
               return createConvolutionFilter();
            default:
               return null;
         }
      }
      
      protected function createGlowFilter() : GlowFilter
      {
         var _loc1_:GlowFilter = new GlowFilter(0,1,1.5,1.5,10,1);
         _loc1_.color = _strokeColor;
         _loc1_.strength = _strokeSize;
         return _loc1_;
      }
      
      protected function createConvolutionFilter() : ConvolutionFilter
      {
         var _loc1_:Array = [0,1,0,1,1,1,0,1,0];
         return new ConvolutionFilter(3,3,_loc1_,3);
      }
      
      protected function createGradientBevelFilter() : GradientBevelFilter
      {
         var _loc1_:GradientBevelFilter = new GradientBevelFilter();
         _loc1_.colors = _gradientColor;
         _loc1_.alphas = [0,1,0,1,0];
         _loc1_.ratios = [0,24,128,232,255];
         _loc1_.blurX = 2;
         _loc1_.blurY = 2;
         _loc1_.quality = 2;
         _loc1_.type = "full";
         _loc1_.strength = _gradientSize;
         _loc1_.knockout = true;
         _loc1_.distance = 1;
         _loc1_.angle = 225;
         return _loc1_;
      }
      
      private function createColorFilter() : void
      {
         var _loc4_:Array = _slowColors;
         var _loc3_:Array = _slowAlphas;
         var _loc2_:Array = _slowRoation;
         var _loc1_:Matrix = new Matrix();
         _loc1_.createGradientBox(_textField.width,_textField.height,_slowAngle,0,0);
         _shape.graphics.clear();
         _shape.graphics.beginGradientFill("linear",_loc4_,_loc3_,_loc2_,_loc1_);
         _shape.graphics.drawRect(0,0,_textField.width,_textField.height);
         _shape.graphics.endFill();
         _shape.cacheAsBitmap = true;
         _maskTextField.defaultTextFormat = _textField.defaultTextFormat;
         _maskTextField.text = _textField.text;
         _maskTextField.width = _textField.width;
         _maskTextField.height = _textField.height;
         _maskTextField.cacheAsBitmap = true;
         _shape.mask = _maskTextField;
         _sprite.addChild(_maskTextField);
         _sprite.addChild(_shape);
      }
      
      public function setSelection(param1:int, param2:int) : void
      {
         _textField.setSelection(param1,param2);
      }
      
      public function appendText(param1:String) : void
      {
         _textField.appendText(param1);
         _textField.setSelection(_textField.text.length,_textField.text.length);
         validate(STYLE);
      }
      
      public function getLineLength(param1:int) : int
      {
         return _textField.getLineLength(param1);
      }
      
      public function replaceSelectedText(param1:String) : void
      {
         _textField.replaceSelectedText(param1);
      }
      
      public function replaceText(param1:int, param2:int, param3:String) : void
      {
         _textField.replaceText(param1,param2,param3);
         validate(STYLE);
      }
      
      public function setFocus() : void
      {
         if(stage)
         {
            stage.focus = _textField;
         }
      }
      
      public function clone() : SimpleTextField
      {
         var _loc1_:SimpleTextField = new SimpleTextField();
         ObjectUtil.copyProperties(_loc1_,this);
         return _loc1_;
      }
      
      override public function render() : void
      {
         var _loc3_:BitmapData = null;
         var _loc1_:BitmapData = null;
         var _loc2_:TextField = null;
         if(validateDic["filter"])
         {
            changFilter();
         }
         if(validateDic["format"])
         {
            _textField.defaultTextFormat = _textFormat;
         }
         if(validateDic[STYLE])
         {
            if(_isColorSlow)
            {
               createColorFilter();
               _loc3_ = new BitmapData(_textField.width,_textField.height,true,0);
               _loc1_ = new BitmapData(_textField.width,_textField.height,true,0);
               _loc2_ = new TextField();
               _loc2_.defaultTextFormat = _textField.defaultTextFormat;
               _loc2_.text = _textField.text;
               _loc2_.width = _textField.width;
               _loc2_.height = _textField.height;
               _loc3_.draw(_textField,null,null);
               _loc1_.draw(_loc2_);
               clearBimtap(_loc3_,_loc1_);
               _loc3_.draw(_sprite);
               _bitmap.bitmapData = _loc3_;
               addChild(_bitmap);
               if(_textField.parent)
               {
                  removeChild(_textField);
               }
            }
            else
            {
               if(_bitmap.parent)
               {
                  removeChild(_bitmap);
               }
               addChild(_textField);
            }
         }
      }
      
      protected function clearBimtap(param1:BitmapData, param2:BitmapData) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:uint = uint(param2.width < param1.width ? param2.width : param1.width);
         var _loc5_:uint = uint(param2.height < param1.height ? param2.height : param1.height);
         var _loc8_:int = 50;
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc4_ = param1.getPixel32(_loc9_,_loc7_);
               _loc3_ = param2.getPixel32(_loc9_,_loc7_);
               _loc3_ >>>= 24;
               if(_loc3_ > _loc8_)
               {
                  _loc4_ &= 16777215;
                  param1.setPixel32(_loc9_,_loc7_,_loc4_);
               }
               _loc7_++;
            }
            _loc9_++;
         }
      }
      
      private function changFilter() : void
      {
         var _loc1_:int = 0;
         _loc1_ = _filterNum.indexOf(1);
         if(_loc1_ > -1)
         {
            _filter.splice(_loc1_,1);
            _filterNum.splice(_loc1_,1);
            _filter.splice(_loc1_ + 1,1);
            _filterNum.splice(_loc1_ + 1,1);
         }
         if(_openStroke)
         {
            _filter.push(returnFilter(1));
         }
         _loc1_ = _filterNum.indexOf(2);
         if(_loc1_ > -1)
         {
            _filter.splice(_loc1_,1);
            _filterNum.splice(_loc1_,1);
         }
         if(_isGradients)
         {
            _filter.push(returnFilter(2));
         }
         _loc1_ = _filterNum.indexOf(3);
         if(_loc1_ > -1)
         {
            _filter.splice(_loc1_,1);
            _filterNum.splice(_loc1_,1);
         }
         if(_isConvolution)
         {
            _filter.push(returnFilter(3));
         }
         _textField.filters = _filter;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_textField)
         {
            _textField.removeEventListener("textInput",__onTextInput);
         }
         this.removeChildren();
         if(_strokeBmd)
         {
            _strokeBmd.dispose();
            _strokeBmp = null;
         }
         _textField = null;
         _textFormat = null;
      }
      
      public function set textFormat(param1:TextFormat) : void
      {
         if(param1)
         {
            _textFormat = param1;
            _textField.defaultTextFormat = _textFormat;
            _textField.text = _textStr;
         }
      }
      
      public function get textFormat() : TextFormat
      {
         return _textFormat;
      }
      
      public function get caretIndex() : int
      {
         return _textField.caretIndex;
      }
      
      public function get selectable() : Boolean
      {
         return _textField.selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         _textField.selectable = param1;
         _maskTextField.selectable = param1;
      }
      
      public function set maxChars(param1:int) : void
      {
         _textField.maxChars = param1;
      }
      
      public function get maxChars() : int
      {
         return _textField.maxChars;
      }
      
      public function get scrollH() : int
      {
         return _textField.scrollH;
      }
      
      public function set scrollH(param1:int) : void
      {
         _textField.scrollH = param1;
      }
      
      public function get scrollV() : int
      {
         return _textField.scrollV;
      }
      
      public function set scrollV(param1:int) : void
      {
         _textField.scrollV = param1;
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
      
      public function set isPassword(param1:Boolean) : void
      {
         _textField.displayAsPassword = param1;
      }
      
      public function get isPassword() : Boolean
      {
         return _textField.displayAsPassword;
      }
      
      public function set textMouseEnabled(param1:Boolean) : void
      {
         mouseEnabled = param1;
         _textField.mouseEnabled = param1;
      }
      
      public function get textMouseEnabled() : Boolean
      {
         return _textField.mouseEnabled;
      }
      
      public function set textTouchable(param1:Boolean) : void
      {
         textMouseEnabled = param1;
      }
      
      public function get textTouchable() : Boolean
      {
         return textMouseEnabled;
      }
      
      public function set text(param1:String) : void
      {
         if(param1 != null)
         {
            _textField.text = param1;
         }
         else
         {
            _textField.text = "";
         }
         _textStr = _textField.text;
         _textField.setSelection(_textStr.length,_textStr.length);
         validate(STYLE);
      }
      
      public function get text() : String
      {
         return _textField.text;
      }
      
      public function set isbold(param1:Boolean) : void
      {
         _textFormat.bold = param1;
         _textField.defaultTextFormat = _textFormat;
         text = _textStr;
         validate(STYLE);
      }
      
      public function get isbold() : Boolean
      {
         return _textFormat.bold;
      }
      
      public function set htmltext(param1:String) : void
      {
         _textField.htmlText = param1;
         validate(STYLE);
      }
      
      public function get htmltext() : String
      {
         return _textField.htmlText;
      }
      
      public function set fontColor(param1:int) : void
      {
         _textFormat.color = param1;
         _textField.defaultTextFormat = _textFormat;
         text = _textStr;
      }
      
      override public function get width() : Number
      {
         if(_textField)
         {
            return _textField.width;
         }
         return 0;
      }
      
      override public function set width(param1:Number) : void
      {
         if(_textField)
         {
            _textField.width = param1;
            validate(STYLE);
         }
      }
      
      public function get fontColor() : int
      {
         return int(_textFormat.color);
      }
      
      public function set autoSize(param1:String) : void
      {
         _textField.autoSize = param1;
         validate(STYLE);
      }
      
      public function get autoSize() : String
      {
         return _textField.autoSize;
      }
      
      public function set size(param1:Number) : void
      {
         _textFormat.size = param1;
         _textField.defaultTextFormat = _textFormat;
         text = _textStr;
      }
      
      public function get size() : Number
      {
         return Number(_textFormat.size);
      }
      
      public function set font(param1:String) : void
      {
         _textFormat.font = param1;
         _textField.defaultTextFormat = _textFormat;
         text = _textStr;
      }
      
      public function get font() : String
      {
         return _textFormat.font;
      }
      
      public function set align(param1:String) : void
      {
         _textFormat.align = param1;
         _textField.defaultTextFormat = _textFormat;
         text = _textStr;
      }
      
      public function get align() : String
      {
         return _textFormat.align;
      }
      
      public function set mutilLine(param1:Boolean) : void
      {
         _textField.multiline = param1;
         text = _textStr;
      }
      
      public function get mutilLine() : Boolean
      {
         return _textField.multiline;
      }
      
      override public function set height(param1:Number) : void
      {
         _textField.height = param1;
         validate(STYLE);
      }
      
      override public function get height() : Number
      {
         return _textField.height;
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         _textField.wordWrap = param1;
         validate(STYLE);
      }
      
      public function get wordWrap() : Boolean
      {
         return _textField.wordWrap;
      }
      
      public function set border(param1:Boolean) : void
      {
         _textField.border = param1;
         validate(STYLE);
      }
      
      public function get border() : Boolean
      {
         return _textField.border;
      }
      
      public function get openStroke() : Boolean
      {
         return _openStroke;
      }
      
      public function set openStroke(param1:Boolean) : void
      {
         _openStroke = param1;
         validate("filter");
         validate(STYLE);
      }
      
      public function get strokeColor() : uint
      {
         return _strokeColor;
      }
      
      public function set strokeColor(param1:uint) : void
      {
         _strokeColor = param1;
         validate("filter");
      }
      
      public function get strokeSize() : uint
      {
         return _strokeSize;
      }
      
      public function set strokeSize(param1:uint) : void
      {
         _strokeSize = param1;
         validate("filter");
      }
      
      public function get isInput() : Boolean
      {
         return _textField.mouseEnabled;
      }
      
      public function set isInput(param1:Boolean) : void
      {
         if(param1)
         {
            _textField.type = "input";
            textMouseEnabled = true;
         }
         else
         {
            _textField.type = "dynamic";
         }
      }
      
      public function set type(param1:String) : void
      {
         _textField.type = param1;
      }
      
      public function set leading(param1:Object) : void
      {
         _textFormat.leading = param1;
         validate("format");
      }
      
      public function get leading() : Object
      {
         return _textFormat.leading;
      }
      
      public function get inputFunciotn() : Function
      {
         return _inputFunciotn;
      }
      
      public function set inputFunciotn(param1:Function) : void
      {
         _inputFunciotn = param1;
      }
      
      public function set styleSheet(param1:StyleSheet) : void
      {
         _textField.styleSheet = param1;
      }
      
      public function get styleSheet() : StyleSheet
      {
         return _textField.styleSheet;
      }
      
      public function get textLinkFunction() : Function
      {
         return _textLinkFunction;
      }
      
      public function set textLinkFunction(param1:Function) : void
      {
         _textLinkFunction = param1;
      }
      
      public function get selectedText() : String
      {
         return _textField.selectedText;
      }
      
      public function get isGradients() : Boolean
      {
         return _isGradients;
      }
      
      public function set isGradients(param1:Boolean) : void
      {
         _isGradients = param1;
         validate("filter");
         validate(STYLE);
      }
      
      public function get gradientColor() : String
      {
         return _gradientColor.join(",");
      }
      
      public function set gradientColor(param1:String) : void
      {
         _gradientColor = param1.split(",");
         validate("filter");
      }
      
      public function get gradientSize() : int
      {
         return _gradientSize;
      }
      
      public function set gradientSize(param1:int) : void
      {
         _gradientSize = param1;
         validate("filter");
      }
      
      public function get isConvo() : Boolean
      {
         return _isConvolution;
      }
      
      public function set isConvo(param1:Boolean) : void
      {
         _isConvolution = param1;
         validate(STYLE);
         validate("filter");
      }
      
      public function get isColorSlow() : Boolean
      {
         return _isColorSlow;
      }
      
      public function set isColorSlow(param1:Boolean) : void
      {
         _isColorSlow = param1;
         validate(STYLE);
      }
      
      public function get slowColors() : String
      {
         return _slowColors.join(",");
      }
      
      public function set slowColors(param1:String) : void
      {
         _slowColors = param1.split(",");
      }
      
      public function get slowRoation() : String
      {
         return _slowRoation.join(",");
      }
      
      public function set slowRoation(param1:String) : void
      {
         _slowRoation = param1.split(",");
      }
      
      public function get slowAlphas() : String
      {
         return _slowAlphas.join(",");
      }
      
      public function set slowAlphas(param1:String) : void
      {
         _slowAlphas = param1.split(",");
      }
      
      public function get slowAngle() : int
      {
         return _slowAngle;
      }
      
      public function set slowAngle(param1:int) : void
      {
         _slowAngle = param1;
      }
   }
}

