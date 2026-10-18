package yishi.manager
{
   import battle.BattleManager;
   import battle.handler.BattleResultHandler;
   import battle.utils.Int64Utils;
   import chat.ChatManager;
   import chat.datas.ChatChannel;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.MD5;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.active.RentalBagOpResMsg;
   import com.road.yishi.proto.answerquestion.AnswerQuestionMsg;
   import com.road.yishi.proto.army.ArmyChangeSharpMsg;
   import com.road.yishi.proto.battle.BattleReportMsg;
   import com.road.yishi.proto.campaign.CampaignNotifyMsg;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.campaign.CampaignTakeCardsMsg;
   import com.road.yishi.proto.campaign.LockScreenRspMsg;
   import com.road.yishi.proto.campaign.TowerInfoMsg;
   import com.road.yishi.proto.campaign.WorldBossInfoLoadMsg;
   import com.road.yishi.proto.campaign.WorldBossReportMsg;
   import com.road.yishi.proto.chat.ChatChannelMsg;
   import com.road.yishi.proto.gamehall.GameHallInviteMsg;
   import com.road.yishi.proto.gameplot.PlotMsg;
   import com.road.yishi.proto.gateway.GatewayMsg;
   import com.road.yishi.proto.gods.CrossGodsInfoMsg;
   import com.road.yishi.proto.gods.CrossGodsMsg;
   import com.road.yishi.proto.gods.GodsPlayerInfoMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import com.road.yishi.proto.item.CampaignCardsMsg;
   import com.road.yishi.proto.item.VirtualBagMsg;
   import com.road.yishi.proto.item.VirtualItemMsg;
   import com.road.yishi.proto.medal.MedalInfoMsg;
   import com.road.yishi.proto.medal.MedalOpMsg;
   import com.road.yishi.proto.novice.NoviceReqMsgMsg;
   import com.road.yishi.proto.pet.NavigationBoatUpgradeInviteMsg;
   import com.road.yishi.proto.pet.PetIslandDefendStateMsg;
   import com.road.yishi.proto.pet.PetRankRewardMsg;
   import com.road.yishi.proto.player.DataResetMsg;
   import com.road.yishi.proto.player.ExtraFieldInfoMsg;
   import com.road.yishi.proto.player.LoginStateMsg;
   import com.road.yishi.proto.player.PlayerAASRefreshMsg;
   import com.road.yishi.proto.player.PlayerAASRspMsg;
   import com.road.yishi.proto.player.PlayerExtraFieldMsg;
   import com.road.yishi.proto.room.MatchStateMsg;
   import com.road.yishi.proto.room.RoomCreatedMsg;
   import com.road.yishi.proto.room.RoomEnterMsg;
   import com.road.yishi.proto.room.RoomInviteMsg;
   import com.road.yishi.proto.room.RoomMsg;
   import com.road.yishi.proto.room.RoomPlayerMsg;
   import com.road.yishi.proto.simple.CheckImageMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.switches.SwitchInfoListMsg;
   import com.road.yishi.proto.switches.SwitchInfoMsg;
   import com.road.yishi.proto.timer.TimerInfoListMsg;
   import com.road.yishi.proto.timer.TimerInfoMsg;
   import com.road.yishi.proto.unrealshooting.UnrealShootingMsg;
   import com.road.yishi.proto.unrealshooting.UnrealShootingPlayerMsg;
   import com.road.yishi.proto.worldmap.WorldBossMsg;
   import dialog.data.DialogMessageInfo;
   import dialog.utils.NewbieManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import logging.LoggerSys;
   import mainBar.ChatBar;
   import mainBar.SmallMapBar;
   import manager.AgentFilterManager;
   import manager.ExternalInterfaceManager;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.ChildPatrolManager;
   import managers.EclipticPalaceManager;
   import managers.ExchangeBoxManager;
   import managers.GameHallManager;
   import managers.GroupfbManager;
   import managers.MarryManager;
   import managers.MopupManager;
   import managers.MountsManager;
   import managers.MysteryShopManager;
   import managers.PerkinLabManager;
   import managers.PumpingJoyManager;
   import managers.RoomManager;
   import managers.TaskTraceTipManager;
   import managers.TheseussoulManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.PetBossModel;
   import map.campaign.data.UnrealShootingUserInfo;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.preload.PreLoadWorldBoss;
   import map.campaign.view.frame.MazeFallItemsFrame;
   import map.internals.utils.Utils;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import map.space.manager.SpaceSocketManager;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.fashion.FashionModel;
   import mvc.module.godsevening.GERankItemPersonData;
   import mvc.module.godsevening.GERankItemServerData;
   import mvc.module.room.RoomInfo;
   import proxy.SocketDataProxyManager;
   import sandbox.SandboxManager;
   import tasktracetip.data.TipMessageData;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.GlobalConfig;
   import yishi.SwitchPageHelp;
   import yishi.actions.base.AlertTipAction;
   import yishi.actions.map.DialogAction;
   import yishi.actions.map.MessageAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.BattleModel;
   import yishi.datas.UserInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GameHallEasterTemplateInfo;
   import yishi.datas.templates.GameHallTemplateInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.scene.SceneManager;
   import yishi.scene.SceneType;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CallInterfaceUtil;
   import yishi.utils.DateFormatter;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.JsHelper;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.LoadingSceneView;
   import yishi.view.frame.InviteFrame;
   import yishi.view.frame.NavigationInviteAssistFrame;
   import yishi.view.frame.RaceAgainstTimeFrame;
   import yishi.view.frame.TimeOutInviteFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tips.MultiMessageTipManager;
   import yzhkof.debug.log;
   
   public class BaseManager extends EventDispatcher
   {
      
      private static const RAPID_PASS:uint = 4801;
      
      private static var _instance:BaseManager;
      
      public static var isMusicOn:Boolean;
      
      public static var isSoundOn:Boolean;
      
      public static var delayId:int = 0;
      
      public static var petBossMapId:int = 0;
      
      public static const TIPS_SIGIN:uint = 1;
      
      public static const TIPS_INVITATION:uint = 2;
      
      private var _inviteRoomId:int;
      
      private var _roomPwd:String;
      
      public var isRigister:Boolean = false;
      
      public var wasteBossBufferIdByHero:String = "";
      
      public var wasteBossBufferIdByBoss:String = "";
      
      public var sendVehicleByteCount:int = 0;
      
      public var wordBossInvincibleState:Boolean;
      
      public var thumbnail:Bitmap;
      
      private var _updateBroadcastContent:XML;
      
      private var _unrealShootingReportData:Object;
      
      private const TYPES_STEELS_PVP:int = 1;
      
      private const TYPES_MULTIS_PVP:int = 2;
      
      private const TYPES_HUNDUN_PVP:int = 3;
      
      private var isActivity:Boolean = false;
      
      private var isInCampaign:Boolean = false;
      
      private var _preLoadWorldBossId:int;
      
      public var isSelect:Boolean;
      
      public var noPaySelect:Boolean;
      
      public var existRoomInvate:Boolean;
      
      private var _loginFrame:BaseAlerFrame;
      
      public var preBattleId:String = "";
      
      private var _timeId1:int = 0;
      
      private var _timeId2:int = 0;
      
      public var existNavigationInvite:Boolean = false;
      
      public function BaseManager()
      {
         super();
      }
      
      public static function get instance() : BaseManager
      {
         if(!_instance)
         {
            _instance = new BaseManager();
         }
         return _instance;
      }
      
      private static function onFightCanceled(param1:SLGSocketEvent) : void
      {
         log({},"战斗结束");
         BattleManager.onFightCanceled();
      }
      
      public function get updateBroadcastContent() : XML
      {
         return _updateBroadcastContent;
      }
      
      public function set updateBroadcastContent(param1:XML) : void
      {
         _updateBroadcastContent = param1;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("RECEIVED_NOTICE"));
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get army() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get userInfo() : UserInfo
      {
         return PlayerManager.instance.currentPlayerModel.userInfo;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4265,__reloadAgentDirtyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4438,__getWorldProsperityHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4203,__worldBossReportHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4202,__resetDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4103,__battleInfoResultHandler);
         SocketManager.instance.addEventListener("close",__socketCloseHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 3842,__loginOtherHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 141,__lockSceneHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 12,__createRoomHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 16,__roomInviteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 125,__createCampaignHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 138,__gamePlotHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 126,__msgHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 111,__serverBroadcastHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 253,__godsEveningNoticeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4164,__armyChangeSharpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4166,onFightCanceled);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 6,__loginStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 135,__campaignCardsHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 26,__campaingTakeCardHandler);
         NotificationManager.instance.addEventListener("SESSION_OVER",__sessionOverHandler);
         NotificationManager.instance.addEventListener("SLGSocketEvent" + 138,__gamePlotActionHandler);
         NotificationManager.instance.addEventListener("SLGSocketEvent" + 126,__showMsgHandler);
         StageReferance.stage.addEventListener("click",__stageClickHandler);
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         externalManager.addEventListener("SOUND_OFF",__setSoundOffHandler);
         externalManager.addEventListener("SOUND_ON",__setSoundOnHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4381,__worldBossLoadHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4402,__securityCodeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4422,__switchesUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4419,__towerReportHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4201,__requestHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4483,__forceQuitBattleCampaign);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4493,__warFightRemainNumber);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4490,__cccHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4512,__vehicleStartHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4595,__createSpaceHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4606,__returnSpaceHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4610,__vipMountStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4613,__petRankRewardHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4913,__mulityCampaignRequestHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4648,__vipCustomNotifyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4686,__petBossSwitchHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4694,__showQuizHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4709,__rentalBagResHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4715,__medalOpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4717,__medalInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4776,__pvpTimerHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 260,__updateInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 299,__crossMutiStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 327,__reFreshBuffer);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 343,__navigationInviteAssistHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4801,__matelordsOpenHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 374,__areslordsOpenHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 447,__spacetimeFaultFightTimeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 446,_reciveSpaceInfoHander);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4834,__unrealShootingReportHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4847,__CCActiveOpenStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 252,__godsEveningReportHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4863,__consortiaBossCountHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4564,__gameHallTeamInviteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4897,__antaeusTipsHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 516,__emeDreamInfoTipsHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 211,__virtualBagDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 212,__virtualBagUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4623,__raceAgainstTimeUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4287,_consortiaNewBossInfoTipsHandler);
      }
      
      private function __virtualBagDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VirtualBagMsg = new VirtualBagMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VirtualBagMsg;
         if(_loc2_.bagType == 3)
         {
            resovleVistualBag(AvengerManager.instance.model.armorBagDic,_loc2_);
            MsgMan.notifyObserver("DEVIL_ARMOR_BAG_UPDATE");
         }
         else
         {
            if(_loc2_.bagType == 4)
            {
               return;
            }
            if(_loc2_.bagType == 5)
            {
               resovleVistualBag(TheseussoulManager.Instance.modelCollenTion.armorBagDic,_loc2_);
               MsgMan.notifyObserver("EVENT_TheseusCollenTion_BAG_UPDATE");
            }
            else if(_loc2_.bagType == 6)
            {
               resovleVistualBag(TheseussoulManager.Instance.modelCollenTion.boxBagDic,_loc2_);
               MsgMan.notifyObserver("EVENT_TheseusBOX_BAG_UPDATE");
            }
         }
      }
      
      private function resovleVistualBag(param1:SimpleDictionary, param2:VirtualBagMsg, param3:SimpleDictionary = null) : void
      {
         var _loc5_:GoodsInfo = null;
         param1.clear();
         if(param3 && param3.keys.length != 0)
         {
            for each(var _loc4_:Object in param3.keys)
            {
               param1.add(_loc4_.id,_loc4_);
            }
         }
         for each(var _loc6_:VirtualItemMsg in param2.items)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc6_.templateId;
            _loc5_.count = _loc6_.count;
            _loc5_.pos = _loc6_.pos;
            _loc5_.isLock = _loc6_.isLock;
            param1.add(_loc6_.templateId,_loc5_);
         }
      }
      
      private function __virtualBagUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VirtualBagMsg = new VirtualBagMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VirtualBagMsg;
         if(_loc2_.bagType == 3)
         {
            handleVistualBagUpdate(AvengerManager.instance.model.armorBagDic,_loc2_);
            MsgMan.notifyObserver("DEVIL_ARMOR_BAG_UPDATE");
         }
         else
         {
            if(_loc2_.bagType == 4)
            {
               return;
            }
            if(_loc2_.bagType == 5)
            {
               handleVistualBagUpdate(TheseussoulManager.Instance.modelCollenTion.armorBagDic,_loc2_);
               MsgMan.notifyObserver("EVENT_TheseusCollenTion_BAG_UPDATE");
            }
            else if(_loc2_.bagType == 6)
            {
               handleVistualBagUpdate(TheseussoulManager.Instance.modelCollenTion.boxBagDic,_loc2_);
               MsgMan.notifyObserver("EVENT_TheseusBOX_BAG_UPDATE");
            }
         }
      }
      
      private function handleVistualBagUpdate(param1:SimpleDictionary, param2:VirtualBagMsg) : void
      {
         var _loc3_:GoodsInfo = null;
         for each(var _loc4_:VirtualItemMsg in param2.items)
         {
            _loc3_ = param1[_loc4_.templateId];
            if(_loc3_ == null)
            {
               _loc3_ = new GoodsInfo();
            }
            _loc3_.templateId = _loc4_.templateId;
            _loc3_.count = _loc4_.count;
            _loc3_.pos = _loc4_.pos;
            _loc3_.isLock = _loc4_.isLock;
            if(_loc3_.count == 0)
            {
               param1.del(_loc4_.templateId);
            }
            else
            {
               param1.add(_loc4_.templateId,_loc3_);
            }
         }
      }
      
      private function __antaeusTipsHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:TipMessageData = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 1)
         {
            _loc3_ = new TipMessageData();
            _loc3_.type = 59;
            _loc3_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
            TaskTraceTipManager.instance.cleanByType(59);
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc3_,showSecretTip));
         }
         else if(_loc2_.param1 == 2)
         {
            _loc3_ = new TipMessageData();
            _loc3_.type = 58;
            _loc3_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
            TaskTraceTipManager.instance.cleanByType(58);
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc3_,showSecretTip));
         }
      }
      
      private function __emeDreamInfoTipsHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         var _loc3_:TipMessageData = new TipMessageData();
         _loc3_.type = 60;
         _loc3_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
         TaskTraceTipManager.instance.cleanByType(60);
         DelayActionsUtils.instance.addAction(new AlertTipAction(_loc3_,showSecretTip));
      }
      
      private function showSecretTip(param1:Object) : void
      {
         TaskTraceTipManager.instance.showView(param1 as TipMessageData);
      }
      
      private function _consortiaNewBossInfoTipsHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         var _loc3_:TipMessageData = new TipMessageData();
         _loc3_.type = 61;
         _loc3_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
         TaskTraceTipManager.instance.cleanByType(61);
         DelayActionsUtils.instance.addAction(new AlertTipAction(_loc3_,showSecretTip));
      }
      
      private function __gameHallTeamInviteHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:GameHallTemplateInfo = null;
         var _loc8_:TimeOutInviteFrame = null;
         var _loc3_:int = 0;
         var _loc9_:GameHallEasterTemplateInfo = null;
         var _loc5_:String = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:GameHallInviteMsg = new GameHallInviteMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as GameHallInviteMsg;
         if(FrameControllerManager.instance.pokerControler.showPoker)
         {
            return;
         }
         if(ChildManager.instance.arenaModel.isInChildArena)
         {
            return;
         }
         if(EclipticPalaceManager.instance.model.openEclipticPalaceFrame)
         {
            return;
         }
         if(MarryManager.instance.model.lockScreen)
         {
            return;
         }
         if(FrameControllerManager.instance.outyardControler.isOutyardMapApply)
         {
            return;
         }
         if(FrameControllerManager.instance.dreamArenaController.dreamArenaMatching)
         {
            return;
         }
         var _loc4_:ThaneInfo = FriendManager.getInstance().friendList[_loc2_.inviterId];
         if(_loc4_ && _loc4_.relation == 2)
         {
            return;
         }
         if((SceneManager.instance.currentType == "SPACE_SCENE" || SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "GAME_HALL_SCENE" || SceneManager.instance.currentType == "OUTER_CITY_SCENE") && !MopupManager.instance.model.isMopup)
         {
            _loc6_ = TempleteManager.instance.gameHallTemplateCate.getTemplateByID(_loc2_.gameId);
            if(_loc6_)
            {
               _loc8_ = ComponentFactory.Instance.creatComponentByStylename("core.TimeOutInviteFrame");
               _loc8_.titleText = LanguageMgr.GetTranslation("gamehall.GameHallFrame.TeamInviteTitle");
               _loc3_ = _loc2_.difficulty;
               _loc9_ = TempleteManager.instance.gameHallEastTemplateCate.getTemplateByID(_loc3_);
               if(_loc2_.gameId == 4)
               {
                  _loc5_ = _loc6_.GameName;
                  if(_loc9_)
                  {
                     _loc5_ = _loc5_ + "-" + _loc9_.TemplateName;
                  }
                  _loc8_.content = LanguageMgr.GetTranslation("gamehall.GameHallFrame.TeamInviteContent",_loc2_.inviterName,_loc5_,_loc2_.count);
               }
               else
               {
                  _loc8_.content = LanguageMgr.GetTranslation("gamehall.GameHallFrame.TeamInviteContent",_loc2_.inviterName,_loc6_.GameName,_loc2_.count);
               }
               _loc8_.confirmCallBack = gameHallTeamInviteCallBack;
               _loc8_.params = [_loc2_.teamId];
               _loc8_.time = 10;
               _loc8_.show();
            }
         }
      }
      
      private function gameHallTeamInviteCallBack(param1:Boolean, param2:Array) : void
      {
         if(param1)
         {
            GameHallManager.instance.teamInviteJoin(param2[0]);
         }
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:String = SceneManager.instance.currentType;
         _loc1_;
         if(BraveLegManager.instance.hasTeam())
         {
            return false;
         }
         if(EclipticPalaceManager.instance.model.openEclipticPalaceFrame)
         {
            return false;
         }
         if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            return false;
         }
         return true;
      }
      
      private function __consortiaBossCountHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         playerInfo.consortiaBossCount = _loc2_.param1;
      }
      
      private function __godsEveningReportHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = SwitchPageHelp.returnScene;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,_loc3_,godsEveningReportCall);
      }
      
      private function godsEveningReportCall(param1:PackageIn) : void
      {
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:GERankItemPersonData = null;
         var _loc14_:GERankItemServerData = null;
         var _loc2_:CrossGodsMsg = new CrossGodsMsg();
         _loc2_ = param1.readBody(_loc2_) as CrossGodsMsg;
         var _loc15_:int = _loc2_.gameType;
         var _loc10_:int = Int64Utils.int64ToNumber(_loc2_.param1);
         var _loc12_:Dictionary = new Dictionary();
         var _loc3_:Dictionary = new Dictionary();
         if(_loc15_ == 1)
         {
            if(_loc2_.myInfo)
            {
               _loc9_ = _loc2_.myInfo.readyOrder;
               _loc8_ = _loc2_.myInfo.readyScore;
            }
            for each(var _loc5_:GodsPlayerInfoMsg in _loc2_.playerInfo)
            {
               _loc4_ = new GERankItemPersonData();
               _loc4_.rank = _loc5_.readyOrder;
               _loc4_.nickName = _loc5_.nickName;
               _loc4_.serverName = _loc5_.serverName;
               _loc4_.fightPower = _loc5_.fightPower;
               _loc4_.score = _loc5_.readyScore;
               _loc12_[_loc4_.rank] = _loc4_;
            }
            for each(var _loc13_:CrossGodsInfoMsg in _loc2_.info)
            {
               _loc14_ = new GERankItemServerData();
               _loc14_.rank = _loc13_.readyOrder;
               _loc14_.serverName = _loc13_.serverName;
               _loc14_.fightPower = _loc13_.fightPower;
               _loc14_.score = _loc13_.readyScore;
               _loc14_.teamId = _loc13_.teamId;
               _loc3_[_loc14_.rank] = _loc14_;
            }
         }
         else if(_loc15_ == 2)
         {
            if(_loc2_.myInfo)
            {
               _loc9_ = _loc2_.myInfo.finalOrder;
               _loc8_ = _loc2_.myInfo.finalScore;
            }
            for each(var _loc7_:GodsPlayerInfoMsg in _loc2_.playerInfo)
            {
               _loc4_ = new GERankItemPersonData();
               _loc4_.rank = _loc7_.finalOrder;
               _loc4_.nickName = _loc7_.nickName;
               _loc4_.serverName = _loc7_.serverName;
               _loc4_.fightPower = _loc7_.fightPower;
               _loc4_.score = _loc7_.finalScore;
               _loc12_[_loc4_.rank] = _loc4_;
            }
            for each(var _loc11_:CrossGodsInfoMsg in _loc2_.info)
            {
               _loc14_ = new GERankItemServerData();
               _loc14_.rank = _loc11_.finalOrder;
               _loc14_.serverName = _loc11_.serverName;
               _loc14_.fightPower = _loc11_.fightPower;
               _loc14_.score = _loc11_.finalScore;
               _loc14_.teamId = _loc11_.teamId;
               _loc3_[_loc14_.rank] = _loc14_;
            }
         }
         var _loc6_:Object = {
            "myRank":_loc9_,
            "myScore":_loc8_,
            "personRankDic":_loc12_,
            "serverRankDic":_loc3_,
            "myServerRank":_loc10_
         };
         FrameControllerManager.instance.openControllerByInfo("godsevening",3,_loc6_);
      }
      
      private function __CCActiveOpenStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         var _loc3_:Boolean = false;
         switch(_loc2_.param1 - 27)
         {
            case 0:
               PumpingJoyManager.instance.model.isOpen = _loc2_.param7;
               _loc3_ = true;
         }
         if(_loc3_)
         {
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function __unrealShootingReportHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:UnrealShootingMsg = new UnrealShootingMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as UnrealShootingMsg;
         var _loc4_:String = SwitchPageHelp.returnScene;
         if(_loc2_.gameState == -1)
         {
            SwitchPageHelp.returnToSpace();
         }
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc3_,_loc4_,unrealShootingReportCall);
      }
      
      private function unrealShootingReportCall(param1:PackageIn) : void
      {
         var _loc8_:* = null;
         var _loc4_:UnrealShootingUserInfo = null;
         var _loc3_:UnrealShootingUserInfo = null;
         var _loc2_:UnrealShootingMsg = new UnrealShootingMsg();
         _loc2_ = param1.readBody(_loc2_) as UnrealShootingMsg;
         var _loc9_:Boolean = false;
         if(_loc2_.gameState == -1)
         {
            _loc9_ = true;
         }
         var _loc7_:Array = [];
         for each(_loc8_ in _loc2_.list)
         {
            _loc4_ = new UnrealShootingUserInfo();
            _loc4_.uuid = _loc8_.uuid;
            _loc4_.userId = _loc8_.userId;
            _loc4_.rank = _loc8_.rank;
            _loc4_.nickName = _loc8_.nickName;
            _loc4_.serverName = _loc8_.serverName;
            _loc4_.score = _loc8_.score;
            _loc4_.fightPower = _loc8_.fightPower;
            _loc4_.templateId = _loc8_.templateId;
            _loc4_.killNum = _loc8_.killNum;
            _loc4_.param1 = _loc8_.param1;
            _loc4_.team = _loc8_.team;
            _loc4_.itemCount = _loc8_.itemCount;
            _loc4_.isOnHook = _loc8_.isOnHook;
            _loc4_.isAbend = _loc9_;
            _loc7_.push(_loc4_);
            if(playerInfo.serviceName == _loc8_.serverName && playerInfo.userId == _loc8_.userId)
            {
               _loc3_ = new UnrealShootingUserInfo();
               _loc3_.uuid = _loc8_.uuid;
               _loc3_.userId = _loc8_.userId;
               _loc3_.rank = _loc8_.rank;
               _loc3_.nickName = _loc8_.nickName;
               _loc3_.serverName = _loc8_.serverName;
               _loc3_.score = _loc8_.score;
               _loc3_.fightPower = _loc8_.fightPower;
               _loc3_.templateId = _loc8_.templateId;
               _loc3_.killNum = _loc8_.killNum;
               _loc3_.param1 = _loc8_.param1;
               _loc3_.team = _loc8_.team;
               _loc3_.itemCount = _loc8_.itemCount;
               _loc3_.isOnHook = _loc8_.isOnHook;
               _loc3_.isAbend = _loc9_;
            }
         }
         _loc7_.sort(sortUnrealShootingUserInfoByRank);
         var _loc5_:Array = _loc2_.param3.split("|");
         _unrealShootingReportData = {
            "list":_loc7_,
            "reward":_loc5_,
            "myRankInfo":_loc3_
         };
         var _loc10_:String = ComponentSetting.getProjectSourcePath("3.png");
         var _loc6_:String = "map.campaign.view.ui.unrealshooting.UnrealShootingGameOverFrame";
         if(!DisplayLoader.Context.applicationDomain.hasDefinition(_loc6_))
         {
            LoaderManagerII.instance.load(_loc10_,3,0,__onloadAllComplete);
         }
         else
         {
            __onloadAllComplete(null,null);
         }
      }
      
      private function __onloadAllComplete(param1:LoaderInfo, param2:Object) : void
      {
         FrameControllerManager.instance.openControllerByInfo("unrealshooting",2,_unrealShootingReportData);
      }
      
      private function sortUnrealShootingUserInfoByRank(param1:UnrealShootingUserInfo, param2:UnrealShootingUserInfo) : int
      {
         if(param1.rank < param2.rank)
         {
            return -1;
         }
         if(param1.rank > param2.rank)
         {
            return 1;
         }
         return 0;
      }
      
      private function __spacetimeFaultFightTimeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.hasParam4)
         {
            playerInfo.spaceTimeBoxTimeStart = _loc2_.param4;
         }
      }
      
      private function __raceAgainstTimeUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.hasParam4)
         {
            playerInfo.raceAgainstTimeStart = _loc2_.param4;
         }
      }
      
      private function _reciveSpaceInfoHander(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.hasParam4)
         {
            playerInfo.spacetimePassHistory = _loc2_.param4;
         }
         if(_loc2_.hasParam7)
         {
            playerInfo.hasSpaceTimeReward = _loc2_.param7;
         }
         if(_loc2_.hasParam2 && _loc2_.param2 == 1)
         {
            DelayActionsUtils.instance.addAction(new AlertTipAction(null,spaceTimeReport,"PVE_ROOM_SCENE"));
         }
      }
      
      private function spaceTimeReport(param1:Object = null) : void
      {
         FrameControllerManager.instance.openControllerByInfo("spacetimefault");
      }
      
      private function __reFreshBuffer(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         wasteBossBufferIdByHero = _loc2_.param4;
         wasteBossBufferIdByBoss = _loc2_.param5;
      }
      
      private function __updateInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ExtraFieldInfoMsg = null;
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerExtraFieldMsg = new PlayerExtraFieldMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlayerExtraFieldMsg;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.extraField.length)
         {
            _loc5_ = _loc2_.extraField[_loc3_];
            if(_loc5_.fieldId == 1)
            {
               RegistWelfareManager.instance.endDate = DateFormatter.parse(_loc5_.value,"YYYY-MM-DD hh:mm:ss");
            }
            else if(_loc5_.fieldId == 2)
            {
               RegistWelfareManager.instance.stone = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 3)
            {
               RegistWelfareManager.instance.fashion = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 4)
            {
               RegistWelfareManager.instance.mount = int(_loc5_.value);
            }
            if(_loc5_.fieldId == 6)
            {
               PokerManager.instance.pokerCash = int(_loc5_.value);
               PlayerManager.instance.currentPlayerModel.playerInfo.pokerCorn = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 7)
            {
               PokerManager.instance.pokerScore = int(_loc5_.value);
               PlayerManager.instance.currentPlayerModel.playerInfo.pokerScore = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 8)
            {
               ArchaeologyManager.instance.model.exp = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 9)
            {
               ArchaeologyManager.instance.model.hasExplorationCount = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 12)
            {
               PerkinLabManager.instance.model.victoryCount = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 13)
            {
               ChildPatrolManager.instance.model.hasHelpCount = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 14)
            {
               OutyardManager.instance.model.reward = _loc5_.value;
            }
            else if(_loc5_.fieldId == 15)
            {
               OutyardManager.instance.areaModel.exploreNum = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 16)
            {
               ExchangeBoxManager.instance.model.fashionHasBuy = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 17)
            {
               ExchangeBoxManager.instance.model.hotFashionHasBuy = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 18)
            {
               ExchangeBoxManager.instance.model.mountHasBuy = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 19)
            {
               ExchangeBoxManager.instance.model.hotMountHasBuy = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 20)
            {
               PerkinLabManager.instance.model.curExp = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 21)
            {
               FrameControllerManager.instance.guildFbController.model.currFightNum = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 22)
            {
               GameHallManager.instance.model.fixedGroupRewardCount = int(_loc5_.value);
            }
            else if(_loc5_.fieldId == 23)
            {
               ArchaeologyManager.instance.model.hasBuyExplorCount = int(_loc5_.value);
            }
            _loc3_++;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("PLAYER_EXTRA_FIELD"));
      }
      
      private function __pvpTimerHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TimerInfoListMsg = new TimerInfoListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TimerInfoListMsg;
         for each(_loc3_ in _loc2_.timerInfo)
         {
            if(_loc3_.type == 1)
            {
               FrameControllerManager.instance.steelController.model.initTimerInfo(_loc3_);
            }
            else if(_loc3_.type == 3)
            {
               FrameControllerManager.instance.svsController.model.initTimerInfo(_loc3_);
            }
         }
      }
      
      private function __medalInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MedalInfoMsg = new MedalInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MedalInfoMsg;
         thane.beginChanges();
         thane.medalGrades = _loc2_.grade;
         thane.medalGp = Int64Utils.int64ToNumber(_loc2_.gp);
         thane.medalInvalidTime = DateFormatter.parse(_loc2_.invalidTime,"YYYY-MM-DD hh:mm:ss").getTime() / 1000;
         thane.commit();
      }
      
      private function __medalOpHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MedalOpMsg = new MedalOpMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MedalOpMsg;
         if(_loc2_.result != 0)
         {
            if(_loc2_.result == 1)
            {
            }
         }
      }
      
      private function __rentalBagResHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RentalBagOpResMsg = new RentalBagOpResMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RentalBagOpResMsg;
         playerInfo.beginChanges();
         if(_loc2_.hasRentalBagTime)
         {
            playerInfo.rentalBagTime = _loc2_.rentalBagTime;
         }
         if(_loc2_.hasStatus)
         {
            playerInfo.rentalBagStatus = _loc2_.status;
         }
         playerInfo.commit();
      }
      
      private function __showQuizHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AnswerQuestionMsg = new AnswerQuestionMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AnswerQuestionMsg;
         if(_loc2_.isOpen)
         {
            GlobalConfig.isQuizOpen = true;
         }
         else
         {
            GlobalConfig.isQuizOpen = false;
         }
         MsgMan.notifyObserver("yishi.datas.consant.GET_QUESTION_IS_OPNE_EVENT");
      }
      
      private function __petBossSwitchHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PetIslandDefendStateMsg = new PetIslandDefendStateMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PetIslandDefendStateMsg;
         var _loc3_:PetBossModel = CampaignManager.instance.petBossModel;
         _loc3_.mapId = _loc2_.mapId;
         _loc3_.isOpen = _loc2_.mapId != 0 ? true : false;
         _loc3_.leftTime = Int64Utils.int64ToNumber(_loc2_.leftTime);
         _loc3_.heroId = _loc2_.bossId;
         if(_loc2_.hasPeaceMiddle && _loc2_.hasPeaceHigh && _loc2_.hasPeaceBoss)
         {
            _loc3_.countArr = [_loc2_.peaceMiddle,_loc2_.peaceHigh,_loc2_.peaceBoss];
         }
         _loc3_.currentRagePoint = _loc2_.ragePoint;
         var _loc4_:int = _loc3_.isOpen ? 1 : 0;
         InfoTipsManager.instance.updateValue(18,_loc4_);
         if(!_loc3_.isOpen)
         {
            TaskTraceTipManager.instance.cleanByType(42);
         }
         else if(ArmyManager.instance.thane.grades >= 50 && petBossMapId != _loc3_.mapId)
         {
            DelayActionsUtils.instance.addAction(new AlertTipAction("",__petBossOpenHandler));
         }
         MsgMan.notifyObserver("CampaignEvent.PET_BOSS_SWITCH",null);
         petBossMapId = _loc3_.mapId;
      }
      
      private function __crossMutiStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         playerInfo.isOpenCrossMutiCampaign = _loc2_.param7;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      private function __petBossOpenHandler(param1:String) : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.type = 42;
         _loc2_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
         _loc2_.content = LanguageMgr.GetTranslation("yishi.manager.BaseManager.PetBossIsOpen");
         TaskTraceTipManager.instance.cleanByType(42);
         TaskTraceTipManager.instance.showView(_loc2_);
      }
      
      private function __vipCustomNotifyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:TipMessageData = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         _loc2_.param1;
         _loc2_.param4;
         _loc2_.param5;
         if(_loc2_.param1 == 1)
         {
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.VIPCustomTipView.QQTips",_loc2_.param4,_loc2_.param5);
            _loc5_ = new TipMessageData();
            _loc5_.type = 39;
            _loc5_.title = _loc2_.param4;
            _loc5_.content = _loc4_;
            TaskTraceTipManager.instance.showView(_loc5_);
         }
         else
         {
            TaskTraceTipManager.instance.cleanByType(39);
         }
      }
      
      private function confirmBack(param1:Boolean, param2:Boolean, param3:RoomInfo) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(param1)
         {
            if(isInCampaign)
            {
               isInCampaign = false;
               _loc4_ = LanguageMgr.GetTranslation("public.confirm");
               _loc5_ = LanguageMgr.GetTranslation("public.cancel");
               _loc6_ = LanguageMgr.GetTranslation("public.prompt");
               _loc7_ = LanguageMgr.GetTranslation("chat.view.ChatView.EnterCampaignTips");
               SimpleAlertHelper.instance.data = [confirmBack,param3];
               if(getIsOver(param3.mapTemplate))
               {
                  SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc4_,_loc5_,true,true,false);
               }
               else
               {
                  SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc4_,_loc5_,true,true,false,2,"CHATINVIE_ALERT",190,"",null,"SimpleAlert",{"income":param2});
               }
            }
            else
            {
               RoomListSocketOutManager.addRoomById(0,param3.id,"",true,!param2);
            }
         }
      }
      
      private function __mulityCampaignRequestHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:String = null;
         var _loc6_:CampaignTemplate = null;
         isActivity = false;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as PropertyMsg;
         var _loc11_:RoomInfo = new RoomInfo();
         _loc11_.id = _loc2_.param1;
         if(_loc2_.hasParam2)
         {
            _loc11_.campaignId = _loc2_.param2;
         }
         isInCampaign = _loc2_.param7;
         var _loc5_:String = "";
         if(_loc11_.campaignId == 0)
         {
            _loc7_ = LanguageMgr.GetTranslation("chat.view.ChatView.NullMap");
         }
         else
         {
            _loc6_ = _loc11_.mapTemplate ? _loc11_.mapTemplate : CampaignManager.instance.mapModel.campaignTemplate;
            if(_loc6_.SonTypes != 0)
            {
               isActivity = true;
               _loc5_ = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.difficultyGrade3");
            }
            else if(_loc11_.mapTemplate.DifficultyGrade == 1)
            {
               _loc5_ = LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.difficultyGrade1");
            }
            if(_loc5_)
            {
               _loc5_ = LanguageMgr.GetTranslation("public.parentheses1",_loc5_);
            }
            _loc7_ = _loc6_.CampaignName + _loc5_;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc9_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc10_:String = LanguageMgr.GetTranslation("chat.view.ChatView.EnterRoomTips",_loc7_,_loc11_.id);
         if(_loc2_.hasParam6 && !(_loc6_.isTrailTower || _loc6_.isFantasyMatrix))
         {
            if(int(_loc2_.param6) == -1)
            {
               _loc10_ += "\n" + LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum2");
            }
            else
            {
               _loc10_ += "\n" + LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum",_loc2_.param6);
            }
         }
         SimpleAlertHelper.instance.data = [confirmBack,_loc11_];
         if(getIsOver(_loc6_))
         {
            SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc10_,_loc3_,_loc4_,true,true,false);
         }
         else
         {
            SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc10_,_loc3_,_loc4_,true,true,false,2,"CHATINVIE_ALERT",190);
         }
      }
      
      private function getIsOver(param1:CampaignTemplate) : Boolean
      {
         var _loc2_:ConfigInfosTempInfo = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(!param1)
         {
            return true;
         }
         var _loc3_:Boolean = false;
         var _loc4_:CampaignTemplate = param1;
         if(_loc4_.isTrailTower)
         {
            _loc3_ = playerInfo.isTrailOverMaxCount;
         }
         else if(_loc4_.isBloodyPandemoniue)
         {
            _loc2_ = TempleteManager.instance.getConfigInfoByConfigName("Random_Boss_Count");
            _loc6_ = int(_loc2_.ConfigValue);
            _loc5_ = _loc6_ - PlayerManager.instance.currentPlayerModel.playerInfo.randomBossCount;
            _loc3_ = _loc5_ <= 0 ? true : false;
         }
         else if(_loc4_.isMolongCampaign)
         {
            _loc3_ = playerInfo.molongRestNum <= 0 ? true : false;
         }
         else if(_loc4_.isNaLan)
         {
            _loc3_ = playerInfo.teamCount <= 0 ? true : false;
         }
         else if(_loc4_.isTaila)
         {
            _loc3_ = playerInfo.tailaCount <= 0 ? true : false;
         }
         else if(_loc4_.isWasteCampaign)
         {
            _loc3_ = playerInfo.wasteCount <= 0 ? true : false;
         }
         else if(_loc4_.isFantasyMatrix)
         {
            _loc3_ = playerInfo.fantasyMatrixRestNum <= 0 ? true : false;
         }
         else if(_loc4_.isChildWarCampaign)
         {
            _loc3_ = playerInfo.childWarCount <= 0 ? true : false;
         }
         else if(_loc4_.isDeepPrison)
         {
            _loc3_ = playerInfo.deepPrisonCount <= 0 ? true : false;
         }
         else if(_loc4_.isDarkKing)
         {
            _loc3_ = playerInfo.darkKIngLeftCount <= 0 ? true : false;
         }
         else if(_loc4_.isRaceAgainstTime)
         {
            _loc3_ = playerInfo.raceAgainstTimeLeftCount <= 0 ? true : false;
         }
         else if(_loc4_.isForest)
         {
            _loc3_ = playerInfo.elementSilvaLeftCount <= 0 ? true : false;
         }
         else if(_loc4_.isSkyStepCampaign)
         {
            _loc3_ = playerInfo.skyStepCount <= 0 ? true : false;
         }
         else
         {
            _loc3_ = playerInfo.multiCopyCount <= 0 ? true : false;
         }
         return _loc3_;
      }
      
      private function __reloadAgentDirtyHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:String = PathManager.AgentZhanPath;
         LoaderManagerII.instance.load(_loc2_,7,8,onAgentDirtyLoadComplete);
      }
      
      private function onAgentDirtyLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         AgentFilterManager.Instance.setup(String(param2));
      }
      
      private function __petRankRewardHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PetRankRewardMsg = new PetRankRewardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PetRankRewardMsg;
         if(_loc2_.status == 0)
         {
            if(_loc2_.type == 2)
            {
               playerInfo.canAcceptPetChallWeekReward = true;
            }
         }
      }
      
      private function __vipMountStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:TipMessageData = null;
         if(ArmyManager.instance.thane.grades < 16)
         {
            return;
         }
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param7 == true)
         {
            _loc3_ = new TipMessageData();
            _loc3_.type = 34;
            _loc3_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
            TaskTraceTipManager.instance.showView(_loc3_);
            MountsManager.instance.requestWildSoulList();
         }
         else
         {
            _loc3_ = new TipMessageData();
            _loc3_.type = 35;
            _loc3_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
            TaskTraceTipManager.instance.showView(_loc3_);
         }
      }
      
      private function __createSpaceHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomEnterMsg = new RoomEnterMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RoomEnterMsg;
         var _loc3_:RoomPlayerMsg = _loc2_.player[0] as RoomPlayerMsg;
         _loc3_.campaignId = 10000;
         if(_loc3_.playerId != ArmyManager.instance.army.userId)
         {
            return;
         }
         if(SpaceManager.instance.exit)
         {
            SpaceManager.instance.dispose();
         }
         SpaceManager.instance.setup(_loc3_.campaignId);
         PlayerManager.instance.currentPlayerModel.spaceMapId = _loc3_.campaignId;
         SpaceTemplateManager.instance.setup();
         SpaceManager.instance.model.mapNodesData = SpaceTemplateManager.instance.nodeDic[_loc3_.campaignId];
         SocketDataProxyManager.instance.addCreateSceneQueue(_loc4_,"SPACE_SCENE",param1.type,false);
         SpaceManager.instance.readMember(_loc3_);
         if(SwitchPageHelp.isEnterSpaceNow())
         {
            SceneManager.instance.setScene("SPACE_SCENE",{"isShowLoading":false},true);
            log({},"__createSpaceHandler.setScene");
         }
         log({},"__createSpaceHandler");
      }
      
      private function __returnSpaceHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomEnterMsg = new RoomEnterMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RoomEnterMsg;
         var _loc3_:RoomPlayerMsg = _loc2_.player[0] as RoomPlayerMsg;
         if(_loc3_.playerId != ArmyManager.instance.army.userId)
         {
            return;
         }
         if(!SpaceManager.instance.model)
         {
            SpaceManager.instance.dispose();
            SpaceManager.instance.setup(_loc3_.campaignId);
            PlayerManager.instance.currentPlayerModel.spaceMapId = _loc3_.campaignId;
            SpaceTemplateManager.instance.setup();
            SpaceManager.instance.model.mapNodesData = SpaceTemplateManager.instance.nodeDic[_loc3_.campaignId];
            SocketDataProxyManager.instance.addCreateSceneQueue(_loc4_,"SPACE_SCENE",param1.type,false);
         }
         SpaceManager.instance.readMember(_loc3_);
         if(SceneManager.instance.currentType != "SPACE_SCENE")
         {
            if(SceneManager.instance.currentType == "BATTLE_SCENE" && BattleManager.getInstance().battleModel.battleType == 16)
            {
               return;
            }
            SceneManager.instance.setScene("SPACE_SCENE",{"isShowLoading":false},true);
         }
      }
      
      private function __warFightRemainNumber(param1:SLGSocketEvent) : void
      {
         var confirm:String;
         var cancel:String;
         var prompt:String;
         var content:String;
         var e:SLGSocketEvent = param1;
         var pkg:PackageIn = e.data as PackageIn;
         var msg:CampaignReqMsg = new CampaignReqMsg();
         msg = pkg.readBody(msg) as CampaignReqMsg;
         var enter:Function = function(param1:Boolean, param2:Boolean = false):void
         {
            var _loc3_:PackageOut = null;
            var _loc4_:WorldBossMsg = null;
            if(param1)
            {
               _loc3_ = new PackageOut(8332);
               _loc4_ = new WorldBossMsg();
               _loc4_.param1 = msg.paraInt1;
               SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc4_);
            }
         };
         if(!msg.paraBool1)
         {
            confirm = LanguageMgr.GetTranslation("public.confirm");
            cancel = LanguageMgr.GetTranslation("public.cancel");
            prompt = LanguageMgr.GetTranslation("public.prompt");
            content = LanguageMgr.GetTranslation("pvpselectFrame.enterwarTip");
            if(playerInfo.vocationGrades > 0)
            {
               content = LanguageMgr.GetTranslation("pvpselectFrame.enterwarTip2");
            }
            SimpleAlertHelper.instance.data = [enter];
            SimpleAlertHelper.instance.popAlerFrame(prompt,content,confirm,cancel);
         }
         else
         {
            enter(true);
         }
      }
      
      private function __forceQuitBattleCampaign(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         DelayActionsUtils.instance.addAction(new AlertTipAction(_loc2_.param1,quitBattleCampaignReport));
      }
      
      private function quitBattleCampaignReport(param1:int) : void
      {
         var _loc2_:String = null;
         SimpleAlertHelper.instance.data = [];
         if(param1 == 3)
         {
            GodsEveningManager.instance.model.isForceQuit = true;
            _loc2_ = LanguageMgr.GetTranslation("godsEvening.forceQuit.tip1");
         }
         else if(param1 == 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("BaseManager.forceQuitBattleCampaign");
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("BaseManager.forceQuitBattleCampaignVocationBattle");
         }
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc2_,_loc3_,"",false,true,true,2,"SIMPLE_ALERT",160);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __requestHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MatchStateMsg = new MatchStateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MatchStateMsg;
         playerInfo.beginChanges();
         playerInfo.isPVPStart = _loc2_.matchState;
         playerInfo.commit();
      }
      
      private function __getWorldProsperityHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         playerInfo.beginChanges();
         playerInfo.worldProsperity = _loc2_.param1;
         playerInfo.commit();
      }
      
      private function __switchesUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SwitchInfoListMsg = new SwitchInfoListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SwitchInfoListMsg;
         for each(var _loc3_:SwitchInfoMsg in _loc2_.switches)
         {
            switch(_loc3_.switchType)
            {
               case 1:
                  ConfigManager.info.CLIENT_DOWNLAND = _loc3_.isOpen;
                  if(ConfigManager.info.CLIENT_DOWNLAND)
                  {
                     TaskManage.instance.clientDownSwitchHandler();
                  }
                  break;
               case 2:
                  ConfigManager.info.MOBILE_TASK = _loc3_.isOpen;
                  if(ConfigManager.info.MOBILE_TASK)
                  {
                     TaskManage.instance.mobileSwitchHandler();
                  }
                  break;
               case 3:
                  ConfigManager.info.CUSTOMER_SERVICE = _loc3_.isOpen;
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("CUSTOMER_SERVICE_SWITCH",_loc3_.isOpen));
                  break;
               case 11:
                  ConfigManager.info.VOICE = _loc3_.isOpen;
                  break;
               case 13:
                  ConfigManager.info.AAS = _loc3_.isOpen;
                  if(ConfigManager.info.AAS && PlayerManager.instance.currentPlayerModel.isInAAS && userInfo.site.indexOf("kxin") >= 0)
                  {
                     setKaiXinAAS();
                  }
                  NotificationManager.instance.sendNotification("UPDATE_AAS_CONFIG");
                  break;
               case 14:
                  ConfigManager.info.SECURITY_CODE = _loc3_.isOpen;
                  break;
               case 15:
                  ConfigManager.info.BEHAVIOR_ANALYSIS = _loc3_.isOpen;
                  break;
               case 127:
                  ConfigManager.info.ANSWER_SYSTEM = _loc3_.isOpen;
                  break;
               case 1001:
                  ConfigManager.info.FACE_BOOK = _loc3_.isOpen;
                  SmallMapBar.instance.checkFaceBookBtn();
                  break;
               case 2003:
                  PlayerManager.instance.currentPlayerModel.tiroActStarTime = _loc3_.beginDate;
                  PlayerManager.instance.currentPlayerModel.tiroActEndTime = _loc3_.endDate;
                  break;
               case 2005:
                  if(NewYearActManager.instance.loginModel)
                  {
                     NewYearActManager.instance.loginModel.isSwitch = _loc3_.isOpen;
                     NewYearActManager.instance.loginModel.starTime = _loc3_.beginDate;
                     NewYearActManager.instance.loginModel.endTime = _loc3_.endDate;
                  }
                  break;
               case 2007:
                  BirthdayManager.instance.setBirthdaySwitch(_loc3_.isOpen,_loc3_.beginDate,_loc3_.endDate);
                  break;
               case 3031:
                  ConfigManager.info.GOLDROAD = _loc3_.isOpen;
                  ConfigManager.info.GOLDROAD_BEGIN_DATE = DateFormatter.parse(_loc3_.beginDate,"YYYY-MM-DD hh:mm:ss");
                  ConfigManager.info.GOLDROAD_END_DATE = DateFormatter.parse(_loc3_.endDate,"YYYY-MM-DD hh:mm:ss");
                  NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
                  break;
               case 3060:
                  ConfigManager.info.BLACKJACK = _loc3_.isOpen;
                  ConfigManager.info.BLACKJACK_BEGIN_DATE = DateFormatter.parse(_loc3_.beginDate,"YYYY-MM-DD hh:mm:ss");
                  ConfigManager.info.BLACKJACK_END_DATE = DateFormatter.parse(_loc3_.endDate,"YYYY-MM-DD hh:mm:ss");
                  NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
                  break;
               case 3064:
                  ConfigManager.info.NEW_YEAR_MODULE = _loc3_.isOpen;
                  ConfigManager.info.NEW_YEAR_BEGIN_DATE = DateFormatter.parse(_loc3_.beginDate,"YYYY-MM-DD hh:mm:ss");
                  ConfigManager.info.NEW_YEAR_END_DATE = DateFormatter.parse(_loc3_.endDate,"YYYY-MM-DD hh:mm:ss");
                  _loc4_ = checkIsOpen(ConfigManager.info.NEW_YEAR_MODULE,ConfigManager.info.NEW_YEAR_BEGIN_DATE,ConfigManager.info.NEW_YEAR_END_DATE);
                  NotificationManager.instance.sendNotification("SPACE_NPC_VISIBLE",[32,_loc4_]);
                  break;
               case 3068:
                  ConfigManager.info.BINGO = _loc3_.isOpen;
                  ConfigManager.info.BINGO_BEGIN_DATE = DateFormatter.parse(_loc3_.beginDate,"YYYY-MM-DD hh:mm:ss");
                  ConfigManager.info.BINGO_END_DATE = DateFormatter.parse(_loc3_.endDate,"YYYY-MM-DD hh:mm:ss");
                  NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
                  break;
               case 3069:
                  ConfigManager.info.ASSAULTWAR = _loc3_.isOpen;
                  NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
                  break;
               case 3066:
                  ConfigManager.info.MAIL_CHECK = _loc3_.isOpen;
                  NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
                  break;
               case 223:
                  ConfigManager.info.FORBIT_CHAT = _loc3_.isOpen;
                  ChatManager.instance.model.beginTime = DateFormatter.parse(_loc3_.beginDate,"YYYY-MM-DD hh:mm:ss");
                  ChatManager.instance.model.endTime = DateFormatter.parse(_loc3_.endDate,"YYYY-MM-DD hh:mm:ss");
                  break;
               case 3073:
                  ConfigManager.info.SQ_MEMORY = _loc3_.isOpen;
                  ConfigManager.info.SQ_MEMORY_START = DateFormatter.parse(_loc3_.beginDate,"YYYY-MM-DD hh:mm:ss");
                  ConfigManager.info.SQ_MEMORY_END = DateFormatter.parse(_loc3_.endDate,"YYYY-MM-DD hh:mm:ss");
                  NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
            }
         }
      }
      
      private function checkIsOpen(param1:Boolean, param2:Date, param3:Date) : Boolean
      {
         if(ConfigManager.info.NEW_YEAR_MODULE && ConfigManager.info.NEW_YEAR_BEGIN_DATE && ConfigManager.info.NEW_YEAR_END_DATE && ConfigManager.info.NEW_YEAR_BEGIN_DATE.time <= playerModel.nowDate && ConfigManager.info.NEW_YEAR_END_DATE.time > playerModel.nowDate)
         {
            return true;
         }
         return false;
      }
      
      public function checkIsNeedShow() : Array
      {
         var _loc2_:Boolean = false;
         var _loc4_:Array = [];
         var _loc3_:int = 32;
         if(ConfigManager.info.NEW_YEAR_MODULE && ConfigManager.info.NEW_YEAR_BEGIN_DATE && ConfigManager.info.NEW_YEAR_END_DATE && ConfigManager.info.NEW_YEAR_BEGIN_DATE.time <= playerModel.nowDate && ConfigManager.info.NEW_YEAR_END_DATE.time > playerModel.nowDate)
         {
            _loc2_ = true;
         }
         _loc4_.push([_loc3_,_loc2_]);
         var _loc1_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         _loc3_ = 35;
         _loc2_ = _loc1_ && (_loc1_.stackHeadState != 3 && _loc1_.hugeHeadState != 3);
         _loc4_.push([_loc3_,_loc2_]);
         _loc3_ = 36;
         _loc2_ = _loc1_ && (_loc1_.stackHeadState == 3 || _loc1_.hugeHeadState == 3);
         _loc4_.push([_loc3_,_loc2_]);
         return _loc4_;
      }
      
      private function myUrlEncode(param1:String, param2:String) : String
      {
         var _loc4_:int = 0;
         var _loc5_:String = "";
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,param2);
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ += escape(String.fromCharCode(_loc3_[_loc4_]));
            _loc4_++;
         }
         _loc3_.clear();
         return _loc5_;
      }
      
      private function setKaiXinAAS() : void
      {
         if(PathManager.info.AASRequestPath == null || PathManager.info.AASRequestPath == "")
         {
            return;
         }
         var _loc3_:String = "aid=5218&ts=" + playerModel.sysCurTimeBySecond + "&uid=" + userInfo.user + "&ver=1" + "&" + "9I2lX78U4$Kd%OaBs#aQMJ";
         var _loc4_:String = PathManager.info.AASRequestPath + "?uid=" + userInfo.user + "&aid=5218" + "&ts=" + playerModel.sysCurTimeBySecond + "&ver=1" + "&sign=" + MD5.hash(_loc3_);
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["url"] = myUrlEncode(_loc4_,"UTF-8");
         var _loc2_:String = PathManager.info.REQUEST_PATH + "kaxinaasservlet";
         LoaderManagerII.instance.load(_loc2_,7,8,__onGetResultCompleted,null,null,null,_loc1_,"POST");
      }
      
      private function __onGetResultCompleted(param1:LoaderInfo, param2:Object) : void
      {
         var _loc6_:PackageOut = null;
         var _loc4_:PlayerAASRefreshMsg = null;
         LoggerSys.info("开心网用户防沉迷信息返回：JSON--->>>" + param2);
         var _loc3_:Object = JSON.parse(param2.toString());
         if(_loc3_ == null)
         {
            return;
         }
         var _loc5_:Boolean = _loc3_["v_idchecked"] == 1;
         var _loc7_:Boolean = _loc3_["v_agechecked"] == 1;
         if(_loc5_ && _loc7_)
         {
            SocketManager.instance.addEventListener("SLGSocketEvent" + 4172,__changeHandler);
            _loc6_ = new PackageOut(8620);
            _loc4_ = new PlayerAASRefreshMsg();
            _loc4_.isCloseAAS = true;
            SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc4_);
         }
      }
      
      private function __changeHandler(param1:SLGSocketEvent) : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4172,__changeHandler);
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerAASRspMsg = new PlayerAASRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlayerAASRspMsg;
         if(_loc2_.result)
         {
            if(_loc2_.age >= 18)
            {
               ResourcesBar.instance.closeIndulgeView();
               PlayerManager.instance.currentPlayerModel.isInAAS = false;
            }
         }
      }
      
      private function __securityCodeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CheckImageMsg = new CheckImageMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CheckImageMsg;
         FrameControllerManager.instance.securityCodeController.model.byteArr_1 = _loc2_.images1;
         FrameControllerManager.instance.securityCodeController.model.byteArr_2 = _loc2_.images2;
         FrameControllerManager.instance.securityCodeController.model.byteArr_3 = _loc2_.images3;
         FrameControllerManager.instance.securityCodeController.model.byteArr_4 = _loc2_.images4;
         FrameControllerManager.instance.securityCodeController.model.remainTime = _loc2_.leftTime;
         FrameControllerManager.instance.securityCodeController.model.remainCount = _loc2_.leftCount;
         FrameControllerManager.instance.openControllerByInfo("securitycode");
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function __setSoundOffHandler(param1:Event) : void
      {
         if(SharedManager.instance.allowMusic == false && SharedManager.instance.allowSound == false)
         {
            return;
         }
         isMusicOn = false;
         isSoundOn = false;
         SharedManager.instance.allowMusic = false;
         SharedManager.instance.allowSound = false;
         SharedManager.instance.save();
      }
      
      private function __setSoundOnHandler(param1:Event) : void
      {
         if(!isMusicOn && !isSoundOn)
         {
            isMusicOn = isSoundOn = true;
         }
         if(SharedManager.instance.allowMusic == isMusicOn && SharedManager.instance.allowSound == isSoundOn)
         {
            return;
         }
         SharedManager.instance.allowMusic = isMusicOn;
         SharedManager.instance.allowSound = isSoundOn;
         SharedManager.instance.save();
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         JsHelper.isSelfAdapting = true;
      }
      
      private function __stageClickHandler(param1:MouseEvent) : void
      {
         if(DragManager.getInstance().isDraging)
         {
            param1.stopPropagation();
         }
      }
      
      private function __worldBossLoadHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:WorldBossInfoLoadMsg = new WorldBossInfoLoadMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as WorldBossInfoLoadMsg;
         var _loc4_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _loc4_ = _loc4_ % 4;
         var _loc3_:Boolean = false;
         if(_loc2_.leftTime >= 14 && _loc4_ == 0)
         {
            _loc3_ = true;
         }
         else if(_loc2_.leftTime >= 9 && _loc2_.leftTime < 14 && _loc4_ == 1)
         {
            _loc3_ = true;
         }
         else if(_loc2_.leftTime >= 5 && _loc2_.leftTime < 9 && _loc4_ == 2)
         {
            _loc3_ = true;
         }
         if(_loc3_ && thane.grades >= 20)
         {
            new PreLoadWorldBoss(_loc2_.campaignId,_loc2_.leftTime);
         }
      }
      
      private function __worldBossReportHandler(param1:SLGSocketEvent) : void
      {
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc7_:Object = null;
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:WorldBossReportMsg = new WorldBossReportMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as WorldBossReportMsg;
         if(_loc2_.hasGold)
         {
            _loc9_ = Int64Utils.int64ToNumber(_loc2_.gold);
         }
         if(_loc2_.hasStrengy)
         {
            _loc11_ = Int64Utils.int64ToNumber(_loc2_.strengy);
         }
         if(_loc2_.type == 1 || _loc2_.type == 3)
         {
            _loc6_ = _loc2_.totalWound == 0 ? LanguageMgr.GetTranslation("yishi.manager.BaseManager.str11") : LanguageMgr.GetTranslation("yishi.manager.BaseManager.str12",_loc2_.totalWound);
            _loc8_ = _loc2_.order == 0 ? LanguageMgr.GetTranslation("yishi.manager.BaseManager.str21") : LanguageMgr.GetTranslation("yishi.manager.BaseManager.str22",_loc2_.order);
            if(_loc2_.type == 1)
            {
               _loc3_ = LanguageMgr.GetTranslation("yishi.manager.BaseManager.str01",_loc6_,_loc8_,_loc9_,_loc11_);
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("yishi.manager.BaseManager.gvgcross.str01",_loc6_,_loc8_,_loc9_,_loc11_);
            }
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc3_,worldBossReport));
         }
         else if(_loc2_.type == 2)
         {
            _loc4_ = LanguageMgr.GetTranslation("yishi.manager.BaseManager.str23",_loc2_.order,_loc9_,_loc11_,_loc2_.property1);
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc4_,worldBossReport,"PVE_ROOM_SCENE"));
         }
         else if(_loc2_.type == 4)
         {
            _loc5_ = LanguageMgr.GetTranslation("yishi.manager.BaseManager.petBoss.reportStr",_loc2_.totalWound,_loc2_.order,_loc2_.property1);
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc5_,worldBossReport));
         }
         else if(_loc2_.type == 7)
         {
            _loc7_ = {};
            _loc7_.num = _loc2_.order;
            _loc7_.time = _loc2_.property1;
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc7_,raceAgainstTimeBack,"PVE_ROOM_SCENE"));
         }
      }
      
      private function raceAgainstTimeBack(param1:Object, param2:Boolean = true, param3:String = "") : void
      {
         var _loc4_:RaceAgainstTimeFrame = ComponentFactory.Instance.creatComponentByStylename("core.raceAgainstTimeFrame");
         _loc4_.setClearTime(param1.num,param1.time);
         _loc4_.show();
      }
      
      private function worldBossReport(param1:String, param2:Boolean = true, param3:String = "") : void
      {
         SimpleAlertHelper.instance.data = [param1];
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         if(param3 != "")
         {
            _loc5_ = param3;
         }
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,param1,_loc4_,"",false,true,true);
      }
      
      private function __resetDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:DataResetMsg = new DataResetMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as DataResetMsg;
         PlayerManager.instance.currentPlayerModel.playerInfo.beginChanges();
         PlayerManager.instance.currentPlayerModel.playerInfo.attackCount = _loc2_.attackCount;
         PlayerManager.instance.currentPlayerModel.playerInfo.seminaryCount = _loc2_.blessingCount;
         PlayerManager.instance.currentPlayerModel.playerInfo.seminaryEffect = _loc2_.blessingBuff;
         var _loc3_:BuildInfo = BuildingManager.instance.model.buildingListByID[-11];
         if(_loc3_)
         {
            _loc3_.property1 = _loc2_.transEnergy;
         }
         var _loc5_:BuildingOrderInfo = BuildingManager.instance.model.getOrderById(10000);
         if(_loc5_)
         {
            _loc5_.currentCount = _loc2_.challengeCount;
            _loc5_.remainTime = 0;
            _loc5_.dispatchEvent(new Event("change"));
         }
         PlayerManager.instance.currentPlayerModel.playerInfo.weary = _loc2_.weary;
         PlayerManager.instance.currentPlayerModel.playerInfo.isGetKingBuffer = _loc2_.king_Buff;
         PlayerManager.instance.currentPlayerModel.playerInfo.diamondIndex = _loc2_.upRuneByPointTimes;
         PlayerManager.instance.currentPlayerModel.playerInfo.commit();
         MysteryShopManager.instance.model.beginChanges();
         MysteryShopManager.instance.model.buyCount = _loc2_.buyCount;
         MysteryShopManager.instance.model.commit();
      }
      
      private function __loginStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc10_:PackageOut = null;
         var _loc3_:NoviceReqMsgMsg = null;
         var _loc5_:String = null;
         var _loc11_:String = null;
         GlobalConfig.isLoginMsg = false;
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 6,__loginStateHandler);
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:LoginStateMsg = new LoginStateMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as LoginStateMsg;
         var _loc9_:int = _loc2_.playerId;
         var _loc6_:int = _loc2_.state;
         var _loc7_:int = PlayerManager.instance.newbieProcess;
         PlayerManager.instance.loginState = _loc6_;
         log({},"登陆状态 : " + _loc6_);
         switch(_loc6_ - 4)
         {
            case 0:
               log({},"登陆状态 : 副本");
               break;
            case 1:
               BattleManager.loginToBattleFlag = true;
               log({},"登陆状态 : 战斗");
               break;
            case 2:
               log({},"登陆状态 : 黎明杀机");
               SandboxManager.loginToSandboxFlag = true;
               break;
            case 3:
               log({},"登陆状态 : 游戏大厅");
               GameHallManager.loginToGameHallFlag = true;
               break;
            case 4:
               SecretWarManager.loginToSecretWarFlag = true;
               break;
            default:
               if(_loc7_ < 19000)
               {
                  _loc10_ = new PackageOut(5127);
                  _loc3_ = new NoviceReqMsgMsg();
                  _loc3_.type = 1;
                  SocketManager.instance.socket.sendProtobuffer(_loc10_,_loc3_);
                  break;
               }
               if(ArmyManager.instance.thane.grades > 16 && _loc7_ < 36000)
               {
                  PlayerManager.instance.newbieProcess = 36000;
                  PlayerManager.instance.sendSaveProcess(36000);
                  SceneManager.instance.setScene("CASTLE_SCENE");
                  break;
               }
               if(ArmyManager.instance.thane.grades <= 16)
               {
                  SceneManager.instance.setScene("CASTLE_SCENE");
               }
         }
         NewbieManager.instance.start();
         NotificationManager.instance.sendNotification("LOGIN_STATE",_loc6_);
         if(_loc7_ == 0)
         {
            _loc5_ = PlayerManager.instance.currentPlayerModel.userInfo.site;
            _loc11_ = PlayerManager.instance.currentPlayerModel.userInfo.user;
            ExternalInterfaceManager.instance.set360Event(_loc5_,_loc11_);
         }
         JsHelper.setSelfAdapting();
         var _loc4_:Array = userInfo.site.split("_");
         if(_loc4_[0] == "duowan")
         {
            CallInterfaceUtil.cannDuowanPlayerNotify(userInfo.user,userInfo.site,2,int(_loc4_[1]));
         }
      }
      
      private function hookAlert(param1:Object = null) : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.type = 11;
         _loc2_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
         TaskTraceTipManager.instance.showView(_loc2_);
      }
      
      private function __campaignCardsHandler(param1:SLGSocketEvent) : void
      {
         isSelect = false;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignCardsMsg = new CampaignCardsMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CampaignCardsMsg;
         var _loc5_:String = _loc2_.sceneType;
         var _loc3_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc3_ && _loc3_.battleType == 16)
         {
            SocketSceneBufferManager.instance.addPkgToBuffer(_loc4_,"BATTLE_SCENE",addQueue);
         }
         else
         {
            SocketSceneBufferManager.instance.addPkgToBuffer(_loc4_,"CAMPAIGN_MAP_SCENE",addQueue);
         }
      }
      
      private function __campaingTakeCardHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignTakeCardsMsg = new CampaignTakeCardsMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CampaignTakeCardsMsg;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.userId == _loc2_.playerId)
         {
            isSelect = true;
         }
         NotificationManager.instance.dispatchEvent(new CampaignMapEvent("UPDATE_CHEST_INFO",_loc2_));
      }
      
      private function __armyChangeSharpHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:CampaignArmy = null;
         var _loc6_:CampaignArmy = null;
         var _loc3_:SpaceArmy = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyChangeSharpMsg = new ArmyChangeSharpMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ArmyChangeSharpMsg;
         var _loc4_:String = _loc2_.hasServerName ? _loc2_.serverName : "";
         if(_loc2_.armyId == ArmyManager.instance.army.id)
         {
            if(!_loc2_.hasServerName || _loc2_.hasServerName && _loc2_.serverName == PlayerManager.instance.currentPlayerModel.playerInfo.serviceName)
            {
               ArmyManager.instance.thane.beginChanges();
               ArmyManager.instance.thane.changeShapeId = _loc2_.changeSharpId;
               ArmyManager.instance.thane.commit();
            }
         }
         if(RoomManager.instance.roomInfo)
         {
            _loc5_ = RoomManager.instance.roomInfo.getPlayerByArmyId(_loc2_.armyId,_loc4_);
            if(_loc5_)
            {
               _loc5_.baseHero.beginChanges();
               _loc5_.baseHero.changeShapeId = _loc2_.changeSharpId;
               _loc5_.baseHero.commit();
            }
         }
         if(CampaignManager.instance.mapModel)
         {
            _loc6_ = CampaignManager.instance.mapModel.getUserArmyByArmyId(_loc2_.armyId,_loc2_.serverName);
            if(_loc6_)
            {
               _loc6_.baseHero.beginChanges();
               _loc6_.baseHero.changeShapeId = _loc2_.changeSharpId;
               _loc6_.baseHero.commit();
            }
         }
         if(SpaceManager.instance.model)
         {
            _loc3_ = SpaceManager.instance.model.getUserArmyByUserId(_loc2_.armyId);
            if(_loc3_)
            {
               _loc3_.baseHero.beginChanges();
               _loc3_.baseHero.changeShapeId = _loc2_.changeSharpId;
               _loc3_.baseHero.commit();
            }
         }
      }
      
      private function __showMsgHandler(param1:NotificationEvent) : void
      {
         GameBaseQueueManager.instance.addAction(new MessageAction(param1.data));
      }
      
      private function __msgHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignNotifyMsg = new CampaignNotifyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CampaignNotifyMsg;
         var _loc3_:int = _loc2_.id;
         var _loc5_:String = _loc2_.scene;
         if(_loc5_ == SceneManager.instance.currentType || _loc5_ == "")
         {
            addQueue(_loc4_);
         }
         else
         {
            SocketSceneBufferManager.instance.addPkgToBuffer(_loc4_,_loc5_,addQueue);
         }
      }
      
      private function __godsEveningNoticeHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:String = null;
         var _loc3_:Array = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         if(!ChatManager.instance.model)
         {
            return;
         }
         ChatManager.instance.model.removeReceiveProtocol(_loc7_.extend1);
         if(!ChatBar.instance.isLoaded)
         {
            return;
         }
         var _loc2_:ChatChannelMsg = new ChatChannelMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ChatChannelMsg;
         var _loc6_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc2_.job != 0 && _loc2_.job != 4 && _loc2_.job != thane.templateInfo.Job)
         {
            return;
         }
         _loc6_.channel = _loc2_.channel;
         _loc6_.userType = _loc2_.userType;
         _loc6_.serverName = _loc2_.serverName;
         _loc6_.type = _loc2_.type;
         _loc6_.grades = _loc2_.grades;
         _loc6_.consortiaName = _loc2_.consortiaName;
         _loc6_.senderName = _loc2_.name;
         _loc6_.receiverName = _loc2_.receiveName;
         _loc6_.is_centerTip = _loc2_.isCenterTip;
         _loc6_.is_bigTip = _loc2_.isBigTip;
         _loc6_.bigBugleType = _loc2_.bigBugleType;
         _loc6_.vipGrade = _loc2_.vipGrade;
         if(_loc6_.channel != 3 && _loc6_.channel != 2)
         {
            _loc6_.uid = _loc2_.otherId;
            _loc6_.consortiaId = _loc2_.consortiaId;
            _loc6_.appellId = _loc2_.appellid;
         }
         var _loc8_:String = analyzeExpression(_loc2_);
         var _loc4_:int = _loc8_.indexOf("http://");
         if(_loc4_ != -1 && ChatChannel.isNoticeChannel(_loc2_.channel))
         {
            _loc6_.msg = _loc8_.substring(0,_loc4_ - 1);
            _loc6_.msgUrl = _loc8_.substring(_loc4_,_loc8_.length);
         }
         else
         {
            _loc6_.msg = _loc8_;
            _loc6_.msgUrl = "";
         }
         _loc6_.commit();
         ChatManager.instance.model.addChat(_loc6_);
         if(_loc6_.type == 6)
         {
            _loc3_ = _loc6_.msg.match(/\<([^>]*)>*/g);
            if(_loc3_ && _loc3_.length > 0)
            {
               _loc5_ = ChatFormat.getGodsEveningNotice(new XML(_loc3_[0]),2);
            }
            else
            {
               _loc5_ = _loc6_.getNormalMsg();
            }
            MultiMessageTipManager.instance.show(_loc5_);
         }
      }
      
      private function analyzeExpression(param1:ChatChannelMsg) : String
      {
         var _loc2_:String = param1.encodeMsg.replace(/\<([^>]*)>*/g,"");
         if(_loc2_.search(/(#)([0-3][0-9])/g) != -1)
         {
            _loc2_ = param1.encodeMsg.replace(/(#)([0-3][0-9])/g,"<a t=\'9\' index=\'$2\' name=\'$2\'/>");
            return filterSpecialChar(_loc2_);
         }
         return filterSpecialChar(param1.encodeMsg);
      }
      
      private function filterSpecialChar(param1:String) : String
      {
         return param1.replace(/­/g,"-");
      }
      
      private function __serverBroadcastHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:String = null;
         var _loc4_:Array = null;
         var _loc8_:int = 0;
         var _loc3_:String = null;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         if(PlayerManager.instance.loginState < 0)
         {
            return;
         }
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChatChannelMsg = new ChatChannelMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as ChatChannelMsg;
         var _loc9_:String = _loc2_.encodeMsg;
         if(SceneManager.instance.currentType != "BATTLE_SCENE")
         {
            _loc5_ = _loc9_;
            _loc4_ = _loc5_.match(/\<([^>]*)>*/g);
            _loc8_ = 0;
            while(_loc8_ < _loc4_.length)
            {
               try
               {
                  _loc3_ = _loc4_[_loc8_];
                  _loc6_ = new XML(_loc3_);
                  _loc7_ = _loc6_.@name;
                  _loc5_ = _loc5_.replace(_loc3_,_loc7_);
               }
               catch(e:Error)
               {
                  _loc5_ = "";
               }
               _loc8_++;
            }
            MessageTipManager.instance().show(_loc5_);
         }
      }
      
      private function __gamePlotHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlotMsg = new PlotMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlotMsg;
         var _loc4_:String = SceneType.getSceneTypeById(_loc2_.sceneType);
         if(_loc4_ == SceneManager.instance.currentType || _loc4_ == "")
         {
            addQueue(_loc3_);
         }
         else
         {
            SocketSceneBufferManager.instance.addPkgToBuffer(_loc3_,_loc4_,addQueue);
         }
      }
      
      private function addQueue(param1:PackageIn) : void
      {
         CoreTransactionManager.getInstance().currentTimeAddQueue(param1);
      }
      
      private function __gamePlotActionHandler(param1:NotificationEvent) : void
      {
         GameBaseQueueManager.instance.addAction(new DialogAction(param1.data));
      }
      
      private function __sessionOverHandler(param1:NotificationEvent) : void
      {
         var _loc3_:Object = param1.data;
         var _loc2_:Array = (_loc3_.data as DialogMessageInfo).param.split("|");
         var _loc5_:int = int(Utils.getArrayValueByTag("nodeId:",_loc2_));
         var _loc4_:int = int(Utils.getArrayValueByTag("mapId:",_loc2_));
         var _loc6_:int = int(Utils.getArrayValueByTag("command:",_loc2_));
         _loc3_.callBack();
         SocketSendManager.instance.sendSessionOverToBattle(_loc4_,_loc5_,_loc6_);
      }
      
      private function __roomInviteHandler(param1:SLGSocketEvent) : void
      {
         var inviteInfo:ThaneInfo;
         var id:int;
         var content:String;
         var nickName:String;
         var frame:InviteFrame;
         var nameMap:String;
         var str:String;
         var bossCountStr:String;
         var templateInfo:CampaignTemplate;
         var evt:SLGSocketEvent = param1;
         var pkg:PackageIn = evt.data as PackageIn;
         var msg:RoomInviteMsg = new RoomInviteMsg();
         msg = pkg.readBody(msg) as RoomInviteMsg;
         if(FrameControllerManager.instance.remainsExploreController.frame && FrameControllerManager.instance.remainsExploreController.openFrameType == 2)
         {
            return;
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "VEHICLE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "CROSS_GUILD_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "STARAREA_SCENE")
         {
            return;
         }
         if(FrameControllerManager.instance.pokerControler.showPoker)
         {
            return;
         }
         if(ChildManager.instance.arenaModel.isInChildArena)
         {
            return;
         }
         if(EclipticPalaceManager.instance.model.openEclipticPalaceFrame)
         {
            return;
         }
         if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            return;
         }
         if(FrameControllerManager.instance.dreamArenaController.dreamArenaMatching)
         {
            return;
         }
         if(SceneManager.instance.currentType == "SELF_CHESS_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "SECRET_ADVENTURE_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "THESE_PVP_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "SECRET_WAR_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "CHILD_NS_WAR_SCENE")
         {
            return;
         }
         if(PlayerManager.instance.loginState < 0)
         {
            return;
         }
         if(RoomManager.instance.roomInfo)
         {
            if(mapModel)
            {
               if(!WorldBossHelper.checkInHouse(mapModel.mapId))
               {
                  return;
               }
            }
         }
         if(CampaignManager.CampaignOverState)
         {
            return;
         }
         inviteInfo = FriendManager.getInstance().friendList[msg.playerId];
         if(inviteInfo && inviteInfo.relation == 2)
         {
            return;
         }
         if(LoadingSceneView.instance.parent)
         {
            if(msg.roomType == 100)
            {
               id = int(setTimeout(function():void
               {
                  clearTimeout(id);
                  SocketSceneBufferManager.instance.addPkgToBuffer(pkg,"CAMPAIGN_MAP_SCENE",enterFarmShow);
               },1000));
               return;
            }
            return;
         }
         if(ArmyManager.instance.thane.grades < 20 && msg.roomType == 0)
         {
            return;
         }
         if(existRoomInvate)
         {
            return;
         }
         if(AnswerManager.Instance.frameIsOpen)
         {
            return;
         }
         trace(MopupManager.instance.model.isMopup);
         if(MopupManager.instance.model.isMopup)
         {
            return;
         }
         if(MarryManager.instance.model.lockScreen)
         {
            return;
         }
         if(GroupfbManager.instance.model.hasGroupTeam)
         {
            return;
         }
         if(FrameControllerManager.instance.outyardControler.isOutyardMapApply)
         {
            return;
         }
         existRoomInvate = true;
         content = "";
         nickName = "<font color=\'#00ff00\'>" + msg.nickName + "</font>" + " ";
         frame = ComponentFactory.Instance.creatComponentByStylename("core.InviteFrame");
         if(msg.roomType == 1)
         {
            content = nickName + LanguageMgr.GetTranslation("yishi.manager.BaseManager.content02",msg.roomId);
            frame.titleText = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame");
         }
         else if(msg.roomType == 16)
         {
            content = nickName + "" + msg.signStr + LanguageMgr.GetTranslation("yishi.manager.BaseManager.content100");
            frame.titleText = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame");
         }
         else if(msg.roomType == 0)
         {
            nameMap = LanguageMgr.GetTranslation("yishi.manager.BaseManager.msg.name");
            str = StringHelper.isNullOrEmpty(msg.name) ? nameMap : msg.name;
            content = nickName + LanguageMgr.GetTranslation("yishi.manager.BaseManager.content03",str);
            templateInfo = TempleteManager.instance.getCampaignTemplateById(msg.tempId);
            if(templateInfo && (templateInfo.isTrailTower || templateInfo.isFantasyMatrix))
            {
               isActivity = true;
            }
            else
            {
               isActivity = false;
            }
            if(msg.bossCount == -1)
            {
               bossCountStr = LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum2");
            }
            else if(isActivity)
            {
               bossCountStr = "";
            }
            else
            {
               bossCountStr = LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum",msg.bossCount);
            }
            content += "  <font color=\'#ffff00\'>" + bossCountStr + "</font>";
            frame.titleText = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame02");
         }
         else if(msg.roomType == 2)
         {
            content = LanguageMgr.GetTranslation("vehicle.mapName");
            content = msg.nickName + LanguageMgr.GetTranslation("yishi.manager.BaseManager.content04",content);
            frame.titleText = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame02");
         }
         else if(msg.roomType == 3)
         {
            nameMap = LanguageMgr.GetTranslation("yishi.manager.BaseManager.msg.name");
            str = StringHelper.isNullOrEmpty(msg.name) ? nameMap : msg.name;
            content = nickName + LanguageMgr.GetTranslation("yishi.manager.BaseManager.content03",str);
            frame.titleText = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame02");
         }
         else if(msg.roomType == 4)
         {
            nameMap = LanguageMgr.GetTranslation("yishi.manager.BaseManager.msg.name");
            str = StringHelper.isNullOrEmpty(msg.name) ? nameMap : msg.name;
            content = nickName + LanguageMgr.GetTranslation("yishi.manager.BaseManager.content03",str);
            frame.titleText = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame03");
         }
         else if(msg.roomType == 7)
         {
            nameMap = LanguageMgr.GetTranslation("yishi.manager.BaseManager.msg.name");
            str = StringHelper.isNullOrEmpty(msg.name) ? nameMap : msg.name;
            content = nickName + LanguageMgr.GetTranslation("yishi.manager.BaseManager.content03",str);
            if(msg.bossCount < 0)
            {
               bossCountStr = LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum2");
            }
            else
            {
               bossCountStr = LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum",msg.bossCount);
            }
            content += "  <font color=\'#ffff00\'>" + bossCountStr + "</font>";
            frame.titleText = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame05");
         }
         else if(msg.roomType == 100)
         {
            content = nickName + LanguageMgr.GetTranslation("yishi.manager.BaseManager.content07");
            frame.titleText = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame07");
         }
         frame.roomType = msg.roomType;
         frame.roomPwd = msg.signStr;
         frame.roomId = msg.roomId;
         frame.tempId = msg.tempId;
         frame.position = msg.position;
         frame.userKey = msg.userKey;
         frame.content = content;
         frame.isCross = msg.isCross;
         frame.time = 10;
         if(msg.hasPlayerId)
         {
            frame.invidePlayerId = msg.playerId;
         }
         frame.setPos(msg.roomType);
         frame.show();
      }
      
      public function enterFarmShow(param1:PackageIn) : void
      {
         if(!mapModel)
         {
            return;
         }
         if(!WorldBossHelper.checkFarm(mapModel.mapId))
         {
            return;
         }
         var _loc2_:RoomInviteMsg = new RoomInviteMsg();
         _loc2_ = param1.readBody(_loc2_) as RoomInviteMsg;
         var _loc4_:String = "";
         var _loc3_:String = "<font color=\'#00ff00\'>" + _loc2_.nickName + "</font>" + " ";
         var _loc5_:InviteFrame = ComponentFactory.Instance.creatComponentByStylename("core.InviteFrame");
         if(_loc2_.roomType == 100)
         {
            _loc4_ = _loc3_ + LanguageMgr.GetTranslation("yishi.manager.BaseManager.content07");
            _loc5_.titleText = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame07");
         }
         _loc5_.roomType = _loc2_.roomType;
         _loc5_.roomPwd = _loc2_.signStr;
         _loc5_.roomId = _loc2_.roomId;
         _loc5_.tempId = _loc2_.tempId;
         _loc5_.position = _loc2_.position;
         _loc5_.userKey = _loc2_.userKey;
         _loc5_.content = _loc4_;
         _loc5_.time = 10;
         if(_loc2_.hasPlayerId)
         {
            _loc5_.invidePlayerId = _loc2_.playerId;
         }
         _loc5_.setPos(_loc2_.roomType);
         _loc5_.show();
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      private function __createCampaignHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomCreatedMsg = new RoomCreatedMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as RoomCreatedMsg;
         var _loc6_:int = _loc2_.createdType;
         log({},"创建副本");
         SpaceManager.instance.stop();
         SpaceManager.instance.exit = true;
         if(SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            SpaceSocketManager.instance.dispose();
            SpaceManager.instance.dispose();
         }
         if(_loc2_.room && _loc2_.room.campaignId == 3001)
         {
            SocketDataProxyManager.instance.addCreateSceneQueue(_loc7_,"VEHICLE",param1.type,true);
            createVehicle(_loc2_);
            return;
         }
         var _loc5_:Object = {};
         var _loc4_:Boolean = false;
         if(_loc2_.hasIsCross)
         {
            _loc4_ = _loc2_.isCross;
         }
         var _loc3_:RoomInfo = RoomManager.instance.roomInfo;
         var _loc8_:Boolean = true;
         if(!_loc3_)
         {
            _loc3_ = new RoomInfo();
            _loc8_ = false;
         }
         _loc3_.isCross = _loc4_;
         if(_loc2_.room)
         {
            _loc3_.id = _loc2_.room.roomId;
            _loc3_.houseOwnerId = _loc2_.room.masterId;
            _loc3_.serverName = _loc2_.room.masterServerName;
            _loc3_.mapName = _loc2_.room.name;
            _loc3_.campaignId = _loc2_.room.campaignId;
            _loc3_.capacity = _loc2_.room.capacity;
            _loc3_.roomType = _loc2_.room.roomType;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            if(WorldBossHelper.checkInHome(CampaignManager.instance.mapId) || WorldBossHelper.checkInHouse(CampaignManager.instance.mapId) || WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId))
            {
               if(_loc3_.campaignId == CampaignManager.instance.mapId)
               {
                  _loc5_["isDiffCampaignId"] = false;
               }
               else
               {
                  _loc5_["isDiffCampaignId"] = true;
               }
            }
         }
         if(CampaignManager.instance.exit)
         {
            CampaignManager.instance.dispose();
         }
         if(!_loc2_.room && _loc2_.room.campaignId != 4801)
         {
            return;
         }
         if(WorldBossHelper.checkFarm(_loc2_.room.campaignId) || WorldBossHelper.checkInHouse(_loc2_.room.campaignId) || WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId))
         {
            if(CampaignManager.instance.mapModel)
            {
               CampaignManager.instance.mapModel.reset();
            }
         }
         if(!_loc8_)
         {
            RoomManager.instance.setup(_loc3_);
         }
         CampaignManager.instance.setup(_loc3_.campaignId);
         CampaignManager.instance.mapModel.createType = _loc6_;
         CampaignManager.instance.mapModel.isCross = _loc4_;
         SocketDataProxyManager.instance.addCreateSceneQueue(_loc7_,"CAMPAIGN_MAP_SCENE",param1.type,false);
         if(!BattleManager.loginToBattleFlag)
         {
            if(_loc6_ == 3)
            {
               _loc5_["isShowLoading"] = false;
            }
            SceneManager.instance.setScene("CAMPAIGN_MAP_SCENE",_loc5_,true,false,_loc6_);
         }
      }
      
      private function createVehicle(param1:RoomCreatedMsg) : void
      {
         var _loc2_:Object = null;
         var _loc3_:int = param1.createdType;
         RoomManager.instance.dispose();
         if(!BattleManager.loginToBattleFlag)
         {
            if(_loc3_ == 3)
            {
               _loc2_ = {"isShowLoading":false};
            }
            SceneManager.instance.setScene("VEHICLE",_loc2_,true,false,_loc3_);
         }
      }
      
      private function __createRoomHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         if(CampaignManager.instance.exit)
         {
            RoomManager.instance.dispose();
         }
         var _loc2_:RoomMsg = new RoomMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RoomMsg;
         var _loc4_:RoomInfo = new RoomInfo();
         _loc4_.id = _loc2_.roomId;
         _loc4_.houseOwnerId = _loc2_.masterId;
         _loc4_.mapName = _loc2_.name;
         _loc4_.campaignId = _loc2_.campaignId;
         _loc4_.capacity = _loc2_.capacity;
         _loc4_.roomType = _loc2_.roomType;
         _loc4_.roomState = _loc2_.roomState;
         RoomManager.instance.setup(_loc4_);
         if(_loc4_.roomType == 1)
         {
            SceneManager.instance.setScene("PVP_ROOM_SCENE");
         }
         else if(_loc4_.roomType == 0)
         {
            SceneManager.instance.setScene("PVE_ROOM_SCENE");
         }
         else if(_loc4_.roomType == 2)
         {
            FrameControllerManager.instance.openControllerByInfo("vehicleroomlist",2);
         }
         else if(_loc4_.roomType == 5)
         {
            SceneManager.instance.setScene("MULTILORDS_ROOM");
         }
         else if(_loc4_.roomType == 8)
         {
            SceneManager.instance.setScene("MATELORDS_ROOM");
         }
         else if(_loc4_.roomType == 9)
         {
            SceneManager.instance.setScene("ARESLORDS_ROOM");
         }
         else if(_loc4_.roomType == 14)
         {
            SceneManager.instance.setScene("APEX_ROOM");
         }
         else if(_loc4_.roomType == 15)
         {
            SceneManager.instance.setScene("GLORY_GAME_SCENE");
         }
         else if(_loc4_.roomType == 16)
         {
            SceneManager.instance.setScene("THESE_Double_PVP_SCENE");
         }
      }
      
      private function __lockSceneHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LockScreenRspMsg = new LockScreenRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LockScreenRspMsg;
         var _loc4_:String = _loc2_.screen;
         if(_loc4_ == SceneManager.instance.currentType || _loc4_ == "")
         {
            lockScene(_loc3_);
         }
         else
         {
            SocketSceneBufferManager.instance.addPkgToBuffer(_loc3_,_loc4_,lockScene);
         }
      }
      
      private function lockScene(param1:PackageIn) : void
      {
         param1.position = 20;
         var _loc2_:LockScreenRspMsg = new LockScreenRspMsg();
         _loc2_ = param1.readBody(_loc2_) as LockScreenRspMsg;
         var _loc4_:String = _loc2_.screen;
         var _loc3_:int = _loc2_.frame;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_SCENE",{
            "lockTime":_loc3_,
            "lockScene":_loc4_
         }));
      }
      
      private function __socketCloseHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:BaseAlerFrame = null;
         if(_loginFrame)
         {
            return;
         }
         try
         {
            AlertManager.Instance.layerType = 0;
            _loc2_ = LanguageMgr.GetTranslation("public.prompt");
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.BaseManager.content01");
            _loc4_ = AlertManager.Instance.simpleAlert(_loc2_,_loc3_,"","",false,true,false);
            _loc4_.addEventListener("response",__exitSocketHandler);
            KeyBoardRegister.instance.keyEnable = false;
         }
         catch(e:Error)
         {
            __exitHandler();
         }
      }
      
      private function __loginOtherHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GatewayMsg = new GatewayMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GatewayMsg;
         try
         {
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loginFrame = AlertManager.Instance.simpleAlert(_loc4_,_loc2_.notifyMsg,"","",false,false,false);
            _loginFrame.addEventListener("response",__exitSocketHandler);
            LayerManager.Instance.addToLayer(_loginFrame,0,true,true,1);
            KeyBoardRegister.instance.keyEnable = false;
         }
         catch(err:Error)
         {
            throw new Error(_loc2_.notifyMsg);
         }
      }
      
      private function __exitSocketHandler(param1:FrameEvent) : void
      {
         _loginFrame = null;
         switch(param1.responseCode)
         {
            case 0:
            case 1:
            case 2:
            case 3:
               __exitHandler();
         }
      }
      
      private function __exitHandler() : void
      {
         var _loc1_:String = PlayerManager.instance.currentPlayerModel.userInfo.site;
         var _loc2_:String = PlayerManager.instance.currentPlayerModel.userInfo.user;
         ExternalInterfaceManager.instance.existGame(PathManager.info.SITE,_loc2_,_loc1_);
      }
      
      private function __battleInfoResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:BattleResultHandler = new BattleResultHandler();
         _loc2_.handler(param1.data as PackageIn);
         var _loc3_:String = SwitchPageHelp.returnScene;
         if(BattleManager.preScene)
         {
            _loc3_ = BattleManager.preScene;
         }
         SocketSceneBufferManager.instance.addPkgToBuffer(param1.data as PackageIn,_loc3_,showAddBloodFrameBack);
      }
      
      private function showAddBloodFrameBack(param1:PackageIn) : void
      {
         var _loc2_:BattleReportMsg = new BattleReportMsg();
         _loc2_ = param1.readBody(_loc2_) as BattleReportMsg;
         var _loc3_:Array = [2,8,11,19,22];
         if(_loc3_.indexOf(_loc2_.battleScene) >= 0)
         {
            return;
         }
         DelayActionsUtils.instance.addAction(new AlertTipAction(_loc2_.battleResult,showAlertTip));
      }
      
      private function __cccHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.hasParam5)
         {
            _loc2_.param7 = !ApplicationDomain.currentDomain.hasDefinition(_loc2_.param5);
         }
         _loc2_.param6 = _loc2_.param4;
         var _loc4_:PackageOut = new PackageOut(8598);
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc2_);
      }
      
      public function moveVirtual(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5634);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      private function __vehicleStartHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MatchStateMsg = new MatchStateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MatchStateMsg;
         playerInfo.beginChanges();
         playerInfo.isVehicleStart = _loc2_.matchState;
         playerInfo.commit();
      }
      
      private function __matelordsOpenHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         TopToolsBar.instance.matelordsState = _loc2_.param1;
      }
      
      private function __areslordsOpenHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         TopToolsBar.instance.areslordsState = _loc2_.param1;
      }
      
      public function showAlertTip(param1:Object) : void
      {
         var _loc2_:* = null;
         if(int(param1) != 2)
         {
            return;
         }
         if(thane.grades >= 13 && ConsortiaManager.instance.checkConsortiaSkillByGrade())
         {
            showTipViewByType(48);
         }
         else if(thane.grades >= 11 && BuildingManager.instance.checkMilitaryGrade())
         {
            showTipViewByType(6);
         }
         else if(thane.grades >= 7 && GoodsManager.instance.checkCanIntensify())
         {
            showTipViewByType(4);
         }
         else if(thane.grades >= 15 && GoodsManager.instance.checkCanMountByGrade())
         {
            showTipViewByType(5);
         }
         else if(thane.grades >= 15 && GoodsManager.instance.checkCanMountByGrade2())
         {
            showTipViewByType(5,2);
         }
         else if(thane.grades >= 16 && MountsManager.instance.checkMountProperty())
         {
            showTipViewByType(49);
         }
         else if(thane.grades >= 18 && StarManager.instance.checkIsStarNotFull())
         {
            showTipViewByType(8);
         }
         else if(thane.grades >= 18 && BuildingManager.instance.checkMilitaryTecMaxGrade())
         {
            showTipViewByType(9);
         }
         else if(thane.grades >= 19 && GoodsManager.instance.checkCanRefreshByGrade())
         {
            showTipViewByType(50);
         }
      }
      
      private function showTipViewByType(param1:int, param2:Object = null) : void
      {
         var _loc3_:TipMessageData = new TipMessageData();
         _loc3_.type = param1;
         _loc3_.data = param2;
         _loc3_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
         TaskTraceTipManager.instance.showView(_loc3_);
      }
      
      private function get externalManager() : ExternalInterfaceManager
      {
         return ExternalInterfaceManager.instance;
      }
      
      private function get soundManager() : SoundManager
      {
         return SoundManager.instance;
      }
      
      private function __towerReportHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TowerInfoMsg = new TowerInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TowerInfoMsg;
         createOneDelayAction(_loc2_.itemTempIds);
      }
      
      private function createOneDelayAction(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         DelayActionsUtils.instance.addAction(new AlertTipAction(param1,showAllFallGoods));
      }
      
      private function showAllFallGoods(param1:String) : void
      {
         var _loc2_:MazeFallItemsFrame = ComponentFactory.Instance.creatComponentByStylename("campaign.maze.FallItemsFrame");
         _loc2_.data = param1;
         _loc2_.show(_loc2_);
         _loc2_ = null;
      }
      
      public function get Message() : String
      {
         var _loc1_:String = "";
         _loc1_ = "enterframe : " + EnterFrameManager.instance.getMessage() + "\n";
         _loc1_ = _loc1_ + "CoreTransactionManager : " + CoreTransactionManager.getInstance().getMessage() + "\n";
         _loc1_ = _loc1_ + "GameBaseQueueManager : " + GameBaseQueueManager.instance.getMessage() + "\n";
         return _loc1_ + "SocketSceneBufferManager : " + SocketSceneBufferManager.instance.getMessage() + "\n";
      }
      
      public function loadBackResource() : void
      {
         if(_timeId2 == 0)
         {
            _timeId2 = setTimeout(loadBackResource,1800000);
            return;
         }
         clearTimeout(_timeId2);
         _timeId2 = 0;
         addWorldBossModule();
      }
      
      private function addAvatarModule() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:XMLList = ConfigManager.backAvatarLisr.children();
         for each(var _loc4_:XML in _loc3_)
         {
            _loc1_ = _loc4_.@AvataSource;
            _loc2_ = PathManager.resourcePath + "swf/avatar" + _loc1_ + "/" + thane.templateInfo.Sexs + ".bswf";
            LoaderManagerII.instance.load(_loc2_,1,1,null);
         }
      }
      
      private function addWorldBossModule() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(_timeId1 != 0)
         {
            clearTimeout(_timeId1);
         }
         _timeId1 = 0;
         var _loc1_:CampaignTemplate = new CampaignTemplate();
         _loc1_.TimeValue = PlayerManager.instance.currentPlayerModel.sysCurtime.time;
         var _loc7_:Array = [];
         _loc7_.push(_loc1_);
         _loc7_.push(TempleteManager.instance.pvpWarFightDic[4001]);
         _loc7_.push(TempleteManager.instance.pvpWarFightDic[4002]);
         _loc7_.push(TempleteManager.instance.worldBossTemplateDict[4501]);
         _loc7_.push(TempleteManager.instance.worldBossTemplateDict[5001]);
         _loc7_.sortOn("TimeValue",16);
         var _loc5_:int = _loc7_.indexOf(_loc1_);
         if(_loc5_ < _loc7_.length - 1)
         {
            _loc4_ = (_loc7_[_loc5_ + 1].TimeValue - _loc1_.TimeValue) / 60000;
            if(_loc4_ <= 10)
            {
               _timeId1 = setTimeout(addWorldBossModule,3600000);
               return;
            }
         }
         var _loc6_:int = 0;
         var _loc3_:XMLList = ConfigManager.backResourceLis.children();
         _loc6_ = _loc5_ + 1;
         while(_loc6_ < _loc7_.length)
         {
            _loc1_ = _loc7_[_loc6_];
            _loc2_ = _loc3_.(@templteId == _loc1_.CampaignId);
            loadWorldBossResource(_loc2_.children());
            loadBattleResource(_loc1_.CampaignId);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc1_ = _loc7_[_loc6_];
            _loc2_ = _loc3_.(@templteId == _loc1_.CampaignId);
            loadWorldBossResource(_loc2_.children());
            loadBattleResource(_loc1_.CampaignId);
            _loc6_++;
         }
         addAvatarModule();
      }
      
      private function loadWorldBossResource(param1:XMLList) : void
      {
         var _loc2_:String = null;
         for each(var _loc3_:XML in param1)
         {
            _loc2_ = _loc3_.@path;
            LoaderManagerII.instance.load(PathManager.resourcePath + _loc2_,1,1,null);
         }
      }
      
      private function loadBattleResource(param1:int) : void
      {
         var _loc3_:int = getHeroTempId(param1);
         if(_loc3_ == 0)
         {
            return;
         }
         var _loc4_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc3_);
         var _loc2_:String = PathManager.solveRolePath(_loc4_.ResPath);
         LoaderManagerII.instance.load(_loc2_,1,1,null);
      }
      
      private function getHeroTempId(param1:int) : int
      {
         switch(param1 - 5001)
         {
            case 0:
            case 2:
               return 2001;
            case 1:
               return 2002;
            default:
               return 0;
         }
      }
      
      private function __navigationInviteAssistHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:NavigationBoatUpgradeInviteMsg = new NavigationBoatUpgradeInviteMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as NavigationBoatUpgradeInviteMsg;
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         if(existNavigationInvite)
         {
            return;
         }
         existNavigationInvite = true;
         var _loc4_:NavigationInviteAssistFrame = ComponentFactory.Instance.creatComponentByStylename("core.NavigationInviteAssistFrame");
         _loc4_.playerId = _loc2_.playerId;
         _loc4_.playerName = _loc2_.playerName;
         _loc4_.boatId = _loc2_.boatId;
         _loc4_.token = _loc2_.token;
         _loc4_.show();
      }
   }
}

