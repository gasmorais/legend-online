package com.pickgliss.ui
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import flash.events.Event;
   
   public final class AlertManager
   {
      
      private static var _instance:AlertManager;
      
      public static var DEFAULT_CONFIRM_LABEL:String = "确定";
      
      private var _layerType:int;
      
      private var _simpleAlertInfo:AlertInfo;
      
      public function AlertManager()
      {
         super();
      }
      
      public static function get Instance() : AlertManager
      {
         if(_instance == null)
         {
            _instance = new AlertManager();
         }
         return _instance;
      }
      
      public function set layerType(param1:int) : void
      {
         _layerType = param1;
      }
      
      public function alert(param1:String, param2:AlertInfo, param3:int = 2) : BaseAlerFrame
      {
         var _loc4_:BaseAlerFrame = ComponentFactory.Instance.creat(param1);
         _loc4_.addEventListener("propertiesChanged",__onAlertSizeChanged);
         _loc4_.addEventListener("removedFromStage",__onAlertRemoved);
         _loc4_.info = param2;
         LayerManager.Instance.addToLayer(_loc4_,_layerType,_loc4_.info.frameCenter,true,param3);
         StageReferance.stage.focus = _loc4_;
         return _loc4_;
      }
      
      private function __onAlertRemoved(param1:Event) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("propertiesChanged",__onAlertSizeChanged);
         _loc2_.removeEventListener("removedFromStage",__onAlertRemoved);
      }
      
      private function __onAlertSizeChanged(param1:ComponentEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(_loc2_.info.frameCenter)
         {
            _loc2_.x = (StageReferance.stageWidth - _loc2_.width) / 2;
            _loc2_.y = (StageReferance.stageHeight - _loc2_.height) / 2;
         }
      }
      
      public function setup(param1:int, param2:AlertInfo) : void
      {
         _simpleAlertInfo = param2;
         _layerType = param1;
      }
      
      public function simpleAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:String = "", param10:Function = null, param11:String = "SimpleAlert") : BaseAlerFrame
      {
         if(StringUtils.isEmpty(param3))
         {
            param3 = DEFAULT_CONFIRM_LABEL;
         }
         var _loc12_:AlertInfo = new AlertInfo();
         ObjectUtils.copyProperties(_loc12_,_simpleAlertInfo);
         _loc12_.closeSoundFunc = _simpleAlertInfo.closeSoundFunc;
         _loc12_.submitSoundFunc = _simpleAlertInfo.submitSoundFunc;
         _loc12_.data = param2;
         _loc12_.autoDispose = param5;
         _loc12_.title = param1;
         _loc12_.submitLabel = param3;
         _loc12_.cancelLabel = param4;
         _loc12_.enableHtml = param6;
         _loc12_.mutiline = param7;
         _loc12_.smallTip = param9;
         _loc12_.smallTipCall = param10;
         if(StringUtils.isEmpty(param4))
         {
            _loc12_.showCancel = false;
         }
         return alert(param11,_loc12_,param8);
      }
      
      public function functionAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:String = "", param10:Function = null) : BaseAlerFrame
      {
         if(StringUtils.isEmpty(param3))
         {
            param3 = DEFAULT_CONFIRM_LABEL;
         }
         var _loc11_:AlertInfo = new AlertInfo();
         ObjectUtils.copyProperties(_loc11_,_simpleAlertInfo);
         _loc11_.closeSoundFunc = _simpleAlertInfo.closeSoundFunc;
         _loc11_.submitSoundFunc = _simpleAlertInfo.submitSoundFunc;
         _loc11_.textShowWidth = 350;
         _loc11_.data = param2;
         _loc11_.autoDispose = param5;
         _loc11_.title = param1;
         _loc11_.submitLabel = param3;
         _loc11_.cancelLabel = param4;
         _loc11_.enableHtml = param6;
         _loc11_.mutiline = param7;
         _loc11_.smallTip = param9;
         _loc11_.smallTipCall = param10;
         if(StringUtils.isEmpty(param4))
         {
            _loc11_.showCancel = false;
         }
         return alert(ComponentSetting.FUNCTION_ALERT_STLE,_loc11_,param8);
      }
      
      public function useBindPointAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:String = "", param10:Function = null, param11:Object = null, param12:Number = 350) : BaseAlerFrame
      {
         if(StringUtils.isEmpty(param3))
         {
            param3 = DEFAULT_CONFIRM_LABEL;
         }
         var _loc13_:AlertInfo = new AlertInfo();
         ObjectUtils.copyProperties(_loc13_,_simpleAlertInfo);
         _loc13_.closeSoundFunc = _simpleAlertInfo.closeSoundFunc;
         _loc13_.submitSoundFunc = _simpleAlertInfo.submitSoundFunc;
         _loc13_.textShowWidth = param12;
         _loc13_.data = param2;
         _loc13_.autoDispose = param5;
         _loc13_.title = param1;
         _loc13_.submitLabel = param3;
         _loc13_.cancelLabel = param4;
         _loc13_.enableHtml = param6;
         _loc13_.mutiline = param7;
         _loc13_.smallTip = param9;
         _loc13_.smallTipCall = param10;
         _loc13_.extraData = param11;
         if(StringUtils.isEmpty(param4))
         {
            _loc13_.showCancel = false;
         }
         return alert(ComponentSetting.USEBINDPOINT_ALERT_STYLE,_loc13_,param8);
      }
      
      public function chatInvieAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:String = "", param10:Function = null, param11:Object = null, param12:Number = 350) : BaseAlerFrame
      {
         if(StringUtils.isEmpty(param3))
         {
            param3 = DEFAULT_CONFIRM_LABEL;
         }
         var _loc13_:AlertInfo = new AlertInfo();
         ObjectUtils.copyProperties(_loc13_,_simpleAlertInfo);
         _loc13_.closeSoundFunc = _simpleAlertInfo.closeSoundFunc;
         _loc13_.submitSoundFunc = _simpleAlertInfo.submitSoundFunc;
         _loc13_.textShowWidth = param12;
         _loc13_.data = param2;
         _loc13_.autoDispose = param5;
         _loc13_.title = param1;
         _loc13_.submitLabel = param3;
         _loc13_.cancelLabel = param4;
         _loc13_.enableHtml = param6;
         _loc13_.mutiline = param7;
         _loc13_.smallTip = param9;
         _loc13_.smallTipCall = param10;
         _loc13_.extraData = param11;
         if(StringUtils.isEmpty(param4))
         {
            _loc13_.showCancel = false;
         }
         return alert(ComponentSetting.CHATINVIE_ALERT_STYLE,_loc13_,param8);
      }
      
      public function useBindPointWithChoiceAutoLayoutAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:String = "", param10:Function = null, param11:Object = null, param12:Number = 350, param13:String = "", param14:String = "") : BaseAlerFrame
      {
         if(StringUtils.isEmpty(param3))
         {
            param3 = DEFAULT_CONFIRM_LABEL;
         }
         var _loc15_:AlertInfo = new AlertInfo();
         ObjectUtils.copyProperties(_loc15_,_simpleAlertInfo);
         _loc15_.closeSoundFunc = _simpleAlertInfo.closeSoundFunc;
         _loc15_.submitSoundFunc = _simpleAlertInfo.submitSoundFunc;
         _loc15_.textShowWidth = param12;
         _loc15_.data = param2;
         _loc15_.autoDispose = param5;
         _loc15_.title = param1;
         _loc15_.submitLabel = param3;
         _loc15_.cancelLabel = param4;
         _loc15_.enableHtml = param6;
         _loc15_.mutiline = param7;
         _loc15_.smallTip = param9;
         _loc15_.smallTipCall = param10;
         _loc15_.choiceString = param13;
         _loc15_.useBindTip = param14;
         _loc15_.extraData = param11;
         if(StringUtils.isEmpty(param4))
         {
            _loc15_.showCancel = false;
         }
         return alert(ComponentSetting.USEBINDPOINT_WITHCHOICE_AUTOLAYOUT_ALERT_STYLE,_loc15_,param8);
      }
   }
}

