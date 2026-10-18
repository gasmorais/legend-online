package offerreward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.OfferRewardManager;
   import mvc.module.buildings.OfferRewardModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotAlertManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class OfferTimeView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _time:TimeDownView;
      
      private var _quickRefreshBtn:IconButton;
      
      private var _freeRefreshBtn:IconButton;
      
      private var _freeCountTxt:FilterFrameText;
      
      private var _lastRefTime:Number;
      
      private var _freshRward:int;
      
      private var _allReward:int;
      
      private var _allFinishBtn:IconButton;
      
      public function OfferTimeView()
      {
         super();
         initView();
         initData();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.offerReward.UpdateTimeBg");
         _time = ComponentFactory.Instance.creatComponentByStylename("offerReward.TaskUpdateTime");
         _allFinishBtn = ComponentFactory.Instance.creatComponentByStylename("offerReward.AllFinishBtn");
         _quickRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("offerReward.QuickRefreshBtn");
         _freeRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("offerReward.FreeRefreshBtn");
         _freeCountTxt = ComponentFactory.Instance.creatComponentByStylename("offerReward.FreeCountTxt");
         addChild(_bg);
         addChild(_time);
         addChild(_allFinishBtn);
         _freshRward = int(TempleteManager.instance.getConfigInfoByConfigName("Fresh_Rward").ConfigValue);
         _allReward = int(TempleteManager.instance.getConfigInfoByConfigName("Reward_OneKey").ConfigValue);
         _quickRefreshBtn.tipData = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTimeView.tip01",_freshRward);
         _allFinishBtn.tipData = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTimeView.tip02",rewardModel.maxRewardCount);
      }
      
      private function initData() : void
      {
         refreshView();
      }
      
      private function addEvent() : void
      {
         _quickRefreshBtn.addEventListener("click",__onQuickRefreshClick);
         _freeRefreshBtn.addEventListener("click",__onFreeRefreshClick);
         _allFinishBtn.addEventListener("click",__allFinishClick);
         _time.addEventListener("timerDown_complete",__timeCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         _quickRefreshBtn.removeEventListener("click",__onQuickRefreshClick);
         _freeRefreshBtn.removeEventListener("click",__onFreeRefreshClick);
         _allFinishBtn.removeEventListener("click",__allFinishClick);
         _time.removeEventListener("timerDown_complete",__timeCompleteHandler);
      }
      
      private function __onQuickRefreshClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         _lastRefTime = rewardModel.lastRefreshRewardListTime;
         if(OfferRewardManager.instance.model.hasOrangeTaskNotComplete)
         {
            SimpleAlertHelper.instance.data = [quickRefreshCallBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTimeView.content2");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
         }
         else
         {
            quickRefresh();
         }
      }
      
      private function quickRefreshCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1 && _lastRefTime == rewardModel.lastRefreshRewardListTime)
         {
            quickRefresh();
         }
      }
      
      private function quickRefresh() : void
      {
         if(quickRefreshAlert(startRefreshAlertBack))
         {
            return;
         }
         var _loc1_:int = int(playerInfo.point);
         if(SharedManager.instance.offerRewardRefreshUseBind)
         {
            _loc1_ = playerInfo.point + playerInfo.giftToken;
         }
         if(_loc1_ < _freshRward)
         {
            RechargeAlertMannager.show();
            return;
         }
         refreshRewardListPayCall(true,SharedManager.instance.offerRewardRefreshUseBind);
      }
      
      private function quickRefreshAlert(param1:Function = null) : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:Date = SharedManager.instance.offerRewardRefreshCheckDate;
         var _loc6_:Boolean = Boolean(SharedManager.instance.offerRewardRefresh);
         var _loc5_:Date = new Date();
         var _loc2_:Boolean = false;
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("offerReward.RefreshAlertFrame");
            _loc7_ = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyTimeView.quickRefreshTip",_freshRward);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc3_,startRefreshAlertBack);
         }
         return _loc2_;
      }
      
      private function startRefreshAlertBack(param1:Boolean, param2:Boolean) : void
      {
         SharedManager.instance.offerRewardRefresh = param1;
         SharedManager.instance.offerRewardRefreshCheckDate = new Date();
         SharedManager.instance.offerRewardRefreshUseBind = param2;
         refreshRewardListPayCall(true,param2);
      }
      
      private function refreshRewardListPayCall(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1 && _lastRefTime == rewardModel.lastRefreshRewardListTime)
         {
            _loc3_ = int(playerInfo.point);
            if(param2)
            {
               _loc3_ = playerInfo.point + playerInfo.giftToken;
            }
            if(_loc3_ < _freshRward)
            {
               RechargeAlertMannager.show();
               return;
            }
            OfferRewardManager.instance.sendRefreshRewardList(true,param2);
            OfferRewardModel.isFirstPay = false;
         }
      }
      
      private function __onFreeRefreshClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         _lastRefTime = rewardModel.lastRefreshRewardListTime;
         if(OfferRewardManager.instance.model.hasOrangeTaskNotComplete)
         {
            SimpleAlertHelper.instance.data = [confirmRefreshTaskListCallback];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTimeView.content2");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
         }
         else
         {
            OfferRewardManager.instance.sendRefreshRewardList(true,SharedManager.instance.offerRewardRefreshUseBind);
         }
      }
      
      private function __allFinishClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(ArmyManager.instance.thane.grades < 40)
         {
            _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",40);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc4_:String = LanguageMgr.GetTranslation("offerreward.view.quickFinishTip",_allReward);
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         NotAlertManager.ins.needAlert("offerreward.view.OfferTimeView",allFinishCallBack,_loc3_,_loc4_);
      }
      
      private function allFinishCallBack(param1:Boolean) : void
      {
         var timeId:int;
         var useBind:Boolean = param1;
         var hasMoney:int = int(playerInfo.point);
         if(useBind)
         {
            hasMoney = playerInfo.point + playerInfo.giftToken;
         }
         if(hasMoney < _allReward)
         {
            RechargeAlertMannager.show();
            return;
         }
         OfferRewardManager.instance.sendAllFinishRequest(useBind);
         OfferRewardManager.instance.isAllFinish = true;
         timeId = int(setTimeout(function():void
         {
            clearTimeout(timeId);
            OfferRewardManager.instance.isAllFinish = false;
         },500));
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         OfferRewardManager.instance.sendRefreshRewardList(false,true);
      }
      
      private function confirmRefreshTaskListCallback(param1:Boolean, param2:Boolean) : void
      {
         if(param1 && _lastRefTime == rewardModel.lastRefreshRewardListTime)
         {
            OfferRewardManager.instance.sendRefreshRewardList(true,param2);
         }
      }
      
      public function refreshView() : void
      {
         _time.timeCount = rewardModel.refreshRemainTime;
         _freeRefreshBtn.enable = _quickRefreshBtn.enable = rewardModel.hasData;
         if(rewardModel.freeRefreshCount >= 2)
         {
            addChild(_quickRefreshBtn);
            if(_freeRefreshBtn.parent)
            {
               _freeRefreshBtn.parent.removeChild(_freeRefreshBtn);
            }
            if(_freeCountTxt.parent)
            {
               _freeCountTxt.parent.removeChild(_freeCountTxt);
            }
         }
         else
         {
            _freeCountTxt.text = LanguageMgr.GetTranslation("public.parentheses1",2 - rewardModel.freeRefreshCount);
            addChild(_freeRefreshBtn);
            addChild(_freeCountTxt);
            if(_quickRefreshBtn.parent)
            {
               _quickRefreshBtn.parent.removeChild(_quickRefreshBtn);
            }
         }
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_quickRefreshBtn);
         _quickRefreshBtn = null;
         ObjectUtils.disposeObject(_freeRefreshBtn);
         _freeRefreshBtn = null;
         ObjectUtils.disposeObject(_allFinishBtn);
         _allFinishBtn = null;
         ObjectUtils.disposeObject(_freeCountTxt);
         _freeCountTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

