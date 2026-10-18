package yishi
{
   import battle.BattleManager;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.AirGardenManager;
   import managers.ChildManager;
   import managers.ChildNswarManager;
   import managers.DarkMazeManager;
   import managers.DragonTalkerManager;
   import managers.DragonTitanManager;
   import managers.FreedomTeamManager;
   import managers.GameHallManager;
   import managers.GodDessManager;
   import managers.IncreasinglyRoadManager;
   import managers.MopupManager;
   import managers.OfferRewardManager;
   import managers.PerkinLabManager;
   import managers.PumpingJoyManager;
   import managers.RingTaskManager;
   import managers.RoomManager;
   import managers.TimeVortexManager;
   import managers.WorldBossManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.CampaignNode;
   import map.space.SpaceManager;
   import map.space.event.SpaceEvent;
   import map.space.manager.SpaceSocketOutManager;
   import mvc.ModuleFrameInfo;
   import mvc.controler.BuildingControler;
   import mvc.module.airgarden.AirGardenModel;
   import mvc.module.archeology.ArchaeologyModel;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.room.RoomInfo;
   import mvc.module.store.StoreModel;
   import mvc.module.task.TaskTemplate;
   import sandbox.SandboxManager;
   import simplegame.hamster.HamsterGameFrame;
   import simplegame.qte.QTETraining;
   import yishi.actions.map.crossmapsearch.CrossMapSearchAction;
   import yishi.actions.map.crossmapsearch.CrossMapSearchActionQueue;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.consant.GuideTaskType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FinalRoadManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.LordTrialManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.SecretWarManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SwitchPageHelp
   {
      
      private static var _callback:Function;
      
      public function SwitchPageHelp()
      {
         super();
      }
      
      public static function skipPageByTaskCondictionType(param1:Object, param2:Function = null) : void
      {
         var _loc10_:Array = null;
         var _loc8_:Array = null;
         var _loc4_:Array = null;
         var _loc9_:RingTask = null;
         var _loc6_:String = null;
         var _loc5_:String = null;
         var _loc7_:Array = null;
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.SwitchPageHelp.taskNotFinish");
         if(param1 is TaskTemplate)
         {
            _loc10_ = (param1 as TaskTemplate).conditionList;
            if(!_loc10_[0].hasOwnProperty("CondictionType"))
            {
               return;
            }
            if(_loc10_[0]["Para4"] != "0")
            {
               if(mapModel && WorldBossHelper.checkIsNoviceSingleCamp(mapModel.mapId))
               {
                  walkNext();
               }
               else
               {
                  walkToCrossMapTarget(_loc10_[0]["Para4"]);
               }
               return;
            }
            if((param1 as TaskTemplate).TemplateId == 1801)
            {
               gotoDragonTransferCampaign();
               return;
            }
            switch(_loc10_[0].CondictionType)
            {
               case 1:
                  MessageTipManager.instance().show(_loc3_);
                  break;
               case 2:
                  if(PlayerManager.instance.newbieProcess < 19000)
                  {
                     walkNext();
                     return;
                  }
                  if(_loc10_[0].hasOwnProperty("Para1"))
                  {
                     gotoBuildingFrame(_loc10_[0].Para1);
                  }
                  break;
               case 3:
                  gotoCasernFrame();
                  break;
               case 7:
                  if(SceneManager.instance.currentType == "CASTLE_SCENE")
                  {
                     gotoOuterCity();
                  }
                  else if(SceneManager.instance.currentType != "OUTER_CITY_SCENE")
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01"));
                  }
                  break;
               case 8:
                  if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
                  {
                     gotoOuterCity();
                  }
                  else if(SceneManager.instance.currentType != "OUTER_CITY_SCENE")
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01"));
                  }
                  break;
               case 9:
                  gotoWorldMapFrame();
                  break;
               case 10:
                  if(_loc10_[0].hasOwnProperty("Para1"))
                  {
                     gotoUpgradePawnFrame(_loc10_[0].Para1);
                  }
                  break;
               case 11:
               case 12:
                  MessageTipManager.instance().show(_loc3_);
                  break;
               case 13:
                  if(_loc10_[0].hasOwnProperty("Para3"))
                  {
                     gotoCampaignById(_loc10_[0].Para3);
                  }
                  break;
               case 14:
                  if(_loc10_[0].hasOwnProperty("Para1"))
                  {
                     gotoCampaignById(_loc10_[0].Para1);
                  }
                  break;
               case 16:
                  gotoPvpFrame();
                  break;
               case 17:
                  gotoStoreFrame("STORE_PANEL_INTENSIFY");
                  break;
               case 18:
                  gotoStoreFrame("STORE_PANEL_MOUNT");
                  break;
               case 19:
                  StoreModel.defaultChildPanel = 3;
                  gotoStoreFrame("STORE_PANEL_COMPOSE");
                  break;
               case 20:
                  gotoFarmFrame();
                  break;
               case 21:
                  gotoFriendFrame();
                  break;
               case 22:
                  gotoConsortiaFrame(1);
                  break;
               case 23:
                  walkNext();
                  break;
               case 24:
               case 25:
               case 26:
               case 27:
               case 28:
                  if(_loc10_[0].hasOwnProperty("Para3"))
                  {
                     gotoCampaignById(_loc10_[0].Para3);
                  }
                  break;
               case 29:
                  gotoConsortiaFrame(2);
                  break;
               case 30:
                  gotoConsortiaFrame(4);
                  break;
               case 31:
                  if(_loc10_[0].hasOwnProperty("Para1"))
                  {
                     if(_loc10_[0].Para1 == 1)
                     {
                        gotoSingleCampaign();
                     }
                     else if(_loc10_[0].Para1 > 1)
                     {
                        gotoHeroDoor();
                     }
                  }
                  break;
               case 32:
                  gotoCollectScene(param1);
                  break;
               case 33:
                  if(param2 != null)
                  {
                     param2();
                  }
                  break;
               case 34:
                  gotoLineupFrame();
                  break;
               case 35:
                  gotoColosseumFrame();
                  break;
               case 36:
               case 221:
                  gotoStarFrame();
                  break;
               case 37:
                  if(param2 != null)
                  {
                     param2();
                  }
                  break;
               case 38:
                  gotoMazeFrame();
                  break;
               case 39:
                  MessageTipManager.instance().show(_loc3_);
                  break;
               case 40:
               case 41:
                  gotoWorldBossFrame();
                  break;
               case 42:
                  gotoOfficeFrame();
                  break;
               case 43:
                  RechargeAlertMannager.navigateToRechargePage();
                  break;
               case 44:
               case 45:
                  gotoWorldFightFrame();
                  break;
               case 46:
                  gotoStoreFrame("STORE_PANEL_RESOLVE");
                  break;
               case 47:
                  gotoStoreFrame("STORE_PANEL_REFRESH");
                  break;
               case 48:
                  if(param2 != null)
                  {
                     param2();
                  }
                  break;
               case 49:
                  MessageTipManager.instance().show(_loc3_);
                  break;
               case 50:
                  gotoWorldFightFrame();
                  break;
               case 51:
                  gotoConsortiaFrame();
                  break;
               case 52:
                  break;
               case 53:
                  gotoStarBagFrame();
                  break;
               case 54:
                  gotoOfferRewardFrame();
                  break;
               case 55:
                  gotoDayGuideFrame();
                  break;
               case 56:
                  gotoMarkeFrame();
                  break;
               case 57:
                  gotoSeminaryFrame();
                  break;
               case 58:
                  gotoBagFrame();
                  break;
               case 59:
               case 60:
               case 61:
               case 216:
                  gotoFarmFrame();
                  break;
               case 63:
                  gotoDayGuideFrame();
                  break;
               case 71:
                  gotoMounts();
                  break;
               case 74:
                  gotoHeroDoor();
                  break;
               case 76:
               case 77:
               case 78:
                  gotoRunnesSkill();
                  break;
               case 79:
               case 80:
                  gotoDayLight();
                  break;
               case 86:
                  gotoMineField();
                  break;
               case 90:
                  openBattleGuardFrame();
                  break;
               case 91:
                  gotoTreasureHunt();
                  break;
               case 92:
                  challengeSelf((param1 as TaskTemplate).TemplateId);
                  break;
               case 94:
                  gotoWorldFightFrame();
                  break;
               case 95:
                  gotoDragonSoulFrame();
                  break;
               case 96:
               case 203:
               case 204:
               case 205:
               case 205:
                  gotoMountsFrame();
                  break;
               case 207:
               case 208:
                  gotoPerkinLabFrame(_loc10_[0].CondictionType);
                  break;
               case 209:
               case 210:
                  gotoTattooFrame(_loc10_[0].CondictionType);
                  break;
               case 98:
                  gotoMonopolyFrame();
                  break;
               case 97:
                  gotoMonopolyFrame();
                  break;
               case 99:
                  gotoMonopolyFrame();
                  break;
               case 212:
                  gotoMarkingSkill();
                  break;
               case 214:
               case 225:
                  gotoChild();
                  break;
               case 217:
                  SpaceManager.instance.visitSpaceNPC(22);
                  break;
               case 218:
                  gotoTitanInject();
                  break;
               case 219:
                  openTitanTemple();
                  break;
               case 222:
                  openShuttleFrame();
                  break;
               case 224:
                  openTimeVortexFrame();
                  break;
               case 223:
                  gotoMagicPub();
                  break;
               case 220:
                  walkToCrossMapTarget("10000,6");
                  break;
               case 226:
                  openStarGazingFrame();
                  break;
               case 231:
                  goSpaceAndFind(48);
                  break;
               case 233:
               case 232:
               case 234:
               case 235:
                  openMonsterFrame();
                  break;
               case 237:
                  gotoMarkingSkill();
                  break;
               case 239:
                  gotoRevengeRoad();
                  break;
               case 240:
                  openGuildWantedFrame();
                  break;
               case 241:
                  gotoRedeptionRoad();
                  break;
               case 242:
                  openInjectSpirit();
                  break;
               case 243:
                  openStrengthenGodess();
                  break;
               case 244:
                  openAdvanceGodess();
                  break;
               case 245:
                  openPotential();
                  break;
               case 246:
                  openRevengeSoul();
                  break;
               case 247:
                  openAdvanceRevengeSkill(0);
                  break;
               case 248:
               case 249:
               case 250:
               case 251:
                  openAdvanceRevengeSkill(4);
                  break;
               case 252:
                  openYLExpeditionFrame();
                  break;
               case 253:
                  openSpiritExpeditionFrame();
                  break;
               case 254:
                  if(_loc10_[0].hasOwnProperty("Para2"))
                  {
                     openShadowLandFrameByTask(2,[_loc10_[0].Para2]);
                  }
                  break;
               case 255:
               case 256:
               case 257:
               case 258:
               case 259:
                  openAdvanceRevengeSkill(0);
                  break;
               case 270:
               case 272:
                  FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.SKILL_PANEL;
                  FrameControllerManager.instance.openControllerByInfo("army",null,1);
                  break;
               case 271:
                  FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.SKILL_PANEL;
                  FrameControllerManager.instance.openControllerByInfo("army",null,4);
                  break;
               case 273:
                  FrameControllerManager.instance.openControllerByInfo("secretwar");
                  break;
               default:
                  if(param2 != null)
                  {
                     param2();
                  }
            }
         }
         else if(param1 is BaseOfferReward)
         {
            switch((_loc8_ = (param1 as BaseOfferReward).conditionList)[0].CondictionType)
            {
               case 1:
                  gotoCasernFrame();
                  break;
               case 2:
                  gotoStoreFrame("STORE_PANEL_INTENSIFY");
                  break;
               case 3:
                  gotoStoreFrame("STORE_PANEL_MOUNT");
                  break;
               case 4:
                  gotoCollectScene(param1);
                  break;
               case 5:
                  gotoFarmFrame();
                  break;
               case 6:
                  gotoStarFrame();
                  break;
               case 9:
                  if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID == 0)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command05"));
                     return;
                  }
                  gotoConsortiaFrame(2);
                  break;
               case 10:
                  gotoStoreFrame("STORE_PANEL_COMPOSE");
                  break;
               case 11:
                  gotoShopFrame();
                  break;
               case 12:
                  CheckUIModuleUtil.instance.tryCall("qte",showQte,[param1]);
                  break;
               case 13:
               case 14:
                  goArrest(param1 as BaseOfferReward);
                  break;
               case 15:
                  CheckUIModuleUtil.instance.tryCall("hamster",showHamster,[param1]);
                  break;
               default:
                  if(param2 != null)
                  {
                     param2();
                  }
            }
         }
         else if(param1 is RingTask)
         {
            _loc4_ = (param1 as RingTask).conditionList;
            _loc9_ = RingTaskManager.instance.getRingTask();
            switch(_loc4_[0].CondictionType)
            {
               case 1:
                  gotoCasernFrame();
                  break;
               case 2:
                  gotoStoreFrame("STORE_PANEL_INTENSIFY");
                  break;
               case 3:
                  gotoStoreFrame("STORE_PANEL_MOUNT");
                  break;
               case 4:
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("DISPOSEVIEW"));
                  walkToCrossMapTarget(_loc4_[0].Para4);
                  break;
               case 5:
                  gotoFarmFrame();
                  break;
               case 6:
                  gotoStarFrame();
                  break;
               case 9:
                  if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID == 0)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command05"));
                     return;
                  }
                  gotoConsortiaFrame(2);
                  break;
               case 10:
                  gotoStoreFrame("STORE_PANEL_COMPOSE");
                  break;
               case 11:
                  gotoShopFrame();
                  break;
               case 12:
                  CheckUIModuleUtil.instance.tryCall("qte",showQte,[param1]);
                  break;
               case 15:
                  CheckUIModuleUtil.instance.tryCall("hamster",showHamster,[param1]);
                  break;
               case 16:
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("DISPOSEVIEW"));
                  walkToCrossMapTarget(_loc4_[0].Para4);
                  break;
               case 17:
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("DISPOSEVIEW"));
                  walkToCrossMapTarget(_loc4_[0].Para4);
                  break;
               case 18:
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("DISPOSEVIEW"));
                  gotoCampaignById(_loc9_.currTask.condition_2);
                  break;
               case 19:
                  openShop(_loc9_.currTask.condition_2);
                  break;
               case 20:
                  openPetFrame();
                  break;
               case 21:
                  _loc6_ = SceneManager.instance.currentType;
                  if(MopupManager.instance.model.isMopup)
                  {
                     _loc5_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
                     MessageTipManager.instance().show(_loc5_);
                     return;
                  }
                  walkToCrossMapTarget("10000,17");
                  break;
               default:
                  if(param2 != null)
                  {
                     param2();
                  }
            }
         }
         else if(param1 is MarryTask)
         {
            switch((_loc7_ = (param1 as MarryTask).marryTaskTemp.conditionList)[0].CondictionType)
            {
               case 16:
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("DISPOSEVIEW"));
                  walkToCrossMapTarget(_loc7_[0].Para4);
                  break;
               case 22:
                  if(param2 != null)
                  {
                     param2();
                  }
                  break;
               case 23:
                  if(param2 != null)
                  {
                     param2();
                  }
                  break;
               default:
                  if(param2 != null)
                  {
                     param2();
                  }
            }
         }
      }
      
      public static function isEnterCastleNow() : Boolean
      {
         if(RoomManager.loginToRoomFlag)
         {
            return false;
         }
         if(SandboxManager.loginToSandboxFlag)
         {
            return false;
         }
         if(GameHallManager.loginToGameHallFlag)
         {
            return false;
         }
         if(SecretWarManager.loginToSecretWarFlag)
         {
            return false;
         }
         return true;
      }
      
      private static function openBattleGuardFrame() : void
      {
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.BATTLEGUARD_PANEL);
      }
      
      private static function challengeSelf(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = SceneManager.instance.currentType;
         switch(_loc3_)
         {
            case "CAMPAIGN_MAP_SCENE":
            case "BATTLE_SCENE":
            case "EMPTY_SCENE":
            case "PVE_ROOM_SCENE":
            case "PVP_ROOM_SCENE":
               break;
            case "SPACE_SCENE":
               BattleManager.preScene = "SPACE_SCENE";
               break;
            case "CASTLE_SCENE":
               BattleManager.preScene = "CASTLE_SCENE";
            default:
               SocketSendManager.instance.challengeSelf(param1);
               return;
         }
         _loc2_ = LanguageMgr.GetTranslation("task.TaskFrameII.command01");
         MessageTipManager.instance().show(_loc2_);
      }
      
      public static function gotoOuterCity() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("035",true);
         if(ArmyManager.instance.thane.grades < 13)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",13);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("mainBar.MainToolBar.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         SceneManager.instance.setScene("OUTER_CITY_SCENE");
      }
      
      public static function gotoOuterArchaeology() : void
      {
         var _loc1_:String = null;
         if(ArmyManager.instance.thane.grades < 15)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",15);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("mainBar.MainToolBar.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         SoundManager.instance.play("035",true);
         SceneManager.instance.setScene("OUTER_CITY_SCENE");
      }
      
      private static function goArrest(param1:BaseOfferReward) : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:OfferRewardConditionTemplate = null;
         if(param1)
         {
            switch(_loc4_ = SceneManager.instance.currentType)
            {
               case "CAMPAIGN_MAP_SCENE":
               case "BATTLE_SCENE":
               case "EMPTY_SCENE":
               case "PVE_ROOM_SCENE":
               case "PVP_ROOM_SCENE":
                  break;
               case "SPACE_SCENE":
                  BattleManager.preScene = "SPACE_SCENE";
                  break;
               case "CASTLE_SCENE":
                  BattleManager.preScene = "CASTLE_SCENE";
               default:
                  _loc3_ = param1.conditionList[0];
                  if(_loc3_)
                  {
                     OfferRewardManager.instance.sendRewardArrest(_loc3_.CondictionType,_loc3_.Para1);
                  }
            }
            _loc2_ = LanguageMgr.GetTranslation("task.TaskFrameII.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
      }
      
      private static function showQte(param1:Array) : void
      {
         var arr:Array = param1;
         var qteSucceedCall:* = function():void
         {
            if(arr[0])
            {
               arr[0].qteResult = true;
            }
         };
         var qte:QTETraining = new QTETraining(arr[0].conditionList[0].Para2,arr[0].conditionList[0].Para1 * 1000,qteSucceedCall);
         qte.show();
      }
      
      private static function showHamster(param1:Array) : void
      {
         var arr:Array = param1;
         var _hamsterGameSucceed:* = function():void
         {
            if(arr[0])
            {
               arr[0].hamsterGameResult = true;
            }
         };
         var hamsterGame:HamsterGameFrame = new HamsterGameFrame(arr[0].conditionList[0].Para1,arr[0].conditionList[0].Para2,_hamsterGameSucceed);
         hamsterGame.show();
      }
      
      private static function getCollectNodeIdByGoodId(param1:int) : int
      {
         switch(param1 - 2100022)
         {
            case 0:
               return 600108;
            case 1:
               return 600113;
            case 2:
               return 600107;
            default:
               return -1;
         }
      }
      
      public static function gotoCollectScene(param1:Object) : void
      {
         var _loc2_:String = null;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("task.TaskFrameII.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:CampaignTemplate = TempleteManager.instance.worldBossTemplateDict[param1.NeedFightId];
         FrameControllerManager.instance.worldBossControler.sendEnterBattle(_loc3_);
      }
      
      public static function gotoHeroDoor() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("035",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 20)
         {
            _loc1_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command19");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(2);
      }
      
      public static function gotoSingleCampaign() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("035",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(PlayerManager.instance.newbieProcess <= 23000)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",6);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("selectcampaign");
      }
      
      public static function gotoDragonTransferCampaign() : void
      {
         var _loc1_:String = null;
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         SocketSendManager.instance.startDragonSoulTransferCampaign();
      }
      
      private static function walkNext(param1:int = 0) : void
      {
         var _loc2_:String = null;
         var _loc4_:CampaignNode = null;
         var _loc3_:DisplayObject = null;
         if(param1 < 0)
         {
            return;
         }
         if(param1 == 0)
         {
            if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
            {
               _loc2_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("WORK_NEXT_NODE",null));
         }
         else
         {
            _loc4_ = mapModel.getMapNodeByNodeId(param1);
            if(!_loc4_ || !_loc4_.info)
            {
               return;
            }
            mapModel.selectNode = _loc4_;
            _loc3_ = CampaignManager.instance.mapView.getNpcNodeById(_loc4_.info.id);
            CampaignManager.instance.controller.moveArmyByPos(_loc3_.x,_loc3_.y,false,true);
         }
      }
      
      public static function walkToCrossMapTarget(param1:String, param2:Point = null) : void
      {
         var _loc6_:int = 0;
         var _loc16_:String = null;
         var _loc4_:Array = null;
         var _loc3_:CampaignMapModel = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc7_:int = 0;
         var _loc15_:CrossMapSearchAction = null;
         CrossMapSearchActionQueue.instance.clean();
         var _loc9_:Array = param1.split("|");
         var _loc13_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc9_.length)
         {
            _loc16_ = _loc9_[_loc6_];
            _loc4_ = _loc16_.split(",");
            _loc13_.push({
               "mapId":int(_loc4_[0]),
               "nodeId":int(_loc4_[1])
            });
            _loc6_++;
         }
         var _loc5_:int = 0;
         var _loc8_:Object = _loc13_[_loc13_.length - 1];
         var _loc10_:String = SceneManager.instance.currentType;
         var _loc17_:Boolean = false;
         if(_loc10_ == "CASTLE_SCENE" || _loc10_ == "FARM")
         {
            _loc17_ = true;
            _loc5_ = 10000;
         }
         else if(_loc10_ == "SPACE_SCENE")
         {
            _loc5_ = 10000;
         }
         else
         {
            if(_loc10_ != "CAMPAIGN_MAP_SCENE")
            {
               if(_loc10_ == "OUTER_CITY_SCENE")
               {
                  _loc11_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
                  MessageTipManager.instance().show(_loc11_);
                  return;
               }
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("taskTrace.SinglepassHasBugleYipsView.TipInfo"));
               return;
            }
            _loc3_ = CampaignManager.instance.mapModel;
            if(!_loc3_)
            {
               return;
            }
            _loc5_ = _loc3_.mapId;
         }
         _loc13_ = [];
         if(_loc5_ != _loc8_.mapId)
         {
            _loc12_ = CrossMapSearchActionQueue.instance.searchPath(_loc5_,_loc8_.mapId);
            if(_loc8_.mapId == 9995)
            {
               _loc12_ = [{
                  "from":10000,
                  "to":9995,
                  "by":99
               }];
            }
            if(!_loc12_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.TaskFrameII.command01"));
               return;
            }
            for each(var _loc14_:Object in _loc12_)
            {
               _loc13_.push({
                  "mapId":_loc14_.from,
                  "nodeId":_loc14_.by
               });
            }
         }
         _loc13_.push(_loc8_);
         _loc7_ = 0;
         while(_loc7_ < _loc13_.length)
         {
            _loc15_ = new CrossMapSearchAction();
            _loc15_.mapId = int(_loc13_[_loc7_].mapId);
            _loc15_.toPoint = int(_loc13_[_loc7_].nodeId);
            if(_loc7_ == _loc13_.length - 1 && param2)
            {
               _loc15_.toPosition = param2;
            }
            CrossMapSearchActionQueue.instance.addAction(_loc15_);
            _loc7_++;
         }
         if(_loc17_)
         {
            SwitchPageHelp.enterToSpace();
         }
      }
      
      private static function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      public static function gotoCampaignById(param1:int) : void
      {
         var _loc2_:String = null;
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(param1 == 0)
         {
            gotoHeroDoor();
         }
         var _loc3_:CampaignTemplate = TempleteManager.instance.campaignTemplateDic[param1];
         if(!_loc3_)
         {
            _loc3_ = TempleteManager.instance.worldBossTemplateDict[param1];
         }
         if(!_loc3_)
         {
            _loc3_ = TempleteManager.instance.pvpWarFightDic[param1];
         }
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.Capacity == 1 && mapModel && mapModel.campaignTemplate && mapModel.campaignTemplate.CampaignId == param1)
         {
            walkNext();
            return;
         }
         if(!checkScene())
         {
            return;
         }
         if(_loc3_.Capacity > 1)
         {
            if(ArmyManager.instance.thane.grades < 20)
            {
               _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command19");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            goSpaceAndFind(2);
         }
         else if(_loc3_.Capacity == 1)
         {
            if(ArmyManager.instance.thane.grades < _loc3_.MinLevel)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.SwitchPageHelp.gotoCampaignById.levelLimit"));
               return;
            }
            if(WorldBossHelper.checkMaze2(_loc3_.CampaignId))
            {
               if(SceneManager.instance.currentType == "SPACE_SCENE")
               {
                  SceneManager.instance.setScene("CASTLE_SCENE",{"isOpenPetMaze2":true});
               }
               else if(SceneManager.instance.currentType == "CASTLE_SCENE")
               {
                  FrameControllerManager.instance.openControllerByInfo("maze",2);
               }
            }
            else
            {
               SoundManager.instance.play("035",true);
               FrameControllerManager.instance.openControllerByInfo("selectcampaign",null,_loc3_);
            }
         }
      }
      
      public static function gotoUpgradePawnFrame(param1:int) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.PAWNUPGRADE,ArmyManager.instance.getCasernPawnByMastertype(param1));
      }
      
      public static function gotoConsortiaFrame(param1:int = 1) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("015",true);
         if(ArmyManager.instance.thane.grades < 13)
         {
            _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",13);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("consortia",param1);
      }
      
      public static function gotoStarFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("035",true);
         if(ArmyManager.instance.thane.grades < 18)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",18);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("star");
      }
      
      public static function gotoShopFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(ArmyManager.instance.thane.grades < 10)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",10);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("shop");
      }
      
      private static function gotoBagFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(ArmyManager.instance.thane.grades < 10)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",4);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL);
      }
      
      public static function gotoWorldBossFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 20)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",20);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         if(!worldBossState)
         {
            _loc1_ = LanguageMgr.GetTranslation("YiShi.SwitchPageHelp.WorldBoss");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("worldboss",1);
      }
      
      public static function gotoWorldFightFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 30)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",30);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         if(!worldFightState)
         {
            _loc1_ = LanguageMgr.GetTranslation("YiShi.SwitchPageHelp.warFight");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("worldboss",3);
      }
      
      public static function gotoDragonSoulFrame() : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || SceneManager.instance.currentType == "EMPTY_SCENE")
         {
            return;
         }
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.DRAGON_SOUL_PANEL);
      }
      
      public static function gotoMountsFrame() : void
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || SceneManager.instance.currentType == "EMPTY_SCENE")
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 70)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",70);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("mounts",1);
      }
      
      private static function get worldBossState() : Boolean
      {
         var _loc2_:Dictionary = TempleteManager.instance.worldBossTemplateDict;
         for each(var _loc1_:CampaignTemplate in _loc2_)
         {
            if(_loc1_.state == 0 && WorldBossHelper.checkWorldBoss(_loc1_.CampaignId))
            {
               return true;
            }
         }
         return false;
      }
      
      private static function get worldFightState() : Boolean
      {
         var _loc2_:Dictionary = TempleteManager.instance.pvpWarFightDic;
         for each(var _loc1_:CampaignTemplate in _loc2_)
         {
            if(WorldBossManager.instance.pvpWarIsOpen && (WorldBossHelper.checkDuskArea(_loc1_.CampaignId) || WorldBossHelper.checkFlameTemple(_loc1_.CampaignId) || WorldBossHelper.checkIceFireTemple(_loc1_.CampaignId)))
            {
               return true;
            }
         }
         return false;
      }
      
      private static function gotoDayGuideFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc1_ = LanguageMgr.GetTranslation("mainBar.TopToolsBar.dayGuideBtn.underLevel");
            MessageTipManager.instance().show(_loc1_);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("newactiveleed");
         }
      }
      
      public static function gotoStoreFrame(param1:String, param2:GoodsInfo = null) : void
      {
         var _loc3_:String = null;
         SoundManager.instance.play("015",true);
         switch(param1)
         {
            case "STORE_PANEL_INTENSIFY":
               if(PlayerManager.instance.newbieProcess <= 19000)
               {
                  _loc3_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",7);
                  MessageTipManager.instance().show(_loc3_);
                  return;
               }
               break;
            case "STORE_PANEL_MOUNT":
            case "STORE_PANEL_COMPOSE":
               if(ArmyManager.instance.thane.grades < 15)
               {
                  _loc3_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",15);
                  MessageTipManager.instance().show(_loc3_);
                  return;
               }
               break;
            case "STORE_PANEL_REFRESH":
            case "STORE_PANEL_RESOLVE":
            case "STORE_PANEL_SWITCH":
               if(ArmyManager.instance.thane.grades < 19)
               {
                  _loc3_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",19);
                  MessageTipManager.instance().show(_loc3_);
                  return;
               }
         }
         FrameControllerManager.instance.storeController.startFrameByType(param1,param2);
      }
      
      public static function gotoOfferRewardFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 17)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(1);
      }
      
      public static function gotoMarkeFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 26)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",26);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(8);
      }
      
      private static function gotoOfficeFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(!checkScene())
         {
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         var _loc2_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(901);
         if(_loc2_.property2 > _loc2_.property1)
         {
            FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc2_),null,_loc2_);
         }
      }
      
      public static function gotoCasernFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 11)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",11);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         var _loc2_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(402);
         FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc2_),null,_loc2_);
      }
      
      public static function gotoTransferFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 15)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",15);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         var _loc2_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(1511);
         FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc2_),null,_loc2_);
      }
      
      public static function gotoSeminaryFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 18)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",18);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         var _loc2_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(501);
         FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc2_),null,_loc2_);
      }
      
      private static function gotoFriendFrame() : void
      {
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.friendControler.startFrameByType(1);
      }
      
      private static function gotoLineupFrame() : void
      {
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL);
      }
      
      public static function gotoMazeFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 12)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",12);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("maze");
      }
      
      public static function gotoHookRoom() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 21)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("hook");
      }
      
      public static function gotoColosseumFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 16)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",16);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(6);
      }
      
      public static function gotoPvpFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("011",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 22)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",22);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(6);
      }
      
      public static function gotoMonopolyFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("011",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 55)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",55);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(27);
      }
      
      public static function gotoChild() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("011",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 70)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",55);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(28);
      }
      
      public static function gotoTitanInject() : void
      {
         SoundManager.instance.play("015",true);
         if(!ArmyManager.instance.thane.isChangeJob || DragonTitanManager.instance.model.templateId <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.titanNotOpen"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("dragontitan");
      }
      
      public static function gotoMagicPub() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || SceneManager.instance.currentType == "EMPTY_SCENE")
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 32)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",32);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("magicpub");
      }
      
      private static function gotoStarBagFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("015",true);
         if(ArmyManager.instance.thane.grades < 18)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",18);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("star",1);
      }
      
      private static function gotoWorldMapFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("022");
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("worldmap");
      }
      
      private static function gotoBuildingFrame(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:BuildInfo = null;
         SoundManager.instance.play("015",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         if(param1 >= 1300 && param1 < 1500 || param1 >= 2304 && param1 < 2446)
         {
            _loc3_ = BuildingManager.instance.getBuildingInfoBySonType(501);
         }
         else
         {
            _loc3_ = BuildingManager.instance.getBuildingInfoBySonType(param1);
         }
         FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc3_),null,_loc3_);
      }
      
      public static function gotoFarmFrame() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("035",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 12)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",12);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("farm","CastleBuildingView.FarmEnterNewFrame");
      }
      
      public static function gotoVehicleBuild() : void
      {
         var _loc1_:* = null;
      }
      
      public static function gotoMineField() : void
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || SceneManager.instance.currentType == "EMPTY_SCENE")
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 25)
         {
            _loc1_ = LanguageMgr.GetTranslation("mineField.noOpen");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("minefield");
      }
      
      public static function gotoDayLight() : void
      {
         var _loc1_:String = null;
         if(ArmyManager.instance.thane.grades < 13)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         SandboxManager.instance.requestState();
      }
      
      public static function gotoVehicleRoom() : void
      {
         var _loc1_:* = null;
      }
      
      public static function gotoTreasureHunt() : void
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || SceneManager.instance.currentType == "EMPTY_SCENE")
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 32)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",32);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("treasurehunt");
      }
      
      public static function gotoRunnesSkill() : void
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || SceneManager.instance.currentType == "EMPTY_SCENE")
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 35)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",35);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL,1);
      }
      
      public static function gotoMarkingSkill() : void
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || SceneManager.instance.currentType == "EMPTY_SCENE")
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 35)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",35);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL,2);
      }
      
      public static function gotoMounts() : void
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || SceneManager.instance.currentType == "EMPTY_SCENE")
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 16)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",16);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("mounts",1);
      }
      
      public static function checkScene() : Boolean
      {
         var _loc1_:String = null;
         var _loc2_:String = WorldBossHelper.getCampaignTips();
         if(_loc2_ != "")
         {
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         if(SceneManager.instance.currentType == "PVE_ROOM_SCENE" || SceneManager.instance.currentType == "PVP_ROOM_SCENE" || SceneManager.instance.currentType == "ARESLORDS_ROOM" || SceneManager.instance.currentType == "UNREAL_SHOOTING_ROOM" || SceneManager.instance.currentType == "APEX_ROOM" || SceneManager.instance.currentType == "GLORY_GAME_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command03");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         return true;
      }
      
      public static function openGuildFbFrame() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0 && checkScene())
         {
            FrameControllerManager.instance.openControllerByInfo("guildfb");
         }
      }
      
      public static function openMinosFrame() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0 && checkScene())
         {
            FrameControllerManager.instance.openControllerByInfo("minos");
         }
      }
      
      public static function openGuildWantedFrame() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0 && checkScene())
         {
            FrameControllerManager.instance.openControllerByInfo("guildwanted");
         }
      }
      
      public static function get isInCampaign() : Boolean
      {
         var _loc1_:String = SceneManager.instance.currentType;
         switch(_loc1_)
         {
            case "CAMPAIGN_MAP_SCENE":
            case "VEHICLE":
               break;
            default:
               return false;
         }
         return true;
      }
      
      public static function get isInSpace() : Boolean
      {
         var _loc1_:String = SceneManager.instance.currentType;
         var _loc2_:String = _loc1_;
         if("SPACE_SCENE" !== _loc2_)
         {
            return false;
         }
         return true;
      }
      
      public static function enterToSpace() : void
      {
         SpaceSocketOutManager.instance.enterSpace();
      }
      
      public static function get returnScene() : String
      {
         if(PlayerManager.instance.currentPlayerModel.spaceMapId == 0)
         {
            return "CASTLE_SCENE";
         }
         if(PlayerManager.instance.currentPlayerModel.inCastle)
         {
            return "CASTLE_SCENE";
         }
         if(ArmyManager.instance.thane.grades < 16)
         {
            return "CASTLE_SCENE";
         }
         return "SPACE_SCENE";
      }
      
      public static function returnToSpace(param1:Object = null, param2:Boolean = false, param3:Boolean = false) : void
      {
         if(returnScene == "SPACE_SCENE" && SpaceManager.instance.exit)
         {
            return;
         }
         SceneManager.instance.setScene(returnScene,param1,param2,param3);
      }
      
      public static function goSpaceAndFind(param1:int) : void
      {
         var _loc2_:String = null;
         PlayerManager.instance.currentPlayerModel.spaceNodeId = param1;
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            NotificationManager.instance.dispatchEvent(new SpaceEvent("FIND_NODE",null));
         }
         else
         {
            if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
            {
               _loc2_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            SwitchPageHelp.enterToSpace();
         }
      }
      
      public static function isEnterSpaceNow() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:CampaignTemplate = null;
         var _loc3_:RoomInfo = null;
         if(CampaignManager.instance.mapModel)
         {
            _loc1_ = CampaignManager.instance.mapModel.mapTempInfo.CampaignId;
            _loc2_ = TempleteManager.instance.campaignTemplateDic[_loc1_];
            _loc3_ = RoomManager.instance.roomInfo;
            if(_loc2_ && _loc3_)
            {
               return false;
            }
         }
         if(BattleManager.loginToBattleFlag)
         {
            return false;
         }
         if(PlayerManager.instance.currentPlayerModel.inCastle)
         {
            return false;
         }
         if(SandboxManager.loginToSandboxFlag)
         {
            return false;
         }
         if(GameHallManager.loginToGameHallFlag)
         {
            return false;
         }
         if(SecretWarManager.loginToSecretWarFlag)
         {
            return false;
         }
         return true;
      }
      
      public static function switchGuidePage(param1:int) : void
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case GuideTaskType.ARMY_LEVEL:
               gotoCasernFrame();
               break;
            case GuideTaskType.GUILD_SKILL:
               if(FrameControllerManager.instance.consortiaController.model.consortiaInfo.consortiaId > 0)
               {
                  gotoConsortiaFrame(5);
                  break;
               }
               _loc2_ = LanguageMgr.GetTranslation("yishi.SwitchPageHelp.promptTxt");
               MessageTipManager.instance().show(_loc2_);
               return;
               break;
            case GuideTaskType.PERSONAL_SKILL:
               gotoSeminaryFrame();
               break;
            case GuideTaskType.USE_STAR:
               gotoStarFrame();
               break;
            case GuideTaskType.USE_EQUIPMENT:
               gotoStoreFrame("STORE_PANEL_COMPOSE");
               break;
            case GuideTaskType.STRENGTHEN_EQU:
               gotoStoreFrame("STORE_PANEL_INTENSIFY");
               break;
            case GuideTaskType.PASS_TOWER:
               gotoMazeFrame();
               break;
            case GuideTaskType.STAR_LEVEL:
               gotoStarFrame();
               break;
            case GuideTaskType.INLAY_STONE:
               gotoStoreFrame("STORE_PANEL_MOUNT");
               break;
            case GuideTaskType.LEARN_FU_WEN:
               gotoRunnesSkill();
               break;
            case GuideTaskType.GET_MOUNT:
               gotoMounts();
               break;
            case GuideTaskType.PASS_CAMPAIGN:
               gotoCampaignById(9004);
               break;
            case GuideTaskType.GUILD_DEVOTE:
               if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID == 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command05"));
                  return;
               }
               gotoConsortiaFrame(2);
               break;
            case GuideTaskType.STAR_VALUE:
               gotoStarFrame();
               break;
            case GuideTaskType.SOUL_IMPORT_PARVAT:
               gotoBagFrame();
               break;
            case GuideTaskType.FU_WEN_LEVEL:
               gotoRunnesSkill();
               break;
            case GuideTaskType.TALENT_LEVEL:
               gotoRunnesSkill();
               break;
            case GuideTaskType.MOUNT_LEVEL:
               gotoMounts();
               break;
            case GuideTaskType.HONOUR_SOLDIER:
               getProprtStr();
               break;
            case GuideTaskType.FIGTHING_CAPACT:
            case GuideTaskType.ENTER_CAMPAIGN:
               gotoCampaignById(9004);
         }
      }
      
      public static function getProprtStr() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt01");
         var _loc2_:Date = new Date();
         var _loc4_:int = _loc2_.day;
         var _loc3_:int = _loc2_.hours;
         var _loc5_:int = _loc2_.minutes;
         switch(_loc4_)
         {
            case 0:
               _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Monday"));
               break;
            case 1:
               if(_loc3_ >= 21)
               {
                  _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Wednesday"));
               }
               else
               {
                  _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Monday"));
               }
               break;
            case 2:
               _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Wednesday"));
               break;
            case 3:
               if(_loc3_ >= 21)
               {
                  _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Friday"));
               }
               else
               {
                  _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Wednesday"));
               }
               break;
            case 4:
               _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Friday"));
               break;
            case 5:
               if(_loc3_ >= 21)
               {
                  _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Monday"));
               }
               else
               {
                  _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Friday"));
               }
               break;
            case 6:
               _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt02",LanguageMgr.GetTranslation("public.Monday"));
         }
         if(_loc3_ < 13)
         {
            _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt03",12,12);
         }
         else if(_loc5_ >= 25)
         {
            _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt03",_loc3_ + 1,_loc3_ + 1);
         }
         else
         {
            _loc1_ += LanguageMgr.GetTranslation("yishi.SwitchPageHelp.HONOUR_SOLDIER.prompt03",_loc3_,_loc3_);
         }
         MessageTipManager.instance().show(_loc1_);
      }
      
      public static function openPetFrame(param1:int = 0) : void
      {
         FrameControllerManager.instance.openControllerByInfo("pet",null,param1);
      }
      
      public static function openShop(param1:int) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",param1);
      }
      
      public static function gotoPerkinLabFrame(param1:int) : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
            return;
         }
         PerkinLabManager.instance.model.taskValue = param1;
         FrameControllerManager.instance.openControllerByInfo("perkinlab");
      }
      
      public static function gotoTattooFrame(param1:int) : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
            return;
         }
         FrameControllerManager.instance.tattooController.tattooModel.missionType = param1;
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.TATTOO_PANEL);
      }
      
      public static function gotoChildArenaFrame() : void
      {
         SoundManager.instance.play("035",true);
         if(ArmyManager.instance.thane.grades < 70)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.sapce.view.frame.DialogOptionItem.childArenaTips"));
            return;
         }
         if(ChildManager.instance.model.childList.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
            return;
         }
         if(ChildManager.instance.arenaModel.curstate == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childpvp.enter.groupAlert",ChildManager.instance.arenaModel.childPvpTimeArr[2]));
            return;
         }
         if(ChildManager.instance.arenaModel.curstate == 4 && ChildManager.instance.arenaModel.isSign)
         {
            FrameControllerManager.instance.openControllerByInfo("childarena","MAIN_FRAME");
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("childarena","SIGN_FRAME");
         }
      }
      
      public static function openAlchemicalFrame() : void
      {
         SoundManager.instance.play("035",true);
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("runeitemView.tip02"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("alchemical");
      }
      
      public static function openDragonTalkerFrame() : void
      {
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
            return;
         }
         if(!DragonTalkerManager.instance.model.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerIntensifyView.open.alert"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("dragontalker");
      }
      
      public static function openChildEsalFrame() : void
      {
         if(!ArmyManager.instance.thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needChangeJob"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("childesal");
      }
      
      public static function openFashionBoxFrame() : void
      {
         if(ArmyManager.instance.thane.grades < 10)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",10));
            return;
         }
         if(!VersionSwitch.FASHION_BOX)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("exchangebox",1);
      }
      
      public static function openMountBoxFrame() : void
      {
         if(ArmyManager.instance.thane.grades < 16)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",16));
            return;
         }
         if(!VersionSwitch.MOUNT_BOX)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("exchangebox",2);
      }
      
      public static function openLordTrailFrame() : void
      {
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
            return;
         }
         if(!checkIsRightScene())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goldRoad.goldRoadJoin.inOuterCity"));
            return;
         }
         if(!LordTrialManager.instance.model.isInActivity)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.mainframe.activityNotOpen"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("lordtrial",0);
      }
      
      public static function openTitanTemple() : void
      {
         if(!ArmyManager.instance.thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OutyardTitanView.openNeedChangeJob"));
            return;
         }
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         if(_loc1_.hours < 6 || _loc1_.hours >= 23)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OutyardTitanView.noInRightTime.alert"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("outyard",9);
      }
      
      public static function openShuttleFrame() : void
      {
         if(!ArmyManager.instance.thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OutyardTitanView.openNeedChangeJob"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("outyard",10);
      }
      
      public static function opendungeonexploFrame() : void
      {
         var _loc1_:int = TempleteManager.instance.royaltyTempCate.getdilaoLv(1);
         if(RoyaltyBossManager.instance.model.royaltyLevel < _loc1_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poseidon.shop.openLv",_loc1_));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("dungenexplo",1);
      }
      
      public static function openAbysmFrame() : void
      {
         if(!ArmyManager.instance.thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OutyardTitanView.openNeedChangeJob"));
            return;
         }
         if(ChildManager.instance.model.childList.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("abysm",7);
      }
      
      public static function openHellAbysmFrame() : void
      {
         if(!ArmyManager.instance.thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OutyardTitanView.openNeedChangeJob"));
            return;
         }
         if(ChildManager.instance.model.childList.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("abysm",11);
      }
      
      public static function openTimeVortexFrame() : void
      {
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         if(TimeVortexManager.instance.model.openDragon)
         {
            FrameControllerManager.instance.openControllerByInfo("timevortex",1);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("timevortex",0);
         }
      }
      
      public static function openUnrealShootingFrame() : void
      {
         if(ArmyManager.instance.thane.grades < 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",1));
            return;
         }
         if(!checkIsRightScene())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goldRoad.goldRoadJoin.inOuterCity"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("unrealshooting");
      }
      
      public static function checkIsRightScene() : Boolean
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return true;
         }
         return false;
      }
      
      public static function openPumpingJoyFrame() : void
      {
         if(ArmyManager.instance.thane.grades < 16)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",16));
            return;
         }
         if(!PumpingJoyManager.instance.model.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("pumpingJoy.active.noOpenAlert"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("pumpingjoy","MAIN_FRAME");
      }
      
      public static function openPerkinLabFrame() : void
      {
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.view.DailyItem.UnderLevel"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("perkinlab");
      }
      
      public static function openStarGazingFrame(param1:int = 0) : void
      {
         if(archaeologyModel.getGradeByExp(archaeologyModel.exp) < 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ArchaeologyMakeRightView.stargazingBtn.tipdata"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("stargazing",null,param1);
      }
      
      public static function openEclipticPalaceFrame() : void
      {
         if(!VersionSwitch.ECLIPTIC_PALACE)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("eclipticpalace","MAIN_FRAME",true);
      }
      
      public static function openDemonLandFrame() : void
      {
         if(!VersionSwitch.DEMON_LAND)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("demonland",1);
      }
      
      public static function openRevengeRoad() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.isAvenger)
         {
            if(!checkScene())
            {
               return;
            }
            FrameControllerManager.instance.openControllerByInfo("revengeroad");
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("revengeroad.main.text12"));
         }
      }
      
      public static function openGameHallFrame() : void
      {
         if(!VersionSwitch.GAME_HALL)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("gamehall");
      }
      
      public static function openMonsterFrame() : void
      {
         if(!VersionSwitch.MONSTER)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(ArmyManager.instance.thane.grades < 70)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",70));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("monster");
      }
      
      public static function openMonsterExploreFrame(param1:Boolean = true) : void
      {
         var _loc2_:TaskTemplate = null;
         if(!VersionSwitch.MONSTER_EXPLORE)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(param1 && !TaskManage.instance.IsTaskFinish(TaskManage.MONSTER_EXPLORE_TASK))
         {
            _loc2_ = TaskManage.instance.getTaskByID(TaskManage.MONSTER_EXPLORE_TASK);
            if(_loc2_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("monsterexplore.openMonsterExplore.taskAlert",_loc2_.Title));
            }
            return;
         }
         if(ArmyManager.instance.thane.grades < 70)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",70));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("monsterexplore");
      }
      
      public static function enterAirGardenCampaign(param1:int) : void
      {
         if(!VersionSwitch.AIR_GARDEN)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
         }
         AirGardenManager.instance.reqAirGardenCampaign(1,param1);
      }
      
      public static function airGardenCreateParty() : void
      {
         if(!VersionSwitch.AIR_GARDEN)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
            return;
         }
         if(!AirGardenManager.instance.model.canCreateParty)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airgarden.createParty.notTimeAlert"));
            return;
         }
         if(AirGardenManager.instance.model.selfCreatedParty)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airgarden.createParty.hasAlert"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("airgarden","CREATE_PARTY");
      }
      
      public static function airGardenJoinParty() : void
      {
         if(!VersionSwitch.AIR_GARDEN)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("airgarden","JOIN_PARTY");
      }
      
      public static function airGardenCampaignUp() : void
      {
         var _loc2_:int = ConfigInfoManager.instance.getAirGardenSelfUpMaxCount();
         var _loc1_:int = ConfigInfoManager.instance.getAirGardenUpMaxCount();
         if(airGardenModel.isParty)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.up.isPartyAlert"));
            return;
         }
         if(!airGardenModel.allPartyDic[airGardenModel.campaignInfo.masterUserId])
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.masterNoParty.PartyAlert"));
            return;
         }
         if(airGardenModel.campaignInfo.masterUserId == ArmyManager.instance.thane.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.up.notSelfAlert"));
            return;
         }
         if(airGardenModel.selfUpCount >= _loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.up.selfFullAlert"));
            return;
         }
         if(airGardenModel.campaignInfo.upCount >= _loc1_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.up.gardenFullAlert"));
            return;
         }
         AirGardenManager.instance.reqAirGardenCampaign(5,airGardenModel.campaignInfo.masterUserId);
      }
      
      public static function joinAirGardenPartyGame(param1:int) : void
      {
         var _loc2_:int = 0;
         if(!airGardenModel.isParty)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.up.noPartyAlert"));
            return;
         }
         if(!airGardenModel.allPartyDic[airGardenModel.campaignInfo.masterUserId])
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.masterNoParty.PartyAlert"));
            return;
         }
         if(airGardenModel.campaignInfo.masterUserId == ArmyManager.instance.thane.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.game.notSelfAlert"));
            return;
         }
         if(airGardenModel.extraGameCount <= 0)
         {
            if(airGardenModel.gameRemain <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.selfGame.noCount"));
               return;
            }
            _loc2_ = int(airGardenModel.campaignInfo.gameRemainList.length > 0 ? airGardenModel.campaignInfo.gameRemainList[param1 - 1] : 0);
            if(_loc2_ <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("airGarden.masterGame.noCount" + param1));
               return;
            }
         }
         AirGardenManager.instance.airGardenJoinGame(airGardenModel.campaignInfo.masterUserId,param1);
      }
      
      public static function openRedemptionRoad() : void
      {
         if(!VersionSwitch.REDEMPTION_ROAD)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(!ArmyManager.instance.thane.isAvenger)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("revengeroad.main.text12"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("redemptionroad");
      }
      
      public static function openIncreasinglyRoad() : void
      {
         if(!VersionSwitch.INCREASINGLY_ROAD)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.increasingly.inTeam"));
            return;
         }
         if(!ArmyManager.instance.thane.isAvenger)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("revengeroad.main.text12"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         IncreasinglyRoadManager.instance.getData();
      }
      
      public static function openDarkMaze() : void
      {
         if(!VersionSwitch.DARK_MAZE)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OutyardTitanView.openNeedChangeJob"));
            return;
         }
         DarkMazeManager.instance.enterScene();
      }
      
      private static function get archaeologyModel() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      private static function get airGardenModel() : AirGardenModel
      {
         return AirGardenManager.instance.model;
      }
      
      public static function gotoRevengeRoad() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("035",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(51);
      }
      
      public static function gotoRedeptionRoad() : void
      {
         var _loc1_:String = null;
         SoundManager.instance.play("035",true);
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(50);
      }
      
      public static function openInjectSpirit() : void
      {
         if(!VersionSwitch.TREASURE_MOST)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit","MAIN",5);
      }
      
      public static function openStrengthenGodess() : void
      {
         if(!GodDessManager.instance.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         var _loc1_:ModuleFrameInfo = new ModuleFrameInfo();
         _loc1_.frameData = 3;
         FrameControllerManager.instance.openControllerByInfo("goddess",3,_loc1_);
      }
      
      public static function openAdvanceGodess() : void
      {
         if(!GodDessManager.instance.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         var _loc1_:ModuleFrameInfo = new ModuleFrameInfo();
         _loc1_.frameData = 3;
         FrameControllerManager.instance.openControllerByInfo("goddess",3,_loc1_);
      }
      
      public static function openPotential() : void
      {
         if(!VersionSwitch.PROFICIENCY || !thane.isAvenger)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("proficiency");
      }
      
      public static function openRevengeSoul() : void
      {
         if(!VersionSwitch.AVENGER || !thane.isAvenger)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         var _loc1_:ModuleFrameInfo = new ModuleFrameInfo();
         _loc1_.frameData = 1;
         FrameControllerManager.instance.openControllerByInfo("avenger",1,_loc1_);
      }
      
      public static function openAdvanceRevengeSkill(param1:int) : void
      {
         if(!VersionSwitch.AVENGER || !thane.isAvenger)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("avenger",null,param1);
      }
      
      public static function openSpiritExpeditionFrame() : void
      {
         if(!VersionSwitch.SPIRIT_EXPEDITION)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(!thane.isAvenger)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("revengeroad.main.text12"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("spiritexpedition");
      }
      
      public static function openYLExpeditionFrame() : void
      {
         if(!VersionSwitch.YL_EXPEDTION)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(!thane.isAvenger)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("revengeroad.main.text12"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("ylexpedition",1);
      }
      
      public static function openShadowLandFrame() : void
      {
         if(!VersionSwitch.SHADOW_LAND)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(!thane.isHoly)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needHoly"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("shadowland");
      }
      
      public static function openShadowLandFrameByTask(param1:Object = null, param2:Object = null) : void
      {
         var timeId:int;
         var openType:Object = param1;
         var data:Object = param2;
         if(!VersionSwitch.SHADOW_LAND)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(!thane.isHoly)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needHoly"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("shadowland");
         timeId = int(setTimeout(function():void
         {
            clearTimeout(timeId);
            FrameControllerManager.instance.openControllerByInfo("shadowland",openType,data);
         },1000));
      }
      
      public static function openRemainsExploreFrame() : void
      {
         if(!VersionSwitch.REMAINS_EXPLORE)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.WarlordsManager.str04"));
            return;
         }
         if(!thane.isHoly)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needHoly"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("remainsexplore");
      }
      
      public static function openDarkMazeShopFrame() : void
      {
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc1_:Date = DarkMazeManager.instance.model.endGameDate;
         if(!VersionSwitch.DARK_MAZE)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OutyardTitanView.openNeedChangeJob"));
            return;
         }
         if(_loc2_.time - _loc1_.time > 604800000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.topToolsBar.clickTips9"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("shop",1023);
      }
      
      public static function openRoyaltyBossFrame() : void
      {
         var _loc1_:TaskTemplate = null;
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needChangeJob"));
            return;
         }
         if(!TaskManage.instance.IsTaskFinish(TaskManage.ROYALTY_BOSS_TASK))
         {
            _loc1_ = TaskManage.instance.getTaskByID(TaskManage.ROYALTY_BOSS_TASK);
            if(_loc1_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("monsterexplore.openMonsterExplore.taskAlert",_loc1_.Title));
            }
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("royaltyboss");
      }
      
      public static function openPoseidonFrame() : void
      {
         var _loc1_:int = TempleteManager.instance.royaltyTempCate.getLockLv(1);
         if(RoyaltyBossManager.instance.model.royaltyLevel < _loc1_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poseidon.shop.openLv",_loc1_));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("poseidonshop");
      }
      
      public static function openForbiddenBossFrame() : void
      {
         var _loc4_:Date = null;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needChangeJob"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("forbiddenBoss.open.remindtxt"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         var _loc1_:int = TempleteManager.instance.royaltyTempCate.getForbiddenLv(1);
         if(RoyaltyBossManager.instance.model.royaltyLevel < _loc1_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poseidon.shop.openLv",_loc1_));
            return;
         }
         var _loc2_:Array = ConfigInfoManager.instance.getForbiddenBossTime();
         if(_loc2_ && _loc2_.length == 2)
         {
            _loc4_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
            _loc5_ = DateFormatter.format(_loc4_,"YYYY-MM-DD");
            _loc6_ = DateFormatter.parse(_loc5_ + " " + _loc2_[0],"YYYY-MM-DD hh:mm:ss").time;
            _loc7_ = DateFormatter.parse(_loc5_ + " " + _loc2_[1],"YYYY-MM-DD hh:mm:ss").time;
            _loc3_ = _loc4_.time;
            if(_loc3_ < _loc6_ || _loc3_ > _loc7_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("forbiddenBossFrame.close.text",_loc2_[0],_loc2_[1]));
               return;
            }
         }
         FrameControllerManager.instance.openControllerByInfo("forbiddenboss");
      }
      
      public static function openWarSoulTowerFrame() : void
      {
         var _loc2_:TaskTemplate = null;
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needChangeJob"));
            return;
         }
         if(!TaskManage.instance.IsTaskFinish(TaskManage.WARSOUL_TOWER))
         {
            _loc2_ = TaskManage.instance.getTaskByID(TaskManage.WARSOUL_TOWER);
            if(_loc2_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("monsterexplore.openMonsterExplore.taskAlert",_loc2_.Title));
            }
            return;
         }
         if(!checkScene())
         {
            return;
         }
         var _loc1_:int = TempleteManager.instance.royaltyTempCate.getWarSoulTowerLv(1);
         if(RoyaltyBossManager.instance.model.royaltyLevel < _loc1_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poseidon.shop.openLv",_loc1_));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("warsoultower");
      }
      
      public static function openGodPvpFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("godpvpenter");
      }
      
      public static function openChildNsWar() : void
      {
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needChangeJob"));
            return;
         }
         ChildNswarManager.Instance.doSomething(1);
      }
      
      public static function openThessTower() : void
      {
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needChangeJob"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         var _loc1_:int = TempleteManager.instance.royaltyTempCate.getThessTowerLv(1);
         if(RoyaltyBossManager.instance.model.royaltyLevel < _loc1_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poseidon.shop.openLv",_loc1_));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("thesstower","ThessTowerFrame");
      }
      
      public static function openThessBox() : void
      {
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needChangeJob"));
            return;
         }
         if(!checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("thessbox","ThessBoxMainFrame");
      }
      
      public static function openFinalRoadFrame() : void
      {
         var _loc6_:TaskTemplate = null;
         var _loc8_:Date = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc10_:String = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:String = null;
         var _loc9_:Array = null;
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needChangeJob"));
            return;
         }
         if(!TaskManage.instance.IsTaskFinish(TaskManage.FINAL_ROAD))
         {
            _loc6_ = TaskManage.instance.getTaskByID(TaskManage.FINAL_ROAD);
            if(_loc6_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("monsterexplore.openMonsterExplore.taskAlert",_loc6_.Title));
            }
            return;
         }
         if(!checkScene())
         {
            return;
         }
         var _loc1_:int = TempleteManager.instance.royaltyTempCate.getFinalRoadLv(1);
         if(RoyaltyBossManager.instance.model.royaltyLevel < _loc1_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poseidon.shop.openLv",_loc1_));
            return;
         }
         var _loc2_:Array = ConfigInfoManager.instance.getFinalRoadRefreshTime();
         if(_loc2_ && _loc2_.length == 2)
         {
            _loc8_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
            _loc3_ = int(_loc2_[0]);
            if(_loc8_.day == _loc3_)
            {
               _loc4_ = _loc2_[1].split("|");
               _loc10_ = DateFormatter.format(_loc8_,"YYYY-MM-DD");
               _loc11_ = DateFormatter.parse(_loc10_ + " " + _loc4_[0],"YYYY-MM-DD hh:mm:ss").time;
               _loc12_ = DateFormatter.parse(_loc10_ + " " + _loc4_[1],"YYYY-MM-DD hh:mm:ss").time;
               _loc5_ = _loc8_.time;
               if(!(_loc5_ < _loc11_ || _loc5_ > _loc12_))
               {
                  _loc7_ = LanguageMgr.GetTranslation("secret.day.tip");
                  _loc9_ = _loc7_.split(",");
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("secret.day.open.text",_loc9_[_loc3_],_loc4_[0],_loc4_[1]));
                  return;
               }
            }
         }
         if(!FinalRoadManager.instance.model.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("finalRoad.close.text"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("finalroad");
      }
      
      public static function openSecretFrame() : void
      {
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:* = null;
         var _loc7_:* = null;
      }
      
      public static function gotoForbiddenBossFrame() : void
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!checkScene())
         {
            return;
         }
         goSpaceAndFind(49);
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

