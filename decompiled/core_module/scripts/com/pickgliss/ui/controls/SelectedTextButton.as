package com.pickgliss.ui.controls
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class SelectedTextButton extends SelectedButton
   {
      
      public static const P_backgoundInnerRect:String = "backgoundInnerRect";
      
      public static const P_text:String = "text";
      
      public static const P_textField:String = "textField";
      
      protected var _textField:DisplayObject;
      
      protected var _text:String = "";
      
      protected var _textStyle:String;
      
      protected var _backgoundInnerRect:InnerRectangle = new InnerRectangle(0,0,0,0,-1);
      
      protected var _backgoundInnerRectString:String;
      
      public function SelectedTextButton()
      {
         super();
      }
      
      public function set backgoundInnerRectString(param1:String) : void
      {
         if(_backgoundInnerRectString == param1)
         {
            return;
         }
         _backgoundInnerRectString = param1;
         _backgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_backgoundInnerRectString));
         onPropertiesChanged("backgoundInnerRect");
      }
      
      public function get backgoundInnerRectString() : String
      {
         return _backgoundInnerRectString;
      }
      
      override public function dispose() : void
      {
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textField = null;
         super.dispose();
      }
      
      public function set text(param1:String) : void
      {
         if(_text == param1)
         {
            return;
         }
         _text = param1;
         onPropertiesChanged("text");
      }
      
      public function set textField(param1:DisplayObject) : void
      {
         if(_textField == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_textField);
         _textField = param1;
         onPropertiesChanged("textField");
      }
      
      public function get textField() : DisplayObject
      {
         return _textField;
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
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_textField)
         {
            addChild(_textField);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var _loc1_:Rectangle = null;
         super.onProppertiesUpdate();
         if(_textField == null)
         {
            return;
         }
         _textField["text"] = _text;
         if(_autoSizeAble)
         {
            _loc1_ = _backgoundInnerRect.getInnerRect(_textField.width,_textField.height);
            _width = _selectedButton.width = _unSelectedButton.width = _loc1_.width;
            _height = _unSelectedButton.height = _unSelectedButton.height = _loc1_.height;
            _textField.x = _backgoundInnerRect.para1;
            _textField.y = _backgoundInnerRect.para3;
         }
         else
         {
            _selectedButton.width = _unSelectedButton.width = _width;
            _selectedButton.height = _unSelectedButton.height = _height;
            _textField.x = (_width - _textField.width) / 2;
            _textField.y = (_height - _textField.height) / 2;
         }
      }
   }
}

