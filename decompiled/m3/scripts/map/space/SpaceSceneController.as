package map.space
{
   import bag.helper.BagHelper;
   import battle.view.battleresult.SinglePassVicotyResultView;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.loader.DomainResourceLoad;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.battle.BattleReportMsg;
   import farm.FarmManager;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.SmallMapBar;
   import mainBar.TipsBar;
   import manager.LanguageMgr;
   import managers.ChallengeManager;
   import managers.ChildPatrolManager;
   import managers.DreamArenaManager;
   import managers.MarryManager;
   import managers.MinosManager;
   import managers.MopupManager;
   import managers.RedemptionRoadManager;
   import managers.SpiritExpeditionManager;
   import managers.StoreSocketOutManager;
   import managers.TaskTraceTipManager;
   import map.campaign.data.MouseData;
   import map.campaign.preload.PreCampaignData;
   import map.campaign.preload.SpacePreCampaignData;
   import map.campaign.view.FootprintItems;
   import map.internals.data.SpaceNode;
   import map.internals.findPath.AcorrsLineGrid;
   import map.internals.findPath.FindPath8;
   import map.internals.library.MapElmsLibrary;
   import map.internals.utils.Utils;
   import map.internals.utils.WalkRectScanUtils;
   import map.outercity.manager.OuterCitySocketOutManager;
   import map.space.data.SpaceArmy;
   import map.space.data.SpaceNodeType;
   import map.space.event.SpaceEvent;
   import map.space.helper.hero.SpaceArmyViewHelper;
   import map.space.helper.mapview.SpaceMapViewHelper;
   import map.space.manager.SpaceSocketManager;
   import map.space.view.SpaceSceneMapView;
   import mvc.module.armyII.BaseArmy;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.DemonLandManager;
   import yishi.manager.FinalRoadManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RemainsExploreManager;
   import yishi.manager.RevengeRoadManager;
   import yishi.manager.ShadowLandManager;
   import yishi.manager.WarSoulTowerManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   import yishi.service.managers.OuterCityServiceManager;
   import yishi.view.community.LoadingSceneView;
   import yishi.view.tips.MessageTipManager;
   
   public class SpaceSceneController extends BaseSceneView
   {
      
      private static var _isFirst:Boolean = true;
      
      private var _model:SpaceModel;
      
      private var _view:SpaceSceneMapView;
      
      private var _preLoad:PreCampaignData;
      
      private var _showLoadingTimeId:int;
      
      private var _preLoadingOver:Boolean;
      
      private var _preSceneData:Object;
      
      private var _findPath:FindPath8;
      
      private var _flyFindPath:FindPath8;
      
      private var _currentFindPath:FindPath8;
      
      private var _algUtils:AcorrsLineGrid;
      
      private var _rectScanUtils:WalkRectScanUtils;
      
      public var armyViews:Dictionary;
      
      private var _time:Number;
      
      private var _mouseLock:int;
      
      private var _armyList:Array;
      
      private var _npcList:Array;
      
      private var _buildList:Array;
      
      public var walkTarget:Object;
      
      public var buildLayer:Object;
      
      public var walkLayer:Object;
      
      public function SpaceSceneController()
      {
         super();
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         PlayerManager.instance.currentPlayerModel.inCastle = false;
         SpaceSocketManager.instance.setup(true);
         FootprintItems.setup();
         SpaceManager.instance.controller = this;
         _model = SpaceManager.instance.model;
         if(!_model)
         {
            SceneManager.instance.lock = false;
            LoadingSceneView.instance.show();
            return;
         }
         MapElmsLibrary.instance.lock();
         if(_model && _model.mapTielsData)
         {
            preLoadingOver();
         }
         else
         {
            _preLoadingOver = false;
            if(_isFirst)
            {
               _isFirst = false;
               showLoading();
            }
            else
            {
               _showLoadingTimeId = setInterval(showLoading,1500);
            }
            _time = getTimer();
            _preLoad = new SpacePreCampaignData(_model);
            _preLoad.syncBackCall(preLoadingOver);
         }
      }
      
      private function showLoading() : void
      {
         if(_showLoadingTimeId > 0)
         {
            clearInterval(_showLoadingTimeId);
            _showLoadingTimeId = 0;
         }
         if(!_preLoadingOver)
         {
            LoadingSceneView.instance.show();
         }
      }
      
      override protected function preLoadingOver() : void
      {
         _preLoadingOver = true;
         super.preLoadingOver();
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         LayerManager.Instance.clearnGameDynamic();
         armyViews = new Dictionary();
         _armyList = [];
         _buildList = [];
         _npcList = [];
         var _loc3_:int = _model.mapTempInfo.Width / 20;
         var _loc4_:int = _model.mapTempInfo.Height / 20;
         _findPath = new FindPath8(_loc3_,_loc4_,_model.mapTielsData);
         _flyFindPath = new FindPath8(_loc3_,_loc4_,_model.mapTielsData,false,true);
         _currentFindPath = _findPath;
         _algUtils = new AcorrsLineGrid(_currentFindPath,_model);
         _preSceneData = param2;
         _view = new SpaceSceneMapView(this,_model);
         addChild(_view);
         SpaceManager.instance.mapView = _view;
         _rectScanUtils = new WalkRectScanUtils();
         _model.buildMapNodesData();
         SmallMapBar.instance.switchSmallMapState(1);
         OuterCityServiceManager.getInstance().setup(thane.userId,userKey,_model.mapId);
         SoundManager.instance.playMusic("space",0);
         addEvent();
      }
      
      override public function enterOver() : void
      {
         var timeId:int;
         var view:SinglePassVicotyResultView;
         var bossReward:String;
         var mapId:int;
         var tempAreaId:int;
         var tempDiff:int;
         var state:int;
         var consortiaId:int;
         var consortiaId2:int;
         var rect:Rectangle;
         if(!MarryManager.instance.model.lockScreen)
         {
            ChatBar.instance.show();
         }
         TopToolsBar.instance.show();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         FullBar.instance.show();
         QueueBar.instance.show();
         TaskTraceBar.instance.show();
         SmallMapBar.instance.show();
         ResourcesBar.instance.show();
         ChatTopBugleView.instance.setPos();
         ChallengeManager.instance.showPVPFrame();
         if(_preSceneData)
         {
            if(_preSceneData.isOpenColosseum)
            {
               ChallengeManager.instance.enterScene = SceneManager.instance.currentType;
               SceneManager.instance.setScene("CHANLLENGE_ROOM_SCENE");
            }
            else if(_preSceneData.isOpenPveRoomList)
            {
               FrameControllerManager.instance.openControllerByInfo("pveroomlist");
            }
            else if(_preSceneData.isOpenPvpRoomList)
            {
               FrameControllerManager.instance.openControllerByInfo("pvproomlist");
            }
            else if(_preSceneData.isOpenVehicle)
            {
               FrameControllerManager.instance.openControllerByInfo("vehicledaimon");
            }
            else if(_preSceneData.isOpenPetChallenge)
            {
               FrameControllerManager.instance.openControllerByInfo("petchallenge",2);
            }
            else if(_preSceneData.isOpenRemotePet)
            {
               FrameControllerManager.instance.remotePetController.startFrameByType(2);
            }
            else if(_preSceneData.isOpenChildPve)
            {
               FrameControllerManager.instance.openControllerByInfo("childpve");
            }
            else if(_preSceneData.isOpenChildArena)
            {
               SwitchPageHelp.gotoChildArenaFrame();
            }
            else if(_preSceneData.isOpenSinglePass)
            {
               FrameControllerManager.instance.openControllerByInfo("singlepass");
            }
            else if(_preSceneData.isOpenPerkinLab)
            {
               FrameControllerManager.instance.openControllerByInfo("perkinlab",1);
            }
            else if(_preSceneData.isOutyardBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("outyard",3);
               timeId = int(setTimeout(function():void
               {
                  clearTimeout(timeId);
                  FrameControllerManager.instance.openControllerByInfo("outyard");
               },1000));
            }
            else if(_preSceneData.isOutyardExploreBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("outyard",3);
            }
            else if(_preSceneData.isCrossBraveBattle && BraveLegManager.instance.model.teamInfo)
            {
               FrameControllerManager.instance.openControllerByInfo("braveleg",{
                  "tab":1,
                  "refresh":true
               },BraveLegManager.instance.model.teamInfo);
            }
            else if(_preSceneData.hasOwnProperty("isOpenSinglePassResultView") && _preSceneData.isOpenSinglePassResultView)
            {
               view = new SinglePassVicotyResultView();
               view.msg = _preSceneData.data as BattleReportMsg;
               view.show();
            }
            else if(_preSceneData.isGloryRoadBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("gloryroad");
            }
            else if(_preSceneData.isAbysmBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("abysm",7);
            }
            else if(_preSceneData.isLordTrial)
            {
               FrameControllerManager.instance.openControllerByInfo("lordtrial",0);
            }
            else if(_preSceneData.isDragonTalker)
            {
               FrameControllerManager.instance.openControllerByInfo("timevortex",0);
            }
            else if(_preSceneData.isOpenTimeVortex)
            {
               FrameControllerManager.instance.openControllerByInfo("timevortex",1);
            }
            else if(_preSceneData.isTitanTempleBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("outyard",9);
            }
            else if(_preSceneData.isShuttleBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("outyard",10);
            }
            else if(_preSceneData.isOpenEclipticPalace)
            {
               FrameControllerManager.instance.openControllerByInfo("eclipticpalace","MAIN_FRAME");
            }
            else if(_preSceneData.isOpenDemonLand)
            {
               DemonLandManager.instance.battleOverHandlerView();
            }
            else if(_preSceneData.isOpenStararea)
            {
               FrameControllerManager.instance.openControllerByInfo("sevenyear",1);
            }
            else if(_preSceneData.isOpenGameHall)
            {
               SceneManager.instance.setScene("GAME_HALL_SCENE");
            }
            else if(_preSceneData.isMonsterExplore)
            {
               FrameControllerManager.instance.openControllerByInfo("monsterexplore");
               bossReward = MonsterExploreManager.instance.model.bossWinReward;
               if(bossReward != null)
               {
                  timeId = int(setTimeout(function():void
                  {
                     clearTimeout(timeId);
                     FrameControllerManager.instance.openControllerByInfo("monsterexplore","WIN_REWARD_FRAME");
                  },1000));
               }
            }
            else if(_preSceneData.isOpenDreamArena)
            {
               if(DreamArenaManager.instance.model.reportData != null)
               {
                  timeId = int(setTimeout(function():void
                  {
                     clearTimeout(timeId);
                     FrameControllerManager.instance.openControllerByInfo("dreamarena","REPORT_FRAME");
                  },1000));
               }
               else
               {
                  FrameControllerManager.instance.openControllerByInfo("dreamarena");
               }
            }
            else if(_preSceneData.isOpenRevengeRoad)
            {
               RevengeRoadManager.Ins.battleOverHandlerView();
            }
            else if(_preSceneData.isOpenRedemptionRoad)
            {
               if(RedemptionRoadManager.instance.model.isClearance || Boolean(RedemptionRoadManager.instance.model.isCding))
               {
                  FrameControllerManager.instance.openControllerByInfo("redemptionroad");
               }
               else
               {
                  FrameControllerManager.instance.openControllerByInfo("redemptionroad","CHAPTER_FRAME");
               }
            }
            else if(_preSceneData.isHellAbysmBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("abysm",11);
            }
            else if(_preSceneData.isExpeditionBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("spiritexpedition");
               mapId = int(SpiritExpeditionManager.instance.model.tempMapId);
               timeId = int(setTimeout(function():void
               {
                  clearTimeout(timeId);
                  FrameControllerManager.instance.openControllerByInfo("spiritexpedition",2,mapId);
               },1000));
            }
            else if(_preSceneData.isYLExpidtionBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("ylexpedition");
            }
            else if(_preSceneData.isSecretAdventure)
            {
               FrameControllerManager.instance.openControllerByInfo("secretadventure");
            }
            else if(_preSceneData.isShadowLandBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("shadowland");
               tempAreaId = int(ShadowLandManager.instance.model.tempAreaId);
               tempDiff = int(ShadowLandManager.instance.model.tempDiff);
               timeId = int(setTimeout(function():void
               {
                  clearTimeout(timeId);
                  FrameControllerManager.instance.openControllerByInfo("shadowland",2,[tempAreaId,tempDiff]);
               },1000));
            }
            else if(_preSceneData.isRemainsExploreBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("remainsexplore");
               if(RemainsExploreManager.instance.model.tempAreaId > 0)
               {
                  timeId = int(setTimeout(function():void
                  {
                     clearTimeout(timeId);
                     FrameControllerManager.instance.openControllerByInfo("remainsexplore",2);
                  },1000));
               }
            }
            else if(_preSceneData.isConsortiaNewBossBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("consortianewboss",1);
            }
            else if(_preSceneData.isRoyaltyBossBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("royaltyboss");
            }
            else if(_preSceneData.isWarSoulTowerBattle)
            {
               if(WarSoulTowerManager.instance.model.overLevel > 0)
               {
                  FrameControllerManager.instance.openControllerByInfo("warsoultower",1);
               }
            }
            else if(_preSceneData.isFinalRoadBattle)
            {
               if(!FinalRoadManager.instance.model.isOpen)
               {
                  return;
               }
               state = int(FinalRoadManager.instance.model.groupInfo.state);
               if(state == 2)
               {
                  FrameControllerManager.instance.openControllerByInfo("finalroad");
               }
               else
               {
                  FrameControllerManager.instance.openControllerByInfo("finalroad",1);
               }
            }
            else if(_preSceneData.isSecretwarResult)
            {
               FrameControllerManager.instance.openControllerByInfo("secretwar",2);
            }
            else if(_preSceneData.isMinosMap)
            {
               consortiaId = int(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID);
               if(consortiaId > 0)
               {
                  FrameControllerManager.instance.openControllerByInfo("minos","Map",MinosManager.ins.model.currBattleLv);
                  FrameControllerManager.instance.minousCrl.setPreFrame("minos");
               }
            }
            else if(_preSceneData.chesspvp)
            {
               consortiaId2 = int(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID);
               if(consortiaId2 > 0)
               {
                  FrameControllerManager.instance.openControllerByInfo("chesspvp",1);
               }
            }
            else if(_preSceneData.thesetower)
            {
               FrameControllerManager.instance.openControllerByInfo("thesstower","ThessTowerFrame");
            }
            else if(_preSceneData.thessbox)
            {
               FrameControllerManager.instance.openControllerByInfo("thessbox","ThessBoxMainFrame");
            }
            else if(_preSceneData.dungeonexplo)
            {
               FrameControllerManager.instance.openControllerByInfo("dungenexplo",1);
            }
            else if(_preSceneData.dungeonexplo)
            {
               FrameControllerManager.instance.openControllerByInfo("dungenexplo",1);
            }
            if(SpaceManager.instance.serchId > 0)
            {
               SwitchPageHelp.walkToCrossMapTarget("10000," + SpaceManager.instance.serchId);
               SpaceManager.instance.serchId = 0;
            }
         }
         FarmManager.instance.showGatherCropTip();
         ChildPatrolManager.instance.showChildPatrolTaskAlertTip();
         TaskTraceTipManager.instance.showBetterGoodsAlertTip();
         if(_view)
         {
            rect = SpaceMapViewHelper.getCurrentMapRect(_view);
            moveMapCallBack(rect);
         }
         __findNodeHandler(null);
         setTimeout(updateTopToolBar,2000);
         if(HeroRoadManager.instance.popTaskInfo && HeroRoadManager.instance.count == 0)
         {
            FrameControllerManager.instance.openControllerByInfo("heroroad",2,HeroRoadManager.instance.popTaskInfo);
            HeroRoadManager.instance.count++;
         }
      }
      
      private function updateTopToolBar() : void
      {
         TopToolsBar.instance.show();
      }
      
      override public function leaving() : void
      {
         removeEvent();
         PlayerManager.instance.currentPlayerModel.selectTarget = null;
         PlayerManager.instance.currentPlayerModel.isOnObstacle = _model.isOnObstacle;
         TopToolsBar.instance.hide();
         MainToolBar.instance.hide();
         TipsBar.instance.hide();
         FullBar.instance.hide();
         QueueBar.instance.hide();
         ChatBar.instance.hide();
         TaskTraceBar.instance.hide();
         SmallMapBar.instance.hide();
         ResourcesBar.instance.hide();
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         TaskTraceTipManager.instance.cleanByType(19);
         TaskTraceTipManager.instance.cleanByType(14);
         TaskTraceTipManager.instance.cleanByType(41);
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(_model)
         {
            _model.selectNode = null;
            MapElmsLibrary.instance.unLock();
            _model.nineSliceScaling = [];
         }
         _model = null;
         if(_rectScanUtils)
         {
            _rectScanUtils.getWalkable = null;
            _rectScanUtils.dispose();
            _rectScanUtils = null;
         }
         SpaceManager.instance.mapView = null;
         FootprintItems.dispose();
         _findPath.dispose();
         _currentFindPath.dispose();
         _flyFindPath.dispose();
         _findPath = null;
         _currentFindPath = null;
         _flyFindPath = null;
         ObjectUtils.disposeAllChildren(this);
         _preLoad = null;
         _algUtils = null;
         _preSceneData = null;
         armyViews = null;
         _armyList = null;
         _npcList = null;
         _buildList = null;
         walkTarget = null;
         buildLayer = null;
         walkLayer = null;
         DomainResourceLoad.clearDomainResource();
         if(SpaceManager.instance.exit)
         {
            SpaceSocketManager.instance.dispose();
            SpaceManager.instance.dispose();
            SpaceManager.instance.controller = null;
            SpaceManager.instance.mapView = null;
         }
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("FIND_NODE",__findNodeHandler);
         NotificationManager.instance.addEventListener("SELECT_NODE",__selectNodeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FIND_NODE",__findNodeHandler);
         NotificationManager.instance.removeEventListener("SELECT_NODE",__selectNodeHandler);
      }
      
      private function __findNodeHandler(param1:SpaceEvent) : void
      {
         var _loc2_:SpaceNode = _model.getMapNodeById(PlayerManager.instance.currentPlayerModel.spaceNodeId);
         PlayerManager.instance.currentPlayerModel.spaceNodeId = -1;
         if(_loc2_)
         {
            _model.selectNode = _loc2_;
            SpaceArmyViewHelper.visitNode(_loc2_);
         }
      }
      
      private function __selectNodeHandler(param1:SpaceEvent) : void
      {
         var _loc2_:String = null;
         var _loc7_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = int(param1.data);
         var _loc4_:SpaceNode = _model.getMapNodeById(_loc6_);
         if(_loc4_)
         {
            _model.checkNodeId = _loc6_;
            _model.selectNode = _loc4_;
            if(SpaceManager.instance.callback != null)
            {
               SpaceManager.instance.callback();
            }
            if(!SpaceManager.instance.isPopFrame)
            {
               return;
            }
            if(_loc6_ == 21)
            {
               if(MarryManager.instance.model.canRideCar)
               {
                  SpaceArmyViewHelper.openNodeDialog();
               }
               else if(MarryManager.instance.model.lockScreen == false)
               {
                  if(!MarryManager.instance.model.roomInfo)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.SpaceSceneController.cannotRideMarryCar01"));
                  }
                  else
                  {
                     _loc2_ = "";
                     switch(int(MarryManager.instance.model.roomInfo.property7))
                     {
                        case 0:
                           _loc2_ = LanguageMgr.GetTranslation("map.space.SpaceSceneController.cannotRideMarryCar02");
                           break;
                        case 1:
                           _loc2_ = LanguageMgr.GetTranslation("map.space.SpaceSceneController.cannotRideMarryCar01");
                           break;
                        case 2:
                           _loc2_ = LanguageMgr.GetTranslation("map.space.SpaceSceneController.cannotRideMarryCar01");
                           break;
                        case 3:
                           _loc2_ = LanguageMgr.GetTranslation("map.space.SpaceSceneController.cannotRideMarryCar02");
                     }
                     MessageTipManager.instance().show(_loc2_);
                  }
               }
            }
            else if(SpaceNodeType.isYearNode(_loc4_.info.types))
            {
               StoreSocketOutManager.sendYearBoxCollect(_loc6_);
            }
            else if(_loc6_ == 35 || _loc6_ == 36)
            {
               TopToolsBar.instance.enterOutyardScene();
            }
            else if(_loc4_.dialogue)
            {
               SpaceArmyViewHelper.openNodeDialog();
            }
            else
            {
               _loc7_ = _loc4_.param3.split(",");
               _loc5_ = int(_loc7_[0]);
               _loc3_ = 0;
               if(_loc7_[2])
               {
                  _loc3_ = int(_loc7_[2]);
               }
               if(_loc3_ > ArmyManager.instance.thane.grades)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("store.view.StoreFrame.command01",_loc3_));
                  return;
               }
               SpaceArmyViewHelper.openNodeFrame(_loc5_);
            }
         }
      }
      
      public function moveArmyByPos(param1:int, param2:int, param3:Boolean = false) : Boolean
      {
         var _loc6_:int = 0;
         var _loc11_:Array = null;
         NotificationManager.instance.sendNotification("LOCK_TEAM_FOLLOW_TARGET",null);
         var _loc7_:String = "";
         if(MopupManager.instance.model.isMopup)
         {
            _loc7_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc7_);
            return false;
         }
         var _loc14_:SpaceNode = SpaceManager.instance.model.getHandlerNode(int(param1 / 20),int(param2 / 20));
         if(_loc14_ && _loc14_.info.types != 191 && _loc14_.info.types != 1 && _loc14_.param1 != 2)
         {
            if(_loc14_.handlerRangePoints.length != 0)
            {
               _loc6_ = Math.random() * _loc14_.handlerRangePoints.length;
               if(_loc6_ == _loc14_.handlerRangePoints.length)
               {
                  _loc6_ = 0;
               }
               if(_loc14_.handlerRangePoints[_loc6_])
               {
                  param1 = _loc14_.handlerRangePoints[_loc6_].x * 20;
                  param2 = _loc14_.handlerRangePoints[_loc6_].y * 20;
               }
            }
         }
         var _loc13_:Point = new Point(param1,param2);
         var _loc8_:SpaceArmy = _model.selfArmy;
         if(!_loc8_)
         {
            return false;
         }
         var _loc4_:Object = getArmyView(_loc8_);
         var _loc12_:Boolean = Boolean(_model.isFlying(ArmyManager.instance.army.mountTemplateId));
         var _loc10_:Point = new Point(_loc4_.x,_loc4_.y);
         var _loc5_:Point = new Point(_loc4_.x,_loc4_.y);
         if(_loc12_)
         {
            _loc5_ = getFlyStartPoint(_loc4_.x,_loc4_.y,_loc13_);
         }
         else
         {
            _loc5_ = getStartPoint(_loc4_.x,_loc4_.y,_loc13_);
         }
         if(!_loc5_)
         {
            for each(var _loc9_:SpaceNode in _model.mapNodesData)
            {
               if(_loc9_.info.types == 40)
               {
                  _loc4_.x = _loc9_.curPosX * 20;
                  _loc4_.y = _loc9_.curPosY * 20;
                  return false;
               }
            }
         }
         if(_loc5_.x < 0 || _loc5_.x > _model.mapTempInfo.Width || _loc5_.y < 0 || _model.mapTempInfo.Height < _loc5_.y)
         {
            return false;
         }
         if(param3 && !_loc12_)
         {
            initRectScan();
            _loc13_ = _rectScanUtils.walkRectScan(_loc13_,new Point(_loc5_.x / 20,_loc5_.y / 20),_loc10_);
         }
         if(_loc13_)
         {
            if(_loc12_)
            {
               _currentFindPath = _flyFindPath;
               _algUtils.findPath8 = _currentFindPath;
               _loc11_ = [new Point(int(_loc5_.x / 20),int(_loc5_.y / 20)),new Point(int(_loc13_.x / 20),int(_loc13_.y / 20))];
            }
            else
            {
               _currentFindPath = _findPath;
               _algUtils.findPath8 = _currentFindPath;
               _loc11_ = _currentFindPath.find(new Point(int(_loc5_.x / 20),int(_loc5_.y / 20)),new Point(int(_loc13_.x / 20),int(_loc13_.y / 20)));
            }
            if(_loc11_)
            {
               if(!_loc12_)
               {
                  _loc11_ = _algUtils.getPsnode(_loc11_);
               }
               _loc4_.aiInfo.pathInfo = _loc11_;
               if(_loc11_.length > 1)
               {
                  _model.updateWalkTarget(_loc13_);
               }
            }
            if(MouseData.instance.curState != "Lock")
            {
               MouseData.instance.curState = "Normal";
            }
            return true;
         }
         return false;
      }
      
      private function initRectScan() : void
      {
         _rectScanUtils.outWidth = _model.mapTempInfo.Width / 20;
         _rectScanUtils.outHeight = _model.mapTempInfo.Height / 20;
         _rectScanUtils.getWalkable = getWalkable;
      }
      
      private function getFlyStartPoint(param1:int, param2:int, param3:Point) : Point
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > _model.mapTempInfo.Width)
         {
            param1 = int(_model.mapTempInfo.Width);
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         else if(param2 > _model.mapTempInfo.Height)
         {
            param2 = int(_model.mapTempInfo.Height);
         }
         return new Point(param1,param2);
      }
      
      private function getStartPoint(param1:int, param2:int, param3:Point) : Point
      {
         if(getWalkable(param1 / 20,param2 / 20))
         {
            return new Point(param1,param2);
         }
         var _loc4_:Point = _model.getNeighborII(param1 / 20,param2 / 20);
         if(_loc4_)
         {
            _loc4_.x *= 20;
            _loc4_.y *= 20;
         }
         return _loc4_;
      }
      
      public function getWalkable(param1:int, param2:int) : Boolean
      {
         return _model.getPointValue(param1,param2);
      }
      
      public function get findPath() : FindPath8
      {
         return _findPath;
      }
      
      public function searchPath(param1:Point, param2:Point) : Array
      {
         var _loc3_:SpaceArmy = null;
         var _loc4_:Array = null;
         var _loc5_:Boolean = false;
         if(_currentFindPath && _algUtils)
         {
            _loc3_ = _model.selfArmy;
            if(!_loc3_)
            {
               return null;
            }
            _loc5_ = Boolean(_model.isFlying(_loc3_.mountTemplateId));
            if(_loc5_)
            {
               _currentFindPath = _flyFindPath;
               _algUtils.findPath8 = _currentFindPath;
               _loc4_ = [param1,param2];
            }
            else
            {
               _currentFindPath = _findPath;
               _algUtils.findPath8 = _currentFindPath;
               _loc4_ = _algUtils.getPsnode(_currentFindPath.find(param1,param2));
            }
            return _loc4_;
         }
         return null;
      }
      
      public function moveMapCallBack(param1:Rectangle) : void
      {
         _model.targetPoint = new Point(param1.x,param1.y);
         _model.nineSliceScaling = Utils.getNineSliceScaling(param1);
         var _loc2_:Array = _model.checkConfigNoExites();
         if(_loc2_.length > 0)
         {
            _model.currentFloorData = _loc2_;
         }
      }
      
      public function sendRefreshScreen(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         OuterCitySocketOutManager.sendCurrentScreen(getCurrent9Screens(),_model.mapId);
      }
      
      private function getCurrent9Screens() : String
      {
         return Utils.getFilesIds(_model.nineSliceScaling);
      }
      
      override public function get SceneName() : String
      {
         return "SPACE_SCENE";
      }
      
      private function get userKey() : String
      {
         return PlayerManager.instance.currentPlayerModel.userInfo.key;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function getArmyView(param1:BaseArmy) : Object
      {
         if(!param1)
         {
            return null;
         }
         if(!_armyList)
         {
            return null;
         }
         for each(var _loc2_:Object in _armyList)
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
         if(!_armyList)
         {
            return;
         }
         _armyList.push(param1);
      }
      
      public function removeArmyView(param1:Object) : void
      {
         if(!_armyList)
         {
            return;
         }
         var _loc2_:int = _armyList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _armyList.splice(_loc2_,1);
         }
      }
      
      public function addNpcView(param1:Object) : void
      {
         _npcList.push(param1);
      }
      
      public function getNpcView(param1:SpaceNode) : Object
      {
         for each(var _loc2_:Object in _npcList)
         {
            if(_loc2_.nodeInfo == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addBuild(param1:Object) : void
      {
         _buildList.push(param1);
      }
      
      public function getBuildView(param1:SpaceNode) : Object
      {
         for each(var _loc2_:Object in _buildList)
         {
            if(_loc2_.info == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get npcList() : Array
      {
         return _npcList;
      }
      
      public function get armyList() : Array
      {
         return _armyList;
      }
      
      public function get buildList() : Array
      {
         return _buildList;
      }
   }
}

