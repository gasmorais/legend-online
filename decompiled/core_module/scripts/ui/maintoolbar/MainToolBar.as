package ui.maintoolbar
{
   import bag.events.BagEvent;
   import bag.helper.BagHelper;
   import battle.BattleManager;
   import com.greensock.TweenMax;
   import com.pickgliss.instance.ComponentGroupManager;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.simple.PropertyMsg;
   import dialog.utils.NewbieMainToolBarLevelControl;
   import dialog.utils.NewbieManager;
   import events.DayGuideEvent;
   import events.FriendUpdateEvent;
   import events.PetEvent;
   import events.RewardEvent;
   import events.RingTaskEvent;
   import events.TaskEvent;
   import farm.FarmManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import im.view.IMMsgBoxView;
   import mainBar.TimeBoxView;
   import manager.LanguageMgr;
   import managers.BoxManager;
   import managers.ChallengeManager;
   import managers.ChildManager;
   import managers.ChildNswarManager;
   import managers.DarkMazeManager;
   import managers.DragonTitanManager;
   import managers.FashionManager;
   import managers.GameHallManager;
   import managers.GloryGameManager;
   import managers.GodDessManager;
   import managers.IMManager;
   import managers.MarryManager;
   import managers.MonopolyManager;
   import managers.MonopolySocketOutManager;
   import managers.MountsManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import managers.RoomManager;
   import managers.RoomSocketOutManager;
   import managers.SevenYearManager;
   import managers.SkyboxRoadManager;
   import managers.SocketSecurityCodeMessageManager;
   import managers.TaskTraceTipManager;
   import managers.TheseusPvpManager;
   import managers.WishPoolManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignEvent;
   import map.internals.data.template.MapTemplate;
   import map.space.SpaceManager;
   import marry.view.ProposeBoxView;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.friends.IMEvent;
   import mvc.module.groupchat.ConsortiaGroupChatModel;
   import mvc.module.marry.MarryProposeInfo;
   import mvc.module.room.RoomInfo;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.wishpool.WishPoolInfoVO;
   import sandbox.SandboxManager;
   import ui.maintoolbar.constant.MainToolCheckBtnOpen;
   import ui.maintoolbar.view.MainToolButton;
   import ui.maintoolbar.view.PlayerExperenceView;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.tasktracebar.view.NewbieTaskTraceView;
   import yishi.SwitchPageHelp;
   import yishi.actions.hero.HeroFightingUpdateAction;
   import yishi.actions.task.CompleteTaskAction;
   import yishi.comm.PackageIn;
   import yishi.datas.PathInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.playerinfo.TowerInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.MarryQualityData;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.lunch.Yishi;
   import yishi.manager.ApexManager;
   import yishi.manager.AresLordsManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.BaseManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.LandMineManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.SecretWarManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.component.MovieButton;
   import yishi.view.tips.MessageTipManager;
   
   public class MainToolBar extends Sprite implements IManualSize
   {
      
      public static const BTN_NUM:int = 14;
      
      public static const BAR_WIDTH:int = 600;
      
      public static const UNIT_WIDTH:int = 47;
      
      public static const BEGIN_INTERVAL:int = 50;
      
      public static var ISINIT:Boolean = false;
      
      private static var _instance:MainToolBar;
      
      public static const PVP_ROOM_START:int = 1;
      
      public static const PVP_ROOM_READY:int = 2;
      
      public static const PVE_ROOM_START:int = 3;
      
      public static const PVE_ROOM_READY:int = 4;
      
      public static const INVITEBTN:int = 1;
      
      public static const RECOMMENDBTN:int = 2;
      
      private var _bg:Bitmap;
      
      private var _exp:PlayerExperenceView;
      
      private var _payBtn:BaseButton;
      
      private var _shopBtn:MainToolButton;
      
      private var _bagBtn:MainToolButton;
      
      private var _petBtn:MainToolButton;
      
      private var _armyBtn:MainToolButton;
      
      private var _mountBtn:MainToolButton;
      
      private var _starBtn:MainToolButton;
      
      private var _skillBtn:MainToolButton;
      
      private var _storeBtn:MainToolButton;
      
      private var _archaeologyBtn:MainToolButton;
      
      private var _consortiaBtn:MainToolButton;
      
      private var _returnBtn:MainToolButton;
      
      private var _marryBtn:MainToolButton;
      
      private var _poptipBtn:MainToolButton;
      
      private var _friendsBtn:MainToolButton;
      
      private var _campaignBtn:MainToolButton;
      
      private var _outerCityBtn:MainToolButton;
      
      private var _castleBtn:MainToolButton;
      
      private var _InviteBtn:MovieImage;
      
      private var _recommendBtn:MovieImage;
      
      private var _applyJoinTeamBtn:MovieImage;
      
      private var _crossGoOnBtn:MovieButton;
      
      private var _crossCancelBtn:MovieButton;
      
      private var _crossContiner:Component;
      
      private var _dragonTalkerBtn:MainToolButton;
      
      private var _timeBG:Bitmap;
      
      private var _timeFont:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timeNumber:int;
      
      private var _timer:Timer;
      
      private var _moduleBtns:Array;
      
      private var _newGoodsInfo:GoodsInfo;
      
      private var isClick:Boolean = false;
      
      private var _btnContainer:Sprite;
      
      private var _wishGoodsArray:Array;
      
      private var _warningPosX:int = 0;
      
      private var _needTipsViewBtnData:Object = {};
      
      private var _preFighting:int = 0;
      
      private var _timeId:int;
      
      private var _goodsList:Array = [];
      
      private var _newGoodsCount:int;
      
      private var _isPopGoods:Boolean;
      
      private var _firstSwitch:Boolean = true;
      
      private var _securityCodeTimeId:int;
      
      private var _state:int;
      
      private var _addFriendListFlag:Boolean = false;
      
      private var _isHeroFrameOpened:Boolean;
      
      public function MainToolBar()
      {
         super();
         this.mouseEnabled = false;
         initView();
         addEvent();
         initEffect();
         initData();
         __thaneLevelUpdateHandler(null);
         __thaneInfoChangeHandler(null);
         NewbieMainToolBarLevelControl.instance;
         doMove();
         buttonsStageByScene(SceneManager.instance.currentType);
      }
      
      public static function get instance() : MainToolBar
      {
         if(!_instance)
         {
            _instance = new MainToolBar();
            ISINIT = true;
         }
         return _instance;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,600,315);
      }
      
      private function initEffect() : void
      {
         if(thane.skillCate.skillPoint > 0)
         {
            _skillBtn.buttonBtn.isPlaying = false;
         }
         __bagIsFullHandler(null);
         if(FashionManager.instance.fashionIdentityProgress == 0)
         {
            _bagBtn.buttonBtn.isPlaying = true;
            _bagBtn.buttonBtn.playEffect();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function initView() : void
      {
         _btnContainer = new Sprite();
         _bg = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.Back");
         _exp = ComponentFactory.Instance.creatCustomObject("mainToolBar.PlayerExpView");
         _poptipBtn = ComponentFactory.Instance.creatComponentByStylename("mainToolBtn.PopTipBtn");
         _marryBtn = ComponentFactory.Instance.creatComponentByStylename("mainToolBtn.marryBtn");
         _shopBtn = createBtnView("ShopBtn");
         _bagBtn = createBtnView("PackBtn");
         _petBtn = createBtnView("PetBtn");
         createBtnTipsView(_petBtn);
         _armyBtn = createBtnView("HeroBtn");
         _dragonTalkerBtn = createBtnView("DragonTalkerBtn");
         _mountBtn = createBtnView("mountBtn");
         _starBtn = createBtnView("StarBtn");
         createBtnTipsView(_starBtn);
         _skillBtn = createBtnView("SkillBtn");
         createBtnTipsView(_skillBtn);
         _storeBtn = createBtnView("storeBtn");
         _archaeologyBtn = createBtnView("archaeologyBtn");
         createBtnTipsView(_archaeologyBtn);
         _consortiaBtn = createBtnView("GuildBtn");
         createBtnTipsView(_consortiaBtn);
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("mainToolBtn.ReturnBtn");
         _friendsBtn = createBtnView("FriendsBtn");
         _campaignBtn = createBtnView("BattleBtn");
         _outerCityBtn = createBtnView("OuterCityBtn");
         _castleBtn = createBtnView("CastleBtn");
         _payBtn = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.PayBtn");
         _recommendBtn = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.recommendBtn");
         _InviteBtn = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.InviteBtnImg");
         _applyJoinTeamBtn = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.applyJoinTeam");
         _crossGoOnBtn = ComponentFactory.Instance.creatCustomObject("mainToolBar.crossGoOnBtn");
         _crossCancelBtn = ComponentFactory.Instance.creatCustomObject("mainToolBar.crossCancelBtn");
         _crossContiner = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.crossContiner");
         _timeBG = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.timeBG");
         _timeFont = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.timeFontBG");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.timeTxt");
         _crossContiner.addChild(_crossGoOnBtn);
         _crossGoOnBtn.visible = false;
         _crossContiner.addChild(_crossCancelBtn);
         _crossCancelBtn.visible = false;
         _crossContiner.addChild(_timeBG);
         _timeBG.visible = false;
         _crossContiner.addChild(_timeFont);
         _timeFont.visible = false;
         _crossContiner.addChild(_timeTxt);
         _timeTxt.visible = false;
         _timer = new Timer(1000);
         _timer.stop();
         _moduleBtns = [_returnBtn,_consortiaBtn,_archaeologyBtn,_storeBtn,_skillBtn,_starBtn,_mountBtn,_dragonTalkerBtn,_armyBtn,_petBtn,_bagBtn,_shopBtn];
         addChild(_bg);
         _poptipBtn.buttonBtn.tipData = LanguageMgr.GetTranslation("consortiagroupchat.msgBoxItemNameTxt");
         _marryBtn.buttonBtn.tipData = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.proposeTips");
         poptipButtonVisible = playerInfo.consortiaID > 0;
         addChild(_shopBtn);
         addChild(_bagBtn);
         addChild(_petBtn);
         addChild(_armyBtn);
         addChild(_dragonTalkerBtn);
         addChild(_mountBtn);
         addChild(_starBtn);
         addChild(_skillBtn);
         addChild(_storeBtn);
         addChild(_archaeologyBtn);
         addChild(_consortiaBtn);
         addChild(_returnBtn);
         _returnBtn.tipData = LanguageMgr.GetTranslation("mainBar.MainToolBar.returnBtnTipData");
         addChild(_campaignBtn);
         _campaignBtn.buttonBtn.tipData = LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "Z";
         addChild(_castleBtn);
         _castleBtn.buttonBtn.tipData = LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "Q";
         addChild(_outerCityBtn);
         _outerCityBtn.buttonBtn.tipData = LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "Q";
         addChild(_friendsBtn);
         _friendsBtn.buttonBtn.tipData = LanguageMgr.GetTranslation("friends.view.FriendsFrame.title");
         addChild(_payBtn);
         addChild(_friendsBtn);
         addChild(_recommendBtn);
         _recommendBtn.movie.play();
         _recommendBtn.buttonMode = true;
         addChild(_InviteBtn);
         _InviteBtn.movie.play();
         _InviteBtn.visible = false;
         _InviteBtn.buttonMode = true;
         addChild(_applyJoinTeamBtn);
         _applyJoinTeamBtn.movie.play();
         _applyJoinTeamBtn.visible = false;
         _applyJoinTeamBtn.buttonMode = true;
         addChild(_exp);
         this.mouseEnabled = false;
         this.scrollRect = null;
         this.cacheAsBitmap = true;
         _crossContiner.x = StageReferance.stageWidth / 2 - 30;
         _crossContiner.y = StageReferance.stageHeight - 200;
         LayerManager.Instance.addToLayer(_poptipBtn,4,false,false,0,2);
         setMarryBtnState();
         __updateCrossAlertHandler(null);
         updateBtnTipsData();
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.Warning");
         _loc1_.text = LanguageMgr.GetTranslation("mainTool.mainToolViewTips");
         _warningPosX = _loc1_.x;
      }
      
      public function get warningPosX() : int
      {
         return _warningPosX;
      }
      
      private function createBtnView(param1:String) : MainToolButton
      {
         var _loc2_:MainToolButton = ComponentFactory.Instance.creatComponentByStylename("mainToolBtn." + param1);
         _loc2_.buttonTips = MainToolCheckBtnOpen.getBtnKeyTips(param1);
         return _loc2_;
      }
      
      private function createBtnTipsView(param1:MainToolButton) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         switch(param1)
         {
            case _skillBtn:
               _loc3_ = 14;
               _loc4_ = 20;
               _loc2_ = -5;
               break;
            case _consortiaBtn:
               _loc3_ = 4;
               _loc4_ = 20;
               _loc2_ = -8;
               break;
            case _starBtn:
               _loc3_ = 13;
               _loc4_ = 17;
               _loc2_ = -10;
               break;
            case _archaeologyBtn:
               _loc3_ = 30;
               _loc4_ = 20;
               _loc2_ = -5;
         }
         var _loc5_:MovieClip = _needTipsViewBtnData[_loc3_];
         if(_loc5_ == null)
         {
            _loc5_ = getBtnTipView();
            _loc5_.x = _loc4_;
            _loc5_.y = _loc2_;
            param1.buttonBtn.movie.movie.addChild(_loc5_);
            _needTipsViewBtnData[_loc3_] = _loc5_;
         }
      }
      
      private function getBtnTipView() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         _loc1_.visible = false;
         return _loc1_;
      }
      
      private function updateBtnTipsData(param1:Event = null) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         for(var _loc2_:String in _needTipsViewBtnData)
         {
            _loc3_ = _needTipsViewBtnData[_loc2_];
            _loc3_.visible = false;
            _loc4_ = InfoTipsManager.instance.getValueByKey(int(_loc2_));
            if(_loc4_ > 0)
            {
               if(!(int(_loc2_) == 13 && thane.grades < 18))
               {
                  _loc3_.visible = true;
                  _loc3_.txt.text = _loc4_ > 99 ? "99+" : _loc4_.toString();
               }
            }
         }
      }
      
      private function _taskComplete(param1:Event) : void
      {
         TaskManage.instance.removeEventListener("TASK_COMPLETE_1802",_taskComplete);
         _starBtn.buttonBtn.isPlaying = true;
         _starBtn.buttonBtn.playEffect();
      }
      
      private function initData() : void
      {
         _exp.refreshView();
         if(BoxManager.instance.needCountTime && thane.grades >= 8)
         {
            TimeBoxView.instance.showView();
         }
      }
      
      private function addEvent() : void
      {
         StageReferance.addEventListener("resize",__onResize);
         StageReferance.stage.addEventListener("deactivate",__deactivateHandler);
         _armyBtn.addEventListener("click",__heroBtnClick);
         _petBtn.addEventListener("click",__petBtnClickHandler);
         _storeBtn.addEventListener("click",__storeBtnClick);
         _skillBtn.addEventListener("click",__skillClickHandler);
         _bagBtn.addEventListener("click",__bagBtnClick);
         _dragonTalkerBtn.addEventListener("click",__dragonTalkerClickHandler);
         _friendsBtn.addEventListener("click",__onFriendsClick);
         _friendsBtn.addEventListener("rollOver",__onFriendsOverHandler);
         _friendsBtn.addEventListener("rollOut",__onFriendsOutHandler);
         _marryBtn.addEventListener("click",__onMarryBtnClick);
         _marryBtn.addEventListener("rollOver",__onMarryBtnOverHandler);
         _marryBtn.addEventListener("rollOut",__onMarryBtnOutHandler);
         _consortiaBtn.addEventListener("click",__consortiaBtnClickHandler);
         _poptipBtn.addEventListener("click",__poptipBtnClickHandler);
         _campaignBtn.addEventListener("click",__gotoCampaignHandler);
         _outerCityBtn.addEventListener("click",__gotoOuterCityHandler);
         _castleBtn.addEventListener("click",__gotoCastleHandler);
         _archaeologyBtn.addEventListener("click",__archaeologyClickHandler);
         _payBtn.addEventListener("click",__payBtnClickHandler);
         _shopBtn.addEventListener("click",__shopBtnClickHandler);
         _returnBtn.addEventListener("click",__returnClickHandler);
         _recommendBtn.addEventListener("click",__recommendClick);
         _mountBtn.addEventListener("click",__mountClickHandler);
         _InviteBtn.addEventListener("click",__inviteClick);
         _applyJoinTeamBtn.addEventListener("click",__applyJoinTeamHandler);
         _crossGoOnBtn.addEventListener("click",__onCrossBtnClickHandler);
         _crossCancelBtn.addEventListener("click",__onCrossBtnClickHandler);
         _starBtn.addEventListener("click",__starClick);
         NotificationManager.instance.addEventListener("INVITE_UPDATE",__updateInvateView);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         NotificationManager.instance.addEventListener("REFRESH_JOINTEAMLIST",__updateApplyJoinTeam);
         NotificationManager.instance.addEventListener("TEAMCAPTAINCHANGE",function(param1:NotificationEvent):void
         {
            _applyJoinTeamBtn.visible = false;
         });
         NotificationManager.instance.addEventListener("POP_GOODS_MOVIE",__popGoodsHandler);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__consortiaChangeHandler);
         IMManager.instance.addEventListener("RECEIVE_MSG",__receiveIMMsgHandler);
         IMManager.instance.addEventListener("MSG_LIST_DEL",__imFrameUpdateHandler);
         IMManager.instance.addEventListener("IMFRAME_REMOVE",__imFrameUpdateHandler);
         thane.addEventListener("THANE_EXP_UPDATE",__heroExpUpdateHandler);
         thane.skillCate.addEventListener("THANE_SKILL_POINT",__hasSkillPointHandler);
         GoodsManager.instance.addEventListener("NEW_GOODS",__newGoodsHandler);
         GoodsManager.instance.addEventListener("BAG_FULL",__bagIsFullHandler);
         playerInfo.addEventListener("BAG_FULL",__bagIsFullHandler);
         playerInfo.addEventListener("RENTAL_BAG_TIME_REFRESH",__rentalBagStatusRefreshHandler);
         TaskManage.instance.addEventListener("task_detail_change",__taskComplateHandler);
         OfferRewardManager.instance.addEventListener("REWARD_TASK_UPDATE",__rewardTaskUpdateHandler);
         RingTaskManager.instance.addEventListener("REFRESHTING",__ringTaskRefreshHandler);
         thane.addEventListener("VOCATION_INDEX",__updateVocationIndexHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__thaneLevelUpdateHandler);
         playerInfo.addEventListener("PET_ADD",__newPetHandler);
         thane.addEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         NotificationManager.instance.addEventListener("SHOWCAMPAIGN",showCampaignHandler);
         FashionManager.instance.addEventListener("FASHION_BOOK_RECEIVE",__refreshBagBtnHandler);
         MsgMan.addObserver("MarryEventType.PROPOSELIST_UPDATE",this,__proposeHandler);
         if(!PlayerManager.instance.currentPlayerModel.isOpenAppellAddition)
         {
            PlayerManager.instance.currentPlayerModel.addEventListener("OPEN_ADDITION",__playBagEffect);
         }
         NotificationManager.instance.addEventListener("INFO_TIPS_DATA_UPDATE",updateBtnTipsData);
         NotificationManager.instance.addEventListener("CROSS_ADD_GOONBTN",__updateCrossAlertHandler);
         NotificationManager.instance.addEventListener("CAMPAIGN_OVER",__campaignOverHandler);
         playerInfo.addEventListener("VOCATION_GRADES",__updateVocationIndexHandler);
         TaskManage.instance.addEventListener("TASK_COMPLETE_1802",_taskComplete);
         NotificationManager.instance.addEventListener("WISH_POOL_SUCCESS",__wishPoolWishHandler);
         NotificationManager.instance.addEventListener("ROYALTYBOSS_LV_EVENT",updateTheseusHandler);
      }
      
      private function updateTheseusHandler(param1:NotificationEvent) : void
      {
         var e:NotificationEvent = param1;
         var timeId:int = int(setTimeout(function():void
         {
            clearTimeout(timeId);
            if(_archaeologyBtn)
            {
               _archaeologyBtn.childButtonTips = MainToolCheckBtnOpen.getKeyTips("ProficiencyBtn");
               _archaeologyBtn.isChildOpen = MainToolCheckBtnOpen.getBtnKeyIsOpen("ProficiencyBtn");
            }
         },1000));
      }
      
      private function __wishPoolWishHandler(param1:NotificationEvent) : void
      {
         _wishGoodsArray = param1.data;
         _timeId = setInterval(popWishGoods,500);
      }
      
      private function popWishGoods() : void
      {
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc2_:int = _wishGoodsArray.pop();
         var _loc1_:WishPoolInfoVO = WishPoolManager.instance.model.totalWishDic[_loc2_];
         if(_loc1_)
         {
            _loc3_ = _loc1_.tempalteId;
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc3_;
            BagHelper.instance.playNewGoodsEffect(_loc4_);
         }
         if(_wishGoodsArray.length == 0)
         {
            clearInterval(_timeId);
         }
      }
      
      protected function __updateVocationIndexHandler(param1:PlayerEvent) : void
      {
         __thaneLevelUpdateHandler(param1);
      }
      
      private function __rentalBagStatusRefreshHandler(param1:PlayerEvent) : void
      {
         __bagIsFullHandler(null);
      }
      
      private function __playBagEffect(param1:Event) : void
      {
         _bagBtn.buttonBtn.isPlaying = true;
         _bagBtn.buttonBtn.playEffect();
      }
      
      private function __proposeHandler(param1:String, param2:Object) : void
      {
         if(param1 != "MarryEventType.PROPOSELIST_UPDATE")
         {
            return;
         }
         setMarryBtnState();
         setProposeBtnShine();
      }
      
      private function setMarryBtnState() : void
      {
         if(MarryManager.instance.model.proposeNum <= 0)
         {
            if(_marryBtn.parent)
            {
               _marryBtn.parent.removeChild(_marryBtn);
            }
         }
         else
         {
            if(!_marryBtn.parent)
            {
               LayerManager.Instance.addToLayer(_marryBtn,4,false,false,0,2);
            }
            _marryBtn.buttonBtn.movie.movie["content"]["numtxt"].text = MarryManager.instance.model.proposeNum + "";
         }
      }
      
      public function setProposeBtnShine() : void
      {
         if(_marryBtn)
         {
            if(MarryManager.instance.model.needShine && MarryManager.instance.model.proposeNum > 0)
            {
               _marryBtn.buttonBtn.isPlaying = true;
               _marryBtn.buttonBtn.playEffect();
            }
            else
            {
               _marryBtn.buttonBtn.isPlaying = false;
               _marryBtn.buttonBtn.stopEffect();
            }
         }
      }
      
      private function __onMarryBtnOutHandler(param1:MouseEvent) : void
      {
         MarryManager.instance.removeBoxTimeOut = setTimeout(removeProposeBox,300);
      }
      
      private function removeProposeBox() : void
      {
         clearTimeout(MarryManager.instance.removeBoxTimeOut);
         MarryManager.instance.removeProposeBox();
      }
      
      private function __onMarryBtnOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ProposeBoxView = MarryManager.instance.createIMMsgBox();
         if(_loc2_)
         {
            ShowTipManager.Instance.removeCurrentTip();
            _loc2_.x = _marryBtn.x - 40;
            _loc2_.y = _marryBtn.y - 75;
            LayerManager.Instance.addToLayer(_loc2_,4,false,false,0,2);
         }
      }
      
      private function __onMarryBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Dictionary = MarryManager.instance.model.proposeDic;
         for each(var _loc2_:MarryProposeInfo in _loc3_)
         {
            MarryManager.instance.creatProposeAnswerFrame(_loc2_);
         }
      }
      
      private function __campaignOverHandler(param1:CampaignEvent) : void
      {
         __updateCrossAlertHandler(null);
      }
      
      private function __updateCrossAlertHandler(param1:NotificationEvent) : void
      {
         var _loc3_:MapTemplate = null;
         var _loc2_:CampaignTemplate = null;
         if(roomInfo && roomInfo.isCross && roomInfo.playerCount < 4 && roomInfo.houseOwnerId == thane.userId)
         {
            _loc3_ = TempleteManager.instance.mapTemplateCate.getTemplateByID(CampaignManager.instance.mapId);
            if(_loc3_)
            {
               _loc2_ = TempleteManager.instance.campaignTemplateDic[_loc3_.CampaignId];
            }
            if(_loc2_ && _loc2_.Capacity == 4 && _loc2_.DungeonId == 1 && _loc2_.Types == 0)
            {
               if(_crossContiner && _crossContiner.parent == null)
               {
                  LayerManager.Instance.addToLayer(_crossContiner,4,false,false,0,2);
                  SocketManager.instance.addEventListener("SLGSocketEvent" + 4995,__updateCrossBtnHanlder);
                  setCrossBtnState(1);
               }
            }
            else if(_crossContiner && _crossContiner.parent)
            {
               _crossContiner.parent.removeChild(_crossContiner);
               SocketManager.instance.removeEventListener("SLGSocketEvent" + 4995,__updateCrossBtnHanlder);
            }
         }
         else if(_crossContiner && _crossContiner.parent)
         {
            _crossContiner.parent.removeChild(_crossContiner);
            SocketManager.instance.removeEventListener("SLGSocketEvent" + 4995,__updateCrossBtnHanlder);
         }
      }
      
      private function __updateCrossBtnHanlder(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         setCrossBtnState(_loc2_.param1);
      }
      
      private function __onCrossBtnClickHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget.stylename == "mainToolBar.crossGoOnBtn")
         {
            RoomSocketOutManager.sendCrossGoOn(1,playerInfo.userId,playerInfo.serviceName);
         }
         else if(param1.currentTarget.stylename == "mainToolBar.crossCancelBtn")
         {
            RoomSocketOutManager.sendCrossGoOn(0,playerInfo.userId,playerInfo.serviceName);
         }
      }
      
      private function setCrossBtnState(param1:int) : void
      {
         if(param1 == 0)
         {
            _crossGoOnBtn.visible = true;
            _crossGoOnBtn.enable = false;
            _crossCancelBtn.visible = false;
            _timeBG.visible = false;
            _timeFont.visible = false;
            _timeTxt.visible = false;
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
         else if(param1 == 1)
         {
            _crossGoOnBtn.visible = true;
            _crossGoOnBtn.enable = true;
            _crossCancelBtn.visible = false;
            _timeBG.visible = false;
            _timeFont.visible = false;
            _timeTxt.visible = false;
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
         else if(param1 == 2)
         {
            _crossCancelBtn.visible = true;
            _crossGoOnBtn.visible = false;
            _timeBG.visible = true;
            _timeFont.visible = true;
            _timeTxt.visible = true;
            _timeTxt.text = "00:00";
            _timeNumber = 0;
            _timer.reset();
            _timer.start();
            _timer.addEventListener("timer",__timerHandler);
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         _timeNumber = _timeNumber + 1;
         _loc2_ = String(int(_timeNumber / 60) > 9 ? int(_timeNumber / 60) : "0" + int(_timeNumber / 60));
         _loc2_ += ":" + (String(int(_timeNumber % 60) > 9 ? int(_timeNumber % 60) : "0" + int(_timeNumber % 60)));
         _timeTxt.text = _loc2_;
      }
      
      private function __refreshBagBtnHandler(param1:Event) : void
      {
         FashionManager.instance.removeEventListener("FASHION_BOOK_RECEIVE",__refreshBagBtnHandler);
         if(FashionManager.instance.fashionIdentityProgress > 100)
         {
            __bagIsFullHandler(null);
         }
      }
      
      private function showCampaignHandler(param1:NotificationEvent) : void
      {
         if(getChildIndex(_campaignBtn) >= 0)
         {
            if(_campaignBtn.visible && _campaignBtn.enable)
            {
               _campaignBtn.dispatchEvent(new MouseEvent("click"));
            }
         }
      }
      
      private function __thaneInfoChangeHandler(param1:PlayerEvent) : void
      {
         var _loc2_:SimplePlayerInfo = null;
         if(param1 == null)
         {
            _loc2_ = thane;
         }
         else
         {
            _loc2_ = param1.currentTarget as SimplePlayerInfo;
         }
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.fightingCapacity > _preFighting && _preFighting > 0 && !__checkFrameExist() && NewbieManager.instance.isMaxNovice)
         {
            DelayActionsUtils.instance.addAction(new HeroFightingUpdateAction(_preFighting,_loc2_));
         }
         _preFighting = _loc2_.fightingCapacity;
      }
      
      private function __checkFrameExist() : Boolean
      {
         if(FrameControllerManager.checkFrame("armyController","ArmyFrameII"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("armyController","SkillFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("armyController","AllocateFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("armyController","PawnLevelUpFrame"))
         {
            return true;
         }
         if(ComponentGroupManager.Instance.hasInstanceClass("armyII.PawnAbilityConvertFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("starController","HoroscopeFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("buildingController","SeminaryFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("storeController","StoreFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("mountsController","MountsFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("consortiaController","ConsortiaStudySkillFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("seminaryBlessControler","SeminaryBlessFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("magicCardControler","CardFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("offerRewardController","OfferRewardFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("petHallowsControler","PetHallowsFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("petHallowsControler","PetContracUpgradeFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("childNursingSpiritControler","ChildNursingSpiritFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("dragonTalkerControler","DragonTalkerFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("avengerControl","AvengerFrame"))
         {
            return true;
         }
         if(FrameControllerManager.checkFrame("proficiencyControler","ProficiencyFrame"))
         {
            return true;
         }
         return false;
      }
      
      private function __updateInvateView(param1:FriendUpdateEvent) : void
      {
         if(SceneManager.instance.currentType != "BATTLE_SCENE" && (SceneManager.instance.currentType != "PVE_ROOM_SCENE" && SceneManager.instance.currentType != "PVP_ROOM_SCENE") && FriendManager.getInstance().toolInviteFriendList.length > 0 && !MarryManager.instance.model.lockScreen && !isInFullscreenFrame)
         {
            _InviteBtn.visible = true;
         }
         else
         {
            _InviteBtn.visible = false;
         }
      }
      
      private function __updateApplyJoinTeam(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType != "BATTLE_SCENE" && (SceneManager.instance.currentType != "PVE_ROOM_SCENE" && SceneManager.instance.currentType != "PVP_ROOM_SCENE") && !MarryManager.instance.model.lockScreen && !isInFullscreenFrame && FriendManager.getInstance().applyJoinList.length > 0)
         {
            _applyJoinTeamBtn.visible = true;
            updateFriendNoticeBtnPos(TaskTraceBar.instance.taskTraceView is NewbieTaskTraceView,false);
         }
         else
         {
            _applyJoinTeamBtn.visible = false;
         }
      }
      
      private function __inviteClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.friendControler.startFrameByType(3,false);
      }
      
      private function __applyJoinTeamHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.friendControler.startFrameByType(7,false);
      }
      
      private function __taskComplateHandler(param1:TaskEvent) : void
      {
         if(PlayerManager.instance.newbieProcess <= 19000)
         {
            return;
         }
         var _loc2_:Boolean = param1.data.hasCompleted;
         if(_loc2_)
         {
            DelayActionsUtils.instance.addAction(new CompleteTaskAction(param1.data));
         }
      }
      
      private function __rewardTaskUpdateHandler(param1:RewardEvent) : void
      {
         if(param1.data.isCompleted && !param1.data.hasCompleted)
         {
            DelayActionsUtils.instance.addAction(new CompleteTaskAction(param1.data));
            param1.data.hasCompleted = true;
         }
      }
      
      private function __ringTaskRefreshHandler(param1:RingTaskEvent) : void
      {
         if(param1.data.isCompleted && !param1.data.hasCompleted)
         {
            DelayActionsUtils.instance.addAction(new CompleteTaskAction(param1.data));
            param1.data.hasCompleted = true;
         }
      }
      
      private function __thaneLevelUpdateHandler(param1:PlayerEvent) : void
      {
         var timeId:int;
         var evt:PlayerEvent = param1;
         var grades:int = ArmyManager.instance.thane.grades;
         var preGrades:int = ArmyManager.instance.thane.preGrade;
         if(grades == 12 && BaseManager.instance.isRigister)
         {
            Yishi.openCache();
         }
         if(BoxManager.instance.needCountTime && grades == 8)
         {
            TimeBoxView.instance.show();
         }
         if(grades >= 27 && preGrades < 27 && preGrades > 0)
         {
            _bagBtn.buttonBtn.isPlaying = true;
            _bagBtn.buttonBtn.playEffect();
         }
         if(MountsManager.instance.avatarList.firstBless)
         {
            _mountBtn.buttonBtn.playEffect();
         }
         timeId = int(setTimeout(function():void
         {
            clearTimeout(timeId);
            _shopBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("ShopBtn");
            _bagBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("PackBtn");
            _bagBtn.childButtonTips = MainToolCheckBtnOpen.getKeyTips("artifactBtn");
            _petBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("PetBtn");
            _petBtn.childButtonTips = MainToolCheckBtnOpen.getKeyTips("petHallowsBtn");
            _armyBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("HeroBtn");
            _armyBtn.childButtonTips = MainToolCheckBtnOpen.getKeyTips("nursingSpiritBtn");
            _dragonTalkerBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("DragonTalkerBtn");
            _dragonTalkerBtn.childButtonTips = MainToolCheckBtnOpen.getKeyTips("titanBtn");
            _mountBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("mountBtn");
            _mountBtn.childButtonTips = MainToolCheckBtnOpen.getKeyTips("MonsterBtn");
            _starBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("StarBtn");
            _starBtn.childButtonTips = MainToolCheckBtnOpen.getKeyTips("AvengerBtn");
            _skillBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("SkillBtn");
            _skillBtn.childButtonTips = MainToolCheckBtnOpen.getKeyTips("GoddessBtn");
            _storeBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("storeBtn");
            _archaeologyBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("archaeologyBtn");
            _friendsBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("FriendsBtn");
            _consortiaBtn.buttonTips = MainToolCheckBtnOpen.getKeyTips("GuildBtn");
            _archaeologyBtn.childButtonTips = MainToolCheckBtnOpen.getKeyTips("ProficiencyBtn");
            _bagBtn.isChildOpen = VersionSwitch.ANCIENTARTIFACT && thane.vocationGrades > 0;
            _bagBtn.childEnable = VersionSwitch.ANCIENTARTIFACT && thane.vocationGrades > 0;
            _dragonTalkerBtn.enable = thane.vocationGrades > 0;
            _dragonTalkerBtn.isChildOpen = thane.vocationGrades > 0;
            _dragonTalkerBtn.childEnable = thane.isChangeJob;
            _petBtn.isChildOpen = thane.vocationGrades > 0;
            _petBtn.childEnable = thane.isChangeJob;
            _armyBtn.isChildOpen = thane.vocationGrades > 0;
            _armyBtn.childEnable = thane.isChangeJob;
            _storeBtn.isChildOpen = false;
            _storeBtn.childEnable = thane.isChangeJob;
            _skillBtn.isChildOpen = GodDessManager.instance.isOpen;
            _mountBtn.isChildOpen = MainToolCheckBtnOpen.getBtnKeyIsOpen("MonsterBtn");
            _starBtn.isChildOpen = MainToolCheckBtnOpen.getBtnKeyIsOpen("AvengerBtn");
            _archaeologyBtn.isChildOpen = MainToolCheckBtnOpen.getBtnKeyIsOpen("ProficiencyBtn");
            _archaeologyBtn.enable = MainToolCheckBtnOpen.getBtnKeyIsOpen("archaeologyBtn");
         },1000));
         recommendBtnIsExist();
      }
      
      private function __newPetHandler(param1:PetEvent) : void
      {
         petButtonShine = true;
      }
      
      public function recommendBtnIsExist(param1:Object = null) : Boolean
      {
         if(!_recommendBtn)
         {
            return false;
         }
         if(isClick)
         {
            return false;
         }
         if(FriendManager.getInstance().countFriend < FriendManager.getInstance().maxFriendCount && thane.grades >= 12 && FriendManager.getInstance().recommendList.length > 0)
         {
            _recommendBtn.movie.play();
            _recommendBtn.buttonMode = true;
            _recommendBtn.visible = true;
            return true;
         }
         _recommendBtn.movie.stop();
         _recommendBtn.buttonMode = false;
         _recommendBtn.visible = false;
         return false;
      }
      
      private function __consortiaChangeHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID > 0)
         {
            poptipButtonVisible = true;
            return;
         }
         if(FrameControllerManager.instance.consortiaGroupChatControler.frame)
         {
            FrameControllerManager.instance.consortiaGroupChatControler.frame["exitFrame"]();
         }
         else
         {
            poptipButtonVisible = false;
            FrameControllerManager.instance.consortiaGroupChatControler.consortiaBtnShining = true;
            FrameControllerManager.instance.consortiaGroupChatControler.model.unreadGroupChat = false;
            FrameControllerManager.instance.consortiaGroupChatControler.model.disposeCurConsortiaChats();
            FrameControllerManager.instance.consortiaGroupChatControler.model.disposeAllConsortiaChats();
         }
      }
      
      private function __receiveIMMsgHandler(param1:IMEvent) : void
      {
         __imFrameUpdateHandler(null);
         IMManager.instance.friendBtnShining = true;
      }
      
      private function __popGoodsHandler(param1:DayGuideEvent) : void
      {
         _isPopGoods = true;
      }
      
      private function __newGoodsHandler(param1:BagEvent) : void
      {
         if(PlayerManager.instance.newbieProcess < 19000 || FrameControllerManager.instance.vipController.model.curOpenVipBox || FrameControllerManager.instance.lotteryController.frame || FrameControllerManager.instance.newYearActController.curOpenLotteryFrame || FrameControllerManager.instance.monopolyController.curOpenFinishRewardFrame || SceneManager.instance.currentType == "PLANES_WAR_SCENE" || FrameControllerManager.instance.sacrificeController.isInSacrificeFrame || FrameControllerManager.instance.blackjackControler.openBlackFrame || FrameControllerManager.instance.luckyExchangeControler.openLuckyFrame || FrameControllerManager.instance.artifactControler.artifactOpen || FrameControllerManager.instance.exchangeBoxControler.isOpenFrame || SevenYearManager.instance.model.curOpenBoxFrame)
         {
            return;
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         if(_isPopGoods)
         {
            _isPopGoods = false;
            NotificationManager.instance.dispatchEvent(new DayGuideEvent("POP_GOODS",param1.list.pop()));
            return;
         }
      }
      
      private function popGoods() : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            clearInterval(_timeId);
            _goodsList = [];
            return;
         }
         _newGoodsInfo = _goodsList.pop();
         _newGoodsCount += 1;
         if(_newGoodsInfo && _newGoodsInfo.bagType != 22)
         {
            BagHelper.instance.playNewGoodsEffect(_newGoodsInfo);
         }
         if(_goodsList.length == 0)
         {
            clearInterval(_timeId);
            _goodsList = [];
            _newGoodsCount = 0;
         }
         if(_newGoodsCount >= 3)
         {
            clearInterval(_timeId);
            _goodsList = [];
            _newGoodsCount = 0;
         }
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         buttonsStageByScene(SceneManager.instance.currentType);
      }
      
      private function get isInFullscreenFrame() : Boolean
      {
         if(FrameControllerManager.instance.outyardControler.isOutyardMapApply || FrameControllerManager.instance.gemMazeController.isEnterGemMaze || FrameControllerManager.instance.svsController.isInSvsFrame || FrameControllerManager.instance.steelController.isInSteelFrame || FrameControllerManager.instance.sacrificeController.isInSacrificeFrame || FrameControllerManager.instance.skyBoxRoadControler.isInSkyBoxRoadFrame || FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            return true;
         }
         return false;
      }
      
      public function buttonsStageByScene(param1:String) : void
      {
         var _loc2_:Array = null;
         if(isInFullscreenFrame)
         {
            _campaignBtn.visible = false;
            _returnBtn.enable = true;
            if(_recommendBtn && _recommendBtn.parent)
            {
               _recommendBtn.parent.removeChild(_recommendBtn);
            }
         }
         else
         {
            switch(param1)
            {
               case "CAMPAIGN_MAP_SCENE":
               case "PVE_ROOM_SCENE":
               case "PVP_ROOM_SCENE":
               case "THESE_Double_PVP_SCENE":
               case "FARM":
               case "MULTILORDS_ROOM":
               case "CHANLLENGE_ROOM_SCENE":
               case "MATELORDS_ROOM":
               case "ARESLORDS_ROOM":
               case "UNREAL_SHOOTING_ROOM":
               case "SANDBOX_SCENE":
               case "PLANE_CRISRIS":
               case "GAME_HALL_SCENE":
               case "APEX_ROOM":
               case "CROSS_GUILD_SCENE":
               case "STARAREA_SCENE":
               case "GLORY_GAME_SCENE":
               case "SECRET_ADVENTURE_SCENE":
               case "SECRET_WAR_SCENE":
                  _campaignBtn.visible = false;
                  _outerCityBtn.visible = false;
                  _castleBtn.visible = false;
                  break;
               case "CASTLE_SCENE":
                  _campaignBtn.visible = PlayerManager.instance.newbieProcess >= 23000;
                  _outerCityBtn.visible = ArmyManager.instance.thane.grades > 12;
                  _castleBtn.visible = false;
                  break;
               case "OUTER_CITY_SCENE":
                  _campaignBtn.visible = PlayerManager.instance.newbieProcess >= 23000;
                  _outerCityBtn.visible = false;
                  _castleBtn.visible = true;
                  break;
               case "SPACE_SCENE":
                  _campaignBtn.visible = PlayerManager.instance.newbieProcess >= 23000;
                  _outerCityBtn.visible = true;
                  _castleBtn.visible = false;
                  break;
               default:
                  _campaignBtn.visible = false;
                  _outerCityBtn.visible = false;
                  _castleBtn.visible = false;
            }
            if(param1 == "CASTLE_SCENE" || param1 == "SPACE_SCENE" || param1 == "OUTER_CITY_SCENE" || PlayerManager.instance.newbieProcess < 19200)
            {
               _returnBtn.enable = false;
               addChild(_recommendBtn);
            }
            else
            {
               _returnBtn.enable = true;
               if(_recommendBtn && _recommendBtn.parent)
               {
                  _recommendBtn.parent.removeChild(_recommendBtn);
               }
            }
            if(WorldBossHelper.checkMonopoly(CampaignManager.instance.mapId))
            {
               _marryBtn.visible = false;
            }
            else
            {
               _marryBtn.visible = true;
            }
            if(!_firstSwitch || _firstSwitch && param1 == "BATTLE_SCENE" || MarryManager.instance.model.lockScreen)
            {
               closeRecommendBtn();
            }
            _loc2_ = FriendManager.getInstance().toolInviteFriendList;
            if(param1 != "BATTLE_SCENE" && param1 != "PVE_ROOM_SCENE" && param1 != "PVP_ROOM_SCENE" && _loc2_ && _loc2_.length > 0 && !MarryManager.instance.model.lockScreen)
            {
               _InviteBtn.visible = true;
            }
            else
            {
               _InviteBtn.visible = false;
            }
            if(_firstSwitch)
            {
               _securityCodeTimeId = setInterval(sendSecurityCode,3000);
            }
            _firstSwitch = false;
         }
      }
      
      private function sendSecurityCode() : void
      {
         clearInterval(_securityCodeTimeId);
         _securityCodeTimeId = 0;
         SocketSecurityCodeMessageManager.sendCheckShowSecurityCode();
      }
      
      public function updateFriendNoticeBtnPos(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            _recommendBtn.x = _InviteBtn.x = _applyJoinTeamBtn.x = 524;
            _recommendBtn.y = 136;
            _InviteBtn.y = 80;
            if(_recommendBtn && _recommendBtn.parent && _recommendBtn.visible)
            {
               _applyJoinTeamBtn.y = 212;
            }
            else
            {
               _applyJoinTeamBtn.y = 136;
            }
         }
         else
         {
            if(param2)
            {
               _recommendBtn.x = _InviteBtn.x = _applyJoinTeamBtn.x = 309;
            }
            else
            {
               _recommendBtn.x = _InviteBtn.x = _applyJoinTeamBtn.x = 279;
            }
            _recommendBtn.y = 3;
            _InviteBtn.y = -46;
            if(_recommendBtn && _recommendBtn.parent && _recommendBtn.visible)
            {
               _applyJoinTeamBtn.y = 59;
            }
            else
            {
               _applyJoinTeamBtn.y = 3;
            }
         }
      }
      
      public function closeRecommendBtn() : void
      {
         if(_recommendBtn)
         {
            _recommendBtn.visible = false;
            _recommendBtn.movie.gotoAndStop(10);
            updateFriendNoticeBtnPos(TaskTraceBar.instance.taskTraceView is NewbieTaskTraceView,false);
         }
      }
      
      private function __gotoCampaignHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("035",true);
         FrameControllerManager.instance.openControllerByInfo("selectcampaign");
      }
      
      private function __heroRoadClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("heroroad");
      }
      
      private function __gotoOuterCityHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("mainBar.MainToolBar.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SoundManager.instance.play("035",true);
         SceneManager.instance.setScene("OUTER_CITY_SCENE");
      }
      
      private function __gotoCastleHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("035",true);
         SceneManager.instance.setScene("CASTLE_SCENE");
      }
      
      private function __payBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __onMouseup(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onMouseup);
         _recommendBtn.x -= 1;
         _recommendBtn.y -= 1;
      }
      
      public function get recommendBtn() : MovieImage
      {
         return _recommendBtn;
      }
      
      private function __recommendClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         isClick = true;
         closeRecommendBtn();
         FrameControllerManager.instance.friendControler.startFrameByType(2,true);
      }
      
      private function __mountClickHandler(param1:MouseEvent) : void
      {
         if(thane.grades < 16)
         {
            return;
         }
         var _loc2_:DisplayObject = param1.target.parent.parent.parent;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_ == _mountBtn.buttonBtn)
         {
            mountButtonShine = false;
            FrameControllerManager.instance.openControllerByInfo("mounts",1);
            TaskTraceTipManager.instance.cleanByType(28);
         }
         else if(_loc2_ == _mountBtn.buttonChildBtn)
         {
            FrameControllerManager.instance.openControllerByInfo("monster");
         }
      }
      
      public function getBtnPos(param1:String) : Point
      {
         var _loc2_:Point = null;
         if(param1 == "mounts.MountsFrame")
         {
            _loc2_ = this._mountBtn.localToGlobal(new Point(_mountBtn.x,_mountBtn.y));
         }
         else if(param1 == "view.ShopFrame")
         {
            _loc2_ = this._shopBtn.localToGlobal(new Point(_shopBtn.x,_shopBtn.y));
         }
         else if(param1 == "army.ArmyFrameII")
         {
            _loc2_ = this._bagBtn.localToGlobal(new Point(_bagBtn.x,_bagBtn.y));
         }
         else if(param1 == "pet.PetFrame")
         {
            _loc2_ = this._petBtn.localToGlobal(new Point(_petBtn.x,_petBtn.y));
         }
         else if(param1 == "store.StoreFrame")
         {
            _loc2_ = this._storeBtn.localToGlobal(new Point(_storeBtn.x,_storeBtn.y));
         }
         else if(param1 == "army.SkillFrame")
         {
            _loc2_ = this._skillBtn.localToGlobal(new Point(_skillBtn.x,_storeBtn.y));
         }
         else if(param1 == "star.StarFrame")
         {
            _loc2_ = this._starBtn.localToGlobal(new Point(_starBtn.x,_starBtn.y));
         }
         else if(param1 == "army.PawnFrame")
         {
            _loc2_ = this._armyBtn.localToGlobal(new Point(_armyBtn.x,_armyBtn.y));
         }
         else if(param1 == "DragonTalker.DragonTalkerFrame")
         {
            _loc2_ = this._dragonTalkerBtn.localToGlobal(new Point(_dragonTalkerBtn.x,_dragonTalkerBtn.y));
         }
         else if(param1 == "consortia.ConsortiaFrame" || param1 == "consortia.ConsortiaSearchFrame")
         {
            _loc2_ = this._consortiaBtn.localToGlobal(new Point(_consortiaBtn.x,_consortiaBtn.y));
         }
         else if(param1 == "selectCP.SelectCampaignFrame")
         {
            _loc2_ = this._campaignBtn.localToGlobal(new Point(_campaignBtn.x,_campaignBtn.y));
         }
         return _loc2_;
      }
      
      public function getBagBtnPos() : Point
      {
         return localToGlobal(new Point(_bagBtn.x,_bagBtn.y));
      }
      
      public function clickMountBtn() : void
      {
         __mountClickHandler(null);
      }
      
      private function __petBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         var _loc2_:DisplayObject = param1.target.parent.parent.parent;
         if(!_loc2_)
         {
            return;
         }
         if(thane.grades < 50)
         {
            return;
         }
         if(_loc2_ == _petBtn.buttonBtn)
         {
            petButtonShine = false;
            FrameControllerManager.instance.openControllerByInfo("pet");
         }
         else if(_loc2_ == _petBtn.buttonChildBtn && _petBtn.buttonChildBtn.enable)
         {
            FrameControllerManager.instance.openControllerByInfo("pethallows",1);
         }
      }
      
      private function __starClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         var _loc2_:DisplayObject = param1.target.parent.parent.parent;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_ == _starBtn.buttonBtn)
         {
            _starBtn.buttonBtn.isPlaying = false;
            _starBtn.buttonBtn.stopEffect();
            FrameControllerManager.instance.openControllerByInfo("star");
         }
         else if(_loc2_ == _starBtn.buttonChildBtn)
         {
            FrameControllerManager.instance.openControllerByInfo("avenger");
         }
      }
      
      private function __shopBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("shop");
      }
      
      private function __returnClickHandler(param1:MouseEvent) : void
      {
         var _loc14_:* = null;
         var _loc10_:String = null;
         SoundManager.instance.play("019",true);
         var _loc6_:Boolean = FrameControllerManager.instance.outyardControler.isOutyardMapApply;
         var _loc9_:Boolean = FrameControllerManager.instance.gemMazeController.isEnterGemMaze;
         var _loc13_:Boolean = FrameControllerManager.instance.svsController.isInSvsFrame;
         var _loc7_:Boolean = FrameControllerManager.instance.steelController.isInSteelFrame;
         var _loc5_:Boolean = FrameControllerManager.instance.sacrificeController.isInSacrificeFrame;
         var _loc15_:Boolean = FrameControllerManager.instance.skyBoxRoadControler.isInSkyBoxRoadFrame;
         var _loc4_:Boolean = FrameControllerManager.instance.unrealShootingController.isInUnrealShootingFrame;
         var _loc8_:Boolean = FrameControllerManager.instance.godsEveningController.isInGodsEveningFrame;
         var _loc11_:Boolean = FrameControllerManager.instance.landMineController.isInLandMineFrame;
         var _loc3_:Boolean = FrameControllerManager.instance.spiritExpeditionControl.isInSpiritExpeditionFrame;
         var _loc12_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc16_:String = LanguageMgr.GetTranslation("mainBar.MainToolBar.prompt");
         if(_loc9_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent(NotificationEvent.CLOSE_GEMMAZEFRAME));
         }
         else if(_loc6_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLOSE_OUTYARD_FRAME"));
         }
         else if(_loc13_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLOSE_SVS_FRAME"));
         }
         else if(_loc7_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLOSE_STEEL_FRAME"));
         }
         else if(_loc5_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLOSE_SACRIFICE_FRAME"));
         }
         else if(_loc4_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLOSE_UNREAL_SHOOTING_FRAME"));
         }
         else if(_loc8_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLOSE_GODSEVENING_FRAME"));
         }
         else if(_loc11_)
         {
            _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitLandMine");
            SimpleAlertHelper.instance.data = [exitLandMine];
            SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
         }
         else if(_loc3_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLOSE_SPIRITEXPEDITION_FRAME"));
         }
         else
         {
            switch(SceneManager.instance.currentType)
            {
               case "FARM":
                  if(SwitchPageHelp.returnScene == "SPACE_SCENE" && FarmManager.instance.model.needReturnSpace)
                  {
                     SwitchPageHelp.enterToSpace();
                  }
                  else
                  {
                     SwitchPageHelp.returnToSpace();
                  }
                  return;
               case "PLANES_WAR_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitPlanesWar.alert");
                  SimpleAlertHelper.instance.data = [exitPlanesWarResult];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  return;
               case "MULTILORDS_ROOM":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitMultilordsRoom");
                  SimpleAlertHelper.instance.data = [exitMultilordsRoom];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  return;
               case "MATELORDS_ROOM":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitMatelordsRoom");
                  SimpleAlertHelper.instance.data = [exitMatelordsRoom];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  return;
               case "ARESLORDS_ROOM":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitAresLordsRoom");
                  SimpleAlertHelper.instance.data = [exitAreslordsRoom];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  return;
               case "CHANLLENGE_ROOM_SCENE":
                  if(ChallengeManager.instance.enterScene == "CASTLE_SCENE")
                  {
                     SceneManager.instance.setScene("CASTLE_SCENE");
                  }
                  else
                  {
                     SwitchPageHelp.enterToSpace();
                  }
                  ChallengeManager.instance.enterScene = "";
                  break;
               case "SKYBOX_ROAD_SCENE":
                  SkyboxRoadManager.instance.isFirst = true;
                  SkyboxRoadManager.instance.exitPortal();
                  SwitchPageHelp.enterToSpace();
                  break;
               case "FINAL_DEFENSE_SCENE":
                  SwitchPageHelp.enterToSpace();
                  break;
               case "SANDBOX_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitSandboxDayLight");
                  SimpleAlertHelper.instance.data = [exitSandbox];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  break;
               case "PLANE_CRISRIS":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.planeCrisis.exitGame");
                  SimpleAlertHelper.instance.data = [exitPlaneCrisisGame];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  break;
               case "GAME_HALL_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitGameHall");
                  SimpleAlertHelper.instance.data = [exitGameHall];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  break;
               case "CROSS_GUILD_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.CrossGuild.exitGame");
                  SimpleAlertHelper.instance.data = [exitCrossGuildWar];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  break;
               case "INCREASINGLY_ROAD_SCENE":
                  SwitchPageHelp.enterToSpace();
                  break;
               case "DARK_MAZE_SCENE":
                  DarkMazeManager.instance.darkMazeOperation(7);
                  SwitchPageHelp.enterToSpace();
                  break;
               case "SELF_CHESS_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("SevenYearGloryGame.room.exit.hint");
                  SimpleAlertHelper.instance.data = [exitSelfChessGame];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  break;
               case "SECRET_ADVENTURE_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("secret.exit");
                  SimpleAlertHelper.instance.data = [exitSecretGame];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  break;
               case "THESE_PVP_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("theseuspvp.return");
                  SimpleAlertHelper.instance.data = [exitTheseusPvpGame];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  break;
               case "SECRET_WAR_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("secretwar.leaveTip");
                  SimpleAlertHelper.instance.data = [exitSecretWar];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  break;
               case "CHILD_NS_WAR_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("childNswar.return");
                  SimpleAlertHelper.instance.data = [exitChildNsWarGame];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  break;
               case "UNREAL_SHOOTING_ROOM":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitUnrealShootingRoom");
                  SimpleAlertHelper.instance.data = [exitUnrealShootingRoom];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  return;
               case "APEX_ROOM":
                  _loc10_ = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitApexRoom");
                  SimpleAlertHelper.instance.data = [exitApexRoom];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  return;
               case "STARAREA_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip17");
                  SimpleAlertHelper.instance.data = [exitStararea];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  return;
               case "GLORY_GAME_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("SevenYearGloryGame.room.exit.hint");
                  SimpleAlertHelper.instance.data = [exitGloryGame];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  return;
               case "THESE_Double_PVP_SCENE":
                  _loc10_ = LanguageMgr.GetTranslation("theseuspvpMulti.return");
                  SimpleAlertHelper.instance.data = [exitTheseusMultiPvpGame];
                  SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true);
                  return;
            }
            if(CampaignManager.CampaignOverState)
            {
               return;
            }
            if(SceneManager.instance.currentType == "THESE_Double_PVP_SCENE")
            {
               return;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("QUIT_CAMPAIGN"));
            if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
            {
               if(WorldBossHelper.checkMonopoly(CampaignManager.instance.mapId))
               {
                  if(MonopolyManager.instance.model.gameIsOver)
                  {
                     MonopolySocketOutManager.sendLeaveCampaign();
                  }
                  else
                  {
                     CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
                  }
               }
               else if(WorldBossHelper.checkMarket(CampaignManager.instance.mapId))
               {
                  if(CampaignManager.instance.marketModel.selfStall.state != 0)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("mediator.mapview.CampaignMapMouseEventMediator.inSell"));
                  }
                  else
                  {
                     CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
                  }
               }
               else if(WorldBossHelper.checkSacrificeRoom(CampaignManager.instance.mapId))
               {
                  CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
               }
               else if(WorldBossHelper.checkAirGarden(CampaignManager.instance.mapId))
               {
                  CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
               }
               else
               {
                  _loc10_ = getExitCampaignMessage();
                  if(_loc10_)
                  {
                     SimpleAlertHelper.instance.data = [__returnCampaignHandler];
                     SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc10_,_loc12_,_loc2_,true,true,true,2,"SIMPLE_ALERT",170);
                  }
                  else
                  {
                     CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
                  }
               }
            }
            else
            {
               CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
            }
         }
      }
      
      private function exitStararea(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            StarareaManager.instance.exit();
         }
      }
      
      private function exitGloryGame(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
            GloryGameManager.instance.exit();
         }
      }
      
      private function exitLandMine(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            LandMineManager.instance.leave();
         }
      }
      
      private function exitSandbox(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SandboxManager.instance.leave(SandboxManager.instance.type);
         }
      }
      
      private function exitGameHall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            GameHallManager.instance.teamLeave();
            SpaceManager.instance.exit = false;
         }
      }
      
      private function exitPlaneCrisisGame(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PlaneCrisisManager.Instance.gameOp(7);
         }
      }
      
      private function exitCrossGuildWar(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CrossGuildManager.instance.sendCrossGuildWar(11);
            CrossGuildManager.instance.model.isInCrossGuildWar = false;
            SceneManager.instance.setScene(SwitchPageHelp.returnScene);
         }
      }
      
      private function exitPlanesWarResult(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PlanesWarManager.instance.model.isInPlanesWar = false;
            PlanesWarManager.instance.sendPlanesOpMsg(19);
            SceneManager.instance.setScene("CASTLE_SCENE");
         }
      }
      
      private function exitMultilordsRoom(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
         }
      }
      
      private function exitMatelordsRoom(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
         }
      }
      
      private function exitSelfChessGame(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SelfChessManager.Ins.exitGame();
            SwitchPageHelp.returnToSpace();
         }
      }
      
      private function exitSecretGame(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Object = null;
         if(param1)
         {
            SecretAdventerManager.Instance.opCommon(7);
            _loc3_ = {};
            _loc3_.isShowLoading = true;
            _loc3_.isSecretAdventure = true;
            SwitchPageHelp.returnToSpace(_loc3_);
         }
      }
      
      private function exitSecretWar(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Object = null;
         if(param1)
         {
            SecretWarManager.Instance.gameOp(2);
            SecretWarManager.Instance.clear();
            _loc3_ = {};
            _loc3_.isShowLoading = true;
            SwitchPageHelp.returnToSpace();
         }
      }
      
      public function exitTheseusPvpGame(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Object = null;
         if(param1)
         {
            TheseusPvpManager.Instance.model.matchState = 1;
            TheseusPvpManager.Instance.doSomething(2);
            _loc3_ = {};
            _loc3_.isShowLoading = true;
            _loc3_.isTheseusPvptrue = true;
            SwitchPageHelp.returnToSpace(_loc3_);
         }
      }
      
      public function exitTheseusMultiPvpGame(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
         }
      }
      
      public function exitChildNsWarGame(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Object = null;
         if(param1)
         {
            ChildNswarManager.Instance.model.matchState = 1;
            BattleManager.getInstance().isLockChildnswar = false;
            ChildNswarManager.Instance.doSomething(5);
            _loc3_ = {};
            _loc3_.isShowLoading = true;
            _loc3_.isChildNswartrue = true;
            SwitchPageHelp.returnToSpace(_loc3_);
         }
      }
      
      private function exitAreslordsRoom(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
            AresLordsManager.instance.clearRoomInfo();
         }
      }
      
      private function exitUnrealShootingRoom(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.unrealShootingController.sendUnrealShootingLeaveMatch();
         }
      }
      
      private function exitApexRoom(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
            ApexManager.instance.clearRoomInfo();
         }
      }
      
      private function getExitCampaignMessage() : String
      {
         var _loc5_:CampaignTemplate = null;
         var _loc6_:int = 0;
         var _loc2_:MarryQualityData = null;
         var _loc1_:String = LanguageMgr.GetTranslation("mainBar.MainToolBar.campaignMsg");
         var _loc4_:int = CampaignManager.instance.mapModel.mapId;
         var _loc7_:MapTemplate = TempleteManager.instance.mapTemplateCate.getTemplateByID(_loc4_);
         if(_loc7_)
         {
            _loc5_ = TempleteManager.instance.campaignTemplateDic[_loc7_.CampaignId];
         }
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.campaignTemplate && CampaignManager.instance.mapModel.campaignTemplate.Types == 13)
         {
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.campaignMsgReturnMolong");
         }
         var _loc3_:Boolean = WorldBossHelper.checkWorldBoss(_loc4_);
         if(_loc3_)
         {
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.str01");
         }
         _loc3_ = WorldBossHelper.checkSumCampaign(_loc4_);
         if(_loc3_)
         {
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.campaignReturnSumCampaign");
         }
         _loc3_ = WorldBossHelper.checkSvs(_loc4_);
         if(_loc3_)
         {
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.str10");
         }
         _loc3_ = WorldBossHelper.checkMaze(_loc4_);
         if(_loc3_)
         {
            if(selfMemberData.isDie == 1)
            {
               if(towerInfo.freeEnterCount - towerInfo.enterCount > 0)
               {
                  _loc1_ = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.content05");
               }
               else
               {
                  _loc1_ = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.content02");
               }
               return _loc1_;
            }
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.str04");
         }
         _loc3_ = WorldBossHelper.checkMaze2(_loc4_);
         if(_loc3_)
         {
            if(selfMemberData.isDie == 1)
            {
               if(towerInfo.freeEnterCount - towerInfo.enterCount > 0)
               {
                  _loc1_ = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.content05");
               }
               else
               {
                  _loc1_ = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.content02");
               }
               return _loc1_;
            }
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.str06");
         }
         _loc3_ = WorldBossHelper.checkMaze3(_loc4_);
         if(_loc3_)
         {
            if(selfMemberData.isDie == 1)
            {
               if(towerInfo.freeEnterCount - towerInfo.enterCount > 0)
               {
                  _loc1_ = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.content05");
               }
               else
               {
                  _loc1_ = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.content02");
               }
               return _loc1_;
            }
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.strlianyumigong");
         }
         _loc3_ = WorldBossHelper.checkConsortiaSecretLand(_loc4_);
         if(_loc3_)
         {
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.str07");
         }
         _loc3_ = WorldBossHelper.checkPvp(_loc4_) || WorldBossHelper.checkFlameTemple(_loc4_);
         if(_loc3_)
         {
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.str05");
         }
         _loc3_ = WorldBossHelper.checkUnrealShooting(_loc4_);
         if(_loc3_)
         {
            return LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitUnrealShootingCampaign");
         }
         _loc3_ = WorldBossHelper.checkPetLand(_loc4_) || WorldBossHelper.checkMineral(_loc4_) || WorldBossHelper.checkMarket(_loc4_);
         if(_loc3_)
         {
            _loc1_ = null;
         }
         _loc3_ = WorldBossHelper.checkWedding(_loc4_);
         if(_loc3_)
         {
            if(MarryManager.instance.model.isWeddingMaster)
            {
               if(MarryManager.instance.model.isEngaged)
               {
                  return LanguageMgr.GetTranslation("MainToolBar.extWeddingRoom02");
               }
               _loc6_ = MarryManager.instance.model.roomInfo.property7;
               _loc2_ = TempleteManager.instance.getMarryQualityTemplateCate.getTempById(_loc6_);
               if(!_loc2_ || StringHelper.isNullOrEmpty(_loc2_.Path))
               {
                  return LanguageMgr.GetTranslation("MainToolBar.extWeddingRoom03");
               }
            }
            return LanguageMgr.GetTranslation("MainToolBar.extWeddingRoom01");
         }
         _loc3_ = WorldBossHelper.checkFarm(_loc4_) || WorldBossHelper.checkInHouse(_loc4_) || WorldBossHelper.checkGodsEvening(_loc4_);
         if(_loc3_)
         {
            return null;
         }
         _loc3_ = WorldBossHelper.checkDuskArea(_loc4_) || WorldBossHelper.checkFlameTemple(_loc4_) || WorldBossHelper.checkIceFireTemple(_loc4_);
         if(_loc3_)
         {
            _loc1_ = LanguageMgr.GetTranslation("mainBar.MainToolBar.str11");
         }
         _loc3_ = WorldBossHelper.checkForbiddenBoss(_loc4_);
         if(_loc3_)
         {
            return LanguageMgr.GetTranslation("mainBar.MainToolBar.str12");
         }
         if(roomInfo && roomInfo.isCross && roomInfo.playerCount > 1 && _loc5_ && _loc5_.Capacity == 4 && _loc5_.DungeonId == 1 && _loc5_.Types == 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("mainBar.MainToolBar.campaignMsg") + "\n" + LanguageMgr.GetTranslation("mainBar.MainToolBar.leaving crossCampaign");
         }
         return _loc1_;
      }
      
      private function get towerInfo() : TowerInfo
      {
         return PlayerManager.instance.currentPlayerModel.towerInfo;
      }
      
      private function get selfMemberData() : CampaignArmy
      {
         return CampaignManager.instance.mapModel.selfMemberData;
      }
      
      private function __returnCampaignHandler(param1:Boolean, param2:Boolean) : void
      {
         if(CampaignManager.CampaignOverState)
         {
            return;
         }
         if(param1)
         {
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
         }
      }
      
      public function returnFromHookRoom() : void
      {
         CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
      }
      
      private function __consortiaBtnClickHandler(param1:MouseEvent) : void
      {
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         _consortiaBtn.buttonBtn.isPlaying = false;
         _consortiaBtn.buttonBtn.stopEffect();
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("consortia",1);
      }
      
      protected function __taskBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("task");
      }
      
      protected function __storeBtnClick(param1:MouseEvent) : void
      {
         if(BraveLegManager.instance.hasTeam())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
            return;
         }
         SoundManager.instance.play("015",true);
         var _loc2_:DisplayObject = param1.target.parent.parent.parent;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_ == _storeBtn.buttonBtn)
         {
            FrameControllerManager.instance.storeController.startFrameByType("STORE_PANEL_INTENSIFY");
         }
         else if(_loc2_ == _storeBtn.buttonChildBtn)
         {
            FrameControllerManager.instance.openControllerByInfo("stelesys");
         }
      }
      
      protected function __heroBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         var _loc2_:DisplayObject = param1.target.parent.parent.parent;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_ == _armyBtn.buttonBtn)
         {
            armyButtonShine = false;
            ChildManager.instance.openChildFram();
         }
         else if(_loc2_ == _armyBtn.buttonChildBtn && _armyBtn.buttonChildBtn.enable)
         {
            FrameControllerManager.instance.openControllerByInfo("childnursingspirit","MAIN");
         }
      }
      
      private function __skillClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         var _loc2_:DisplayObject = param1.target.parent.parent.parent;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_ == _skillBtn.buttonBtn)
         {
            FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL);
         }
         else if(_loc2_ == _skillBtn.buttonChildBtn)
         {
            FrameControllerManager.instance.openControllerByInfo("goddess");
         }
      }
      
      protected function __bagBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = null;
         SoundManager.instance.play("015",true);
         if(FashionManager.instance.fashionIdentityProgress <= 0)
         {
            SharedManager.instance.fashionIdentityProgress = 1;
         }
         __bagIsFullHandler(null);
         if(param1.target is MainToolButton)
         {
            _loc2_ = param1.target.buttonBtn;
         }
         else
         {
            _loc2_ = param1.target.parent.parent.parent;
         }
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_ == _bagBtn.buttonBtn)
         {
            FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL);
         }
         else if(_loc2_ == _bagBtn.buttonChildBtn && _bagBtn.buttonChildBtn.enable)
         {
            if(!VersionSwitch.ANCIENTARTIFACT)
            {
               return;
            }
            FrameControllerManager.instance.openControllerByInfo("ancientartifact");
         }
      }
      
      private function __onFriendsOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:IMMsgBoxView = IMManager.instance.createIMMsgBox();
         if(_loc3_)
         {
            ShowTipManager.Instance.removeCurrentTip();
            _loc2_ = new Point(getFriendsBtnX(),_loc3_.y);
            _loc2_ = this.localToGlobal(_loc2_);
            _loc3_.x = _loc2_.x - 80;
            _loc3_.y = _loc2_.y - 15;
            _loc2_ = null;
            LayerManager.Instance.addToLayer(_loc3_,0);
         }
      }
      
      private function __onFriendsOutHandler(param1:MouseEvent) : void
      {
         IMManager.instance.model.removeMsgBoxTimeOut = setTimeout(removeIMMsgBox,300);
      }
      
      private function removeIMMsgBox() : void
      {
         clearTimeout(IMManager.instance.model.removeMsgBoxTimeOut);
         IMManager.instance.removeIMMsgBox();
      }
      
      private function __dragonTalkerClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         var _loc2_:DisplayObject = param1.target.parent.parent.parent;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_ == _dragonTalkerBtn.buttonBtn)
         {
            SwitchPageHelp.openDragonTalkerFrame();
         }
         else if(_loc2_ == _dragonTalkerBtn.buttonChildBtn)
         {
            if(!thane.isChangeJob || DragonTitanManager.instance.model.templateId <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.titanNotOpen"));
               return;
            }
            FrameControllerManager.instance.openControllerByInfo("dragontitan");
         }
      }
      
      protected function __onFriendsClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("015",true);
         if(_addFriendListFlag)
         {
            _loc2_ = FriendManager.getInstance().bufferLength();
            if(_loc2_ <= 1)
            {
               _addFriendListFlag = false;
               stopBlinkFriendBtn();
            }
            showAddFriendAlert();
         }
         else
         {
            stopBlinkFriendBtn();
            FrameControllerManager.instance.friendControler.startFrameByType(1);
         }
      }
      
      private function __archaeologyClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         var _loc2_:DisplayObject = param1.target.parent.parent.parent;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_ == _archaeologyBtn.buttonBtn)
         {
            if(BraveLegManager.instance.hasTeam())
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str08"));
               return;
            }
            FrameControllerManager.instance.openControllerByInfo("archaeology");
         }
         else if(_loc2_ == _archaeologyBtn.buttonChildBtn)
         {
            FrameControllerManager.instance.openControllerByInfo("theseussoul");
         }
      }
      
      private function __imFrameUpdateHandler(param1:Event) : void
      {
         var _loc2_:int = int(IMManager.instance.model.msgBoxList.length);
         _loc2_ = 30;
         _loc2_ > 30 ? _loc2_ : _loc2_;
         if(_loc2_ > 0)
         {
            _friendsBtn.buttonBtn.movie.movie["content"].gotoAndStop(2);
            _friendsBtn.buttonBtn.movie.movie["content"]["numtxt"].mouseEnabled = false;
            _friendsBtn.buttonBtn.movie.movie["content"]["numtxt"].text = _loc2_.toString();
         }
         else
         {
            _friendsBtn.buttonBtn.movie.movie["content"].gotoAndStop(1);
         }
      }
      
      private function get currentArmyId() : int
      {
         var _loc1_:BaseArmy = ArmyManager.instance.army;
         if(_loc1_)
         {
            return _loc1_.id;
         }
         return 0;
      }
      
      public function switchToolsBarState(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         switch(param1 - 1)
         {
            case 0:
            case 2:
               _returnBtn.enable = false;
               _bagBtn.enable = false;
               _starBtn.enable = false;
               _armyBtn.enable = false;
               _mountBtn.enable = false;
               _consortiaBtn.enable = false;
               _skillBtn.enable = false;
               _storeBtn.enable = false;
               _petBtn.enable = false;
               _archaeologyBtn.enable = false;
               _dragonTalkerBtn.enable = false;
               ResourcesBar.instance.iconClickEnable = false;
               KeyBoardRegister.instance.functionEnable = false;
               break;
            case 1:
            case 3:
               _returnBtn.enable = true;
               _bagBtn.enable = true;
               _starBtn.enable = true;
               _armyBtn.enable = true;
               _mountBtn.enable = true;
               _consortiaBtn.enable = true;
               _skillBtn.enable = true;
               _storeBtn.enable = true;
               _archaeologyBtn.enable = true;
               _dragonTalkerBtn.enable = thane.vocationGrades > 0;
               _petBtn.enable = true;
               ResourcesBar.instance.iconClickEnable = true;
               KeyBoardRegister.instance.functionEnable = true;
         }
      }
      
      public function set mountButtonShine(param1:Boolean) : void
      {
         if(!_mountBtn)
         {
            return;
         }
         _mountBtn.buttonBtn.isPlaying = param1;
         if(param1)
         {
            _mountBtn.buttonBtn.playEffect();
         }
         else
         {
            _mountBtn.buttonBtn.stopEffect();
         }
      }
      
      public function set petButtonShine(param1:Boolean) : void
      {
         if(!_petBtn)
         {
            return;
         }
         _petBtn.buttonBtn.isPlaying = param1;
         if(param1)
         {
            _petBtn.buttonBtn.playEffect();
         }
         else
         {
            _petBtn.buttonBtn.stopEffect();
         }
      }
      
      public function setPetButtonVisible() : void
      {
         if(!_petBtn)
         {
            return;
         }
         _petBtn.enable = PlayerManager.instance.currentPlayerModel.petSystemIsOpened;
      }
      
      public function set consortiaButtonShine(param1:Boolean) : void
      {
         if(param1)
         {
            _consortiaBtn.buttonBtn.isPlaying = true;
            _consortiaBtn.buttonBtn.playEffect();
         }
         else
         {
            _consortiaBtn.buttonBtn.isPlaying = false;
            _consortiaBtn.buttonBtn.stopEffect();
         }
      }
      
      public function set armyButtonShine(param1:Boolean) : void
      {
         if(!_armyBtn)
         {
            return;
         }
         _armyBtn.buttonBtn.isPlaying = param1;
         if(param1)
         {
            _armyBtn.buttonBtn.playEffect();
         }
         else
         {
            _armyBtn.buttonBtn.stopEffect();
         }
      }
      
      private function __poptipBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("consortiagroupchat");
      }
      
      public function get poptipButtonVisible() : Boolean
      {
         return _poptipBtn.visible;
      }
      
      public function set poptipButtonVisible(param1:Boolean) : void
      {
         if(param1 && !KeyBoardRegister.instance.vehicleFlag && playerInfo.consortiaID > 0)
         {
            _poptipBtn.visible = true;
         }
         else
         {
            _poptipBtn.visible = false;
            poptipButtonShine = false;
         }
      }
      
      public function set poptipButtonShine(param1:Boolean) : void
      {
         if(param1 && consortiaGroupChatModel.shineSwitch && poptipButtonVisible && consortiaGroupChatModel.unreadGroupChat)
         {
            if(!_poptipBtn.buttonBtn.isPlaying)
            {
               _poptipBtn.buttonBtn.isPlaying = true;
               _poptipBtn.buttonBtn.playEffect();
            }
         }
         else
         {
            _poptipBtn.buttonBtn.isPlaying = false;
            _poptipBtn.buttonBtn.stopEffect();
         }
      }
      
      public function getFriendsBtnX() : Number
      {
         return _friendsBtn.x;
      }
      
      public function blinkFriendBtn() : void
      {
         _friendsBtn.buttonBtn.isPlaying = true;
         _friendsBtn.buttonBtn.playEffect();
         setTimeout(stopBlinkFriendBtn,2000);
      }
      
      private function stopBlinkFriendBtn() : void
      {
         _friendsBtn.buttonBtn.isPlaying = false;
         _friendsBtn.buttonBtn.stopEffect();
      }
      
      public function blinkFriendBtnNoTime() : void
      {
         _addFriendListFlag = true;
         _friendsBtn.buttonBtn.isPlaying = true;
         _friendsBtn.buttonBtn.playEffect();
      }
      
      private function showAddFriendAlert() : void
      {
         FriendManager.getInstance().popBufferFrame();
      }
      
      private function __heroExpUpdateHandler(param1:PlayerEvent) : void
      {
         _exp.refreshView();
      }
      
      private function __hasSkillPointHandler(param1:PlayerEvent) : void
      {
         if(thane.skillCate.skillPoint > 0)
         {
            _skillBtn.buttonBtn.isPlaying = false;
         }
         else
         {
            _skillBtn.buttonBtn.isPlaying = false;
            _skillBtn.buttonBtn.stopEffect();
         }
      }
      
      private function __bagIsFullHandler(param1:BagEvent) : void
      {
         if(playerInfo.isNeedWeekLockGuild)
         {
            _bagBtn.buttonBtn.isPlaying = true;
            _bagBtn.buttonBtn.playEffect();
         }
         else if(GoodsManager.instance.findEmputyPos() == -1)
         {
            _bagBtn.buttonBtn.movie.movie["content"].gotoAndStop(2);
            _bagBtn.buttonBtn.isPlaying = true;
            _bagBtn.buttonBtn.playEffect();
         }
         else
         {
            _bagBtn.buttonBtn.movie.movie["content"].gotoAndStop(1);
            _bagBtn.buttonBtn.isPlaying = false;
            _bagBtn.buttonBtn.stopEffect();
         }
      }
      
      private function get consortiaGroupChatModel() : ConsortiaGroupChatModel
      {
         return FrameControllerManager.instance.consortiaGroupChatControler.model;
      }
      
      private function get army() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      public function getButtnByType(param1:int) : MainToolButton
      {
         switch(param1 - 1)
         {
            case 0:
               return _shopBtn;
            case 1:
               return _bagBtn;
            case 2:
               return _storeBtn;
            case 3:
               return _skillBtn;
            case 4:
               return _starBtn;
            case 5:
               return _armyBtn;
            case 7:
               return _consortiaBtn;
            case 8:
               return _returnBtn;
            case 9:
               return _campaignBtn;
            case 12:
               return _mountBtn;
            case 13:
               return _petBtn;
            case 14:
               return _outerCityBtn;
            case 15:
               return _castleBtn;
            case 16:
               return _archaeologyBtn;
            default:
               return null;
         }
      }
      
      public function getMovieImageByType(param1:int) : MovieImage
      {
         switch(param1 - 1)
         {
            case 0:
               return _InviteBtn;
            case 1:
               return _recommendBtn;
            default:
               return null;
         }
      }
      
      private function __onResize(param1:Event) : void
      {
         var _loc2_:int = StageReferance.stageWidth;
         var _loc5_:int = StageReferance.stageHeight;
         _poptipBtn.x = _loc2_ - 657;
         _poptipBtn.y = _loc5_ - 68;
         _marryBtn.x = (_loc2_ - _marryBtn.width) / 2;
         _marryBtn.y = _loc5_ - 148;
         _crossContiner.x = StageReferance.stageWidth / 2 - 30;
         _crossContiner.y = StageReferance.stageHeight - 200;
         var _loc3_:Point = currentLocation;
         _loc3_.x = int(_loc3_.x);
         _loc3_.y = int(_loc3_.y);
         this.x = _loc3_.x;
         this.y = _loc3_.y - 3;
         _loc3_ = null;
         var _loc4_:int = 332;
         if(_poptipBtn.x < _loc4_)
         {
            _poptipBtn.x = _loc4_;
         }
         if(this.x < _loc4_ - _payBtn.x)
         {
            this.x = _loc4_ - _payBtn.x;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("MAIN_TOOL_BAR_RESIZED"));
      }
      
      private function __deactivateHandler(param1:Event) : void
      {
      }
      
      private function get currentLocation() : Point
      {
         var _loc4_:Point = new Point();
         var _loc3_:int = StageReferance.gameStageHeight;
         var _loc2_:int = StageReferance.gameStageWidth;
         _loc4_.x = _loc2_ - viewRectangle.width * StageReferance.gameScaleX;
         if(_loc4_.x < PathInfo.GAME_WIDTH - width)
         {
            _loc4_.x = PathInfo.GAME_WIDTH - width;
         }
         var _loc1_:int = viewRectangle.height * StageReferance.gameScaleY;
         _loc4_.y = _loc3_ - _loc1_;
         if(_loc4_.y < PathInfo.GAME_HEIGHT - _loc1_)
         {
            _loc4_.y = PathInfo.GAME_HEIGHT - _loc1_;
         }
         return _loc4_;
      }
      
      public function doMove(param1:DisplayObject = null, param2:Boolean = false, param3:Function = null, param4:Array = null) : void
      {
         var _loc10_:MainToolButton = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         if(!param1)
         {
            for each(_loc10_ in _moduleBtns)
            {
               if(_loc10_.parent && _loc10_.visible)
               {
                  _loc10_.x = 600 - 50 - _loc7_ * 47;
                  _loc7_++;
               }
            }
         }
         else
         {
            _loc8_ = _moduleBtns.indexOf(param1);
            if(_loc8_ < 0)
            {
               return;
            }
            _loc5_ = int(_moduleBtns.length);
            _loc6_ = [];
            _loc9_ = 0;
            while(_loc9_ < _loc5_)
            {
               _loc10_ = _moduleBtns[_loc9_];
               if(_loc10_.parent && _loc10_.visible)
               {
                  if(_loc9_ > _loc8_)
                  {
                     param2 ? _loc6_.push(_loc10_) : (_loc10_.x -= 47);
                  }
                  else
                  {
                     if(_loc9_ >= _loc8_)
                     {
                        if(param3 != null)
                        {
                           param4 ? param3(param4) : param3();
                        }
                        param3 = null;
                        param4 = null;
                        return;
                     }
                     param1.x = _loc10_.x - 47;
                     _loc7_++;
                  }
               }
               _loc9_++;
            }
            if(_loc7_ == 0)
            {
               param1.x = 600 - 50;
            }
            if(_loc6_.length > 0)
            {
               TweenMax.allTo(_loc6_,1,{"x":"-47"},0,param3,param4 ? [param4] : null);
            }
            else
            {
               if(param3 != null)
               {
                  param4 ? param3(param4) : param3();
               }
               param3 = null;
               param4 = null;
            }
         }
      }
      
      public function show() : void
      {
         __onResize(null);
         initData();
         LayerManager.Instance.addToLayer(this,4,false,false,0,2);
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         TimeBoxView.instance.hide();
      }
      
      public function mopupIng() : void
      {
         if(_campaignBtn)
         {
            _campaignBtn.enable = false;
         }
         if(_castleBtn)
         {
            _castleBtn.enable = false;
         }
         if(_outerCityBtn)
         {
            _outerCityBtn.enable = false;
         }
      }
      
      public function mopupEnd() : void
      {
         if(_campaignBtn)
         {
            _campaignBtn.enable = true;
         }
         if(_castleBtn)
         {
            _castleBtn.enable = true;
         }
         if(_outerCityBtn)
         {
            _outerCityBtn.enable = true;
         }
      }
      
      public function getFriendBtn() : MainToolButton
      {
         return _friendsBtn;
      }
   }
}

