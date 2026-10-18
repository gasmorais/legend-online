package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   
   public class SelectedIconTextButton extends SelectedIconButton
   {
      
      public static const P_textStyle:String = "textStyle";
      
      protected var _textStyle:String;
      
      protected var _text:FilterFrameText;
      
      public function SelectedIconTextButton()
      {
         super();
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textStyle == param1)
         {
            return;
         }
         _textStyle = param1;
         onPropertiesChanged("textStyle");
      }
      
      public function get textStyle() : String
      {
         return _textStyle;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["textStyle"])
         {
            _text = ComponentFactory.Instance.creatComponentByStylename(_textStyle);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_text)
         {
            addChild(_text);
         }
      }
      
      public function set text(param1:String) : void
      {
         if(_text)
         {
            _text.text = param1;
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(!_text)
         {
            return;
         }
         if(param1)
         {
            _text.setFrame(2);
         }
         else
         {
            _text.setFrame(1);
         }
      }
   }
}

