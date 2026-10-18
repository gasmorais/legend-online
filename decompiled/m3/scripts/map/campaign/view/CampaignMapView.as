package map.campaign.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.bg.BgLayer;
   import farm.view.FarmLandItem;
   import farm.view.FarmLandLayer;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mainBar.SmallMapBar;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.MouseData;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.helper.mapview.CampaignMapCenterCheckHelper;
   import map.campaign.mediator.QuizActivity.QuizActivityMediator;
   import map.campaign.mediator.activevehicle.ActiveVehicleRiverMediator;
   import map.campaign.mediator.activevehicle.ActiveVehicleSelectTargetMediator;
   import map.campaign.mediator.activevehicle.ActiveVehicleUIMediator;
   import map.campaign.mediator.airgarden.AirGardenUIMediator;
   import map.campaign.mediator.childwar.ChildWarUIMediater;
   import map.campaign.mediator.deepprison.DeepPrisonUIMediater;
   import map.campaign.mediator.duskarea.DuskAreaUIMediator;
   import map.campaign.mediator.emedream.EmeDreamRiverMediator;
   import map.campaign.mediator.emedream.EmeDreamUIMediator;
   import map.campaign.mediator.farm.FarmMediator;
   import map.campaign.mediator.flametemple.FlameTempleUIMediator;
   import map.campaign.mediator.godsevening.GodsEveningUIMediator;
   import map.campaign.mediator.gvg.GvgChaseNpcMediator;
   import map.campaign.mediator.gvg.GvgRiverMediator;
   import map.campaign.mediator.hero.ChaseNPCMediator;
   import map.campaign.mediator.house.HouseMoveMediator;
   import map.campaign.mediator.house.HouseUIMediator;
   import map.campaign.mediator.layer.ActivationMovieMediator;
   import map.campaign.mediator.mapview.CampaignCountDownMediator;
   import map.campaign.mediator.mapview.CampaignMapCursorMediator;
   import map.campaign.mediator.mapview.CampaignMapMouseEventMediator;
   import map.campaign.mediator.mapview.CampaignSmallMapMediator;
   import map.campaign.mediator.mapview.ConsortiaSecretMapMediator;
   import map.campaign.mediator.mapview.ForbiddenBossMediator;
   import map.campaign.mediator.mapview.MapCameraMediator;
   import map.campaign.mediator.mapview.MazeMapMediator;
   import map.campaign.mediator.mapview.NodeGuideMediator;
   import map.campaign.mediator.mapview.RaceAgainstTimeMapMediator;
   import map.campaign.mediator.mapview.SkyStepMediator;
   import map.campaign.mediator.mapview.TeamListMediator;
   import map.campaign.mediator.mapview.ThessBoxMediator;
   import map.campaign.mediator.mapview.TrailMapMediator;
   import map.campaign.mediator.mapview.WorldBossBuffMediator;
   import map.campaign.mediator.mapview.WorldBossHeadInfoMediator;
   import map.campaign.mediator.mapview.WorldBossRiverMediator;
   import map.campaign.mediator.mapview.WorldBossWoundMediator;
   import map.campaign.mediator.market.MarketMediator;
   import map.campaign.mediator.marry.MarryUIMediator;
   import map.campaign.mediator.maze.MazeRiverMediator;
   import map.campaign.mediator.mineral.MineralUIMediator;
   import map.campaign.mediator.monopoly.MonopolyUIMediator;
   import map.campaign.mediator.petland.PetBossUIMediator;
   import map.campaign.mediator.petland.PetLandUIMediator;
   import map.campaign.mediator.pvp.PvpUIMediator;
   import map.campaign.mediator.pvp.PvpWarFightMediator;
   import map.campaign.mediator.rapidThrough.RapidThroughUIMediater;
   import map.campaign.mediator.sacrifice.SacrificeRoomUIMediator;
   import map.campaign.mediator.sumcampaign.SumCampaignUIMediator;
   import map.campaign.mediator.svs.SvsUIMediator;
   import map.campaign.mediator.unrealshooting.UnrealShootingRiverMediator;
   import map.campaign.mediator.unrealshooting.UnrealShootingSelectTargetMediator;
   import map.campaign.mediator.unrealshooting.UnrealShootingUIMediator;
   import map.campaign.view.fog.FogView;
   import map.campaign.view.house.FurnitureLayer;
   import map.campaign.view.layer.CampaignMainBuidingLayer;
   import map.campaign.view.layer.CampaignWalkLayer;
   import map.campaign.view.layer.NpcLayer;
   import map.internals.MapData;
   import map.internals.constant.MapGlobal;
   import map.internals.data.CampaignNode;
   import map.internals.data.template.MapTemplate;
   import map.internals.event.OuterCityEvent;
   import map.internals.library.MapElmsLibrary;
   import map.internals.mediator.layer.BuildingSelectMediator;
   import map.internals.mediator.mapview.LockTargetMediator;
   import map.internals.mediator.team.FreedomTeamFollowMediator;
   import map.internals.mediator.team.FreedomTeamListMediator;
   import map.internals.scenePathSearcher.PathMapHitTester;
   import map.internals.utils.PointUtils;
   import map.internals.utils.QTree;
   import map.internals.view.layer.MapRenderLayer;
   import map.internals.view.layer.OuterCityStaticLayer;
   import map.outercity.helper.mapview.MapViewHelper;
   import map.outercity.path.SceneScene;
   import yishi.datas.BattleModel;
   import yishi.datas.VersionSwitch;
   import yishi.events.SceneViewEvent;
   import yishi.manager.BaseManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   
   public class CampaignMapView extends Sprite
   {
      
      public static const NAME:String = "map.campaign.view.CampaignMapView";
      
      public var isLockMove:Boolean = false;
      
      protected var _bgLayer:BgLayer;
      
      protected var _staticRenderLayer:MapRenderLayer;
      
      protected var _staticLayer:OuterCityStaticLayer;
      
      protected var _footLayer:Sprite;
      
      protected var _furnitureLayer:FurnitureLayer;
      
      protected var _walkLayer:CampaignWalkLayer;
      
      protected var _mainBuidingLayer:CampaignMainBuidingLayer;
      
      protected var _fogLayer:FogView;
      
      protected var _mapModel:CampaignMapModel;
      
      protected var _npcLayer:NpcLayer;
      
      protected var _farmLayer:Sprite;
      
      protected var _skillLayer:Sprite;
      
      protected var _effectLayer:Sprite;
      
      protected var _topUILayer:Sprite;
      
      protected var _sceneScene:SceneScene;
      
      protected var _mediatorKey:String;
      
      private var _lookAtTimeId:int;
      
      private var _prePoint:Point = new Point();
      
      public var farmLandLayer:FarmLandLayer;
      
      public function CampaignMapView()
      {
         super();
         CampaignManager.instance.mapView = this;
         _mapModel = CampaignManager.instance.mapModel;
         MapGlobal.qtree = new QTree(0,0,_mapModel.mapTempInfo.Width,_mapModel.mapTempInfo.Height);
         init();
         addEvent();
         setStartPoint();
         if(WorldBossHelper.checkPetLand(_mapModel.mapId))
         {
            SoundManager.instance.playMusic("petland",0);
         }
         else
         {
            SoundManager.instance.dynamicPlayMusic(_mapModel.mapTempInfo.MusicPath);
         }
      }
      
      protected function registerList() : void
      {
         var _loc1_:Array = [CampaignMapCursorMediator,MapCameraMediator,CampaignMapMouseEventMediator,BuildingSelectMediator,CampaignSmallMapMediator];
         if(!WorldBossHelper.checkFogMap(_mapModel.mapId) && !WorldBossHelper.checkMaze(_mapModel.mapId))
         {
            _loc1_.push(TeamListMediator);
            _loc1_.push(NodeGuideMediator);
         }
         else if(_mapModel.campaignTemplate.Types == 0 && Boolean(_mapModel.campaignTemplate.isNaLan))
         {
            _loc1_.push(TeamListMediator);
         }
         else if(_mapModel.campaignTemplate.Types == 0 && Boolean(_mapModel.campaignTemplate.isTaila))
         {
            _loc1_.push(TeamListMediator);
            BattleModel.allowAutoFight = !VersionSwitch.allAutoFight;
         }
         else if(_mapModel.campaignTemplate.Types == 0 && Boolean(_mapModel.campaignTemplate.isWasteCampaign))
         {
            _loc1_.push(TeamListMediator);
            BattleModel.allowAutoFight = !VersionSwitch.allAutoFight;
         }
         else if(_mapModel.campaignTemplate.Types == 0 && Boolean(_mapModel.campaignTemplate.isTrailTower))
         {
            _loc1_.push(TeamListMediator);
            _loc1_.push(TrailMapMediator);
         }
         else if(_mapModel.campaignTemplate.Types == 0 && Boolean(_mapModel.campaignTemplate.isRaceAgainstTime))
         {
            _loc1_.push(TeamListMediator);
            _loc1_.push(RaceAgainstTimeMapMediator);
         }
         else if(_mapModel.campaignTemplate.Types == 0 && Boolean(_mapModel.campaignTemplate.isSpacetimeFault))
         {
            _loc1_.push(TeamListMediator);
         }
         else if(_mapModel.campaignTemplate.isChildWarCampaign)
         {
            _loc1_.push(TeamListMediator);
            _loc1_.push(ChildWarUIMediater);
         }
         else if(_mapModel.campaignTemplate.Types == 1)
         {
            _loc1_.push(WorldBossWoundMediator);
            _loc1_.push(WorldBossHeadInfoMediator);
            _loc1_.push(WorldBossRiverMediator);
            _loc1_.push(WorldBossBuffMediator);
            _loc1_.push(NodeGuideMediator);
         }
         else if(_mapModel.campaignTemplate.Types != 2)
         {
            if(_mapModel.campaignTemplate.Types == 4)
            {
               _loc1_.push(MazeMapMediator);
               _loc1_.push(MazeRiverMediator);
            }
            else if(_mapModel.campaignTemplate.Types == 7)
            {
               _loc1_.push(ConsortiaSecretMapMediator);
               _loc1_.push(GvgChaseNpcMediator);
            }
         }
         if(WorldBossHelper.checkPvp(_mapModel.mapId))
         {
            _loc1_.push(PvpUIMediator);
            _loc1_.push(PvpWarFightMediator);
            _loc1_.push(ActivationMovieMediator);
            BattleModel.allowAutoFight = !VersionSwitch.allAutoFight;
         }
         if(WorldBossHelper.checkMineral(_mapModel.mapId))
         {
            _loc1_.push(FreedomTeamListMediator);
            _loc1_.push(FreedomTeamFollowMediator);
            _loc1_.push(MineralUIMediator);
            _loc1_.push(LockTargetMediator);
            if(WorldBossHelper.checkMineralPVP(_mapModel.mapId))
            {
               _loc1_.push(PvpWarFightMediator);
            }
            _loc1_.push(ActivationMovieMediator);
            BattleModel.allowAutoFight = !VersionSwitch.allAutoFight;
         }
         if(WorldBossHelper.checkWedding(_mapModel.mapId))
         {
            _loc1_.push(FreedomTeamListMediator);
            _loc1_.push(FreedomTeamFollowMediator);
            _loc1_.push(MarryUIMediator);
            _loc1_.push(LockTargetMediator);
            _loc1_.push(ActivationMovieMediator);
            BattleModel.allowAutoFight = !VersionSwitch.allAutoFight;
         }
         if(WorldBossHelper.checkDuskArea(_mapModel.mapId) || Boolean(WorldBossHelper.checkIceFireTemple(_mapModel.mapId)))
         {
            _loc1_.push(DuskAreaUIMediator);
            _loc1_.push(PvpWarFightMediator);
            _loc1_.push(GvgChaseNpcMediator);
            _loc1_.push(ActivationMovieMediator);
            _loc1_.push(GvgRiverMediator);
         }
         if(WorldBossHelper.checkFlameTemple(_mapModel.mapId))
         {
            _loc1_.push(FlameTempleUIMediator);
            _loc1_.push(PvpWarFightMediator);
            _loc1_.push(ActivationMovieMediator);
            _loc1_.push(GvgRiverMediator);
            BattleModel.allowAutoFight = !VersionSwitch.allAutoFight;
         }
         if(WorldBossHelper.checkSumCampaign(_mapModel.mapId))
         {
            _loc1_.push(SumCampaignUIMediator);
            _loc1_.push(FreedomTeamListMediator);
            _loc1_.push(FreedomTeamFollowMediator);
            _loc1_.push(LockTargetMediator);
            _loc1_.push(ActivationMovieMediator);
         }
         if(WorldBossHelper.checkPetLand(_mapModel.mapId))
         {
            _loc1_.push(FreedomTeamListMediator);
            _loc1_.push(FreedomTeamFollowMediator);
            _loc1_.push(LockTargetMediator);
            _loc1_.push(PvpWarFightMediator);
            _loc1_.push(ActivationMovieMediator);
            _loc1_.push(ChaseNPCMediator);
            _loc1_.push(PetLandUIMediator);
         }
         if(WorldBossHelper.checkSvs(_mapModel.mapId))
         {
            _loc1_.push(FreedomTeamListMediator);
            _loc1_.push(FreedomTeamFollowMediator);
            _loc1_.push(SvsUIMediator);
            _loc1_.push(PvpWarFightMediator);
            _loc1_.push(ActivationMovieMediator);
            BattleModel.allowAutoFight = !VersionSwitch.allAutoFight;
         }
         if(WorldBossHelper.checkIsNoviceMap(_mapModel.mapId) || Boolean(WorldBossHelper.checkIsNoviceSingleCamp(_mapModel.mapId)))
         {
            _loc1_.push(NodeGuideMediator);
            NotificationManager.instance.sendNotification("NOVICE_ARROW_STATE",{
               "type":1,
               "tip":null
            });
         }
         if(WorldBossHelper.checkInPetBossFloor(_mapModel.mapId))
         {
            _loc1_.push(WorldBossRiverMediator);
            _loc1_.push(PetBossUIMediator);
            BattleModel.allowAutoFight = !VersionSwitch.allAutoFight;
         }
         if(_mapModel.campaignTemplate.Types == 17 || Boolean(WorldBossHelper.checkInQuizActivity(_mapModel.mapId)))
         {
            _loc1_.push(QuizActivityMediator);
         }
         if(WorldBossHelper.checkMolong(_mapModel.mapId))
         {
            _loc1_.push(FreedomTeamListMediator);
         }
         if(WorldBossHelper.checkMonopoly(_mapModel.mapId))
         {
            _loc1_ = [MonopolyUIMediator,MapCameraMediator,CampaignSmallMapMediator];
         }
         if(WorldBossHelper.checkConsortiaEmeDream(_mapModel.mapId))
         {
            _loc1_.push(WorldBossHeadInfoMediator);
            _loc1_.push(EmeDreamUIMediator);
            _loc1_.push(EmeDreamRiverMediator);
         }
         if(WorldBossHelper.checkBloody(_mapModel.mapId))
         {
            _loc1_.push(CampaignCountDownMediator);
            BattleModel.allowAutoFight = !VersionSwitch.allAutoFight;
         }
         if(WorldBossHelper.checkMarket(_mapModel.mapId))
         {
            _loc1_.push(MarketMediator);
         }
         if(WorldBossHelper.checkActiveVehicle(_mapModel.mapId))
         {
            _loc1_.push(ActiveVehicleUIMediator);
            _loc1_.push(ActiveVehicleSelectTargetMediator);
            _loc1_.push(ActiveVehicleRiverMediator);
         }
         if(WorldBossHelper.checkFarm(_mapModel.mapId))
         {
            _loc1_.push(FarmMediator);
         }
         if(WorldBossHelper.checkInHouse(_mapModel.mapId))
         {
            _loc1_.push(HouseUIMediator);
            _loc1_.push(HouseMoveMediator);
         }
         if(WorldBossHelper.checkSacrificeRoom(_mapModel.mapId))
         {
            _loc1_.push(SacrificeRoomUIMediator);
         }
         if(WorldBossHelper.checkGroupfb(_mapModel.mapId))
         {
            _loc1_.push(FreedomTeamListMediator);
         }
         if(WorldBossHelper.checkUnrealShooting(_mapModel.mapId))
         {
            _loc1_.push(UnrealShootingUIMediator);
            _loc1_.push(UnrealShootingSelectTargetMediator);
            _loc1_.push(UnrealShootingRiverMediator);
            _loc1_.push(ActivationMovieMediator);
         }
         if(WorldBossHelper.checkRapidMap(_mapModel.mapId))
         {
            _loc1_.push(RapidThroughUIMediater);
         }
         if(WorldBossHelper.checkGodsEvening(_mapModel.mapId))
         {
            _loc1_.push(PvpWarFightMediator);
            _loc1_.push(GodsEveningUIMediator);
            _loc1_.push(GvgRiverMediator);
         }
         if(_mapModel.campaignTemplate.isDeepPrison)
         {
            _loc1_.push(DeepPrisonUIMediater);
         }
         if(WorldBossHelper.checkAirGarden(_mapModel.mapId))
         {
            _loc1_.push(AirGardenUIMediator);
         }
         if(_mapModel.campaignTemplate.isSkyStepCampaign)
         {
            _loc1_.push(TeamListMediator);
            _loc1_.push(SkyStepMediator);
         }
         if(WorldBossHelper.checkThessBox(_mapModel.mapId))
         {
            _loc1_.push(ThessBoxMediator);
         }
         if(WorldBossHelper.checkForbiddenBoss(_mapModel.mapId))
         {
            _loc1_.push(ForbiddenBossMediator);
            _loc1_.push(NodeGuideMediator);
         }
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.campaign.view.CampaignMapView");
      }
      
      private function __petBossSwitchHandler(param1:String, param2:Object) : void
      {
         if(_mapModel == null || BaseManager.petBossMapId == CampaignManager.instance.petBossModel.mapId)
         {
            return;
         }
         if(WorldBossHelper.checkInPetBossFloor(_mapModel.mapId))
         {
            MediatorMananger.instance.addRegisterMediator(WorldBossRiverMediator,this,_mediatorKey);
            MediatorMananger.instance.addRegisterMediator(PetBossUIMediator,this,_mediatorKey);
         }
         else if(WorldBossHelper.checkPetLand(_mapModel.mapId))
         {
            MediatorMananger.instance.removeRegisterMediator(WorldBossRiverMediator,this,_mediatorKey);
            MediatorMananger.instance.removeRegisterMediator(PetBossUIMediator,this,_mediatorKey);
         }
      }
      
      protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:BitmapData = null;
         var _loc3_:Number = NaN;
         _sceneScene = new SceneScene(1000);
         var _loc7_:PathMapHitTester = new PathMapHitTester(null);
         _sceneScene.setHitTester(_loc7_);
         _loc7_.titles = _mapModel.mapTielsData;
         _mapModel.mapId = campaignTempInfo.Id;
         var _loc1_:Array = [2271,2281,2341,2291,2292,2293,2294,2411,4301,4302,4303,10001,10002,10003,10004,10005,20001,20002,20003,20004,20005,30000,30001,4201,4101,4401,4601,5101,5201,5301,7701,5401,5501,5502,5503,5504,5505,5601,5602,5603,5604,5605,5701,5801,9995,9996,9997,9998,9999,4701,2351,2352,2353,2361,2371,2381,3002,7601,7602,5904,5905,4801,6001,6002,6003,6004,6005,6006,6007,6008,6009,5911,5912,5913,5914,5915,5921,5922,5923,5924,5925,5931,5932,7000,5933,5934,5935,5703,8501,4202,6011,6021,6031,2391,2392,2393,2354,2355,2356,2362,2372,2401,4901,6501];
         if(WorldBossHelper.checkMaze(_mapModel.mapId) || Boolean(WorldBossHelper.checkMaze2(_mapModel.mapId)) || Boolean(WorldBossHelper.checkMaze3(_mapModel.mapId)) || _loc1_.indexOf(_mapModel.mapId) != -1 || Boolean(WorldBossHelper.checkForbiddenBoss(_mapModel.mapId)) || Boolean(WorldBossHelper.checkThessBox(_mapModel.mapId)))
         {
            if(!_mapModel.bgLayer)
            {
               _mapModel.bgLayer = new BgLayer(this,_mapModel.mapTempInfo,_mapModel.floorData);
            }
            _bgLayer = _mapModel.bgLayer as BgLayer;
            _bgLayer.setParent(this);
         }
         else
         {
            _loc2_ = int(_mapModel.mapTempInfo.Width);
            _loc4_ = int(_mapModel.mapTempInfo.Height);
            _loc2_ = int(_loc2_ <= 0 ? 2000 : _loc2_);
            _loc4_ = int(_loc4_ <= 0 ? 2000 : _loc4_);
            _loc8_ = _loc2_ * _loc4_;
            _loc6_ = 16777215;
            if(_loc2_ > 5000 || _loc4_ > 5000 || _loc8_ >= _loc6_)
            {
               _staticLayer = new OuterCityStaticLayer();
               _staticLayer.mapData = _mapModel;
               addChild(_staticLayer);
            }
            else
            {
               if(_mapModel.mapTempInfo.Id != MapData.mapId || !MapData.mapBitmap)
               {
                  _loc5_ = new BitmapData(_loc2_,_loc4_,true,16711680);
               }
               _staticRenderLayer = new MapRenderLayer(this,_loc5_,"auto",true);
               _staticRenderLayer.elmsDatas = MapElmsLibrary.instance;
               _staticRenderLayer.data = _mapModel.floorData;
               _loc5_ = null;
            }
         }
         _topUILayer = new Sprite();
         _topUILayer.mouseEnabled = false;
         _skillLayer = new Sprite();
         _skillLayer.mouseChildren = _skillLayer.mouseEnabled = false;
         _effectLayer = new Sprite();
         _effectLayer.mouseChildren = _effectLayer.mouseEnabled = false;
         _footLayer = new Sprite();
         addChild(_footLayer);
         _farmLayer = new Sprite();
         addChild(_farmLayer);
         _mainBuidingLayer = new CampaignMainBuidingLayer();
         addChild(_mainBuidingLayer);
         _walkLayer = new CampaignWalkLayer();
         addChild(_walkLayer);
         _npcLayer = new NpcLayer(_walkLayer);
         addChild(_skillLayer);
         addChild(_effectLayer);
         addChild(_topUILayer);
         if(!WorldBossHelper.checkFogMap(_mapModel.mapId))
         {
            _fogLayer = new FogView(campaignTempInfo.Width,campaignTempInfo.Height);
            addChild(_fogLayer);
         }
         TempleteManager.instance.mapTemplateCate.checkEnterCampaign(campaignTempInfo.Id);
         if(WorldBossHelper.checkConsortiaEmeDream(_mapModel.mapId))
         {
            _loc3_ = Number(ConsortiaManager.instance.model.emeDreamInfo.totalHp);
            CampaignManager.instance.worldBossModel.totalHp = _loc3_;
         }
         if(_bgLayer != null)
         {
            _bgLayer.dragingCallBack();
         }
      }
      
      protected function setStartPoint() : void
      {
         var _loc2_:CampaignNode = null;
         var _loc4_:Object = null;
         var _loc5_:CampaignArmy = _mapModel.selfMemberData;
         var _loc3_:Point = new Point(0,0);
         if(_loc5_)
         {
            _loc3_ = PointUtils.scaleTransformII(new Point(_loc5_.curPosX,_loc5_.curPosY),20,20);
         }
         var _loc1_:Rectangle = new Rectangle(0,0,_mapModel.mapTempInfo.Width,_mapModel.mapTempInfo.Height);
         if(!_loc1_.containsPoint(_loc3_))
         {
            _loc2_ = _mapModel.mapNodeStartPoint;
            if(_loc2_)
            {
               _loc5_.curPosX = _loc2_.curPosX;
               _loc5_.curPosY = _loc2_.curPosY;
               _loc3_ = PointUtils.scaleTransformII(new Point(_loc5_.curPosX,_loc5_.curPosY),20,20);
               _loc4_ = CampaignManager.instance.controller.getArmyView(_loc5_);
               if(_loc4_)
               {
                  _loc4_.x = _loc5_.curPosX * 20;
                  _loc4_.y = _loc5_.curPosY * 20;
               }
            }
         }
         _mapModel.targetPoint = CampaignMapCenterCheckHelper.checkOutScene(_loc3_);
      }
      
      public function moveCenterPoint(param1:Point, param2:Number = 0.6, param3:Boolean = true) : void
      {
         MouseData.instance.curState = "ON_DRAG";
         param1.x = -param1.x;
         param1.y = -param1.y;
         param1.x += this.stage.stageWidth / 2;
         param1.y += this.stage.stageHeight / 2;
         param1 = CampaignMapCenterCheckHelper.checkOutScene(param1);
         _mapModel.targetPoint = param1;
         TweenLite.killTweensOf(this,false);
         var _loc4_:Point = new Point(this.x,this.y);
         if(Point.distance(param1,_loc4_) < 20)
         {
            return;
         }
         if(param3)
         {
            TweenLite.to(this,param2,{
               "x":param1.x,
               "y":param1.y,
               "onUpdate":moveEndCheck
            });
         }
         else
         {
            setPosition(param1.x,param1.y);
         }
      }
      
      protected function addEvent() : void
      {
         addEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         _mapModel.addEventListener("addGarrison",__addUserArmyHandler);
         MsgMan.addObserver("CampaignEvent.PET_BOSS_SWITCH",this,__petBossSwitchHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         if(_mapModel)
         {
            _mapModel.removeEventListener("addGarrison",__addUserArmyHandler);
         }
         MsgMan.removeObserver("CampaignEvent.PET_BOSS_SWITCH",this,__petBossSwitchHandler);
      }
      
      private function __addUserArmyHandler(param1:OuterCityEvent) : void
      {
         var _loc3_:CampaignArmy = param1.data as CampaignArmy;
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         if(_loc3_.userId == _loc2_)
         {
            setStartPoint();
            lookAtTarget(true);
         }
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         if(_staticLayer)
         {
            _staticLayer.resize();
         }
         layou();
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _walkLayer.addToStage(param1);
         registerList();
         lookAtTarget();
         NotificationManager.instance.dispatchEvent(new SceneViewEvent("addToStage","CAMPAIGN_MAP_SCENE"));
      }
      
      protected function lookAtTarget(param1:Boolean = false) : void
      {
         if(_lookAtTimeId > 0)
         {
            clearInterval(_lookAtTimeId);
         }
         _lookAtTimeId = 0;
         if(isLockMove || _mapModel == null)
         {
            return;
         }
         if(!_mapModel.selfMemberData)
         {
            _lookAtTimeId = setInterval(lookAtTarget,1000);
            return;
         }
         var _loc2_:Object = CampaignManager.instance.controller.getArmyView(_mapModel.selfMemberData);
         if(!_loc2_)
         {
            return;
         }
         if(param1)
         {
            moveCenterPoint(new Point(_loc2_.x,_loc2_.y),0.1,false);
         }
         this.dispatchEvent(new CampaignMapEvent("LOOK_AT_ROLE",_loc2_));
      }
      
      private function layou() : void
      {
         lookAtTarget();
      }
      
      private function moveEndCheck() : void
      {
         var _loc1_:Point = new Point(this.x,this.y);
         _loc1_ = CampaignMapCenterCheckHelper.checkOutScene(_loc1_);
         setPosition(_loc1_.x,_loc1_.y);
      }
      
      override public function set x(param1:Number) : void
      {
         if(super.x == param1)
         {
            return;
         }
         super.x = param1;
         SmallMapBar.instance.iconContainerX = param1 / 16;
         if(_fogLayer)
         {
            _fogLayer.updateContainerPosX();
         }
      }
      
      override public function set y(param1:Number) : void
      {
         if(super.y == param1)
         {
            return;
         }
         super.y = param1;
         SmallMapBar.instance.iconContainerY = param1 / 16;
         if(_fogLayer)
         {
            _fogLayer.updateContainerPosY();
         }
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
         if(Math.abs(_prePoint.x - x >> 0) > 100 || Math.abs(_prePoint.y - y >> 0) > 100)
         {
            moveOver(this.x,this.y);
         }
      }
      
      public function updateOff(param1:Number, param2:Number) : void
      {
         if(Math.abs(param2 - param1 >> 0) > 100)
         {
            moveOver(x,y);
         }
      }
      
      private function moveOver(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = null;
         _prePoint.x = param1;
         _prePoint.y = param2;
         if(_staticLayer && stage)
         {
            _loc3_ = MapViewHelper.getCurrentMapRect(this);
            CampaignManager.instance.controller.moveMapCallBack(_loc3_);
            _staticLayer.backgroundXandY(-this.x,-this.y);
            _staticLayer.upDateNextRend();
         }
         this.dispatchEvent(new CampaignMapEvent("MOVE_SCENET_END",this));
      }
      
      public function get walkLayer() : CampaignWalkLayer
      {
         return _walkLayer;
      }
      
      public function get mainBuidingLayer() : CampaignMainBuidingLayer
      {
         return _mainBuidingLayer;
      }
      
      public function get fogLayer() : FogView
      {
         return _fogLayer;
      }
      
      public function get campaignTempInfo() : MapTemplate
      {
         if(_mapModel)
         {
            return _mapModel.mapTempInfo;
         }
         return null;
      }
      
      public function get npcLayer() : NpcLayer
      {
         return _npcLayer;
      }
      
      public function get farmLayer() : Sprite
      {
         return _farmLayer;
      }
      
      public function getNpcNodeById(param1:int) : DisplayObject
      {
         if(_mapModel.getNodeById(param1))
         {
            return _mapModel.getNodeById(param1);
         }
         return _mapModel.getNodeByNodeId(param1);
      }
      
      public function get sceneScene() : SceneScene
      {
         return _sceneScene;
      }
      
      public function get footLayer() : Sprite
      {
         return _footLayer;
      }
      
      public function get furnitureLayer() : FurnitureLayer
      {
         return _furnitureLayer;
      }
      
      public function setFurniture() : void
      {
         if(_furnitureLayer == null)
         {
            _furnitureLayer = new FurnitureLayer();
         }
         _footLayer.addChild(_furnitureLayer);
      }
      
      public function get staticRenderLayer() : MapRenderLayer
      {
         return _staticRenderLayer;
      }
      
      public function get topUILayer() : Sprite
      {
         return _topUILayer;
      }
      
      public function get skillLayer() : Sprite
      {
         return _skillLayer;
      }
      
      public function get effectLayer() : Sprite
      {
         return _effectLayer;
      }
      
      public function getLandItem(param1:int) : FarmLandItem
      {
         if(farmLandLayer)
         {
            return farmLandLayer.getLandItem(param1);
         }
         return null;
      }
      
      public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         if(_bgLayer)
         {
            _bgLayer.removeParent();
         }
         _bgLayer = null;
         if(_fogLayer)
         {
            _fogLayer.dispose();
         }
         _fogLayer = null;
         if(_npcLayer)
         {
            _npcLayer.dispose();
         }
         _npcLayer = null;
         removeEvent();
         if(_mainBuidingLayer)
         {
            _mainBuidingLayer.dispose();
         }
         _mainBuidingLayer = null;
         if(_walkLayer)
         {
            _walkLayer.dispose();
         }
         _walkLayer = null;
         _mapModel = null;
         if(_staticRenderLayer)
         {
            _staticRenderLayer.dispose();
         }
         _staticRenderLayer = null;
         _sceneScene = null;
         if(_staticLayer)
         {
            _staticLayer.dispose();
         }
         _staticLayer = null;
         ObjectUtils.disposeAllChildren(_topUILayer);
         ObjectUtils.disposeObject(_topUILayer);
         _topUILayer = null;
         ObjectUtils.disposeAllChildren(_skillLayer);
         ObjectUtils.disposeObject(_skillLayer);
         _skillLayer = null;
         ObjectUtils.disposeAllChildren(_effectLayer);
         ObjectUtils.disposeObject(_effectLayer);
         _effectLayer = null;
         ObjectUtils.disposeAllChildren(_farmLayer);
         ObjectUtils.disposeObject(_farmLayer);
         _farmLayer = null;
         if(MapGlobal.qtree)
         {
            MapGlobal.qtree.dispose();
         }
         MapGlobal.qtree = null;
      }
   }
}

