package yishi.lunch
{
   import battle.logsys.BattleLogSystemLoader;
   import chat.ChatManager;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.player.PlayerDataMsg;
   import farm.FarmManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import mainBar.FullBar;
   import manager.ExternalInterfaceManager;
   import managers.ActivityManager;
   import managers.AirGardenFivecardManager;
   import managers.AirGardenGameLlkManager;
   import managers.AirGardenManager;
   import managers.AirGardenMemoryCardManager;
   import managers.BattleViewManager;
   import managers.BottleManager;
   import managers.BoxManager;
   import managers.CatHouseManager;
   import managers.ChessPvpManager;
   import managers.ChildManager;
   import managers.ChildNswarManager;
   import managers.ChildPatrolManager;
   import managers.ChildesalManager;
   import managers.ChristmasTreeManager;
   import managers.ConsortiaSocketOutManager;
   import managers.CustomizedVipManager;
   import managers.DarkMazeManager;
   import managers.DayGuideManager;
   import managers.DragonTalkerManager;
   import managers.DragonTitanManager;
   import managers.DreamArenaManager;
   import managers.DungeoTurnManager;
   import managers.DungeonExploManager;
   import managers.EclipticPalaceManager;
   import managers.EncoGoldManager;
   import managers.ExchangeBoxManager;
   import managers.ExchargeRankManager;
   import managers.FaceBookShareManager;
   import managers.FashionManager;
   import managers.FeedBackManager;
   import managers.FinalDefenseManager;
   import managers.FishManager;
   import managers.FoisonHornManager;
   import managers.FreedomTeamManager;
   import managers.FundManager;
   import managers.FundVeinManager;
   import managers.FunnyManager;
   import managers.GameBoxManager;
   import managers.GameHallManager;
   import managers.GloryGameManager;
   import managers.GodDessManager;
   import managers.GodTreasureManager;
   import managers.GoldRoadManager;
   import managers.GroupfbManager;
   import managers.GuideTaskManager;
   import managers.HomeManager;
   import managers.IncreasinglyRoadManager;
   import managers.KingContractManager;
   import managers.KingbackManager;
   import managers.LlkManager;
   import managers.LotteryManager;
   import managers.LuckyLotteryManager;
   import managers.MagicSpringManager;
   import managers.MailCheckManager;
   import managers.MarryManager;
   import managers.MinosManager;
   import managers.MonopolyGemMazeManager;
   import managers.MonopolyLlkManager;
   import managers.MonopolyManager;
   import managers.MonthCardManager;
   import managers.MopupManager;
   import managers.MountsManager;
   import managers.MvpShopManager;
   import managers.MysteryShopManager;
   import managers.NavigationManager;
   import managers.NewActiveLeedManager;
   import managers.NewFirstPayManager;
   import managers.NewMemoryCardManager;
   import managers.OfferRewardManager;
   import managers.OldBackerManager;
   import managers.OuterCityShopManager;
   import managers.PerkinLabManager;
   import managers.PetChallengeManager;
   import managers.PetSacristyManager;
   import managers.PlatinumManager;
   import managers.PlayerCurrencyManager;
   import managers.PoseidonManager;
   import managers.PumpingJoyManager;
   import managers.QuestionManager;
   import managers.RapidThroughPassManager;
   import managers.RavePartyManager;
   import managers.RedemptionRoadManager;
   import managers.RemotePetManager;
   import managers.RingTaskManager;
   import managers.SaleManager;
   import managers.SecretaryManager;
   import managers.SevenYearManager;
   import managers.ShopManager;
   import managers.SkyboxRoadManager;
   import managers.SlotManager;
   import managers.SpiritExpeditionManager;
   import managers.SqMemoryManger;
   import managers.SteleSysManager;
   import managers.StokesOreManager;
   import managers.SuperSigninCardManager;
   import managers.TailaFbManager;
   import managers.TaskTraceTipManager;
   import managers.TheseusPvpManager;
   import managers.TheseussoulManager;
   import managers.TimeVortexManager;
   import managers.TreasureHuntManager;
   import managers.TreasureMapManager;
   import managers.VIPManager;
   import managers.WholeRebateManager;
   import managers.WishPoolManager;
   import managers.WorldBossManager;
   import managers.YLExpedtionManger;
   import managers.YearActiveManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import mvc.controler.MarryController;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.stararea.StarareaManager;
   import org.aswing.KeyboardManager;
   import sandbox.SandboxManager;
   import yishi.datas.UserInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.StartupEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.AlchemicalManager;
   import yishi.manager.AllManExchangeManager;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.AnswerManager;
   import yishi.manager.AntaeusManager;
   import yishi.manager.ApexManager;
   import yishi.manager.AppellManager;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.AresLordsManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.ArtifactManager;
   import yishi.manager.AvengerManager;
   import yishi.manager.BaseManager;
   import yishi.manager.BingoManager;
   import yishi.manager.BirthdayManager;
   import yishi.manager.BlackjackManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.CampaignTemplateManager;
   import yishi.manager.CarnivalManager;
   import yishi.manager.ChargeLotteryManager;
   import yishi.manager.ChristmasManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.ConsortiaNewBossManager;
   import yishi.manager.CoreTransactionManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.CultureActiveManager;
   import yishi.manager.CustomerServiceManager;
   import yishi.manager.DemonLandManager;
   import yishi.manager.DiscountShopManager;
   import yishi.manager.EmailManager;
   import yishi.manager.ExpBackManager;
   import yishi.manager.FinalRoadManager;
   import yishi.manager.ForbiddenBossManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.GameUiManager;
   import yishi.manager.GemMazeManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.GoldenDionysiaManager;
   import yishi.manager.GoldenSheepManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.GuildWantedManager;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.LandMineManager;
   import yishi.manager.LocalConnectionManager;
   import yishi.manager.LordTrialManager;
   import yishi.manager.LuckyExchangeManager;
   import yishi.manager.MagicCardManager;
   import yishi.manager.MagicPubManager;
   import yishi.manager.MatelordsManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.MonsterManager;
   import yishi.manager.NewYearActManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PandoraManager;
   import yishi.manager.PathManager;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerBufferManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PokerManager;
   import yishi.manager.ProficiencyManager;
   import yishi.manager.PublicChairsManager;
   import yishi.manager.PublicEggManager;
   import yishi.manager.QuestionnaireManager;
   import yishi.manager.QueueBarManager;
   import yishi.manager.RegistWelfareManager;
   import yishi.manager.RegressManager;
   import yishi.manager.RemainsExploreManager;
   import yishi.manager.RevengeRoadManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.SacrificeManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.SecretWarManager;
   import yishi.manager.ShadowLandManager;
   import yishi.manager.SharedManager;
   import yishi.manager.SkyTreasureManager;
   import yishi.manager.SnsPortManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.manager.StageFocusManager;
   import yishi.manager.StarGazingManager;
   import yishi.manager.StarManager;
   import yishi.manager.SumCampaignManager;
   import yishi.manager.TaskManage;
   import yishi.manager.UpgradePresentManager;
   import yishi.manager.WarSoulTowerManager;
   import yishi.manager.WaterManager;
   import yishi.scene.SceneCreateSwitch;
   import yishi.scene.SceneManager;
   import yishi.service.managers.CastleServiceManager;
   import yishi.service.managers.ServicesManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.ExitGameUtils;
   import yishi.utils.WorldBossHelper;
   import yishi.view.frame.CacheTipFrame;
   import yishi.view.frame.UpdateBroadCastFrame;
   import yzhkof.debug.log;
   
   public class Yishi extends Sprite
   {
      
      private static var _cacheFrame:CacheTipFrame;
      
      private var _configXml:XML;
      
      private var _userInfo:UserInfo;
      
      public function Yishi()
      {
         super();
      }
      
      public static function openCache() : void
      {
         LoaderSavingManager.eventDispatcher.addEventListener("SharedObject.Flush.Open",__soOpenHandler);
         var _loc1_:Boolean = true;
         if(DisplayLoader.isDebug)
         {
            _loc1_ = false;
         }
         if(_loc1_)
         {
            LoaderSavingManager.loadFilesInLocal(_loc1_);
         }
      }
      
      private static function __soOpenHandler(param1:Event) : void
      {
         if(!_cacheFrame)
         {
            _cacheFrame = new CacheTipFrame();
         }
         _cacheFrame.show();
         _cacheFrame.addEventListener("removedFromStage",__removedFromStageHandler);
      }
      
      private static function __removedFromStageHandler(param1:Event) : void
      {
         if(_cacheFrame)
         {
            _cacheFrame.removeEventListener("removedFromStage",__removedFromStageHandler);
         }
         _cacheFrame = null;
      }
      
      public function lunch(param1:XML, param2:Object) : void
      {
         var _loc3_:BattleLogSystemLoader = null;
         _configXml = param1;
         initUserInfo(param2);
         if(!ConfigParaser.isInit)
         {
            ConfigParaser.paras(_configXml,StageReferance.stage.loaderInfo);
         }
         socketConnect();
         setupComponent();
         VersionSwitch.BATTLE_LOG = StageReferance.isDebug;
         if(VersionSwitch.BATTLE_LOG)
         {
            _loc3_ = new BattleLogSystemLoader(null);
            _loc3_.load();
         }
      }
      
      private function initUserInfo(param1:Object) : void
      {
         _userInfo = new UserInfo();
         _userInfo.user = param1.user;
         _userInfo.tempPassword = param1.tempPassword;
         _userInfo.userId = param1.userId;
         _userInfo.password = param1.password;
         _userInfo.site = param1.site;
         _userInfo.isActive = param1.isActive;
         _userInfo.noviceProcess = param1.noviceProcess;
         _userInfo.serverName = param1.serverName;
      }
      
      private function initEvent() : void
      {
         PlayerManager.instance.addEventListener("LOGIN_SUCCESS",__tryLoadStartupResource);
         StartupResourcesLoader.instance.addEventListener("coreSetupLoadComplete",__onCoreSetupLoadComplete);
         StartupResourcesLoader.instance.addEventListener("coreUILoadComplete",__coreLoadCompleteHandler);
      }
      
      private function socketConnect() : void
      {
         initEvent();
         beforSocketConnect();
         onSocketConnect();
      }
      
      private function beforSocketConnect() : void
      {
         PlayerManager.instance.setup();
         VIPManager.Instance.setup();
         PlayerCurrencyManager.instance.setup();
         PlayerManager.instance.currentPlayerModel.userInfo = _userInfo;
         BaseManager.instance.setup();
      }
      
      private function onSocketConnect() : void
      {
         log({},PathManager.SocktPath + "连接socket : " + PathManager.SocketPort);
         SocketManager.instance.socket.connect(PathManager.SocktPath,PathManager.SocketPort);
      }
      
      private function __tryLoadStartupResource(param1:Event) : void
      {
         var _loc2_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(_loc2_.userId != 0)
         {
            SharedManager.instance.setup(_userInfo.userId);
            StartupResourcesLoader.instance.start(_userInfo,_configXml,false);
            AppellManager.instance.setup();
         }
      }
      
      private function __coreLoadCompleteHandler(param1:StartupEvent) : void
      {
         ServicesManager.instance.setup(PathManager.CastleServicePath);
         CastleServiceManager.instance.setup();
         BuildingManager.instance.setup();
         ArmyManager.instance.setup();
         MountsManager.instance.setup();
         StarManager.instance.setup();
         PlayerBufferManager.instance.setup();
         BoxManager.instance.setup();
         TaskManage.instance.setup();
         OfferRewardManager.instance.setup();
         DayGuideManager.instance.setup();
         GoodsManager.instance.setup();
         WaterManager.instance.setup();
         SceneCreateSwitch.instance.setup();
         SceneManager.instance.setup();
         ShopManager.Instance.setup();
         ActivityManager.Instance.setup();
         MysteryShopManager.instance.setup();
         FarmManager.instance.setup();
         SnsPortManager.Instance.setup();
         MopupManager.instance.setup();
         QuestionnaireManager.instance.setup();
         KingContractManager.Instance.setup();
         FeedBackManager.instance.setup();
         FunnyManager.instance.setup();
         ExchargeRankManager.instance.setup();
         BottleManager.instance.setup();
         FashionManager.instance.setup();
         FundManager.instance.setup();
         FundVeinManager.instance.setup();
         GuideTaskManager.instance.setup();
         RingTaskManager.instance.setup();
         LotteryManager.Instance.setup();
         MarryManager.instance.setup();
         SlotManager.Instance.setup();
         ChristmasTreeManager.instance.setup();
         SecretaryManager.instance.setup();
         NewYearActManager.instance.setup();
         BirthdayManager.instance.setup();
         AnswerManager.Instance.setup();
         FreedomTeamManager.instance.setup();
         TreasureMapManager.instance.setup();
         ExpBackManager.Instance.setUp();
         TreasureHuntManager.instance.setup();
         MagicCardManager.Instance.setup();
         GemMazeManager.Instance.setup();
         FishManager.instance.setup();
         GoldRoadManager.instance.setup();
         MatelordsManager.instance.setup();
         MonopolyManager.instance.setup();
         OuterCityShopManager.instance.setup();
         PlanesWarManager.instance.setup();
         ExchargeRankManager.instance.setup();
         ChildManager.instance.setup();
         LlkManager.instance.setup();
         MonopolyLlkManager.instance.setup();
         MonopolyGemMazeManager.Instance.setup();
         SkyTreasureManager.Instance.setup();
         RemotePetManager.instance.setup();
         SacrificeManager.instance.setup();
         GodTreasureManager.instance.setup();
         GroupfbManager.instance.setup();
         TailaFbManager.instance.setup();
         BattleViewManager.instance.setup();
         DungeonExploManager.instance.setup();
         SumCampaignManager.instance.setup();
         InfoTipsManager.instance.setup();
         SkyboxRoadManager.instance.setup();
         RegistWelfareManager.instance.setup();
         BlackjackManager.instance.setup();
         ArtifactManager.instance.setup();
         GameBoxManager.instance.setup();
         FinalDefenseManager.ins.setup();
         PerkinLabManager.instance.setup();
         PokerManager.instance.setup();
         ArchaeologyManager.instance.setup();
         HomeManager.instance.setup();
         DragonTitanManager.instance.setup();
         ChildPatrolManager.instance.setup();
         SaleManager.instance.setup();
         CatHouseManager.instance.setup();
         FaceBookShareManager.instance.setup();
         MailCheckManager.instance.setup();
         RegressManager.instance.setup();
         BingoManager.instance.setup();
         OutyardManager.instance.setup();
         NavigationManager.instance.setup();
         QueueBarManager.instance.setup();
         LuckyExchangeManager.instance.setup();
         ExchangeBoxManager.instance.setup();
         CrossGuildManager.instance.setup();
         AresLordsManager.instance.setup();
         BraveLegManager.instance.setup();
         DiscountShopManager.instance.setup();
         PetHallowsManager.instance.setup();
         PetSacristyManager.instance.setup();
         RapidThroughPassManager.instance.setup();
         MagicPubManager.instance.setup();
         RavePartyManager.instance.setup();
         HeroRoadManager.instance.setup();
         PublicChairsManager.instance.setup();
         PublicEggManager.instance.setup();
         PandoraManager.instance.setup();
         ChildesalManager.instance.setup();
         EncoGoldManager.instance.setup();
         PetChallengeManager.instance.setup();
         ChargeLotteryManager.instance.setup();
         LordTrialManager.instance.setup();
         CultureActiveManager.instance.setup();
         AncientArtifactManager.instance.setup();
         GoldenDionysiaManager.instance.setup();
         AlchemicalManager.instance.setup();
         TimeVortexManager.instance.setup();
         OldBackerManager.instance.setup();
         DragonTalkerManager.instance.setup();
         PumpingJoyManager.instance.setup();
         SandboxManager.instance.setup();
         GodsEveningManager.instance.setup();
         WholeRebateManager.instance.setup();
         StarGazingManager.instance.setup();
         PlaneCrisisManager.Instance.setup();
         DungeoTurnManager.instance.setup();
         MagicSpringManager.instance.setup();
         EclipticPalaceManager.instance.setup();
         MonthCardManager.instance.setup();
         UpgradePresentManager.instance.setup();
         DemonLandManager.instance.setup();
         GoldenSheepManager.instance.setup();
         GodDessManager.instance.setup();
         FoisonHornManager.instance.setup();
         LandMineManager.instance.setup();
         MvpShopManager.instance.setup();
         GameHallManager.instance.setup();
         ApexManager.instance.setup();
         MonsterManager.instance.setup();
         AntaeusManager.instance.setup();
         MonsterExploreManager.instance.setup();
         LuckyLotteryManager.instance.setup();
         DreamArenaManager.instance.setup();
         StokesOreManager.instance.setup();
         AirGardenManager.instance.setup();
         AirGardenGameLlkManager.instance.setup();
         AirGardenFivecardManager.instance.setup();
         AirGardenMemoryCardManager.instance.setup();
         AvengerManager.instance.setup();
         RevengeRoadManager.Ins.setup();
         WishPoolManager.instance.setup();
         RedemptionRoadManager.instance.setup();
         SuperSigninCardManager.instance.setup();
         ProficiencyManager.instance.setup();
         KingbackManager.instance.setup();
         GuildWantedManager.instance.setup();
         StarareaManager.instance.setup();
         SevenYearManager.instance.setup();
         GloryGameManager.instance.setup();
         AllManExchangeManager.instance.setup();
         IncreasinglyRoadManager.instance.setup();
         SpiritExpeditionManager.instance.setup();
         YLExpedtionManger.instance.setup();
         PlatinumManager.instance.setup();
         SelfChessManager.Ins.setup();
         CustomizedVipManager.instance.setup();
         ShadowLandManager.instance.setup();
         DarkMazeManager.instance.setup();
         SteleSysManager.Ins.setup();
         RemainsExploreManager.instance.setup();
         ConsortiaNewBossManager.instance.setup();
         NewFirstPayManager.instance.setup();
         QuestionManager.instance.setup();
         RoyaltyBossManager.instance.setup();
         PoseidonManager.Ins.setup();
         ForbiddenBossManager.instance.setup();
         TheseussoulManager.Instance.setup();
         NewMemoryCardManager.instance.setup();
         SecretAdventerManager.Instance.setup();
         CarnivalManager.Instance.setup();
         NewActiveLeedManager.instance.setup();
         WarSoulTowerManager.instance.setup();
         FinalRoadManager.instance.setup();
         TheseusPvpManager.Instance.setup();
         SqMemoryManger.Instance.setup();
         OldPlayerReturnManager.instance.setup();
         SecretWarManager.Instance.setup();
         YearActiveManager.ins.setup();
         MinosManager.ins.setup();
         ChessPvpManager.Instance.setup();
         ChristmasManager.instance.setup();
         ChildNswarManager.Instance.setup();
      }
      
      private function __onCoreSetupLoadComplete(param1:StartupEvent) : void
      {
         requestLoginState();
         setupManager();
         loginOverCall();
      }
      
      private function requestLoginState() : void
      {
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         var _loc1_:PlayerDataMsg = new PlayerDataMsg();
         _loc1_.user = true;
         SocketSendManager.instance.loginDataReq(_loc1_);
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
         loginInitDataAcceptComplete();
      }
      
      private function loginInitDataAcceptComplete() : void
      {
         var _loc2_:UpdateBroadCastFrame = null;
         var _loc1_:int = 0;
         if(checkScence())
         {
            if(ArmyManager.instance.thane.grades >= 25)
            {
               if(isNeedShowMailCheck())
               {
                  FrameControllerManager.instance.openControllerByInfo("mailcheck",1);
               }
               else if(MarryManager.instance.model.selfMarryInfo.heartInfo.curQuestion)
               {
                  if(!marryController.hasHeartFrame)
                  {
                     MarryManager.instance.creatHeartFrame();
                  }
               }
               else if(PlayerManager.instance.currentPlayerModel.playerInfo.showVersion)
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.BroadCastFrame");
                  _loc2_.show(callBack);
               }
               else
               {
                  _loc1_ = int(DayGuideManager.instance.daySignInfo.signArr[DayGuideManager.instance.daySignInfo.todayIndex - 1]);
                  if(_loc1_ == 1)
                  {
                     if(isShowDayGuideInScence)
                     {
                        FrameControllerManager.instance.openControllerByInfo("newactiveleed");
                     }
                  }
                  else
                  {
                     FrameControllerManager.instance.openControllerByInfo("dayguide",1);
                  }
               }
            }
         }
         ShopManager.Instance.getBuyDataInfos();
         ConsortiaSocketOutManager.getConsortiaInviteInfos();
         InfoTipsManager.instance.getData();
      }
      
      private function isNeedShowMailCheck() : Boolean
      {
         var _loc1_:String = SceneManager.instance.currentType;
         if((_loc1_ == "SPACE_SCENE" || _loc1_ == "CASTLE_SCENE") && MailCheckManager.instance.model.isShow)
         {
            return true;
         }
         return false;
      }
      
      private function callBack() : void
      {
         if(isShowDayGuideInScence)
         {
            FrameControllerManager.instance.openControllerByInfo("newactiveleed");
         }
      }
      
      private function get isShowDayGuideInScence() : Boolean
      {
         var _loc1_:String = SceneManager.instance.currentType;
         switch(_loc1_)
         {
            case "PLANE_CRISRIS":
            case "GAME_HALL_SCENE":
               break;
            default:
               return true;
         }
         return false;
      }
      
      private function get isShowMailCheckInScene() : Boolean
      {
         var _loc1_:String = SceneManager.instance.currentType;
         switch(_loc1_)
         {
            case "SPACE_SCENE":
            case "CASTLE_SCENE":
               break;
            default:
               return false;
         }
         return true;
      }
      
      private function checkScence() : Boolean
      {
         var _loc3_:CampaignMapModel = null;
         var _loc1_:Boolean = false;
         var _loc2_:String = SceneManager.instance.currentType;
         switch(_loc2_)
         {
            case "BATTLE_SCENE":
            case "PVE_ROOM_SCENE":
            case "PVP_ROOM_SCENE":
            case "EMPTY_SCENE":
            case "VEHICLE":
            case "VEHICLE_ROOM_SCENE":
            case "UNREAL_SHOOTING_ROOM":
            case "SECRET_WAR_SCENE":
               break;
            case "CAMPAIGN_MAP_SCENE":
               _loc3_ = CampaignManager.instance.mapModel;
               if(_loc3_)
               {
                  _loc1_ = WorldBossHelper.checkWorldBoss(_loc3_.mapId) || WorldBossHelper.checkPvp(_loc3_.mapId) || WorldBossHelper.checkFlameTemple(_loc3_.mapId) || WorldBossHelper.checkSvs(_loc3_.mapId) || WorldBossHelper.checkUnrealShooting(_loc3_.mapId) || WorldBossHelper.checkDuskArea(_loc3_.mapId) || WorldBossHelper.checkIceFireTemple(_loc3_.mapId) || WorldBossHelper.checkSteel(_loc3_.mapId) || WorldBossHelper.checkMolong(_loc3_.mapId) || WorldBossHelper.checkActiveVehicle(_loc3_.mapId) || WorldBossHelper.checkForbiddenBoss(_loc3_.mapId);
               }
               else
               {
                  _loc1_ = false;
               }
               if(_loc1_)
               {
                  return false;
               }
            default:
               return true;
         }
         return false;
      }
      
      private function setupManager() : void
      {
         trace("===============setupManager================");
         11.4;
         ShowTipManager.Instance.setup();
         LocalConnectionManager.instance.connId;
         ChatManager.instance.setup();
         GameUiManager.instance.setup();
         CampaignTemplateManager.instance.setup();
         CampaignRankManager.instance.setup();
         StageFocusManager.getInstance().setup(StageReferance.stage);
         KeyboardManager.getInstance().init(StageReferance.stage);
         KeyBoardRegister.instance.setup();
         SoundManager.instance.setup(_configXml);
         GameBaseQueueManager.instance.setup();
         CoreTransactionManager.getInstance().setup();
         SocketSceneBufferManager.instance.setup();
         FullBar.instance.hide();
         TaskTraceTipManager.instance.setup();
         EmailManager.instance.setup();
         CustomerServiceManager.instance.setup();
      }
      
      private function loginOverCall() : void
      {
         PlayerManager.instance.removeEventListener("LOGIN_SUCCESS",__tryLoadStartupResource);
         StartupResourcesLoader.instance.removeEventListener("coreSetupLoadComplete",__onCoreSetupLoadComplete);
         StartupResourcesLoader.instance.removeEventListener("coreUILoadComplete",__coreLoadCompleteHandler);
         StartupResourcesLoader.instance.dispose();
         TaskManage.instance.loadData();
         ConsortiaManager.instance.setup();
         WorldBossManager.instance.setup();
         if(_userInfo.isActive)
         {
            openCache();
         }
         else
         {
            ExternalInterfaceManager.instance.setFavorite(PathManager.forwardSite,PathManager.forwardName);
         }
         var _loc1_:ExitGameUtils = new ExitGameUtils();
         _loc1_.setup();
      }
      
      private function setupComponent() : void
      {
         ComponentEmbed;
         ComponentSetting.COMBOX_LIST_LAYER = LayerManager.Instance.getLayerByType(2);
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.mutiline = true;
         _loc1_.buttonGape = 15;
         _loc1_.autoDispose = true;
         _loc1_.closeSoundFunc = closeSoundPlay;
         _loc1_.submitSoundFunc = submitSoundPlay;
         AlertManager.Instance.setup(1,_loc1_);
         Frame.closeSoundFunc = frameCloseSoundPlay;
         Frame.submitSoundFunc = frameSubmitSoundPlay;
      }
      
      private function get marryController() : MarryController
      {
         return FrameControllerManager.instance.marryController;
      }
      
      private function closeSoundPlay() : void
      {
         SoundManager.instance.play("008");
      }
      
      private function submitSoundPlay(param1:Boolean = true) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function frameCloseSoundPlay() : void
      {
         SoundManager.instance.play("008");
      }
      
      private function frameSubmitSoundPlay() : void
      {
         SoundManager.instance.play("022");
      }
   }
}

