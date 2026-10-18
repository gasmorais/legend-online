package com.speedEngine.components.ui2D
{
   import com.speedEngine.game.view.BaseSprite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SimpleProcessBar extends TinyUI
   {
      
      private var _bgBarSprite:TinyUI;
      
      private var _barSprite:TinyUI;
      
      private var _bgBar:Bitmap;
      
      private var _foreBar:Bitmap;
      
      private var _forePosLeft:Number = 0;
      
      private var _forePosTop:Number = 0;
      
      private var _slider:Bitmap;
      
      private var _sliderPosLeft:Number = 0;
      
      private var _sliderPosRight:Number = 0;
      
      private var _sliderPosTop:Number = 0;
      
      private var _oldX:Number;
      
      private var _percent:int = -1;
      
      private var _rect:BaseSprite = new BaseSprite();
      
      private var _rectMaxHeight:Number = 0;
      
      private var _rectMaxWidth:Number = 0;
      
      public function SimpleProcessBar(param1:int = -1)
      {
         super();
         this.percent = param1;
         initView();
         initEvents();
      }
      
      protected function initView() : void
      {
         _bgBarSprite = new TinyUI();
         _barSprite = new TinyUI();
         _bgBar = new Bitmap();
         _foreBar = new Bitmap();
         _slider = new Bitmap();
         _slider.x = -_sliderPosLeft;
         _bgBarSprite.addChild(_bgBar);
         addChild(_bgBarSprite);
         _barSprite.addChild(_foreBar);
         _barSprite.mouseEnabled = false;
         addChild(_barSprite);
         addChild(_slider);
      }
      
      protected function initEvents() : void
      {
         addEventListener("mouseDown",__beginDrag);
      }
      
      protected function __endDrag(param1:MouseEvent) : void
      {
         stage.removeEventListener("mouseMove",__drag);
         stage.removeEventListener("mouseUp",__endDrag);
      }
      
      protected function __drag(param1:MouseEvent) : void
      {
         var _loc2_:Number = param1.stageX - _oldX;
         _oldX = param1.stageX;
         if(_slider.x + _sliderPosLeft + _loc2_ >= 0 && _slider.x + _sliderPosRight + _loc2_ <= _bgBar.width)
         {
            _slider.x += _loc2_;
            _rect.x = _percent > 50 ? _slider.x + _sliderPosRight : _slider.x + _sliderPosLeft;
            _percent = _rect.x * 100 / _bgBar.width;
            dispatchEvent(new Event("change"));
         }
      }
      
      protected function __beginDrag(param1:MouseEvent) : void
      {
         stage.addEventListener("mouseUp",__endDrag);
         stage.addEventListener("mouseMove",__drag);
         if(param1.localX >= 0 && param1.localX < _bgBar.width)
         {
            _slider.x = _percent > 50 ? param1.localX - sliderPosRight : param1.localX - _sliderPosLeft;
            _rect.x = param1.localX;
            _percent = _rect.x * 100 / _bgBar.width;
            dispatchEvent(new Event("change"));
         }
         _oldX = param1.stageX;
      }
      
      public function get sliderPosLeft() : Number
      {
         return _sliderPosLeft;
      }
      
      public function set sliderPosLeft(param1:Number) : void
      {
         if(_sliderPosLeft != param1)
         {
            _sliderPosLeft = param1;
            _sliderPosRight = param1;
            _slider.x = param1;
         }
      }
      
      public function get sliderPosRight() : Number
      {
         return _sliderPosRight;
      }
      
      public function set sliderPosRight(param1:Number) : void
      {
         _sliderPosRight = param1;
      }
      
      public function set percent(param1:int) : void
      {
         if(_percent == param1)
         {
            return;
         }
         _percent = param1;
         if(_rect)
         {
            _rect.x = Math.ceil(_percent * _bgBar.width / 100);
            _slider.x = _rect.x - _sliderPosLeft;
         }
      }
      
      public function get percent() : int
      {
         return _percent;
      }
      
      public function get bgBarTexture() : BitmapData
      {
         return _bgBar.bitmapData;
      }
      
      public function set bgBarTexture(param1:BitmapData) : void
      {
         if(_bgBar.bitmapData == param1)
         {
            return;
         }
         _bgBar.bitmapData = param1;
         if(param1.width > _rectMaxWidth)
         {
            _rectMaxWidth = param1.width;
         }
         if(param1.height > _rectMaxHeight)
         {
            _rectMaxHeight = param1.height;
         }
         pushDisposeBitmap(param1);
      }
      
      public function get foreBarTexture() : BitmapData
      {
         return _foreBar.bitmapData;
      }
      
      public function set foreBarTexture(param1:BitmapData) : void
      {
         if(_foreBar.bitmapData == param1)
         {
            return;
         }
         _foreBar.bitmapData = param1;
         if(param1.width > _rectMaxWidth)
         {
            _rectMaxWidth = param1.width;
         }
         if(param1.height > _rectMaxHeight)
         {
            _rectMaxHeight = param1.height;
         }
         pushDisposeBitmap(param1);
      }
      
      public function get sliderTexture() : BitmapData
      {
         return _slider.bitmapData;
      }
      
      public function set sliderTexture(param1:BitmapData) : void
      {
         _slider.bitmapData = param1;
         pushDisposeBitmap(param1);
      }
      
      override public function __onAfterProp() : void
      {
         _slider.y = _sliderPosTop;
         _foreBar.x = _forePosLeft;
         _foreBar.y = _forePosTop;
         _rect.graphics.beginFill(0);
         _rect.graphics.drawRect(-_rectMaxWidth,0,_rectMaxWidth,_rectMaxHeight);
         _rect.graphics.endFill();
         _rect.mouseEnabled = false;
         addChild(_rect);
         _barSprite.mask = _rect;
         _rect.x = Math.ceil(_percent * _bgBar.width / 100);
         _slider.x = _rect.x - _sliderPosLeft;
      }
      
      override public function dispose() : void
      {
         removeEventListener("mouseDown",__beginDrag);
         super.dispose();
      }
      
      public function get sliderPosTop() : Number
      {
         return _sliderPosTop;
      }
      
      public function set sliderPosTop(param1:Number) : void
      {
         _sliderPosTop = param1;
      }
      
      public function get forePosLeft() : Number
      {
         return _forePosLeft;
      }
      
      public function set forePosLeft(param1:Number) : void
      {
         _forePosLeft = param1;
      }
      
      public function get forePosTop() : Number
      {
         return _forePosTop;
      }
      
      public function set forePosTop(param1:Number) : void
      {
         _forePosTop = param1;
      }
   }
}

