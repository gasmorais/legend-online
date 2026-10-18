package com.pickgliss.ui.controls.alert
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   
   public class UseBindPointAlert extends SimpleAlert
   {
      
      public static const P_useBindPointStyle:String = "useBindPointStyle";
      
      protected var _useBindPointBtn:SelectedCheckButton;
      
      protected var _usebindPointStyle:String;
      
      public function UseBindPointAlert()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_useBindPointBtn)
         {
            ObjectUtils.disposeObject(_smallTipTxt);
            _useBindPointBtn = null;
         }
         super.dispose();
      }
      
      public function set usebindPointStyle(param1:String) : void
      {
         if(_usebindPointStyle == param1)
         {
            return;
         }
         _usebindPointStyle = param1;
         _useBindPointBtn = ComponentFactory.Instance.creatComponentByStylename(_usebindPointStyle);
         _useBindPointBtn.text = "使用绑定钻石";
      }
      
      public function get usebindPointStyle() : String
      {
         return _usebindPointStyle;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_useBindPointBtn)
         {
            addChild(_useBindPointBtn);
            _useBindPointBtn.selected = true;
         }
      }
      
      override protected function layoutFrameRect() : void
      {
         super.layoutFrameRect();
         if(_useBindPointBtn)
         {
            if(_smallTipTxt.text != "")
            {
               _useBindPointBtn.x = _textField.x + (_textField.width - _useBindPointBtn.width) / 2;
               _useBindPointBtn.y = _textField.y + _textField.height + 15;
            }
            else
            {
               _textField.y = 40;
               _useBindPointBtn.x = _textField.x + (_textField.width - _useBindPointBtn.width) / 2;
               _useBindPointBtn.y = 64;
            }
         }
      }
      
      override protected function __onSubmitClick(param1:MouseEvent) : void
      {
         if(_useBindPointBtn)
         {
            if(_submitSoundFunc != null)
            {
               _submitSoundFunc();
            }
            onResponse(3,_useBindPointBtn.selected);
            param1.stopPropagation();
         }
      }
      
      override protected function __onCancelClick(param1:MouseEvent) : void
      {
         if(_submitSoundFunc != null)
         {
            _submitSoundFunc();
         }
         onResponse(0,_useBindPointBtn.selected);
         param1.stopPropagation();
         super.dispose();
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         if(_submitSoundFunc != null)
         {
            _submitSoundFunc();
         }
         onResponse(4,_useBindPointBtn.selected);
         param1.stopPropagation();
         super.dispose();
      }
   }
}

