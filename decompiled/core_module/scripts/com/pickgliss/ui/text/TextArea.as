package com.pickgliss.ui.text
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.DisplayObjectViewport;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   
   public class TextArea extends ScrollPanel
   {
      
      public static const P_textField:String = "textField";
      
      protected var _currentTextHeight:int = 0;
      
      protected var _enable:Boolean = true;
      
      protected var _textField:FilterFrameText;
      
      protected var _textStyle:String;
      
      protected var _limitLines:int = 2147483647;
      
      public var textString:String = "";
      
      public function TextArea()
      {
         super();
         _viewSource.addEventListener("click",__onTextAreaClick);
         _viewSource.addEventListener("mouseOver",__onTextAreaOver);
         _viewSource.addEventListener("mouseOut",__onTextAreaOut);
      }
      
      override public function dispose() : void
      {
         Mouse.cursor = "auto";
         _viewSource.removeEventListener("click",__onTextAreaClick);
         _viewSource.removeEventListener("mouseOver",__onTextAreaOver);
         _viewSource.removeEventListener("mouseOut",__onTextAreaOut);
         _textField.removeEventListener("keyDown",__onTextKeyDown);
         _textField.removeEventListener("change",__onTextChanged);
         ObjectUtils.disposeObject(_textField);
         _textField = null;
         super.dispose();
      }
      
      public function get editable() : Boolean
      {
         return _textField.type == "input";
      }
      
      public function set editable(param1:Boolean) : void
      {
         if(param1)
         {
            _textField.type = "input";
            _viewSource.addEventListener("mouseOver",__onTextAreaOver);
            _viewSource.addEventListener("mouseOut",__onTextAreaOut);
         }
         else
         {
            _textField.type = "dynamic";
            _viewSource.removeEventListener("mouseOver",__onTextAreaOver);
            _viewSource.removeEventListener("mouseOut",__onTextAreaOut);
         }
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _enable = param1;
         _textField.mouseEnabled = _enable;
         if(_enable)
         {
            _viewSource.addEventListener("mouseOver",__onTextAreaOver);
            _viewSource.addEventListener("mouseOut",__onTextAreaOut);
         }
         else
         {
            _viewSource.removeEventListener("mouseOver",__onTextAreaOver);
            _viewSource.removeEventListener("mouseOut",__onTextAreaOut);
         }
      }
      
      public function get maxChars() : int
      {
         return _textField.maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         _textField.maxChars = param1;
      }
      
      public function set limitChars(param1:int) : void
      {
         _limitLines = param1;
      }
      
      public function get text() : String
      {
         return _textField.text;
      }
      
      public function set text(param1:String) : void
      {
         _textField.text = param1;
         DisplayObjectViewport(_viewSource).invalidateView();
      }
      
      public function set htmlText(param1:String) : void
      {
         _textField.htmlText = param1;
         DisplayObjectViewport(_viewSource).invalidateView();
      }
      
      public function get textField() : FilterFrameText
      {
         return _textField;
      }
      
      public function set textField(param1:FilterFrameText) : void
      {
         if(_textField == param1)
         {
            return;
         }
         if(_textField)
         {
            _textField.removeEventListener("change",__onTextChanged);
            _textField.removeEventListener("keyDown",__onTextKeyDown);
            ObjectUtils.disposeObject(_textField);
         }
         _textField = param1;
         _textField.multiline = true;
         _textField.addEventListener("keyDown",__onTextKeyDown);
         _textField.addEventListener("change",__onTextChanged);
         onPropertiesChanged("textField");
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textStyle == param1)
         {
            return;
         }
         _textStyle = param1;
         textField = ComponentFactory.Instance.creat(_textStyle);
      }
      
      public function get textStyle() : String
      {
         return _textStyle;
      }
      
      override protected function layoutComponent() : void
      {
         super.layoutComponent();
         var _loc1_:Rectangle = _viewportInnerRect.getInnerRect(_width,_height);
         _textField.x = _loc1_.x;
         _textField.y = _loc1_.y;
         _textField.width = _viewSource.width;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["textField"])
         {
            DisplayObjectViewport(_viewSource).setView(_textField);
         }
      }
      
      private function __onTextAreaClick(param1:MouseEvent) : void
      {
         _textField.setFocus();
      }
      
      private function __onTextAreaOut(param1:MouseEvent) : void
      {
         Mouse.cursor = "auto";
      }
      
      private function __onTextAreaOver(param1:MouseEvent) : void
      {
         Mouse.cursor = "ibeam";
      }
      
      private function __onTextChanged(param1:Event) : void
      {
         if(StringUtils.checkStringLength(_textField.text) >= _limitLines)
         {
            _textField.text = StringUtils.substr(_textField.text,_limitLines);
         }
         upScrollArea();
      }
      
      private function __onTextKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            param1.stopPropagation();
            this.dispatchEvent(param1);
         }
         else if(param1.keyCode == 38)
         {
            upScrollArea();
         }
         else if(param1.keyCode == 40)
         {
            upScrollArea();
         }
         else if(param1.keyCode == 46)
         {
            upScrollArea();
         }
      }
      
      private function upScrollArea() : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:IntPoint = null;
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:Number = NaN;
         DisplayObjectViewport(_viewSource).invalidateView();
         if(_textField.caretIndex <= 0)
         {
            viewPort.viewPosition = new IntPoint(0,0);
         }
         else
         {
            _loc7_ = DisplayUtils.getTextFieldLineHeight(_textField);
            _loc8_ = viewPort.viewPosition;
            _loc4_ = DisplayUtils.getTextFieldCareLinePosX(_textField);
            _loc6_ = DisplayUtils.getTextFieldCareLinePosY(_textField);
            _loc1_ = _loc4_ - _loc8_.x;
            _loc3_ = _loc6_ + _loc7_ - _loc8_.y;
            DisplayObjectViewport(_viewSource).invalidateView();
            _loc2_ = _loc8_.x;
            _loc5_ = _loc8_.y;
            if(_loc1_ < 0)
            {
               _loc2_ = _loc4_;
            }
            else if(_loc1_ > viewPort.getExtentSize().width)
            {
               _loc2_ = _loc4_ + viewPort.getExtentSize().width;
            }
            if(_loc3_ < _loc7_)
            {
               _loc5_ = _loc6_ - _loc3_;
            }
            else if(_loc3_ > viewPort.getExtentSize().height)
            {
               _loc5_ = _loc6_ + viewPort.getExtentSize().height;
            }
            if(_loc2_ > 0 || _loc5_ > 0)
            {
               viewPort.viewPosition = new IntPoint(_loc2_,_loc5_);
            }
         }
      }
   }
}

