package com.speedEngine.components.ui2D
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   
   public class IconButton extends LabelButton
   {
      
      protected var _icon:Bitmap;
      
      private var _iconTexture:BitmapData;
      
      private var _iconOverTexture:BitmapData;
      
      private var _iconDownTexture:BitmapData;
      
      private var _iconX:int = -2147483648;
      
      private var _iconY:int = -2147483648;
      
      private var _gap:int = 3;
      
      private var _iconAlign:String;
      
      private var _lastDownTexture:BitmapData;
      
      public var LEFT:String = "left";
      
      public var RIGHT:String = "right";
      
      public function IconButton()
      {
         _iconAlign = LEFT;
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _icon = new Bitmap();
         addChild(_icon);
      }
      
      public function get iconTexture() : BitmapData
      {
         return _iconTexture;
      }
      
      public function set iconTexture(param1:BitmapData) : void
      {
         _iconTexture = param1;
         _icon.bitmapData = param1;
         pushDisposeBitmap(param1);
         validate(STYLE);
      }
      
      protected function layoutToCenter(param1:Array, param2:int = 0, param3:int = -1, param4:int = -1) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = int(param1.length);
         if(param3 == -1)
         {
            param3 = this.width;
         }
         if(param4 == -1)
         {
            param4 = this.height;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            if(param2 == 0)
            {
               _loc6_ += param1[_loc8_].width + _gap;
            }
            else if(param2 == 1)
            {
               _loc6_ += param1[_loc8_].height + _gap;
            }
            _loc8_++;
         }
         if(_loc6_ > 0)
         {
            _loc6_ -= _gap;
         }
         if(param2 == 0)
         {
            _loc7_ = param3 - _loc6_ >> 1;
         }
         else if(param2 == 1)
         {
            _loc7_ = param4 - _loc6_ >> 1;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            if(param2 == 0)
            {
               param1[_loc8_].x = _loc7_;
               _loc7_ += param1[_loc8_].width + _gap;
            }
            else if(param2 == 1)
            {
               param1[_loc8_].y = _loc7_;
               _loc7_ += param1[_loc8_].height + _gap;
            }
            _loc8_++;
         }
      }
      
      override protected function down(param1:MouseEvent) : void
      {
         super.down(param1);
         _lastDownTexture = _icon.bitmapData;
         changIconTexture(_iconDownTexture);
      }
      
      override protected function up(param1:MouseEvent) : void
      {
         super.up(param1);
         changIconTexture(_lastDownTexture);
      }
      
      override protected function out(param1:MouseEvent) : void
      {
         super.out(param1);
         changIconTexture(_iconTexture);
      }
      
      override protected function over(param1:MouseEvent) : void
      {
         super.over(param1);
         changIconTexture(_iconOverTexture);
      }
      
      protected function changIconTexture(param1:BitmapData) : void
      {
         if(param1 && param1 != _icon.bitmapData)
         {
            _icon.bitmapData = param1;
         }
      }
      
      override protected function layout() : void
      {
         var _loc3_:Array = null;
         if(_textField.parent)
         {
            removeChild(_textField);
         }
         if(_icon.parent)
         {
            removeChild(_icon);
         }
         var _loc2_:int = width;
         var _loc1_:int = height;
         if(_iconAlign == LEFT)
         {
            _loc3_ = [_icon,_textField];
         }
         else if(_iconAlign == RIGHT)
         {
            _loc3_ = [_textField,_icon];
         }
         layoutToCenter(_loc3_,0,_loc2_,_loc1_);
         layoutToCenter([_textField],1,_loc2_,_loc1_);
         layoutToCenter([_icon],1,_loc2_,_loc1_);
         if(textX != -2147483648)
         {
            _textField.x = textX;
         }
         if(textY != -2147483648)
         {
            _textField.y = textY;
         }
         if(_iconX != -2147483648)
         {
            _icon.x = _iconX;
         }
         if(_iconY != -2147483648)
         {
            _icon.y = _iconY;
         }
         addChild(_textField);
         addChild(_icon);
      }
      
      public function get gap() : int
      {
         return _gap;
      }
      
      public function set gap(param1:int) : void
      {
         _gap = param1;
      }
      
      public function get iconAlign() : String
      {
         return _iconAlign;
      }
      
      public function set iconAlign(param1:String) : void
      {
         _iconAlign = param1;
      }
      
      public function get iconX() : int
      {
         return _iconX;
      }
      
      public function set iconX(param1:int) : void
      {
         _iconX = param1;
      }
      
      public function get iconY() : int
      {
         return _iconY;
      }
      
      public function set iconY(param1:int) : void
      {
         _iconY = param1;
      }
      
      public function get iconOverTexture() : BitmapData
      {
         return _iconOverTexture;
      }
      
      public function set iconOverTexture(param1:BitmapData) : void
      {
         _iconOverTexture = param1;
         pushDisposeBitmap(param1);
      }
      
      public function get iconDownTexture() : BitmapData
      {
         return _iconDownTexture;
      }
      
      public function set iconDownTexture(param1:BitmapData) : void
      {
         _iconDownTexture = param1;
         pushDisposeBitmap(param1);
      }
   }
}

