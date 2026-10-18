package petchallenge.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.VIPEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import mainBar.view.VipCoolDownFrame;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import managers.VIPManager;
   import mvc.module.petchallenge.PetChallengeModel;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   
   public class PetChallengeListView extends Component
   {
      
      private var challengeAlertText:FilterFrameText;
      
      private var nextRefreshTime:FilterFrameText;
      
      private var leftCountText:FilterFrameText;
      
      private var cdTxt:GradientText;
      
      private var coolDownBtn:BaseButton;
      
      private var itemVbox:VBox;
      
      private var lastPageBtn:IconButton;
      
      private var nextPageBtn:IconButton;
      
      private var pageBg:Image;
      
      private var pageTxt:FilterFrameText;
      
      private var pageCount:int = 5;
      
      private var pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var formatStr:String = "{0} / {1}";
      
      private var itemList:Vector.<PetChallengeItemView>;
      
      private var _timer:TimerTicker;
      
      private var _str:String;
      
      public function PetChallengeListView()
      {
         super();
         initView();
         addEvent();
         currentPageNum = 1;
      }
      
      private function initView() : void
      {
         challengeAlertText = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortView.challengeAlertText");
         leftCountText = ComponentFactory.Instance.creatComponentByStylename("PetChallengeCDView.leftCountText");
         cdTxt = ComponentFactory.Instance.creatComponentByStylename("PetChallengeCDView.cdTxt");
         coolDownBtn = ComponentFactory.Instance.creatComponentByStylename("PetChallengeCDView.coolDownBtn");
         nextRefreshTime = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortView.nextRefreshTime");
         pageBg = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortView.PageBg");
         pageTxt = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortView.PageTextStyle");
         lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortView.LastPageBtn");
         nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortView.NextPageBtn");
         itemVbox = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortView.itemVbox");
         addChild(challengeAlertText);
         addChild(leftCountText);
         addChild(cdTxt);
         addChild(coolDownBtn);
         addChild(nextRefreshTime);
         addChild(pageBg);
         addChild(pageTxt);
         addChild(lastPageBtn);
         addChild(nextPageBtn);
         addChild(itemVbox);
         initListView();
         _timer = new TimerTicker(1000);
         cdTxt.text = "";
         coolDownBtn.tipData = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QuickText");
         challengeAlertText.text = LanguageMgr.GetTranslation("PetChallengeSortView.challengeAlertText.text");
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetChallengeItemView = null;
         itemList = new Vector.<PetChallengeItemView>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new PetChallengeItemView();
            itemVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         lastPageBtn.addEventListener("click",__onLastPageHandler);
         nextPageBtn.addEventListener("click",__onNextPageHandler);
         coolDownBtn.addEventListener("click",__coolDownHandler);
         VIPManager.Instance.model.addEventListener("upframeview_change",__upvipInfoHandler);
         model.addEventListener(PetChallengeModel.SORT_LIST_REFRESH,__onRefreshTimeHandler);
         model.addEventListener(PetChallengeModel.FRAME_INDEX_CHANGE,__indexChangeHandler);
         model.addEventListener(PetChallengeModel.CHALLENGE_INFO_CHAGNE,__indexChangeHandler);
         model.buildingOrder.addEventListener("change",__refreshHandler);
      }
      
      private function removeEvent() : void
      {
         lastPageBtn.removeEventListener("click",__onLastPageHandler);
         nextPageBtn.removeEventListener("click",__onNextPageHandler);
         coolDownBtn.removeEventListener("click",__coolDownHandler);
         VIPManager.Instance.model.removeEventListener("upframeview_change",__upvipInfoHandler);
         model.removeEventListener(PetChallengeModel.SORT_LIST_REFRESH,__onRefreshTimeHandler);
         model.removeEventListener(PetChallengeModel.FRAME_INDEX_CHANGE,__indexChangeHandler);
         model.removeEventListener(PetChallengeModel.CHALLENGE_INFO_CHAGNE,__indexChangeHandler);
         model.buildingOrder.removeEventListener("change",__refreshHandler);
         cleanTimer();
      }
      
      private function __refreshHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function __indexChangeHandler(param1:Event) : void
      {
         pageNumMax = Math.ceil(model.getShowList().length / pageCount);
         currentPageNum = 1;
         refreshView();
      }
      
      private function __onRefreshTimeHandler(param1:Event) : void
      {
         if(_timer.hasEventListener("timer") == false)
         {
            _timer.addEventListener("timer",__timerhandler);
         }
         _timer.reset();
         _timer.start();
         pageNumMax = Math.ceil(model.getShowList().length / pageCount);
         currentPageNum = 1;
         refreshView();
      }
      
      private function __coolDownHandler(param1:MouseEvent) : void
      {
         var _loc3_:Array = null;
         var _loc7_:int = 0;
         var _loc4_:VipCoolDownFrame = null;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc9_:BuildingOrderInfo = null;
         SoundManager.instance.play("022");
         if(model.buildingOrder.remainTime <= 0)
         {
            return;
         }
         if(VIPManager.Instance.model.vipCoolPrivilege)
         {
            PetChallengeManager.instance.coolDownChallengeCD();
         }
         else
         {
            _loc3_ = TempleteManager.instance.getConfigInfoByConfigName("Challenge_Cool").ConfigValue.split(",");
            _loc7_ = Math.ceil(model.buildingOrder.remainTime / (60 * _loc3_[1])) * _loc3_[0];
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
            _loc6_ = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipName");
            _loc8_ = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipContent",_loc7_);
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc9_ = PetChallengeManager.instance.model.buildingOrder;
            _loc4_.initData(_loc6_,_loc8_,_loc9_.orderId,_loc7_,_loc7_,coolColosseBack,_loc2_,_loc5_);
            _loc4_.show();
         }
      }
      
      private function coolColosseBack(param1:Boolean, param2:int = 0, param3:int = 1, param4:Boolean = true) : void
      {
         if(model.buildingOrder.remainTime <= 0)
         {
            return;
         }
         if(param1)
         {
            PetChallengeManager.instance.coolDownChallengeCD(param4);
         }
      }
      
      private function __upvipInfoHandler(param1:VIPEvent) : void
      {
         if(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt)
         {
            PetChallengeManager.instance.coolDownChallengeCD();
         }
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshView();
      }
      
      private function __onNextPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetChallengeItemView = null;
         if(model.curSelectIndex == 0)
         {
            challengeAlertText.text = "";
            leftCountText.text = "";
            cdTxt.text = "";
            coolDownBtn.visible = false;
         }
         else if(model.curSelectIndex == 1)
         {
            nextRefreshTime.text = "";
            challengeAlertText.text = LanguageMgr.GetTranslation("PetChallengeSortView.challengeAlertText.text");
            leftCountText.text = LanguageMgr.GetTranslation("PetChallengeSortView.leftCountText.text",model.buildingOrder.remainCount,model.challengeMaxCount);
            if(model.buildingOrder.remainTime > 0)
            {
               cdTxt.text = DateFormatter.getCountDate(model.buildingOrder.remainTime);
               coolDownBtn.visible = true;
            }
            else
            {
               cdTxt.text = "";
               coolDownBtn.visible = false;
            }
         }
         else
         {
            nextRefreshTime.text = "";
            challengeAlertText.text = "";
            leftCountText.text = "";
            cdTxt.text = "";
            coolDownBtn.visible = false;
         }
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = itemList[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = new PetChallengeItemView();
               itemList[_loc2_] = _loc1_;
            }
            _loc1_.data = _loc2_ < currentList.length ? currentList[_loc2_] : null;
            _loc2_++;
         }
      }
      
      public function get currentPageNum() : int
      {
         return _currentPageNum;
      }
      
      public function set currentPageNum(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         if(param1 > pageNumMax)
         {
            return;
         }
         _currentPageNum = param1;
         updatePageInfo();
      }
      
      private function updatePageInfo() : void
      {
         if(lastPageBtn)
         {
            lastPageBtn.enable = currentPageNum > 1;
         }
         if(nextPageBtn)
         {
            nextPageBtn.enable = currentPageNum < pageNumMax;
         }
         if(pageTxt)
         {
            pageTxt.text = StringHelper.format(formatStr,currentPageNum,pageNumMax);
         }
      }
      
      private function get currentList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = (currentPageNum - 1) * pageCount;
         var _loc3_:int = Math.min(_loc1_ + pageCount,model.getShowList().length);
         return model.getShowList().slice(_loc1_,_loc3_);
      }
      
      private function cleanTimer() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__timerhandler);
            _timer.stop();
         }
      }
      
      private function __timerhandler(param1:TimerEvent) : void
      {
         if(model.curSelectIndex != 0)
         {
            return;
         }
         var _loc2_:String = "";
         if(model.nextRefreshTime <= 0)
         {
            nextRefreshTime.text = "";
            cleanTimer();
            return;
         }
         if(model.nextRefreshTime <= playerModel.sysCurTimeBySecond)
         {
            _loc2_ = LanguageMgr.GetTranslation("petchallenge.PetChallengeSortFrame.tipTxt02");
            nextRefreshTime.text = LanguageMgr.GetTranslation("petchallenge.PetChallengeSortFrame.tipTxt01",_loc2_);
         }
         else
         {
            _loc2_ = DateFormatter.getCountDateByMS(int(model.nextRefreshTime - playerModel.sysCurTimeBySecond));
            nextRefreshTime.text = LanguageMgr.GetTranslation("petchallenge.PetChallengeSortFrame.tipTxt01",_loc2_);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         cleanTimer();
         _timer = null;
         removeEvent();
         ObjectUtils.disposeObject(challengeAlertText);
         challengeAlertText = null;
         ObjectUtils.disposeObject(leftCountText);
         leftCountText = null;
         ObjectUtils.disposeObject(cdTxt);
         cdTxt = null;
         ObjectUtils.disposeObject(coolDownBtn);
         coolDownBtn = null;
         ObjectUtils.disposeObject(nextRefreshTime);
         nextRefreshTime = null;
         ObjectUtils.disposeObject(pageBg);
         pageBg = null;
         ObjectUtils.disposeObject(pageTxt);
         pageTxt = null;
         ObjectUtils.disposeObject(lastPageBtn);
         lastPageBtn = null;
         ObjectUtils.disposeObject(nextPageBtn);
         nextPageBtn = null;
         ObjectUtils.disposeObject(itemVbox);
         itemVbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

