package map.campaign.view.ui.emedream
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.frame.ConsortiaEmeDreamRewardFrame;
   
   public class EmeDreamTaskView extends Component
   {
      
      private var _leftTimeBg:ScaleBitmapImage;
      
      private var _timeTxt1:GradientText;
      
      private var _timeTxt2:GradientText;
      
      private var _rewardBtn:BaseButton;
      
      private var _taskHeadImage:MutipleImage;
      
      private var _taskVbox:VBox;
      
      private var _collectImage:Image;
      
      private var _propImage:Image;
      
      private var _taskList:Object = {};
      
      private var _timer:TimerTicker;
      
      private var nodeArr:Array;
      
      private var _shieldBtn:BaseButton;
      
      private var _cancelShieldBtn:BaseButton;
      
      public function EmeDreamTaskView()
      {
         super();
         initView();
         initTaskVbox();
         addEvent();
         refreshView();
         __consortiaSwitchHandler(null,null);
         refreshOthersVisibleBtn(SharedManager.instance.hideOthers);
      }
      
      private function initView() : void
      {
         _leftTimeBg = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossTaskView.leftTimeBg");
         _timeTxt1 = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossTaskView.timeTxt1");
         _timeTxt2 = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossTaskView.timeTxt2");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossTaskView.rewardBtn");
         _taskHeadImage = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossTaskView.taskHeadImage");
         _taskVbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBossTaskView.taskVbox");
         _collectImage = ComponentFactory.Instance.creatComponentByStylename("ConsortiaEmeDreamTaskView.collectImage");
         _propImage = ComponentFactory.Instance.creatComponentByStylename("ConsortiaEmeDreamTaskView.propImage");
         _shieldBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.shieldBtn");
         _cancelShieldBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.cancelShieldBtn");
         _shieldBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.OthersHideBtnTipData");
         _cancelShieldBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.OthersShowBtnTipData");
         _timer = new TimerTicker(1000);
         _timer.start();
         addChild(_shieldBtn);
         addChild(_cancelShieldBtn);
         addChild(_leftTimeBg);
         addChild(_timeTxt1);
         addChild(_timeTxt2);
         addChild(_rewardBtn);
         addChild(_taskHeadImage);
         addChild(_taskVbox);
         addChild(_collectImage);
         addChild(_propImage);
         _rewardBtn.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.gvgcross.reward.showReward");
         _collectImage.tipData = LanguageMgr.GetTranslation("ConsortiaEmeDreamTaskView.collectImage.tipdata");
         _propImage.tipData = LanguageMgr.GetTranslation("ConsortiaEmeDreamTaskView.propImage.tipdata");
      }
      
      private function initTaskVbox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:EmeDreamTaskItem = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("EmeDreamTaskView.taskItem",[_loc2_]);
            _taskList[_loc2_] = _loc1_;
            _taskVbox.addChild(_loc1_);
            _loc2_++;
         }
         _taskVbox.refreshChildPos();
      }
      
      private function uninitView() : void
      {
         _timer = null;
         if(_taskVbox)
         {
            ObjectUtils.disposeAllChildren(_taskVbox);
            ObjectUtils.disposeObject(_taskVbox);
            _taskVbox = null;
         }
         if(_taskList)
         {
            for(var _loc1_:String in _taskList)
            {
               ObjectUtils.disposeObject(_taskList[_loc1_]);
               _taskList[_loc1_] = null;
            }
            _taskList = null;
         }
         ObjectUtils.disposeObject(_leftTimeBg);
         _leftTimeBg = null;
         ObjectUtils.disposeObject(_timeTxt1);
         _timeTxt1 = null;
         ObjectUtils.disposeObject(_timeTxt2);
         _timeTxt2 = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_taskHeadImage);
         _taskHeadImage = null;
         ObjectUtils.disposeObject(_collectImage);
         _collectImage = null;
         ObjectUtils.disposeObject(_propImage);
         _propImage = null;
         ObjectUtils.disposeObject(_taskVbox);
         _taskVbox = null;
         ObjectUtils.disposeObject(_shieldBtn);
         _shieldBtn = null;
         ObjectUtils.disposeObject(_cancelShieldBtn);
         _cancelShieldBtn = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         nodeArr = null;
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,__consortiaSwitchHandler);
         MsgMan.addObserver("CampaignEvent.CONSORTIA_BOSS_STATE_UPDATE",this,__consortiaBossStateUpdateHandler);
         if(_timer)
         {
            _timer.addEventListener("timer",__timerHandler);
         }
         if(_rewardBtn)
         {
            _rewardBtn.addEventListener("click",__rewardClickHandler);
         }
         if(_shieldBtn)
         {
            _shieldBtn.addEventListener("click",__othersShowHander);
         }
         if(_cancelShieldBtn)
         {
            _cancelShieldBtn.addEventListener("click",__othersHideHander);
         }
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,__consortiaSwitchHandler);
         MsgMan.removeObserver("CampaignEvent.CONSORTIA_BOSS_STATE_UPDATE",this,__consortiaBossStateUpdateHandler);
         if(_rewardBtn)
         {
            _rewardBtn.removeEventListener("click",__rewardClickHandler);
         }
         if(_shieldBtn)
         {
            _shieldBtn.removeEventListener("click",__othersShowHander);
         }
         if(_cancelShieldBtn)
         {
            _cancelShieldBtn.removeEventListener("click",__othersHideHander);
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      private function __othersShowHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         refreshOthersVisibleBtn(true);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_OTHERS",true));
      }
      
      private function __othersHideHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         refreshOthersVisibleBtn(false);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_OTHERS",false));
      }
      
      private function refreshOthersVisibleBtn(param1:Boolean = false) : void
      {
         SharedManager.instance.hideOthers = param1;
         if(!SharedManager.instance.hideOthers)
         {
            _shieldBtn.visible = true;
            _cancelShieldBtn.visible = false;
         }
         else
         {
            _shieldBtn.visible = false;
            _cancelShieldBtn.visible = true;
         }
      }
      
      private function __hideOthersHandler(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            refreshOthersVisibleBtn();
         }
      }
      
      private function __consortiaBossStateUpdateHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         _timeTxt2.text = leftTime;
         for each(var _loc1_:EmeDreamTaskItem in _taskList)
         {
            _loc1_.refreshView();
         }
         _taskVbox.refreshChildPos();
         _collectImage.y = _propImage.y = _taskVbox.y + _taskVbox.height + 5;
         if(model.emeDreamInfo.nightmareState == 0)
         {
            _collectImage.tipData = LanguageMgr.GetTranslation("ConsortiaEmeDreamTaskView.collectImage.tipdata1");
            _collectImage.filters = [UIFilter.getGrayFilter()];
         }
         else
         {
            _collectImage.tipData = LanguageMgr.GetTranslation("ConsortiaEmeDreamTaskView.collectImage.tipdata");
            _collectImage.filters = [];
         }
         if(model.emeDreamInfo.sleepState == 0)
         {
            _propImage.tipData = LanguageMgr.GetTranslation("ConsortiaEmeDreamTaskView.propImage.tipdata");
            _propImage.filters = [UIFilter.getGrayFilter()];
         }
         else
         {
            _propImage.tipData = LanguageMgr.GetTranslation("ConsortiaEmeDreamTaskView.propImage.tipdata" + model.emeDreamInfo.sleepState);
            _propImage.filters = [];
         }
      }
      
      private function __rewardClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ConsortiaEmeDreamRewardFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaEmeDream.ConsortiaEmeDreamRewardFrame");
         if(_loc2_)
         {
            _loc2_.show();
         }
      }
      
      private function __consortiaSwitchHandler(param1:String, param2:Object) : void
      {
         nodeArr = CampaignManager.instance.mapModel.mapNodesData;
         if(model.emeDreamInfo.state == 1)
         {
            _timeTxt1.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.consortiaboss.ConsortiaEmeDreamSortView.startTxt");
         }
         else if(model.emeDreamInfo.state == 2)
         {
            _timeTxt1.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.petboss.PetBossSortView.timeTxt");
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _timeTxt2.text = leftTime;
      }
      
      private function get leftTime() : String
      {
         var _loc1_:String = "";
         var _loc3_:int = DateFormatter.parse(model.emeDreamInfo.endTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
         if(model.emeDreamInfo.state == 1)
         {
            _loc3_ -= 1800;
         }
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         if(_loc3_ > _loc2_)
         {
            _loc1_ = DateFormatter.getCountDateByMS(_loc3_ - _loc2_);
         }
         else if(model.emeDreamInfo.state == 1)
         {
            _loc1_ = LanguageMgr.GetTranslation("ui.tasktracebar.view.petboss.PetBossSortView.starStr");
         }
         else if(model.emeDreamInfo.state == 2)
         {
            _loc1_ = LanguageMgr.GetTranslation("ui.tasktracebar.view.petboss.PetBossSortView.endStr");
         }
         return _loc1_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

