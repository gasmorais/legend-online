package ui.toptoolbar
{
   import flash.utils.Dictionary;
   import funny.datas.FunnyData;
   import managers.BottleManager;
   import managers.ChildManager;
   import managers.CustomizedVipManager;
   import managers.DarkMazeManager;
   import managers.DreamArenaManager;
   import managers.EncoGoldManager;
   import managers.ExchargeRankManager;
   import managers.FeedBackManager;
   import managers.FoisonHornManager;
   import managers.FundManager;
   import managers.FundVeinManager;
   import managers.FunnyManager;
   import managers.GameHallManager;
   import managers.KingbackManager;
   import managers.LotteryManager;
   import managers.LuckyLotteryManager;
   import managers.MailCheckManager;
   import managers.MarryManager;
   import managers.MonthCardManager;
   import managers.MvpShopManager;
   import managers.NewFirstPayManager;
   import managers.NewMemoryCardManager;
   import managers.OldBackerManager;
   import managers.PlatinumManager;
   import managers.PumpingJoyManager;
   import managers.QuestionManager;
   import managers.RavePartyManager;
   import managers.RemotePetManager;
   import managers.SaleManager;
   import managers.ShopManager;
   import managers.SlotManager;
   import managers.StokesOreManager;
   import managers.SuperSigninCardManager;
   import managers.WholeRebateManager;
   import managers.WishPoolManager;
   import managers.YearActiveManager;
   import mvc.module.discountshop.DiscountShopModel;
   import mvc.module.funny.FunnyModel;
   import mvc.module.godsevening.GodsEveningModel;
   import mvc.module.lottery.LotteryModel;
   import mvc.module.marry.MarryModel;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import mvc.module.outyard.OutyardModel;
   import mvc.module.questionnaire.QuestionnaireModel;
   import mvc.module.remotepet.RemotePetModel;
   import mvc.module.shop.ShopModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.TopToolBtnTempInfo;
   import yishi.manager.AllManExchangeManager;
   import yishi.manager.AnswerManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.ArtifactManager;
   import yishi.manager.CarnivalManager;
   import yishi.manager.ChargeLotteryManager;
   import yishi.manager.ChristmasManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.CultureActiveManager;
   import yishi.manager.DiscountShopManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.GoldenDionysiaManager;
   import yishi.manager.GoldenSheepManager;
   import yishi.manager.LuckyExchangeManager;
   import yishi.manager.NewYearActManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PandoraManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PublicChairsManager;
   import yishi.manager.PublicEggManager;
   import yishi.manager.QuestionnaireManager;
   import yishi.manager.RegistWelfareManager;
   import yishi.manager.SkyTreasureManager;
   import yishi.manager.SumCampaignManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   
   public class TopBtnCheckShowHelper
   {
      
      private static var _instance:TopBtnCheckShowHelper;
      
      private var _boxActiveList:Array = [];
      
      public function TopBtnCheckShowHelper()
      {
         super();
      }
      
      public static function get instance() : TopBtnCheckShowHelper
      {
         if(!_instance)
         {
            _instance = new TopBtnCheckShowHelper();
         }
         return _instance;
      }
      
      public function get allTempCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:Dictionary = TempleteManager.instance.topToolBtnTempCate.getTemplates();
         for each(var _loc3_:TopToolBtnTempInfo in _loc2_)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function get curShowList() : Array
      {
         var _loc3_:Array = [];
         _boxActiveList.length = 0;
         var _loc1_:Dictionary = TempleteManager.instance.topToolBtnTempCate.getTemplates();
         for each(var _loc2_:TopToolBtnTempInfo in _loc1_)
         {
            if(checkIsShow(_loc2_))
            {
               if(_loc2_.BoxTypeTo == 0)
               {
                  _loc3_.push(_loc2_);
               }
               else if(_loc2_.BoxTypeTo > 0)
               {
                  _boxActiveList.push(_loc2_);
               }
            }
         }
         _loc3_.sort(sortShow);
         _boxActiveList.sort(sortShow);
         return _loc3_;
      }
      
      public function get boxActiveList() : Array
      {
         return _boxActiveList;
      }
      
      private function sortShow(param1:TopToolBtnTempInfo, param2:TopToolBtnTempInfo) : int
      {
         if(param1.BtnKey == "mailcheck")
         {
            if(param2.BtnKey == "funny")
            {
               return 1;
            }
            return -1;
         }
         if(param2.BtnKey == "mailcheck")
         {
            if(param1.BtnKey == "funny")
            {
               return -1;
            }
            return 1;
         }
         var _loc3_:Boolean = param1.IsTimeTemp && param2.IsTimeTemp;
         if(_loc3_)
         {
            if(param1.isOpen && !param2.isOpen)
            {
               return -1;
            }
            if(!param1.isOpen && param2.isOpen)
            {
               return 1;
            }
            if(param1.isSignUpState && !param2.isSignUpState)
            {
               return -1;
            }
            if(!param1.isSignUpState && param2.isSignUpState)
            {
               return 1;
            }
            if(param1.isCanSignUp && !param2.isCanSignUp)
            {
               return -1;
            }
            if(!param1.isCanSignUp && param2.isCanSignUp)
            {
               return 1;
            }
            if(param1.Sort < param2.Sort)
            {
               return -1;
            }
            return 1;
         }
         if(param1.Sort < param2.Sort)
         {
            return -1;
         }
         return 1;
      }
      
      public function checkIsShow(param1:TopToolBtnTempInfo) : Boolean
      {
         var _loc2_:FunnyData = null;
         var _loc3_:FunnyData = null;
         if(!param1)
         {
            return false;
         }
         switch(param1.BtnKey)
         {
            case "funny":
               return thane.grades >= 6;
            case "first":
               return !playerInfo.isFirstCharge && thane.grades >= 6;
            case "pvp":
               return thane.grades >= 22;
            case "tiro":
               if(thane.grades >= 6 && playerModel.isOpenAct && playerModel.isEndAct && playerModel.openActivityDay >= 1 && playerModel.openActivityDay <= 7 && playerModel.isOpenAct["flag"] && playerModel.isEndAct["flag"])
               {
                  return true;
               }
               return false;
               break;
            case "online":
               return thane.grades >= 11 && funnyModel.findDataByType(14);
            case "timing":
               return thane.grades >= 11 && funnyModel.timingBagData;
            case "karneval":
               return thane.grades >= 11 && funnyModel.findDataByType(51);
            case "feedback":
               if(thane.grades >= 6 && FeedBackManager.instance.switchBtn1 && FeedBackManager.instance.data.endTime > playerModel.sysCurTimeBySecond && FeedBackManager.instance.data.startTime <= playerModel.sysCurTimeBySecond)
               {
                  return true;
               }
               return false;
               break;
            case "recharge":
               return thane.grades >= 11 && funnyModel.rechargeBagData && funnyModel.rechargeFlag;
            case "worldboss":
               return thane.grades >= 20;
            case "question":
               return thane.grades >= 20 && questionnaireModel.questionnaireVisible;
            case "crosspvpreward":
               return thane.grades >= 30 && playerInfo.canAcceptCrossScoreAward;
            case "matelords":
               return thane.grades >= 36 && VersionSwitch.MATE_LORDS;
            case "vehicel":
               return thane.grades >= 35;
            case "bottle":
               return thane.grades >= 11 && BottleManager.instance.openBottle;
            case "petweedreward":
               return thane.grades >= 50 && playerInfo.canAcceptPetChallWeekReward;
            case "fund":
               return FundManager.instance.getShowBtn();
            case "fundnewbie":
               return FundVeinManager.instance.isShowBtn;
            case "regression1":
               return FunnyManager.instance.backPlayerBtnEnable;
            case "regression2":
               return FunnyManager.instance.regressRewardBtnEnable;
            case "lottery":
               return thane.grades >= 10 && lotteryModel.info.isOpen;
            case "petboss":
               return thane.grades >= 50;
            case "limitbuy":
               return thane.grades >= 10 && shopModel.getTimeBuyList2() && shopModel.getTimeBuyList2().length > 0;
            case "crossgvg":
               return VersionSwitch.CROSS_GUILD && thane.grades >= 13 && checkIsRightScene() && CrossGuildManager.instance.model.state != 1;
            case "newyear":
               return thane.grades >= 11 && playerModel.isOpenNewYearAct && !NewYearActManager.instance.isGetOver;
            case "newyearlottery":
               return thane.grades >= 11 && playerModel.isOpenNewYearLottery;
            case "rvr1":
               return thane.grades >= 30;
            case "exchargeall":
               return thane.grades >= 20 && ExchargeRankManager.instance._isOpen;
            case "childArena":
               return thane.grades >= 70 && checkIsRightScene();
            case "blackjack":
               return thane.grades >= 6 && ConfigManager.info.BLACKJACK && playerModel.nowDate && ConfigManager.info.BLACKJACK_BEGIN_DATE && ConfigManager.info.BLACKJACK_END_DATE && ConfigManager.info.BLACKJACK_BEGIN_DATE.time <= playerModel.nowDate && playerModel.nowDate < ConfigManager.info.BLACKJACK_END_DATE.time;
            case "artifact":
               return thane.grades >= 11 && ArtifactManager.instance.openArtifact;
            case "registwelfare":
               return thane.grades >= 6 && RegistWelfareManager.instance.endDate && RegistWelfareManager.instance.endDate.time > playerModel.sysCurtime.time;
            case "poker":
               return thane.grades >= 6 && checkIsRightScene();
            case "regress":
               return thane.grades >= 6 && OldBackerManager.instance.model.openState == 1;
            case "bingo":
               return ConfigManager.info.BINGO && thane.grades >= 11 && playerModel.nowDate && ConfigManager.info.BINGO_BEGIN_DATE && ConfigManager.info.BINGO_END_DATE && ConfigManager.info.BINGO_BEGIN_DATE.time <= playerModel.nowDate && playerModel.nowDate < ConfigManager.info.BINGO_END_DATE.time;
            case "outyard":
               return thane.grades >= 13 && VersionSwitch.OUTYARD && outyardModel.stateMsg && SceneManager.instance.currentType == "SPACE_SCENE";
            case "outyardreward":
               return thane.grades >= 13 && VersionSwitch.OUTYARD && outyardModel.reward.length && checkIsRightScene();
            case "continuepayrrbate":
               return thane.grades > 6 && funnyModel.continuePayRebateData && funnyModel.continuePayRebateData.bagList.length > 0 && funnyModel.continuePayRebateChestData.length > 0 && funnyModel.continuePayRebateChestData[0].showStart <= playerModel.nowDate && funnyModel.continuePayRebateChestData[0].showEnd >= playerModel.nowDate;
            case "auctionsale":
               return thane.grades >= 35 && checkIsRightScene() && SaleManager.instance.model.isOpen;
            case "mailcheck":
               return false;
            case "crosscost":
               _loc2_ = funnyModel.findDataByType(73);
               _loc3_ = funnyModel.findDataByType(197);
               return thane.grades >= 20 && (_loc2_ || _loc3_);
            case "luckyexchange":
               return thane.grades >= 6 && LuckyExchangeManager.instance.showData.length > 0;
            case "discountshop":
               return VersionSwitch.DISCOUNT_SHOP_SWITCH && discountModel.showTopIcon;
            case "daylight":
               return ArmyManager.instance.thane.grades >= 13 && VersionSwitch.ICON_DAYLIAHGT;
            case "giftwill":
               return thane.grades >= 32;
            case "publicchairs":
               return thane.grades >= 6 && PublicChairsManager.instance.openChairs;
            case "cultureactive":
               return thane.grades >= 11 && CultureActiveManager.instance.openCultureActive;
            case "goldendionysia":
               return thane.grades >= 6 && GoldenDionysiaManager.instance.openGoldenDionysia;
            case "publicegg_total":
               return thane.grades >= 6 && PublicEggManager.instance.openEggGift;
            case "publicegg_egg":
               return thane.grades >= 6 && PublicEggManager.instance.openEgg;
            case "publicegg_sumgift":
               return thane.grades >= 6 && PublicEggManager.instance.openGift;
            case "sumcampaign":
               return thane.grades >= 6 && SumCampaignManager.instance.openSumCampaign;
            case "pandora":
               return thane.grades >= 6 && PandoraManager.instance.openPandora;
            case "chargelottery":
               return thane.grades >= 11 && ChargeLotteryManager.instance.openChargeLottery;
            case "goldroad":
               return thane.grades >= 18 && checkIsRightScene() && ConfigManager.info.GOLDROAD && playerModel.nowDate && ConfigManager.info.GOLDROAD_BEGIN_DATE.time && ConfigManager.info.GOLDROAD_END_DATE.time && ConfigManager.info.GOLDROAD_BEGIN_DATE.time <= playerModel.nowDate && playerModel.nowDate < ConfigManager.info.GOLDROAD_END_DATE.time;
            case "loginactive":
               return funnyModel.loginActiveData && checkIsRightScene();
            case "slot":
               return thane.grades > 11 && SlotManager.Instance.model.isOpen && checkIsRightScene();
            case "answer":
               return AnswerManager.Instance.isOpen();
            case "renotereward":
               return remoteModel.lastOrder > 0 && !remoteModel.isGet;
            case "hallfame":
               return funnyModel.findDataByType(146) && checkIsRightScene();
            case "crossmuticampaign":
               return thane.grades >= 20;
            case "wedding":
               return thane.grades >= 36 && marryModel.selfMarryInfo.state == 3 && marryTimeCheck();
            case "areslords":
               return thane.grades >= 36;
            case "braveleg":
               return thane.grades >= 40 && checkIsRightScene();
            case "raveparty":
               return thane.grades >= 11 && RavePartyManager.instance.model.openState == 1;
            case "encoGold":
               return thane.grades >= 6 && EncoGoldManager.instance.model.isOpen;
            case "childarenareward":
               return ChildManager.instance.arenaModel.hasReward;
            case "unrealshooting":
               return thane.grades >= 1 && VersionSwitch.UNREALSHOOTING && checkIsRightScene() && VersionSwitch.UNREALSHOOTING;
            case "pumpingjoy":
               return thane.grades >= 16 && PumpingJoyManager.instance.model.isOpen && VersionSwitch.PUMPING_JOY;
            case "godsevening":
               return godsEveningModel.isShowIcon && thane.vocationGrades > 0 && VersionSwitch.GODS_EVENING && checkIsRightScene();
            case "wholerebate":
               return WholeRebateManager.instance.model.isOpen;
            case "magicspring":
               return VersionSwitch.MAGIC_SPRING && thane.grades >= ConfigInfoManager.instance.getMagicSpringOpenGrade();
            case "monthcard":
               return VersionSwitch.MONTH_CARD && MonthCardManager.instance.model.isOpen;
            case "foisonhorn":
               return VersionSwitch.FOISON_HORN && FoisonHornManager.instance.model.isOpen;
            case "goldensheep":
               return VersionSwitch.GOLDEN_SHEEP && GoldenSheepManager.instance.model.topBtnShow;
            case "landmine":
               return VersionSwitch.LANDMINE && thane.vocationGrades > 0 && checkIsRightScene();
            case "mvpshop":
               return VersionSwitch.MVP_SHOP && MvpShopManager.instance.model.isOpen;
            case "apex":
               return VersionSwitch.APEX && thane.grades >= 80;
            case "luckylottery":
               return VersionSwitch.LUCKY_LOTTERY && LuckyLotteryManager.instance.model.openLuckyLottery;
            case "dreamarena":
               return VersionSwitch.DREAM_ARENA && DreamArenaManager.instance.model.isShow && checkIsRightScene();
            case "stokesore":
               return VersionSwitch.STOKES_ORE && StokesOreManager.instance.model.openStokesOre;
            case "gamehall":
               return GameHallManager.instance.model.eastIsOpen;
            case "wishpool":
               return WishPoolManager.instance.model.wishPoolIsOpen;
            case "supersignincard":
               return SuperSigninCardManager.instance.model.isOpen;
            case "kingback":
               return KingbackManager.instance.isOpen == 1;
            case "sevenyear":
               return YearActiveManager.ins.isOpen;
            case "allmanexchange":
               return AllManExchangeManager.instance.model.isopen;
            case "platinum":
               return thane.grades >= 11 && PlatinumManager.instance.openBottle;
            case "platinum":
               return thane.grades >= 11 && PlatinumManager.instance.openBottle;
            case "customizedvip":
               return thane.grades > 1 && CustomizedVipManager.instance.model.isOpen;
            case "darkmaze":
               return DarkMazeManager.instance.model.darkMazeIsOpen && !YearActiveManager.ins.isOpen;
            case "timebox1":
               return thane.grades > 1 && checkIsRightScene();
            case "newfirstpay":
               return NewFirstPayManager.instance.model.isOpen && thane.grades >= 6;
            case "newquestion":
               return QuestionManager.instance.model.isOpen;
            case "newmemorycard":
               return NewMemoryCardManager.instance.model.isOpen && checkIsRightScene();
            case "carnival":
               return CarnivalManager.Instance.isOpen;
            case "sqmomery":
               return ConfigManager.info.SQ_MEMORY && thane.grades >= 80 && playerModel.nowDate && ConfigManager.info.SQ_MEMORY_START.time && ConfigManager.info.SQ_MEMORY_END.time && ConfigManager.info.SQ_MEMORY_START.time <= playerModel.nowDate && playerModel.nowDate < ConfigManager.info.SQ_MEMORY_END.time;
            case "oldplayerreturn":
               return oldPlayerReturnModel.status == 1 && (oldPlayerReturnModel.isOpen || oldPlayerReturnModel.isShopOpen) && oldPlayerReturnModel.isReturnPlayer;
            case "oldplayerreturn2":
               return oldPlayerReturnModel.status == 1 && (oldPlayerReturnModel.isOpen || oldPlayerReturnModel.isShopOpen) && !oldPlayerReturnModel.isReturnPlayer;
            case "secretwar":
               return VersionSwitch.SECRET_WAR;
            case "christmas":
               return VersionSwitch.CHRISTMAS && ChristmasManager.instance.model.isOpen;
            case "skytreasure1":
               return SkyTreasureManager.Instance.modelNew.getAllSkyTreasureFrameOpenActTempData().length > 0;
            default:
               return false;
         }
      }
      
      private function get oldPlayerReturnModel() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      private function get godsEveningModel() : GodsEveningModel
      {
         return GodsEveningManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get funnyModel() : FunnyModel
      {
         return FunnyManager.instance.model;
      }
      
      private function get questionnaireModel() : QuestionnaireModel
      {
         return QuestionnaireManager.instance.model;
      }
      
      private function get shopModel() : ShopModel
      {
         return ShopManager.Instance.model;
      }
      
      private function get lotteryModel() : LotteryModel
      {
         return LotteryManager.Instance.model;
      }
      
      private function get outyardModel() : OutyardModel
      {
         return OutyardManager.instance.model;
      }
      
      private function get discountModel() : DiscountShopModel
      {
         return DiscountShopManager.instance.model;
      }
      
      private function get remoteModel() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function marryTimeCheck() : Boolean
      {
         return int(marryModel.selfMarryInfo.marriageTime) + 259200 > playerModel.sysCurTimeBySecond;
      }
      
      private function checkIsRightScene() : Boolean
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return true;
         }
         return false;
      }
   }
}

