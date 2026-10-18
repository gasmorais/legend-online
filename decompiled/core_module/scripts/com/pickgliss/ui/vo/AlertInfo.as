package com.pickgliss.ui.vo
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentSetting;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class AlertInfo extends EventDispatcher
   {
      
      public static const CANCEL_LABEL:String = "取消";
      
      public static const SUBMIT_LABEL:String = "确定";
      
      private var _customPos:Point;
      
      private var _autoButtonGape:Boolean = true;
      
      private var _autoDispose:Boolean = false;
      
      private var _smallTip:String;
      
      private var _smallTipCall:Function;
      
      private var _bottomGap:int;
      
      private var _buttonGape:int = ComponentSetting.ALERT_BUTTON_GAPE;
      
      private var _cancelLabel:String = "取消";
      
      private var _data:Object;
      
      private var _enableHtml:Boolean;
      
      private var _enterEnable:Boolean = true;
      
      private var _escEnable:Boolean = true;
      
      private var _frameCenter:Boolean = true;
      
      private var _moveEnable:Boolean = true;
      
      private var _mutiline:Boolean;
      
      private var _showCancel:Boolean = true;
      
      private var _showSubmit:Boolean = true;
      
      private var _submitLabel:String = "确定";
      
      private var _textShowHeight:int;
      
      private var _textShowWidth:int;
      
      private var _title:String;
      
      private var _closeSoundFunc:Function;
      
      private var _submitSoundFunc:Function;
      
      public var extraData:Object;
      
      public var choiceString:String;
      
      private var _useBindTip:String;
      
      public function AlertInfo(param1:String = "", param2:String = "确定", param3:String = "取消", param4:Boolean = true, param5:Boolean = true, param6:Object = null, param7:Boolean = true, param8:Boolean = true, param9:Boolean = true, param10:Boolean = true, param11:int = 0, param12:int = 30, param13:Boolean = false, param14:String = "", param15:Function = null, param16:String = "")
      {
         super();
         title = param1;
         submitLabel = param2;
         cancelLabel = param3;
         showSubmit = param4;
         showCancel = param5;
         data = param6;
         frameCenter = param7;
         moveEnable = param8;
         enterEnable = param9;
         escEnable = param10;
         bottomGap = param11;
         buttonGape = param12;
         autoDispose = param13;
         smallTip = param14;
         smallTipCall = param15;
         choiceString = param16;
      }
      
      public function get autoButtonGape() : Boolean
      {
         return _autoButtonGape;
      }
      
      public function set autoButtonGape(param1:Boolean) : void
      {
         if(_autoButtonGape == param1)
         {
            return;
         }
         _autoButtonGape = param1;
         fireChange();
      }
      
      public function get autoDispose() : Boolean
      {
         return _autoDispose;
      }
      
      public function set autoDispose(param1:Boolean) : void
      {
         if(_autoDispose == param1)
         {
            return;
         }
         _autoDispose = param1;
         fireChange();
      }
      
      public function get smallTip() : String
      {
         return _smallTip;
      }
      
      public function set smallTip(param1:String) : void
      {
         if(_smallTip == param1)
         {
            return;
         }
         _smallTip = param1;
         fireChange();
      }
      
      public function get smallTipCall() : Function
      {
         return _smallTipCall;
      }
      
      public function set smallTipCall(param1:Function) : void
      {
         if(_smallTipCall == param1)
         {
            return;
         }
         _smallTipCall = param1;
         fireChange();
      }
      
      public function get bottomGap() : int
      {
         return _bottomGap;
      }
      
      public function set bottomGap(param1:int) : void
      {
         if(_bottomGap == param1)
         {
            return;
         }
         _bottomGap = param1;
         fireChange();
      }
      
      public function get buttonGape() : int
      {
         return _buttonGape;
      }
      
      public function set buttonGape(param1:int) : void
      {
         if(_buttonGape == param1)
         {
            return;
         }
         _buttonGape = param1;
         fireChange();
      }
      
      public function get cancelLabel() : String
      {
         return _cancelLabel;
      }
      
      public function set cancelLabel(param1:String) : void
      {
         if(_cancelLabel == param1)
         {
            return;
         }
         _cancelLabel = param1;
         fireChange();
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         fireChange();
      }
      
      public function get enableHtml() : Boolean
      {
         return _enableHtml;
      }
      
      public function set enableHtml(param1:Boolean) : void
      {
         if(_enableHtml == param1)
         {
            return;
         }
         _enableHtml = param1;
         fireChange();
      }
      
      public function get enterEnable() : Boolean
      {
         return _enterEnable;
      }
      
      public function set enterEnable(param1:Boolean) : void
      {
         if(_enterEnable == param1)
         {
            return;
         }
         _enterEnable = param1;
         fireChange();
      }
      
      public function get escEnable() : Boolean
      {
         return _escEnable;
      }
      
      public function set escEnable(param1:Boolean) : void
      {
         if(_escEnable == param1)
         {
            return;
         }
         _escEnable = param1;
         fireChange();
      }
      
      public function get frameCenter() : Boolean
      {
         return _frameCenter;
      }
      
      public function set frameCenter(param1:Boolean) : void
      {
         if(_frameCenter == param1)
         {
            return;
         }
         _frameCenter = param1;
         fireChange();
      }
      
      public function get moveEnable() : Boolean
      {
         return _moveEnable;
      }
      
      public function set moveEnable(param1:Boolean) : void
      {
         if(_moveEnable == param1)
         {
            return;
         }
         _moveEnable = param1;
         fireChange();
      }
      
      public function get mutiline() : Boolean
      {
         return _mutiline;
      }
      
      public function set mutiline(param1:Boolean) : void
      {
         if(_mutiline == param1)
         {
            return;
         }
         _mutiline = param1;
         fireChange();
      }
      
      public function get showCancel() : Boolean
      {
         return _showCancel;
      }
      
      public function set showCancel(param1:Boolean) : void
      {
         if(_showCancel == param1)
         {
            return;
         }
         _showCancel = param1;
         fireChange();
      }
      
      public function get showSubmit() : Boolean
      {
         return _showSubmit;
      }
      
      public function set showSubmit(param1:Boolean) : void
      {
         if(_showSubmit == param1)
         {
            return;
         }
         _showSubmit = param1;
         fireChange();
      }
      
      public function get submitLabel() : String
      {
         return _submitLabel;
      }
      
      public function set submitLabel(param1:String) : void
      {
         if(_submitLabel == param1)
         {
            return;
         }
         _submitLabel = param1;
         fireChange();
      }
      
      public function get textShowHeight() : int
      {
         return _textShowHeight;
      }
      
      public function set textShowHeight(param1:int) : void
      {
         if(_textShowHeight == param1)
         {
            return;
         }
         _textShowHeight = param1;
         fireChange();
      }
      
      public function get textShowWidth() : int
      {
         return _textShowWidth;
      }
      
      public function set textShowWidth(param1:int) : void
      {
         if(_textShowWidth == param1)
         {
            return;
         }
         _textShowWidth = param1;
         fireChange();
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         if(_title == param1)
         {
            return;
         }
         _title = param1;
         fireChange();
      }
      
      public function get closeSoundFunc() : Function
      {
         return _closeSoundFunc;
      }
      
      public function get submitSoundFunc() : Function
      {
         return _submitSoundFunc;
      }
      
      public function set closeSoundFunc(param1:Function) : void
      {
         if(_closeSoundFunc == param1)
         {
            return;
         }
         _closeSoundFunc = param1;
         fireChange();
      }
      
      public function set submitSoundFunc(param1:Function) : void
      {
         if(_submitSoundFunc == param1)
         {
            return;
         }
         _submitSoundFunc = param1;
         fireChange();
      }
      
      private function fireChange() : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      public function get customPos() : Point
      {
         return _customPos;
      }
      
      public function set customPos(param1:Point) : void
      {
         _customPos = param1;
      }
      
      public function get useBindTip() : String
      {
         return _useBindTip;
      }
      
      public function set useBindTip(param1:String) : void
      {
         if(_useBindTip == param1)
         {
            return;
         }
         _useBindTip = param1;
         fireChange();
      }
   }
}

