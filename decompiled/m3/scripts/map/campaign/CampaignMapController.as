package map.campaign
{
   import bag.helper.BagHelper;
   import battle.BattleManager;
   import chat.datas.ChatData;
   import chat.view.ChatTopBugleView;
   import com.map.vehicle.VehicleChatController;
   import com.pickgliss.loader.DomainResourceLoad;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.battle.BaseItemMsg;
   import com.road.yishi.proto.battle.BattleReportMsg;
   import com.road.yishi.proto.campaign.CampaignConfirmMsg;
   import com.road.yishi.proto.campaign.HangupAttackMsg;
   import com.road.yishi.proto.campaign.NPCChaseMsg;
   import com.road.yishi.proto.campaign.NPCChatMsg;
   import com.road.yishi.proto.campaign.PlayerMoveMsg;
   import com.road.yishi.proto.campaign.PlayerNodeStateMsg;
   import com.road.yishi.proto.campaign.WarMovieMsg;
   import com.road.yishi.proto.marriage.MarriageProMsg;
   import com.road.yishi.proto.player.PlayerMoveCameraMsg;
   import com.road.yishi.proto.player.PlayerMovieMsg;
   import com.road.yishi.proto.simple.FightOverMoiveMsg;
   import farm.FarmManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.SmallMapBar;
   import mainBar.TipsBar;
   import manager.LanguageMgr;
   import managers.DungeoTurnManager;
   import managers.FreedomTeamManager;
   import managers.MarryManager;
   import managers.TaskTraceTipManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.MouseData;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.helper.gvgcross.GvgCrossResourceManager;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.mediator.bloody.BloodyManager;
   import map.campaign.mediator.fantasymatrix.FantasyMatrixMapView;
   import map.campaign.mediator.molong.MolongManager;
   import map.campaign.mediator.randomboss.RandomShaiziManager;
   import map.campaign.mediator.singlecampaign.SingleCampaignMapView;
   import map.campaign.preload.PreCampaignData;
   import map.campaign.preload.PreLoadNextCampaign;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.FootprintItems;
   import map.campaign.view.frame.ConsortiaBossDialogFrame;
   import map.campaign.view.frame.GodsEveningDialogFrame;
   import map.campaign.view.frame.MarryWeddingDialogFrame;
   import map.campaign.view.frame.MineralDialogFrame;
   import map.campaign.view.frame.NewbieVillageDialogFrame;
   import map.campaign.view.frame.PetLandDialogFrame;
   import map.campaign.view.frame.PrepareBattleFrame1;
   import map.campaign.view.frame.PrepareBattleFrame2;
   import map.campaign.view.frame.SacrificeRoomDialogFrame;
   import map.campaign.view.physics.ActiveVehicleArmyView;
   import map.campaign.view.physics.ActiveVehicleNpcAvater;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.physics.CampaignNpcPhysics;
   import map.campaign.view.physics.NpcAvatarView;
   import map.campaign.view.physics.UnrealShootingArmyView;
   import map.campaign.view.physics.UnrealShootingNpcAvatarView;
   import map.campaign.view.physics.UnrealShootingNpcPhysics;
   import map.internals.MapData;
   import map.internals.constant.ArmyState;
   import map.internals.constant.CreateCampaignType;
   import map.internals.constant.NodeState;
   import map.internals.data.CampaignNode;
   import map.internals.data.template.MapTemplate;
   import map.internals.findPath.AcorrsLineGrid;
   import map.internals.findPath.FindPath8;
   import map.internals.library.MapElmsLibrary;
   import map.internals.utils.Utils;
   import map.internals.utils.WalkRectScanUtils;
   import map.net.MapSocketOuterManager;
   import map.outercity.helper.mapview.MapViewHelper;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.marry.MarryModel;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.actions.map.BattleGetMoviesAction;
   import yishi.actions.map.CampaignActionsFactory;
   import yishi.actions.map.PlayerMoveAction;
   import yishi.actions.map.SceneMoveAction;
   import yishi.actions.map.pvp.ScoreOrGesteAction;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MarryQualityData;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.LocalConnectionManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.IconAlertHelper;
   import yishi.utils.MaskUtils;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.LoadingSceneView;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class CampaignMapController extends BaseSceneView
   {
      
      private var _view:CampaignMapView;
      
      private var _fantasyMatrixView:FantasyMatrixMapView;
      
      private var _singleCampaginMapView:SingleCampaignMapView;
      
      private var _mapModel:CampaignMapModel;
      
      private var _preLoad:PreCampaignData;
      
      private var _gotoCastleTimeId:int;
      
      private var _preFrameIsClose:Boolean = true;
      
      private var _preBattle:PrepareBattleFrame2;
      
      private var _battleFrame:PrepareBattleFrame1;
      
      private var _armyViewList:Array = [];
      
      private var _rectScanUtils:WalkRectScanUtils;
      
      private var _finPath:FindPath8;
      
      private var _algUtils:AcorrsLineGrid;
      
      private var _steelDoorIsOpen:Boolean = false;
      
      private var _curSelectedObject:Sprite;
      
      public function CampaignMapController()
      {
         super();
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         if(gotoOutCampaign())
         {
            return;
         }
         CampaignSocketManger.instance.setup(true);
         FootprintItems.setup();
         CampaignManager.instance.controller = this;
         _mapModel = CampaignManager.instance.mapModel;
         if(_mapModel && WorldBossHelper.checkPve())
         {
            preLoadingOver();
         }
         else
         {
            MapElmsLibrary.instance.lock();
            if(_mapModel && MapData.mapId == _mapModel.mapTempInfo.Id && MapData.mapBitmap && _mapModel.mapTielsData)
            {
               preLoadingOver();
            }
            else if(_mapModel)
            {
               if(_mapModel.createType == 3)
               {
                  LoadingSceneView.instance.show();
               }
               _preLoad = new PreCampaignData(_mapModel);
               _preLoad.syncBackCall(preLoadingOver);
            }
            if(_mapModel)
            {
               if(WorldBossHelper.checkActiveVehicle(_mapModel.mapId) || Boolean(WorldBossHelper.checkUnrealShooting(_mapModel.mapId)) || Boolean(WorldBossHelper.checkConsortiaEmeDream(_mapModel.mapId)))
               {
                  GvgCrossResourceManager.instance.setup();
               }
            }
         }
      }
      
      override protected function preLoadingOver() : void
      {
         LoadingSceneView.instance.hide();
         super.preLoadingOver();
      }
      
      private function gotoCastleScene() : void
      {
         if(_gotoCastleTimeId > 0)
         {
            clearInterval(_gotoCastleTimeId);
         }
         _gotoCastleTimeId = 0;
         SceneManager.instance.lock = false;
         SwitchPageHelp.returnToSpace();
      }
      
      private function gotoOutCampaign() : Boolean
      {
         if(CampaignManager.instance.exit)
         {
            _gotoCastleTimeId = setInterval(gotoCastleScene,1000);
            return true;
         }
         return false;
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         var _loc5_:Array = null;
         if(gotoOutCampaign())
         {
            return;
         }
         _mapModel.onCollectionId = 0;
         var _loc3_:int = _mapModel.mapTempInfo.Width / 20;
         var _loc4_:int = _mapModel.mapTempInfo.Height / 20;
         if(WorldBossHelper.checkPve())
         {
            _singleCampaginMapView = new SingleCampaignMapView();
            CampaignManager.instance.mapView = _singleCampaginMapView;
            addChild(_singleCampaginMapView);
         }
         else
         {
            _finPath = new FindPath8(_loc3_,_loc4_,_mapModel.mapTielsData);
            _algUtils = new AcorrsLineGrid(_finPath,_mapModel);
            _rectScanUtils = new WalkRectScanUtils();
            if(WorldBossHelper.checkFantasyMatrix(_mapModel.mapId))
            {
               _fantasyMatrixView = new FantasyMatrixMapView();
               CampaignManager.instance.mapView = _fantasyMatrixView;
               addChild(_fantasyMatrixView);
            }
            else
            {
               _view = new CampaignMapView();
               CampaignManager.instance.mapView = _view;
               addChild(_view);
            }
         }
         _mapModel.createType = -1;
         addEvent();
         if(ExternalInterface.available && Boolean(LocalConnectionManager.instance.isUse))
         {
            _loc5_ = [_mapModel.mapTielsData];
            LocalConnectionManager.instance.Call("initCampaignTitles",_loc5_,searchPathSyc,null);
         }
         if(_mapModel.campaignTemplate.Types == 3)
         {
            SmallMapBar.instance.switchSmallMapState(5);
            FarmManager.instance.model.preMapId = _mapModel.campaignTemplate.CampaignId;
         }
         else if(_mapModel.campaignTemplate.Types == 10 || _mapModel.campaignTemplate.Types == 11 || _mapModel.campaignTemplate.Types == 99)
         {
            FarmManager.instance.model.preMapId = _mapModel.campaignTemplate.CampaignId;
         }
      }
      
      private function searchPathSyc(param1:Array, param2:Object) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("map.campaign.CampaignMapController.command01");
         MessageTipManager.instance().show(_loc3_);
      }
      
      override public function leaving() : void
      {
         removeEvent();
         saveBitmap();
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(_fantasyMatrixView)
         {
            ObjectUtils.disposeObject(_fantasyMatrixView);
         }
         _fantasyMatrixView = null;
         if(_singleCampaginMapView)
         {
            ObjectUtils.disposeObject(_singleCampaginMapView);
         }
         _singleCampaginMapView = null;
         if(_mapModel)
         {
            _mapModel.nineSliceScaling = [];
         }
         CampaignManager.instance.mapView = null;
         _curSelectedObject = null;
         FullBar.instance.hide();
         MainToolBar.instance.hide();
         TopToolsBar.instance.hide();
         TipsBar.instance.hide();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         SmallMapBar.instance.hide();
         TaskTraceBar.instance.hide();
         ShowTipManager.Instance.removeCurrentTip();
         BagHelper.instance.stopSelling();
         MaskUtils.instance.dispose();
         if(CampaignManager.instance.exit)
         {
            CampaignManager.instance.dispose();
            CampaignSocketManger.instance.dispose();
         }
         if(_preBattle)
         {
            KeyBoardRegister.instance.keyEnable = true;
            _preBattle.dispose();
            _preBattle = null;
         }
         if(_battleFrame)
         {
            _battleFrame.dispose();
         }
         _battleFrame = null;
         CampaignManager.instance.controller = null;
         if(_rectScanUtils)
         {
            _rectScanUtils.getWalkable = null;
            _rectScanUtils.dispose();
            _rectScanUtils = null;
         }
         MapElmsLibrary.instance.unLock();
         if(_finPath)
         {
            _finPath.dispose();
         }
         _finPath = null;
         if(_algUtils)
         {
            _algUtils.dispose();
         }
         _algUtils = null;
         ObjectUtils.disposeAllChildren(this);
         _preLoad = null;
         if(_mapModel && _mapModel.exit)
         {
            if(_mapModel.campaignTemplate.Types == 13)
            {
               MolongManager.instance.dispose();
            }
            if(WorldBossHelper.checkBloody(_mapModel.mapId))
            {
               RandomShaiziManager.instance.dispose();
            }
            if(WorldBossHelper.checkActiveVehicle(_mapModel.mapId))
            {
               GvgCrossResourceManager.instance.dispose();
            }
            if(WorldBossHelper.checkUnrealShooting(_mapModel.mapId))
            {
               GvgCrossResourceManager.instance.dispose();
            }
            if(WorldBossHelper.checkConsortiaEmeDream(_mapModel.mapId))
            {
               GvgCrossResourceManager.instance.dispose();
            }
            KeyBoardRegister.instance.vehicleFlag = false;
            MapData.clearData();
            _mapModel.dispose();
            _mapModel = null;
            CampaignManager.instance.controller = null;
         }
         else
         {
            if(_mapModel.campaignTemplate.Types == 13)
            {
               MolongManager.instance.forBattle();
            }
            if(_mapModel.campaignTemplate.AreaId == 302)
            {
               RandomShaiziManager.instance.forBattle();
            }
         }
         FarmManager.instance.model.bigBonFireIsOpen = false;
         PlayerManager.instance.currentPlayerModel.selectTarget = null;
         DomainResourceLoad.clearDomainResource();
      }
      
      private function saveBitmap() : void
      {
         if(WorldBossHelper.checkFantasyMatrix(_mapModel.mapId))
         {
            return;
         }
         if(!_mapModel || !_view || !_view.staticRenderLayer)
         {
            return;
         }
         if(_mapModel.exit)
         {
            return;
         }
         MapData.mapBitmap = _view.staticRenderLayer.bitmap;
         MapData.mapId = _mapModel.mapTempInfo.Id;
         MapData.stageWidth = StageReferance.stageWidth;
         MapData.stageHeight = StageReferance.stageHeight;
         MapData.movePos = null;
      }
      
      override public function enterOver() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Rectangle = null;
         SceneManager.instance.removeSceneType();
         TopToolsBar.instance.show();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         FullBar.instance.show();
         ChatBar.instance.show();
         ChatTopBugleView.instance.setPos();
         ResourcesBar.instance.show();
         FootprintItems.dispose();
         var _loc3_:Boolean = _mapModel.campaignTemplate.SonTypes != 0;
         if(_loc3_ || Boolean(WorldBossHelper.checkWorldBoss(_mapModel.mapId)) || Boolean(WorldBossHelper.checkPvp(_mapModel.mapId)) || Boolean(WorldBossHelper.checkDuskArea(_mapModel.mapId)) || Boolean(WorldBossHelper.checkIceFireTemple(_mapModel.mapId)) || Boolean(WorldBossHelper.checkMineral(_mapModel.mapId)) || Boolean(WorldBossHelper.checkWedding(_mapModel.mapId)) || Boolean(WorldBossHelper.checkFlameTemple(_mapModel.mapId)) || Boolean(WorldBossHelper.checkInHouse(_mapModel.mapId)) || Boolean(WorldBossHelper.checkInQuizActivity(_mapModel.mapId)) || Boolean(WorldBossHelper.checkMonopoly(_mapModel.mapId)) || Boolean(WorldBossHelper.checkMarket(_mapModel.mapId)) || Boolean(WorldBossHelper.checkFarm(_mapModel.mapId)) || Boolean(WorldBossHelper.checkActiveVehicle(_mapModel.mapId)) || Boolean(WorldBossHelper.checkSteel(_mapModel.mapId)) || Boolean(WorldBossHelper.checkConsortiaSecretLand(_mapModel.mapId)) || Boolean(WorldBossHelper.checkFantasyMatrix(_mapModel.mapId)) || Boolean(WorldBossHelper.checkUnrealShooting(_mapModel
         .mapId)) || Boolean(WorldBossHelper.checkGodsEvening(_mapModel.mapId)) || Boolean(WorldBossHelper.checkConsortiaEmeDream(_mapModel.mapId)) || Boolean(WorldBossHelper.checkAirGarden(_mapModel.mapId)) || Boolean(WorldBossHelper.checkForbiddenBoss(_mapModel.mapId)))
         {
            TaskTraceBar.instance.hide();
         }
         else
         {
            _loc1_ = _mapModel.campaignTemplate.Capacity > 1;
            if(_loc1_ && _mapModel.campaignTemplate.Types == 0 && Boolean(CreateCampaignType.checkGoToTeamChat(_mapModel.createType)))
            {
               NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",6);
            }
            TaskTraceBar.instance.show();
         }
         if(WorldBossHelper.checkWorldBoss(_mapModel.mapId) || Boolean(WorldBossHelper.checkWedding(_mapModel.mapId)) || Boolean(WorldBossHelper.checkInHouse(_mapModel.mapId)) || Boolean(WorldBossHelper.checkFarm(_mapModel.mapId)) || Boolean(WorldBossHelper.checkActiveVehicle(_mapModel.mapId)) || Boolean(WorldBossHelper.checkConsortiaEmeDream(_mapModel.mapId)) || Boolean(WorldBossHelper.checkSteel(_mapModel.mapId)) || Boolean(WorldBossHelper.checkUnrealShooting(_mapModel.mapId)))
         {
            SmallMapBar.instance.hide();
         }
         else
         {
            SmallMapBar.instance.show();
         }
         if(WorldBossHelper.checkWedding(_mapModel.mapId) || Boolean(WorldBossHelper.checkUnrealShooting(_mapModel.mapId)))
         {
            TaskTraceTipManager.instance.cleanByType(19);
            TaskTraceTipManager.instance.cleanByType(14);
            TaskTraceTipManager.instance.cleanByType(41);
         }
         CampaignManager.instance.controller = this;
         if(!WorldBossHelper.checkPetLand(_mapModel.mapId) && !WorldBossHelper.checkIsNoviceMap(_mapModel.mapId))
         {
            new PreLoadNextCampaign(_mapModel).mapId = _mapModel.mapId;
         }
         if(_view)
         {
            _loc2_ = MapViewHelper.getCurrentMapRect(_view);
            moveMapCallBack(_loc2_);
         }
         if(WorldBossHelper.checkIsNoviceMap(_mapModel.mapId))
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_OUT_SCENE"));
         }
         else if(WorldBossHelper.checkPetLand(_mapModel.mapId) || Boolean(WorldBossHelper.checkMineral(_mapModel.mapId)))
         {
            FarmManager.instance.showGatherCropTip();
            FarmManager.instance.model.needReturnSpace = true;
         }
         if(_mapModel.campaignTemplate.Types == 13)
         {
            MolongManager.instance.molongInit();
         }
         if(_mapModel.campaignTemplate.AreaId == 304)
         {
            BloodyManager.instance.molongInit();
         }
         if(WorldBossHelper.checkBloody(_mapModel.mapId))
         {
            RandomShaiziManager.instance.init();
         }
         if(WorldBossHelper.checkSteel(_mapModel.mapId))
         {
            MainToolBar.instance.hide();
            MainToolBar.instance.poptipButtonVisible = false;
            ResourcesBar.instance.hide();
            ChatBar.instance.hide();
            ChatBar.inBattleFlag = true;
            VehicleChatController.getInstance().start();
         }
         if(WorldBossHelper.checkActiveVehicle(_mapModel.mapId))
         {
            TopToolsBar.instance.hide();
            MainToolBar.instance.hide();
            MainToolBar.instance.poptipButtonVisible = false;
            ResourcesBar.instance.hide();
            ChatBar.instance.hide();
            ChatBar.inBattleFlag = true;
            VehicleChatController.getInstance().start();
         }
         if(WorldBossHelper.checkFarm(_mapModel.mapId))
         {
            ResourcesBar.instance.hide();
            TopToolsBar.instance.hide();
            MainToolBar.instance.updateFriendNoticeBtnPos(false,true);
         }
         if(WorldBossHelper.checkInHouse(_mapModel.mapId))
         {
            MainToolBar.instance.updateFriendNoticeBtnPos(false,true);
         }
         if(WorldBossHelper.checkSacrificeRoom(_mapModel.mapId) || Boolean(WorldBossHelper.checkAirGarden(_mapModel.mapId)))
         {
            TopToolsBar.instance.hide();
         }
         if(WorldBossHelper.checkUnrealShooting(_mapModel.mapId))
         {
            MainToolBar.instance.hide();
            MainToolBar.instance.poptipButtonVisible = false;
            ResourcesBar.instance.hide();
            ChatBar.instance.hide();
            ChatBar.inBattleFlag = true;
            VehicleChatController.getInstance().start();
         }
         if(WorldBossHelper.checkGodsEvening(_mapModel.mapId))
         {
            MainToolBar.instance.updateFriendNoticeBtnPos(false,true);
         }
         findTarget();
      }
      
      private function findTarget(param1:NotificationEvent = null) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Point = null;
         var _loc2_:Object = PlayerManager.instance.currentPlayerModel.campaignFindTarget;
         if(!_loc2_)
         {
            return;
         }
         if(!_loc2_.hasOwnProperty("mapId"))
         {
            return;
         }
         if(!_loc2_.hasOwnProperty("targetPoint"))
         {
            return;
         }
         _loc4_ = int(_loc2_["mapId"]);
         _loc3_ = _loc2_["targetPoint"] as Point;
         if(_loc4_ == _mapModel.mapId && _loc3_)
         {
            PlayerManager.instance.currentPlayerModel.campaignFindTarget = null;
            CampaignManager.instance.controller.moveArmyByPos(_loc3_.x,_loc3_.y);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function moveMapCallBack(param1:Rectangle) : void
      {
         _mapModel.targetPoint = new Point(param1.x,param1.y);
         _mapModel.nineSliceScaling = Utils.getNineSliceScaling(param1);
         var _loc2_:Array = _mapModel.checkConfigNoExites();
         if(_loc2_.length > 0)
         {
            _mapModel.currentFloorData = _loc2_;
         }
      }
      
      override public function get SceneName() : String
      {
         return "CAMPAIGN_MAP_SCENE";
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("SLGSocketEvent" + 142,__campaignSceneMoveHandler);
         NotificationManager.instance.addEventListener("U_PLAY_MOVIE",__playNodeMovieHandler);
         _mapModel.addEventListener("ATTACK_BOSS_TEMA",__refreshTeamHandler);
         _mapModel.addEventListener("ATTACK_BOSS_INVITE",__showInviteHandler);
         _mapModel.addEventListener("ATTACK_BOSS_NOTICE",__attackNoticeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4382,__playGetMovieHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4269,__warMovieHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4162,__playerMoveHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 29,__confirmFrameHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4268,__resetFallHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4163,__npcChatHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4105,__npcChaseArmyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4421,__onPKRequestHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4208,__playerTranseferStateHandler);
         NotificationManager.instance.addEventListener("UN_LOCK_NODE",__unlockNodeHandler);
         NotificationManager.instance.addEventListener("SELF_HELP_RESET_POSITION",__resetPositionHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4676,__weddingAutoMove);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4660,__oathHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SLGSocketEvent" + 142,__campaignSceneMoveHandler);
         NotificationManager.instance.removeEventListener("U_PLAY_MOVIE",__playNodeMovieHandler);
         if(_mapModel)
         {
            _mapModel.removeEventListener("ATTACK_BOSS_TEMA",__refreshTeamHandler);
            _mapModel.removeEventListener("ATTACK_BOSS_INVITE",__showInviteHandler);
            _mapModel.removeEventListener("ATTACK_BOSS_NOTICE",__attackNoticeHandler);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4382,__playGetMovieHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4269,__warMovieHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4162,__playerMoveHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 29,__confirmFrameHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4268,__resetFallHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4163,__npcChatHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4105,__npcChaseArmyHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4421,__onPKRequestHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4208,__playerTranseferStateHandler);
         NotificationManager.instance.removeEventListener("UN_LOCK_NODE",__unlockNodeHandler);
         NotificationManager.instance.removeEventListener("SELF_HELP_RESET_POSITION",__resetPositionHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4676,__weddingAutoMove);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4660,__oathHandler);
      }
      
      private function __weddingAutoMove(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageProMsg = new MarriageProMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MarriageProMsg;
         if(MarryManager.instance.model.isWeddingMaster)
         {
            moveArmyByPos(_loc2_.property6 * 20,_loc2_.property7 * 20,false,true);
         }
         MsgMan.notifyObserver("MarryEventType.WEDDING_AUTOMOVE",_loc2_);
      }
      
      private function __oathHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageProMsg = new MarriageProMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MarriageProMsg;
         MsgMan.notifyObserver("MarryEventType.WEDDING_OATH",_loc2_);
      }
      
      private function __playerTranseferStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerNodeStateMsg = new PlayerNodeStateMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlayerNodeStateMsg;
         var _loc3_:CampaignArmy = _mapModel.getUserArmyByArmyId(_loc2_.armyId);
         if(_loc3_)
         {
            _loc3_.setTranseferWait(_loc2_.isStand,_loc2_.nodeId,_loc2_.mapId);
         }
      }
      
      private function __onPKRequestHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HangupAttackMsg = new HangupAttackMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HangupAttackMsg;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CAMPAIGN_PK",_loc2_));
      }
      
      private function __npcChaseArmyHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:NPCChaseMsg = new NPCChaseMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as NPCChaseMsg;
         _mapModel.npcChase(_loc2_);
         _loc3_ = null;
      }
      
      private function __npcChatHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:NPCChatMsg = new NPCChatMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as NPCChatMsg;
         var _loc4_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc4_.uid = _loc2_.id;
         _loc4_.msg = _loc2_.content;
         _loc4_.commit();
         var _loc3_:CampaignNode = _mapModel.getMapNodesById(_loc2_.id);
         if(_loc3_)
         {
            _loc3_.chatData = _loc4_;
         }
      }
      
      private function __resetFallHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:Array = null;
         var _loc4_:int = 0;
         var _loc7_:BaseItemMsg = null;
         var _loc6_:int = 0;
         var _loc3_:GoodsInfo = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:BattleReportMsg = new BattleReportMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as BattleReportMsg;
         var _loc8_:CampaignNode = _mapModel.getNodeBySindId(_loc2_.signId);
         if(_loc8_)
         {
            _loc5_ = [];
            _loc4_ = int(_loc2_.baseItem.length);
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = _loc2_.baseItem[_loc6_] as BaseItemMsg;
               _loc3_ = new GoodsInfo();
               _loc3_.templateId = _loc7_.templateId;
               _loc3_.count = _loc7_.count;
               _loc5_.push(_loc3_);
               _loc6_++;
            }
            _loc8_.tempData = _loc5_;
            _loc8_.info.state = 1;
            if(_loc8_.nodeView.hasOwnProperty("goods"))
            {
               _loc8_.nodeView["goods"] = _loc5_;
            }
            _loc8_.commit();
         }
      }
      
      private function __confirmFrameHandler(param1:SLGSocketEvent) : void
      {
         var _loc18_:DisplayObject = null;
         var _loc10_:CampaignNode = null;
         var _loc9_:String = null;
         var _loc3_:String = null;
         var _loc14_:String = null;
         var _loc16_:String = null;
         var _loc12_:String = null;
         var _loc11_:String = null;
         if(!_preFrameIsClose)
         {
            return;
         }
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignConfirmMsg = new CampaignConfirmMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as CampaignConfirmMsg;
         var _loc4_:String = _loc2_.title;
         var _loc8_:String = _loc2_.body;
         var _loc15_:int = int(_loc2_.hasItemTempId ? _loc2_.itemTempId : null);
         var _loc7_:int = _loc2_.itemCount;
         var _loc13_:int = _loc2_.mapId;
         var _loc17_:int = _loc2_.nodeId;
         var _loc5_:int = _loc2_.type;
         if(_loc5_ == 14)
         {
            _loc8_ = getMessage();
         }
         if(StringHelper.isNullOrEmpty(_loc8_) && _loc5_ < 4)
         {
            __callServerSccess(false,_loc13_,_loc17_);
            return;
         }
         _preFrameIsClose = false;
         if(_loc5_ == 0)
         {
            IconAlertHelper.instance.data = [__callServerSccess,_loc13_,_loc17_];
            _loc9_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            IconAlertHelper.instance.popAlertFrame(_loc4_,_loc8_,_loc15_,_loc7_,_loc9_,_loc3_);
            IconAlertHelper.instance.addEventListener("dispose",__disposeHandler);
         }
         else if(_loc5_ == 2)
         {
            _loc18_ = ComponentFactory.Instance.creatComponentByStylename("campaign.SubmitResourcesFrame");
            _loc18_["mapId"] = _loc13_;
            _loc18_["nodeId"] = _loc17_;
            _loc18_["show"](__callServerSccess);
            _loc18_.addEventListener("dispose",__disposeHandler);
         }
         else if(_loc5_ == 3)
         {
            _loc18_ = ComponentFactory.Instance.creatCustomObject("campaign.TrailDialogView");
            _loc18_["title"] = _loc4_;
            _loc18_["content"] = _loc8_;
            _loc18_["mapId"] = _loc13_;
            _loc18_["nodeId"] = _loc17_;
            _loc18_["show"](__callServerSccess);
            _loc18_.addEventListener("dispose",__disposeHandler);
         }
         else if(_loc5_ == 4)
         {
            _loc10_ = _mapModel.getMapNodeByNodeId(_loc17_);
            _loc18_ = ComponentFactory.Instance.creatComponentByStylename("campaign.PetLandDialogFrame");
            (_loc18_ as PetLandDialogFrame).mapId = _loc13_;
            _loc18_.addEventListener("dispose",__disposeHandler);
            (_loc18_ as PetLandDialogFrame).show(_loc10_);
         }
         else if(_loc5_ == 5)
         {
            _loc10_ = _mapModel.getMapNodeByNodeId(_loc17_);
            _loc18_ = ComponentFactory.Instance.creatComponentByStylename("campaign.MineralDialogFrame");
            (_loc18_ as MineralDialogFrame).mapId = _loc13_;
            _loc18_.addEventListener("dispose",__disposeHandler);
            (_loc18_ as MineralDialogFrame).show(_loc10_);
         }
         else if(_loc5_ == 6)
         {
            IconAlertHelper.instance.data = [__mineralConfirmCall,_loc13_,_loc17_];
            _loc14_ = LanguageMgr.GetTranslation("public.confirm");
            _loc16_ = LanguageMgr.GetTranslation("public.cancel");
            IconAlertHelper.instance.popAlertFrame(_loc4_,_loc8_,_loc15_,_loc7_,_loc14_,_loc16_);
            IconAlertHelper.instance.addEventListener("dispose",__disposeHandler);
         }
         else if(_loc5_ == 10)
         {
            _loc18_ = ComponentFactory.Instance.creatCustomObject("campaign.TrailDialogView");
            _loc18_["title"] = _loc4_;
            _loc18_["content"] = _loc8_;
            _loc18_["mapId"] = _loc13_;
            _loc18_["nodeId"] = _loc17_;
            _loc18_["show"](__callServerSccess);
            _loc18_.addEventListener("dispose",__disposeHandler);
         }
         else if(_loc5_ == 11 || _loc5_ == 12)
         {
            _loc10_ = _mapModel.getMapNodeByNodeId(_loc17_);
            _loc18_ = ComponentFactory.Instance.creatComponentByStylename("campaign.MarryWeddingDialogFrame");
            (_loc18_ as MarryWeddingDialogFrame).mapId = _loc13_;
            _loc18_.addEventListener("dispose",__disposeHandler);
            (_loc18_ as MarryWeddingDialogFrame).show(_loc10_);
         }
         else if(_loc5_ == 13)
         {
            _loc10_ = _mapModel.getMapNodeByNodeId(_loc17_);
            _loc18_ = ComponentFactory.Instance.createComponentGroupByStylename("campaign.NewbieVillageDialogFrame",true);
            _loc18_.addEventListener("dispose",__disposeHandler);
            NewbieVillageDialogFrame(_loc18_).nodeInfo = _loc10_;
            NewbieVillageDialogFrame(_loc18_).show();
         }
         else if(_loc5_ == 14)
         {
            IconAlertHelper.instance.data = [__callServerSccess,_loc13_,_loc17_];
            _loc12_ = LanguageMgr.GetTranslation("public.confirm");
            _loc11_ = LanguageMgr.GetTranslation("public.cancel");
            IconAlertHelper.instance.popAlertFrame(_loc4_,_loc8_,_loc15_,_loc7_,_loc12_,_loc11_,true);
            IconAlertHelper.instance.addEventListener("dispose",__disposeHandler);
         }
         else if(_loc5_ == 15)
         {
            _loc10_ = _mapModel.getMapNodeByNodeId(_loc17_);
            _loc18_ = ComponentFactory.Instance.creatComponentByStylename("campaign.SacrificeRoomDialogFrame");
            (_loc18_ as SacrificeRoomDialogFrame).mapId = _loc13_;
            _loc18_.addEventListener("dispose",__disposeHandler);
            (_loc18_ as SacrificeRoomDialogFrame).show(_loc10_);
         }
         else if(_loc5_ == 16)
         {
            _loc10_ = _mapModel.getMapNodeByNodeId(_loc17_);
            _loc18_ = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaBossDialogFrame");
            (_loc18_ as ConsortiaBossDialogFrame).mapId = _loc13_;
            _loc18_.addEventListener("dispose",__disposeHandler);
            (_loc18_ as ConsortiaBossDialogFrame).show(_loc10_);
         }
         else if(_loc5_ == 18)
         {
            _loc10_ = _mapModel.getMapNodeByNodeId(_loc17_);
            _loc18_ = ComponentFactory.Instance.creatComponentByStylename("campaign.GodsEveningDialogFrame");
            (_loc18_ as GodsEveningDialogFrame).mapId = _loc13_;
            _loc18_.addEventListener("dispose",__disposeHandler);
            (_loc18_ as GodsEveningDialogFrame).show(_loc10_);
         }
         else if(_loc5_ == 19)
         {
            _loc18_ = ComponentFactory.Instance.creatCustomObject("campaign.TrailDialogView");
            _loc18_["title"] = _loc4_;
            _loc18_["content"] = _loc8_;
            _loc18_["mapId"] = _loc13_;
            _loc18_["nodeId"] = _loc17_;
            _loc18_["show"](showFrame);
            _loc18_.addEventListener("dispose",__disposeHandler);
         }
         else
         {
            _loc18_ = ComponentFactory.Instance.creatComponentByStylename("campaign.HookAlertFrame");
            _loc18_["mapId"] = _loc13_;
            _loc18_["nodeId"] = _loc17_;
            _loc18_["show"](hookAlertBack);
            _loc18_.addEventListener("dispose",__disposeHandler);
         }
      }
      
      private function showFrame(param1:Boolean, param2:int, param3:int) : void
      {
         DungeoTurnManager.instance.openTurn();
      }
      
      private function getMessage() : String
      {
         var _loc3_:int = 0;
         var _loc2_:MarryQualityData = null;
         var _loc1_:String = "";
         if(WorldBossHelper.checkWedding(CampaignManager.instance.mapId))
         {
            if(MarryManager.instance.model.isWeddingMaster)
            {
               if(MarryManager.instance.model.isEngaged)
               {
                  return LanguageMgr.GetTranslation("MainToolBar.extWeddingRoom02");
               }
               _loc3_ = int(MarryManager.instance.model.roomInfo.property7);
               _loc2_ = TempleteManager.instance.getMarryQualityTemplateCate.getTempById(_loc3_);
               if(!_loc2_ || Boolean(StringHelper.isNullOrEmpty(_loc2_.Path)))
               {
                  return LanguageMgr.GetTranslation("MainToolBar.extWeddingRoom03");
               }
            }
         }
         return LanguageMgr.GetTranslation("MainToolBar.extWeddingRoom01");
      }
      
      private function hookAlertBack(param1:Boolean, param2:int, param3:int) : void
      {
         MapSocketOuterManager.sendFrameCallBack(param2,param3,param1);
      }
      
      private function __disposeHandler(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("dispose",__disposeHandler);
         _preFrameIsClose = true;
      }
      
      private function __mineralConfirmCall(param1:Boolean, param2:int, param3:int) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendSessionOverToBattle(param2,param3,2);
         }
      }
      
      private function __callServerSccess(param1:Boolean, param2:int, param3:int) : void
      {
         MapSocketOuterManager.sendFrameCallBack(param2,param3,param1);
      }
      
      private function __playerMoveHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,BattleManager.preScene,createPlayerMoveAction);
      }
      
      private function createPlayerMoveAction(param1:PackageIn) : void
      {
         var _loc2_:PlayerMoveMsg = new PlayerMoveMsg();
         _loc2_ = param1.readBody(_loc2_) as PlayerMoveMsg;
         GameBaseQueueManager.instance.addAction(new PlayerMoveAction(_loc2_));
         param1 = null;
      }
      
      private function __warMovieHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",playerMovie);
      }
      
      private function playerMovie(param1:PackageIn) : void
      {
         var _loc2_:WarMovieMsg = new WarMovieMsg();
         _loc2_ = param1.readBody(_loc2_) as WarMovieMsg;
         GameBaseQueueManager.instance.addAction(new ScoreOrGesteAction(_loc2_));
      }
      
      private function __playGetMovieHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            playGetMovie(_loc2_);
         }
         else
         {
            SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",playGetMovie);
         }
      }
      
      private function playGetMovie(param1:PackageIn) : void
      {
         var _loc2_:FightOverMoiveMsg = null;
         var _loc3_:CampaignArmy = null;
         if(_mapModel && param1)
         {
            _loc2_ = new FightOverMoiveMsg();
            _loc2_ = param1.readBody(_loc2_) as FightOverMoiveMsg;
            _loc3_ = _mapModel.selfMemberData;
            if(_loc3_)
            {
               GameBaseQueueManager.instance.addAction(new BattleGetMoviesAction(_loc3_,_loc2_));
            }
            _loc3_ = null;
            _loc2_ = null;
         }
      }
      
      private function exitSubmitBack(param1:Boolean) : void
      {
         if(param1)
         {
            CampaignSocketOutManager.instance.sendExitCampaignScene(currentArmyId);
         }
      }
      
      private function __refreshTeamHandler(param1:CampaignMapEvent) : void
      {
         if(_preBattle && !_preBattle.isDie)
         {
            _preBattle.data = param1.data;
            return;
         }
         if(_preBattle && _preBattle.isDie)
         {
            _preBattle = null;
         }
         _preBattle = ComponentFactory.Instance.creatComponentByStylename("map.campaign.PrepareBattleFrame2");
         _preBattle.show();
         KeyBoardRegister.instance.keyEnable = false;
         _preBattle.data = param1.data;
      }
      
      private function __showInviteHandler(param1:CampaignMapEvent) : void
      {
         if(_battleFrame && !_battleFrame.isDie)
         {
            return;
         }
         _battleFrame = ComponentFactory.Instance.creatComponentByStylename("map.campaign.PrepareBattleFrame1");
         _battleFrame.data = param1.data;
         _battleFrame.show();
      }
      
      private function __campaignSceneMoveHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerMoveCameraMsg = new PlayerMoveCameraMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlayerMoveCameraMsg;
         GameBaseQueueManager.instance.addAction(new SceneMoveAction(_loc2_.targetX,_loc2_.targetY));
         _loc2_ = null;
         _loc3_ = null;
      }
      
      private function __playNodeMovieHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:CampaignArmy = null;
         var _loc5_:Object = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerMovieMsg = new PlayerMovieMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as PlayerMovieMsg;
         if(_loc2_.movieTargetType == 0 && _view)
         {
            _loc3_ = _view.getNpcNodeById(_loc2_.targetId);
         }
         else if(_loc2_.movieTargetType == 1)
         {
            _loc4_ = _mapModel.getUserArmyByArmyId(_loc2_.targetId);
            _loc5_ = CampaignManager.instance.controller.getArmyView(_loc4_);
            if(_loc4_)
            {
               _loc3_ = _loc5_;
            }
         }
         if(_loc3_)
         {
            _mapModel.updateFog(_loc3_.x,_loc3_.y,2);
         }
         CampaignActionsFactory.createAction(_loc2_.movieType,_loc3_,_loc6_,75,_loc2_.targetId);
      }
      
      public function sceneMove(param1:int, param2:int, param3:Function = null) : void
      {
         GameBaseQueueManager.instance.addAction(new SceneMoveAction(param1,param2,param3));
      }
      
      private function get consortiaModel() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      public function getArmyView(param1:BaseArmy) : Object
      {
         if(!param1)
         {
            return null;
         }
         for each(var _loc2_:Object in _armyViewList)
         {
            if(_loc2_)
            {
               if(_loc2_.data)
               {
                  if(_loc2_.data == param1 || _loc2_.data.userId == param1.userId)
                  {
                     return _loc2_;
                  }
               }
            }
         }
         return null;
      }
      
      public function addArmyView(param1:Object) : void
      {
         _armyViewList.push(param1);
      }
      
      public function removeArmyView(param1:Object) : void
      {
         var _loc2_:int = _armyViewList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _armyViewList.splice(_loc2_,1);
         }
      }
      
      public function getArmyGvgFight(param1:Boolean = false) : BaseArmy
      {
         var _loc3_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:CampaignArmy = _mapModel.selfMemberData;
         var _loc5_:Object = getArmyView(_loc4_);
         for each(var _loc2_:CampaignArmy in _mapModel.allUserArmy)
         {
            _loc3_ = getArmyView(_loc2_);
            if(_loc3_)
            {
               _loc6_ = _loc5_.x - _loc3_.x;
               _loc7_ = _loc5_.y - _loc3_.y;
               _loc8_ = _loc6_ * _loc6_ + _loc7_ * _loc7_;
               if(_loc8_ < 10000)
               {
                  if(param1)
                  {
                     if(_loc2_.teamId != _loc4_.teamId || !ArmyState.checkCampaignAttack(_loc2_.state))
                     {
                        return _loc2_;
                     }
                  }
                  else if(_loc2_.baseHero.consortiaID != _loc4_.baseHero.consortiaID || !ArmyState.checkCampaignAttack(_loc2_.state))
                  {
                     return _loc2_;
                  }
               }
            }
         }
         return null;
      }
      
      private function get campaignTempInfo() : MapTemplate
      {
         if(_mapModel)
         {
            return _mapModel.mapTempInfo;
         }
         return null;
      }
      
      private function get currentArmyId() : int
      {
         return ArmyManager.instance.army.id;
      }
      
      private function initRectScan() : void
      {
         _rectScanUtils.outWidth = _mapModel.mapTempInfo.Width / 20;
         _rectScanUtils.outHeight = _mapModel.mapTempInfo.Height / 20;
         _rectScanUtils.getWalkable = getWalkable;
      }
      
      public function get findPath() : FindPath8
      {
         return _finPath;
      }
      
      public function searchPath(param1:Point, param2:Point) : Array
      {
         if(_finPath && _algUtils)
         {
            return _algUtils.getPsnode(_finPath.find(param1,param2));
         }
         return null;
      }
      
      private function __resetPositionHandler(param1:NotificationEvent) : void
      {
         var _loc2_:CampaignArmy = _mapModel.selfMemberData;
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:Object = getArmyView(_loc2_);
         if(!_loc5_)
         {
            return;
         }
         var _loc3_:int = _loc5_.x / 20;
         var _loc4_:int = _loc5_.y / 20;
         if(getWalkable(_loc3_,_loc4_))
         {
            if(!_mapModel.getMapNodesByPoint(new Point(_loc3_,_loc4_)))
            {
               return;
            }
         }
         var _loc6_:Point = _mapModel.getNeighborII(_loc3_,_loc4_);
         if(_loc6_)
         {
            if(!_mapModel.getMapNodesByPoint(_loc6_))
            {
               return;
            }
         }
         _loc6_ = _mapModel.getNeighborIII(_loc3_,_loc4_);
         if(!_loc6_)
         {
            return;
         }
         _loc5_.x = _loc6_.x * 20;
         _loc5_.y = _loc6_.y * 20;
      }
      
      private function checkSteelMapChange() : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc10_:Dictionary = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         if(WorldBossHelper.checkSteel(_mapModel.mapId))
         {
            if(_mapModel.steelMapIsChanged)
            {
               _loc10_ = new Dictionary();
               _loc1_ = 0;
               _loc3_ = 0;
               _loc9_ = 0;
               _loc6_ = 0;
               _loc7_ = 0;
               _loc4_ = 0;
               _loc8_ = 5;
               for each(_loc2_ in _mapModel.mapNodesData)
               {
                  if(CampaignArmyViewHelper.checkSteelDoor(_loc2_))
                  {
                     if(_loc2_.info.state == 8)
                     {
                        _loc9_ = 0;
                        _loc4_++;
                     }
                     else
                     {
                        _loc9_ = 1;
                     }
                     _loc1_ = int(_loc2_.curPosX);
                     _loc3_ = int(_loc2_.curPosY);
                     _loc6_ = _loc1_ - _loc8_;
                     while(_loc6_ <= _loc1_ + _loc8_)
                     {
                        _loc7_ = _loc3_ - _loc8_;
                        while(_loc7_ <= _loc3_ + _loc8_)
                        {
                           _loc10_[_loc6_ + "_" + _loc7_] = _loc9_;
                           if(_loc9_ == 0)
                           {
                              _mapModel.mapTielsData[_loc6_ + "_" + _loc7_] = 1;
                           }
                           else
                           {
                              delete _mapModel.mapTielsData[_loc6_ + "_" + _loc7_];
                           }
                           _loc7_++;
                        }
                        _loc6_++;
                     }
                  }
                  else if(CampaignArmyViewHelper.checkSteelTower(_loc2_))
                  {
                     _loc9_ = 1;
                     _loc1_ = int(_loc2_.curPosX);
                     _loc3_ = int(_loc2_.curPosY);
                     _loc10_[_loc1_ + "_" + _loc3_] = _loc9_;
                     delete _mapModel.mapTielsData[_loc1_ + "_" + _loc3_];
                  }
               }
               _steelDoorIsOpen = _loc4_ > 0;
               findPath.refreshData(_loc10_);
               _mapModel.steelMapIsChanged = false;
            }
         }
      }
      
      private function checkSteelMapMove(param1:Point, param2:Point) : Boolean
      {
         if(WorldBossHelper.checkSteel(_mapModel.mapId))
         {
            if(_steelDoorIsOpen)
            {
               return true;
            }
            if(_mapModel.walkableValueIsPara(1,param1.x,param1.y) || Boolean(_mapModel.walkableValueIsPara(4,param1.x,param1.y)))
            {
               if(_mapModel.walkableValueIsPara(3,param2.x,param2.y))
               {
                  return false;
               }
            }
            else if(_mapModel.walkableValueIsPara(3,param1.x,param1.y))
            {
               if(_mapModel.walkableValueIsPara(1,param2.x,param2.y))
               {
                  return false;
               }
               if(_mapModel.walkableValueIsPara(4,param2.x,param2.y))
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function showStunTips() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("map.campaign.CampaignMapController.stunTips");
         MessageTipManager.instance().show(_loc1_);
      }
      
      public function moveArmyByPos(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false) : Boolean
      {
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc6_:int = 0;
         var _loc5_:Array = null;
         NotificationManager.instance.sendNotification("LOCK_TEAM_FOLLOW_TARGET",null);
         var _loc13_:Point = new Point(param1,param2);
         var _loc11_:CampaignArmy = _mapModel.selfMemberData;
         if(!_loc11_)
         {
            return false;
         }
         if(_loc11_.isStun)
         {
            if(WorldBossHelper.checkConsortiaEmeDream(_mapModel.mapId))
            {
               showStunTips();
            }
            return false;
         }
         if(_loc11_.isTowerState())
         {
            return false;
         }
         var _loc7_:Object = CampaignManager.instance.controller.getArmyView(_loc11_);
         if(!_loc7_)
         {
            return false;
         }
         var _loc12_:Point = new Point(_loc7_.x,_loc7_.y);
         var _loc8_:Point = getStartPoint(_loc7_.x,_loc7_.y,_loc13_);
         if(_loc8_.x < 0 || _loc8_.x > _mapModel.mapTempInfo.Width || _loc8_.y < 0 || _mapModel.mapTempInfo.Height < _loc8_.y)
         {
            return false;
         }
         checkSteelMapChange();
         if(param3)
         {
            initRectScan();
            _loc13_ = _rectScanUtils.walkRectScan(_loc13_,new Point(_loc8_.x / 20,_loc8_.y / 20),_loc12_);
         }
         if(_loc13_)
         {
            if(!ArmyState.checkCampaignAttack(_loc11_.state))
            {
               return false;
            }
            _loc9_ = new Point(int(_loc8_.x / 20),int(_loc8_.y / 20));
            _loc10_ = new Point(int(_loc13_.x / 20),int(_loc13_.y / 20));
            if(!checkSteelMapMove(_loc9_,_loc10_))
            {
               return false;
            }
            _loc6_ = Point.distance(_loc9_,_loc10_);
            _loc5_ = _finPath.find(_loc9_,_loc10_);
            if(!_loc5_ || _loc5_.length <= 0)
            {
               if(WorldBossHelper.checkMolong(_mapModel.mapId) || Boolean(WorldBossHelper.checkPetLand(_mapModel.mapId)) || Boolean(WorldBossHelper.checkWedding(_mapModel.mapId)) || Boolean(WorldBossHelper.checkMarket(_mapModel.mapId)) || Boolean(WorldBossHelper.checkRapidMap(_mapModel.mapId)) || Boolean(WorldBossHelper.checkSteel(_mapModel.mapId)) || Boolean(WorldBossHelper.checkFarm(_mapModel.mapId)) || Boolean(WorldBossHelper.checkSacrificeRoom(_mapModel.mapId)) || Boolean(WorldBossHelper.checkUnrealShooting(_mapModel.mapId)) || Boolean(WorldBossHelper.checkGodsEvening(_mapModel.mapId)) || Boolean(WorldBossHelper.checkAirGarden(_mapModel.mapId)))
               {
                  if(CampaignArmyViewHelper.selfArmyToEnd(_loc7_.aiInfo,_loc7_))
                  {
                     return false;
                  }
                  if(CampaignArmyViewHelper.selfArmyEvent(_loc11_.userId,_loc7_.aiInfo,_loc7_,new Point(int(_loc8_.x / 20),int(_loc8_.y / 20)),true))
                  {
                     return false;
                  }
               }
               return false;
            }
            if(_loc6_ > 2)
            {
               if(!checkWorldBossAndPlayerDie(_loc11_) && !checkMonopoly(_loc11_) && !WorldBossHelper.checkFarm(_mapModel.mapId))
               {
                  if(CampaignArmyViewHelper.selfArmyEvent(_loc11_.userId,_loc7_.aiInfo,_loc7_,new Point(int(_loc8_.x / 20),int(_loc8_.y / 20))))
                  {
                     return false;
                  }
               }
            }
            else if(param4)
            {
               if(!checkWorldBossAndPlayerDie(_loc11_))
               {
                  if(CampaignArmyViewHelper.selfArmyToEnd(_loc7_.aiInfo,_loc7_))
                  {
                     return false;
                  }
                  if(CampaignArmyViewHelper.selfArmyEvent(_loc11_.userId,_loc7_.aiInfo,_loc7_,new Point(int(_loc8_.x / 20),int(_loc8_.y / 20)),true))
                  {
                     return false;
                  }
               }
            }
            if(_loc5_)
            {
               _loc5_ = _algUtils.getPsnode2(_loc5_);
               _loc7_.aiInfo.pathInfo = _loc5_;
               if(_loc5_ && _loc5_.length > 1)
               {
                  _mapModel.updateWalkTarget(_loc13_);
               }
               if(MouseData.instance.curState != "Lock")
               {
                  MouseData.instance.curState = "Normal";
               }
               return true;
            }
         }
         return false;
      }
      
      private function checkWorldBossAndPlayerDie(param1:CampaignArmy) : Boolean
      {
         if(WorldBossHelper.checkWorldBoss(_mapModel.mapId) && Boolean(CampaignArmyState.checkDied(param1.isDie)))
         {
            return true;
         }
         return false;
      }
      
      private function checkMonopoly(param1:CampaignArmy) : Boolean
      {
         if(WorldBossHelper.checkMonopoly(_mapModel.mapId))
         {
            return true;
         }
         return false;
      }
      
      private function getStartPoint(param1:int, param2:int, param3:Point) : Point
      {
         if(getWalkable(param1 / 20,param2 / 20))
         {
            return new Point(param1,param2);
         }
         var _loc4_:Point = _mapModel.getNeighborII(param1 / 20,param2 / 20);
         if(!_loc4_)
         {
            _loc4_ = new Point(param1 / 20,param2 / 20);
         }
         _loc4_.x *= 20;
         _loc4_.y *= 20;
         return _loc4_;
      }
      
      public function getWalkable(param1:int, param2:int) : Boolean
      {
         return _mapModel.getPointValue(param1,param2);
      }
      
      public function sendCampaignArmyMove(param1:int, param2:Array, param3:int) : void
      {
         MapSocketOuterManager.sendCampaignArmyMove(param1,param2,param3);
      }
      
      public function sendCampaignArrive(param1:int, param2:int, param3:int = 0) : void
      {
         MapSocketOuterManager.sendCampaignArrive(param1,param2,true,param3);
      }
      
      public function sendReinforce(param1:int) : void
      {
         MapSocketOuterManager.sendReinforce(param1);
      }
      
      public function buyWorldBossBufferWithPointOrGiftToken(param1:int) : void
      {
         MapSocketOuterManager.sendBuyWorldBossBuffer(2,param1);
      }
      
      public function receivePKRequest(param1:int, param2:int) : void
      {
         MapSocketOuterManager.receivePKRequest(param1,param2);
      }
      
      public function refusePKRequest(param1:int, param2:int) : void
      {
         MapSocketOuterManager.refusePKRequest(param1,param2);
      }
      
      public function alertMsg(param1:String) : void
      {
         MessageTipManager.instance().show(param1);
      }
      
      private function __unlockNodeHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = int(param1.data);
         var _loc2_:CampaignNode = _mapModel.getMapNodesById(_loc3_);
         if(_loc2_ && _loc2_.nodeView is NpcAvatarView)
         {
            (_loc2_.nodeView as NpcAvatarView).aiInfo.pathInfo = [];
            MapSocketOuterManager.sendAlertState(_loc2_.nodeId,false);
         }
      }
      
      public function get curSelectedObject() : Sprite
      {
         return _curSelectedObject;
      }
      
      public function set curSelectedObject(param1:Sprite) : void
      {
         var _loc2_:CampaignArmyView = null;
         if(param1 && !checkCanCastSkillTo(param1))
         {
            return;
         }
         if(_curSelectedObject is CampaignArmyView)
         {
            _loc2_ = _curSelectedObject as CampaignArmyView;
         }
         if(param1 is CampaignArmyView)
         {
            _loc2_ = param1 as CampaignArmyView;
            _loc2_.hideFateSkillEffect();
         }
         _curSelectedObject = param1;
         dispatchEvent(new Event("curSelectedObject"));
      }
      
      public function checkCanCastSkillTo(param1:Object) : Boolean
      {
         var _loc2_:CampaignNode = null;
         var _loc3_:CampaignArmy = null;
         var _loc4_:CampaignArmy = _mapModel.selfMemberData;
         if(!param1)
         {
            return false;
         }
         if(!_loc4_)
         {
            return false;
         }
         if(WorldBossHelper.checkActiveVehicle(_mapModel.mapId))
         {
            if(param1 is ActiveVehicleArmyView)
            {
               _loc3_ = (param1 as ActiveVehicleArmyView).data;
               if(!_loc3_)
               {
                  return false;
               }
            }
            else if(param1 is ActiveVehicleNpcAvater)
            {
               _loc2_ = (param1 as ActiveVehicleNpcAvater).nodeInfo as CampaignNode;
               if(!_loc2_)
               {
                  return false;
               }
            }
            else if(param1 is CampaignNode)
            {
               _loc2_ = param1 as CampaignNode;
            }
            else if(param1 is CampaignArmy)
            {
               _loc3_ = param1 as CampaignArmy;
            }
            if(_loc2_)
            {
               if(!NodeState.displayState(_loc2_.info.state))
               {
                  return false;
               }
               if(_loc2_.info.types != 99998)
               {
                  return false;
               }
            }
            if(_loc3_)
            {
               if(_loc3_.activeCurHp <= 0)
               {
                  return false;
               }
            }
         }
         else if(WorldBossHelper.checkUnrealShooting(_mapModel.mapId))
         {
            if(param1 is UnrealShootingNpcPhysics)
            {
               _loc2_ = (param1 as UnrealShootingNpcPhysics).info as CampaignNode;
               if(!_loc2_)
               {
                  return false;
               }
            }
            else if(param1 is UnrealShootingNpcAvatarView)
            {
               _loc2_ = (param1 as UnrealShootingNpcAvatarView).nodeInfo as CampaignNode;
               if(!_loc2_)
               {
                  return false;
               }
            }
            else if(param1 is UnrealShootingArmyView)
            {
               _loc3_ = (param1 as UnrealShootingArmyView).data;
               if(!_loc3_)
               {
                  return false;
               }
            }
            else if(param1 is CampaignNode)
            {
               _loc2_ = param1 as CampaignNode;
            }
            else if(param1 is CampaignArmy)
            {
               _loc3_ = param1 as CampaignArmy;
            }
            if(_loc2_)
            {
               if(!NodeState.displayState(_loc2_.info.state))
               {
                  return false;
               }
               if(!(_loc2_.info.types == 202 || _loc2_.info.types == 203 || _loc2_.info.types == 204 || _loc2_.info.types == 205 || _loc2_.info.types == 206))
               {
                  return false;
               }
            }
            if(_loc2_)
            {
               if(_loc2_.param1 == _loc4_.teamId)
               {
                  return false;
               }
            }
            if(_loc3_)
            {
               if(CampaignArmyState.checkDied(_loc3_.isDie))
               {
                  return false;
               }
            }
         }
         else
         {
            if(!_loc4_.inNode)
            {
               return false;
            }
            if(param1 is CampaignNpcPhysics)
            {
               _loc2_ = (param1 as CampaignNpcPhysics).info as CampaignNode;
               if(!_loc2_)
               {
                  return false;
               }
            }
            else if(param1 is CampaignNode)
            {
               _loc2_ = param1 as CampaignNode;
            }
            else if(param1 is CampaignArmy)
            {
               _loc3_ = param1 as CampaignArmy;
            }
            if(_loc2_)
            {
               if(_loc2_.param1 == _loc4_.teamId || _loc2_.param1 == 0)
               {
                  return false;
               }
               if(!NodeState.displayState(_loc2_.info.state))
               {
                  return false;
               }
            }
            if(_loc3_)
            {
               if(_loc3_.teamId == _loc4_.teamId)
               {
                  return false;
               }
               if(_loc3_.state == 2)
               {
                  return false;
               }
               if(_loc3_.isTowerState())
               {
                  return false;
               }
               if(CampaignArmyState.checkDied(_loc3_.isDie))
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function findNearEnemy() : Object
      {
         var _loc5_:Object = null;
         var _loc2_:Point = null;
         var _loc4_:int = 0;
         if(!_mapModel.selfMemberData)
         {
            return null;
         }
         if(!getArmyView(_mapModel.selfMemberData))
         {
            return null;
         }
         var _loc6_:int = 800;
         var _loc1_:Point = new Point(getArmyView(_mapModel.selfMemberData).x,getArmyView(_mapModel.selfMemberData).y);
         var _loc3_:int = 800;
         for each(var _loc7_:CampaignArmy in _mapModel.allUserArmy)
         {
            if(_loc7_ != _mapModel.selfMemberData)
            {
               if(_loc7_.teamId != _mapModel.selfMemberData.teamId)
               {
                  if(getArmyView(_loc7_))
                  {
                     if(!CampaignArmyState.checkDied(_loc7_.isDie))
                     {
                        if(ArmyState.checkCampaignAttack(_loc7_.state))
                        {
                           _loc2_ = new Point(getArmyView(_loc7_).x,getArmyView(_loc7_).y);
                           _loc4_ = Point.distance(_loc1_,_loc2_);
                           if(_loc4_ < _loc6_ && _loc4_ < _loc3_)
                           {
                              _loc3_ = _loc4_;
                              _loc5_ = getArmyView(_loc7_);
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc5_;
      }
      
      public function checkNeedShowWhenHideOthers(param1:CampaignArmy) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1 == _mapModel.selfMemberData)
         {
            return true;
         }
         var _loc2_:MarryModel = MarryManager.instance.model;
         if(WorldBossHelper.checkWedding(_mapModel.mapId))
         {
            if(!_loc2_)
            {
               return true;
            }
            if(param1.userId == _loc2_.weddingInfo.userIdA || param1.userId == _loc2_.weddingInfo.userIdB || param1 == _mapModel.selfMemberData)
            {
               return true;
            }
            return false;
         }
         if(WorldBossHelper.checkDuskArea(_mapModel.mapId) || Boolean(WorldBossHelper.checkFlameTemple(_mapModel.mapId)) || Boolean(WorldBossHelper.checkIceFireTemple(_mapModel.mapId)))
         {
            if(param1.teamId != _mapModel.selfMemberData.teamId)
            {
               return true;
            }
            if(FreedomTeamManager.instance.hasTeam && Boolean(FreedomTeamManager.instance.inMyTeam(param1.userId)))
            {
               return true;
            }
            return false;
         }
         if(FreedomTeamManager.instance.hasTeam && Boolean(FreedomTeamManager.instance.inMyTeam(param1.userId)))
         {
            return true;
         }
         return false;
      }
      
      public function getArmySvsFight(param1:Boolean = false) : BaseArmy
      {
         var _loc3_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:CampaignArmy = _mapModel.selfMemberData;
         var _loc5_:Object = getArmyView(_loc4_);
         for each(var _loc2_:CampaignArmy in _mapModel.allUserArmy)
         {
            _loc3_ = getArmyView(_loc2_);
            if(_loc3_)
            {
               if(!CampaignArmyState.checkDied(_loc2_.isDie))
               {
                  _loc6_ = _loc5_.x - _loc3_.x;
                  _loc7_ = _loc5_.y - _loc3_.y;
                  _loc8_ = _loc6_ * _loc6_ + _loc7_ * _loc7_;
                  if(_loc8_ < 10000)
                  {
                     if(param1)
                     {
                        if(_loc2_.teamId != _loc4_.teamId || !ArmyState.checkCampaignAttack(_loc2_.state))
                        {
                           return _loc2_;
                        }
                     }
                     else if(_loc2_.baseHero.consortiaID != _loc4_.baseHero.consortiaID || !ArmyState.checkCampaignAttack(_loc2_.state))
                     {
                        return _loc2_;
                     }
                  }
               }
            }
         }
         return null;
      }
      
      public function moveArmyByPath(param1:Array) : void
      {
         var _loc2_:CampaignArmy = null;
         var _loc3_:Object = null;
         if(param1)
         {
            _loc2_ = _mapModel.selfMemberData;
            _loc3_ = getArmyView(_loc2_);
            _loc3_.aiInfo.pathInfo = param1;
         }
      }
      
      public function findNearEnemySteel() : Object
      {
         var _loc3_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:CampaignNode = null;
         if(!_mapModel.selfMemberData)
         {
            return null;
         }
         if(!getArmyView(_mapModel.selfMemberData))
         {
            return null;
         }
         var _loc1_:Point = new Point(getArmyView(_mapModel.selfMemberData).x,getArmyView(_mapModel.selfMemberData).y);
         var _loc8_:int = 800;
         var _loc4_:int = 800;
         for each(var _loc2_:CampaignNode in _mapModel.mapNodesData)
         {
            if(_loc2_.param1 != _mapModel.selfMemberData.teamId)
            {
               if(checkCanCastSkillTo(_loc2_))
               {
                  if(_loc2_.nodeView)
                  {
                     _loc3_ = new Point(_loc2_.nodeView.x,_loc2_.nodeView.y);
                     _loc5_ = Point.distance(_loc1_,_loc3_);
                     if(_loc5_ < _loc8_ && _loc5_ < _loc4_)
                     {
                        _loc4_ = _loc5_;
                        _loc7_ = _loc2_;
                        _loc6_ = _loc2_.nodeView;
                        if(CampaignArmyViewHelper.checkSteelTower(_loc2_))
                        {
                           break;
                        }
                        if(CampaignArmyViewHelper.checkSnowBallNode(_loc2_))
                        {
                           break;
                        }
                     }
                  }
               }
            }
         }
         if(_loc7_)
         {
            if(CampaignArmyViewHelper.checkSteelDoor(_loc7_) || CampaignArmyViewHelper.checkSteelTower(_loc7_) || CampaignArmyViewHelper.checkSnowBallNode(_loc7_))
            {
               return _loc6_;
            }
         }
         for each(var _loc9_:CampaignArmy in _mapModel.allUserArmy)
         {
            if(_loc9_ != _mapModel.selfMemberData)
            {
               if(_loc9_.teamId != _mapModel.selfMemberData.teamId)
               {
                  if(getArmyView(_loc9_))
                  {
                     if(!CampaignArmyState.checkDied(_loc9_.isDie))
                     {
                        if(ArmyState.checkCampaignAttack(_loc9_.state))
                        {
                           _loc3_ = new Point(getArmyView(_loc9_).x,getArmyView(_loc9_).y);
                           _loc5_ = Point.distance(_loc1_,_loc3_);
                           if(_loc5_ < _loc8_ && _loc5_ < _loc4_)
                           {
                              _loc4_ = _loc5_;
                              _loc6_ = getArmyView(_loc9_);
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc6_;
      }
      
      private function __attackNoticeHandler(param1:CampaignMapEvent) : void
      {
         var _loc3_:Point = param1.data as Point;
         var _loc4_:MovieClip = ComponentFactory.Instance.creat("asset.vehiclemap.SteelBossSkillCursor");
         var _loc2_:SimpleMovie = new SimpleMovie(_loc4_,null,50);
         if(_view)
         {
            _view.walkLayer.addChildAt(_loc2_,0);
         }
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         _loc4_.play();
      }
      
      public function get view() : CampaignMapView
      {
         return _view;
      }
      
      public function findNearEnemyUnrealShooting() : Object
      {
         var _loc3_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:CampaignNode = null;
         if(!_mapModel.selfMemberData)
         {
            return null;
         }
         if(!getArmyView(_mapModel.selfMemberData))
         {
            return null;
         }
         var _loc1_:Point = new Point(getArmyView(_mapModel.selfMemberData).x,getArmyView(_mapModel.selfMemberData).y);
         var _loc8_:int = 800;
         var _loc4_:int = 800;
         for each(var _loc2_:CampaignNode in _mapModel.mapNodesData)
         {
            if(checkCanCastSkillTo(_loc2_))
            {
               if(_loc2_.nodeView)
               {
                  _loc3_ = new Point(_loc2_.nodeView.x,_loc2_.nodeView.y);
                  _loc5_ = Point.distance(_loc1_,_loc3_);
                  if(_loc5_ < _loc8_ && _loc5_ < _loc4_)
                  {
                     _loc4_ = _loc5_;
                     _loc7_ = _loc2_;
                     _loc6_ = _loc2_.nodeView;
                     if(CampaignArmyViewHelper.checkUnrealShootingMonster(_loc2_))
                     {
                        break;
                     }
                  }
               }
            }
         }
         if(_loc7_)
         {
            if(CampaignArmyViewHelper.checkUnrealShootingMonster(_loc7_) || CampaignArmyViewHelper.checkUnrealShootingSoldier(_loc7_))
            {
               return _loc6_;
            }
         }
         for each(var _loc9_:CampaignArmy in _mapModel.allUserArmy)
         {
            if(_loc9_ != _mapModel.selfMemberData)
            {
               if(getArmyView(_loc9_))
               {
                  if(!CampaignArmyState.checkDied(_loc9_.isDie))
                  {
                     if(ArmyState.checkCampaignAttack(_loc9_.state))
                     {
                        if(_loc9_.teamId != _mapModel.selfMemberData.teamId)
                        {
                           _loc3_ = new Point(getArmyView(_loc9_).x,getArmyView(_loc9_).y);
                           _loc5_ = Point.distance(_loc1_,_loc3_);
                           if(_loc5_ < _loc8_ && _loc5_ < _loc4_)
                           {
                              _loc4_ = _loc5_;
                              _loc6_ = getArmyView(_loc9_);
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc6_;
      }
   }
}

