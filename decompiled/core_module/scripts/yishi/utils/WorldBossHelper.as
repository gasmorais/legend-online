package yishi.utils
{
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.FrameControllerManager;
   import yishi.scene.SceneManager;
   
   public class WorldBossHelper
   {
      
      public function WorldBossHelper()
      {
         super();
      }
      
      public static function checkIsNoTeamChatMap(param1:int) : Boolean
      {
         if(WorldBossHelper.checkDeepPrison(param1))
         {
            return false;
         }
         if(WorldBossHelper.checkWorldBoss(param1))
         {
            return true;
         }
         if(WorldBossHelper.checkPetLand(param1))
         {
            return true;
         }
         if(WorldBossHelper.checkMineral(param1))
         {
            return true;
         }
         if(WorldBossHelper.checkIsNoviceMap(param1))
         {
            return true;
         }
         if(WorldBossHelper.checkIsNoviceSingleCamp(param1))
         {
            return true;
         }
         if(WorldBossHelper.checkIsNoviceCityMap(param1))
         {
            return true;
         }
         if(WorldBossHelper.checkForbiddenBoss(param1))
         {
            return true;
         }
         if(CampaignManager.instance.mapModel.campaignTemplate.Capacity == 1)
         {
            return true;
         }
         if(param1 >= 5000 && param1 <= 5100 || param1 > 6000 && param1 < 7000 || param1 > 7000 && param1 < 8000)
         {
            return true;
         }
         return false;
      }
      
      public static function checkFogMap(param1:int) : Boolean
      {
         if(param1 >= 10001 && param1 <= 10005 || param1 >= 4000 && param1 <= 5000 || param1 >= 5000 && param1 <= 5100 || param1 >= 5501 && param1 <= 5505 || param1 >= 5601 && param1 <= 5605 || param1 >= 5911 && param1 <= 5935 || param1 > 6000 && param1 < 7000 || param1 > 7000 && param1 < 8000 || param1 >= 8000 && param1 < 9000 || param1 > 20000 && param1 <= 25000 || param1 == 30000 || param1 == 30001 || param1 == 5101 || param1 == 5201 || param1 == 5301 || param1 == 9996 || param1 == 9997 || param1 == 9998 || param1 == 5701 || param1 == 5401 || param1 == 5801 || param1 == 9995 || param1 == 2292 || param1 == 2293 || param1 == 2291 || param1 == 2294 || param1 == 3002 || param1 == 9999 || param1 == 5703 || param1 == 4701 || param1 == 7701 || param1 == 7000 || param1 == 2401 || param1 > 31000 && param1 < 40000 || checkThessBox(param1))
         {
            return true;
         }
         return false;
      }
      
      public static function fogNoExits(param1:int) : Boolean
      {
         if(param1 > 6000 && param1 < 7000 || param1 > 7000 && param1 < 8000)
         {
            return true;
         }
         return false;
      }
      
      public static function checkMapId(param1:int) : Boolean
      {
         if(param1 >= 5000 && param1 <= 5100 || param1 > 6000 && param1 < 7000)
         {
            return true;
         }
         return false;
      }
      
      public static function checkDayLight(param1:int) : Boolean
      {
         return param1 == 4102;
      }
      
      public static function checkWorldBoss(param1:int) : Boolean
      {
         if(param1 >= 5000 && param1 <= 5100)
         {
            return true;
         }
         return false;
      }
      
      public static function checkMolong(param1:int) : Boolean
      {
         if(param1 == 4202)
         {
            return true;
         }
         return false;
      }
      
      public static function checkMaze(param1:int) : Boolean
      {
         if(param1 >= 8000 && param1 <= 8100)
         {
            return true;
         }
         return false;
      }
      
      public static function checkMaze2(param1:int) : Boolean
      {
         if(param1 >= 8101 && param1 <= 8130)
         {
            return true;
         }
         return false;
      }
      
      public static function checkMaze3(param1:int) : Boolean
      {
         if(param1 >= 8401 && param1 <= 8430)
         {
            return true;
         }
         return false;
      }
      
      public static function checkInAnyMaze(param1:int) : Boolean
      {
         return checkMaze(param1) || checkMaze2(param1) || checkMaze3(param1);
      }
      
      public static function checkPvp(param1:int) : Boolean
      {
         return false;
      }
      
      public static function checkPve() : Boolean
      {
         var _loc1_:CampaignTemplate = CampaignManager.instance.mapModel.campaignTemplate;
         return _loc1_ && _loc1_.Types == 0 && _loc1_.Capacity == 1 && _loc1_.DungeonId != 0;
      }
      
      public static function checkWedding(param1:int) : Boolean
      {
         if(param1 >= 4301 && param1 <= 4303)
         {
            return true;
         }
         return false;
      }
      
      public static function checkSteel(param1:int) : Boolean
      {
         if(param1 == 5701)
         {
            return true;
         }
         return false;
      }
      
      public static function checkConsortiaSecretLand(param1:int) : Boolean
      {
         if(param1 == 7501)
         {
            return true;
         }
         return false;
      }
      
      public static function consortiaCampaign(param1:int) : Boolean
      {
         if(checkConsortiaSecretLand(param1))
         {
            return true;
         }
         return false;
      }
      
      public static function checkIsNoviceMap(param1:int) : Boolean
      {
         if(param1 == 10001 || param1 == 10002)
         {
            return true;
         }
         return false;
      }
      
      public static function checkIsNoviceSingleCamp(param1:int) : Boolean
      {
         if(param1 == 10004 || param1 == 10005)
         {
            return true;
         }
         return false;
      }
      
      public static function checkIsNoviceCityMap(param1:int) : Boolean
      {
         if(param1 == 10003)
         {
            return true;
         }
         return false;
      }
      
      public static function checkVehicleMap(param1:int) : Boolean
      {
         return param1 == 3001;
      }
      
      public static function checkPetLand(param1:int) : Boolean
      {
         return param1 > 20000 && param1 <= 25000;
      }
      
      public static function checkMineral(param1:int) : Boolean
      {
         return param1 == 30000 || param1 == 30001;
      }
      
      public static function checkMineralPVP(param1:int) : Boolean
      {
         return param1 == 30001;
      }
      
      public static function checkMineralNoPVP(param1:int) : Boolean
      {
         return param1 == 3000;
      }
      
      public static function checkSvs(param1:int) : Boolean
      {
         return param1 == 5401;
      }
      
      public static function checkDuskArea(param1:int) : Boolean
      {
         return param1 == 4901;
      }
      
      public static function checkFlameTemple(param1:int) : Boolean
      {
         return param1 == 4101;
      }
      
      public static function checkIceFireTemple(param1:int) : Boolean
      {
         return param1 == 4701;
      }
      
      public static function checkSumCampaign(param1:int) : Boolean
      {
         return param1 >= 6001 && param1 <= 6009;
      }
      
      public static function checkInPetBossFloor(param1:int) : Boolean
      {
         return param1 == CampaignManager.instance.petBossModel.mapId && CampaignManager.instance.petBossModel.isOpen;
      }
      
      public static function checkInQuizActivity(param1:int) : Boolean
      {
         return param1 == 5101;
      }
      
      public static function checkMonopoly(param1:int) : Boolean
      {
         return param1 == 5201;
      }
      
      public static function checkConsortiaEmeDream(param1:int) : Boolean
      {
         return param1 == 7701;
      }
      
      public static function checkTrialTower(param1:int) : Boolean
      {
         return param1 == 8201;
      }
      
      public static function checkBloody(param1:int) : Boolean
      {
         return param1 == 9996;
      }
      
      public static function checkMarket(param1:int) : Boolean
      {
         return param1 == 5801;
      }
      
      public static function checkGroupfb(param1:int) : Boolean
      {
         return param1 == 2291 || param1 == 2292 || param1 == 2293 || param1 == 2294;
      }
      
      public static function checkFarm(param1:int) : Boolean
      {
         return param1 >= 5501 && param1 <= 5505;
      }
      
      public static function checkSacrificeRoom(param1:int) : Boolean
      {
         return param1 == 9995;
      }
      
      public static function checkUnrealShooting(param1:int) : Boolean
      {
         if(param1 == 5703)
         {
            return true;
         }
         return false;
      }
      
      public static function checkGodsEvening(param1:int) : Boolean
      {
         return param1 == 8501;
      }
      
      public static function getCampaignTips() : String
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            if(SceneManager.instance.currentType == "PLANES_WAR_SCENE")
            {
               return LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip100");
            }
            if(CrossGuildManager.instance.model.isInCrossGuildWar)
            {
               return LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.inCrossGuildWar.alert");
            }
            if(FrameControllerManager.instance.outyardControler.isOutyardMapApply)
            {
               return LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.isOutyardMapApply.alert");
            }
            if(SceneManager.instance.currentType == "SANDBOX_SCENE")
            {
               return LanguageMgr.GetTranslation("sandbox.scence.skipTip");
            }
            if(SceneManager.instance.currentType == "PLANE_CRISRIS")
            {
               return LanguageMgr.GetTranslation("planeCrisis.inPlaneCrisisScene");
            }
            if(SceneManager.instance.currentType == "UNREAL_SHOOTING_ROOM")
            {
               return LanguageMgr.GetTranslation("colosseum.view.ColosseumListView.command03");
            }
            if(SceneManager.instance.currentType == "SECRET_ADVENTURE_SCENE")
            {
               return LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip06");
            }
            if(SceneManager.instance.currentType == "THESE_PVP_SCENE")
            {
               return LanguageMgr.GetTranslation("ChatOutputViewII.inThesepvp.alert");
            }
            if(SceneManager.instance.currentType == "THESE_Double_PVP_SCENE")
            {
               return LanguageMgr.GetTranslation("ChatOutputViewII.inTheseMultipvp.alert");
            }
            if(SceneManager.instance.currentType == "SECRET_WAR_SCENE")
            {
               return LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip06");
            }
            if(SceneManager.instance.currentType == "SECRET_WAR_SCENE")
            {
               return LanguageMgr.GetTranslation("ChatOutputViewII.inChildNswar.alert");
            }
            return "";
         }
         var _loc2_:int = CampaignManager.instance.mapModel.mapId;
         if(WorldBossHelper.checkSumCampaign(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip6000");
         }
         else if(WorldBossHelper.checkMaze(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip03");
         }
         else if(WorldBossHelper.checkWorldBoss(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip04");
         }
         else if(WorldBossHelper.checkPvp(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip05");
         }
         else if(WorldBossHelper.checkDuskArea(_loc2_) || Boolean(WorldBossHelper.checkIceFireTemple(_loc2_)))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip16");
         }
         else if(WorldBossHelper.checkConsortiaSecretLand(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip08");
         }
         else if(WorldBossHelper.checkMineral(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip10");
         }
         else if(WorldBossHelper.checkFlameTemple(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip11");
         }
         else if(WorldBossHelper.checkSvs(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip14");
         }
         else if(WorldBossHelper.checkWedding(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip12");
         }
         else if(WorldBossHelper.checkMarket(_loc2_))
         {
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip15");
         }
         else
         {
            if(SceneManager.instance.currentType == "STARAREA_SCENE")
            {
               return LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip17");
            }
            _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip06");
         }
         return _loc1_;
      }
      
      public static function checkNeedShowChatPop(param1:int) : Boolean
      {
         if(WorldBossHelper.checkMonopoly(param1))
         {
            return false;
         }
         if(WorldBossHelper.checkMaze(param1))
         {
            return false;
         }
         if(WorldBossHelper.checkMaze2(param1))
         {
            return false;
         }
         if(WorldBossHelper.checkMaze3(param1))
         {
            return false;
         }
         if(param1 < 200)
         {
            return false;
         }
         return true;
      }
      
      public static function checkInHouse(param1:int) : Boolean
      {
         return param1 >= 5601 && param1 <= 5605;
      }
      
      public static function checkRapidMap(param1:int) : Boolean
      {
         return param1 == 4801;
      }
      
      public static function checkInHome(param1:int) : Boolean
      {
         return param1 >= 5501 && param1 <= 5505;
      }
      
      public static function checkActiveVehicle(param1:int) : Boolean
      {
         return param1 == ConfigInfoManager.instance.getActiveVehicleCampaignId();
      }
      
      public static function checkFantasyMatrix(param1:int) : Boolean
      {
         return param1 == 9997;
      }
      
      public static function checkDeepPrison(param1:int) : Boolean
      {
         return param1 == 6011 || param1 == 6021 || param1 == 6031;
      }
      
      public static function checkAirGarden(param1:int) : Boolean
      {
         return param1 == 7000;
      }
      
      public static function checkForbiddenBoss(param1:int) : Boolean
      {
         if(param1 > 31000 && param1 < 40000)
         {
            return true;
         }
         return false;
      }
      
      public static function checkThessBox(param1:int) : Boolean
      {
         if(param1 >= 40101 && param1 <= 43000)
         {
            return true;
         }
         return false;
      }
   }
}

