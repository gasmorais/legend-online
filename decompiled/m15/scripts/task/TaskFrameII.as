package task
{
   import battle.BattleManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RingTaskEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.FileReference;
   import flash.net.URLRequest;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import managers.MagicSpringManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import managers.TaskSocketManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import mvc.module.kingcontract.KingContractInfo;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.marry.MarrySender;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskCondictionTemplate;
   import mvc.module.task.TaskTemplate;
   import simplegame.hamster.HamsterGameFrame;
   import simplegame.qte.QTETraining;
   import task.view.TaskDescribeViewII;
   import task.view.TaskMenuII;
   import task.view.TaskMobilePhoneView;
   import task.view.TaskRewardViewII;
   import task.view.TaskTargetViewII;
   import ui.gameroll.TaskGainMovie;
   import yishi.SwitchPageHelp;
   import yishi.datas.VersionSwitch;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class TaskFrameII extends Frame
   {
      
      private var _back1:Scale9CornerImage;
      
      private var _back2:Bitmap;
      
      private var _back3:Image;
      
      private var _back4:Image;
      
      private var _back5:Image;
      
      private var _back6:Image;
      
      private var _taskMenu:TaskMenuII;
      
      private var _vBox:VBox;
      
      private var _taskTarget:TaskTargetViewII;
      
      private var _taskReward:TaskRewardViewII;
      
      private var _taskDescribe:TaskDescribeViewII;
      
      private var _rewardBtn:IconButton;
      
      private var _campaignBtn:IconButton;
      
      private var _giveUpBtn:IconButton;
      
      private var _startPlayBtn:IconButton;
      
      private var _goArrestBtn:IconButton;
      
      private var _dragonTransferBtn:IconButton;
      
      private var _completeNowBtn:IconButton;
      
      private var _clientDownBtn:IconButton;
      
      private var _immediateBtn:IconButton;
      
      private var _buttonMc1:MovieClip;
      
      private var _buttonMc2:MovieClip;
      
      private var _taskTypeIcon:ScaleFrameImage;
      
      private var _taskMobile:TaskMobilePhoneView;
      
      private var info:KingContractInfo;
      
      private var _currentInfo:Object;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      private var _completeBtn:TextButton;
      
      public function TaskFrameII()
      {
         super();
         initView();
         initBufferView();
         initEvent();
         initData();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get button() : BaseButton
      {
         return _rewardBtn;
      }
      
      public function get campaignBtn() : BaseButton
      {
         return _campaignBtn;
      }
      
      private function initData() : void
      {
         _taskMenu.defaultSelected();
      }
      
      public function set selectedByInfo(param1:Object) : void
      {
         _taskMenu.selectedByInfo = param1;
      }
      
      public function show() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("BEHAVIOR_ANALYSIS",this));
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("task.TaskFrameII.title");
         _back2 = ComponentFactory.Instance.creatBitmap("asset.task.TaskFrameIIBack2");
         _back1 = ComponentFactory.Instance.creatComponentByStylename("task.TaskFrameIIBack1");
         _back3 = ComponentFactory.Instance.creatComponentByStylename("task.TaskFrameIIBack3");
         _back4 = ComponentFactory.Instance.creatComponentByStylename("task.TaskFrameIIBack4");
         _back5 = ComponentFactory.Instance.creatComponentByStylename("task.TaskFrameIIBack5");
         _back6 = ComponentFactory.Instance.creatComponentByStylename("task.TaskFrameIIBack6");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("task.TaskRewardBtn");
         _completeNowBtn = ComponentFactory.Instance.creatComponentByStylename("task.TaskCompleteNowBtn");
         _campaignBtn = ComponentFactory.Instance.creatComponentByStylename("task.TaskCampaignBtn");
         _giveUpBtn = ComponentFactory.Instance.creatComponentByStylename("task.TaskGiveUpBtn");
         _goArrestBtn = ComponentFactory.Instance.creatComponentByStylename("task.TaskgoArrestBtn");
         _immediateBtn = ComponentFactory.Instance.creatComponentByStylename("task.ImmediatelyWentBtn");
         _dragonTransferBtn = ComponentFactory.Instance.creatComponentByStylename("task.TaskDragonTransferBtn");
         _taskTypeIcon = ComponentFactory.Instance.creatComponentByStylename("task.TaskScenceIcon");
         _startPlayBtn = ComponentFactory.Instance.creatComponentByStylename("task.TaskStartPlayBtn");
         _clientDownBtn = ComponentFactory.Instance.creatComponentByStylename("task.TaskClientBtn");
         _buttonMc1 = ComponentFactory.Instance.creatCustomObject("task.TaskRewardButtonMc1");
         _buttonMc2 = ComponentFactory.Instance.creatCustomObject("task.TaskRewardButtonMc2");
         _buttonMc1.gotoAndStop(1);
         _buttonMc1["pos"].addChild(_rewardBtn);
         _buttonMc2.gotoAndStop(1);
         _buttonMc2["pos"].addChild(_campaignBtn);
         _buttonMc2["pos"].addChild(_goArrestBtn);
         _buttonMc2["pos"].addChild(_startPlayBtn);
         _buttonMc2["pos"].addChild(_immediateBtn);
         _buttonMc2["pos"].addChild(_dragonTransferBtn);
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_back3);
         addToContent(_back4);
         addToContent(_back5);
         addToContent(_back6);
         addToContent(_buttonMc1);
         addToContent(_buttonMc2);
         addToContent(_clientDownBtn);
         addToContent(_giveUpBtn);
         addToContent(_campaignBtn);
         if(StageReferance.isDebug)
         {
            _completeBtn = ComponentFactory.Instance.creatComponentByStylename("core.UseButton");
            _completeBtn.text = "立即完成";
            addToContent(_completeBtn);
            _completeBtn.addEventListener("click",onCompleteBtnClick);
         }
         if(VersionSwitch.KING_CONTRACT)
         {
            addToContent(_completeNowBtn);
         }
         _campaignBtn.visible = false;
         _giveUpBtn.visible = false;
         _startPlayBtn.visible = false;
         _goArrestBtn.visible = false;
         _clientDownBtn.visible = false;
         _completeNowBtn.visible = false;
         _taskTypeIcon.visible = false;
         _immediateBtn.visible = false;
         _dragonTransferBtn.visible = false;
         _taskMenu = ComponentFactory.Instance.creatCustomObject("task.TaskMenuII");
         addToContent(_taskMenu);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("task.VBox1");
         _taskTarget = ComponentFactory.Instance.creatCustomObject("task.TaskTargetII");
         _taskReward = ComponentFactory.Instance.creatCustomObject("task.askRewardViewII");
         _taskDescribe = ComponentFactory.Instance.creatCustomObject("task.TaskDescribeViewII");
         _vBox.addChild(_taskTarget);
         _vBox.addChild(_taskReward);
         _vBox.addChild(_taskDescribe);
         addToContent(_vBox);
         addToContent(_taskTypeIcon);
         info = KingContractManager.Instance.model.getInfoById(2);
      }
      
      private function initBufferView() : void
      {
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(10);
         if(_loc1_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc1_);
            _bufferView.stopTimer();
            _bufferView.setDescText(_loc1_.tempInfo.Desc);
            _bufferView.x = 670;
            _bufferView.y = 385;
            addToContent(_bufferView);
         }
      }
      
      private function onCompleteBtnClick(param1:MouseEvent) : void
      {
         TaskSocketManager.sendGetTaskReward(_currentInfo.TemplateId,0,true);
      }
      
      private function __showPhone() : void
      {
         if(!parent || _currentInfo.conditionList[0].CondictionType != 48)
         {
            return;
         }
         _taskMobile = new TaskMobilePhoneView();
         _taskMobile.x = 353;
         _taskMobile.y = 213;
         _container.addChildAt(_taskMobile,11);
         _taskMobile.visible = true;
         _taskMobile.taskTemp = _currentInfo as TaskTemplate;
      }
      
      private function refreshView() : void
      {
         if(!_currentInfo)
         {
            dispose();
            return;
         }
         _taskTarget.data = _currentInfo;
         _taskReward.data = _currentInfo;
         _taskDescribe.data = _currentInfo;
         _vBox.refreshChildPos();
         refreshButton();
      }
      
      private function refreshIcon() : void
      {
         var _loc1_:Object = null;
         if(_currentInfo is TaskTemplate)
         {
            _loc1_ = _currentInfo;
         }
         else if(_currentInfo is BaseOfferReward)
         {
            _loc1_ = _currentInfo as BaseOfferReward;
         }
         else if(_currentInfo is RingTask)
         {
            _loc1_ = (_currentInfo as RingTask).ringTaskTemp;
         }
         else if(_currentInfo is MarryTask)
         {
            _loc1_ = (_currentInfo as MarryTask).marryTaskTemp;
         }
         if(_loc1_.ShowType == 0)
         {
            _taskTypeIcon.visible = false;
         }
         else
         {
            _taskTypeIcon.visible = true;
            _taskTypeIcon.setFrame(_loc1_.ShowType);
         }
      }
      
      private function refreshButton() : void
      {
         removeAllBtn();
         refreshIcon();
         setButtonBackStyle();
         _taskDescribe.desribeTxt.y = 24;
         if(_bufferView && _bufferView.parent)
         {
            _bufferView.stopTimer();
            _bufferView.visible = false;
         }
         if(_currentInfo.isCompleted)
         {
            _rewardBtn.visible = true;
            _rewardBtn.enable = true;
            _buttonMc1.gotoAndPlay(1);
            if(_currentInfo is BaseOfferReward)
            {
               _giveUpBtn.visible = true;
               _completeNowBtn.visible = true;
            }
            if(_currentInfo is MarryTask)
            {
               _giveUpBtn.visible = true;
            }
         }
         else if(_currentInfo is TaskTemplate)
         {
            if(_currentInfo.NeedFightId != 0)
            {
               _campaignBtn.visible = true;
               _buttonMc2.gotoAndPlay(1);
            }
            else if((_currentInfo as TaskTemplate).TemplateId == 756)
            {
               _dragonTransferBtn.visible = true;
               _buttonMc2.gotoAndPlay(1);
            }
            else
            {
               _rewardBtn.visible = true;
               _rewardBtn.enable = false;
            }
            for each(var _loc2_:TaskCondictionTemplate in _currentInfo.conditionList)
            {
               if(_loc2_.CondictionType == 33)
               {
                  _clientDownBtn.visible = true;
                  break;
               }
               if(_loc2_.CondictionType == 92)
               {
                  _campaignBtn.visible = false;
                  _rewardBtn.visible = false;
                  _dragonTransferBtn.visible = false;
                  _immediateBtn.visible = true;
                  _buttonMc2.gotoAndPlay(1);
                  break;
               }
               if(_loc2_.CondictionType == 48)
               {
                  if(_taskMobile)
                  {
                     _taskMobile.visible = true;
                     _taskMobile.taskTemp = _currentInfo as TaskTemplate;
                  }
                  else
                  {
                     CheckUIModuleUtil.instance.tryCall("phone",__showPhone);
                  }
                  _taskDescribe.desribeTxt.y = 135;
                  break;
               }
               if(_taskMobile)
               {
                  _taskMobile.visible = false;
               }
            }
         }
         else if(_currentInfo is RingTask)
         {
            if(_bufferView)
            {
               _bufferView.resetTimer();
               _bufferView.visible = true;
            }
            if((_currentInfo as RingTask).ringTaskTemp.Type == 3)
            {
               _rewardBtn.visible = false;
               _rewardBtn.enable = false;
               _buttonMc1.gotoAndStop(1);
               _taskDescribe.desribeTxt.y = 24;
               _giveUpBtn.visible = false;
               _completeNowBtn.visible = false;
            }
            else
            {
               _rewardBtn.visible = false;
               _rewardBtn.enable = false;
               _buttonMc1.gotoAndStop(1);
               _taskDescribe.desribeTxt.y = 24;
               _giveUpBtn.visible = false;
               _completeNowBtn.visible = true;
               for each(var _loc3_:OfferRewardConditionTemplate in _currentInfo.conditionList)
               {
                  if(_loc3_.CondictionType == 12 || _loc3_.CondictionType == 15)
                  {
                     _startPlayBtn.visible = true;
                     _buttonMc2.gotoAndPlay(1);
                     _rewardBtn.visible = false;
                  }
               }
            }
         }
         else if(_currentInfo is MarryTask)
         {
            _rewardBtn.visible = true;
            _rewardBtn.enable = false;
            _buttonMc1.gotoAndStop(1);
            _taskDescribe.desribeTxt.y = 24;
            _giveUpBtn.visible = true;
            _completeNowBtn.visible = false;
         }
         else
         {
            _rewardBtn.visible = true;
            _rewardBtn.enable = false;
            _buttonMc1.gotoAndStop(1);
            _taskDescribe.desribeTxt.y = 24;
            _giveUpBtn.visible = true;
            _completeNowBtn.visible = true;
            for each(var _loc1_:OfferRewardConditionTemplate in _currentInfo.conditionList)
            {
               switch(int(_loc1_.CondictionType) - 4)
               {
                  case 0:
                     _campaignBtn.visible = true;
                     _buttonMc2.gotoAndPlay(1);
                     _rewardBtn.visible = false;
                     break;
                  case 8:
                  case 11:
                     _startPlayBtn.visible = true;
                     _buttonMc2.gotoAndPlay(1);
                     _rewardBtn.visible = false;
                     break;
                  case 9:
                  case 10:
                     _goArrestBtn.visible = true;
                     _rewardBtn.visible = false;
                     _buttonMc2.gotoAndPlay(1);
               }
            }
         }
      }
      
      private function removeAllBtn() : void
      {
         _goArrestBtn.visible = false;
         _startPlayBtn.visible = false;
         _campaignBtn.visible = false;
         _rewardBtn.visible = false;
         _giveUpBtn.visible = false;
         _clientDownBtn.visible = false;
         _completeNowBtn.visible = false;
         _immediateBtn.visible = false;
         _dragonTransferBtn.visible = false;
         _buttonMc1.gotoAndStop(1);
         _buttonMc2.gotoAndStop(1);
         if(_taskMobile)
         {
            _taskMobile.visible = false;
         }
      }
      
      private function setButtonBackStyle() : void
      {
         if(_currentInfo is BaseOfferReward)
         {
            _rewardBtn.backStyle = "asset.core.Style25Btn";
            _startPlayBtn.backStyle = "asset.task.TaskgoArrestBtn";
            _campaignBtn.backStyle = "asset.task.TaskgoArrestBtn";
            _dragonTransferBtn.backStyle = "asset.task.TaskgoArrestBtn";
            _goArrestBtn.backStyle = "asset.task.TaskgoArrestBtn";
            _completeNowBtn.backStyle = "asset.core.Style25Btn";
            _rewardBtn.iconInnerRectString = "28,106,8,34,13";
            _rewardBtn.x = 38;
            _rewardBtn.y = 9;
            _startPlayBtn.iconInnerRectString = "28,106,8,34,13";
            _startPlayBtn.x = 38;
            _startPlayBtn.y = 12;
            _campaignBtn.iconInnerRectString = "28,106,8,34,13";
            _campaignBtn.x = 38;
            _campaignBtn.y = 12;
            _dragonTransferBtn.iconInnerRectString = "28,106,8,34,13";
            _dragonTransferBtn.x = 38;
            _dragonTransferBtn.y = 12;
            _goArrestBtn.iconInnerRectString = "30,101,12,26,13";
            _goArrestBtn.x = 38;
            _goArrestBtn.y = 12;
            _completeNowBtn.iconInnerRectString = "29,102,11,27,13";
            _completeNowBtn.x = 693;
            _completeNowBtn.y = 450;
            _completeNowBtn.iconStyle = "asset.task.TaskCompleteNowTxt";
         }
         else if(_currentInfo is TaskTemplate)
         {
            _rewardBtn.backStyle = "asset.core.Style12Btn";
            _startPlayBtn.backStyle = "asset.core.Style13Btn";
            _campaignBtn.backStyle = "asset.core.Style13Btn";
            _dragonTransferBtn.backStyle = "asset.core.Style13Btn";
            _goArrestBtn.backStyle = "asset.core.Style13Btn";
            _rewardBtn.iconInnerRectString = "64,106,16,34,13";
            _rewardBtn.x = 0;
            _rewardBtn.y = 0;
            _startPlayBtn.iconInnerRectString = "64,106,16,34,13";
            _startPlayBtn.x = 0;
            _startPlayBtn.y = 0;
            _campaignBtn.iconInnerRectString = "66,106,19,34,13";
            _campaignBtn.x = 0;
            _campaignBtn.y = 0;
            _dragonTransferBtn.iconInnerRectString = "66,106,19,34,13";
            _dragonTransferBtn.x = 0;
            _dragonTransferBtn.y = 0;
            _goArrestBtn.iconInnerRectString = "66,101,20,26,13";
            _goArrestBtn.x = 0;
            _goArrestBtn.y = 0;
         }
         else if(_currentInfo is RingTask)
         {
            if((_currentInfo as RingTask).ringTaskTemp.Type != 3)
            {
               for each(var _loc1_:OfferRewardConditionTemplate in _currentInfo.conditionList)
               {
                  if(_loc1_.CondictionType == 12 || _loc1_.CondictionType == 15)
                  {
                     _rewardBtn.backStyle = "asset.core.Style25Btn";
                     _startPlayBtn.backStyle = "asset.task.TaskgoArrestBtn";
                     _campaignBtn.backStyle = "asset.task.TaskgoArrestBtn";
                     _dragonTransferBtn.backStyle = "asset.task.TaskgoArrestBtn";
                     _goArrestBtn.backStyle = "asset.task.TaskgoArrestBtn";
                     _rewardBtn.iconInnerRectString = "28,106,8,34,13";
                     _rewardBtn.x = 38;
                     _rewardBtn.y = 9;
                     _startPlayBtn.iconInnerRectString = "28,106,8,34,13";
                     _startPlayBtn.x = 38;
                     _startPlayBtn.y = 12;
                     _campaignBtn.iconInnerRectString = "28,106,8,34,13";
                     _campaignBtn.x = 38;
                     _campaignBtn.y = 12;
                     _dragonTransferBtn.iconInnerRectString = "28,106,8,34,13";
                     _dragonTransferBtn.x = 38;
                     _dragonTransferBtn.y = 12;
                     _goArrestBtn.iconInnerRectString = "30,101,12,26,13";
                     _goArrestBtn.x = 38;
                     _goArrestBtn.y = 12;
                  }
                  else
                  {
                     _rewardBtn.backStyle = "asset.core.Style12Btn";
                     _startPlayBtn.backStyle = "asset.task.TaskgoArrestBtn";
                     _campaignBtn.backStyle = "asset.task.TaskgoArrestBtn";
                     _dragonTransferBtn.backStyle = "asset.task.TaskgoArrestBtn";
                     _goArrestBtn.backStyle = "asset.task.TaskgoArrestBtn";
                     _completeNowBtn.backStyle = "asset.core.Style30Btn";
                     _rewardBtn.iconInnerRectString = "64,106,16,34,13";
                     _rewardBtn.x = 0;
                     _rewardBtn.y = 0;
                     _startPlayBtn.iconInnerRectString = "28,106,8,34,13";
                     _startPlayBtn.x = 38;
                     _startPlayBtn.y = 12;
                     _campaignBtn.iconInnerRectString = "28,106,8,34,13";
                     _campaignBtn.x = 38;
                     _campaignBtn.y = 12;
                     _dragonTransferBtn.iconInnerRectString = "28,106,8,34,13";
                     _dragonTransferBtn.x = 38;
                     _dragonTransferBtn.y = 12;
                     _goArrestBtn.iconInnerRectString = "30,101,12,26,13";
                     _goArrestBtn.x = 38;
                     _goArrestBtn.y = 12;
                     _completeNowBtn.iconInnerRectString = "66,103,21,28,13";
                     _completeNowBtn.x = 491;
                     _completeNowBtn.y = 436;
                     _completeNowBtn.iconStyle = "asset.task.completeNowTxt2";
                  }
               }
            }
         }
         else if(_currentInfo is MarryTask)
         {
            _rewardBtn.backStyle = "asset.core.Style12Btn";
            _startPlayBtn.backStyle = "asset.task.TaskgoArrestBtn";
            _campaignBtn.backStyle = "asset.task.TaskgoArrestBtn";
            _dragonTransferBtn.backStyle = "asset.task.TaskgoArrestBtn";
            _goArrestBtn.backStyle = "asset.task.TaskgoArrestBtn";
            _completeNowBtn.backStyle = "asset.core.Style30Btn";
            _rewardBtn.iconInnerRectString = "64,106,16,34,13";
            _rewardBtn.x = 0;
            _rewardBtn.y = 0;
            _startPlayBtn.iconInnerRectString = "28,106,8,34,13";
            _startPlayBtn.x = 38;
            _startPlayBtn.y = 12;
            _campaignBtn.iconInnerRectString = "28,106,8,34,13";
            _campaignBtn.x = 38;
            _campaignBtn.y = 12;
            _dragonTransferBtn.iconInnerRectString = "28,106,8,34,13";
            _dragonTransferBtn.x = 38;
            _dragonTransferBtn.y = 12;
            _goArrestBtn.iconInnerRectString = "30,101,12,26,13";
            _goArrestBtn.x = 38;
            _goArrestBtn.y = 12;
            _completeNowBtn.iconInnerRectString = "66,103,21,28,13";
            _completeNowBtn.x = 491;
            _completeNowBtn.y = 436;
            _completeNowBtn.iconStyle = "asset.task.completeNowTxt2";
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _rewardBtn.addEventListener("click",__getRewardHandler);
         _completeNowBtn.addEventListener("click",__completeNowHandler);
         _taskMenu.addEventListener("task_item_selected",__selectedHadler);
         _taskMenu.addEventListener("REWARD_TASK_SELECTED",__selectedHadler);
         _campaignBtn.addEventListener("click",__enterCampainHandler);
         _startPlayBtn.addEventListener("click",__onStartPlayClick);
         _goArrestBtn.addEventListener("click",__onGoArrestClick);
         _clientDownBtn.addEventListener("click",__clientDownClick);
         _giveUpBtn.addEventListener("click",__onRemoveRewardTaskClick);
         _immediateBtn.addEventListener("click",__onImmediateClick);
         _dragonTransferBtn.addEventListener("click",__onDragonTransferClick);
         addEventListener("addedToStage",onAddToStage);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _rewardBtn.removeEventListener("click",__getRewardHandler);
         _completeNowBtn.removeEventListener("click",__completeNowHandler);
         _taskMenu.removeEventListener("task_item_selected",__selectedHadler);
         _taskMenu.removeEventListener("REWARD_TASK_SELECTED",__selectedHadler);
         _campaignBtn.removeEventListener("click",__enterCampainHandler);
         _startPlayBtn.removeEventListener("click",__onStartPlayClick);
         _goArrestBtn.removeEventListener("click",__onGoArrestClick);
         _clientDownBtn.removeEventListener("click",__clientDownClick);
         _giveUpBtn.removeEventListener("click",__onRemoveRewardTaskClick);
         _immediateBtn.removeEventListener("click",__onImmediateClick);
         _dragonTransferBtn.removeEventListener("click",__onDragonTransferClick);
         removeEventListener("addedToStage",onAddToStage);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         if(_completeBtn != null)
         {
            _completeBtn.x = 772;
            _completeBtn.y = 458;
         }
      }
      
      private function __onImmediateClick(param1:MouseEvent) : void
      {
         var _loc2_:TaskTemplate = null;
         if(_currentInfo is TaskTemplate)
         {
            _loc2_ = _currentInfo as TaskTemplate;
            SocketSendManager.instance.challengeSelf(_loc2_.TemplateId);
         }
      }
      
      private function refreshRingTask(param1:RingTaskEvent) : void
      {
      }
      
      private function __selectedHadler(param1:Event) : void
      {
         _currentInfo = param1["info"];
         refreshView();
      }
      
      private function __getRewardHandler(param1:MouseEvent) : void
      {
         if(!_currentInfo)
         {
            return;
         }
         if(_currentInfo is BaseOfferReward)
         {
            if(_currentInfo.isCompleted || info.leftTime > 0)
            {
               OfferRewardManager.instance.sendFinishRewardTask(_currentInfo.rewardID);
            }
            return;
         }
         if(_currentInfo is RingTask)
         {
            if(_currentInfo.isCompleted)
            {
               RingTaskManager.instance.submitRingTask();
            }
         }
         else if(_currentInfo is MarryTask)
         {
            if(_currentInfo.isCompleted)
            {
               MarrySender.opMarryTask(2002);
            }
         }
         else if(_currentInfo.isCompleted)
         {
            FrameControllerManager.instance.taskControler.sendGetTaskReward(_currentInfo.TemplateId,0);
         }
      }
      
      private function quickSubmit(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.completeRingTaskFlag = param1;
            SharedManager.instance.completeRingTaskUseBind = param2;
         }
         var _loc3_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(param2)
         {
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         var _loc4_:Array = GoodsManager.instance.getBagGoodsByTemplateId(2131021);
         if(_loc3_ < 10 && _loc4_.length <= 0)
         {
            RechargeAlertMannager.show();
            return;
         }
         RingTaskManager.instance.CompletedImmediately(param2);
      }
      
      private function __completeNowHandler(param1:MouseEvent) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc7_:Array = null;
         var _loc10_:TodayNotAlertFrame = null;
         var _loc8_:String = null;
         var _loc3_:String = null;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         if(_currentInfo is MarryTask)
         {
            return;
         }
         if(_currentInfo is RingTask)
         {
            _loc5_ = true;
            _loc6_ = Boolean(SharedManager.instance.completeRingTaskFlag);
            _loc2_ = Boolean(SharedManager.instance.completeRingTaskUseBind);
            if(_loc6_)
            {
               _loc5_ = false;
            }
            _loc7_ = GoodsManager.instance.getBagGoodsByTemplateId(2131021);
            if(_loc5_)
            {
               _loc10_ = ComponentFactory.Instance.creatComponentByStylename("task.RiverNotAlert");
               _loc8_ = LanguageMgr.GetTranslation("task.TaskFrameII.usePointPrompt",10);
               _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
               if(_loc7_.length <= 0)
               {
                  _loc9_ = 10;
               }
               _loc10_.show(_loc8_,_loc3_,quickSubmit,null,"center",1,true,_loc9_);
            }
            else
            {
               _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
               if(_loc2_)
               {
                  _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
               }
               if(_loc4_ < 10 && _loc7_.length <= 0)
               {
                  RechargeAlertMannager.show();
                  return;
               }
               RingTaskManager.instance.CompletedImmediately(_loc2_);
            }
         }
         else if(info.leftTime <= 0)
         {
            FrameControllerManager.instance.openControllerByInfo("kingcontract");
         }
         else
         {
            if(!_currentInfo)
            {
               return;
            }
            if(_currentInfo is BaseOfferReward)
            {
               if(_currentInfo.isCompleted || info.leftTime > 0)
               {
                  OfferRewardManager.instance.sendFinishRewardTask(_currentInfo.rewardID,true);
               }
            }
         }
      }
      
      private function __enterCampainHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:CampaignMapModel = null;
         var _loc4_:Object = null;
         var _loc5_:CampaignTemplate = null;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc3_ = CampaignManager.instance.mapModel;
            _loc2_ = LanguageMgr.GetTranslation("task.TaskFrameII.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_taskMenu.currentSelected == _taskMenu.rewardBtn)
         {
            _loc4_ = _currentInfo;
         }
         else
         {
            _loc4_ = _currentInfo;
         }
         if(_loc4_)
         {
            SoundManager.instance.play("022");
            _loc5_ = TempleteManager.instance.worldBossTemplateDict[_loc4_.NeedFightId];
            FrameControllerManager.instance.worldBossControler.sendEnterBattle(_loc5_);
         }
      }
      
      private function __onDragonTransferClick(param1:MouseEvent) : void
      {
         if(_currentInfo is TaskTemplate && (_currentInfo as TaskTemplate).TemplateId == 756)
         {
            SwitchPageHelp.gotoCampaignById((_currentInfo as TaskTemplate).conditionList[0]["Para1"]);
         }
      }
      
      private function __onStartPlayClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_currentInfo)
         {
            switch(_currentInfo.conditionList[0].CondictionType)
            {
               case 12:
                  CheckUIModuleUtil.instance.tryCall("qte",__showQte);
                  break;
               case 15:
                  CheckUIModuleUtil.instance.tryCall("hamster",__showHamster);
            }
         }
      }
      
      private function __showQte() : void
      {
         var _loc1_:QTETraining = new QTETraining(_currentInfo.conditionList[0].Para2,_currentInfo.conditionList[0].Para1 * 1000,qteSucceedCall);
         _loc1_.show();
      }
      
      private function __showHamster() : void
      {
         var _loc1_:HamsterGameFrame = new HamsterGameFrame(_currentInfo.conditionList[0].Para1,_currentInfo.conditionList[0].Para2,_hamsterGameSucceed);
         _loc1_.show();
      }
      
      private function _hamsterGameSucceed() : void
      {
         if(_currentInfo)
         {
            _currentInfo.hamsterGameResult = true;
         }
      }
      
      private function qteSucceedCall() : void
      {
         if(_currentInfo)
         {
            _currentInfo.qteResult = true;
         }
      }
      
      private function __onGoArrestClick(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:OfferRewardConditionTemplate = null;
         if(_currentInfo)
         {
            switch(_loc4_ = SceneManager.instance.currentType)
            {
               case "CAMPAIGN_MAP_SCENE":
               case "BATTLE_SCENE":
               case "EMPTY_SCENE":
               case "PVE_ROOM_SCENE":
               case "PVP_ROOM_SCENE":
                  break;
               case "SPACE_SCENE":
                  BattleManager.preScene = "SPACE_SCENE";
                  break;
               case "CASTLE_SCENE":
                  BattleManager.preScene = "CASTLE_SCENE";
               default:
                  _loc3_ = _currentInfo.conditionList[0];
                  if(_loc3_)
                  {
                     OfferRewardManager.instance.sendRewardArrest(_loc3_.CondictionType,_loc3_.Para1);
                  }
            }
            _loc2_ = LanguageMgr.GetTranslation("task.TaskFrameII.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
      }
      
      private function __clientDownClick(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         var _loc7_:String = PathManager.getClientLoginPath();
         var _loc3_:String = PathManager.getClientLoginName() + ".exe";
         if(_loc7_.substr(-3) != "exe")
         {
            _loc6_ = PlayerManager.instance.currentPlayerModel.userInfo.user;
            _loc4_ = PlayerManager.instance.currentPlayerModel.userInfo.site;
            if(_loc7_.indexOf("?") == -1)
            {
               _loc7_ += "?";
            }
            else
            {
               _loc7_ += "&";
            }
            _loc7_ += "u=" + _loc6_ + "&site=" + _loc4_;
         }
         _loc7_ = encodeURI(_loc7_);
         var _loc2_:URLRequest = new URLRequest(_loc7_);
         var _loc5_:FileReference = new FileReference();
         _loc5_.download(_loc2_,_loc3_);
      }
      
      private function __onRemoveRewardTaskClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SimpleAlertHelper.instance.data = [removeRewardTaskCallBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("task.TaskFrameII.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
      }
      
      private function removeRewardTaskCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SoundManager.instance.play("022");
            TaskGainMovie.isGiveUp = true;
            if(_currentInfo is BaseOfferReward)
            {
               OfferRewardManager.instance.sendRemoveRewardTask(_currentInfo.rewardID);
            }
            else if(_currentInfo is MarryTask)
            {
               MarrySender.opMarryTask(2003);
            }
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_back3);
         _back3 = null;
         ObjectUtils.disposeObject(_back4);
         _back4 = null;
         ObjectUtils.disposeObject(_back5);
         _back5 = null;
         ObjectUtils.disposeObject(_back6);
         _back6 = null;
         ObjectUtils.disposeObject(_taskMenu);
         _taskMenu = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_taskTarget);
         _taskTarget = null;
         ObjectUtils.disposeObject(_taskReward);
         _taskReward = null;
         ObjectUtils.disposeObject(_taskDescribe);
         _taskDescribe = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_campaignBtn);
         _campaignBtn = null;
         ObjectUtils.disposeObject(_giveUpBtn);
         _giveUpBtn = null;
         ObjectUtils.disposeObject(_startPlayBtn);
         _startPlayBtn = null;
         ObjectUtils.disposeObject(_goArrestBtn);
         _goArrestBtn = null;
         ObjectUtils.disposeObject(_clientDownBtn);
         _clientDownBtn = null;
         ObjectUtils.disposeObject(_completeNowBtn);
         _completeNowBtn = null;
         ObjectUtils.disposeObject(_buttonMc1);
         _buttonMc1 = null;
         ObjectUtils.disposeObject(_taskMobile);
         if(_taskMobile)
         {
            _taskMobile.taskTemp = null;
         }
         _taskMobile = null;
         ObjectUtils.disposeObject(_buttonMc1);
         _buttonMc1 = null;
         ObjectUtils.disposeObject(_buttonMc2);
         _buttonMc2 = null;
         ObjectUtils.disposeObject(_taskTypeIcon);
         _taskTypeIcon = null;
         ObjectUtils.disposeObject(_immediateBtn);
         _immediateBtn = null;
         ObjectUtils.disposeObject(_dragonTransferBtn);
         _dragonTransferBtn = null;
         ObjectUtils.disposeObject(_completeBtn);
         _completeBtn = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         super.dispose();
      }
   }
}

