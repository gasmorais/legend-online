package com.pickgliss.ui.controls
{
   import flash.display.Bitmap;
   import flash.text.TextField;
   
   public class TextButton extends AbstractTextButton
   {
      
      protected var _autoCenter:Boolean = true;
      
      protected var _offSetX:Number = 0;
      
      protected var _offSetY:Number = 0;
      
      public function TextButton()
      {
         super();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         this.updataOtherPropperties();
      }
      
      protected function updataOtherPropperties() : void
      {
         var _loc1_:TextField = null;
         if(!_back)
         {
            return;
         }
         if(_textField is TextField && _autoCenter && _back is Bitmap)
         {
            _loc1_ = _textField as TextField;
            _loc1_.autoSize = "left";
            _back.x = 0;
            _back.y = 0;
            _loc1_.x = (_back.width - _loc1_.width) / 2;
            _loc1_.y = (_back.height - _loc1_.textHeight) / 2 - 2;
            _loc1_.x += this._offSetX;
            _loc1_.y += this._offSetY;
         }
      }
      
      public function set autoCenter(param1:Boolean) : void
      {
         _autoCenter = param1;
         this.updataOtherPropperties();
      }
      
      public function get autoCenter() : Boolean
      {
         return _autoCenter;
      }
      
      public function set offSetX(param1:Number) : void
      {
         this._offSetX = param1;
         this.updataOtherPropperties();
      }
      
      public function get offSetX() : Number
      {
         return this._offSetX;
      }
      
      public function set offSetY(param1:Number) : void
      {
         this._offSetY = param1;
         this.updataOtherPropperties();
      }
      
      public function get offSetY() : Number
      {
         return this._offSetY;
      }
   }
}

