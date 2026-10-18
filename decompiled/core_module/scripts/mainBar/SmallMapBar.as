package mainBar
{
   import com.greensock.TweenMax;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.SoundManager;
   import events.EmailEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.GuideTaskManager;
   import managers.MopupManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.template.MapTemplate;
   import mvc.controler.GuideTaskController;
   import mvc.controler.SortController;
   import mvc.module.guidetask.GuideTaskInfo;
   import mvc.module.sort.SortModel;
   import yishi.SwitchPageHelp;
   import yishi.datas.PathInfo;
   import yishi.datas.UserInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.CustomerServiceManager;
   import yishi.manager.EmailManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.UpdateBroadCastFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SmallMapBar extends Sprite
   {
      
      private static var _instance:SmallMapBar;
      
      public static const SPACE_SMALL_MAP_STATE:int = 1;
      
      public static const CAMPAIGN_SMALL_MAP_STATE:int = 2;
      
      public static const CAMPAIGN_SMALL_MAP_STATE2:int = 3;
      
      public static const CASTLE_SMALL_MAP_STATE:int = 4;
      
      public static const HOOKROOM_SMALL_MAP_STATE:int = 5;
      
      public static const OUTERCITY_SMALL_MAP_STATE:int = 6;
      
      public static const SPACE:int = 1;
      
      public static const CASTLE:int = 2;
      
      public static const OUTERCITY:int = 3;
      
      public static const LOCATEARMY:int = 4;
      
      public static const RETURNCASTLE:int = 5;
      
      private const SAMLL_MAP_WIDTH:int = 173;
      
      private const SAMLL_MAP_HEIGHT:int = 99;
      
      private var _backMc:MovieClip;
      
      private var _spaceBtn:IconButton;
      
      private var _spaceBtnStripView:StripView;
      
      private var _castleBtn:IconButton;
      
      private var _outercityBtn:IconButton;
      
      private var _titleText:FilterFrameText;
      
      private var _updateFrame:UpdateBroadCastFrame;
      
      private var _sprite:Sprite;
      
      private var _zoomBg:Bitmap;
      
      private var _inputPosTextX:TextField;
      
      private var _inputPosYText:TextField;
      
      private var _inputPosCText:TextField;
      
      private var _zoomBtn:BaseButton;
      
      private var _locateArmyBtn:IconButton;
      
      private var _returnCastleBtn:IconButton;
      
      private var _transmitBtn:IconButton;
      
      private var _locateHkeeBtn:IconButton;
      
      private var _attackBtn:IconButton;
      
      private var _skipNewbieBtn:BaseButton;
      
      private var _dayGuideBtn:BaseButton;
      
      private var _customerServiceBtn:BaseButton;
      
      private var _updateBtn:BaseButton;
      
      private var _setBtn:BaseButton;
      
      private var _rankingBtn:BaseButton;
      
      private var _mailBtn:BaseButton;
      
      private var _othersShowBtn:BaseButton;
      
      private var _othersShowBtnStripView:StripView;
      
      private var _othersHideBtn:BaseButton;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _customerServiceBtnEffect:MainToolBtnGlowEffect;
      
      private var _pvpHelpBtn:BaseButton;
      
      private var _mapInfo:MapTemplate;
      
      private var _campaignGuideCallBack:Function;
      
      private var _preAttackHandler:Function;
      
      private var _BigMap_X:Number;
      
      private var _BigMap_Y:Number;
      
      private var _curState:int;
      
      private var _funPreviewBtn:IconButton;
      
      private var _faceBookBtn:BaseButton;
      
      private var _guideTaskBtn:BaseButton;
      
      private var _guideTaskEff:MovieClip;
      
      private var _guideTaskTxt:Bitmap;
      
      private var _guideGetRewardBg:Bitmap;
      
      private var _guideGetRewardTxt:GradientText;
      
      private var _guideGetRewardEff:MovieClip;
      
      private var _mailStrip:StripView;
      
      private var _friendsStrip:StripView;
      
      private var _localArmyCallBack:Function;
      
      private var _localCastleCallBack:Function;
      
      private var _moveCallBack:Function;
      
      private var _returnCastleBack:Function;
      
      private var _transmitCastleBack:Function;
      
      private var _timeIcon:Image;
      
      public function SmallMapBar()
      {
         super();
         initView();
         addEvent();
         if(EmailManager.instance.existUnreadMail())
         {
            _effect.play();
         }
         this.mouseEnabled = false;
         this.scrollRect = null;
         showBtnAndEff();
         setBtnAndEffXY();
         _instance = this;
      }
      
      public static function get instance() : SmallMapBar
      {
         if(!_instance)
         {
            _instance = new SmallMapBar();
         }
         return _instance;
      }
      
      private function setBtnAndEffXY() : void
      {
         var _loc1_:int = -165;
         var _loc2_:int = 200;
         _guideTaskBtn.x = _loc1_;
         _guideTaskBtn.y = _loc2_;
         _guideTaskEff.x = _loc1_ + 1;
         _guideTaskEff.y = _loc2_ - 1;
         _guideTaskTxt.x = _loc1_ + 7;
         _guideTaskTxt.y = _loc2_ + 43;
         _guideGetRewardBg.x = _loc1_ - 14;
         _guideGetRewardBg.y = _loc2_ + 3;
         _guideGetRewardTxt.x = _loc1_ - 10;
         _guideGetRewardTxt.y = _loc2_ + 7;
         _guideGetRewardEff.x = _loc1_;
         _guideGetRewardEff.y = _loc2_;
      }
      
      private function showBtnAndEff() : void
      {
         var _loc1_:GuideTaskInfo = GuideTaskManager.instance.model;
         if(_loc1_.statu == 0)
         {
            _guideTaskBtn.visible = false;
            _guideTaskEff.visible = false;
            _guideTaskTxt.visible = false;
            _guideGetRewardBg.visible = false;
            _guideGetRewardTxt.visible = false;
            _guideGetRewardEff.visible = false;
         }
         else if(_loc1_.statu == 1)
         {
            _guideTaskBtn.visible = true;
            _guideTaskTxt.visible = true;
            if(GuideTaskManager.instance.isShowEff())
            {
               _guideGetRewardBg.visible = true;
               _guideGetRewardTxt.visible = true;
               _guideGetRewardEff.visible = true;
               _guideTaskEff.visible = false;
            }
            else
            {
               _guideGetRewardBg.visible = false;
               _guideGetRewardTxt.visible = false;
               _guideTaskEff.visible = true;
               _guideGetRewardEff.visible = false;
            }
         }
      }
      
      public function hidenGuild() : void
      {
         _guideTaskBtn.visible = false;
         _guideTaskEff.visible = false;
         _guideTaskTxt.visible = false;
         _guideGetRewardBg.visible = false;
         _guideGetRewardTxt.visible = false;
         _guideGetRewardEff.visible = false;
      }
      
      private function initView() : void
      {
         _backMc = ComponentFactory.Instance.creatCustomObject("asset.smallMap.BgMcAsset");
         _zoomBg = ComponentFactory.Instance.creatBitmap("asset.smallMap.zoomBtnBg");
         _zoomBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.ZoomBtn");
         _inputPosTextX = ComponentFactory.Instance.creatComponentByStylename("smallMap.InputPosText");
         _inputPosYText = ComponentFactory.Instance.creatComponentByStylename("smallMap.InputPosYText");
         _inputPosCText = ComponentFactory.Instance.creatComponentByStylename("smallMap.InputPosCText");
         _locateArmyBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.LocateArmyBtn");
         _transmitBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.campaignTransmitBtn");
         _returnCastleBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.ResultCastleBtn");
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.AttackBtn");
         _locateHkeeBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.LocateHkeeBtn");
         _spaceBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.SpaceBtn");
         _spaceBtnStripView = ComponentFactory.Instance.creatComponentByStylename("smallMap.SpaceBtnTip");
         _castleBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.CastleBtn");
         _outercityBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.OutercityBtn");
         _titleText = ComponentFactory.Instance.creatComponentByStylename("smallMap.TitleText");
         _pvpHelpBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.HelpBtn");
         _customerServiceBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.CustomerServiceBtn");
         _dayGuideBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.DayGuideBtn");
         _skipNewbieBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.NoviceCloseBtn");
         _updateBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.UpdateBtn");
         _setBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.SetBtn");
         _rankingBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.RankingBtn");
         _mailBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.MailBtn");
         _othersShowBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.OthersShowBtn");
         _othersShowBtnStripView = ComponentFactory.Instance.creatComponentByStylename("smallMap.OthersShowBtnTip");
         _othersHideBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.OthersHideBtn");
         _funPreviewBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.FunPreviewBtn");
         _faceBookBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.FaceBookBtn");
         _guideTaskBtn = ComponentFactory.Instance.creatComponentByStylename("smallMap.guideTaskBtn");
         _guideTaskEff = ComponentFactory.Instance.creatCustomObject("asset.smallmap.guideTaskBtnEff");
         _guideTaskTxt = ComponentFactory.Instance.creatBitmap("asset.smallMap.guideTaskTxt");
         _guideGetRewardBg = ComponentFactory.Instance.creatBitmap("asset.smallmap.getRewardbg");
         _guideGetRewardTxt = ComponentFactory.Instance.creatComponentByStylename("smallMap.getRewardTxt_2");
         _guideGetRewardEff = ComponentFactory.Instance.creatCustomObject("asset.smallmap.guideTaskRewardEff");
         _mailStrip = ComponentFactory.Instance.creatCustomObject("smallMap.mailStrip");
         _friendsStrip = ComponentFactory.Instance.creatCustomObject("smallMap.friendsStrip");
         _timeIcon = ComponentFactory.Instance.creatComponentByStylename("smallMap.TimeIcon");
         _timeIcon.tipData = PlayerManager.instance.currentPlayerModel;
         _guideTaskEff.mouseChildren = false;
         _guideTaskEff.mouseEnabled = false;
         _guideTaskEff.x = -99;
         _guideTaskEff.y = 209;
         _guideGetRewardEff.x = -99;
         _guideGetRewardEff.y = 210;
         _guideGetRewardEff.mouseChildren = false;
         _guideGetRewardEff.mouseEnabled = false;
         _guideGetRewardTxt.mouseChildren = false;
         _guideGetRewardTxt.mouseEnabled = false;
         _guideTaskBtn.tipData = LanguageMgr.GetTranslation("guidetask.GuideTaskFrame.titleTxt");
         _skipNewbieBtn.visible = false;
         _sprite = new Sprite();
         _sprite.x = 10;
         _sprite.y = 0;
         _inputPosCText.mouseEnabled = false;
         _sprite.addChild(_zoomBg);
         _sprite.addChild(_zoomBtn);
         _sprite.addChild(_inputPosTextX);
         _sprite.addChild(_inputPosYText);
         _sprite.addChild(_inputPosCText);
         _sprite.addChild(_locateArmyBtn);
         _sprite.addChild(_transmitBtn);
         _sprite.addChild(_returnCastleBtn);
         _sprite.addChild(_attackBtn);
         _sprite.addChild(_locateHkeeBtn);
         _zoomBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.zoomBtnTipData");
         _locateHkeeBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.locateHkeeBtnTipData");
         _locateArmyBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.locateArmyBtnTipData");
         _transmitBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.transmitBtnTipData");
         _returnCastleBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.returnCastleBtnTipData");
         _attackBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.attackBtnTipData");
         addChild(_backMc);
         addChild(_spaceBtnStripView);
         _spaceBtnStripView.addChild(_spaceBtn);
         addChild(_castleBtn);
         addChild(_outercityBtn);
         addChild(_pvpHelpBtn);
         addChild(_titleText);
         addChild(_updateBtn);
         addChild(_skipNewbieBtn);
         addChild(_setBtn);
         addChild(_rankingBtn);
         addChild(_mailBtn);
         addChild(_othersShowBtnStripView);
         _othersShowBtnStripView.addChild(_othersShowBtn);
         addChild(_othersHideBtn);
         addChild(_guideTaskBtn);
         addChild(_guideTaskEff);
         addChild(_guideTaskTxt);
         addChild(_guideGetRewardBg);
         addChild(_guideGetRewardTxt);
         _guideGetRewardTxt.text = LanguageMgr.GetTranslation("ui.queuebar.view.getReward.text");
         addChild(_guideGetRewardEff);
         addChild(_sprite);
         _sprite.visible = false;
         addChild(_mailStrip);
         addChild(_friendsStrip);
         addChild(_timeIcon);
         _mailBtn.enable = false;
         _mailStrip.setTarget(_mailBtn);
         refreshOthersBtn();
         _backMc.scrollRect = null;
         _spaceBtnStripView.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.spaceBtnTipData");
         _castleBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.castleBtnTipData");
         _outercityBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.outercityBtnTipData");
         _titleText.text = LanguageMgr.GetTranslation("mainBar.SmallMapBar.title");
         _dayGuideBtn.tipData = LanguageMgr.GetTranslation("mainBar.TopToolsBar.dailyRoutineBtnTipData");
         _updateBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.updataBtnTipData_2");
         _setBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.setBtnTipData");
         _rankingBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.rankingBtnTipData");
         _mailBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.mailBtnTipData");
         _othersShowBtnStripView.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.OthersShowBtnTipData");
         _othersHideBtn.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.OthersHideBtnTipData");
         _mailStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",6);
         _friendsStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",6);
         _effect = new MainToolBtnGlowEffect(_mailBtn);
         _effect.stop();
         _customerServiceBtnEffect = new MainToolBtnGlowEffect(_customerServiceBtn);
         _customerServiceBtnEffect.stop();
         setCustomerBtn();
      }
      
      public function initData(param1:MapTemplate, param2:Function = null, param3:Function = null, param4:Function = null, param5:Function = null, param6:Function = null, param7:Function = null, param8:Function = null) : void
      {
         _mapInfo = param1;
         _campaignGuideCallBack = param2;
         _preAttackHandler = param3;
         _localArmyCallBack = param5;
         _moveCallBack = param6;
         _returnCastleBack = param7;
         _localCastleCallBack = param8;
         _transmitCastleBack = param4;
         if(_mapInfo)
         {
            _titleText.text = _mapInfo.MapName;
         }
      }
      
      private function addEvent() : void
      {
         _locateArmyBtn.addEventListener("click",__localArmyHandler);
         _returnCastleBtn.addEventListener("click",__returnCastleHandler);
         _transmitBtn.addEventListener("click",__onTransmitHandler);
         _attackBtn.addEventListener("click",__attackHandler);
         _locateHkeeBtn.addEventListener("click",__localCastleHandler);
         _zoomBtn.addEventListener("click",__moveMapHandler);
         _inputPosTextX.addEventListener("keyDown",__keyDownHandler);
         _inputPosYText.addEventListener("keyDown",__keyDownHandler);
         StageReferance.addEventListener("resize",__onResizeHandler);
         _spaceBtn.addEventListener("click",__spaceClickHandler);
         _castleBtn.addEventListener("click",__castleClickHandler);
         _outercityBtn.addEventListener("click",__outercityClickHandler);
         _skipNewbieBtn.addEventListener("click",__skipNewbieHandler);
         _dayGuideBtn.addEventListener("click",__dayGuideBtnClickHandler);
         _pvpHelpBtn.addEventListener("click",__pvpHelpClickHandler);
         _updateBtn.addEventListener("click",__lookUpdateHander);
         _setBtn.addEventListener("click",__setHander);
         _rankingBtn.addEventListener("click",__rankingHander);
         _mailBtn.addEventListener("click",__mailHander);
         _othersShowBtn.addEventListener("click",__othersShowHander);
         _othersHideBtn.addEventListener("click",__othersHideHander);
         _customerServiceBtn.addEventListener("click",__customerServiceBtnHandler);
         _funPreviewBtn.addEventListener("click",__funPreviewBtnClickHandler);
         _guideTaskBtn.addEventListener("click",__guideTaskBtnHandler);
         CustomerServiceManager.instance.addEventListener("new_reply",__newServiceReplyHandler);
         EmailManager.instance.addEventListener("DATA_EMAIL_NEW",__onNewMailHandler);
         EmailManager.instance.addEventListener("EMAIL_STARTREAD",__onNewMailHandler);
         NotificationManager.instance.addEventListener("CUSTOMER_SERVICE_SWITCH",__onCustomerServiceSwitchHandler);
         ArmyManager.instance.thane.addEventListener("THANE_LEVEL_UPDATE",__thaneLevelUpdateHandler);
         _faceBookBtn.addEventListener("click",__faceBookBtnHandler);
         NotificationManager.instance.addEventListener("SHOWBTN",_showButton);
         NotificationManager.instance.addEventListener("SHOWEFF",_showEffer);
         NotificationManager.instance.addEventListener("UP_DATA_SHOW_PLAYER_VIEW",__showOtherHander);
      }
      
      private function _showButton(param1:NotificationEvent) : void
      {
         var _loc2_:int = param1.data as int;
         if(_loc2_ == 0)
         {
            _guideTaskBtn.visible = false;
            _guideTaskEff.visible = false;
            _guideTaskTxt.visible = false;
            _guideGetRewardBg.visible = false;
            _guideGetRewardTxt.visible = false;
            _guideGetRewardEff.visible = false;
         }
         else if(_loc2_ == 1)
         {
            _guideTaskBtn.visible = true;
            _guideTaskTxt.visible = true;
            if(GuideTaskManager.instance.isShowEff())
            {
               _guideGetRewardBg.visible = true;
               _guideGetRewardTxt.visible = true;
               if(!_guideTaskBtn.visible)
               {
                  _guideTaskEff.visible = false;
                  _guideGetRewardEff.visible = true;
               }
            }
            else
            {
               _guideGetRewardBg.visible = false;
               _guideGetRewardTxt.visible = false;
               if(!_guideTaskBtn.visible)
               {
                  _guideTaskEff.visible = true;
                  _guideGetRewardEff.visible = false;
               }
            }
         }
      }
      
      private function _showEffer(param1:NotificationEvent) : void
      {
         if(GuideTaskManager.instance.isShowEff())
         {
            _guideTaskEff.visible = false;
            _guideGetRewardEff.visible = true;
         }
         else
         {
            _guideTaskEff.visible = true;
            _guideGetRewardEff.visible = false;
         }
         _guideGetRewardBg.visible = true;
         _guideGetRewardTxt.visible = true;
         if(GuideTaskManager.instance.model.statu == 0)
         {
            _guideTaskEff.visible = false;
            _guideGetRewardBg.visible = false;
            _guideGetRewardTxt.visible = false;
            _guideGetRewardEff.visible = false;
         }
      }
      
      private function __guideTaskBtnHandler(param1:MouseEvent) : void
      {
         _guideTaskEff.visible = false;
         _guideGetRewardEff.visible = false;
         FrameControllerManager.instance.openControllerByInfo("guidetask",GuideTaskController.GUIDETYPE_MAIN);
      }
      
      private function removeEvent() : void
      {
         StageReferance.removeEventListener("resize",__onResizeHandler);
         _inputPosTextX.removeEventListener("keyDown",__keyDownHandler);
         _inputPosYText.removeEventListener("keyDown",__keyDownHandler);
      }
      
      private function setCustomerBtn() : void
      {
         addChild(_customerServiceBtn);
         _customerServiceBtn.tipData = LanguageMgr.GetTranslation("customerservice.CustomerServiceFrame.title");
         _customerServiceBtn.enable = ConfigManager.info.CUSTOMER_SERVICE;
      }
      
      public function switchSmallMapState(param1:int) : void
      {
         _curState = param1;
         if(_pvpHelpBtn.parent)
         {
            _pvpHelpBtn.parent.removeChild(_pvpHelpBtn);
         }
         _castleBtn.enable = ArmyManager.instance.thane.grades >= 11;
         _dayGuideBtn.enable = ArmyManager.instance.thane.grades >= 11;
         _spaceBtn.enable = ArmyManager.instance.thane.grades >= 16;
         _updateBtn.enable = ArmyManager.instance.thane.grades >= 16;
         _outercityBtn.enable = ArmyManager.instance.thane.grades >= 15;
         _mailBtn.enable = ArmyManager.instance.thane.grades >= 6;
         _mailStrip.visible = ArmyManager.instance.thane.grades < 6;
         _friendsStrip.visible = ArmyManager.instance.thane.grades < 6;
         _othersShowBtn.enable = false;
         _othersHideBtn.enable = false;
         _sprite.visible = false;
         _skipNewbieBtn.visible = _mapInfo && WorldBossHelper.checkIsNoviceMap(_mapInfo.Id);
         if(ArmyManager.instance.thane.grades >= 16)
         {
            _spaceBtnStripView.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.spaceBtnTipData");
         }
         else
         {
            _spaceBtnStripView.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.spaceBtnTipData2") + " " + 16;
         }
         if(_funPreviewBtn.parent)
         {
            _funPreviewBtn.parent.removeChild(_funPreviewBtn);
         }
         if(ConfigManager.info.FACE_BOOK && ArmyManager.instance.thane.grades >= 20)
         {
            addChild(_faceBookBtn);
            _faceBookBtn.visible = false;
         }
         switch(_curState - 1)
         {
            case 0:
               _spaceBtn.visible = false;
               _castleBtn.visible = true;
               _outercityBtn.visible = false;
               _othersShowBtn.enable = true;
               _othersHideBtn.enable = true;
               _faceBookBtn.visible = true;
               break;
            case 1:
               _othersShowBtn.enable = _othersHideBtn.enable = canHideCampaign();
               if(canHideCampaign())
               {
                  _othersShowBtn.visible = true;
                  _othersHideBtn.visible = false;
                  SharedManager.instance.hideOthers = false;
               }
               else if(canHidePetLand())
               {
                  _othersShowBtn.enable = _othersHideBtn.enable = true;
               }
               _castleBtn.enable = _spaceBtn.enable = _outercityBtn.enable = false;
               if(_mapInfo && WorldBossHelper.checkPvp(_mapInfo.Id))
               {
                  addChild(_pvpHelpBtn);
               }
               if(_mapInfo && WorldBossHelper.checkFlameTemple(_mapInfo.Id))
               {
                  _othersShowBtn.enable = true;
                  _othersHideBtn.enable = true;
               }
               break;
            case 2:
               _castleBtn.enable = _spaceBtn.enable = _outercityBtn.enable = false;
               if(_mapInfo && WorldBossHelper.checkDuskArea(_mapInfo.Id) || WorldBossHelper.checkFlameTemple(_mapInfo.Id) || WorldBossHelper.checkIceFireTemple(_mapInfo.Id))
               {
                  _othersShowBtn.enable = true;
                  _othersHideBtn.enable = true;
               }
               break;
            case 3:
               _spaceBtn.visible = true;
               _castleBtn.visible = false;
               _outercityBtn.visible = false;
               _faceBookBtn.visible = true;
               _titleText.text = LanguageMgr.GetTranslation("mainBar.SmallMapBar.castleTitle");
               break;
            case 5:
               _sprite.visible = true;
               if(ArmyManager.instance.thane.grades < 15)
               {
                  _transmitBtn.visible = false;
                  _attackBtn.visible = false;
               }
               else
               {
                  _transmitBtn.visible = true;
                  _attackBtn.visible = true;
               }
               _spaceBtn.visible = false;
               _castleBtn.visible = false;
               _outercityBtn.visible = true;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _castleBtn.enable = _spaceBtn.enable = _outercityBtn.enable = false;
         }
      }
      
      private function canHideCampaign() : Boolean
      {
         if(WorldBossHelper.checkMineral(CampaignManager.instance.mapId))
         {
            return true;
         }
         return false;
      }
      
      private function canHidePetLand() : Boolean
      {
         if(WorldBossHelper.checkPetLand(CampaignManager.instance.mapId))
         {
            return true;
         }
         return false;
      }
      
      private function __onCustomerServiceSwitchHandler(param1:NotificationEvent) : void
      {
         setCustomerBtn();
      }
      
      private function __thaneLevelUpdateHandler(param1:PlayerEvent) : void
      {
         switchSmallMapState(_curState);
      }
      
      private function __newServiceReplyHandler(param1:Event) : void
      {
         _customerServiceBtnEffect.play();
         PlayerManager.instance.openCustomerServiceFrame = 1;
      }
      
      private function __onNewMailHandler(param1:EmailEvent) : void
      {
         _effect.play();
      }
      
      private function __customerServiceBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(CustomerServiceManager.instance.model.canOpen)
         {
            _customerServiceBtnEffect.stop();
            FrameControllerManager.instance.openControllerByInfo("customerservice");
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.SmallMapBar.customerservice"));
         }
      }
      
      private function __setHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("setting");
      }
      
      private function __rankingHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         openNumOne();
      }
      
      private function openNumOne() : void
      {
         var _loc2_:String = null;
         var _loc3_:SortController = FrameControllerManager.instance.sortController;
         var _loc4_:SortModel = _loc3_.model;
         var _loc1_:Array = [];
         if(_loc4_.playerFightList == null || _loc4_.playerFightList.length == 0)
         {
            _loc2_ = PathManager.orderPath + "fight.xml";
            _loc1_.push(_loc2_);
         }
         if(_loc4_.accumulationAddList == null || _loc4_.accumulationAddList.length == 0)
         {
            _loc2_ = PathManager.orderPath + "total.xml";
            _loc1_.push(_loc2_);
         }
         if(_loc4_.playerHonourList == null || _loc4_.playerHonourList.length == 0)
         {
            _loc2_ = PathManager.orderPath + "geste.xml";
            _loc1_.push(_loc2_);
         }
         if(_loc4_.charmsTotalAddList == null || _loc4_.charmsTotalAddList.length == 0)
         {
            _loc2_ = PathManager.orderPath + "totalcharm.xml";
            _loc1_.push(_loc2_);
         }
         if(_loc4_.soulScoreTotalAddList == null || _loc4_.soulScoreTotalAddList.length == 0)
         {
            _loc2_ = PathManager.orderPath + "soulscore.xml";
            _loc1_.push(_loc2_);
         }
         if(_loc4_.petPowerList == null || _loc4_.petPowerList.length == 0)
         {
            _loc2_ = PathManager.orderPath + "petfightcapacityrank.xml";
            _loc1_.push(_loc2_);
         }
         if(_loc1_.length > 0)
         {
            _loc3_.loadAllLocalXML(_loc1_,showNumberOne);
         }
         else
         {
            showNumberOne();
         }
      }
      
      private function showNumberOne() : void
      {
         FrameControllerManager.instance.openControllerByInfo("shoubang");
      }
      
      private function __mailHander(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc2_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.mailBtn.underLevel");
            MessageTipManager.instance().show(_loc2_);
         }
         else
         {
            _effect.stop();
            FrameControllerManager.instance.openControllerByInfo("email","email.EmailFrame");
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
      
      private function __showOtherHander(param1:NotificationEvent) : void
      {
         refreshOthersVisibleBtn(param1.data);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_OTHERS",param1.data));
      }
      
      private function refreshOthersVisibleBtn(param1:Boolean = false) : void
      {
         SharedManager.instance.hideOthers = param1;
         SharedManager.instance.saveHideOthers();
         refreshOthersBtn();
      }
      
      private function refreshOthersBtn() : void
      {
         if(!SharedManager.instance.hideOthers)
         {
            _othersShowBtn.visible = true;
            _othersHideBtn.visible = false;
         }
         else
         {
            _othersShowBtn.visible = false;
            _othersHideBtn.visible = true;
         }
      }
      
      private function __lookUpdateHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_updateFrame || _updateFrame.isDie)
         {
            _updateFrame = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.BroadCastFrame");
            _updateFrame.show();
         }
         else
         {
            TweenMax.to(_updateFrame,1,{
               "scaleX":0.01,
               "scaleY":0.01,
               "x":stage.stageWidth - 35,
               "y":50,
               "onComplete":tweenComplete
            });
         }
      }
      
      private function showAddFriendAlert() : void
      {
         FriendManager.getInstance().popBufferFrame();
      }
      
      private function tweenComplete() : void
      {
         _updateFrame.dispose();
         _updateFrame = null;
      }
      
      private function __spaceClickHandler(param1:MouseEvent) : void
      {
         SwitchPageHelp.enterToSpace();
      }
      
      private function __castleClickHandler(param1:MouseEvent) : void
      {
         SceneManager.instance.setScene("CASTLE_SCENE");
      }
      
      private function __outercityClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("worldmap");
      }
      
      private function __pvpHelpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("worldboss.pvpHelperFrame");
         _loc2_.show();
      }
      
      private function __dayGuideBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc2_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.dayGuideBtn.underLevel");
            MessageTipManager.instance().show(_loc2_);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("newactiveleed");
         }
      }
      
      private function __funPreviewBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("funpreview");
      }
      
      private function __skipNewbieHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("mainBar.SmallMapBar.content");
         SimpleAlertHelper.instance.data = [skipNewbieCall];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
      }
      
      private function skipNewbieCall(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:URLVariables = null;
         var _loc4_:UserInfo = null;
         var _loc5_:String = null;
         if(param1)
         {
            _loc3_ = new URLVariables();
            _loc4_ = PlayerManager.instance.currentPlayerModel.userInfo;
            _loc3_["userid"] = _loc4_.userId;
            _loc3_["key"] = _loc4_.key;
            _loc3_["jump"] = true;
            _loc3_["ran"] = Math.random();
            _loc5_ = ComponentSetting.REQUEST_PATH + "selectjobregister";
            LoaderManagerII.instance.load(_loc5_,7,0,onSkipNewbieComplete,null,null,null,_loc3_);
         }
      }
      
      private function onSkipNewbieComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:Class = null;
         var _loc3_:XML = XML(param2);
         var _loc6_:int = int(_loc3_.@type);
         var _loc5_:Boolean = _loc3_.@value == "true";
         if(_loc6_ == 12 && _loc5_)
         {
            _loc4_ = DisplayLoader.Context.applicationDomain.getDefinition("NewbieModule") as Class;
            _loc4_["updateCurNode"](19000);
         }
      }
      
      private function __onResizeHandler(param1:Event) : void
      {
         x = StageReferance.gameStageWidth - 173 - 10;
         if(x < PathInfo.GAME_WIDTH - 173)
         {
            x = PathInfo.GAME_WIDTH - 173;
         }
         y = -2;
      }
      
      public function show() : void
      {
         var _loc2_:Boolean = FrameControllerManager.instance.outyardControler.isOutyardMapApply;
         if(_loc2_)
         {
            return;
         }
         var _loc3_:Boolean = FrameControllerManager.instance.gemMazeController.isEnterGemMaze;
         if(_loc3_)
         {
            return;
         }
         if(SceneManager.instance.currentType == "PVP_ROOM_SCENE" || SceneManager.instance.currentType == "PVE_ROOM_SCENE" || SceneManager.instance.currentType == "MULTILORDS_ROOM" || SceneManager.instance.currentType == "UNREAL_SHOOTING_ROOM" || SceneManager.instance.currentType == "CROSS_GUILD_SCENE" || SceneManager.instance.currentType == "SELF_CHESS_SCENE")
         {
            return;
         }
         if(mapModel && (WorldBossHelper.checkInHome(mapModel.mapId) || WorldBossHelper.checkInHouse(mapModel.mapId)))
         {
            return;
         }
         var _loc1_:Boolean = SceneManager.instance.isEnterFullScene;
         if(_loc1_)
         {
            return;
         }
         LayerManager.Instance.addToLayer(this,4,false,false,0,0);
         if(mapModel && WorldBossHelper.checkMonopoly(mapModel.mapId))
         {
            hidenGuild();
         }
         else
         {
            showBtnAndEff();
         }
         __onResizeHandler(null);
         if(!SharedManager.instance.hideOthers)
         {
            _othersShowBtn.visible = true;
            _othersHideBtn.visible = false;
         }
         else
         {
            _othersShowBtn.visible = false;
            _othersHideBtn.visible = true;
         }
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get curState() : int
      {
         return _curState;
      }
      
      public function set iconContainerX(param1:Number) : void
      {
         _BigMap_X = param1;
         coordinates();
      }
      
      public function set iconContainerY(param1:Number) : void
      {
         _BigMap_Y = param1;
         coordinates();
      }
      
      private function coordinates() : void
      {
         var _loc1_:int = (StageReferance.stageWidth / 2 - _BigMap_X * 16) / 50;
         var _loc2_:int = (StageReferance.stageHeight / 2 - _BigMap_Y * 16) / 50;
         _loc1_ = int(_loc1_ < 0 ? 0 : _loc1_);
         _loc2_ = int(_loc2_ < 0 ? 0 : _loc2_);
         _inputPosTextX.text = _loc1_ + "";
         _inputPosYText.text = _loc2_ + "";
         if(_inputPosTextX.text != "")
         {
            _inputPosCText.text = ",";
         }
      }
      
      public function mopupIng() : void
      {
         if(_castleBtn)
         {
            _castleBtn.enable = false;
         }
         if(_outercityBtn)
         {
            _outercityBtn.enable = false;
         }
         if(_spaceBtn)
         {
            _spaceBtn.enable = false;
         }
         if(_dayGuideBtn)
         {
            _dayGuideBtn.enable = false;
         }
      }
      
      public function mopupEnd() : void
      {
         if(_castleBtn)
         {
            _castleBtn.enable = true;
         }
         if(_outercityBtn)
         {
            _outercityBtn.enable = true;
         }
         if(_spaceBtn)
         {
            _spaceBtn.enable = true;
         }
         if(_dayGuideBtn)
         {
            _dayGuideBtn.enable = true;
         }
      }
      
      public function getButtonByType(param1:int) : BaseButton
      {
         switch(param1 - 1)
         {
            case 0:
               return _spaceBtn;
            case 1:
               return _castleBtn;
            case 2:
               return _outercityBtn;
            case 3:
               return _locateArmyBtn;
            case 4:
               return _returnCastleBtn;
            default:
               return null;
         }
      }
      
      private function __localArmyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_localArmyCallBack != null)
         {
            _localArmyCallBack();
         }
      }
      
      private function __returnCastleHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_returnCastleBack != null)
         {
            _returnCastleBack();
         }
      }
      
      private function __attackHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_preAttackHandler != null)
         {
            _preAttackHandler();
         }
         CursorManagerII.instance.showCursorByType("PVP_ATTACT_CURSOR");
         param1.stopPropagation();
      }
      
      private function __onTransmitHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_transmitCastleBack != null)
         {
            _transmitCastleBack();
         }
         param1.stopImmediatePropagation();
      }
      
      private function __localCastleHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_localCastleCallBack != null)
         {
            _localCastleCallBack();
         }
      }
      
      private function __moveMapHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_moveCallBack != null)
         {
            _moveCallBack(_inputPosTextX.text + "," + _inputPosYText.text);
         }
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(StageReferance.stage.focus != _inputPosTextX && StageReferance.stage.focus != _inputPosYText)
         {
            return;
         }
         if(param1.keyCode == 13)
         {
            __moveMapHandler(null);
         }
         param1.stopPropagation();
      }
      
      public function clickAttackButton() : void
      {
         if(_attackBtn == null)
         {
            return;
         }
         _attackBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      private function __faceBookBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(ExternalInterface.available)
         {
            _loc2_ = PlayerManager.instance.currentPlayerModel.userInfo.site;
            ExternalInterface.call("callFbLike",_loc2_);
         }
      }
      
      public function checkFaceBookBtn() : void
      {
         if(ConfigManager.info.FACE_BOOK && ArmyManager.instance.thane.grades >= 20)
         {
            if(_curState == 4 || _curState == 1)
            {
               addChild(_faceBookBtn);
               _faceBookBtn.visible = true;
            }
         }
      }
   }
}

