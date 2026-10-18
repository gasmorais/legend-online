package map.campaign
{
   import battle.BattleManager;
   import battle.utils.Int64Utils;
   import chat.datas.ChatData;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import com.road.yishi.proto.airgarden.AirGardenCampaignMsg;
   import com.road.yishi.proto.answerquestion.AnswerQuestionPlayerMsg;
   import com.road.yishi.proto.answerquestion.AnswerQuestionRankListMsg;
   import com.road.yishi.proto.answerquestion.SingleAnswerQuestionMsg;
   import com.road.yishi.proto.army.ArmyBufferListMsg;
   import com.road.yishi.proto.army.ArmyBufferMsg;
   import com.road.yishi.proto.army.ArmyMsg;
   import com.road.yishi.proto.army.ArmyPawnInfoMsg;
   import com.road.yishi.proto.army.ArmyPosUpdatedMsg;
   import com.road.yishi.proto.army.BossArmyListMsg;
   import com.road.yishi.proto.army.CrossArmyListMsg;
   import com.road.yishi.proto.army.CrossArmyMsg;
   import com.road.yishi.proto.army.FightPlayerMsg;
   import com.road.yishi.proto.battle.BaseItemMsg;
   import com.road.yishi.proto.battle.BattleReportMsg;
   import com.road.yishi.proto.battle.PlayerTrialMsg;
   import com.road.yishi.proto.battle.TrialInfoMsg;
   import com.road.yishi.proto.bloodyrealm.BloodyRealmCampaignInfoMsg;
   import com.road.yishi.proto.bloodyrealm.EggInfoMsg;
   import com.road.yishi.proto.bloodyrealm.EggStateMsg;
   import com.road.yishi.proto.bloodyrealm.PickupEggMsg;
   import com.road.yishi.proto.bloodyrealm.PoundEggMsg;
   import com.road.yishi.proto.campaign.BossInviteMsg;
   import com.road.yishi.proto.campaign.CampaignExitMsg;
   import com.road.yishi.proto.campaign.CampaignFogMsg;
   import com.road.yishi.proto.campaign.CampaignFogUpdateMsg;
   import com.road.yishi.proto.campaign.CampaignLoginMsg;
   import com.road.yishi.proto.campaign.CampaignNodeArriveRequestMsg;
   import com.road.yishi.proto.campaign.CampaignNodeListMsg;
   import com.road.yishi.proto.campaign.CampaignNodeMsg;
   import com.road.yishi.proto.campaign.CampaignNodePosRefershListMsg;
   import com.road.yishi.proto.campaign.CampaignNodePosRefershMsg;
   import com.road.yishi.proto.campaign.CampaignNodeSuccMsg;
   import com.road.yishi.proto.campaign.CampaignNodeUpdateMsg;
   import com.road.yishi.proto.campaign.CampaignUpdateNodeListMsg;
   import com.road.yishi.proto.campaign.CarInfo;
   import com.road.yishi.proto.campaign.DragonCampaingnDataMsg;
   import com.road.yishi.proto.campaign.FogUpdateMsg;
   import com.road.yishi.proto.campaign.HangupInfoMsg;
   import com.road.yishi.proto.campaign.MultiCampaignHpSyncMsg;
   import com.road.yishi.proto.campaign.MultiPlayerHpSyncMsg;
   import com.road.yishi.proto.campaign.NPCFollowMsg;
   import com.road.yishi.proto.campaign.NPCMoveMsg;
   import com.road.yishi.proto.campaign.NodeLockReqMsg;
   import com.road.yishi.proto.campaign.PlayerHangupStateListMsg;
   import com.road.yishi.proto.campaign.PlayerHangupStateMsg;
   import com.road.yishi.proto.campaign.RandomBossBuffefMsg;
   import com.road.yishi.proto.campaign.RandomBuffMsg;
   import com.road.yishi.proto.campaign.RollInfoMsg;
   import com.road.yishi.proto.campaign.StandPosMsg;
   import com.road.yishi.proto.campaign.TimeJudgeMsg;
   import com.road.yishi.proto.campaign.TowerDiedMsg;
   import com.road.yishi.proto.campaign.TramcarInfoMsg;
   import com.road.yishi.proto.campaign.WarEnergyListMsg;
   import com.road.yishi.proto.campaign.WarEnergyMsg;
   import com.road.yishi.proto.campaign.WarFightInfoMsg;
   import com.road.yishi.proto.campaign.WarReportListMsg;
   import com.road.yishi.proto.campaign.WarReportMsg;
   import com.road.yishi.proto.consortia.ConsortiaBossStateMsg;
   import com.road.yishi.proto.dungeonturn.DungeonTurnOpMsg;
   import com.road.yishi.proto.fantasymatirx.FantasyMatrixMainMsg;
   import com.road.yishi.proto.fantasymatirx.FantasyMatrixMapMsg;
   import com.road.yishi.proto.fantasymatirx.FantasyMatrixNodeMsg;
   import com.road.yishi.proto.gods.CrossGodsMsg;
   import com.road.yishi.proto.item.MarketMsg;
   import com.road.yishi.proto.item.MarketOpMsg;
   import com.road.yishi.proto.item.StallItemMsg;
   import com.road.yishi.proto.item.StallMsg;
   import com.road.yishi.proto.player.PlayerMoveCameraMsg;
   import com.road.yishi.proto.room.SnowVehicleSkillListMsg;
   import com.road.yishi.proto.room.VehicleBuffListMsg;
   import com.road.yishi.proto.room.VehicleBuffStateMsg;
   import com.road.yishi.proto.room.VehicleSkillListMsg;
   import com.road.yishi.proto.simple.PlayerStateListMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.simple.WorldBossInfoMsg;
   import com.road.yishi.proto.simple.WorldBossPlayerStateMsg;
   import com.road.yishi.proto.simple.WoundInfoMsg;
   import com.road.yishi.proto.vehicle.HurtDataMsg;
   import com.road.yishi.proto.vehicle.PlayerVehicleListMsg;
   import com.road.yishi.proto.vehicle.PlayerVehicleMsg;
   import com.road.yishi.proto.vehicle.Position;
   import com.road.yishi.proto.vehicle.SkillBuffMsg;
   import com.road.yishi.proto.vehicle.SnowVehicleEndRewardMsg;
   import com.road.yishi.proto.vehicle.VehicleAttackRspMsg;
   import com.road.yishi.proto.vehicle.VehicleCampaignDetailMsg;
   import com.road.yishi.proto.vehicle.VehicleExitMsg;
   import com.road.yishi.proto.vehicle.VehicleMoveListMsg;
   import com.road.yishi.proto.vehicle.VehicleMoveMsg;
   import com.road.yishi.proto.vehicle.VehicleNpcNodeListMsg;
   import com.road.yishi.proto.vehicle.VehicleNpcNodeMsg;
   import com.road.yishi.proto.vehicle.VehicleScroeListMsg;
   import com.road.yishi.proto.worldmap.PosMoveListMsg;
   import com.road.yishi.proto.worldmap.PosMoveMsg;
   import com.road.yishi.proto.worldmap.SynPlayerViewMsg;
   import farm.FarmManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.AirGardenManager;
   import managers.DungeoTurnManager;
   import managers.GameHallManager;
   import managers.RoomManager;
   import managers.TaskTraceTipManager;
   import map.campaign.data.ActiveVehicleModel;
   import map.campaign.data.ActiveVehicleUserInfo;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.DeepPrisonModel;
   import map.campaign.data.FantasyMatrixModel;
   import map.campaign.data.FantasyMatrixNodeInfo;
   import map.campaign.data.FlameTempleEnergyGapInfo;
   import map.campaign.data.MarketModel;
   import map.campaign.data.MineralCarInfo;
   import map.campaign.data.MineralModel;
   import map.campaign.data.PvpWarFightModel;
   import map.campaign.data.StallInfo;
   import map.campaign.data.TrailPropInfo;
   import map.campaign.data.TrialModel;
   import map.campaign.data.WarFightOrderInfo;
   import map.campaign.data.WarReportInfo;
   import map.campaign.data.skill.MapBuffHurtData;
   import map.campaign.data.skill.MapSkillHurtData;
   import map.campaign.data.skill.MapSkillResultInfo;
   import map.campaign.event.CampaignEvent;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.event.PvpWarFightEvent;
   import map.campaign.helper.CampaignFrameHelper;
   import map.campaign.helper.SearchPathHelper;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.mediator.bloody.BloodyManager;
   import map.campaign.mediator.molong.MolongManager;
   import map.campaign.mediator.randomboss.RandomShaiziManager;
   import map.campaign.view.physics.UnrealShootingNpcAvatarView;
   import map.internals.data.CampaignNode;
   import map.internals.data.ChestInfo;
   import map.internals.data.PhysicInfo;
   import map.internals.data.RandomBossBuffefMsgInfo;
   import map.internals.data.RandomBuffMsgInfo;
   import map.internals.data.SnowVehicleDropInfo;
   import map.internals.utils.SocketGameReader;
   import map.internals.view.hero.AvatarBaseView;
   import mvc.module.airgarden.AirGardenModel;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.armyII.SystemArmy;
   import mvc.module.armyII.UserArmy;
   import mvc.module.consortia.ConsortiaEmeDreamInfo;
   import mvc.module.room.RoomInfo;
   import mvc.module.sevenyear.SnowVehicleReportInfo;
   import mvc.module.singlecampaign.SingleCampaignModel;
   import mvc.module.worldboss.WorldBossModel;
   import mvc.module.worldboss.WoundInfo;
   import proxy.SocketDataProxyEventEvent;
   import proxy.SocketDataProxyManager;
   import yishi.SwitchPageHelp;
   import yishi.actions.base.AlertTipAction;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BaseManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.CoreTransactionManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yzhkof.debug.log;
   
   public class CampaignSocketManger
   {
      
      private static var _instance:CampaignSocketManger;
      
      private static const fogViewUnitWidth:int = 110;
      
      private var _isProxy:Boolean;
      
      private var _isUse:Boolean;
      
      private var tempMapId:int;
      
      private var _exitTime:Number;
      
      private var _activeVehicleGameOverList:Array = [];
      
      private var _snowVehicleInfo:SnowVehicleReportInfo;
      
      public function CampaignSocketManger()
      {
         super();
      }
      
      public static function get instance() : CampaignSocketManger
      {
         if(!_instance)
         {
            _instance = new CampaignSocketManger();
         }
         return _instance;
      }
      
      private static function get selfarmy() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      private function get worldBossModel() : WorldBossModel
      {
         return CampaignManager.instance.worldBossModel;
      }
      
      private function get pvpWarFightModel() : PvpWarFightModel
      {
         return CampaignManager.instance.pvpWarFightModel;
      }
      
      private function get trialModel() : TrialModel
      {
         return CampaignManager.instance.trialModel;
      }
      
      private function get mineralModel() : MineralModel
      {
         return CampaignManager.instance.mineralModel;
      }
      
      private function get marketModel() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
      
      private function get activeVehicleModel() : ActiveVehicleModel
      {
         return CampaignManager.instance.activeVehicleModel;
      }
      
      private function get fantasyMatrixModel() : FantasyMatrixModel
      {
         return CampaignManager.instance.fantasyMatrixModel;
      }
      
      private function get deepPrisonModel() : DeepPrisonModel
      {
         return CampaignManager.instance.deepPrisonModel;
      }
      
      private function get airGardenModel() : AirGardenModel
      {
         return AirGardenManager.instance.model;
      }
      
      private function get singleCampaignModel() : SingleCampaignModel
      {
         return CampaignManager.instance.singleCampaignModel;
      }
      
      public function setup(param1:Boolean = false) : void
      {
         if(_isUse)
         {
            return;
         }
         _isProxy = param1;
         _isUse = true;
         if(param1)
         {
            removeSocketEvent(SocketManager.instance);
            addSocketEvent(SocketDataProxyManager.instance.model);
            SocketDataProxyManager.instance.model.addEventListener("READ_SOCKET_DATA_OVEW",__readOverHandler);
            SocketDataProxyManager.instance.readSocketDataByType("CAMPAIGN_MAP_SCENE");
         }
         else
         {
            addSocketEvent(SocketManager.instance);
            removeSocketEvent(SocketDataProxyManager.instance.model);
         }
         NotificationManager.instance.addEventListener("CAMPAIGN_OVER",__campaignOverHandler);
      }
      
      private function __readOverHandler(param1:SocketDataProxyEventEvent) : void
      {
         if(param1.sceneType != "CAMPAIGN_MAP_SCENE")
         {
            return;
         }
         addSocketEvent(SocketManager.instance);
         removeSocketEvent(SocketDataProxyManager.instance.model);
         SocketDataProxyManager.instance.model.removeEventListener("READ_SOCKET_DATA_OVEW",__readOverHandler);
      }
      
      private function __campaignOverHandler(param1:CampaignEvent) : void
      {
         _isUse = false;
         removeSocketEvent(SocketManager.instance);
         removeSocketEvent(SocketDataProxyManager.instance.model);
         NotificationManager.instance.removeEventListener("CAMPAIGN_OVER",__campaignOverHandler);
      }
      
      private function addSocketEvent(param1:EventDispatcher) : void
      {
         param1.addEventListener("SLGSocketEvent" + 130,__campaignFogHandler);
         param1.addEventListener("SLGSocketEvent" + 4199,__hookTimeHandler);
         param1.addEventListener("SLGSocketEvent" + 4264,__campaignNodeAddHandler);
         param1.addEventListener("SLGSocketEvent" + 4122,__npcMoveHandler);
         param1.addEventListener("SLGSocketEvent" + 128,__updateCampaignNodeHandler);
         param1.addEventListener("SLGSocketEvent" + 131,__updateCampaignArmyHandler);
         param1.addEventListener("SLGSocketEvent" + 137,__campaignResultHandler);
         param1.addEventListener("SLGSocketEvent" + 134,__campaignFinishInfoHandler);
         param1.addEventListener("SLGSocketEvent" + 131,__campaingArmyInfoHandler);
         param1.addEventListener("SLGSocketEvent" + 124,__campaignLoginInHandler);
         param1.addEventListener("SLGSocketEvent" + 123,__campaingLoginOutHandler);
         param1.addEventListener("SLGSocketEvent" + 22,__exitCampaignSceneHandler);
         param1.addEventListener("U_PLAY_MOVIE",__playMovieHandler);
         param1.addEventListener("SLGSocketEvent" + 142,__campaignSceneMoveHandler);
         param1.addEventListener("SLGSocketEvent" + 129,__attackNodeHandler);
         param1.addEventListener("SLGSocketEvent" + 19,__updateFogHandler);
         param1.addEventListener("SLGSocketEvent" + 133,__campaignBossArmyListHandler);
         param1.addEventListener("SLGSocketEvent" + 132,__campaignBossArmyInviteHandler);
         param1.addEventListener("SLGSocketEvent" + 4124,__followNpcHandler);
         param1.addEventListener("SLGSocketEvent" + 4126,__standPosHandler);
         param1.addEventListener("SLGSocketEvent" + 4174,__syncBossHpHandler);
         param1.addEventListener("SLGSocketEvent" + 4175,__playerDieStateHandler);
         param1.addEventListener("SLGSocketEvent" + 4183,__multiHpsyncHandler);
         param1.addEventListener("SLGSocketEvent" + 4104,__updateArmyPosHandler);
         param1.addEventListener("SLGSocketEvent" + 4185,__armyPosBroadHandler);
         param1.addEventListener("SLGSocketEvent" + 4213,__armyPosListBroadHandler);
         param1.addEventListener("SLGSocketEvent" + 4206,__playerHangupstateHandler);
         param1.addEventListener("SLGSocketEvent" + 4252,__warfieldInfoHandler);
         param1.addEventListener("SLGSocketEvent" + 4254,__warreportHandler);
         param1.addEventListener("SLGSocketEvent" + 4255,__orderrequestHandler);
         param1.addEventListener("SLGSocketEvent" + 4253,__nodePosRefershHandler);
         param1.addEventListener("SLGSocketEvent" + 4262,__broadBufferHandler);
         param1.addEventListener("SLGSocketEvent" + 4371,__timeJudgeHandler);
         param1.addEventListener("SLGSocketEvent" + 4456,__campiagnOpenMv);
         param1.addEventListener("SLGSocketEvent" + 4207,__towerDiedHandler);
         param1.addEventListener("SLGSocketEvent" + 4468,__trailPropInfoHandler);
         NotificationManager.instance.addEventListener("roomKillOut",__roomKillOutHandler);
         NotificationManager.instance.addEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
         NotificationManager.instance.addEventListener("BATTLE_RESULT",__battleResultHandler);
         NotificationManager.instance.addEventListener("$UPDTAE_ARMY",__updateArmyHandler);
         param1.addEventListener("SLGSocketEvent" + 4103,__battleInfoResultHandler);
         param1.addEventListener("SLGSocketEvent" + 4494,__crossArmyUpdateHandler);
         param1.addEventListener("SLGSocketEvent" + 4609,__lockNpcHandler);
         param1.addEventListener("SLGSocketEvent" + 4548,__mineralHandler);
         param1.addEventListener("SLGSocketEvent" + 4663,myRollResult);
         param1.addEventListener("SLGSocketEvent" + 4664,rollMaxNumResult);
         param1.addEventListener("SLGSocketEvent" + 4665,dragonCampaignInfoResult);
         param1.addEventListener("SLGSocketEvent" + 4649,__updateFlameTempleEnergyListHandler);
         param1.addEventListener("SLGSocketEvent" + 4520,__playerAttackHandler);
         param1.addEventListener("SLGSocketEvent" + 4790,__groupfbMovieHandler);
         param1.addEventListener("SLGSocketEvent" + 4792,__groupfbAttackHandler);
         param1.addEventListener("SLGSocketEvent" + 4522,__syncBuffListHandler);
         param1.addEventListener("SLGSocketEvent" + 4521,__playerSkillHandler);
         param1.addEventListener("SLGSocketEvent" + 4524,__bossAttackNoticeHandler);
         param1.addEventListener("SLGSocketEvent" + 4474,__nodeListHandler);
         param1.addEventListener("SLGSocketEvent" + 4833,__playerUnrealShootingSkillHandler);
         param1.addEventListener("SLGSocketEvent" + 4727,__consortiaEmeDreamBossHpHandler);
         param1.addEventListener("SLGSocketEvent" + 4693,__getQuestionHandler);
         param1.addEventListener("SLGSocketEvent" + 4695,__updateRankMyInfoHandler);
         param1.addEventListener("SLGSocketEvent" + 4692,__updateRankHandler);
         param1.addEventListener("SLGSocketEvent" + 4945,onRandomBossBuffInfo);
         param1.addEventListener("SLGSocketEvent" + 4781,__marketOpbackHandler);
         param1.addEventListener("SLGSocketEvent" + 4782,__marketInfoHandler);
         param1.addEventListener("SLGSocketEvent" + 4729,__emeDreamStateUpdateHandler);
         param1.addEventListener("SLGSocketEvent" + 4861,__emeDreamBuffUpdateHandler);
         param1.addEventListener("SLGSocketEvent" + 4862,__emeDreamBuffTrapHandler);
         param1.addEventListener("SLGSocketEvent" + 4212,__synCampaignViewHandler);
         param1.addEventListener("SLGSocketEvent" + 333,bloodyRollResult);
         param1.addEventListener("SLGSocketEvent" + 334,bloodyFallBoxResult);
         param1.addEventListener("SLGSocketEvent" + 335,bloodyRealmInfoHandle);
         param1.addEventListener("SLGSocketEvent" + 4513,__activeVehicleJoinHandler);
         param1.addEventListener("SLGSocketEvent" + 4523,__activeVehicleExitHandler);
         param1.addEventListener("SLGSocketEvent" + 4518,__activeCampaignInfoHandler);
         param1.addEventListener("SLGSocketEvent" + 4514,__activeCampaignEndHandler);
         param1.addEventListener("SLGSocketEvent" + 4519,__activeCampaignMoveHandler);
         NotificationManager.instance.addEventListener("RANDOM_CAMPAIGN_WAVE_CHANGE",__bloodyWaveChangeHandle);
         param1.addEventListener("SLGSocketEvent" + 4448,__fantasyMatrixMainHandler);
         param1.addEventListener("SLGSocketEvent" + 4449,__fantasyMatrixMapInfoHandler);
         param1.addEventListener("SLGSocketEvent" + 387,__CampaignBattleRequestHandler);
         param1.addEventListener("SLGSocketEvent" + 439,__childWarCampaignHandler);
         param1.addEventListener("SLGSocketEvent" + 4831,__updateNodeHandler);
         param1.addEventListener("SLGSocketEvent" + 244,__godsEveningBossHpHandler);
         param1.addEventListener("SLGSocketEvent" + 4874,__dungeonTurnOpHandler);
         param1.addEventListener("SLGSocketEvent" + 183,__playersHpHandler);
         param1.addEventListener("SLGSocketEvent" + 201,__activeCampaignEndHandler);
         param1.addEventListener("SLGSocketEvent" + 4891,__deepPriosionInfoHandler);
         param1.addEventListener("SLGSocketEvent" + 378,__airGardenCampaignHandler);
         param1.addEventListener("SLGSocketEvent" + 4282,__singleCampaignHandler);
      }
      
      private function removeSocketEvent(param1:EventDispatcher) : void
      {
         param1.removeEventListener("SLGSocketEvent" + 130,__campaignFogHandler);
         param1.removeEventListener("SLGSocketEvent" + 4199,__hookTimeHandler);
         param1.removeEventListener("SLGSocketEvent" + 4264,__campaignNodeAddHandler);
         param1.removeEventListener("SLGSocketEvent" + 4122,__npcMoveHandler);
         param1.removeEventListener("SLGSocketEvent" + 128,__updateCampaignNodeHandler);
         param1.removeEventListener("SLGSocketEvent" + 131,__updateCampaignArmyHandler);
         param1.removeEventListener("SLGSocketEvent" + 137,__campaignResultHandler);
         param1.removeEventListener("SLGSocketEvent" + 134,__campaignFinishInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 131,__campaingArmyInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 124,__campaignLoginInHandler);
         param1.removeEventListener("SLGSocketEvent" + 123,__campaingLoginOutHandler);
         param1.removeEventListener("SLGSocketEvent" + 22,__exitCampaignSceneHandler);
         param1.removeEventListener("U_PLAY_MOVIE",__playMovieHandler);
         param1.removeEventListener("SLGSocketEvent" + 142,__campaignSceneMoveHandler);
         param1.removeEventListener("SLGSocketEvent" + 129,__attackNodeHandler);
         param1.removeEventListener("SLGSocketEvent" + 19,__updateFogHandler);
         param1.removeEventListener("SLGSocketEvent" + 133,__campaignBossArmyListHandler);
         param1.removeEventListener("SLGSocketEvent" + 132,__campaignBossArmyInviteHandler);
         param1.removeEventListener("SLGSocketEvent" + 4124,__followNpcHandler);
         param1.removeEventListener("SLGSocketEvent" + 4126,__standPosHandler);
         param1.removeEventListener("SLGSocketEvent" + 4174,__syncBossHpHandler);
         param1.removeEventListener("SLGSocketEvent" + 4175,__playerDieStateHandler);
         param1.removeEventListener("SLGSocketEvent" + 4183,__multiHpsyncHandler);
         param1.removeEventListener("SLGSocketEvent" + 4104,__updateArmyPosHandler);
         param1.removeEventListener("SLGSocketEvent" + 4185,__armyPosBroadHandler);
         param1.removeEventListener("SLGSocketEvent" + 4213,__armyPosListBroadHandler);
         param1.removeEventListener("SLGSocketEvent" + 4206,__playerHangupstateHandler);
         param1.removeEventListener("SLGSocketEvent" + 4252,__warfieldInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 4254,__warreportHandler);
         param1.removeEventListener("SLGSocketEvent" + 4255,__orderrequestHandler);
         param1.removeEventListener("SLGSocketEvent" + 4253,__nodePosRefershHandler);
         param1.removeEventListener("SLGSocketEvent" + 4262,__broadBufferHandler);
         param1.removeEventListener("SLGSocketEvent" + 4371,__timeJudgeHandler);
         param1.removeEventListener("SLGSocketEvent" + 4456,__campiagnOpenMv);
         param1.removeEventListener("SLGSocketEvent" + 4207,__towerDiedHandler);
         param1.removeEventListener("SLGSocketEvent" + 4468,__trailPropInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 4103,__battleInfoResultHandler);
         NotificationManager.instance.removeEventListener("roomKillOut",__roomKillOutHandler);
         NotificationManager.instance.removeEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
         NotificationManager.instance.removeEventListener("BATTLE_RESULT",__battleResultHandler);
         NotificationManager.instance.removeEventListener("$UPDTAE_ARMY",__updateArmyHandler);
         param1.removeEventListener("SLGSocketEvent" + 4494,__crossArmyUpdateHandler);
         param1.removeEventListener("SLGSocketEvent" + 4609,__lockNpcHandler);
         param1.removeEventListener("SLGSocketEvent" + 4548,__mineralHandler);
         param1.removeEventListener("SLGSocketEvent" + 4663,myRollResult);
         param1.removeEventListener("SLGSocketEvent" + 4664,rollMaxNumResult);
         param1.removeEventListener("SLGSocketEvent" + 4665,dragonCampaignInfoResult);
         param1.removeEventListener("SLGSocketEvent" + 4649,__updateFlameTempleEnergyListHandler);
         param1.removeEventListener("SLGSocketEvent" + 4520,__playerAttackHandler);
         param1.removeEventListener("SLGSocketEvent" + 4790,__groupfbMovieHandler);
         param1.removeEventListener("SLGSocketEvent" + 4792,__groupfbAttackHandler);
         param1.removeEventListener("SLGSocketEvent" + 4522,__syncBuffListHandler);
         param1.removeEventListener("SLGSocketEvent" + 4521,__playerSkillHandler);
         param1.removeEventListener("SLGSocketEvent" + 4524,__bossAttackNoticeHandler);
         param1.removeEventListener("SLGSocketEvent" + 4474,__nodeListHandler);
         param1.removeEventListener("SLGSocketEvent" + 4833,__playerUnrealShootingSkillHandler);
         param1.removeEventListener("SLGSocketEvent" + 4727,__consortiaEmeDreamBossHpHandler);
         param1.removeEventListener("SLGSocketEvent" + 4693,__getQuestionHandler);
         param1.removeEventListener("SLGSocketEvent" + 4695,__updateRankMyInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 4692,__updateRankHandler);
         param1.removeEventListener("SLGSocketEvent" + 4945,onRandomBossBuffInfo);
         param1.removeEventListener("SLGSocketEvent" + 4781,__marketOpbackHandler);
         param1.removeEventListener("SLGSocketEvent" + 4782,__marketInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 4729,__emeDreamStateUpdateHandler);
         param1.removeEventListener("SLGSocketEvent" + 4861,__emeDreamBuffUpdateHandler);
         param1.removeEventListener("SLGSocketEvent" + 4862,__emeDreamBuffTrapHandler);
         param1.removeEventListener("SLGSocketEvent" + 4513,__activeVehicleJoinHandler);
         param1.removeEventListener("SLGSocketEvent" + 4523,__activeVehicleExitHandler);
         param1.removeEventListener("SLGSocketEvent" + 4518,__activeCampaignInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 4514,__activeCampaignEndHandler);
         param1.removeEventListener("SLGSocketEvent" + 4519,__activeCampaignMoveHandler);
         NotificationManager.instance.removeEventListener("RANDOM_CAMPAIGN_WAVE_CHANGE",__bloodyWaveChangeHandle);
         param1.removeEventListener("SLGSocketEvent" + 4448,__fantasyMatrixMainHandler);
         param1.removeEventListener("SLGSocketEvent" + 4449,__fantasyMatrixMapInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 387,__CampaignBattleRequestHandler);
         param1.removeEventListener("SLGSocketEvent" + 439,__childWarCampaignHandler);
         param1.removeEventListener("SLGSocketEvent" + 4831,__updateNodeHandler);
         param1.removeEventListener("SLGSocketEvent" + 244,__godsEveningBossHpHandler);
         param1.removeEventListener("SLGSocketEvent" + 4212,__synCampaignViewHandler);
         param1.removeEventListener("SLGSocketEvent" + 4874,__dungeonTurnOpHandler);
         param1.removeEventListener("SLGSocketEvent" + 183,__playersHpHandler);
         param1.removeEventListener("SLGSocketEvent" + 201,__activeCampaignEndHandler);
         param1.removeEventListener("SLGSocketEvent" + 4891,__deepPriosionInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 378,__airGardenCampaignHandler);
         param1.removeEventListener("SLGSocketEvent" + 4282,__singleCampaignHandler);
      }
      
      private function __playersHpHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:CampaignArmy = null;
         var _loc4_:CampaignNode = null;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         var _loc6_:MapBuffHurtData = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerVehicleListMsg = new PlayerVehicleListMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as PlayerVehicleListMsg;
         var _loc9_:CampaignArmy = mapModel.selfMemberData;
         if(WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            for each(_loc7_ in _loc2_.vehicles)
            {
               if(!_loc7_.hasPlayerId && Boolean(_loc7_.hasTemplateId))
               {
                  _loc4_ = mapModel.getMapNodeByNodeId(_loc7_.npcNodeId);
                  if(_loc4_)
                  {
                     _loc4_.totalHp = _loc7_.maxHp;
                     _loc4_.curHp = _loc7_.hp;
                     for each(_loc5_ in _loc7_.buffState)
                     {
                        _loc6_ = new MapBuffHurtData();
                        _loc6_.buffId = _loc5_;
                        if(_loc4_.info.types == 99998)
                        {
                           _loc4_.beHurt(_loc6_);
                        }
                        else
                        {
                           _loc4_.updateBuff(_loc6_);
                        }
                        if(_loc6_.buffTemplate)
                        {
                           log({},_loc6_.buffTemplate.Name);
                        }
                     }
                  }
               }
               else
               {
                  _loc3_ = mapModel.getUserArmyByUserId(_loc7_.playerId,_loc7_.serverName);
                  if(_loc3_)
                  {
                     if(_loc7_.hasTemplateId && Boolean(_loc7_.hasDefaultSkills))
                     {
                        _loc3_.activeLastTempId = _loc7_.templateId;
                        _loc3_.updateActiveInfo(_loc7_.templateId,_loc7_.defaultSkills);
                     }
                     _loc3_.updateArmyHpInfo(_loc7_.hp,_loc7_.maxHp);
                     _loc3_.updateActiveVehicleHoldKeyState(_loc7_.isHoldKey);
                     for each(_loc5_ in _loc7_.buffState)
                     {
                        _loc6_ = new MapBuffHurtData();
                        _loc6_.buffId = _loc5_;
                        _loc3_.updateBuffActive(_loc6_);
                        if(_loc6_.buffTemplate)
                        {
                           log({},_loc6_.buffTemplate.Name);
                        }
                     }
                     if(_loc7_.hasTeam)
                     {
                        _loc3_.activeTeamId = _loc7_.team;
                     }
                     if(_loc7_.hasX)
                     {
                        _loc3_.curPosX = _loc7_.x;
                     }
                     if(_loc7_.hasY)
                     {
                        _loc3_.curPosY = _loc7_.y;
                     }
                     if(_loc7_.hasHp)
                     {
                        _loc3_.activeCurHp = _loc7_.hp;
                     }
                     if(_loc7_.hasRebornTime)
                     {
                        _loc3_.rebornTime = _loc7_.rebornTime;
                     }
                  }
               }
            }
         }
      }
      
      private function __dungeonTurnOpHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",__dungeonTurnOpCall);
      }
      
      private function __dungeonTurnOpCall(param1:PackageIn) : void
      {
         var _loc2_:DungeonTurnOpMsg = new DungeonTurnOpMsg();
         _loc2_ = param1.readBody(_loc2_) as DungeonTurnOpMsg;
         DungeoTurnManager.instance.dungeoTurnop(_loc2_);
      }
      
      private function __synCampaignViewHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SynPlayerViewMsg = new SynPlayerViewMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SynPlayerViewMsg;
         mapModel.synCampaignView(_loc2_);
      }
      
      private function __godsEveningBossHpHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrossGodsMsg = new CrossGodsMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CrossGodsMsg;
         var _loc3_:CampaignNode = mapModel.getMapNodeByNodeId(_loc2_.param3);
         if(_loc3_)
         {
            _loc3_.totalHp = Int64Utils.int64ToNumber(_loc2_.param2);
            _loc3_.curHp = Int64Utils.int64ToNumber(_loc2_.param1);
         }
      }
      
      private function __marketOpbackHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:Object = null;
         var _loc9_:StallInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:Boolean = false;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarketOpMsg = new MarketOpMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as MarketOpMsg;
         if(!_loc2_.stall)
         {
            _loc5_ = {
               "type":_loc2_.opType,
               "stallId":"0",
               "userId":0,
               "isSuccess":_loc2_.param6
            };
            MsgMan.notifyObserver("CampaignEvent.MARKET_OPBACK",_loc5_);
            return;
         }
         if(marketModel.stalls[_loc2_.stall.userId])
         {
            _loc9_ = marketModel.stalls[_loc2_.stall.userId] as StallInfo;
         }
         else
         {
            _loc9_ = new StallInfo();
            marketModel.stalls[_loc2_.stall.userId] = _loc9_;
         }
         _loc9_.userId = _loc2_.stall.userId;
         if(_loc9_.state != _loc2_.stall.state)
         {
            _loc9_.state = _loc2_.stall.state;
            _loc4_ = true;
         }
         _loc9_.stallId = _loc2_.stall.uid;
         _loc9_.name = _loc2_.stall.name;
         _loc9_.x = _loc2_.stall.xPos;
         _loc9_.y = _loc2_.stall.yPos;
         var _loc3_:CampaignArmy = mapModel.getUserArmyByUserId(_loc9_.userId);
         if(_loc3_)
         {
            _loc3_.sellState = _loc9_.state;
         }
         if(_loc3_)
         {
            _loc3_.stallName = _loc9_.name;
         }
         _loc9_.items.length = 0;
         for each(var _loc7_:StallItemMsg in _loc2_.stall.items)
         {
            _loc6_ = new GoodsInfo();
            _loc6_.id = _loc7_.itemInfo.id;
            _loc6_.templateId = _loc7_.itemInfo.templateId;
            _loc6_.count = _loc7_.itemInfo.count;
            _loc6_.marketPrice = _loc7_.point;
            _loc6_.pos = _loc7_.itemInfo.pos;
            _loc6_.bagType = _loc7_.itemInfo.bagType;
            _loc6_.property1 = _loc7_.itemInfo.property1;
            if(_loc6_.pos < 12)
            {
               _loc9_.items[_loc6_.pos] = _loc6_;
            }
         }
         if(_loc4_)
         {
            _loc3_.dispatchEvent(new CampaignMapEvent("IS_SELLING",null));
         }
         _loc5_ = {
            "type":_loc2_.opType,
            "stallId":_loc2_.stall.uid,
            "userId":_loc2_.stall.userId,
            "isSuccess":_loc2_.param6
         };
         MsgMan.notifyObserver("CampaignEvent.MARKET_OPBACK",_loc5_);
      }
      
      private function __marketInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc9_:StallInfo = null;
         var _loc3_:CampaignArmy = null;
         var _loc6_:int = 0;
         if(mapModel == null)
         {
            return;
         }
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarketMsg = new MarketMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as MarketMsg;
         var _loc5_:Array = [];
         for each(var _loc4_:StallMsg in _loc2_.stalls)
         {
            if(marketModel.stalls[_loc4_.userId])
            {
               _loc9_ = marketModel.stalls[_loc4_.userId] as StallInfo;
            }
            else
            {
               _loc9_ = new StallInfo();
               marketModel.stalls[_loc4_.userId] = _loc9_;
            }
            if(_loc9_)
            {
               _loc3_ = mapModel.getUserArmyByUserId(_loc4_.userId);
               if(_loc9_.state == 2 || _loc4_.state == 2)
               {
                  if(_loc9_.name != _loc4_.name)
                  {
                     if(_loc5_.indexOf(_loc4_.userId) < 0)
                     {
                        _loc5_.push(_loc4_.userId);
                     }
                  }
                  if(_loc9_.state != _loc4_.state)
                  {
                     if(_loc5_.indexOf(_loc4_.userId) < 0)
                     {
                        _loc5_.push(_loc4_.userId);
                     }
                  }
               }
               if(_loc3_)
               {
                  _loc3_.stallName = _loc4_.name;
               }
               if(_loc3_)
               {
                  _loc3_.sellState = _loc4_.state;
               }
               _loc9_.userId = _loc4_.userId;
               _loc9_.stallId = _loc4_.uid;
               _loc9_.name = _loc4_.name;
               _loc9_.state = _loc4_.state;
               _loc9_.x = _loc4_.xPos;
               _loc9_.y = _loc4_.yPos;
               _loc9_.isNew = true;
            }
         }
         for(var _loc8_:String in marketModel.stalls)
         {
            if(marketModel.stalls[_loc8_].isNew)
            {
               marketModel.stalls[_loc8_].isNew = false;
            }
            else
            {
               _loc3_ = mapModel.getUserArmyByUserId(marketModel.stalls[_loc8_].userId);
               if(_loc3_)
               {
                  _loc3_.sellState = 0;
               }
               if(_loc5_.indexOf(marketModel.stalls[_loc8_].userId) < 0)
               {
                  _loc5_.push(marketModel.stalls[_loc8_].userId);
               }
               delete marketModel.stalls[_loc8_];
            }
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = mapModel.getUserArmyByUserId(_loc5_[_loc6_]);
            if(_loc3_)
            {
               _loc3_.dispatchEvent(new CampaignMapEvent("IS_SELLING",null));
            }
            _loc6_++;
         }
      }
      
      private function __updateRankHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         DelayActionsUtils.instance.addAction(new AlertTipAction(_loc2_,updateQuizRank,"CAMPAIGN_MAP_SCENE"));
      }
      
      private function updateQuizRank(param1:PackageIn) : void
      {
         var _loc2_:AnswerQuestionRankListMsg = new AnswerQuestionRankListMsg();
         _loc2_ = param1.readBody(_loc2_) as AnswerQuestionRankListMsg;
         MsgMan.notifyObserver("yishi.datas.consant.UPDATE_RANK_INFO_EVENT",_loc2_);
      }
      
      private function __updateRankMyInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",sendUpdateMyInfo);
      }
      
      private function sendUpdateMyInfo(param1:PackageIn) : void
      {
         var _loc2_:AnswerQuestionPlayerMsg = new AnswerQuestionPlayerMsg();
         _loc2_ = param1.readBody(_loc2_) as AnswerQuestionPlayerMsg;
         MsgMan.notifyObserver("yishi.datas.consant.GET_RANK_MY_INFO_EVENT",_loc2_);
      }
      
      private function __getQuestionHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         DelayActionsUtils.instance.addAction(new AlertTipAction(_loc2_,sendGetQuestion,"CAMPAIGN_MAP_SCENE"));
      }
      
      private function sendGetQuestion(param1:PackageIn) : void
      {
         var _loc2_:SingleAnswerQuestionMsg = new SingleAnswerQuestionMsg();
         _loc2_ = param1.readBody(_loc2_) as SingleAnswerQuestionMsg;
         MsgMan.notifyObserver("yishi.datas.consant.QUIZ_ACTIVITY_GET_QUESTION_EVENT",_loc2_);
      }
      
      private function __emeDreamStateUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaBossStateMsg = new ConsortiaBossStateMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaBossStateMsg;
         var _loc3_:ConsortiaEmeDreamInfo = ConsortiaManager.instance.model.emeDreamInfo;
         _loc3_.taskProcessArr = [_loc2_.missionAProcess,_loc2_.missionBProcess,_loc2_.missionCProcess];
         _loc3_.taskSkillIdProcessArr = [_loc2_.missionASkillId,_loc2_.missionBSkillId,_loc2_.missionCSkillId];
         MsgMan.notifyObserver("CampaignEvent.CONSORTIA_BOSS_STATE_UPDATE",null);
      }
      
      private function __emeDreamBuffUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         var _loc3_:ConsortiaEmeDreamInfo = ConsortiaManager.instance.model.emeDreamInfo;
         _loc3_.nightmareState = _loc2_.param1;
         _loc3_.sleepState = _loc2_.param2;
         MsgMan.notifyObserver("CampaignEvent.CONSORTIA_BOSS_STATE_UPDATE",null);
      }
      
      private function __emeDreamBuffTrapHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:MapBuffHurtData = null;
         var _loc3_:MapBuffHurtData = null;
         var _loc4_:CampaignArmy = null;
         var _loc11_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as PropertyMsg;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         if(!StringHelper.isNullOrEmpty(_loc2_.param4))
         {
            _loc5_ = createEmeDreamStunBuffData();
            _loc11_ = _loc2_.param4.split(",");
            _loc6_ = int(_loc11_.length);
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc10_ = int(_loc11_[_loc7_]);
               _loc4_ = mapModel.getUserArmyByUserId(_loc10_);
               if(_loc4_)
               {
                  _loc4_.updateBuffEmeDream(_loc5_);
               }
               _loc7_++;
            }
         }
         if(!StringHelper.isNullOrEmpty(_loc2_.param5))
         {
            _loc3_ = createEmeDreamStunBuffData(1);
            _loc8_ = _loc2_.param5.split(",");
            _loc6_ = int(_loc8_.length);
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc10_ = int(_loc8_[_loc7_]);
               _loc4_ = mapModel.getUserArmyByUserId(_loc10_);
               if(_loc4_)
               {
                  _loc4_.updateBuffEmeDream(_loc3_);
               }
               _loc7_++;
            }
         }
      }
      
      private function createEmeDreamStunBuffData(param1:int = 0) : MapBuffHurtData
      {
         var _loc2_:MapBuffHurtData = new MapBuffHurtData();
         _loc2_.buffId = ConsortiaEmeDreamInfo.TRAP_STUN_BUFF_ID;
         _loc2_.state = param1;
         return _loc2_;
      }
      
      private function __mineralHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:MineralCarInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TramcarInfoMsg = new TramcarInfoMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TramcarInfoMsg;
         var _loc3_:int = int(_loc2_.carInfo.length);
         if(!mineralModel)
         {
            return;
         }
         mineralModel.maxCount = _loc2_.count;
         mineralModel.multiple = _loc2_.multiple;
         if(_loc3_ > 1)
         {
            mineralModel.resetCarInfos();
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = int((_loc2_.carInfo[_loc4_] as CarInfo).userId);
            _loc7_ = mineralModel.getCarInfoById(_loc6_);
            if(!_loc7_)
            {
               _loc7_ = new MineralCarInfo();
            }
            _loc7_.ownerId = _loc6_;
            _loc7_.isUpdate = true;
            _loc7_.armyId = (_loc2_.carInfo[_loc4_] as CarInfo).armyId;
            _loc7_.minerals = (_loc2_.carInfo[_loc4_] as CarInfo).minerals;
            _loc7_.quality = (_loc2_.carInfo[_loc4_] as CarInfo).quality;
            _loc7_.get_count = (_loc2_.carInfo[_loc4_] as CarInfo).tramcarCount;
            _loc7_.hand_count = (_loc2_.carInfo[_loc4_] as CarInfo).handCount;
            _loc7_.pick_count = (_loc2_.carInfo[_loc4_] as CarInfo).pickCount;
            if(_loc7_.is_own != (_loc2_.carInfo[_loc4_] as CarInfo).isOwn)
            {
               _loc7_.is_own = (_loc2_.carInfo[_loc4_] as CarInfo).isOwn;
               mineralModel.addCarInfo(_loc7_);
               setCarUpdate(_loc6_);
            }
            else
            {
               _loc7_.is_own = (_loc2_.carInfo[_loc4_] as CarInfo).isOwn;
               mineralModel.addCarInfo(_loc7_);
            }
            _loc4_++;
         }
         mineralModel.activeTime = _loc2_.activeTime;
         mineralModel.commit();
      }
      
      private function setCarUpdate(param1:int) : void
      {
         var _loc2_:CampaignArmy = mapModel.getUserArmyByUserId(param1);
         if(_loc2_)
         {
            mineralModel.updateCar(_loc2_);
         }
      }
      
      private function __battleInfoResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc10_:String = null;
         var _loc12_:Point = null;
         var _loc13_:BaseItemMsg = null;
         var _loc5_:int = 0;
         var _loc8_:GoodsInfo = null;
         var _loc9_:CampaignNode = null;
         var _loc14_:ChestInfo = null;
         var _loc7_:BaseArmy = null;
         var _loc3_:CampaignMapController = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:BattleReportMsg = new BattleReportMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as BattleReportMsg;
         var _loc4_:Array = [];
         var _loc11_:int = int(_loc2_.baseItem.length);
         _loc5_ = 0;
         while(_loc5_ < _loc11_)
         {
            _loc13_ = _loc2_.baseItem[_loc5_] as BaseItemMsg;
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc13_.templateId;
            _loc8_.count = _loc13_.count;
            _loc4_.push(_loc8_);
            _loc5_++;
         }
         if(_loc11_ > 0)
         {
            _loc10_ = _loc2_.signId;
            _loc12_ = new Point(_loc2_.posX,_loc2_.posY);
         }
         if(_loc4_.length > 0 && mapModel)
         {
            _loc9_ = new CampaignNode();
            _loc14_ = new ChestInfo();
            _loc7_ = mapModel.selfMemberData;
            if(!_loc7_)
            {
               _loc7_ = ArmyManager.instance.army;
            }
            _loc14_.id = 1000000000000 + int(Math.random() * 100000);
            _loc9_.nodeId = 1000000000000 + int(Math.random() * 100000);
            _loc14_.signId = _loc10_;
            _loc14_.names = LanguageMgr.GetTranslation("battle.handler.BattleResultHandler.name");
            _loc14_.types = 92;
            _loc9_.sonType = 2201;
            _loc9_.preNodeIds = "";
            _loc9_.nextNodeIds = "";
            _loc14_.state = 1;
            _loc14_.posX = _loc7_.curPosX;
            _loc14_.posY = _loc7_.curPosY;
            _loc14_.nodePosX = _loc12_.x;
            _loc14_.nodePosY = _loc12_.y;
            _loc14_.grade = 0;
            _loc9_.info = _loc14_;
            _loc9_.tempData = _loc4_;
            mapModel.addTempChestNode(_loc9_);
            if(SceneManager.instance.currentScene is CampaignMapController)
            {
               _loc3_ = CampaignManager.instance.controller as CampaignMapController;
               _loc3_ && _loc3_.view && _loc3_.view.mainBuidingLayer && _loc3_.view.mainBuidingLayer.addNodeNow(_loc9_);
            }
         }
      }
      
      private function __trailPropInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:TrailPropInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerTrialMsg = new PlayerTrialMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlayerTrialMsg;
         trialModel.currentLayer = _loc2_.param1;
         trialModel.rewardExp = _loc2_.param2;
         trialModel.rewardBox = _loc2_.param3;
         for each(var _loc3_:TrialInfoMsg in _loc2_.trialInfos)
         {
            _loc5_ = trialModel.getShopItemByIndex(_loc3_.index);
            if(!_loc5_)
            {
               _loc5_ = new TrailPropInfo();
               trialModel.addShopItem(_loc5_);
            }
            _loc5_.index = _loc3_.index;
            _loc5_.id = _loc3_.skillId;
            _loc5_.currentCount = _loc3_.param1;
            _loc5_.maxCount = _loc3_.param2;
            _loc5_.cost = _loc3_.param3;
         }
      }
      
      protected function __campiagnOpenMv(param1:SLGSocketEvent) : void
      {
         mapModel.showOpenTimeMv();
      }
      
      private function __towerDiedHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",riverTower);
      }
      
      private function riverTower(param1:PackageIn) : void
      {
         var _loc2_:TowerDiedMsg = new TowerDiedMsg();
         _loc2_ = param1.readBody(_loc2_) as TowerDiedMsg;
         var _loc3_:* = mapModel.selfMemberData;
         mapModel.selfMemberData.isDie = 1;
         NotificationManager.instance.dispatchEvent(new CampaignMapEvent("MAZE_DIE",int(_loc2_.msg)));
      }
      
      private function __timeJudgeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TimeJudgeMsg = new TimeJudgeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TimeJudgeMsg;
         mapModel.syncErrorTime = _loc2_.secondCount;
         mapModel.syncEndTime = DateFormatter.parse(_loc2_.stopTime,"YYYY-MM-DD hh:mm:ss");
      }
      
      private function __updateArmyHandler(param1:NotificationEvent) : void
      {
         var _loc3_:BaseArmy = param1.data as BaseArmy;
         if(!_loc3_ || !_loc3_.baseHero || !roomInfo)
         {
            return;
         }
         var _loc2_:CampaignArmy = roomInfo.getPlayerByUserId(_loc3_.userId,_loc3_.baseHero.serviceName);
         if(_loc2_ && _loc2_.baseHero)
         {
            _loc2_.baseHero.armsEquipAvata = _loc3_.baseHero.armsEquipAvata;
            _loc2_.baseHero.bodyEquipAvata = _loc3_.baseHero.bodyEquipAvata;
            _loc2_.baseHero.hideFashion = _loc3_.baseHero.hideFashion;
            _loc2_.baseHero.armsFashionAvata = _loc3_.baseHero.armsFashionAvata;
            _loc2_.baseHero.bodyFashionAvata = _loc3_.baseHero.bodyFashionAvata;
            _loc2_.baseHero.wingAvata = _loc3_.baseHero.wingAvata;
            _loc2_.baseHero.hairFashionAvata = _loc3_.baseHero.hairFashionAvata;
         }
      }
      
      private function __battleResultHandler(param1:NotificationEvent) : void
      {
         if(!param1.data && mapModel && mapModel.selfMemberData)
         {
            mapModel.selfMemberData.angle = -1;
         }
      }
      
      private function __broadBufferHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:CampaignArmy = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyBufferListMsg = new ArmyBufferListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ArmyBufferListMsg;
         for each(var _loc5_:ArmyBufferMsg in _loc2_.armyBuffer)
         {
            _loc3_ = mapModel.getUserArmyByUserId(_loc5_.userId);
            _loc3_.bufferTempId = _loc5_.bufferTempId;
         }
      }
      
      private function __nodePosRefershHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:CampaignNode = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignNodePosRefershListMsg = new CampaignNodePosRefershListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as CampaignNodePosRefershListMsg;
         for each(var _loc3_:CampaignNodePosRefershMsg in _loc2_.node)
         {
            if(mapModel.mapId != _loc3_.mapId)
            {
               return;
            }
            _loc4_ = mapModel.getMapNodesById(_loc3_.nodeId);
            _loc4_.info.state = _loc3_.state;
            _loc4_.info.posX = _loc3_.posX;
            _loc4_.info.posY = _loc3_.posY;
            _loc4_.fixX = _loc3_.posX * 20;
            _loc4_.fixY = _loc3_.posY * 20;
            _loc4_.curPosX = _loc3_.posX;
            _loc4_.curPosY = _loc3_.posY;
            _loc4_.move(_loc3_.posX,_loc3_.posY);
         }
      }
      
      private function __warreportHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:Number = getTimer() - _exitTime;
         if(_loc2_ > 30000)
         {
            _exitTime = getTimer();
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc4_:String = SwitchPageHelp.returnScene;
         tempMapId = mapModel.mapId;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc3_,_loc4_,__warReportCall);
      }
      
      private function __warReportCall(param1:PackageIn) : void
      {
         var _loc6_:WarFightOrderInfo = null;
         var _loc2_:WarReportListMsg = new WarReportListMsg();
         _loc2_ = param1.readBody(_loc2_) as WarReportListMsg;
         var _loc5_:WarReportInfo = new WarReportInfo();
         _loc5_.ownCount = _loc2_.ownCount;
         _loc5_.teamCount = _loc2_.teamCount;
         _loc5_.oneScore = _loc2_.oneScore;
         _loc5_.twoScore = _loc2_.twoScore;
         _loc5_.thdScore = _loc2_.thdScore;
         _loc5_.tempId = _loc2_.tempId;
         _loc5_.oneTeamId = _loc2_.oneTeamId;
         _loc5_.thdTeamId = _loc2_.thdTemaId;
         _loc5_.twoTeamId = _loc2_.twoTeamId;
         pvpWarFightModel.fightReportInfo = _loc5_;
         _loc5_.commit();
         var _loc3_:Array = [];
         for each(var _loc4_:WarReportMsg in _loc2_.info)
         {
            _loc6_ = new WarFightOrderInfo();
            _loc6_.hitCount = _loc4_.hitCount;
            _loc6_.nickName = _loc4_.nickName;
            _loc6_.order = _loc4_.order;
            _loc6_.score = _loc4_.score;
            _loc6_.userId = _loc4_.userId;
            _loc6_.teamId = _loc4_.teamId;
            _loc6_.geste = _loc4_.geste;
            if(_loc4_.hasServerName)
            {
               _loc6_.serverName = _loc4_.serverName;
            }
            _loc6_.honner = _loc4_.winGesteCount;
            _loc6_.medal = _loc4_.itemCount;
            _loc6_.seniorStoreCount = _loc4_.seniorStoreCount;
            _loc6_.soulsStoreCount = _loc4_.soulsStoreCount;
            _loc6_.param1 = _loc4_.param1;
            _loc6_.param2 = _loc4_.param2;
            _loc3_.push(_loc6_);
         }
         pvpWarFightModel.warFightOrderList = _loc3_;
         FrameControllerManager.instance.openControllerByInfo("duskarea",null,{"mapId":tempMapId});
      }
      
      private function __orderrequestHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:WarFightOrderInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:WarReportListMsg = new WarReportListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as WarReportListMsg;
         var _loc3_:Array = [];
         for each(var _loc4_:WarReportMsg in _loc2_.info)
         {
            _loc6_ = new WarFightOrderInfo();
            _loc6_.uuid = _loc4_.playerUuid;
            _loc6_.hitCount = _loc4_.hitCount;
            _loc6_.nickName = _loc4_.nickName;
            _loc6_.order = _loc4_.order;
            _loc6_.score = _loc4_.score;
            _loc6_.userId = _loc4_.userId;
            _loc6_.teamId = _loc4_.teamId;
            _loc6_.geste = _loc4_.geste;
            if(_loc4_.hasParam2)
            {
               _loc6_.param2 = _loc4_.param2;
            }
            if(_loc4_.hasServerName)
            {
               _loc6_.serverName = _loc4_.serverName;
            }
            _loc3_.push(_loc6_);
         }
         pvpWarFightModel.warFightOrderList = _loc3_;
         NotificationManager.instance.dispatchEvent(new PvpWarFightEvent("PVP_WAR_FIGHT_ORDER_REPORT",{
            "list":_loc3_,
            "report":null
         }));
      }
      
      private function __warfieldInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:WarFightInfoMsg = new WarFightInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as WarFightInfoMsg;
         pvpWarFightModel.pvpWarFightInfo.hitCount = _loc2_.hitCount;
         pvpWarFightModel.pvpWarFightInfo.leftTime = _loc2_.leftTime;
         pvpWarFightModel.pvpWarFightInfo.oneCount = _loc2_.oneCount;
         pvpWarFightModel.pvpWarFightInfo.oneScore = _loc2_.oneScore;
         pvpWarFightModel.pvpWarFightInfo.order = _loc2_.order;
         pvpWarFightModel.pvpWarFightInfo.score = _loc2_.score;
         pvpWarFightModel.pvpWarFightInfo.teamId = _loc2_.teamId;
         pvpWarFightModel.pvpWarFightInfo.geste = _loc2_.geste;
         pvpWarFightModel.pvpWarFightInfo.twoCount = _loc2_.twoCount;
         pvpWarFightModel.pvpWarFightInfo.twoScore = _loc2_.twoScore;
         pvpWarFightModel.pvpWarFightInfo.buleFlagCount = _loc2_.one_FlagCount;
         pvpWarFightModel.pvpWarFightInfo.redFlagCount = _loc2_.two_FlagCount;
         pvpWarFightModel.pvpWarFightInfo.commit();
      }
      
      private function __playerHangupstateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:CampaignArmy = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerHangupStateListMsg = new PlayerHangupStateListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PlayerHangupStateListMsg;
         var _loc3_:Array = _loc2_.hanupState;
         for each(var _loc6_:PlayerHangupStateMsg in _loc3_)
         {
            _loc4_ = mapModel.getUserArmyByArmyId(_loc6_.armyId);
            if(_loc4_)
            {
               _loc4_.hangupState = _loc6_.state;
            }
         }
      }
      
      private function __armyPosListBroadHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PosMoveListMsg = new PosMoveListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PosMoveListMsg;
         mapModel.movePathsArmyList(_loc2_);
      }
      
      private function __armyPosBroadHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PosMoveMsg = new PosMoveMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PosMoveMsg;
         mapModel.movePathsArmy(_loc2_);
      }
      
      private function __updateArmyPosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyPosUpdatedMsg = new ArmyPosUpdatedMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ArmyPosUpdatedMsg;
         mapModel.gotoPosArmy(_loc2_);
      }
      
      private function __multiHpsyncHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:CampaignArmy = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:MultiCampaignHpSyncMsg = new MultiCampaignHpSyncMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as MultiCampaignHpSyncMsg;
         var _loc5_:CampaignNode = mapModel.getMapNodeByNodeId(_loc2_.nodeId);
         if(_loc5_)
         {
            _loc5_.totalHp = _loc2_.nodeTotalHp;
            _loc5_.curHp = _loc2_.nodeHp;
         }
         for each(var _loc3_:MultiPlayerHpSyncMsg in _loc2_.playerHp)
         {
            _loc4_ = mapModel.getUserArmyByArmyId(_loc3_.armyId);
            if(_loc4_)
            {
               _loc4_.updateArmyHpInfo(_loc3_.curHp,_loc3_.totalHp);
            }
         }
      }
      
      private function __playerDieStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:CampaignArmy = null;
         var _loc5_:CampaignNode = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerStateListMsg = new PlayerStateListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlayerStateListMsg;
         for each(var _loc3_:WorldBossPlayerStateMsg in _loc2_.playerState)
         {
            _loc6_ = mapModel.getUserArmyByArmyId(_loc3_.armyId,_loc3_.serverName);
            if(_loc6_)
            {
               if(_loc3_.hasLeftTime)
               {
                  _loc6_.riverStartTime = getTimer();
                  _loc6_.riverTime = _loc3_.leftTime;
               }
               if(_loc3_.hasState)
               {
                  _loc6_.goddessTeamId = _loc3_.templateId;
                  _loc6_.goddessId = _loc3_.npcNodeId;
                  _loc6_.isDie = _loc3_.state;
                  NotificationManager.instance.sendNotification("GODS_EVENING_GODDESS",_loc6_);
               }
               if(_loc3_.hasResCount)
               {
                  _loc6_.oreNum = _loc3_.resCount;
               }
               CampaignManager.instance.pvpWarFightModel.isFlag = CampaignArmyState.checkisFlag(_loc6_.isDie);
               if(CampaignArmyState.inTower(_loc6_.isDie) || Boolean(CampaignArmyState.inVehicle(_loc6_.isDie)))
               {
                  _loc6_.enterNode(_loc3_.npcNodeId,_loc3_.templateId);
                  _loc5_ = mapModel.getMapNodeByNodeId(_loc3_.npcNodeId);
                  if(_loc5_)
                  {
                     _loc6_.updateNodeHpInfo(_loc5_.curHp,_loc5_.totalHp);
                  }
               }
               else
               {
                  _loc6_.exitNode();
               }
            }
         }
      }
      
      private function __consortiaEmeDreamBossHpHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:WorldBossInfoMsg = new WorldBossInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as WorldBossInfoMsg;
         if(!WorldBossHelper.checkConsortiaEmeDream(mapModel.mapId))
         {
            return;
         }
         worldBossModel.curHp = Int64Utils.int64ToNumber(_loc2_.curHp);
         worldBossModel.totalHp = Int64Utils.int64ToNumber(_loc2_.totalHp);
         worldBossModel.commit();
      }
      
      private function __syncBossHpHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:WoundInfoMsg = null;
         var _loc4_:WoundInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:WorldBossInfoMsg = new WorldBossInfoMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as WorldBossInfoMsg;
         if(mapModel.campaignTemplate.CampaignId != _loc2_.campaignId)
         {
            return;
         }
         worldBossModel.curHp = Int64Utils.int64ToNumber(_loc2_.curHp);
         worldBossModel.totalHp = Int64Utils.int64ToNumber(_loc2_.totalHp);
         worldBossModel.campaignId = _loc2_.campaignId;
         worldBossModel.totalNum = _loc2_.totalNum;
         worldBossModel.buffGrade = _loc2_.bufferGrade;
         worldBossModel.selfWoundInfo.wound = Int64Utils.int64ToNumber(_loc2_.myWound);
         worldBossModel.selfWoundInfo.totalHp = Int64Utils.int64ToNumber(_loc2_.totalHp);
         worldBossModel.selfWoundInfo.nickName = PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
         worldBossModel.selfWoundInfo.job = PlayerManager.instance.currentPlayerModel.playerInfo.job;
         worldBossModel.bossGrades = _loc2_.grades;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.woundInfo.length)
         {
            _loc3_ = _loc2_.woundInfo[_loc5_];
            _loc4_ = worldBossModel.getWoundInfoByNickname(_loc3_.nickName);
            if(!_loc4_)
            {
               _loc4_ = new WoundInfo(_loc5_);
            }
            if(_loc4_)
            {
               _loc4_.nickName = _loc3_.nickName;
               _loc4_.wound = Int64Utils.int64ToNumber(_loc3_.wound);
               _loc4_.userId = _loc3_.userId;
               _loc4_.totalHp = worldBossModel.totalHp;
               _loc4_.job = _loc3_.job;
            }
            worldBossModel.addWoundInfo(_loc4_);
            _loc5_++;
         }
         if(mapModel.campaignTemplate.Types == 1)
         {
            BaseManager.instance.wordBossInvincibleState = _loc2_.bossState == 0 ? true : false;
         }
         worldBossModel.commit();
      }
      
      private function __playerChatHandler(param1:NotificationEvent) : void
      {
         var _loc3_:ChatData = param1.data as ChatData;
         if(!mapModel || !_loc3_)
         {
            return;
         }
         if(_loc3_.channel != 6 && _loc3_.channel != 8)
         {
            return;
         }
         var _loc2_:CampaignArmy = mapModel.getUserArmyByUserId(_loc3_.uid,_loc3_.serverName);
         if(_loc2_)
         {
            _loc2_.chatData = _loc3_;
         }
      }
      
      private function __standPosHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:StandPosMsg = new StandPosMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as StandPosMsg;
         var _loc3_:CampaignArmy = mapModel.getUserArmyByArmyId(_loc2_.id,_loc2_.serverName);
         _loc3_.curPosX = _loc2_.posX;
         _loc3_.curPosY = _loc2_.posY;
         var _loc5_:BaseArmy = ArmyManager.instance.army;
         if(_loc5_.id == _loc2_.id)
         {
            _loc5_.curPosX = _loc2_.posX;
            _loc5_.curPosY = _loc2_.posY;
         }
         mapModel.standPos(_loc2_);
      }
      
      private function __roomKillOutHandler(param1:NotificationEvent) : void
      {
         var _loc2_:CampaignArmy = null;
         var _loc3_:int = int(param1.data);
         if(mapModel)
         {
            _loc2_ = mapModel.removeUserArmyByArmyId(_loc3_);
         }
      }
      
      private function __followNpcHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:NPCFollowMsg = new NPCFollowMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as NPCFollowMsg;
         var _loc3_:CampaignNode = mapModel.getMapNodesById(_loc2_.escortId);
         if(_loc3_)
         {
            _loc3_.curPosX = _loc2_.curPosX;
            _loc3_.curPosY = _loc2_.curPosY;
            _loc3_.followTarget = _loc2_.followId;
         }
         _loc2_ = null;
      }
      
      private function __updateNodeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:CampaignNode = null;
         var _loc4_:UnrealShootingNpcAvatarView = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignUpdateNodeListMsg = new CampaignUpdateNodeListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as CampaignUpdateNodeListMsg;
         for each(var _loc5_:CampaignNodeUpdateMsg in _loc2_.node)
         {
            _loc3_ = mapModel.getMapNodeByNodeId(_loc5_.nodeId);
            _loc4_ = mapModel.getNodeByNodeId(_loc5_.nodeId) as UnrealShootingNpcAvatarView;
            if(_loc3_)
            {
               _loc3_.curPosX = _loc5_.posX;
               _loc3_.curPosY = _loc5_.posX;
               _loc3_.info.posX = _loc5_.posX;
               _loc3_.info.posY = _loc5_.posY;
               _loc3_.info.state = _loc5_.nodeState;
            }
         }
      }
      
      private function __campaignNodeAddHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:CampaignNode = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignNodeListMsg = new CampaignNodeListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as CampaignNodeListMsg;
         var _loc5_:Array = [];
         for each(var _loc4_:CampaignNodeMsg in _loc2_.node)
         {
            _loc3_ = readNodeInfo(_loc4_,true);
            if(!mapModel.getMapNodesById(_loc3_.info.id))
            {
               _loc5_.push(_loc3_);
            }
         }
         mapModel.addNodes = _loc5_;
      }
      
      private function readNodeInfo(param1:CampaignNodeMsg, param2:Boolean = false) : CampaignNode
      {
         var _loc3_:CampaignNode = null;
         if(param2)
         {
            _loc3_ = mapModel.getMapNodesById(param1.nodeId);
         }
         if(!_loc3_)
         {
            _loc3_ = new CampaignNode();
         }
         var _loc4_:PhysicInfo = new PhysicInfo();
         _loc4_.id = param1.nodeId;
         _loc3_.nodeId = param1.campDataId;
         _loc4_.names = param1.nodeName;
         _loc4_.types = param1.masterType;
         _loc3_.sonType = param1.sonType;
         _loc3_.preNodeIds = param1.preNodeIds;
         _loc3_.nextNodeIds = param1.nextNodeIds;
         _loc4_.state = param1.state;
         _loc4_.posX = param1.posX;
         _loc4_.posY = param1.posY;
         _loc3_.curPosX = param1.curX;
         _loc3_.curPosY = param1.curY;
         _loc4_.grade = param1.level;
         _loc3_.attackTypes = param1.attackTypes;
         _loc3_.nameColor = param1.nameColor;
         _loc3_.toward = param1.toward;
         _loc3_.resource = param1.resource;
         _loc3_.resetPosX = param1.resetX;
         _loc3_.resetPosY = param1.resetY;
         _loc3_.visitUserIds = param1.visitUserIds;
         _loc3_.fixX = param1.fixX;
         _loc3_.fixY = param1.fixY;
         _loc3_.handlerRange = param1.handlerRange;
         _loc3_.heroTemplateId = param1.heroTempId;
         _loc3_.sizeType = param1.sizeType;
         _loc3_.fightCapaity = param1.fightCapaity;
         _loc3_.param1 = param1.param1;
         _loc3_.param2 = param1.param2;
         _loc3_.param3 = param1.param3;
         _loc3_.param4 = param1.param4;
         _loc3_.armyId = param1.armyId;
         _loc3_.demonLeftCount = param1.currentCount;
         if(param1.hasParam5)
         {
            _loc3_.param5 = param1.param5;
         }
         _loc3_.param6 = param1.param6;
         _loc3_.info = _loc4_;
         return _loc3_;
      }
      
      private function __campaignFogHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc3_:Array = null;
         var _loc8_:int = 0;
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignFogMsg = new CampaignFogMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as CampaignFogMsg;
         if(mapModel.mapTempInfo.Id != _loc2_.mapTempId)
         {
            return;
         }
         var _loc9_:int = _loc2_.row;
         var _loc4_:int = _loc2_.col;
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc3_ = [];
            _loc8_ = 0;
            while(_loc8_ < _loc2_.forArray[_loc7_].length)
            {
               _loc3_[_loc8_] = _loc2_.forArray[_loc7_][_loc8_];
               _loc8_++;
            }
            _loc5_[_loc7_] = _loc3_;
            _loc7_++;
         }
         mapModel.fogData = _loc5_;
      }
      
      private function __hookTimeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HangupInfoMsg = new HangupInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HangupInfoMsg;
         mapModel.hookleftWeay = _loc2_.leftWeay;
      }
      
      private function __updateFogHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:FogUpdateMsg = null;
         var _loc3_:int = Math.ceil(mapModel.mapTempInfo.Width / 110);
         var _loc2_:CampaignFogUpdateMsg = new CampaignFogUpdateMsg();
         var _loc5_:PackageIn = param1.data as PackageIn;
         _loc2_ = _loc5_.readBody(_loc2_) as CampaignFogUpdateMsg;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.fogUpdate.length)
         {
            _loc6_ = _loc2_.fogUpdate[_loc4_];
            mapModel.syscFogNode(_loc6_.index,_loc6_.fogByte,_loc3_);
            _loc4_++;
         }
         _loc2_ = null;
      }
      
      private function __attackNodeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignNodeSuccMsg = new CampaignNodeSuccMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CampaignNodeSuccMsg;
         mapModel.currentDieNodeId = _loc2_.nodeId;
         _loc2_ = null;
         _loc3_ = null;
      }
      
      private function __campaignSceneMoveHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerMoveCameraMsg = new PlayerMoveCameraMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlayerMoveCameraMsg;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc3_,_loc2_.scene,addQueue);
         _loc2_ = null;
      }
      
      private function __playMovieHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",addQueue);
      }
      
      private function addQueue(param1:PackageIn) : void
      {
         if(CampaignManager.instance.exit)
         {
            return;
         }
         CoreTransactionManager.getInstance().currentTimeAddQueue(param1);
      }
      
      private function __updateCampaignArmyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyMsg = new ArmyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ArmyMsg;
         var _loc3_:CrossArmyMsg = new CrossArmyMsg();
         _loc3_.armyId = _loc2_.armyId;
         _loc3_.curPosX = _loc2_.curPosX;
         _loc3_.curPosY = _loc2_.curPosY;
         _loc3_.playerId = _loc2_.playerId;
         _loc3_.serverName = _loc2_.serverName;
         _loc3_.state = _loc2_.state;
         updatePlayerArmyInfo(_loc3_);
      }
      
      private function __crossArmyUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrossArmyListMsg = new CrossArmyListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CrossArmyListMsg;
         for each(var _loc4_:CrossArmyMsg in _loc2_.armyList)
         {
            updatePlayerArmyInfo(_loc4_);
         }
      }
      
      private function updatePlayerArmyInfo(param1:CrossArmyMsg) : void
      {
         if(null == param1)
         {
            return;
         }
         var _loc4_:Boolean = false;
         var _loc3_:String = param1.hasServerName ? param1.serverName : "";
         var _loc2_:CampaignArmy = mapModel.getUserArmyByArmyId(param1.armyId,_loc3_);
         if(!_loc2_)
         {
            _loc4_ = true;
            _loc2_ = mapModel.getSysArmyByArmyId(param1.armyId,_loc3_);
            if(!_loc2_)
            {
               _loc2_ = new CampaignArmy();
               _loc2_.id = param1.armyId;
               _loc2_.userId = param1.playerId;
               _loc2_.baseHero.serviceName = _loc3_;
               mapModel.addSysArmy(_loc2_);
            }
         }
         _loc2_.state = param1.state;
         _loc2_.curPosX = param1.curPosX;
         _loc2_.curPosY = param1.curPosY;
         _loc2_.syncArmyInfo();
         var _loc5_:BaseArmy = ArmyManager.instance.army;
         if(_loc4_)
         {
            NotificationManager.instance.dispatchEvent(new CampaignEvent("SYS_ARMY_UPDATE",_loc2_));
         }
         else if(isSelf(param1.playerId,_loc3_))
         {
            _loc5_.curPosX = param1.curPosX;
            _loc5_.curPosY = param1.curPosY;
         }
         param1 = null;
         mapModel.dispatchEvent(new CampaignEvent("SYS_ARMY_UPDATE",_loc2_));
      }
      
      private function __campaignLoginInHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignLoginMsg = new CampaignLoginMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CampaignLoginMsg;
         var _loc4_:CampaignArmy = mapModel.getUserArmyByUserId(_loc2_.playerId,_loc2_.serverName);
         if(_loc4_)
         {
            _loc4_.online = true;
         }
         _loc2_ = null;
      }
      
      private function __campaingLoginOutHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignLoginMsg = new CampaignLoginMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CampaignLoginMsg;
         var _loc3_:CampaignArmy = mapModel.getUserArmyByUserId(_loc2_.playerId,_loc2_.serverName);
         if(_loc3_)
         {
            _loc3_.online = false;
         }
         _loc2_ = null;
      }
      
      private function __campaingArmyInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:BaseArmy = null;
         var _loc7_:int = 0;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyMsg = new ArmyMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as ArmyMsg;
         var _loc6_:int = int(_loc2_.armyId);
         var _loc10_:int = int(_loc2_.playerId);
         var _loc4_:String = _loc2_.nickName;
         var _loc8_:int = int(_loc2_.type);
         var _loc5_:String = _loc2_.hasServerName ? _loc2_.serverName : "";
         if(isSelf(_loc10_,_loc5_))
         {
            _loc3_ = ArmyManager.instance.army;
         }
         else
         {
            _loc3_ = _loc8_ == 5 ? new SystemArmy() : new UserArmy();
            _loc3_.id = _loc6_;
            _loc3_.nickName = _loc4_;
            _loc3_.userId = _loc10_;
            _loc3_.baseHero.serviceName = _loc5_;
            _loc3_.type = _loc8_;
         }
         _loc3_.mapId = _loc2_.mapId;
         _loc3_.curPosX = _loc2_.curPosX;
         _loc3_.curPosY = _loc2_.curPosY;
         _loc3_.state = _loc2_.state;
         if(_loc2_.hasSimpleHeroInfo)
         {
            _loc3_.baseHero.consortiaID = _loc2_.consortiaId;
            _loc3_.baseHero.consortiaName = _loc2_.consortiaName;
            ThaneInfoHelper.readHeroInfo(_loc3_.baseHero,_loc2_.simpleHeroInfo);
         }
         _loc7_ = 0;
         while(_loc7_ < _loc2_.armyPawn.length)
         {
            SocketGameReader.readArmyPawnInfo(_loc3_,_loc2_.armyPawn[_loc7_] as ArmyPawnInfoMsg);
            _loc7_++;
         }
         if(_loc3_.type == 5)
         {
            mapModel.addSysArmy(_loc3_);
         }
         mapModel.dispatchEvent(new CampaignEvent("SYS_ARMY_UPDATE",_loc3_));
      }
      
      private function __campaignResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         CampaignManager.CampaignOverState = true;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",addQueue);
         TaskTraceTipManager.instance.clean();
      }
      
      private function __campaignFinishInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",addQueue);
      }
      
      private function __npcMoveHandler(param1:SLGSocketEvent) : void
      {
         if(!mapModel)
         {
            return;
         }
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:NPCMoveMsg = new NPCMoveMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as NPCMoveMsg;
         var _loc3_:CampaignNode = mapModel.getMapNodesById(_loc2_.id);
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            _loc3_.curPosX = _loc2_.curPosX;
            _loc3_.curPosY = _loc2_.curPosY;
         }
         if(_loc3_ && _loc3_.info.types == 151)
         {
            SocketSceneBufferManager.instance.addPkgToBuffer(_loc4_,"CAMPAIGN_MAP_SCENE",npcMove);
         }
         else
         {
            mapModel.moveNpc(_loc2_);
            _loc4_ = null;
         }
      }
      
      private function npcMove(param1:PackageIn) : void
      {
         if(!mapModel)
         {
            return;
         }
         var _loc2_:NPCMoveMsg = new NPCMoveMsg();
         _loc2_ = param1.readBody(_loc2_) as NPCMoveMsg;
         mapModel.moveNpc(_loc2_);
         param1 = null;
      }
      
      private function __updateCampaignNodeHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignNodeUpdateMsg = new CampaignNodeUpdateMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as CampaignNodeUpdateMsg;
         var _loc6_:int = _loc2_.nodeId;
         var _loc4_:int = _loc2_.nodeState;
         var _loc3_:CampaignNode = mapModel.getMapNodesById(_loc6_);
         if(_loc3_)
         {
            if(_loc2_.hasNodeName)
            {
               _loc3_.info.names = _loc2_.nodeName;
            }
            _loc3_.param1 = _loc2_.param1;
            _loc3_.armyId = _loc2_.param2;
            _loc3_.demonLeftCount = _loc2_.currentCount;
            _loc3_.uid = _loc2_.uuId;
            _loc3_.fightUserId = _loc2_.userId;
            _loc2_.hasSonType && (_loc3_.sonType = _loc2_.sonType);
            _loc3_.info.state = _loc4_;
            if(_loc3_.info.types == 1001)
            {
               if(_loc3_.info.state == 20)
               {
                  FarmManager.instance.model.bigBonFireIsOpen = true;
               }
               else if(_loc3_.info.state == 19 || _loc3_.info.state == 9)
               {
                  FarmManager.instance.model.bigBonFireIsOpen = false;
               }
            }
            _loc3_.visitUserIds = _loc2_.visitUserIds;
            if(_loc2_.hasPosX && _loc2_.hasPosY)
            {
               _loc3_.curPosX = _loc2_.posX;
               _loc3_.curPosY = _loc2_.posY;
               if(_loc3_.nodeView)
               {
                  _loc3_.nodeView.x = _loc3_.curPosX * 20;
                  _loc3_.nodeView.y = _loc3_.curPosY * 20;
               }
            }
            if(_loc3_.info.types == 192)
            {
               mapModel.steelMapIsChanged = true;
            }
            _loc3_.commit();
         }
         _loc2_ = null;
         mapModel.dispatchEvent(new Event("UPDATE_CAMPAING_NODE"));
      }
      
      private function __exitCampaignSceneHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignExitMsg = new CampaignExitMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CampaignExitMsg;
         if(_loc2_.result > 0)
         {
            _loc5_ = int(_loc2_.playerId);
            _loc3_ = int(_loc2_.armyId);
            if(isSelf(_loc5_,_loc2_.serverName))
            {
               if(CampaignManager.instance.mapId == 4101)
               {
                  _exitTime = getTimer();
               }
               RoomManager.instance.dispose();
               CampaignManager.instance.exit = true;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("CROSS_ADD_GOONBTN"));
               exitBack();
            }
            else
            {
               if(mapModel)
               {
                  mapModel.removeUserArmyByArmyId(_loc3_,_loc2_.serverName);
               }
               if(roomInfo)
               {
                  roomInfo.removePlayerByUserId(_loc5_,_loc2_.serverName);
               }
            }
            BloodyManager.instance.disposeCountDown();
            MolongManager.instance.disposeCountDown();
         }
         _loc4_ = null;
         _loc2_ = null;
      }
      
      private function isSelf(param1:int, param2:String) : Boolean
      {
         if(mapModel && mapModel.isCross)
         {
            return param1 == selfPlayerInfo.userId && param2 == selfPlayerInfo.serviceName;
         }
         return param1 == selfPlayerInfo.userId;
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      private function __campaignBossArmyListHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ThaneInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:BossArmyListMsg = new BossArmyListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as BossArmyListMsg;
         var _loc3_:ThaneInfo = new ThaneInfo();
         _loc3_.nickName = _loc2_.bossName;
         _loc3_.grades = _loc2_.level;
         _loc3_.templateId = _loc2_.bossTemplateId;
         var _loc7_:Dictionary = new Dictionary(true);
         for each(var _loc4_:FightPlayerMsg in _loc2_.fightPlayer)
         {
            _loc5_ = new ThaneInfo();
            _loc5_.userId = _loc4_.playerId;
            _loc5_.nickName = _loc4_.nickName;
            _loc5_.pics = _loc4_.pic;
            _loc7_[_loc5_.userId] = _loc5_;
         }
         mapModel.attackBossTeam(_loc7_,_loc2_.leftFightTime,_loc3_);
         _loc6_ = null;
         _loc2_ = null;
      }
      
      private function __campaignBossArmyInviteHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:BossInviteMsg = new BossInviteMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as BossInviteMsg;
         var _loc3_:ThaneInfo = new ThaneInfo();
         _loc3_.nickName = _loc2_.bossNick;
         _loc3_.grades = _loc2_.level;
         _loc3_.templateId = _loc2_.templateId;
         mapModel.inviteAttackBoos(_loc2_.nickName,_loc3_,_loc2_.leftFightTime,new Point(_loc2_.posX,_loc2_.posY));
         _loc2_ = null;
         _loc4_ = null;
      }
      
      private function exitBack() : void
      {
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            this.dispose();
            CampaignManager.instance.dispose();
         }
         else if(GameHallManager.instance.model.selfTeam)
         {
            GameHallManager.instance.enterGameHallScene();
         }
         else
         {
            SwitchPageHelp.returnToSpace();
         }
      }
      
      public function get selfPlayerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __lockNpcHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:AvatarBaseView = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:NodeLockReqMsg = new NodeLockReqMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as NodeLockReqMsg;
         var _loc3_:CampaignNode = mapModel.getMapNodeByNodeId(_loc2_.nodeId);
         if(_loc3_ && _loc3_.nodeView is AvatarBaseView)
         {
            _loc4_ = _loc3_.nodeView as AvatarBaseView;
            _loc4_.info.pathInfo = [];
            _loc4_.restrictMoveCount = 130;
         }
      }
      
      private function myRollResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DragonCampaingnDataMsg = new DragonCampaingnDataMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DragonCampaingnDataMsg;
         mapModel.rollInfos = _loc2_.rollInfos;
         MolongManager.instance.startTimeShaizi = getTimer();
         MsgMan.notifyObserver("map.campaign.view.ui.molong.GET_SHAIZI_INFO",_loc2_.rollInfos);
         BattleManager.molongLayer = _loc2_.curRound;
      }
      
      private function rollMaxNumResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RollInfoMsg = new RollInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RollInfoMsg;
         MsgMan.notifyObserver("map.campaign.view.ui.molong.FALL_BOXES",_loc2_);
      }
      
      private function dragonCampaignInfoResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DragonCampaingnDataMsg = new DragonCampaingnDataMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DragonCampaingnDataMsg;
         mapModel.rollInfos = _loc2_.rollInfos;
         MolongManager.instance.acceptedServerInfo(_loc2_);
         if(WorldBossHelper.checkBloody(mapModel.mapId))
         {
            RandomShaiziManager.instance.acceptedServerInfo(_loc2_);
            RandomShaiziManager.instance.cdTime = _loc2_.campaignTm / 1000;
         }
      }
      
      private function bloodyRollResult(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:EggStateMsg = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PoundEggMsg = new PoundEggMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PoundEggMsg;
         var _loc6_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.state.length)
         {
            _loc3_ = _loc2_.state[_loc4_] as EggStateMsg;
            if(_loc3_.userId == ArmyManager.instance.thane.userId)
            {
               _loc6_ = true;
            }
            _loc4_++;
         }
         if(!_loc6_)
         {
            return;
         }
         mapModel.bloodyRollInfos = _loc2_.state;
         BloodyManager.instance.startTimeShaizi = getTimer();
         if(CampaignManager.instance.mapModel.randomBossBuffefMsgInfo)
         {
            CampaignManager.instance.mapModel.randomBossBuffefMsgInfo.turn = _loc2_.currentWare;
         }
         if(CampaignManager.instance.bloodyCurrentWave != _loc2_.currentWare)
         {
            __bloodyWaveChangeHandle(null);
         }
         CampaignManager.instance.bloodyCurrentWave = _loc2_.currentWare;
         BloodyManager.instance.expireTime = Int64Utils.int64ToNumber(_loc2_.expireTime);
         MsgMan.notifyObserver("map.campaign.view.ui.bloody.GET_EGG_INFO",_loc2_.state);
         NotificationManager.instance.sendNotification("RANDOM_CAMPAIGN_UPDATE_TIME");
      }
      
      private function bloodyFallBoxResult(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:EggInfoMsg = null;
         var _loc7_:int = 0;
         var _loc5_:EggInfoMsg = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:PickupEggMsg = new PickupEggMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as PickupEggMsg;
         BloodyManager.instance.eggInfo = _loc2_.eggInfo;
         if(CampaignManager.instance.bloodyCurrentWave != _loc2_.currentWare)
         {
            __bloodyWaveChangeHandle(null);
         }
         CampaignManager.instance.bloodyCurrentWave = _loc2_.currentWare;
         var _loc3_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.eggInfo.length)
         {
            _loc6_ = _loc2_.eggInfo[_loc4_] as EggInfoMsg;
            if(_loc6_.status)
            {
               _loc3_ = true;
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc2_.eggInfo.length)
            {
               _loc5_ = _loc2_.eggInfo[_loc7_] as EggInfoMsg;
               if(_loc5_.status)
               {
                  MsgMan.notifyObserver("map.campaign.view.ui.bloody.BOX_HAS_PICK",_loc2_);
               }
               else
               {
                  MsgMan.notifyObserver("map.campaign.view.ui.bloody.FALL_BOXES",_loc5_);
               }
               _loc7_++;
            }
         }
         NotificationManager.instance.sendNotification("RANDOM_CAMPAIGN_UPDATE_TIME");
      }
      
      private function bloodyRealmInfoHandle(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BloodyRealmCampaignInfoMsg = new BloodyRealmCampaignInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BloodyRealmCampaignInfoMsg;
         if(CampaignManager.instance.bloodyCurrentWave != _loc2_.currentWare)
         {
            __bloodyWaveChangeHandle(null);
         }
         CampaignManager.instance.bloodyCurrentWave = _loc2_.currentWare;
         NotificationManager.instance.sendNotification("RANDOM_CAMPAIGN_UPDATE_TIME");
      }
      
      private function __bloodyWaveChangeHandle(param1:NotificationEvent) : void
      {
         BloodyManager.instance.myClickEggIndex = -1;
         BloodyManager.instance.posInfo = [0,0,0,0,0,0,0,0,0,0,0,0];
      }
      
      private function __updateFlameTempleEnergyListHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:FlameTempleEnergyGapInfo = null;
         var _loc3_:CampaignNode = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:WarEnergyListMsg = new WarEnergyListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as WarEnergyListMsg;
         var _loc4_:PvpWarFightModel = CampaignManager.instance.pvpWarFightModel;
         for each(var _loc7_:WarEnergyMsg in _loc2_.energy)
         {
            _loc3_ = mapModel.getMapNodeByNodeId(_loc7_.nodeTempId);
            if(_loc3_)
            {
               _loc3_.tempData = _loc7_.currentIndex;
               _loc3_.param1 = _loc7_.ownerTeamId;
               _loc3_.commit();
            }
            _loc5_ = _loc4_.getEnergyGapByNodeId(_loc7_.nodeTempId);
            if(_loc5_)
            {
               _loc5_.bluePlayerCount = _loc7_.blueCount;
               _loc5_.redPlayerCount = _loc7_.redsCount;
               _loc5_.progress = _loc7_.currentIndex;
               _loc5_.team = _loc7_.ownerTeamId;
            }
         }
         _loc4_.pvpWarFightInfo.commit();
      }
      
      private function __groupfbMovieHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleAttackRspMsg = new VehicleAttackRspMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as VehicleAttackRspMsg;
         var _loc7_:MapSkillResultInfo = MapSkillResultInfo.createFromAttackMsg(_loc2_);
         var _loc6_:CampaignNode = mapModel.getMapNodeByNodeId(_loc7_.casterId);
         if(_loc6_)
         {
            _loc6_.useSkill(_loc7_);
         }
      }
      
      private function __groupfbAttackHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc4_:MapSkillHurtData = null;
         var _loc3_:CampaignArmy = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleAttackRspMsg = new VehicleAttackRspMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as VehicleAttackRspMsg;
         var _loc6_:MapSkillResultInfo = MapSkillResultInfo.createFromAttackMsg(_loc2_);
         for each(_loc5_ in _loc2_.playerHurtDataList)
         {
            _loc4_ = MapSkillHurtData.createFromHurtDataMsg(_loc2_.attackerId,_loc2_.serverName,_loc5_);
            _loc4_.attackType = _loc2_.attackTyep;
            _loc4_.buffLeftTime = _loc5_.leftTime;
            _loc3_ = mapModel.getUserArmyByUserId(_loc4_.effectId,_loc4_.effectServiceName);
            if(_loc3_)
            {
               _loc3_.beHurt(_loc4_);
            }
         }
      }
      
      private function __playerAttackHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:HurtDataMsg = null;
         var _loc4_:MapSkillHurtData = null;
         var _loc3_:CampaignArmy = null;
         var _loc9_:CampaignArmy = null;
         var _loc6_:CampaignNode = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleAttackRspMsg = new VehicleAttackRspMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as VehicleAttackRspMsg;
         if(!_loc2_.hasSkillId)
         {
            _loc5_ = _loc2_.playerHurtDataList[0];
            if(!_loc5_)
            {
               return;
            }
            _loc4_ = MapSkillHurtData.createFromHurtDataMsg(_loc2_.attackerId,_loc2_.serverName,_loc5_);
            _loc3_ = mapModel.getUserArmyByUserId(_loc4_.effectId,_loc4_.effectServiceName);
            if(_loc3_)
            {
               _loc3_.beHurt(_loc4_);
            }
            return;
         }
         var _loc7_:MapSkillResultInfo = MapSkillResultInfo.createFromAttackMsg(_loc2_);
         if(_loc7_.attackType == 1)
         {
            _loc9_ = mapModel.getUserArmyByUserId(_loc7_.casterId,_loc7_.casterService);
            if(_loc9_)
            {
               _loc9_.useSkill(_loc7_);
            }
         }
         else if(_loc7_.attackType == 2)
         {
            _loc9_ = mapModel.getUserArmyByUserId(_loc7_.casterId,_loc7_.casterService);
            if(_loc9_)
            {
               _loc9_.useJumpSkill(_loc7_);
            }
         }
         else
         {
            _loc6_ = mapModel.getMapNodeByNodeId(_loc7_.casterId);
            if(_loc6_)
            {
               _loc6_.useSkill(_loc7_);
            }
         }
      }
      
      private function onRandomBossBuffInfo(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:RandomBuffMsg = null;
         var _loc5_:RandomBuffMsgInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:RandomBossBuffefMsg = new RandomBossBuffefMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as RandomBossBuffefMsg;
         mapModel.randomBossBuffefMsgInfo = new RandomBossBuffefMsgInfo();
         if(mapModel.randomBossBuffefMsgInfo.turn != _loc2_.turn)
         {
            mapModel.randomBossBuffefMsgInfo.turn = _loc2_.turn;
            if(mapModel.mapNodesData != null)
            {
               _loc4_ = 0;
               while(_loc4_ < mapModel.mapNodesData.length)
               {
                  if(CampaignNode(mapModel.mapNodesData[_loc4_]).info.types == 92)
                  {
                     CampaignNode(mapModel.mapNodesData[_loc4_]).info.state = 8;
                     CampaignNode(mapModel.mapNodesData[_loc4_]).commit();
                  }
                  _loc4_++;
               }
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.buffs.length)
         {
            _loc3_ = _loc2_.buffs[_loc4_];
            _loc5_ = new RandomBuffMsgInfo();
            _loc5_.buy_count = _loc3_.buyCount;
            _loc5_.skillId = _loc3_.skillId;
            mapModel.randomBossBuffefMsgInfo.buffs.push(_loc5_);
            _loc4_++;
         }
         NotificationManager.instance.sendNotification("RANDOM_CAMPAIGN_UPDATE_BUFF");
      }
      
      private function __playerUnrealShootingSkillHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleSkillListMsg = new VehicleSkillListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VehicleSkillListMsg;
         mapModel.selfMemberData.updateUnrealShootingSkillInfo(_loc2_.skillId,_loc2_.state,_loc2_.curSum);
      }
      
      private function __syncBuffListHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:MapBuffHurtData = null;
         var _loc7_:CampaignArmy = null;
         var _loc3_:CampaignNode = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc5_:VehicleBuffListMsg = new VehicleBuffListMsg();
         _loc5_ = _loc6_.readBody(_loc5_) as VehicleBuffListMsg;
         if(WorldBossHelper.checkSteel(mapModel.mapId))
         {
            for each(_loc2_ in _loc5_.playerBuffStates)
            {
               _loc7_ = mapModel.getUserArmyByUserId(_loc2_.playerId,_loc2_.serverName);
               if(_loc7_)
               {
                  _loc4_ = MapBuffHurtData.createFromVehicleBuffStateMsg(_loc2_);
                  _loc7_.updateBuffSteel(_loc4_);
                  log({},"player:" + _loc7_.baseHero.nickName + ", " + _loc4_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
                  if(_loc4_.buffTemplate)
                  {
                     log({},_loc4_.buffTemplate.Name);
                  }
               }
            }
            for each(_loc2_ in _loc5_.npcBuffStates)
            {
               _loc3_ = mapModel.getMapNodeByNodeId(_loc2_.playerId);
               if(_loc3_)
               {
                  _loc4_ = MapBuffHurtData.createFromVehicleBuffStateMsg(_loc2_);
                  _loc3_.beHurt(_loc4_);
                  log({},"npc:" + _loc2_.playerId + ", " + _loc4_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
                  if(_loc4_.buffTemplate)
                  {
                     log({},_loc4_.buffTemplate.Name);
                  }
               }
            }
         }
         else if(WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            for each(_loc2_ in _loc5_.playerBuffStates)
            {
               _loc7_ = mapModel.getUserArmyByUserId(_loc2_.playerId,_loc2_.serverName);
               if(_loc7_)
               {
                  _loc4_ = MapBuffHurtData.createFromVehicleBuffStateMsg(_loc2_);
                  _loc7_.updateBuffActive(_loc4_);
                  log({},"player:" + _loc7_.baseHero.nickName + ", " + _loc4_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
                  if(_loc4_.buffTemplate)
                  {
                     log({},_loc4_.buffTemplate.Name);
                  }
               }
            }
            for each(_loc2_ in _loc5_.npcBuffStates)
            {
               _loc3_ = mapModel.getMapNodeByNodeId(_loc2_.playerId);
               if(_loc3_)
               {
                  _loc4_ = MapBuffHurtData.createFromVehicleBuffStateMsg(_loc2_);
                  _loc3_.beHurt(_loc4_);
                  log({},"npc:" + _loc2_.playerId + ", " + _loc4_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
                  if(_loc4_.buffTemplate)
                  {
                     log({},_loc4_.buffTemplate.Name);
                  }
               }
            }
         }
         else if(WorldBossHelper.checkUnrealShooting(mapModel.mapId))
         {
            for each(_loc2_ in _loc5_.playerBuffStates)
            {
               _loc7_ = mapModel.getUserArmyByUserId(_loc2_.playerId,_loc2_.serverName);
               if(_loc7_)
               {
                  _loc4_ = MapBuffHurtData.createFromVehicleBuffStateMsg(_loc2_);
                  _loc7_.updateBuffUnrealShooting(_loc4_);
                  log({},"player:" + _loc7_.baseHero.nickName + ", " + _loc4_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
                  if(_loc4_.buffTemplate)
                  {
                     log({},_loc4_.buffTemplate.Name);
                  }
               }
            }
            for each(_loc2_ in _loc5_.npcBuffStates)
            {
               _loc3_ = mapModel.getMapNodeByNodeId(_loc2_.playerId);
               if(_loc3_)
               {
                  _loc4_ = MapBuffHurtData.createFromVehicleBuffStateMsg(_loc2_);
                  if(_loc3_.info.types == 206)
                  {
                     _loc3_.beHurt(_loc4_);
                  }
                  else
                  {
                     _loc3_.updateBuff(_loc4_);
                  }
                  log({},"npc:" + _loc2_.playerId + ", " + _loc4_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
                  if(_loc4_.buffTemplate)
                  {
                     log({},_loc4_.buffTemplate.Name);
                  }
               }
            }
         }
         else
         {
            for each(_loc2_ in _loc5_.playerBuffStates)
            {
               _loc7_ = mapModel.getUserArmyByUserId(_loc2_.playerId,_loc2_.serverName);
               if(_loc7_)
               {
                  _loc4_ = MapBuffHurtData.createFromVehicleBuffStateMsg(_loc2_);
                  _loc7_.updateBuff(_loc4_);
                  log({},"player:" + _loc7_.baseHero.nickName + ", " + _loc4_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
                  if(_loc4_.buffTemplate)
                  {
                     log({},_loc4_.buffTemplate.Name);
                  }
               }
            }
            for each(_loc2_ in _loc5_.npcBuffStates)
            {
               _loc3_ = mapModel.getMapNodeByNodeId(_loc2_.playerId);
               if(_loc3_)
               {
                  _loc4_ = MapBuffHurtData.createFromVehicleBuffStateMsg(_loc2_);
                  if(_loc3_.param2 == 6)
                  {
                     _loc7_ = mapModel.findArmyInNode(_loc2_.playerId);
                     if(_loc7_)
                     {
                        _loc4_.effectServiceName = _loc7_.baseHero.serviceName;
                        _loc7_.updateBuff(_loc4_);
                        log({},"player:" + _loc7_.baseHero.nickName + ", " + _loc4_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
                        if(_loc4_.buffTemplate)
                        {
                           log({},_loc4_.buffTemplate.Name);
                        }
                     }
                  }
                  else
                  {
                     _loc3_.beHurt(_loc4_);
                     log({},"npc:" + _loc2_.playerId + ", " + _loc4_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
                     if(_loc4_.buffTemplate)
                     {
                        log({},_loc4_.buffTemplate.Name);
                     }
                  }
               }
            }
         }
      }
      
      private function __playerSkillHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:VehicleSkillListMsg = null;
         var _loc3_:SnowVehicleSkillListMsg = null;
         var _loc5_:CampaignArmy = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         if(WorldBossHelper.checkSteel(mapModel.mapId))
         {
            _loc2_ = new VehicleSkillListMsg();
            _loc2_ = _loc4_.readBody(_loc2_) as VehicleSkillListMsg;
            mapModel.selfMemberData.updateSteelSkillInfo(_loc2_.skillId,_loc2_.state,_loc2_.curSum);
         }
         else if(WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            _loc3_ = new SnowVehicleSkillListMsg();
            _loc3_ = _loc4_.readBody(_loc3_) as SnowVehicleSkillListMsg;
            _loc5_ = mapModel.getUserArmyByUserId(_loc3_.playerId,_loc3_.serverName);
            if(_loc5_)
            {
               _loc5_.updateActiveSkillInfo(_loc3_);
            }
         }
      }
      
      private function __bossAttackNoticeHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleAttackRspMsg = new VehicleAttackRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as VehicleAttackRspMsg;
         var _loc3_:Point = new Point(_loc2_.effectX,_loc2_.effectY);
         _loc3_.x *= 20;
         _loc3_.y *= 20;
         mapModel.bossAttackNotice(_loc3_);
      }
      
      private function __nodeListHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         if(WorldBossHelper.checkUnrealShooting(mapModel.mapId))
         {
            unrealShootingNodeListHandler(_loc2_);
         }
         else if(WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            activeVehicleNodeListHandler(_loc2_);
         }
         else
         {
            nodeListHandler(_loc2_);
         }
      }
      
      private function unrealShootingNodeListHandler(param1:PackageIn) : void
      {
         var _loc4_:CampaignNode = null;
         if(!mapModel)
         {
            return;
         }
         var _loc2_:VehicleNpcNodeListMsg = new VehicleNpcNodeListMsg();
         _loc2_ = param1.readBody(_loc2_) as VehicleNpcNodeListMsg;
         for each(var _loc3_:VehicleNpcNodeMsg in _loc2_.vehicleNpcNode)
         {
            _loc4_ = mapModel.getMapNodeByNodeId(_loc3_.nodeId);
            if(_loc4_ && _loc4_.info)
            {
               if(_loc3_.state == 1)
               {
                  _loc4_.info.state = 8;
               }
               else
               {
                  _loc4_.info.state = 1;
               }
            }
         }
      }
      
      private function activeVehicleNodeListHandler(param1:PackageIn) : void
      {
         var _loc4_:CampaignNode = null;
         if(!mapModel)
         {
            return;
         }
         var _loc2_:VehicleNpcNodeListMsg = new VehicleNpcNodeListMsg();
         _loc2_ = param1.readBody(_loc2_) as VehicleNpcNodeListMsg;
         var _loc5_:Array = [];
         for each(var _loc3_:VehicleNpcNodeMsg in _loc2_.vehicleNpcNode)
         {
            _loc4_ = mapModel.getMapNodeByNodeId(_loc3_.nodeId);
            if(_loc4_ && _loc4_.info)
            {
               if(_loc4_.info.types == 99999 || _loc4_.info.types == 99998)
               {
                  if(_loc3_.state == 1)
                  {
                     mapModel.removeMapNodeByInfo(_loc4_);
                     _loc4_.info.state = 8;
                  }
               }
            }
            else if(_loc3_.state == 0)
            {
               _loc4_ = readSnowNodeInfo(_loc3_,true);
               _loc5_.push(_loc4_);
            }
         }
         if(_loc5_.length > 0)
         {
            mapModel.addNodes = _loc5_;
         }
      }
      
      private function nodeListHandler(param1:PackageIn) : void
      {
         var _loc4_:CampaignNode = null;
         if(!mapModel)
         {
            return;
         }
         var _loc2_:VehicleNpcNodeListMsg = new VehicleNpcNodeListMsg();
         _loc2_ = param1.readBody(_loc2_) as VehicleNpcNodeListMsg;
         var _loc5_:Array = [];
         for each(var _loc3_:VehicleNpcNodeMsg in _loc2_.vehicleNpcNode)
         {
            _loc4_ = mapModel.getMapNodeByNodeId(_loc3_.nodeId);
            if(_loc4_ && _loc4_.info)
            {
               if(_loc4_.info.types == 99999)
               {
                  if(_loc3_.state == 1)
                  {
                     _loc4_.info.state = 8;
                     mapModel.removeMapNodeByInfo(_loc4_);
                  }
               }
            }
            else if(_loc3_.state == 0)
            {
               _loc4_ = readSteelNodeInfo(_loc3_,true);
               _loc5_.push(_loc4_);
            }
         }
         if(_loc5_.length > 0)
         {
            mapModel.addNodes = _loc5_;
         }
      }
      
      private function readSnowNodeInfo(param1:VehicleNpcNodeMsg, param2:Boolean = false) : CampaignNode
      {
         var _loc3_:CampaignNode = null;
         var _loc6_:SnowVehicleDropInfo = null;
         if(param2)
         {
            _loc3_ = mapModel.getMapNodeByNodeId(param1.nodeId);
         }
         if(!_loc3_)
         {
            _loc3_ = new CampaignNode();
         }
         var _loc5_:PhysicInfo = new PhysicInfo();
         _loc5_.id = param1.nodeId;
         _loc5_.names = param1.name;
         _loc5_.posX = param1.curX;
         _loc5_.posY = param1.curY;
         if(param1.state == 0)
         {
            _loc5_.state = 1;
         }
         else if(param1.state == 1)
         {
            _loc5_.state = 0;
         }
         _loc3_.nodeId = param1.nodeId;
         _loc3_.nameColor = param1.nameColor;
         _loc3_.curPosX = param1.curX;
         _loc3_.curPosY = param1.curY;
         trace("创建打雪仗中的小怪节点：",_loc5_.names,"节点类型{invalid_utf8=239}{invalid_utf8=188}?",param1.type,param1.nodeId);
         if(param1.type == 0)
         {
            _loc5_.types = 99998;
            _loc3_.sonType = param1.sonType;
            _loc3_.resource = 1;
            if(param1.hasHp)
            {
               _loc3_.curHp = param1.hp;
            }
         }
         else
         {
            _loc5_.types = 99999;
            _loc3_.resource = 2;
            _loc3_.sonType = param1.sonType;
         }
         if(CampaignArmyViewHelper.checkSnowVehicleTowerNode(_loc3_))
         {
            _loc3_.resource = 2;
         }
         _loc3_.snowVehicleDrops = [];
         for each(var _loc4_:SkillBuffMsg in param1.skillBuffList)
         {
            _loc6_ = new SnowVehicleDropInfo();
            _loc6_.type = _loc4_.type;
            _loc6_.tempId = _loc4_.templateId;
            _loc3_.snowVehicleDrops.push(_loc6_);
         }
         _loc3_.snowVehicleDrops.sortOn("type",16);
         _loc3_.info = _loc5_;
         return _loc3_;
      }
      
      private function readSteelNodeInfo(param1:VehicleNpcNodeMsg, param2:Boolean = false) : CampaignNode
      {
         var _loc3_:CampaignNode = null;
         if(param2)
         {
            _loc3_ = mapModel.getMapNodeByNodeId(param1.nodeId);
         }
         if(!_loc3_)
         {
            _loc3_ = new CampaignNode();
         }
         var _loc4_:PhysicInfo = new PhysicInfo();
         _loc4_.id = param1.nodeId;
         _loc4_.names = param1.name;
         _loc4_.posX = param1.curX;
         _loc4_.posY = param1.curY;
         _loc4_.types = 99999;
         if(param1.state == 0)
         {
            _loc4_.state = 1;
         }
         else if(param1.state == 1)
         {
            _loc4_.state = 0;
         }
         _loc3_.nodeId = param1.nodeId;
         _loc3_.sonType = param1.sonType;
         _loc3_.curPosX = param1.curX;
         _loc3_.curPosY = param1.curY;
         _loc3_.resource = 2;
         _loc3_.info = _loc4_;
         return _loc3_;
      }
      
      private function __activeVehicleJoinHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:CampaignArmy = null;
         var _loc4_:CampaignNode = null;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         var _loc6_:MapBuffHurtData = null;
         if(!WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            return;
         }
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerVehicleListMsg = new PlayerVehicleListMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as PlayerVehicleListMsg;
         var _loc9_:CampaignArmy = mapModel.selfMemberData;
         for each(_loc7_ in _loc2_.vehicles)
         {
            if(!_loc7_.hasPlayerId && Boolean(_loc7_.hasTemplateId))
            {
               _loc4_ = mapModel.getMapNodeByNodeId(_loc7_.npcNodeId);
               if(_loc4_)
               {
                  _loc4_.totalHp = _loc7_.maxHp;
                  _loc4_.curHp = _loc7_.hp;
                  for each(_loc5_ in _loc7_.buffState)
                  {
                     _loc6_ = new MapBuffHurtData();
                     _loc6_.buffId = _loc5_;
                     if(_loc4_.info.types == 99998)
                     {
                        _loc4_.updateBuff(_loc6_);
                     }
                     if(_loc6_.buffTemplate)
                     {
                        log({},_loc6_.buffTemplate.Name);
                     }
                  }
               }
            }
            else
            {
               _loc3_ = mapModel.getUserArmyByUserId(_loc7_.playerId,_loc7_.serverName);
               if(_loc3_)
               {
                  if(_loc7_.hasTemplateId && Boolean(_loc7_.hasDefaultSkills))
                  {
                     _loc3_.activeLastTempId = _loc7_.templateId;
                     _loc3_.updateActiveInfo(_loc7_.templateId,_loc7_.defaultSkills);
                  }
                  _loc3_.updateArmyHpInfo(_loc7_.hp,_loc7_.maxHp);
                  _loc3_.updateActiveVehicleHoldKeyState(_loc7_.isHoldKey);
                  for each(_loc5_ in _loc7_.buffState)
                  {
                     _loc6_ = new MapBuffHurtData();
                     _loc6_.buffId = _loc5_;
                     _loc3_.updateBuffActive(_loc6_);
                     if(_loc6_.buffTemplate)
                     {
                        log({},_loc6_.buffTemplate.Name);
                     }
                  }
                  if(_loc7_.hasTeam)
                  {
                     _loc3_.activeTeamId = _loc7_.team;
                  }
                  if(_loc7_.hasX)
                  {
                     _loc3_.curPosX = _loc7_.x;
                  }
                  if(_loc7_.hasY)
                  {
                     _loc3_.curPosY = _loc7_.y;
                  }
                  if(_loc7_.hasHp)
                  {
                     _loc3_.activeCurHp = _loc7_.hp;
                  }
                  if(_loc7_.hasRebornTime)
                  {
                     _loc3_.rebornTime = _loc7_.rebornTime;
                  }
                  _loc3_.checkSnowBallArmyPos();
               }
            }
         }
      }
      
      private function __activeCampaignInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:ActiveVehicleUserInfo = null;
         var _loc6_:VehicleScroeListMsg = null;
         var _loc4_:int = 0;
         if(!WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            return;
         }
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleCampaignDetailMsg = new VehicleCampaignDetailMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as VehicleCampaignDetailMsg;
         if(_loc2_.hasCampaignStartTime)
         {
            activeVehicleModel.campaiganStartTime = DateFormatter.parse(_loc2_.campaignStartTime,"YYYY-MM-DD hh:mm:ss");
         }
         var _loc5_:Array = [];
         if(_loc2_.scroeList)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.scroeList.length)
            {
               _loc6_ = _loc2_.scroeList[_loc4_];
               _loc3_ = new ActiveVehicleUserInfo();
               _loc3_.userId = _loc6_.playerId;
               _loc3_.serverName = _loc6_.serverName;
               _loc3_.nickName = _loc6_.nickName;
               _loc3_.rank = _loc6_.order;
               _loc3_.enterSeq = _loc6_.enterSeq;
               _loc3_.pickSkillNum = _loc6_.pickSkillCount;
               _loc5_.push(_loc3_);
               _loc4_++;
            }
         }
         _loc5_.sortOn("enterSeq",16);
         MsgMan.notifyObserver("ActiveFlushRank",_loc5_);
      }
      
      private function __activeVehicleExitHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:CampaignArmy = null;
         if(!WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleExitMsg = new VehicleExitMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VehicleExitMsg;
         if(selfPlayerInfo.userId == _loc2_.playerId)
         {
            RoomManager.instance.dispose();
            CampaignManager.instance.exit = true;
            exitBack();
         }
         else
         {
            _loc4_ = mapModel.getUserArmyByUserId(_loc2_.playerId);
            if(mapModel)
            {
               mapModel.removeUserArmyByArmyId(_loc4_.id,"");
            }
            if(roomInfo)
            {
               roomInfo.removePlayerByUserId(_loc2_.playerId,"");
            }
         }
      }
      
      private function __activeCampaignEndHandler(param1:SLGSocketEvent) : void
      {
         if(!WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SnowVehicleEndRewardMsg = new SnowVehicleEndRewardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SnowVehicleEndRewardMsg;
         _snowVehicleInfo = new SnowVehicleReportInfo();
         _snowVehicleInfo.myRank = _loc2_.myRank;
         _snowVehicleInfo.isOnHook = _loc2_.isOnHook;
         _snowVehicleInfo.pickSkillNum = _loc2_.pickSkillNum;
         _snowVehicleInfo.damage = _loc2_.damage;
         _snowVehicleInfo.eliminateNum = _loc2_.eliminateNum;
         _snowVehicleInfo.todayReward = _loc2_.todayReward;
         RoomManager.instance.dispose();
         CampaignManager.instance.exit = true;
         exitBack2(_loc3_);
      }
      
      private function exitBack2(param1:PackageIn) : void
      {
         var _loc2_:String = null;
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            this.dispose();
            CampaignManager.instance.dispose();
            __activeCampaignEndCall(param1);
         }
         else
         {
            _loc2_ = SwitchPageHelp.returnScene;
            SocketSceneBufferManager.instance.addPkgToBuffer(param1,_loc2_,__activeCampaignEndCall);
         }
      }
      
      private function __activeCampaignEndCall(param1:PackageIn) : void
      {
         CampaignFrameHelper.showActiveVehicleAccoutFrameHandler(_snowVehicleInfo);
         _snowVehicleInfo = null;
      }
      
      private function __activeCampaignMoveHandler(param1:SLGSocketEvent) : void
      {
         if(!mapModel)
         {
            return;
         }
         if(mapModel.exit)
         {
            return;
         }
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",__activeCampaignMoveImp);
      }
      
      private function __activeCampaignMoveImp(param1:PackageIn) : void
      {
         var _loc2_:VehicleMoveMsg = null;
         var _loc3_:VehicleMoveListMsg = null;
         var _loc4_:int = 0;
         var _loc6_:Position = null;
         var _loc7_:Position = null;
         var _loc8_:* = null;
         var _loc5_:UnrealShootingNpcAvatarView = null;
         if(WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            _loc2_ = new VehicleMoveMsg();
            _loc2_ = param1.readBody(_loc2_) as VehicleMoveMsg;
            if(!mapModel)
            {
               return;
            }
            if(mapModel.exit)
            {
               return;
            }
            mapModel.moveActiveVehiclePaths(_loc2_);
         }
         else if(WorldBossHelper.checkUnrealShooting(mapModel.mapId))
         {
            if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
            {
               return;
            }
            _loc3_ = new VehicleMoveListMsg();
            _loc3_ = param1.readBody(_loc3_) as VehicleMoveListMsg;
            for each(_loc8_ in _loc3_.list)
            {
               _loc5_ = mapModel.getNodeByNodeId(_loc8_.playerId) as UnrealShootingNpcAvatarView;
               if(_loc5_)
               {
                  if(_loc5_.nodeInfo.info.types == 205)
                  {
                     _loc6_ = _loc8_.path[0];
                     _loc7_ = _loc8_.path[1];
                     if(_loc6_)
                     {
                        if(_loc7_)
                        {
                           searchPath(_loc5_,_loc6_,_loc7_);
                        }
                        else
                        {
                           _loc5_.x = _loc6_.x * 20;
                           _loc5_.y = _loc6_.y * 20;
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function searchPath(param1:UnrealShootingNpcAvatarView, param2:Position, param3:Position) : void
      {
         var _loc5_:Point = CampaignManager.instance.mapModel.getAroundWalkPoint(param2.x * 20,param2.y * 20);
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:Point = CampaignManager.instance.mapModel.getAroundWalkPoint(param3.x * 20,param3.y * 20);
         if(!_loc6_)
         {
            return;
         }
         var _loc4_:Array = SearchPathHelper.searchPath(new Point(param1.x,param1.y),new Point(_loc6_.x * 20,_loc6_.y * 20));
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.length > 2)
         {
            _loc4_.shift();
         }
         param1.aiInfo.pathInfo = _loc4_;
      }
      
      private function __fantasyMatrixMainHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FantasyMatrixMainMsg = new FantasyMatrixMainMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as FantasyMatrixMainMsg;
         fantasyMatrixModel.isStart = _loc2_.countDownStart;
         fantasyMatrixModel.leftTime = _loc2_.leftTime;
         fantasyMatrixModel.curScore = _loc2_.score;
         fantasyMatrixModel.hasBoxCount = _loc2_.boxCount;
         fantasyMatrixModel.skillAttackUpCount = _loc2_.skillAttackUp;
         fantasyMatrixModel.skillAddScoreCount = _loc2_.skillAddScore;
         fantasyMatrixModel.skillScoreUpCount = _loc2_.skillScoreUp;
         MsgMan.notifyObserver("FANTASYMATRIX_MAIN_UPDATE");
      }
      
      private function __fantasyMatrixMapInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:FantasyMatrixNodeInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FantasyMatrixMapMsg = new FantasyMatrixMapMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FantasyMatrixMapMsg;
         for each(var _loc3_:FantasyMatrixNodeMsg in _loc2_.nodeList)
         {
            _loc4_ = fantasyMatrixModel.getNodeInfoByXY(_loc3_.posX,_loc3_.posY);
            if(!_loc4_)
            {
               _loc4_ = new FantasyMatrixNodeInfo();
               fantasyMatrixModel.nodeArr.push(_loc4_);
            }
            _loc4_.posX = _loc3_.posX;
            _loc4_.posY = _loc3_.posY;
            _loc4_.pawnTempId = _loc3_.pawnTempId;
            _loc4_.pawnLevel = _loc3_.pawnLevel;
            _loc4_.showBox = _loc3_.showBox;
            _loc4_.showSkillId = _loc3_.showSkill;
            _loc4_.isFighting = _loc3_.fighting;
            _loc4_.state = _loc3_.state;
            _loc4_.pawnSonType = _loc3_.pawnSontype;
         }
         MsgMan.notifyObserver("FANTASYMATRIX_MAP_UPDATE",_loc2_.nodeList);
      }
      
      private function __CampaignBattleRequestHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",__onSceneCompleteHandler);
      }
      
      private function __onSceneCompleteHandler(param1:PackageIn) : void
      {
         var _loc2_:CampaignNodeArriveRequestMsg = new CampaignNodeArriveRequestMsg();
         _loc2_ = param1.readBody(_loc2_) as CampaignNodeArriveRequestMsg;
         var _loc3_:CampaignNode = mapModel.getMapNodeByNodeId(_loc2_.nodeId);
         if(_loc3_ && _loc3_.info.state != 8 && _loc3_.info.state != 9)
         {
            CampaignManager.instance.controller.sendCampaignArrive(selfarmy.id,_loc2_.nodeId);
         }
      }
      
      private function __childWarCampaignHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         CampaignManager.instance.childWarHasSkillArr = [];
         if(_loc2_.hasParam4)
         {
            CampaignManager.instance.childWarHasSkillArr = _loc2_.param4.split(",");
         }
         MsgMan.notifyObserver("CHILD_WAR_BUFF_CHANGE");
      }
      
      private function __deepPriosionInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         deepPrisonModel.allScore = _loc2_.param1;
         deepPrisonModel.selfScore = _loc2_.param2;
         deepPrisonModel.waveScore = _loc2_.param3;
         deepPrisonModel.scoreString = _loc2_.param4;
         deepPrisonModel.allRewardArray = sort(_loc2_.param5);
         deepPrisonModel.personalRewardArray = sort(_loc2_.param6);
         deepPrisonModel.endTime = _loc2_.param12;
         MsgMan.notifyObserver("DEEP_PRISION_UPDATE");
      }
      
      private function __airGardenCampaignHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AirGardenCampaignMsg = new AirGardenCampaignMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AirGardenCampaignMsg;
         if(_loc2_.hasMasterUserId)
         {
            airGardenModel.campaignInfo.masterUserId = _loc2_.masterUserId;
         }
         if(_loc2_.hasNickName)
         {
            airGardenModel.campaignInfo.nickName = _loc2_.nickName;
         }
         if(_loc2_.hasHeadId)
         {
            airGardenModel.campaignInfo.headId = _loc2_.headId;
         }
         if(_loc2_.hasFightCapacity)
         {
            airGardenModel.campaignInfo.fightPower = _loc2_.fightCapacity;
         }
         if(_loc2_.hasIntro)
         {
            airGardenModel.campaignInfo.intro = _loc2_.intro;
         }
         if(_loc2_.hasIsParty)
         {
            airGardenModel.campaignInfo.isParty = _loc2_.isParty;
         }
         if(_loc2_.hasUpCount)
         {
            airGardenModel.campaignInfo.upCount = _loc2_.upCount;
         }
         if(_loc2_.hasHotCount)
         {
            airGardenModel.campaignInfo.hotCount = _loc2_.hotCount;
         }
         if(_loc2_.hasTotalScore)
         {
            airGardenModel.campaignInfo.totalScore = _loc2_.totalScore;
         }
         airGardenModel.campaignInfo.gameRemainList = _loc2_.gameRemainList;
         MsgMan.notifyObserver("CAMPAIGN_INFO_UPDATE");
      }
      
      private function __singleCampaignHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.hasParam1)
         {
            singleCampaignModel.curIndex = _loc2_.param1;
         }
         MsgMan.notifyObserver("UPDATE_SINGLE_CAMPAIGN");
      }
      
      private function sort(param1:String) : Array
      {
         var _loc2_:Array = param1.split("|");
         _loc2_.sort(sortByScore);
         return _loc2_;
      }
      
      private function sortByScore(param1:String, param2:String) : int
      {
         var _loc4_:int = int(param1.split(",")[0]);
         var _loc3_:int = int(param2.split(",")[0]);
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         if(_loc4_ == _loc3_)
         {
            return 0;
         }
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         return 0;
      }
      
      public function dispose() : void
      {
         if(_isProxy)
         {
            removeSocketEvent(SocketDataProxyManager.instance.model);
            SocketDataProxyManager.instance.removeEventListener("READ_SOCKET_DATA_OVEW",__readOverHandler);
         }
         else
         {
            removeSocketEvent(SocketManager.instance);
         }
         _isUse = false;
      }
   }
}

