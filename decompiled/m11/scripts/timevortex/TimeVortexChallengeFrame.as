package timevortex
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.TimeVortexEvent;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import managers.TimeVortexManager;
   import mvc.controler.TimeVortexController;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.timevortex.TimeVortexDropTemplateInfo;
   import mvc.module.timevortex.TimeVortexModel;
   import timevortex.view.TimeVortexRewardView;
   import timevortex.view.TimeVortexShowAvatar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class TimeVortexChallengeFrame extends Frame implements IManualSize, IEnterFrame
   {
      
      private var _border:Scale9CornerImage;
      
      private var _back:Image;
      
      private var _bossTitleImg:Image;
      
      private var _bossAvatar:TimeVortexShowAvatar;
      
      private var _bossTipsImg1:Image;
      
      private var _bossTipsImg2:Image;
      
      private var _bossTipsImg3:Image;
      
      private var _bossTipsTxt:FilterFrameText;
      
      private var _bossRewardView1:TimeVortexRewardView;
      
      private var _bossRewardView2:TimeVortexRewardView;
      
      private var _bossRewardStateImg:Image;
      
      private var _bossFightBtn:IconButton;
      
      private var _bossMopupBtn:IconButton;
      
      private var _lairdTitleImg:Image;
      
      private var _lairdAvatar:ShowAvatar;
      
      private var _lairdNameTxt:FilterFrameText;
      
      private var _lairdTipsImg1:Image;
      
      private var _lairdTipsImg2:Image;
      
      private var _lairdTipsImg3:Image;
      
      private var _lairdTipsImg4:Image;
      
      private var _lairdTipsTxt1:FilterFrameText;
      
      private var _lairdTipsTxt2:FilterFrameText;
      
      private var _lairdRewardView1:TimeVortexRewardView;
      
      private var _lairdRewardView2:TimeVortexRewardView;
      
      private var _lairdFightBtn:IconButton;
      
      private var _lairdRevengeBtn:IconButton;
      
      private var _defaultAvatar:Image;
      
      private var _model:TimeVortexModel = TimeVortexManager.instance.model;
      
      private var _controller:TimeVortexController = FrameControllerManager.instance.timeVortexController;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _data:CampaignAreaInfo = _model.selectedArea;
      
      private var _uuid:String;
      
      private var _grayFilter:ColorMatrixFilter;
      
      private var _lastTime:Number = getTimer();
      
      private var _timeCount:int = 0;
      
      private var _countDiff:int = 1;
      
      private var _occupyDate:Date;
      
      private var _occupyDiffDate:Object;
      
      private var _revengeDate:Date;
      
      private var _revengeDiffDate:Object;
      
      private var _bossNameStr:String = "";
      
      private var _preCampaignId:int = 0;
      
      public function TimeVortexChallengeFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         refreshLairdTips();
         refreshRevengeTips();
         TimeVortexManager.instance.lookUpSingle(_data.campaignId);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,586,553);
      }
      
      private function initView() : void
      {
         titleText = _data.areaName;
         _border = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.back");
         _bossTitleImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.bossTitleImg");
         _bossAvatar = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexChallengeFrame.bossAvatar");
         _bossTipsImg1 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.bossTipsImg1");
         _bossTipsImg2 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.bossTipsImg2");
         _bossTipsImg3 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.bossTipsImg3");
         _bossTipsTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.bossTipsTxt");
         _bossRewardView1 = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexChallengeFrame.bossRewardView1");
         _bossRewardView2 = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexChallengeFrame.bossRewardView2");
         _bossRewardStateImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.bossRewardStateImg");
         _bossFightBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.bossFightBtn");
         _bossMopupBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.bossMopupBtn");
         _lairdTitleImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdTitleImg");
         _lairdAvatar = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexChallengeFrame.lairdAvatar");
         _lairdNameTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdNameTxt");
         _lairdTipsImg1 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdTipsImg1");
         _lairdTipsImg2 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdTipsImg2");
         _lairdTipsImg3 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdTipsImg3");
         _lairdTipsImg4 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdTipsImg4");
         _lairdTipsTxt1 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdTipsTxt1");
         _lairdTipsTxt2 = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdTipsTxt2");
         _lairdRewardView1 = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexChallengeFrame.lairdRewardView1");
         _lairdRewardView2 = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexChallengeFrame.lairdRewardView2");
         _lairdFightBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdFightBtn");
         _lairdRevengeBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.lairdRevengeBtn");
         _defaultAvatar = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame.defaultAvatar");
         _defaultAvatar.setFrame(4);
         _grayFilter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         addToContent(_border);
         addToContent(_back);
         addToContent(_bossTitleImg);
         addToContent(_bossAvatar);
         addToContent(_bossTipsImg1);
         addToContent(_bossTipsImg2);
         addToContent(_bossTipsImg3);
         addToContent(_bossTipsTxt);
         addToContent(_bossRewardView1);
         addToContent(_bossRewardView2);
         addToContent(_bossRewardStateImg);
         addToContent(_bossFightBtn);
         addToContent(_bossMopupBtn);
         addToContent(_lairdTitleImg);
         addToContent(_defaultAvatar);
         addToContent(_lairdAvatar);
         addToContent(_lairdNameTxt);
         addToContent(_lairdTipsImg1);
         addToContent(_lairdTipsImg2);
         addToContent(_lairdTipsImg3);
         addToContent(_lairdTipsImg4);
         addToContent(_lairdTipsTxt1);
         addToContent(_lairdTipsTxt2);
         addToContent(_lairdRewardView1);
         addToContent(_lairdRewardView2);
         addToContent(_lairdFightBtn);
         addToContent(_lairdRevengeBtn);
         initRewards();
         _lairdFightBtn.tipData = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.lairdFightBtn.tipdata");
         _lairdRevengeBtn.tipData = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.lairdFightBtn.tipdata");
      }
      
      private function initRewards() : void
      {
         var _loc1_:Dictionary = _model.getDropInfos(_data.campaignId);
         if(_loc1_)
         {
            _bossRewardView1.dropInfos = _loc1_[1] as Vector.<TimeVortexDropTemplateInfo>;
            _bossRewardView2.dropInfos = _loc1_[2] as Vector.<TimeVortexDropTemplateInfo>;
            _lairdRewardView1.dropInfos = _loc1_[3] as Vector.<TimeVortexDropTemplateInfo>;
            _lairdRewardView2.dropInfos = _loc1_[4] as Vector.<TimeVortexDropTemplateInfo>;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bossTitleImg);
         _bossTitleImg = null;
         ObjectUtils.disposeObject(_bossAvatar);
         _bossAvatar = null;
         ObjectUtils.disposeObject(_bossTipsImg1);
         _bossTipsImg1 = null;
         ObjectUtils.disposeObject(_bossTipsImg2);
         _bossTipsImg2 = null;
         ObjectUtils.disposeObject(_bossTipsImg3);
         _bossTipsImg3 = null;
         ObjectUtils.disposeObject(_bossTipsTxt);
         _bossTipsTxt = null;
         ObjectUtils.disposeObject(_bossRewardView1);
         _bossRewardView1 = null;
         ObjectUtils.disposeObject(_bossRewardView2);
         _bossRewardView2 = null;
         ObjectUtils.disposeObject(_bossRewardStateImg);
         _bossRewardStateImg = null;
         ObjectUtils.disposeObject(_bossFightBtn);
         _bossFightBtn = null;
         ObjectUtils.disposeObject(_bossMopupBtn);
         _bossMopupBtn = null;
         ObjectUtils.disposeObject(_lairdTitleImg);
         _lairdTitleImg = null;
         ObjectUtils.disposeObject(_lairdAvatar);
         _lairdAvatar = null;
         ObjectUtils.disposeObject(_lairdNameTxt);
         _lairdNameTxt = null;
         ObjectUtils.disposeObject(_lairdTipsImg1);
         _lairdTipsImg1 = null;
         ObjectUtils.disposeObject(_lairdTipsImg2);
         _lairdTipsImg2 = null;
         ObjectUtils.disposeObject(_lairdTipsImg3);
         _lairdTipsImg3 = null;
         ObjectUtils.disposeObject(_lairdTipsImg4);
         _lairdTipsImg4 = null;
         ObjectUtils.disposeObject(_lairdTipsTxt1);
         _lairdTipsTxt1 = null;
         ObjectUtils.disposeObject(_lairdTipsTxt2);
         _lairdTipsTxt2 = null;
         ObjectUtils.disposeObject(_lairdRewardView1);
         _lairdRewardView1 = null;
         ObjectUtils.disposeObject(_lairdRewardView2);
         _lairdRewardView2 = null;
         ObjectUtils.disposeObject(_lairdFightBtn);
         _lairdFightBtn = null;
         ObjectUtils.disposeObject(_lairdRevengeBtn);
         _lairdRevengeBtn = null;
         ObjectUtils.disposeObject(_defaultAvatar);
         _defaultAvatar = null;
         ObjectUtils.disposeObject(_grayFilter);
         _grayFilter = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _model = null;
         _controller = null;
         _playerInfo = null;
         _grayFilter = null;
         _occupyDate = null;
         _occupyDiffDate = null;
         _revengeDate = null;
         _revengeDiffDate = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _bossFightBtn.addEventListener("click",__bossFightBtnClickHandler);
         _bossMopupBtn.addEventListener("click",__bossMopupBtnClickHandler);
         _lairdFightBtn.addEventListener("click",__lairdFightBtnClickHandler);
         _lairdRevengeBtn.addEventListener("click",__lairdRevengeBtnClickHandler);
         _model.addEventListener("SINGLE_LAIRD_INFO_CHANGE",__singleLairdInfoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_bossFightBtn)
         {
            _bossFightBtn.removeEventListener("click",__bossFightBtnClickHandler);
         }
         if(_bossMopupBtn)
         {
            _bossMopupBtn.removeEventListener("click",__bossMopupBtnClickHandler);
         }
         if(_lairdFightBtn)
         {
            _lairdFightBtn.removeEventListener("click",__lairdFightBtnClickHandler);
         }
         if(_lairdRevengeBtn)
         {
            _lairdRevengeBtn.removeEventListener("click",__lairdRevengeBtnClickHandler);
         }
         if(_model)
         {
            _model.removeEventListener("SINGLE_LAIRD_INFO_CHANGE",__singleLairdInfoChangeHandler);
         }
      }
      
      private function __singleLairdInfoChangeHandler(param1:TimeVortexEvent) : void
      {
         var _loc2_:CampaignAreaInfo = param1.data as CampaignAreaInfo;
         if(!_data || !_loc2_)
         {
            return;
         }
         if(_data.campaignId != _loc2_.campaignId)
         {
            return;
         }
         if(_uuid == _loc2_.uuid)
         {
            return;
         }
         refreshView();
         _uuid = _loc2_.uuid;
      }
      
      private function __lairdRevengeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!bossChallenged)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt04");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(0 == _data.userId)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt06");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_playerInfo.userId == _data.userId)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt05");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(StringHelper.isNullOrEmpty(_playerInfo.timeVortexRevengeTime) && 0 == _playerInfo.timeVortexRevenge)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt05");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!canRevenge)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt11");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:int = int(_model.selectedChapter.getChapterRevengeCost());
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc8_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc10_:String = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt08");
         var _loc6_:String = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt09",_loc3_);
         var _loc7_:String = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt10");
         var _loc9_:String = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useBind");
         SimpleAlertHelper.instance.data = [lairdRevengeCallBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc10_,_loc4_,_loc5_,true,true,false,2,"USEBINDPOINT_WITHCHOICE_AUTOLAYOUT_ALERT",250,_loc7_,null,"SimpleAlert",_loc3_,350,_loc6_,_loc9_);
      }
      
      private function lairdRevengeCallBack(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(param1)
         {
            revengeLaird(param3,param2);
         }
      }
      
      private function __lairdFightBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(!bossChallenged)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt04");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_playerInfo.userId == _data.userId)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_playerInfo.timeVortexRevenge != 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt07");
            SimpleAlertHelper.instance.data = [lairdFightCallBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,true,true,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert",null,200);
            return;
         }
         if(_playerInfo.timeVortexCapture != 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt02");
            SimpleAlertHelper.instance.data = [lairdFightCallBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
            return;
         }
         challengeLaird();
      }
      
      private function get bossChallenged() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Dictionary = CampaignRankManager.instance.timeVortexRankDic;
         if(_loc2_[_data.campaignId])
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function get hasLaird() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_data && _data.userId != 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function get canRevenge() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_data && _playerInfo.timeVortexRevenge != 0 && _playerInfo.timeVortexRevenge == _data.campaignId)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function lairdFightCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            challengeLaird();
         }
      }
      
      private function __bossMopupBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(bossChallenged && _playerInfo.timeVortexCount >= _model.challengeMax)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         MopupManager.instance.model.campaignId = _data.campaignId;
         FrameControllerManager.instance.openControllerByInfo("mopup",11);
      }
      
      private function __bossFightBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(bossChallenged && _playerInfo.timeVortexCount >= _model.challengeMax)
         {
            _loc2_ = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.TipsTxt01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         challengeBoss();
      }
      
      private function revengeLaird(param1:Boolean = false, param2:Boolean = true) : void
      {
         _model.challengeCampaignTem = _data.getMapById(_data.campaignId);
         TimeVortexManager.instance.revengeLaird(_data.campaignId,param1,param2);
      }
      
      private function challengeLaird() : void
      {
         _model.challengeCampaignTem = _data.getMapById(_data.campaignId);
         TimeVortexManager.instance.challengeLaird(_data.campaignId);
      }
      
      private function challengeBoss() : void
      {
         _model.challengeCampaignTem = _data.getMapById(_data.campaignId);
         TimeVortexManager.instance.challengeBoss(_data.campaignId);
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
         var _loc1_:int = _model.challengeMax - _playerInfo.timeVortexCount;
         _bossTipsTxt.text = LanguageMgr.GetTranslation("timevortex.view.TimeVortexAreaView.TipsTxt",_loc1_,_model.challengeMax);
         _lairdTipsTxt1.text = "";
         _lairdTipsTxt2.text = "";
         _bossAvatar.data = _data;
         _bossAvatar.showName(getBossName(_data.campaignId));
         if(hasLaird)
         {
            _lairdNameTxt.text = _data.nickName;
            _lairdAvatar.data = _data.thane;
            _defaultAvatar.visible = false;
            _lairdAvatar.visible = true;
            _lairdTipsImg1.visible = true;
            _lairdNameTxt.visible = true;
            initLairdTips();
         }
         else
         {
            _defaultAvatar.visible = true;
            _lairdAvatar.visible = false;
            _lairdTipsImg1.visible = false;
            _lairdNameTxt.visible = false;
         }
         if(canRevenge)
         {
            _lairdTipsImg4.visible = true;
            initRevengeTips();
         }
         else
         {
            _lairdTipsImg4.visible = false;
         }
         if(bossChallenged)
         {
            _bossMopupBtn.enable = true;
            _bossRewardView1.filters = [_grayFilter];
            _bossRewardStateImg.visible = true;
         }
         else
         {
            _bossMopupBtn.enable = false;
            _bossRewardView1.filters = null;
            _bossRewardStateImg.visible = false;
         }
      }
      
      private function getBossName(param1:int) : String
      {
         var _loc2_:CampaignTemplate = null;
         var _loc4_:Array = null;
         var _loc3_:int = 0;
         var _loc5_:GameHeroTempInfo = null;
         if(_preCampaignId != param1)
         {
            _loc2_ = _data.getMapById(param1);
            if(_loc2_ && _loc2_.MapIds)
            {
               _loc4_ = _loc2_.MapIds.split(",");
               _loc3_ = int(_loc4_[0]);
               _loc5_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc3_);
               if(_loc5_)
               {
                  _bossNameStr = _loc5_.TemplateName;
               }
            }
         }
         return _bossNameStr;
      }
      
      private function initLairdTips() : void
      {
         var _loc2_:Date = DateFormatter.parse(_data.occupyTime,"YYYY-MM-DD hh:mm:ss");
         if(_occupyDate && _occupyDate.time == _loc2_.time)
         {
            return;
         }
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc3_:Object = DateFormatter.compareDate4(_loc2_,_loc1_);
         _timeCount = _loc3_.sec;
         _occupyDiffDate = _loc3_;
         _occupyDate = _loc2_;
      }
      
      private function refreshLairdTips() : void
      {
         if(_occupyDiffDate == null)
         {
            return;
         }
         var _loc4_:int = int(_occupyDiffDate.sec);
         var _loc3_:int = int(_occupyDiffDate.min);
         var _loc2_:int = int(_occupyDiffDate.hour);
         _loc4_ += _countDiff;
         _occupyDiffDate.sec = _loc4_;
         if(_loc4_ >= 60)
         {
            _occupyDiffDate.sec = _loc4_ % 60;
            _loc3_++;
            _occupyDiffDate.min = _loc3_;
            if(_loc3_ >= 60)
            {
               _occupyDiffDate.min = _loc3_ % 60;
               _loc2_++;
               _occupyDiffDate.hour = _loc2_;
            }
         }
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         var _loc1_:int = _occupyDiffDate.sec + _occupyDiffDate.min * 60 + _occupyDiffDate.hour * 3600;
         _lairdTipsTxt1.text = DateFormatter.getConsortiaCountDate(_loc1_);
      }
      
      private function initRevengeTips() : void
      {
         var _loc2_:Date = DateFormatter.parse(_playerInfo.timeVortexRevengeTime,"YYYY-MM-DD hh:mm:ss");
         if(_revengeDate && _revengeDate.time == _loc2_.time)
         {
            return;
         }
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc3_:Object = DateFormatter.compareDate4(_loc2_,_loc1_);
         _revengeDiffDate = _loc3_;
         _revengeDate = _loc2_;
      }
      
      private function refreshRevengeTips() : void
      {
         var _loc11_:String = null;
         var _loc3_:String = null;
         var _loc12_:String = null;
         if(_revengeDiffDate == null)
         {
            return;
         }
         var _loc9_:int = int(_revengeDiffDate.sec);
         var _loc8_:int = int(_revengeDiffDate.min);
         var _loc6_:int = int(_revengeDiffDate.hour);
         _loc9_ += _countDiff;
         _revengeDiffDate.sec = _loc9_;
         if(_loc9_ >= 60)
         {
            _revengeDiffDate.sec = _loc9_ % 60;
            _loc8_++;
            _revengeDiffDate.min = _loc8_;
            if(_loc8_ >= 60)
            {
               _revengeDiffDate.min = _loc8_ % 60;
               _loc6_++;
               _revengeDiffDate.hour = _loc6_;
            }
         }
         if(_loc9_ < 0)
         {
            _loc9_ = 0;
         }
         if(_loc8_ < 0)
         {
            _loc8_ = 0;
         }
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         var _loc13_:int = 3600;
         var _loc5_:int = _loc6_ * 3600 + _loc8_ * 60 + _loc9_;
         var _loc7_:int = _loc13_ - _loc5_;
         var _loc2_:int = _loc7_ / 60;
         var _loc1_:int = _loc2_ / 60;
         var _loc10_:int = _loc7_ % 60;
         var _loc14_:int = _loc2_ % 60;
         var _loc4_:int = _loc1_;
         if(_loc10_ < 10)
         {
            _loc11_ = "0" + _loc10_.toString();
         }
         else
         {
            _loc11_ = _loc10_.toString();
         }
         if(_loc14_ < 10)
         {
            _loc3_ = "0" + _loc14_.toString();
         }
         else
         {
            _loc3_ = _loc14_.toString();
         }
         if(_loc4_ < 10)
         {
            _loc12_ = "0" + _loc4_.toString();
         }
         else
         {
            _loc12_ = _loc4_.toString();
         }
         _lairdTipsTxt2.text = LanguageMgr.GetTranslation("timevortex.TimeVortexChallengeFrame.LairdTipsTxt",_loc12_,_loc3_,_loc11_);
      }
      
      public function enterFrame() : void
      {
         if(_bossAvatar && _bossAvatar.parent && _bossAvatar.visible)
         {
            _bossAvatar.execute();
         }
         var _loc1_:Number = getTimer();
         var _loc2_:Number = _loc1_ - _lastTime;
         if(_loc2_ >= 1000)
         {
            _countDiff = _loc2_ / 1000;
            if(hasLaird)
            {
               refreshLairdTips();
            }
            if(canRevenge)
            {
               refreshRevengeTips();
            }
            _timeCount += _countDiff;
            _lastTime = _loc1_;
         }
         if(_timeCount >= 2)
         {
            _timeCount = 0;
            if(hasLaird || canRevenge)
            {
               TimeVortexManager.instance.lookUpSingle(_data.campaignId);
            }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      override public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

