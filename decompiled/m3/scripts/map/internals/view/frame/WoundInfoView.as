package map.internals.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import mvc.module.worldboss.WorldBossModel;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.BaseManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class WoundInfoView extends Sprite implements Disposeable
   {
      
      private var _background:ScaleBitmapImage;
      
      private var _buffGradeTxt:FilterFrameText;
      
      private var _timeTipTxt:FilterFrameText;
      
      private var _countTip:FilterFrameText;
      
      private var _countValue:FilterFrameText;
      
      private var _selfWoundInfo:WoundInfoItemView;
      
      private var _timeDown:TimeDownView;
      
      private var _helpBtn:BaseButton;
      
      private var _woundList:Array;
      
      private var _model:WorldBossModel;
      
      private var _mapModel:CampaignMapModel;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _jobTab:SelectedCheckButton;
      
      private var _allTab:SelectedCheckButton;
      
      private var _hideBtn:BaseButton;
      
      private var _cancleHideBtn:BaseButton;
      
      private var _stateBack:ScaleFrameImage;
      
      private var _stateText:FilterFrameText;
      
      public function WoundInfoView()
      {
         super();
         init();
         initEvent();
         this.mouseEnabled = false;
         _background.mouseEnabled = _background.mouseChildren = false;
         _selfWoundInfo.mouseEnabled = _selfWoundInfo.mouseChildren = false;
         _timeDown.mouseEnabled = _timeDown.mouseChildren = false;
         _buffGradeTxt.mouseEnabled = false;
         _timeTipTxt.mouseEnabled = false;
         _countTip.mouseEnabled = false;
         _countValue.mouseEnabled = false;
         _mapModel = CampaignManager.instance.mapModel;
         updateHideBtnVisible();
      }
      
      private function initEvent() : void
      {
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpHandler);
         }
         if(_mapModel)
         {
            _mapModel.addEventListener("syncErrorTime",__syncErrorTimeHandler);
         }
         if(_jobTab)
         {
            _jobTab.addEventListener("click",__jobTabHandler);
         }
         if(_allTab)
         {
            _allTab.addEventListener("click",__allTabHandler);
         }
         if(_hideBtn)
         {
            _hideBtn.addEventListener("click",__switchShieldHandler);
         }
         if(_cancleHideBtn)
         {
            _cancleHideBtn.addEventListener("click",__switchShieldHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpHandler);
         }
         if(_mapModel)
         {
            _mapModel.removeEventListener("syncErrorTime",__syncErrorTimeHandler);
         }
         if(_jobTab)
         {
            _jobTab.removeEventListener("click",__jobTabHandler);
         }
         if(_allTab)
         {
            _allTab.removeEventListener("click",__allTabHandler);
         }
         if(_hideBtn)
         {
            _hideBtn.removeEventListener("click",__switchShieldHandler);
         }
         if(_cancleHideBtn)
         {
            _cancleHideBtn.removeEventListener("click",__switchShieldHandler);
         }
      }
      
      private function updateHideBtnVisible() : void
      {
         _hideBtn.visible = !SharedManager.instance.hideOthers;
         _cancleHideBtn.visible = SharedManager.instance.hideOthers;
      }
      
      private function __switchShieldHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         SharedManager.instance.hideOthers = !SharedManager.instance.hideOthers;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UP_DATA_SHOW_PLAYER_VIEW",SharedManager.instance.hideOthers));
         updateHideBtnVisible();
      }
      
      private function __jobTabHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.woundAll = false;
         updateView();
      }
      
      private function __allTabHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.woundAll = true;
         updateView();
      }
      
      private function __syncErrorTimeHandler(param1:CampaignMapEvent) : void
      {
         updateTimeView();
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("worldboss.worldbossHelperFrame");
         _loc2_.show();
      }
      
      public function get model() : WorldBossModel
      {
         return _model;
      }
      
      public function set model(param1:WorldBossModel) : void
      {
         _model = param1;
         _model.woundAll = false;
         _model.addEventListener("UPDATE_WOUND_LIST",__updateWoundListHandler);
         updateView();
         updateTimeView();
      }
      
      private function __updateWoundListHandler(param1:Event) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc2_:int = 0;
         _selfWoundInfo.woundInfo = _model.selfWoundInfo;
         _loc2_ = 0;
         while(_loc2_ < _model.woundInfoList.length)
         {
            _woundList[_loc2_].woundInfo = _model.getWoundInfoByIndex(_loc2_);
            _loc2_++;
         }
         var _loc1_:String = LanguageMgr.GetTranslation("WorldBoss.WoundInfo.countValue");
         _countValue.text = _model.totalNum < 300 ? _loc1_ : _model.totalNum + "";
         if(_model.buffGrade > 0)
         {
            _buffGradeTxt.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoView.buffGradeTip",_model.buffGrade,_model.buffGrade * 500);
         }
         else
         {
            _buffGradeTxt.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoView.buffTip");
         }
         if(BaseManager.instance.wordBossInvincibleState)
         {
            _stateBack.setFrame(1);
            _stateText.text = LanguageMgr.GetTranslation("WoundInfoView.stateText.text1");
         }
         else
         {
            _stateBack.setFrame(2);
            _stateText.text = LanguageMgr.GetTranslation("WoundInfoView.stateText.text2");
         }
         _stateText.y = _stateText.numLines > 1 ? 335 : 345;
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:WoundInfoItemView = null;
         _woundList = [];
         _jobTab = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.JobTab");
         _jobTab.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoView.JobTabTxt");
         addChild(_jobTab);
         _allTab = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.AllTab");
         _allTab.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoView.AllTabTxt");
         addChild(_allTab);
         _background = ComponentFactory.Instance.creatComponentByStylename("WorldBossWoundInfo.Background");
         addChild(_background);
         _buffGradeTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.BuffTipTxt");
         _buffGradeTxt.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoView.buffTip");
         addChild(_buffGradeTxt);
         _timeTipTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.TimeTipTxt");
         _timeTipTxt.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoView.timeTip");
         addChild(_timeTipTxt);
         _timeDown = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.TimeDownView");
         addChild(_timeDown);
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.hideBtn");
         _cancleHideBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.cancleHideBtn");
         addChild(_hideBtn);
         addChild(_cancleHideBtn);
         _hideBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.OthersHideBtnTipData");
         _cancleHideBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.OthersShowBtnTipData");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.HelpBtn");
         addChild(_helpBtn);
         _countTip = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.CountTipTxt");
         _countTip.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoView.countTip");
         addChild(_countTip);
         _countValue = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.CountValueTxt");
         addChild(_countValue);
         _stateBack = ComponentFactory.Instance.creatComponentByStylename("WoundInfoView.stateBack");
         _stateText = ComponentFactory.Instance.creatComponentByStylename("WoundInfoView.stateText");
         addChild(_stateBack);
         addChild(_stateText);
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_jobTab);
         _buttonGroup.addSelectItem(_allTab);
         _buttonGroup.selectIndex = 0;
         _selfWoundInfo = new WoundInfoItemView();
         _selfWoundInfo.setFrame(1);
         _selfWoundInfo.isSelf = true;
         _selfWoundInfo.x = 6;
         _selfWoundInfo.y = 75;
         addChild(_selfWoundInfo);
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new WoundInfoItemView();
            switch(_loc2_)
            {
               case 0:
                  _loc1_.setFrame(2);
                  break;
               case 1:
                  _loc1_.setFrame(3);
                  break;
               case 2:
                  _loc1_.setFrame(4);
                  break;
               default:
                  _loc1_.setFrame(5);
            }
            _loc1_.x = 6;
            _loc1_.y = _loc2_ * 20 + 100;
            addChild(_loc1_);
            _woundList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function updateTimeView() : void
      {
         var _loc2_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         var _loc5_:CampaignTemplate = TempleteManager.instance.worldBossTemplateDict[RoomManager.instance.roomInfo.campaignId];
         var _loc1_:Array = _loc5_.StopTime.split(":");
         var _loc3_:Date = new Date();
         _loc3_.time = _loc2_;
         _loc3_.hours = int(_loc1_[0]);
         _loc3_.minutes = int(_loc1_[1]);
         _loc3_.seconds = 0;
         var _loc4_:Number = _loc3_.time - _loc2_ + CampaignManager.instance.mapModel.syncErrorTime * 1000;
         _timeDown.timeCount = _loc4_ / 1000;
         _timeDown.commitChanges();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_mapModel)
         {
            _mapModel.removeEventListener("syncErrorTime",__syncErrorTimeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_WOUND_LIST",__updateWoundListHandler);
         }
         if(_timeDown)
         {
            _timeDown.dispose();
         }
         _timeDown = null;
         for each(var _loc1_:WoundInfoItemView in _woundList)
         {
            _loc1_.dispose();
         }
         _woundList = null;
         if(_selfWoundInfo)
         {
            _selfWoundInfo.dispose();
         }
         _selfWoundInfo = null;
         if(_background)
         {
            _background.dispose();
         }
         _background = null;
         if(_timeTipTxt)
         {
            _timeTipTxt.dispose();
         }
         _timeTipTxt = null;
         if(_buffGradeTxt)
         {
            _buffGradeTxt.dispose();
         }
         _buffGradeTxt = null;
         if(_countTip)
         {
            _countTip.dispose();
         }
         _countTip = null;
         if(_countValue)
         {
            _countValue.dispose();
         }
         _countValue = null;
         if(_helpBtn)
         {
            _helpBtn.dispose();
         }
         _helpBtn = null;
         if(_buttonGroup)
         {
            _buttonGroup.dispose();
         }
         _buttonGroup = null;
         if(_jobTab)
         {
            _jobTab.dispose();
         }
         _jobTab = null;
         if(_allTab)
         {
            _allTab.dispose();
         }
         _allTab = null;
         if(_hideBtn)
         {
            _hideBtn.dispose();
         }
         _hideBtn = null;
         if(_cancleHideBtn)
         {
            _cancleHideBtn.dispose();
         }
         _cancleHideBtn = null;
         ObjectUtils.disposeObject(_stateBack);
         _stateBack = null;
         ObjectUtils.disposeObject(_stateText);
         _stateText = null;
         _model = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

