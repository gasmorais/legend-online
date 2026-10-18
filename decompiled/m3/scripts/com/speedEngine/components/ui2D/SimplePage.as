package com.speedEngine.components.ui2D
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class SimplePage extends TinyUI
   {
      
      private var _pageButtonBg:Bitmap;
      
      private var _preButton:LabelButton;
      
      private var _firstButton:LabelButton;
      
      private var _nextButton:LabelButton;
      
      private var _lastButton:LabelButton;
      
      private var _pageText:TextField;
      
      private var _textFormat:TextFormat;
      
      private var _currPage:int = 1;
      
      private var _totalPage:int = 10;
      
      private var _space:Number = 5;
      
      private var _textWidth:Number = 80;
      
      private var _textHeight:Number = 25;
      
      private var _onChangeCallBack:Function = null;
      
      public function SimplePage()
      {
         super();
         _pageText = new TextField();
         _pageText.mouseEnabled = false;
         _pageText.width = 45;
         _pageText.height = 20;
         _textFormat = new TextFormat(null,14);
         _textFormat.align = "center";
         addChild(_pageText);
         newPreButton();
         newFirstButton();
         newLastButton();
         newNextButton();
      }
      
      public function set texture(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!_pageButtonBg)
         {
            _pageButtonBg = new Bitmap(param1);
         }
         _pageButtonBg.bitmapData = param1;
         pushDisposeBitmap(param1);
         addChildAt(_pageButtonBg,0);
         validate(STYLE);
      }
      
      public function get texture() : BitmapData
      {
         if(_pageButtonBg)
         {
            return _pageButtonBg.bitmapData;
         }
         return null;
      }
      
      private function newPreButton() : void
      {
         _preButton = new LabelButton();
         _preButton.downEffect = null;
         _preButton.onClickCallBack = onPreHandle;
         addChild(_preButton);
      }
      
      private function newNextButton() : void
      {
         _nextButton = new LabelButton();
         _nextButton.downEffect = null;
         _nextButton.onClickCallBack = onNextHandle;
         addChild(_nextButton);
      }
      
      private function newFirstButton() : void
      {
         _firstButton = new LabelButton();
         _firstButton.downEffect = null;
         _firstButton.onClickCallBack = onFirstHandle;
         addChild(_firstButton);
      }
      
      private function newLastButton() : void
      {
         _lastButton = new LabelButton();
         _lastButton.downEffect = null;
         _lastButton.onClickCallBack = onLastHandle;
         addChild(_lastButton);
      }
      
      public function set preTexture(param1:BitmapData) : void
      {
         if(_preButton == null)
         {
            newPreButton();
         }
         _preButton.texture = param1;
         validate(STYLE);
      }
      
      public function get preTexture() : BitmapData
      {
         if(_preButton)
         {
            return _preButton.texture;
         }
         return null;
      }
      
      public function set preOverTexture(param1:BitmapData) : void
      {
         if(_preButton == null)
         {
            newPreButton();
         }
         _preButton.overTexture = param1;
         validate(STYLE);
      }
      
      public function get preOverTexture() : BitmapData
      {
         if(_preButton)
         {
            return _preButton.overTexture;
         }
         return null;
      }
      
      public function set preDownTexture(param1:BitmapData) : void
      {
         if(_preButton == null)
         {
            newPreButton();
         }
         _preButton.downTexture = param1;
         validate(STYLE);
      }
      
      public function get preDownTexture() : BitmapData
      {
         if(_preButton)
         {
            return _preButton.downTexture;
         }
         return null;
      }
      
      public function set preText(param1:String) : void
      {
         if(_preButton == null)
         {
            newPreButton();
         }
         _preButton.text = param1;
         validate(STYLE);
      }
      
      public function set nextTexture(param1:BitmapData) : void
      {
         if(_nextButton == null)
         {
            newNextButton();
         }
         _nextButton.texture = param1;
         validate(STYLE);
      }
      
      public function get nextTexture() : BitmapData
      {
         if(_nextButton)
         {
            return _nextButton.texture;
         }
         return null;
      }
      
      public function set nextOverTexture(param1:BitmapData) : void
      {
         if(_nextButton == null)
         {
            newNextButton();
         }
         _nextButton.overTexture = param1;
         validate(STYLE);
      }
      
      public function get nextOverTexture() : BitmapData
      {
         if(_nextButton)
         {
            return _nextButton.overTexture;
         }
         return null;
      }
      
      public function set nextDownTexture(param1:BitmapData) : void
      {
         if(_nextButton == null)
         {
            newNextButton();
         }
         _nextButton.downTexture = param1;
         validate(STYLE);
      }
      
      public function get nextDownTexture() : BitmapData
      {
         if(_nextButton)
         {
            return _nextButton.downTexture;
         }
         return null;
      }
      
      public function set nextText(param1:String) : void
      {
         if(_nextButton == null)
         {
            newNextButton();
         }
         _nextButton.text = param1;
         validate(STYLE);
      }
      
      public function get nextText() : String
      {
         if(_nextButton)
         {
            return _nextButton.text;
         }
         return null;
      }
      
      public function get preText() : String
      {
         if(_preButton)
         {
            return _preButton.text;
         }
         return null;
      }
      
      public function set firstTexture(param1:BitmapData) : void
      {
         if(_firstButton == null)
         {
            newFirstButton();
         }
         _firstButton.texture = param1;
         validate(STYLE);
      }
      
      public function get firstTexture() : BitmapData
      {
         if(_firstButton)
         {
            return _firstButton.texture;
         }
         return null;
      }
      
      public function set firstOverTexture(param1:BitmapData) : void
      {
         if(_firstButton == null)
         {
            newFirstButton();
         }
         _firstButton.overTexture = param1;
         validate(STYLE);
      }
      
      public function get firstOverTexture() : BitmapData
      {
         if(_firstButton)
         {
            return _firstButton.overTexture;
         }
         return null;
      }
      
      public function set firstDownTexture(param1:BitmapData) : void
      {
         if(_firstButton == null)
         {
            newFirstButton();
         }
         _firstButton.downTexture = param1;
         validate(STYLE);
      }
      
      public function get firstDownTexture() : BitmapData
      {
         if(_firstButton)
         {
            return _firstButton.texture;
         }
         return null;
      }
      
      public function set firstText(param1:String) : void
      {
         if(_firstButton == null)
         {
            newFirstButton();
         }
         _firstButton.text = param1;
         validate(STYLE);
      }
      
      public function set lastTexture(param1:BitmapData) : void
      {
         if(_lastButton == null)
         {
            newLastButton();
         }
         _lastButton.texture = param1;
         validate(STYLE);
      }
      
      public function get lastTexture() : BitmapData
      {
         if(_lastButton)
         {
            return _lastButton.texture;
         }
         return null;
      }
      
      public function set lastOverTexture(param1:BitmapData) : void
      {
         if(_lastButton == null)
         {
            newLastButton();
         }
         _lastButton.overTexture = param1;
         validate(STYLE);
      }
      
      public function get lastOverTexture() : BitmapData
      {
         if(_lastButton)
         {
            return _lastButton.overTexture;
         }
         return null;
      }
      
      public function set lastDownTexture(param1:BitmapData) : void
      {
         if(_lastButton == null)
         {
            newLastButton();
         }
         _lastButton.downTexture = param1;
         validate(STYLE);
      }
      
      public function get lastDownTexture() : BitmapData
      {
         if(_lastButton)
         {
            return _lastButton.downTexture;
         }
         return null;
      }
      
      public function set lastText(param1:String) : void
      {
         if(_lastButton == null)
         {
            newLastButton();
         }
         _lastButton.text = param1;
         validate(STYLE);
      }
      
      public function get lastText() : String
      {
         if(_lastButton)
         {
            return _lastButton.text;
         }
         return null;
      }
      
      public function get firstText() : String
      {
         if(_firstButton)
         {
            return _firstButton.text;
         }
         return null;
      }
      
      private function updataButton() : void
      {
         if(_totalPage == 1)
         {
            if(_lastButton && _lastButton.texture)
            {
               _lastButton.enabled = false;
            }
            if(_nextButton)
            {
               _nextButton.enabled = false;
            }
            if(_firstButton && _firstButton.texture)
            {
               _firstButton.enabled = false;
            }
            if(_preButton)
            {
               _preButton.enabled = false;
            }
         }
         else if(_currPage == _totalPage)
         {
            if(_firstButton)
            {
               _firstButton.enabled = true;
            }
            if(_preButton)
            {
               _preButton.enabled = true;
            }
            if(_lastButton)
            {
               _lastButton.enabled = false;
            }
            if(_nextButton)
            {
               _nextButton.enabled = false;
            }
         }
         else if(_currPage == 1)
         {
            if(_firstButton && _firstButton.texture)
            {
               _firstButton.enabled = false;
            }
            if(_preButton)
            {
               _preButton.enabled = false;
            }
            if(_lastButton && _lastButton.texture)
            {
               _lastButton.enabled = true;
            }
            if(_nextButton)
            {
               _nextButton.enabled = true;
            }
         }
      }
      
      override public function render() : void
      {
         if(validateDic[STYLE])
         {
            updataButton();
            if(_firstButton)
            {
               _firstButton.x = 0;
               _firstButton.y = 0;
               _preButton.x = _space + _firstButton.height;
               _preButton.y = 0;
            }
            else if(_preButton)
            {
               _preButton.x = 0;
               _preButton.y = 0;
            }
            _pageText.defaultTextFormat = _textFormat;
            _pageText.text = _currPage + " / " + _totalPage;
            _pageText.width = _textWidth;
            _pageText.height = _textHeight;
            _pageText.x = _preButton ? _preButton.x + _preButton.width : 0;
            _pageText.y = 0;
            if(_nextButton)
            {
               _nextButton.x = _pageText.x + _pageText.width;
               _nextButton.y = 0;
            }
            if(_lastButton)
            {
               _lastButton.x = _nextButton.x + _nextButton.width + _space;
            }
            if(_pageButtonBg)
            {
               _pageText.y = (_pageButtonBg.height - _pageText.height) / 2;
               _nextButton.y = (_pageButtonBg.height - _nextButton.height) / 2;
               _preButton.y = (_pageButtonBg.height - _preButton.height) / 2;
               if(_firstButton)
               {
                  _firstButton.y = (_pageButtonBg.height - _firstButton.height) / 2;
               }
               if(_lastButton)
               {
                  _lastButton.y = (_pageButtonBg.height - _lastButton.height) / 2;
               }
            }
         }
      }
      
      private function onLastHandle(param1:MouseEvent) : void
      {
         _currPage = _totalPage;
         validate(STYLE);
         if(_onChangeCallBack != null)
         {
            _onChangeCallBack.call();
         }
      }
      
      private function onFirstHandle(param1:MouseEvent) : void
      {
         _currPage = 1;
         validate(STYLE);
         if(_onChangeCallBack != null)
         {
            _onChangeCallBack.call();
         }
      }
      
      override public function __onAfterProp() : void
      {
      }
      
      private function onNextHandle(param1:MouseEvent) : void
      {
         if(_currPage < _totalPage)
         {
            _currPage = _currPage + 1;
            _pageText.text = _currPage + " / " + _totalPage;
            _preButton.enabled = true;
            if(_firstButton)
            {
               _firstButton.enabled = true;
            }
            if(_onChangeCallBack != null)
            {
               _onChangeCallBack.call();
            }
         }
         else
         {
            _nextButton.enabled = false;
         }
      }
      
      private function onPreHandle(param1:MouseEvent) : void
      {
         if(_currPage > 1)
         {
            _currPage = _currPage - 1;
            _pageText.text = _currPage + " / " + _totalPage;
            _nextButton.enabled = true;
            if(_onChangeCallBack != null)
            {
               _onChangeCallBack.call();
            }
         }
         else
         {
            _preButton.enabled = false;
         }
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set totalPage(param1:int) : void
      {
         if(param1 >= 1)
         {
            _totalPage = param1;
         }
         else
         {
            _totalPage = 1;
         }
         _pageText.text = _currPage + " / " + _totalPage;
         updataButton();
      }
      
      public function set font(param1:String) : void
      {
         _textFormat.font = param1;
      }
      
      public function get font() : String
      {
         return _textFormat.font;
      }
      
      public function set size(param1:Object) : void
      {
         _textFormat.size = param1;
      }
      
      public function get size() : Object
      {
         return _textFormat.size;
      }
      
      public function set color(param1:Object) : void
      {
         _textFormat.color = param1;
      }
      
      public function set bold(param1:Object) : void
      {
         _textFormat.bold = param1;
      }
      
      public function get bold() : Object
      {
         return _textFormat.bold;
      }
      
      override public function dispose() : void
      {
         if(_preButton)
         {
            _preButton.dispose();
            if(_preButton.parent == this)
            {
               removeChild(_preButton);
            }
         }
         if(_nextButton)
         {
            _nextButton.dispose();
            if(_nextButton.parent == this)
            {
               removeChild(_nextButton);
            }
         }
         if(_pageButtonBg && _pageButtonBg.bitmapData)
         {
            _pageButtonBg.bitmapData.dispose();
         }
         super.dispose();
         _pageButtonBg = null;
         _onChangeCallBack = null;
      }
      
      public function get textWidth() : Number
      {
         return _textWidth;
      }
      
      public function set textWidth(param1:Number) : void
      {
         _textWidth = param1;
      }
      
      public function get textHeight() : Number
      {
         return _textHeight;
      }
      
      public function set textHeight(param1:Number) : void
      {
         _textHeight = param1;
      }
      
      public function get currPage() : int
      {
         return _currPage;
      }
      
      public function set currPage(param1:int) : void
      {
         if(param1 >= 1 && param1 < _totalPage)
         {
            _currPage = param1;
         }
         else
         {
            _currPage = param1 < 1 ? 1 : _totalPage;
         }
         _pageText.text = _currPage + " / " + _totalPage;
         updataButton();
      }
      
      public function get onChangeCallBack() : Function
      {
         return _onChangeCallBack;
      }
      
      public function set onChangeCallBack(param1:Function) : void
      {
         _onChangeCallBack = param1;
      }
   }
}

