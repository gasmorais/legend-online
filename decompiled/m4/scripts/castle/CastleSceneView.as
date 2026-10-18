package castle
{
   import bag.helper.BagHelper;
   import castle.view.CastleMapViewII;
   import castle.view.layer.CastleNameLayer;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import farm.FarmManager;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.SmallMapBar;
   import mainBar.TipsBar;
   import manager.LanguageMgr;
   import managers.ChallengeManager;
   import managers.ChildPatrolManager;
   import managers.DreamArenaManager;
   import managers.MinosManager;
   import managers.RedemptionRoadManager;
   import managers.SpiritExpeditionManager;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SceneViewEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.BuildingManager;
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
   import yishi.manager.TempleteSaveManager;
   import yishi.manager.WarSoulTowerManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   
   public class CastleSceneView extends BaseSceneView
   {
      
      private var _castleMap:CastleMapViewII;
      
      private var _nameLayer:CastleNameLayer;
      
      private var _preSceneData:Object;
      
      public function CastleSceneView()
      {
         super();
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         _preSceneData = param2;
         _nameLayer = new CastleNameLayer();
         _nameLayer.x = -130;
         _nameLayer.y = -180;
         _nameLayer.mouseChildren = _nameLayer.mouseEnabled = false;
         _castleMap = new CastleMapViewII(_nameLayer);
         _castleMap.dragingCallBack();
         addChild(_castleMap);
         addChild(_nameLayer);
         BuildingManager.instance.castleMap = _castleMap;
         SmallMapBar.instance.switchSmallMapState(4);
         SoundManager.instance.playMusic("castle",0);
         NotificationManager.instance.dispatchEvent(new SceneViewEvent("addToStage","CASTLE_SCENE"));
      }
      
      override public function enterOver() : void
      {
         var timeId:int;
         var bossReward:String;
         var consortiaId:int;
         var consortiaId2:int;
         var mapId:int;
         var tempAreaId:int;
         var tempDiff:int;
         var shadowLandCallBack:Function;
         var state:int;
         var tipData:TipMessageData;
         super.enterOver();
         TopToolsBar.instance.show();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         FullBar.instance.show();
         QueueBar.instance.show();
         ChatBar.instance.show();
         TaskTraceBar.instance.show();
         SmallMapBar.instance.show();
         ResourcesBar.instance.show();
         ChatTopBugleView.instance.setPos();
         if(_preSceneData)
         {
            if(_preSceneData.isOpenColosseum)
            {
               ChallengeManager.instance.enterScene = SceneManager.instance.currentType;
               SceneManager.instance.setScene("CHANLLENGE_ROOM_SCENE");
               FrameControllerManager.instance.openControllerByInfo("colosseum");
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
            else if(_preSceneData.isOpenPetMaze2)
            {
               FrameControllerManager.instance.openControllerByInfo("maze",2);
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
            else if(_preSceneData.isGloryRoadBattle)
            {
               FrameControllerManager.instance.openControllerByInfo("gloryroad");
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
            else if(_preSceneData.isSecretwarResult)
            {
               FrameControllerManager.instance.openControllerByInfo("secretwar",2);
            }
            else if(_preSceneData.isOpenStararea)
            {
               FrameControllerManager.instance.openControllerByInfo("sevenyear",1);
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
               tempAreaId = int(ShadowLandManager.instance.model.tempAreaId);
               tempDiff = int(ShadowLandManager.instance.model.tempDiff);
               shadowLandCallBack = function():void
               {
                  FrameControllerManager.instance.openControllerByInfo("shadowland",2,[tempAreaId,tempDiff]);
               };
               FrameControllerManager.instance.openControllerByInfo("shadowland",null,null);
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
         }
         FarmManager.instance.showGatherCropTip();
         ChildPatrolManager.instance.showChildPatrolTaskAlertTip();
         TaskTraceTipManager.instance.showBetterGoodsAlertTip();
         if(PlayerManager.instance.currentPlayerModel.playerInfo.showVersion && thane.grades >= 55)
         {
            tipData = new TipMessageData();
            tipData.title = LanguageMgr.GetTranslation("public.prompt");
            tipData.type = 31;
            tipData.content = LanguageMgr.GetTranslation("tasktracetip.view.FateGuardOpenview.content");
            TaskTraceTipManager.instance.showView(tipData);
         }
         if(thane.grades > 6)
         {
            TempleteSaveManager.instance.startSave();
         }
         if(HeroRoadManager.instance.popTaskInfo && HeroRoadManager.instance.count == 0)
         {
            FrameControllerManager.instance.openControllerByInfo("heroroad",2,HeroRoadManager.instance.popTaskInfo);
            HeroRoadManager.instance.count++;
         }
      }
      
      override public function get SceneName() : String
      {
         return "CASTLE_SCENE";
      }
      
      override public function leaving() : void
      {
         ObjectUtils.disposeObject(_castleMap);
         _castleMap = null;
         ObjectUtils.disposeObject(_nameLayer);
         _nameLayer = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         FullBar.instance.hide();
         MainToolBar.instance.hide();
         TopToolsBar.instance.hide();
         TipsBar.instance.hide();
         ResourcesBar.instance.hide();
         ChatBar.instance.hide();
         QueueBar.instance.hide();
         SmallMapBar.instance.hide();
         TaskTraceBar.instance.hide();
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         BuildingManager.instance.castleMap = null;
         TaskTraceTipManager.instance.cleanByType(19);
         TaskTraceTipManager.instance.cleanByType(14);
         TaskTraceTipManager.instance.cleanByType(41);
      }
      
      override public function onScale() : void
      {
         if(_castleMap)
         {
            _castleMap.onStageScale();
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

