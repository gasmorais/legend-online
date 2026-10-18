package yishi.datas.playerinfo
{
   import bag.events.BagEvent;
   import events.ConsortiaEvent;
   import flash.utils.ByteArray;
   import manager.ExternalInterfaceManager;
   import mvc.module.consortia.ConsortiaTemplete;
   import yishi.events.PlayerEvent;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class PlayerInfo extends SimplePlayerInfo
   {
      
      protected static const TIMEBOX_UPDATE:String = "TIMEBOX_UPDATE";
      
      protected static const RELOGINPROCESS_UPDATE:String = "RELOGINPROCESS_UPDATE";
      
      protected static const SEMINARY_EFFECT:String = "SEMINARY_EFFECT";
      
      protected static const BAG_CAPICITY:String = "BAG_CAPICITY";
      
      protected static const STAR_FREECOUNT:String = "STAR_FREECOUNT";
      
      protected static const STARBAG_CAPICITY:String = "STARBAG_CAPICITY";
      
      protected static const STAR_POINT:String = "STAR_POINT";
      
      protected static const SIGNSITE_CHANGE:String = "SIGNSITE_CHANGE";
      
      protected static const COMPOSE_LIST:String = "COMPOSE_LIST";
      
      protected static const POINT:String = "POINT";
      
      protected static const WEARY:String = "WEARY";
      
      protected static const FIRSTCHARGE:String = "FIRSTCHARGE";
      
      protected static const KINGBUFF:String = "KINGBUFF";
      
      protected static const WORLDPROSPERITY:String = "WORLDPROSPERITY";
      
      protected static const GVGISOPEN:String = "GVGISOPEN";
      
      protected static const MINERAL:String = "MINERAL";
      
      protected static const WORLDBOSSSTATE:String = "WORLDBOSSSTATE";
      
      protected static const ISPVPSTART:String = "ISPVPSTART";
      
      protected static const PVP_WAR_COUNT:String = "PVP_WAR_COUNT";
      
      protected static const SEEK_SURPLUS_TIME:String = "SEEK_SURPLUS_TIME";
      
      protected static const ISVEHICLESTART:String = "ISVEHICLESTART";
      
      protected static const VEHICLE_GP:String = "VEHICLE_GP";
      
      protected static const VEHICLE_SCORE:String = "VEHICLE_SCORE";
      
      protected static const VEHICLE_LIST:String = "VEHICLE_LIST";
      
      protected static const CROSSGUILD_SCORE:String = "CROSSGUILD_SCORE";
      
      protected static const CROSSLEAGUE_SCORE:String = "CROSSLEAGUE_SCORE";
      
      protected static const RENTAL_BAG_STATUS:String = "RENTAL_BAG_TIME";
      
      protected static const PROFICIENCY:String = "PROFICIENCY";
      
      protected static const LIFESKILLID:String = "LIFESKILLID";
      
      protected static const LIFESKILLGRADE:String = "LIFESKILLGRADE";
      
      protected static const LIFESKILLCAMPAIGNID:String = "LIFESKILLCAMPAIGNID";
      
      protected static const FREESKILLTIME:String = "FREESKILLTIME";
      
      protected static const TIME_VORTEX_COUNT:String = "TIME_VORTEX_COUNT";
      
      protected static const TIME_VORTEX_NODE:String = "TIME_VORTEX_NODE";
      
      protected static const TIME_VORTEX_CAPTURE:String = "TIME_VORTEX_CAPTURE";
      
      protected static const TIME_VORTEX_CRACK:String = "TIME_VORTEX_CRACK";
      
      protected static const TIME_VORTEX_REVENGE:String = "TIME_VORTEX_REVENGE";
      
      public static const WEARY_MAX:int = 200;
      
      public static const WEARY_GET_MAX:int = 600;
      
      public static const RENTAL_BAG_OPEN_CONDITION:int = 224;
      
      public static const PLAYER_BAG_MAX_1:int = 273;
      
      public static const PLAYER_BAG_MAX_2:int = 322;
      
      public static const PLAYER_BAG_PAGE_MAX:int = 6;
      
      public static const VOCATION_LEVEL_MAX:int = 8;
      
      public static const STORE_BAG_MAX:int = 280;
      
      public static const VOCATION_GRADE_MAX:int = 80;
      
      public static const TALENT_GRADE_MAX:int = 179;
      
      public static const ADV_TALENT_GRADE_MAX:int = 50;
      
      public static const REFRESH_trialTower_RESTNUM:String = "REFRESH_trialTower_RESTNUM";
      
      public static const REFRESH_darkKIng_RESTNUM:String = "REFRESH_darkKIng_RESTNUM";
      
      public static const REFRESH_raceAgainst_RESTNUM:String = "REFRESH_raceAgainst_RESTNUM";
      
      public static const REFRESH_ELEMENTSILVA_NUM:String = "REFRESH_ELEMENTSILVA_NUM";
      
      private var _campaignSite:String;
      
      private var _questSite:ByteArray;
      
      private var _point:int;
      
      private var _giftToken:int;
      
      public var lastAward:Date;
      
      public var renames:Boolean;
      
      public var crystals:int;
      
      public var resourceMax:int;
      
      private var _trialTowerCampaignCount:int;
      
      public var trialTowerCampaignMaxCount:int;
      
      public var castleOrder:int;
      
      private var _weary:int;
      
      public var wearyLimit:int;
      
      public var refuseFriend:Boolean;
      
      public var refuseInvite:Boolean;
      
      public var refuseTeamInvite:Boolean;
      
      public var showVersion:Boolean;
      
      public var showStory:Boolean;
      
      public var showStoryModule:int;
      
      public var isChallReward:Boolean;
      
      private var _isGetKingBuffer:Boolean;
      
      public var canAcceptCrossScoreAward:Boolean;
      
      public var crossScore:int;
      
      public var pokerScore:int;
      
      public var pokerCorn:int;
      
      public var isReceived:Boolean;
      
      public var mineral:int;
      
      public var canAcceptPetChallWeekReward:Boolean;
      
      public var randomBossCount:int;
      
      public var randomBossMaxCount:int;
      
      public var lifeSKillProficiency:String = "";
      
      public var lifeSkillId:String = "";
      
      public var lifeSKillGrade:String = "";
      
      public var lifeSKillComposeNum:int;
      
      public var lifeSKillCollectNum:int;
      
      public var liftComposeId:String = "";
      
      public var teamCount:int;
      
      public var teamMaxCount:int;
      
      public var tailaCount:int;
      
      public var tailaMaxCount:int;
      
      public var wasteCount:int;
      
      public var wasteMaxCount:int;
      
      public var petPveCount:int;
      
      public var petPveMaxCount:int;
      
      public var childWarCount:int;
      
      public var childWarMaxCount:int;
      
      public var deepPrisonMaxCount:int;
      
      public var deepPrisonCount:int;
      
      public var darkKingMaxCount:int;
      
      private var _darkKIngLeftCount:int;
      
      public var skyStepCount:int;
      
      public var skyStepMaxCount:int;
      
      public var raceAgainstTimeMaxCount:int;
      
      private var _raceAgainstTimeLeftCount:int;
      
      public var elementSilvaMaxCount:int;
      
      public var isOpenTopTool:Boolean = false;
      
      public var jumpNovice:Boolean = false;
      
      private var _seekSurplusTime:int;
      
      public var groupId:int = 0;
      
      public var stoneBagCount:int = 0;
      
      public var tramcarCount:int = 0;
      
      private var _crossGuildScore:int = 0;
      
      private var _crossLeagueMedal:int = 0;
      
      public var _rentalBagTime:String;
      
      private var _rentalBagStatus:int;
      
      private var _timeVortexCount:int = 0;
      
      private var _timeVortexNode:int = -1;
      
      private var _timeVortexCapture:int;
      
      private var _timeVortexCrack:int;
      
      private var _timeVortexRevenge:int;
      
      public var timeVortexRevengeTime:String;
      
      public var faterotaryCount:int = 0;
      
      private var _warFieldCount:int;
      
      private var _vehicleGp:int;
      
      private var _vehicleScore:int;
      
      private var _vehicleList:Array = [];
      
      public var diamondIndex:int;
      
      public var isFirstSeminary:Boolean = true;
      
      public var iscost:Boolean = false;
      
      public var leadExtractTimes:int = 0;
      
      public var isOpenCrossMutiCampaign:Boolean = false;
      
      public var prayStatus:int;
      
      public var lordTrialKeyCount:int;
      
      public var prayCount:int;
      
      public var sacrificeCount:int;
      
      public var lordTrialCard:String;
      
      public var hpPrecent:int;
      
      public var petId:int;
      
      public var childPetId:int;
      
      public var secondChildPetId:int;
      
      public var childId:int;
      
      public var secondChildId:int;
      
      public var currentType:int = -1;
      
      public var currentIndex:int = 0;
      
      public var sweepIndex:int;
      
      public var maxIndex:Array = [0,0,0];
      
      public var order:Array = [0,0,0];
      
      public var itemTempIds:String;
      
      public var debuffer:Array;
      
      public var consortiaBossCount:int;
      
      public var isFirstOpenBagFrame:Boolean = true;
      
      private var _elementSilvaLeftCount:int;
      
      private var _isFirstCharge:Boolean = false;
      
      public var consortiaDefence:int;
      
      private var _consortiaPower:int;
      
      private var _consortiaAgility:int;
      
      private var _consortiaIntellect:int;
      
      private var _consortiaCaptain:int;
      
      private var _consortiaGold:int;
      
      private var _consortiaPhysique:int;
      
      private var _newPowerLv:int;
      
      private var _newAgilityLv:int;
      
      private var _newIntellectLv:int;
      
      private var _newPhysiqueLv:int;
      
      private var _famGpLv:int;
      
      private var _medalLv:int;
      
      private var _honorLv:int;
      
      private var _propertyLv:int;
      
      private var _masterPowerLv:int;
      
      private var _masterAgilityLv:int;
      
      private var _masterIntellectLv:int;
      
      private var _masterPhysiqueLv:int;
      
      private var _runeCount:int;
      
      private var _runePowerPoint:int;
      
      public var op:int;
      
      public var gradeProcess:int;
      
      private var _timeProcess:int;
      
      private var _timeGet:Boolean;
      
      private var _isCost:Boolean;
      
      private var _lastFreeSkillLearnTime:String;
      
      private var _timeRun:Number;
      
      private var _reloginProcess:int;
      
      private var _seminaryEffect:int;
      
      public var seminaryMax:int;
      
      public var seminaryCount:int;
      
      public var reloginCount:int;
      
      public var totalGP:Number;
      
      public var signDate:Date;
      
      public var signTimes:int;
      
      private var _signSite:int;
      
      public var bagDefaultCount:int = 42;
      
      private var _bagCount:int = 0;
      
      private var _starFreeCount:int;
      
      private var _starBagCount:int;
      
      private var _starPoint:int;
      
      public var demonConsortiaId:int;
      
      private var _composeList:Array;
      
      public var addCompose:Array;
      
      private var _noviceProcess:int;
      
      private var _worldProsperity:int;
      
      private var _worldbossState:Boolean;
      
      private var _isPVPStart:Boolean;
      
      private var _isVehicleStart:Boolean;
      
      public var hasVicePassword:int;
      
      public var isDuringResetTime:int;
      
      public var godDiamond:int;
      
      public var needViceGuild:Boolean = false;
      
      public var needShowReward:Boolean = false;
      
      protected const RUNE_COUNT:String = "RUNE_COUNT";
      
      protected const RUNPOWER_POINT:String = "RUNPOWER_POINT";
      
      public function PlayerInfo()
      {
         super();
      }
      
      public function set trialTowerCampaignCount(param1:int) : void
      {
         if(_trialTowerCampaignCount == param1)
         {
            return;
         }
         _trialTowerCampaignCount = param1;
         NotificationManager.instance.sendNotification("REFRESH_trialTower_RESTNUM");
      }
      
      public function get trialTowerCampaignCount() : int
      {
         return _trialTowerCampaignCount;
      }
      
      public function set darkKIngLeftCount(param1:int) : void
      {
         if(_darkKIngLeftCount == param1)
         {
            return;
         }
         _darkKIngLeftCount = param1;
         NotificationManager.instance.sendNotification("REFRESH_darkKIng_RESTNUM");
      }
      
      public function get darkKIngLeftCount() : int
      {
         return _darkKIngLeftCount;
      }
      
      public function set raceAgainstTimeLeftCount(param1:int) : void
      {
         if(_raceAgainstTimeLeftCount == param1)
         {
            return;
         }
         _raceAgainstTimeLeftCount = param1;
         NotificationManager.instance.sendNotification("REFRESH_raceAgainst_RESTNUM");
      }
      
      public function get raceAgainstTimeLeftCount() : int
      {
         return _raceAgainstTimeLeftCount;
      }
      
      public function get warFieldCount() : int
      {
         return _warFieldCount;
      }
      
      public function set warFieldCount(param1:int) : void
      {
         if(_warFieldCount != param1)
         {
            _warFieldCount = param1;
            _changeObj["PVP_WAR_COUNT"] = true;
         }
      }
      
      public function set elementSilvaLeftCount(param1:int) : void
      {
         if(_elementSilvaLeftCount == param1)
         {
            return;
         }
         _elementSilvaLeftCount = param1;
         NotificationManager.instance.sendNotification("REFRESH_ELEMENTSILVA_NUM");
      }
      
      public function get elementSilvaLeftCount() : int
      {
         return _elementSilvaLeftCount;
      }
      
      public function get seekSurplusTime() : int
      {
         return _seekSurplusTime;
      }
      
      public function set seekSurplusTime(param1:int) : void
      {
         if(_seekSurplusTime != param1)
         {
            _seekSurplusTime = param1;
            _changeObj["SEEK_SURPLUS_TIME"] = true;
         }
      }
      
      public function get isGetKingBuffer() : Boolean
      {
         return _isGetKingBuffer;
      }
      
      public function set isGetKingBuffer(param1:Boolean) : void
      {
         if(_isGetKingBuffer != param1)
         {
            _isGetKingBuffer = param1;
            _changeObj["KINGBUFF"] = true;
         }
      }
      
      public function get isFirstCharge() : Boolean
      {
         return _isFirstCharge;
      }
      
      public function set isFirstCharge(param1:Boolean) : void
      {
         if(_isFirstCharge != param1)
         {
            _isFirstCharge = param1;
            _changeObj["FIRSTCHARGE"] = true;
         }
      }
      
      public function get weary() : int
      {
         return _weary;
      }
      
      public function set weary(param1:int) : void
      {
         if(_weary != param1)
         {
            _weary = param1;
            _changeObj["WEARY"] = true;
         }
      }
      
      public function get giftToken1() : int
      {
         return _giftToken;
      }
      
      public function get giftToken() : int
      {
         return _giftToken < 0 ? 0 : _giftToken;
      }
      
      public function set giftToken(param1:int) : void
      {
         if(_giftToken != param1)
         {
            _giftToken = param1;
            _changeObj["POINT"] = true;
         }
      }
      
      public function get point() : int
      {
         return _point;
      }
      
      public function set point(param1:int) : void
      {
         if(_point != param1)
         {
            _point = param1;
            _changeObj["POINT"] = true;
         }
      }
      
      public function get allPoint() : int
      {
         return point + giftToken;
      }
      
      public function get masterPowerLv() : int
      {
         return _masterPowerLv;
      }
      
      public function set masterPowerLv(param1:int) : void
      {
         if(_masterPowerLv == param1)
         {
            return;
         }
         _masterPowerLv = param1;
         updateConstiaStudy(param1,22);
      }
      
      public function get masterAgilityLv() : int
      {
         return _masterAgilityLv;
      }
      
      public function set masterAgilityLv(param1:int) : void
      {
         if(_masterAgilityLv == param1)
         {
            return;
         }
         _masterAgilityLv = param1;
         updateConstiaStudy(param1,23);
      }
      
      public function get masterIntellectLv() : int
      {
         return _masterIntellectLv;
      }
      
      public function set masterIntellectLv(param1:int) : void
      {
         if(_masterIntellectLv == param1)
         {
            return;
         }
         _masterIntellectLv = param1;
         updateConstiaStudy(param1,24);
      }
      
      public function get masterPhysiqueLv() : int
      {
         return _masterPhysiqueLv;
      }
      
      public function set masterPhysiqueLv(param1:int) : void
      {
         if(_masterPhysiqueLv == param1)
         {
            return;
         }
         _masterPhysiqueLv = param1;
         updateConstiaStudy(param1,25);
      }
      
      public function get propertyLv() : int
      {
         return _propertyLv;
      }
      
      public function set propertyLv(param1:int) : void
      {
         if(_propertyLv == param1)
         {
            return;
         }
         _propertyLv = param1;
         updateConstiaStudy(param1,21);
      }
      
      public function get honorLv() : int
      {
         return _honorLv;
      }
      
      public function set honorLv(param1:int) : void
      {
         if(_honorLv == param1)
         {
            return;
         }
         _honorLv = param1;
         updateConstiaStudy(param1,19);
      }
      
      public function get medalLv() : int
      {
         return _medalLv;
      }
      
      public function set medalLv(param1:int) : void
      {
         if(_medalLv == param1)
         {
            return;
         }
         _medalLv = param1;
         updateConstiaStudy(param1,18);
      }
      
      public function get famGpLv() : int
      {
         return _famGpLv;
      }
      
      public function set famGpLv(param1:int) : void
      {
         if(_famGpLv == param1)
         {
            return;
         }
         _famGpLv = param1;
         updateConstiaStudy(param1,17);
      }
      
      public function get newPhysiqueLv() : int
      {
         return _newPhysiqueLv;
      }
      
      public function set newPhysiqueLv(param1:int) : void
      {
         if(_newPhysiqueLv == param1)
         {
            return;
         }
         _newPhysiqueLv = param1;
         updateConstiaStudy(param1,16);
      }
      
      public function get newIntellectLv() : int
      {
         return _newIntellectLv;
      }
      
      public function set newIntellectLv(param1:int) : void
      {
         if(_newIntellectLv == param1)
         {
            return;
         }
         _newIntellectLv = param1;
         updateConstiaStudy(param1,15);
      }
      
      public function get newAgilityLv() : int
      {
         return _newAgilityLv;
      }
      
      public function set newAgilityLv(param1:int) : void
      {
         if(_newAgilityLv == param1)
         {
            return;
         }
         _newAgilityLv = param1;
         updateConstiaStudy(param1,14);
      }
      
      public function get newPowerLv() : int
      {
         return _newPowerLv;
      }
      
      public function set newPowerLv(param1:int) : void
      {
         if(_newPowerLv == param1)
         {
            return;
         }
         _newPowerLv = param1;
         updateConstiaStudy(param1,13);
      }
      
      public function get consortiaPower() : int
      {
         return _consortiaPower;
      }
      
      public function set consortiaPower(param1:int) : void
      {
         if(_consortiaPower == param1)
         {
            return;
         }
         _consortiaPower = param1;
         updateConstiaStudy(param1,6);
      }
      
      public function get consortiaAgility() : int
      {
         return _consortiaAgility;
      }
      
      public function set consortiaAgility(param1:int) : void
      {
         if(_consortiaAgility == param1)
         {
            return;
         }
         _consortiaAgility = param1;
         updateConstiaStudy(param1,8);
      }
      
      public function get consortiaIntellect() : int
      {
         return _consortiaIntellect;
      }
      
      public function set consortiaIntellect(param1:int) : void
      {
         if(_consortiaIntellect == param1)
         {
            return;
         }
         _consortiaIntellect = param1;
         updateConstiaStudy(param1,9);
      }
      
      public function get consortiaCaptain() : int
      {
         return _consortiaCaptain;
      }
      
      public function set consortiaCaptain(param1:int) : void
      {
         if(_consortiaCaptain == param1)
         {
            return;
         }
         _consortiaCaptain = param1;
         updateConstiaStudy(param1,10);
      }
      
      public function get consortiaGold() : int
      {
         return _consortiaGold;
      }
      
      public function set consortiaGold(param1:int) : void
      {
         if(_consortiaGold == param1)
         {
            return;
         }
         _consortiaGold = param1;
         updateConstiaStudy(param1,11);
      }
      
      public function get consortiaPhysique() : int
      {
         return _consortiaPhysique;
      }
      
      public function set consortiaPhysique(param1:int) : void
      {
         if(_consortiaPhysique == param1)
         {
            return;
         }
         _consortiaPhysique = param1;
         updateConstiaStudy(param1,12);
      }
      
      private function updateConstiaStudy(param1:int, param2:int) : void
      {
         if(param1 == 1)
         {
            dispatchEvent(new ConsortiaEvent("CONSORTIA_STUDY",param2));
         }
         else
         {
            dispatchEvent(new ConsortiaEvent("CONSORTIA_STUDY_UPGRADE",param2));
         }
      }
      
      public function get timeProgress() : int
      {
         return _timeProcess;
      }
      
      public function set timeProgress(param1:int) : void
      {
         if(param1 != _timeProcess)
         {
            _timeProcess = param1;
            _changeObj["TIMEBOX_UPDATE"] = true;
            isOpenTopTool = true;
         }
      }
      
      public function get timeGet() : Boolean
      {
         return _timeGet;
      }
      
      public function set timeGet(param1:Boolean) : void
      {
         if(param1 != _timeGet)
         {
            _timeGet = param1;
            _changeObj["TIMEBOX_UPDATE"] = true;
         }
      }
      
      public function get isCost() : Boolean
      {
         return _isCost;
      }
      
      public function set isCost(param1:Boolean) : void
      {
         if(param1 != _isCost)
         {
            _isCost = param1;
         }
      }
      
      public function set lastFreeSkillLearnTime(param1:String) : void
      {
         if(param1 != _lastFreeSkillLearnTime)
         {
            _changeObj["FREESKILLTIME"] = true;
            _lastFreeSkillLearnTime = param1;
         }
      }
      
      public function get lastFreeSkillLearnTime() : String
      {
         return _lastFreeSkillLearnTime;
      }
      
      public function get timeRun() : Number
      {
         return _timeRun;
      }
      
      public function set timeRun(param1:Number) : void
      {
         if(param1 != _timeRun)
         {
            _timeRun = param1;
            _changeObj["TIMEBOX_UPDATE"] = true;
         }
      }
      
      public function get reloginProcess() : int
      {
         return _reloginProcess;
      }
      
      public function set reloginProcess(param1:int) : void
      {
         if(param1 != _reloginProcess)
         {
            _reloginProcess = param1;
            _changeObj["RELOGINPROCESS_UPDATE"] = true;
            InfoTipsManager.instance.dealData(5);
         }
      }
      
      public function get seminaryEffect() : int
      {
         return _seminaryEffect;
      }
      
      public function set seminaryEffect(param1:int) : void
      {
         if(param1 != _seminaryEffect)
         {
            _seminaryEffect = param1;
            _changeObj["SEMINARY_EFFECT"] = true;
         }
      }
      
      public function set signSite(param1:int) : void
      {
         if(_signSite != param1)
         {
            _changeObj["SIGNSITE_CHANGE"] = true;
            _signSite = param1;
         }
      }
      
      public function get signSite() : int
      {
         return _signSite;
      }
      
      public function get bagCount() : int
      {
         return _bagCount;
      }
      
      public function set bagCount(param1:int) : void
      {
         if(_bagCount != param1)
         {
            _changeObj["BAG_CAPICITY"] = true;
            _bagCount = param1;
         }
      }
      
      public function set crossGuildScore(param1:int) : void
      {
         if(_crossGuildScore != param1)
         {
            _changeObj["CROSSGUILD_SCORE"] = true;
            _crossGuildScore = param1;
         }
      }
      
      public function get crossGuildScore() : int
      {
         return _crossGuildScore;
      }
      
      public function set crossLeagueMedal(param1:int) : void
      {
         if(_crossLeagueMedal != param1)
         {
            _changeObj["CROSSLEAGUE_SCORE"] = true;
            _crossLeagueMedal = param1;
         }
      }
      
      public function get crossLeagueMedal() : int
      {
         return _crossLeagueMedal;
      }
      
      public function set rentalBagTime(param1:String) : void
      {
         if(_rentalBagTime != param1)
         {
            _changeObj["RENTAL_BAG_TIME"] = true;
            _rentalBagTime = param1;
         }
      }
      
      public function get rentalBagTime() : String
      {
         return _rentalBagTime;
      }
      
      public function set rentalBagStatus(param1:int) : void
      {
         if(_rentalBagStatus != param1)
         {
            _changeObj["RENTAL_BAG_TIME"] = true;
            _rentalBagStatus = param1;
         }
      }
      
      public function get rentalBagStatus() : int
      {
         return _rentalBagStatus;
      }
      
      public function set timeVortexCount(param1:int) : void
      {
         if(_timeVortexCount != param1)
         {
            _changeObj["TIME_VORTEX_COUNT"] = true;
            _timeVortexCount = param1;
         }
      }
      
      public function get timeVortexCount() : int
      {
         return _timeVortexCount;
      }
      
      public function set timeVortexNode(param1:int) : void
      {
         if(_timeVortexNode != param1)
         {
            _changeObj["TIME_VORTEX_NODE"] = true;
            _timeVortexNode = param1;
         }
      }
      
      public function get timeVortexNode() : int
      {
         return _timeVortexNode;
      }
      
      public function set timeVortexCapture(param1:int) : void
      {
         if(_timeVortexCapture != param1)
         {
            _changeObj["TIME_VORTEX_CAPTURE"] = true;
            _timeVortexCapture = param1;
         }
      }
      
      public function get timeVortexCapture() : int
      {
         return _timeVortexCapture;
      }
      
      public function set timeVortexCrack(param1:int) : void
      {
         if(_timeVortexCrack != param1)
         {
            _changeObj["TIME_VORTEX_CRACK"] = true;
            _timeVortexCrack = param1;
         }
      }
      
      public function get timeVortexCrack() : int
      {
         return _timeVortexCrack;
      }
      
      public function set timeVortexRevenge(param1:int) : void
      {
         if(_timeVortexRevenge != param1)
         {
            _changeObj["TIME_VORTEX_REVENGE"] = true;
            _timeVortexRevenge = param1;
         }
      }
      
      public function get timeVortexRevenge() : int
      {
         return _timeVortexRevenge;
      }
      
      public function set starFreeCount(param1:int) : void
      {
         if(_starFreeCount != param1)
         {
            _starFreeCount = param1;
            _changeObj["STAR_FREECOUNT"] = true;
         }
      }
      
      public function get starFreeCount() : int
      {
         return _starFreeCount;
      }
      
      public function set starBagCount(param1:int) : void
      {
         if(_starBagCount != param1)
         {
            _changeObj["STARBAG_CAPICITY"] = true;
            _starBagCount = param1;
         }
      }
      
      public function get starBagCount() : int
      {
         return _starBagCount;
      }
      
      public function get starPoint() : int
      {
         return _starPoint;
      }
      
      public function set starPoint(param1:int) : void
      {
         if(_starPoint != param1)
         {
            _changeObj["STAR_POINT"] = true;
            _starPoint = param1;
         }
      }
      
      public function set composeList(param1:Array) : void
      {
         if(!_composeList)
         {
            _composeList = param1;
            _changeObj["COMPOSE_LIST"] = true;
         }
      }
      
      public function get composeList() : Array
      {
         return _composeList;
      }
      
      public function addComposeTemp(param1:Array) : void
      {
         if(!_composeList)
         {
            _composeList = param1;
            return;
         }
         addCompose = param1;
         for each(var _loc2_:int in param1)
         {
            _composeList.push(_loc2_);
            _changeObj["COMPOSE_LIST"] = true;
         }
      }
      
      public function get bagTotalCount() : int
      {
         if(rentalBagStatus == 1)
         {
            return bagCount + bagDefaultCount + 49;
         }
         if(rentalBagStatus == 2)
         {
            return bagCount + bagDefaultCount + 49 + 49;
         }
         return bagCount + bagDefaultCount;
      }
      
      public function get noviceProcess() : int
      {
         return _noviceProcess;
      }
      
      public function set noviceProcess(param1:int) : void
      {
         if(_noviceProcess == param1)
         {
            return;
         }
         _noviceProcess = param1;
         NotificationManager.instance.sendNotification("NEWBIE_PROCESS_UPDATE",_noviceProcess);
      }
      
      public function get campaignSite() : String
      {
         if(_campaignSite == null)
         {
            _campaignSite = "";
         }
         return _campaignSite;
      }
      
      public function isCompleteCampaign(param1:int) : Boolean
      {
         var _loc2_:Array = campaignSite.split(",");
         if(_loc2_.indexOf(param1) >= 0)
         {
            return true;
         }
         return false;
      }
      
      public function set campaignSite(param1:String) : void
      {
         if(_campaignSite != param1)
         {
            _campaignSite = param1;
         }
      }
      
      public function get questSite() : ByteArray
      {
         return _questSite;
      }
      
      public function set questSite(param1:ByteArray) : void
      {
         _questSite = param1;
      }
      
      public function set worldProsperity(param1:int) : void
      {
         if(_worldProsperity == param1)
         {
            return;
         }
         _worldProsperity = param1;
         _changeObj["WORLDPROSPERITY"] = true;
      }
      
      public function get worldProsperity() : int
      {
         return _worldProsperity;
      }
      
      public function set worldbossState(param1:Boolean) : void
      {
         if(_worldbossState != param1)
         {
            _changeObj["WORLDBOSSSTATE"] = true;
            _worldbossState = param1;
            if(param1 == true)
            {
               ExternalInterfaceManager.instance.initNews("12");
               isOpenTopTool = true;
            }
         }
      }
      
      public function get worldbossState() : Boolean
      {
         return _worldbossState;
      }
      
      public function set isPVPStart(param1:Boolean) : void
      {
         if(_isPVPStart != param1)
         {
            _changeObj["ISPVPSTART"] = true;
            _isPVPStart = param1;
            if(param1 == true)
            {
               ExternalInterfaceManager.instance.initNews("13");
               isOpenTopTool = true;
            }
         }
      }
      
      public function get isPVPStart() : Boolean
      {
         return _isPVPStart;
      }
      
      public function get isVehicleStart() : Boolean
      {
         return _isVehicleStart;
      }
      
      public function set isVehicleStart(param1:Boolean) : void
      {
         if(_isVehicleStart != param1)
         {
            _changeObj["ISVEHICLESTART"] = true;
            _isVehicleStart = param1;
            if(param1 == true)
            {
               ExternalInterfaceManager.instance.initNews("14");
               isOpenTopTool = true;
            }
         }
      }
      
      public function getConsortiaSkills() : Array
      {
         var _loc2_:ConsortiaTemplete = null;
         var _loc1_:Array = [];
         if(_consortiaPower > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(6,_consortiaPower);
            _loc1_.push(_loc2_);
         }
         if(_consortiaAgility > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(8,_consortiaAgility);
            _loc1_.push(_loc2_);
         }
         if(_consortiaIntellect > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(9,_consortiaIntellect);
            _loc1_.push(_loc2_);
         }
         if(_consortiaPhysique > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(12,_consortiaPhysique);
            _loc1_.push(_loc2_);
         }
         if(_consortiaCaptain > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(10,_consortiaCaptain);
            _loc1_.push(_loc2_);
         }
         if(_consortiaGold > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(11,_consortiaGold);
            _loc1_.push(_loc2_);
         }
         if(_newPowerLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(13,_newPowerLv);
            _loc1_.push(_loc2_);
         }
         if(_newAgilityLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(14,_newAgilityLv);
            _loc1_.push(_loc2_);
         }
         if(_newIntellectLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(15,_newIntellectLv);
            _loc1_.push(_loc2_);
         }
         if(_newPhysiqueLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(16,_newPhysiqueLv);
            _loc1_.push(_loc2_);
         }
         if(_famGpLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(17,_famGpLv);
            _loc1_.push(_loc2_);
         }
         if(_medalLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(18,_medalLv);
            _loc1_.push(_loc2_);
         }
         if(_honorLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(19,_honorLv);
            _loc1_.push(_loc2_);
         }
         if(_propertyLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(21,_propertyLv);
            _loc1_.push(_loc2_);
         }
         if(_masterPowerLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(22,_masterPowerLv);
            _loc1_.push(_loc2_);
         }
         if(_masterAgilityLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(23,_masterAgilityLv);
            _loc1_.push(_loc2_);
         }
         if(_masterIntellectLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(24,_masterIntellectLv);
            _loc1_.push(_loc2_);
         }
         if(_masterPhysiqueLv > 0)
         {
            _loc2_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(25,_masterPhysiqueLv);
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function get isTrailOverMaxCount() : Boolean
      {
         return trialTowerCampaignCount <= 0;
      }
      
      public function exitUnReceivedLogin() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            if(!(_reloginProcess & 1 << _loc1_))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function checkIsReceived(param1:int) : Boolean
      {
         var _loc2_:Number = 1 << param1 - 1;
         return _loc2_ == (_reloginProcess & _loc2_);
      }
      
      override public function commit() : void
      {
         if(_changeObj["BAG_CAPICITY"])
         {
            dispatchEvent(new PlayerEvent("BAG_CAPICITY_INCRESS",this));
            dispatchEvent(new BagEvent("BAG_FULL",null));
         }
         if(_changeObj["STAR_FREECOUNT"])
         {
            dispatchEvent(new PlayerEvent("STAR_FREECOUNT_CHANGE",this));
         }
         if(_changeObj["STARBAG_CAPICITY"])
         {
            dispatchEvent(new PlayerEvent("STARBAG_CAPICITY_INCRESS",this));
         }
         if(_changeObj["STAR_POINT"])
         {
            dispatchEvent(new PlayerEvent("STAR_POINT_UPDATE",this));
         }
         if(_changeObj["SIGNSITE_CHANGE"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_SIGNSITE_CHANGE",this));
         }
         if(_changeObj["COMPOSE_LIST"])
         {
            dispatchEvent(new PlayerEvent("COMPOSE_LIST_CHANGE",this));
         }
         if(_changeObj["TIMEBOX_UPDATE"])
         {
            dispatchEvent(new PlayerEvent("TIMEBOX_UPDATE",this));
         }
         if(_changeObj["POINT"])
         {
            dispatchEvent(new PlayerEvent("POINT_CHANGE",this));
         }
         if(_changeObj["WEARY"])
         {
            dispatchEvent(new PlayerEvent("WEARY_CHANGE",this));
         }
         if(_changeObj["WEARY"])
         {
            dispatchEvent(new PlayerEvent("RELOGINPROCESS_UPDATE",this));
         }
         if(_changeObj["RELOGINPROCESS_UPDATE"])
         {
            dispatchEvent(new PlayerEvent("RELOGINPROCESS_UPDATE",this));
         }
         if(_changeObj["SEMINARY_EFFECT"])
         {
            dispatchEvent(new PlayerEvent("SEMINARY_EFFECT",this));
         }
         if(_changeObj["FIRSTCHARGE"])
         {
            dispatchEvent(new PlayerEvent("FIRSTCHARGE",this));
         }
         if(_changeObj["KINGBUFF"])
         {
            dispatchEvent(new PlayerEvent("GET_KING_BUFF",this));
         }
         if(_changeObj["WORLDPROSPERITY"])
         {
            dispatchEvent(new PlayerEvent("WORLDPROSPERITY",this));
         }
         if(_changeObj["GVGISOPEN"])
         {
            dispatchEvent(new PlayerEvent("GVGISOPEN",this));
         }
         if(_changeObj["MINERAL"])
         {
            dispatchEvent(new PlayerEvent("MINERAL",this));
         }
         if(_changeObj["WORLDBOSSSTATE"])
         {
            dispatchEvent(new PlayerEvent("WORLDBOSSSTATE",this));
         }
         if(_changeObj["ISPVPSTART"])
         {
            dispatchEvent(new PlayerEvent("ISPVPSTART",this));
         }
         if(_changeObj["PVP_WAR_COUNT"])
         {
            dispatchEvent(new PlayerEvent("PVP_CONUT_CHANGE",this));
         }
         if(_changeObj["SEEK_SURPLUS_TIME"])
         {
            dispatchEvent(new PlayerEvent("SEEK_COUNT_CHANGE",this));
         }
         if(canAcceptCrossScoreAward)
         {
            dispatchEvent(new PlayerEvent("CROSS_SCORE_RAWARD",this));
         }
         if(_changeObj["ISVEHICLESTART"])
         {
            dispatchEvent(new PlayerEvent("VEHICLESTART",this));
         }
         if(_changeObj["VEHICLE_GP"])
         {
            dispatchEvent(new PlayerEvent("VEHICLE_GP",this));
         }
         if(_changeObj["VEHICLE_SCORE"] || _changeObj["VEHICLE_LIST"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_VEHICLEINFO_CHANGE",this));
         }
         if(_changeObj["CROSSGUILD_SCORE"])
         {
            dispatchEvent(new PlayerEvent("CROSSGUILDSCOREREFRESH",this));
         }
         if(_changeObj["CROSSLEAGUE_SCORE"])
         {
            dispatchEvent(new PlayerEvent("CROSSLEAGUESCOREREFRESH",this));
         }
         if(_changeObj["RENTAL_BAG_TIME"])
         {
            dispatchEvent(new PlayerEvent("RENTAL_BAG_TIME_REFRESH",this));
         }
         if(_changeObj["PROFICIENCY"])
         {
            dispatchEvent(new PlayerEvent("PROFICIENCY_CHANGE",this));
         }
         if(_changeObj["LIFESKILLID"])
         {
            dispatchEvent(new PlayerEvent("LIFESKILLID_CHANGE",this));
         }
         if(_changeObj["LIFESKILLGRADE"])
         {
            dispatchEvent(new PlayerEvent("LIFESKILLID_CHANGE",this));
         }
         if(_changeObj["LIFESKILLCAMPAIGNID"])
         {
            dispatchEvent(new PlayerEvent("LIFESKILLCAMPAIGNID_CHANGE",this));
         }
         if(_changeObj["FREESKILLTIME"])
         {
            dispatchEvent(new PlayerEvent("FREESKILL_CHANGE",this));
         }
         if(_changeObj["TIME_VORTEX_COUNT"])
         {
            dispatchEvent(new PlayerEvent("TIME_VORTEX_COUNT_CHANGE",this));
         }
         if(_changeObj["TIME_VORTEX_NODE"])
         {
            dispatchEvent(new PlayerEvent("TIME_VORTEX_NODE_CHANGE",this));
         }
         if(_changeObj["TIME_VORTEX_CAPTURE"])
         {
            dispatchEvent(new PlayerEvent("TIME_VORTEX_CAPTURE_CHANGE",this));
         }
         if(_changeObj["TIME_VORTEX_CRACK"])
         {
            dispatchEvent(new PlayerEvent("TIME_VORTEX_CRACK_CHANGE",this));
         }
         if(_changeObj["TIME_VORTEX_REVENGE"])
         {
            dispatchEvent(new PlayerEvent("TIME_VORTEX_REVENGE_CHANGE",this));
         }
         if(_changeObj["TIME_VORTEX_REVENGE"])
         {
            dispatchEvent(new PlayerEvent("TIME_VORTEX_REVENGE_CHANGE",this));
         }
         if(_changeObj["RUNE_COUNT"])
         {
            dispatchEvent(new PlayerEvent("RUNE_COUNT_CHANGE",this));
         }
         if(_changeObj["RUNPOWER_POINT"])
         {
            dispatchEvent(new PlayerEvent("RUNPOWER_POINT_CHANGE",this));
         }
         super.commit();
      }
      
      public function transfer() : void
      {
         dispatchEvent(new PlayerEvent("DRAGON_SOUL_TRANSFER",this));
      }
      
      public function get vehicleGp() : int
      {
         return _vehicleGp;
      }
      
      public function set vehicleGp(param1:int) : void
      {
         if(_vehicleGp != param1)
         {
            _changeObj["VEHICLE_GP"] = true;
            _vehicleGp = param1;
         }
      }
      
      public function get vehicleScore() : int
      {
         return _vehicleScore;
      }
      
      public function set vehicleScore(param1:int) : void
      {
         if(_vehicleScore != param1)
         {
            _changeObj["VEHICLE_SCORE"] = true;
            _vehicleScore = param1;
         }
      }
      
      public function get vehicleList() : Array
      {
         return _vehicleList;
      }
      
      public function addVehicle(param1:int) : void
      {
         if(_vehicleList.indexOf(param1) < 0)
         {
            _vehicleList.push(param1);
            _changeObj["VEHICLE_LIST"] = true;
         }
      }
      
      public function get vehicleGrade() : int
      {
         var _loc6_:int = 0;
         var _loc4_:int = this.vehicleGp;
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(24);
         _loc1_.sortOn("Grades",16);
         var _loc3_:int = 1;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc1_.length)
         {
            _loc5_ = _loc2_ + _loc1_[_loc6_].Data;
            if(_loc4_ >= _loc2_ && _loc4_ < _loc5_)
            {
               break;
            }
            _loc3_ = int(_loc1_[_loc6_].Grades);
            _loc2_ = _loc5_;
            _loc6_++;
         }
         return _loc3_;
      }
      
      public function get isNeedWeekLockGuild() : Boolean
      {
         return needViceGuild == false && needShowReward;
      }
      
      public function get runeCount() : int
      {
         return _runeCount;
      }
      
      public function set runeCount(param1:int) : void
      {
         if(_runeCount == param1)
         {
            return;
         }
         _runeCount = param1;
         _changeObj["RUNE_COUNT"] = true;
      }
      
      public function get runePowerPoint() : int
      {
         return _runePowerPoint;
      }
      
      public function set runePowerPoint(param1:int) : void
      {
         if(_runePowerPoint == param1)
         {
            return;
         }
         _runePowerPoint = param1;
         _changeObj["RUNPOWER_POINT"] = true;
      }
   }
}

