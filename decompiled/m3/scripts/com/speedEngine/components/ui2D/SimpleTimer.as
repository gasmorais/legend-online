package com.speedEngine.components.ui2D
{
   import flash.events.Event;
   import flash.globalization.DateTimeFormatter;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class SimpleTimer extends TinyUI
   {
      
      public static const DESC:String = "desc";
      
      public static const ASC:String = "asc";
      
      private var _type:String = "desc";
      
      private var _startTimer:String;
      
      private var _currTimer:String;
      
      private var _timerFormat:String = "HH:mm:ss";
      
      private var _timerNum:SimpleNumber;
      
      private var _timerText:SimpleTextField;
      
      private var _textFormat:TextFormat;
      
      private var _timerNumberOffset:int;
      
      private var _vheight:Number;
      
      private var _vwidth:Number;
      
      private var _timer:Timer;
      
      private var _date:Date;
      
      private var _dtf:DateTimeFormatter;
      
      private var _pause:Boolean;
      
      public function SimpleTimer()
      {
         super();
         _dtf = new DateTimeFormatter("en-US");
         _dtf.setDateTimePattern(_timerFormat);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",onTimer);
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      protected function onTimer(param1:Event) : void
      {
         if(_type == "desc")
         {
            _date.time -= 1000;
         }
         else if(_type == "asc")
         {
            _date.time += 1000;
         }
         setText(_dtf.format(_date));
      }
      
      private function setText(param1:String) : void
      {
         _currTimer = param1;
         if(_timerNum)
         {
            _timerNum.text = param1;
         }
         else
         {
            if(_timerText == null)
            {
               newTextField();
            }
            _timerText.textFormat = _textFormat;
            _timerText.text = param1;
         }
         if(int(_currTimer.split(":").join("")) == 0)
         {
            _timer.stop();
            this.dispatchEvent(new Event("change"));
         }
      }
      
      public function set numResPath(param1:String) : void
      {
         if(_timerNum == null)
         {
            newNumber();
         }
         _timerNum.resPath = param1;
      }
      
      private function newNumber() : void
      {
         if(_timerNum == null)
         {
            _timerNum = new SimpleNumber();
         }
         _timerNum.align = "center";
         _timerNum.gap = _timerNumberOffset;
         addChild(_timerNum);
      }
      
      private function newTextField() : void
      {
         if(_timerText == null)
         {
            _timerText = new SimpleTextField();
         }
         if(_textFormat == null)
         {
            _textFormat = new TextFormat();
         }
         _timerText.width = _vwidth;
         _timerText.height = _vheight + 5;
         _timerText.textFormat = _textFormat;
         _timerText.align = "center";
         addChild(_timerText);
      }
      
      public function set startTimer(param1:String) : void
      {
         _startTimer = param1;
         var _loc2_:Date = new Date();
         _date = new Date(_loc2_.fullYearUTC + "/" + _loc2_.monthUTC + "/" + _loc2_.dateUTC + " " + param1);
      }
      
      public function get startTimer() : String
      {
         return _startTimer;
      }
      
      public function start() : void
      {
         _timer.start();
      }
      
      public function pause() : void
      {
         _timer.stop();
      }
      
      override public function set height(param1:Number) : void
      {
         _vheight = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         _vwidth = param1;
      }
      
      public function set font(param1:String) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.font = param1;
      }
      
      public function set size(param1:Object) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.size = param1;
      }
      
      public function set color(param1:Object) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.color = param1;
      }
      
      public function set bold(param1:Object) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.bold = param1;
      }
      
      override public function __onAfterProp() : void
      {
         setText(_dtf.format(_date));
      }
      
      public function get timerFormat() : String
      {
         return _timerFormat;
      }
      
      public function set timerFormat(param1:String) : void
      {
         _timerFormat = param1;
         _dtf.setDateTimePattern(_timerFormat);
      }
      
      override public function dispose() : void
      {
         if(_timerNum)
         {
            _timerNum.dispose();
            if(_timerNum.parent == this)
            {
               removeChild(_timerNum);
            }
         }
         if(_timerText)
         {
            _timerText.dispose();
            if(_timerText.parent == this)
            {
               removeChild(_timerText);
            }
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTimer);
         }
         super.dispose();
         _timerNum = null;
         _timerText = null;
         _textFormat = null;
         _timer = null;
         _dtf = null;
         _date = null;
      }
   }
}

