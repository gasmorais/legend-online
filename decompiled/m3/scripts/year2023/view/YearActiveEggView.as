package year2023.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.YearActiveManager;
   import mvc.module.year2023.YearActiveModel;
   import year2023.item.YearActivePointItem;
   import year2023.ui.item.YearActiveLeftItemUI;
   import year2023.ui.item.YearActiveRightItemUI;
   import year2023.ui.view.YearActiveEggViewUI;
   import yishi.datas.templates.SpeicalRewardTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class YearActiveEggView extends YearActiveEggViewUI
   {
      
      private var _probarMask:Shape;
      
      private var _proPos:Bitmap;
      
      private var _maxlv:int;
      
      private var _probarBottom:int;
      
      private var _leftArr:Array = [];
      
      private var _rightArr:Array = [];
      
      private var _onceNum:int;
      
      private var _goldPrice:YearActivePointItem;
      
      private var isPlayMc:Boolean = false;
      
      public function YearActiveEggView()
      {
         super();
         addView();
         initData();
         initEvent();
         _eggPlayMc.gotoAndStop(1);
      }
      
      private function addView() : void
      {
         _goldPrice = ComponentFactory.Instance.creatCustomObject("ui.yearactive.enterGoldPrice");
         addChild(_goldPrice);
      }
      
      private function initData() : void
      {
         var _loc2_:YearActiveLeftItemUI = null;
         var _loc8_:YearActiveRightItemUI = null;
         var _loc4_:SpeicalRewardTempInfo = null;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:String = YearActiveManager.ins.openTime;
         var _loc7_:String = YearActiveManager.ins.stopTime;
         _eggTimeTxt.text = LanguageMgr.GetTranslation("SevenYear.time",_loc9_,_loc7_);
         _onceNum = TempleteManager.instance.getConfigValue("year_gacha_extract");
         _eggnum2.text = "" + _onceNum;
         _eggnum2_2.text = "" + _onceNum * 10;
         _eggnum3.text = "" + TempleteManager.instance.getConfigValue("year_gacha_buy");
         _probarBottom = _proBar.y + _proBar.height;
         _proPos = ComponentFactory.Instance.creatBitmap("asset.yearactive.egg.pos");
         _proPos.x = 202;
         _probarMask = new Shape();
         _probarMask.graphics.beginFill(16711680);
         _probarMask.graphics.drawRect(0,0,_proBar.width,1);
         _probarMask.graphics.endFill();
         _probarMask.x = _proBar.x;
         _probarMask.y = _probarBottom - 1;
         _proPos.y = _probarMask.y - 15;
         addChild(_probarMask);
         addChild(_proPos);
         _proBar.mask = _probarMask;
         _eggft1.text = LanguageMgr.GetTranslation("yearactivity.egg.hasDoFt");
         var _loc10_:Array = TempleteManager.instance.theseusPvpRewardCate.getListByType(4);
         var _loc3_:int = int(_loc10_.length);
         var _loc5_:SpeicalRewardTempInfo = _loc10_[_loc3_ - 1];
         _maxlv = _loc5_.Gear;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = _loc10_[_loc6_];
            _loc1_ = _loc4_.Gear / _maxlv * _proBar.height;
            if(_loc6_ % 2 == 0)
            {
               _loc2_ = new YearActiveLeftItemUI();
               _leftArr.push(_loc2_);
               addChild(_loc2_);
               _loc2_.data = _loc4_;
               _loc2_.x = 66;
               _loc2_.y = _probarBottom - 30 - _loc1_;
            }
            else
            {
               _loc8_ = new YearActiveRightItemUI();
               _rightArr.push(_loc8_);
               addChild(_loc8_);
               _loc8_.data = _loc10_[_loc6_];
               _loc8_.x = 240;
               _loc8_.y = _probarBottom - 30 - _loc1_;
            }
            _loc6_++;
         }
         updateProgress();
      }
      
      private function updateProgress() : void
      {
         var _loc1_:int = model.eggCount / _maxlv * _proBar.height;
         if(_loc1_ > _proBar.height)
         {
            _loc1_ = _proBar.height;
         }
         _probarMask.graphics.clear();
         _probarMask.graphics.beginFill(16711680);
         _probarMask.graphics.drawRect(0,0,_proBar.width,_loc1_);
         _probarMask.graphics.endFill();
         _probarMask.y = _probarBottom - _loc1_;
         _proPos.y = _probarMask.y - 15;
         _eggNum1.text = "" + model.eggCount;
      }
      
      private function get model() : YearActiveModel
      {
         return YearActiveManager.ins.model;
      }
      
      private function __pumpResultHandler() : void
      {
         _eggPlayMc.gotoAndPlay(1);
         isPlayMc = true;
         _eggBtn10.enable = false;
         _eggBtn1.enable = false;
         TweenMax.to(_eggPlayMc,1.8,{
            "frame":_eggPlayMc.totalFrames - 1,
            "onComplete":movieOverHandler
         });
      }
      
      private function movieOverHandler() : void
      {
         isPlayMc = false;
         _eggBtn10.enable = true;
         _eggBtn1.enable = true;
         if(_eggPlayMc)
         {
            _eggPlayMc.gotoAndStop(1);
         }
      }
      
      private function initEvent() : void
      {
         if(_eggBtn10)
         {
            _eggBtn10.addEventListener("click",_pump10BtnClickHandler);
         }
         if(_eggBtn1)
         {
            _eggBtn1.addEventListener("click",_pumpBtn1ClickHandler);
         }
         _eggRechargeBtn.addEventListener("click",rechargeClickHandler);
         _eggPreBtn.addEventListener("click",rewardClickhandler);
         NotificationManager.instance.addEventListener("EVENT_YEARACTIVITY_OP",updateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         if(_eggBtn10)
         {
            _eggBtn10.removeEventListener("click",_pump10BtnClickHandler);
         }
         if(_eggBtn1)
         {
            _eggBtn1.removeEventListener("click",_pumpBtn1ClickHandler);
         }
         _eggRechargeBtn.removeEventListener("click",rechargeClickHandler);
         _eggPreBtn.removeEventListener("click",rewardClickhandler);
         NotificationManager.instance.removeEventListener("EVENT_YEARACTIVITY_OP",updateInfoHandler);
      }
      
      private function rewardClickhandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("yearactive","Egg_Drop");
      }
      
      private function rechargeClickHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         updateProgress();
         __pumpResultHandler();
      }
      
      private function _pump10BtnClickHandler(param1:MouseEvent) : void
      {
         if(_goldPrice.hasYearGold < _onceNum * 10)
         {
            showBuyAlert();
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("yearactivity.PumpingJoy.ContentText",_onceNum * 10,10);
         SharedManagerHelper.ins.needAlert("yearactive.PumpingJoy.pumpCount1",pumpbtn10CallHandler,_loc2_,_loc3_);
      }
      
      private function pumpbtn10CallHandler() : void
      {
         _eggBtn10.enable = false;
         _eggBtn1.enable = false;
         YearActiveManager.ins.doSomething(10,10);
      }
      
      private function _pumpBtn1ClickHandler(param1:MouseEvent) : void
      {
         if(_goldPrice.hasYearGold < _onceNum)
         {
            showBuyAlert();
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("yearactivity.PumpingJoy.ContentText",_onceNum,1);
         SharedManagerHelper.ins.needAlert("yearactive.PumpingJoy.pumpCount2",pumpbtn1CallHandler,_loc2_,_loc3_);
      }
      
      private function showBuyAlert() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("yearactive.look.noGoldtoBuy");
         SimpleAlertHelper.instance.data = [__alertResponse];
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,false,true);
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("yearactive","Shop");
            FrameControllerManager.instance.yearactiveContrl.setPreFrame("yearactive","Egg");
         }
      }
      
      private function pumpbtn1CallHandler() : void
      {
         _eggBtn10.enable = false;
         _eggBtn1.enable = false;
         YearActiveManager.ins.doSomething(10,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_eggPlayMc)
         {
            TweenMax.killTweensOf(_eggPlayMc);
         }
         for each(var _loc1_:YearActiveLeftItemUI in _leftArr)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _leftArr = null;
         for each(var _loc2_:YearActiveRightItemUI in _rightArr)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _rightArr = null;
         ObjectUtils.disposeObject(_goldPrice);
         _goldPrice = null;
         super.dispose();
      }
   }
}

