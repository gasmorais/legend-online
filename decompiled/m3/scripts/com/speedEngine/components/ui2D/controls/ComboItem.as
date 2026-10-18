package com.speedEngine.components.ui2D.controls
{
   import com.speedEngine.components.ui2D.SimpleImage;
   import com.speedEngine.components.ui2D.TinyUI;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ComboItem extends TinyUI
   {
      
      private var _label:String = "";
      
      private var _textField:TextField;
      
      private const OUT_COLOR:uint = 10262920;
      
      private const OVER_COLOR:uint = 15788480;
      
      private var _overBmp:BitmapData;
      
      private var _bgBmp:BitmapData;
      
      private var _bg:SimpleImage;
      
      private var _itemData:Object;
      
      private var _format:TextFormat;
      
      private var _itemWidth:int = -1;
      
      private var _itemHeight:int = -1;
      
      public function ComboItem()
      {
         super();
         _bg = new SimpleImage();
         this.addChild(_bg);
         _textField = new TextField();
         _textField.mouseEnabled = false;
         _textField.width = 83;
         _textField.height = 28;
         this.addChild(_textField);
         addEvent();
      }
      
      public function set textFormat(param1:TextFormat) : void
      {
         if(param1 == null)
         {
            return;
         }
         _format = param1;
         if(_textField)
         {
            _textField.defaultTextFormat = _format;
            _textField.text = _label;
         }
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      override public function set height(param1:Number) : void
      {
         if(param1 != -1)
         {
            _itemHeight = param1;
            _textField.height = param1;
            _bg.height = param1;
         }
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(param1 != -1)
         {
            _itemWidth = param1;
            _textField.width = param1;
            _bg.width = param1;
         }
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
      
      public function set texture(param1:BitmapData) : void
      {
         if(param1 != null)
         {
            _bgBmp = param1;
            _bg.texture = _bgBmp;
         }
      }
      
      public function set overTexture(param1:BitmapData) : void
      {
         if(param1 != null)
         {
            _overBmp = param1;
            pushDisposeBitmap(param1);
         }
      }
      
      private function addEvent() : void
      {
         this.addEventListener("rollOver",onOverHandler);
         this.addEventListener("rollOut",onOutHandler);
         this.addEventListener("click",onDownHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("rollOver",onOverHandler);
         this.removeEventListener("rollOut",onOutHandler);
         this.removeEventListener("click",onDownHandler);
      }
      
      private function onOverHandler(param1:MouseEvent) : void
      {
         if(_overBmp)
         {
            _bg.texture = _overBmp;
            _bg.width = _itemWidth;
            _bg.height = _itemHeight;
         }
         if(_textField)
         {
            _textField.textColor = 15788480;
         }
      }
      
      private function onOutHandler(param1:MouseEvent) : void
      {
         if(_bgBmp)
         {
            _bg.texture = _bgBmp;
            _bg.width = _itemWidth;
            _bg.height = _itemHeight;
         }
         if(_textField)
         {
            _textField.textColor = 10262920;
         }
      }
      
      private function onDownHandler(param1:MouseEvent) : void
      {
         this.dispatchEvent(new Event("change"));
      }
      
      public function set label(param1:String) : void
      {
         _textField.text = param1;
         _textField.textColor = 10262920;
         _label = param1;
      }
      
      public function get label() : String
      {
         return _label;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _bgBmp = null;
         _textField = null;
         _format = null;
         _overBmp = null;
         super.dispose();
      }
      
      public function get itemData() : Object
      {
         return _itemData;
      }
      
      public function set itemData(param1:Object) : void
      {
         _itemData = param1;
      }
   }
}

