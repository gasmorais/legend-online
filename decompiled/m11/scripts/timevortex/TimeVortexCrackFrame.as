package timevortex
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TimeVortexEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.TimeVortexManager;
   import mvc.controler.TimeVortexController;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.timevortex.TimeVortexDropTemplateInfo;
   import mvc.module.timevortex.TimeVortexModel;
   import mvc.module.timevortex.TimeVortexTeamItemInfo;
   import timevortex.view.TimeVortexCrackDefendRewardView;
   import timevortex.view.TimeVortexCrackRewardView;
   import timevortex.view.TimeVortexCrackTeamItemView;
   import timevortex.view.TimeVortexCrackTeamWaitView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class TimeVortexCrackFrame extends Frame implements IManualSize, IEnterFrame
   {
      
      private var _border:Scale9CornerImage;
      
      private var _back:Image;
      
      private var _crackTitleBg:Image;
      
      private var _crackTitleImg:Image;
      
      private var _crackAvatar:ShowAvatar;
      
      private var _crackNameTxt:FilterFrameText;
      
      private var _crackRewardBtn:BaseButton;
      
      private var _crackTipsImg1:Image;
      
      private var _crackTipsImg2:Image;
      
      private var _crackTipsImg3:Image;
      
      private var _crackTipsTxt:FilterFrameText;
      
      private var _crackRewardView:TimeVortexCrackRewardView;
      
      private var _crackTeamTitleImg1:Image;
      
      private var _crackTeamTitleImg2:Image;
      
      private var _crackTeamInfoLine:Image;
      
      private var _crackTeamVBox:VBox;
      
      private var _crackTeamScrollPanel:ScrollPanel;
      
      private var _crackFightBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _waitView:TimeVortexCrackTeamWaitView;
      
      private var _rewardView:TimeVortexCrackDefendRewardView;
      
      private var _model:TimeVortexModel = TimeVortexManager.instance.model;
      
      private var _controller:TimeVortexController = FrameControllerManager.instance.timeVortexController;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _data:CampaignAreaInfo = _model.selectedCrack;
      
      private var _grayFilter:ColorMatrixFilter;
      
      private var _lastTime:Number = getTimer();
      
      private var _timeCount:int = 0;
      
      private var _countDiff:int = 1;
      
      public function TimeVortexCrackFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         TimeVortexManager.instance.lookUpCrackSingle(_data.campaignId);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,776,493);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("timevortex.TimeVortexCrackFrame.Title");
         _border = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.back");
         _crackTitleBg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTitleBg");
         _crackTitleImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTitleImg");
         _crackAvatar = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexCrackFrame.crackAvatar");
         _crackNameTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackNameTxt");
         _crackRewardBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackRewardBtn");
         _crackTipsImg1 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTipsImg1");
         _crackTipsImg2 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTipsImg2");
         _crackTipsImg3 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTipsImg3");
         _crackTipsTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTipsTxt");
         _crackRewardView = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexCrackFrame.crackRewardView");
         _crackTeamTitleImg1 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTeamTitleImg1");
         _crackTeamTitleImg2 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTeamTitleImg2");
         _crackTeamInfoLine = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTeamInfoLine");
         _crackTeamVBox = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTeamVBox");
         _crackTeamScrollPanel = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackTeamScrollPanel");
         _crackFightBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.crackFightBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.helpBtn");
         _grayFilter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         _crackTeamScrollPanel.setView(_crackTeamVBox);
         addToContent(_border);
         addToContent(_back);
         addToContent(_crackTitleBg);
         addToContent(_crackTitleImg);
         addToContent(_crackAvatar);
         addToContent(_crackNameTxt);
         addToContent(_crackRewardBtn);
         addToContent(_crackTipsImg1);
         addToContent(_crackTipsImg2);
         addToContent(_crackTipsImg3);
         addToContent(_crackTipsTxt);
         addToContent(_crackTeamTitleImg1);
         addToContent(_crackTeamTitleImg2);
         addToContent(_crackTeamInfoLine);
         addToContent(_crackTeamScrollPanel);
         addToContent(_crackRewardView);
         addToContent(_crackFightBtn);
         addToContent(_helpBtn);
         initRewards();
      }
      
      private function initRewards() : void
      {
         var _loc1_:Dictionary = _model.getDropInfos(_model.selectedChapter.chapterId);
         if(_loc1_)
         {
            _crackRewardView.dropInfos = _loc1_[5] as Vector.<TimeVortexDropTemplateInfo>;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_crackTitleBg);
         _crackTitleBg = null;
         ObjectUtils.disposeObject(_crackTitleImg);
         _crackTitleImg = null;
         ObjectUtils.disposeObject(_crackAvatar);
         _crackAvatar = null;
         ObjectUtils.disposeObject(_crackNameTxt);
         _crackNameTxt = null;
         ObjectUtils.disposeObject(_crackRewardBtn);
         _crackRewardBtn = null;
         ObjectUtils.disposeObject(_crackTipsImg1);
         _crackTipsImg1 = null;
         ObjectUtils.disposeObject(_crackTipsImg2);
         _crackTipsImg2 = null;
         ObjectUtils.disposeObject(_crackTipsImg3);
         _crackTipsImg3 = null;
         ObjectUtils.disposeObject(_crackTipsTxt);
         _crackTipsTxt = null;
         ObjectUtils.disposeObject(_crackTeamTitleImg1);
         _crackTeamTitleImg1 = null;
         ObjectUtils.disposeObject(_crackTeamTitleImg2);
         _crackTeamTitleImg2 = null;
         ObjectUtils.disposeObject(_crackTeamInfoLine);
         _crackTeamInfoLine = null;
         ObjectUtils.disposeObject(_crackTeamScrollPanel);
         _crackTeamScrollPanel = null;
         ObjectUtils.disposeObject(_crackRewardView);
         _crackRewardView = null;
         ObjectUtils.disposeObject(_crackFightBtn);
         _crackFightBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_waitView);
         _waitView = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         ObjectUtils.disposeObject(_grayFilter);
         _grayFilter = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _model = null;
         _controller = null;
         _playerInfo = null;
         _grayFilter = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _crackRewardBtn.addEventListener("click",__crackRewardBtnClickHandler);
         _crackFightBtn.addEventListener("click",__lairdFightBtnClickHandler);
         _model.addEventListener("CRACK_TEAM_INFO_CHANGE",__crackTeamInfoChangeHandler);
         _model.addEventListener("RECEIVE_WAIT_INFO",__receiveWaitInfoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         }
         if(_crackRewardBtn)
         {
            _crackRewardBtn.removeEventListener("click",__crackRewardBtnClickHandler);
         }
         if(_crackFightBtn)
         {
            _crackFightBtn.removeEventListener("click",__lairdFightBtnClickHandler);
         }
         if(_model)
         {
            _model.removeEventListener("CRACK_TEAM_INFO_CHANGE",__crackTeamInfoChangeHandler);
            _model.removeEventListener("RECEIVE_WAIT_INFO",__receiveWaitInfoChangeHandler);
         }
      }
      
      private function __crackTeamInfoChangeHandler(param1:TimeVortexEvent) : void
      {
         refreshView();
      }
      
      private function __receiveWaitInfoChangeHandler(param1:TimeVortexEvent) : void
      {
         _waitView = new TimeVortexCrackTeamWaitView(waitViewCallBack);
         _waitView.timeCount = 10;
         _waitView.show();
      }
      
      private function __lairdFightBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(!FreedomTeamManager.instance.hasTeam && _data.userId == _playerInfo.userId || FreedomTeamManager.instance.hasTeam && Boolean(FreedomTeamManager.instance.inMyTeam(_data.userId)))
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexCrackFrame.TipsTxt01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!FreedomTeamManager.instance.hasTeam)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("timevortex.TimeVortexCrackFrame.TipsTxt02");
            SimpleAlertHelper.instance.data = [lairdFightCallBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
            return;
         }
         if(FreedomTeamManager.instance.hasTeam && !FreedomTeamManager.instance.isCaptain)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexCrackFrame.TipsTxt03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         challengeCrackLaird();
      }
      
      private function waitViewCallBack() : void
      {
         _waitView = null;
      }
      
      private function lairdFightCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            challengeCrackLaird();
         }
      }
      
      private function challengeCrackLaird() : void
      {
         _model.challengeCampaignTem = _data.getMapById(_data.campaignId);
         TimeVortexManager.instance.challengeCrack(_data.campaignId);
      }
      
      private function __crackRewardBtnClickHandler(param1:MouseEvent) : void
      {
         if(_rewardView)
         {
            _rewardView.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_rewardView)
         {
            _rewardView = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexCrackDefendRewardView");
         }
         _rewardView.addEventListener("dispose",__rewardViewDisposeHandler);
         var _loc2_:Point = new Point(_crackRewardBtn.x,_crackRewardBtn.y);
         _rewardView.x = localToGlobal(_loc2_).x - 305;
         _rewardView.y = localToGlobal(_loc2_).y - 35;
         LayerManager.Instance.addToLayer(_rewardView,7);
      }
      
      private function __rewardViewDisposeHandler(param1:Event) : void
      {
         _rewardView.removeEventListener("dispose",__rewardViewDisposeHandler);
         _rewardView = null;
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame.helpFrame");
         _loc2_.show();
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
      
      private function refreshView() : void
      {
         var _loc4_:Array = null;
         var _loc2_:TimeVortexCrackTeamItemView = null;
         var _loc5_:TimeVortexTeamItemInfo = null;
         var _loc1_:int = 0;
         var _loc6_:Boolean = false;
         var _loc3_:int = 0;
         if(_data)
         {
            _crackNameTxt.text = _data.nickName;
            _crackAvatar.data = _data.thane;
            _loc4_ = _model.teamInfo.getList();
            _loc1_ = int(_loc4_.length);
            _crackTeamVBox.removeAllChild();
            _crackTeamVBox.disposeAllChildren();
            _crackTeamScrollPanel.beginChanges();
            _crackTeamVBox.beginChanges();
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc5_ = _loc4_[_loc3_] as TimeVortexTeamItemInfo;
               if(_loc3_ == _loc1_ - 1)
               {
                  _loc6_ = false;
               }
               else
               {
                  _loc6_ = true;
               }
               _loc2_ = new TimeVortexCrackTeamItemView(_loc6_);
               _loc2_.data = _loc5_;
               _crackTeamVBox.addChild(_loc2_);
               if(_loc5_.userId == _playerInfo.userId)
               {
                  _crackTipsTxt.text = LanguageMgr.GetTranslation("timevortex.view.TimeVortexAreaView.TipsTxt",_loc5_.leftCount,_model.crackChallengeRewardMax);
               }
               _loc3_++;
            }
            _crackTeamVBox.commitChanges();
            _crackTeamScrollPanel.invalidateViewport();
         }
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(_data && _data.userId != 0)
         {
            _loc1_ = getTimer();
            _loc2_ = _loc1_ - _lastTime;
            if(_loc2_ >= 1000)
            {
               _countDiff = _loc2_ / 1000;
               _timeCount += _countDiff;
               _lastTime = _loc1_;
            }
            if(_timeCount >= 20)
            {
               _timeCount = 0;
               TimeVortexManager.instance.lookUpCrackSingle(_data.campaignId);
            }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         EnterFrameManager.instance.registeEnterFrame(this);
         _controller.isOpenCrackFrame = true;
      }
      
      override public function dispose() : void
      {
         _controller.isOpenCrackFrame = false;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

