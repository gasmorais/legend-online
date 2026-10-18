package com.map.vehicle.view
{
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.events.VehicleEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class VehicleBossDownTimeView extends Component implements IEnterFrame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _text:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _model:VehicleModel;
      
      private var _bossTime:int;
      
      private var _skillTime:int;
      
      private var _riverTime:int;
      
      private var _currentTime:Number = 0;
      
      private var _riverTimeConst:int = 30;
      
      private var _last:Number = 0;
      
      public function VehicleBossDownTimeView()
      {
         super();
         _model = VGlobal.model;
         _riverTimeConst = _model.riverTimeConst;
         _currentTime = PlayerManager.instance.currentPlayerModel.nowDate - _model.campaiganStartTime.time;
         initView();
         addEvent();
         updateTime(2000);
         _last = getTimer();
         this.mouseEnabled = this.mouseChildren = false;
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("VehicleBossDownTimeView.back");
         _text = ComponentFactory.Instance.creatComponentByStylename("VehicleBossDownTimeView.downTimeTxt");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("VehicleBossDownTimeView.downTimeTxt");
         _valueTxt.x = 170;
         _valueTxt.y = 8;
         addChild(_back);
         addChild(_text);
         addChild(_valueTxt);
         _text.htmlText = LanguageMgr.GetTranslation("vehicle.bossDownTime");
         _valueTxt.htmlText = "--:--:--<br/>--:--:--<br/>--:--:--";
      }
      
      public function enterFrame() : void
      {
         var _loc2_:Number = getTimer();
         var _loc1_:Number = _loc2_ - _last;
         if(_loc1_ >= 1000)
         {
            updateTime(_loc1_);
            _last = _loc2_;
         }
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("CAMPAIGN_TIME",__startCountHandler);
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("CAMPAIGN_TIME",__startCountHandler);
         }
      }
      
      private function __startCountHandler(param1:VehicleEvent) : void
      {
         _currentTime = PlayerManager.instance.currentPlayerModel.nowDate - _model.campaiganStartTime.time;
      }
      
      private function updateTime(param1:Number = 1000) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         _currentTime += param1;
         var _loc2_:int = Math.ceil(_currentTime / 1000);
         _bossTime = 300 - _loc2_;
         _skillTime = 180 - _loc2_ % 180;
         _riverTime = _riverTimeConst - _loc2_ % _riverTimeConst;
         if(_bossTime <= 0 || _model.bossRefreshed)
         {
            _bossTime = 0;
            _loc3_ = "--:--:--";
         }
         else
         {
            _loc3_ = DateFormatter.getCountDate(_bossTime);
         }
         if(_skillTime <= 0)
         {
            _skillTime = 180;
         }
         if(_riverTime <= 0)
         {
            _riverTime = _model.riverTimeConst;
         }
         if(_model.remainsTime > 0)
         {
            _loc4_ = DateFormatter.getCountDate(_skillTime);
            _loc4_ = _loc4_ + "<br/>" + DateFormatter.getCountDate(_riverTime);
         }
         else
         {
            _loc4_ = "--:--:--<br/>--:--:--";
         }
         if(_valueTxt)
         {
            _valueTxt.htmlText = _loc3_ + "<br/>" + _loc4_;
         }
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4,false,false,0,1);
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         this.x = _loc1_ - _back.width - 5;
         this.y = 0;
      }
      
      override public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         _model = null;
         super.dispose();
      }
   }
}

