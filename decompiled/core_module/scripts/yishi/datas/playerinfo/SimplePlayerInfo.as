package yishi.datas.playerinfo
{
   import events.PetEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   import mvc.module.pet.PetData;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ClassFactory;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class SimplePlayerInfo extends EventDispatcher
   {
      
      protected static const ATTACK_COUNT:String = "ATTACK_COUNT";
      
      protected static const CONSORTIA_DUTY:String = "CONSORTIA_DUTY";
      
      protected static const CONSORTIA_OFFER:String = "CONSORTIA_OFFER";
      
      protected static const CONSORTIA:String = "CONSORTIA";
      
      protected static const CONSORTIA_NAME:String = "CONSORTIA_NAME";
      
      protected static const IS_AUTO:String = "IS_AUTO";
      
      protected static const STATE:String = "STATE";
      
      protected static const NICKNAME:String = "NICKNAME";
      
      protected static const PLAYER_HONOR:String = "PLAYER_HONOR";
      
      protected static const PLAYER_HONOR_DAY:String = "PLAYER_HONOR_DAY";
      
      protected static const PLAYER_HONOR_DAY_MAX:String = "PLAYER_HONOR_DAY_MAX";
      
      protected static const VEHICLEID_CHANGE:String = "VEHICLEID_CHANGE";
      
      protected static const GLORY_CHANGE:String = "GLORY_CHANGE";
      
      protected static const PET_DATA:String = "PET_DATA";
      
      protected static const FIGHTINGCAPACITY_CHANGE:String = "FIGHTINGCAPACITY_CHANGE";
      
      public static const PET_ADD:String = "PET_ADD";
      
      public static const PET_REMOVE:String = "PET_REMOVE";
      
      public static const PLAYER_PET_LIST_CHANGE:String = "PLAYER_PET_LIST_CHANGE";
      
      public static const PLAYER_CHILD_LIST_CHANGE:String = "PLAYER_CHILD_LIST_CHANGE";
      
      public static const MUTICOPY_COUNT:String = "MUTICOPY_COUNT";
      
      public static const MUTICOPY_MAX_COUNT:String = "MUTICOPY_MAX_COUNT";
      
      public static const DRAGON_SOUL_TYPE:String = "DRAGON_SOUL_TYPE";
      
      public static const DRAGON_SOUL_GRADE:String = "DRAGON_SOUL_GRADE";
      
      public static const DRAGON_SOUL_GP:String = "DRAGON_SOUL_GP";
      
      public static const VOCATION_INDEX:String = "VOCATION_INDEX";
      
      public static const VOCATION_GRADES:String = "VOCATION_GRADES";
      
      public static const VOCATION_GP:String = "VOCATION_GP";
      
      public static const MULTIPLE_AP:String = "MULTIPLE_AP";
      
      public static const OLDBACKER:String = "OLDBACKER";
      
      public static const AVENGER_DEGREE:String = "AVENGER_DEGREE";
      
      public static const REFRESH_fantasyMatrix_NUM:String = "REFRESH_fantasyMatrix_NUM";
      
      public static const REFRESH_DUNGEO_RESTNUM:String = "REFRESH_DUNGEO_RESTNUM";
      
      public static const REFRESH_SPACE_TIME_RESTNUM:String = "REFRESH_SPACE_TIME_RESTNUM";
      
      public static const REFRESH_SPACE_TIME_HISTORY:String = "REFRESH_SPACE_TIME_HISTORY";
      
      public var playerOrdeInfo:PlayerOrderInfo;
      
      protected var _changeObj:SimpleDictionary;
      
      private var _userId:int;
      
      public var molongRestNum:int;
      
      public var molongMaxNum:int;
      
      private var _fantasyMatrixRestNum:int;
      
      public var fantasyMatrixMaxNum:int;
      
      public var monopolyCampaignNum:int;
      
      public var usePlaneCrisis:int;
      
      public var uuid:String = "";
      
      public var site:String = "";
      
      public var rapidPassNum:int = 1;
      
      private var _isBackPlayer:Boolean = false;
      
      private var _multiCopyCount:int;
      
      private var _multiCopyMaxCount:int;
      
      public var dungeoTurnMaxNum:int = 1;
      
      private var _dungeoRestNum:int;
      
      public var dungeoHasReward:Boolean;
      
      public var spacetimeMaxNum:int = 1;
      
      private var _spacetimeRestNum:int;
      
      private var _spacetimePassHistory:String = "";
      
      public var hasSpaceTimeReward:Boolean;
      
      private var _spaceTimeBoxTimeBegin:Number = 0;
      
      private var _raceAgainstTimeBegin:Number = 0;
      
      public var job:int;
      
      private var _state:int;
      
      private var _attackCount:int;
      
      private var _dutyId:int;
      
      private var _consortiaOffer:int;
      
      private var _consortiaTotalOffer:int;
      
      private var _charms:int;
      
      private var _gloryPoint:int;
      
      private var _rewardCount:int;
      
      private var _soulScore:int;
      
      private var _honer:int;
      
      private var _honerDay:int;
      
      private var _honerDayMax:int;
      
      private var _honerDayMedicinal:int;
      
      public var right:int;
      
      private var _nickName:String;
      
      public var isExist:int;
      
      public var sexs:int;
      
      public var childrenName:String;
      
      public var childrenSex:int;
      
      public var childrenJob:int;
      
      private var _childrenGrade:int;
      
      private var _monsterTempteId:int;
      
      public var childrenFightPower:int;
      
      public var pics:int;
      
      public var camp:int;
      
      private var _consortiaID:int;
      
      private var _consortiaName:String;
      
      public var claimId:int;
      
      public var claimName:String;
      
      public var repute:int;
      
      public var IsVipAndNoExpirt:Boolean;
      
      public var vipType:int;
      
      public var storeGrade:int;
      
      public var parameter1:int;
      
      public var strategy:Number;
      
      public var ownHeros:int;
      
      public var ownWildlands:int;
      
      private var _fightingCapacity:int;
      
      public var matchFailed:int;
      
      public var matchWin:int;
      
      public var lastOutConsortia:Number = 0;
      
      private var _isAuto:Boolean;
      
      public var challengeRank:int;
      
      public var invited:Boolean = false;
      
      public var serviceName:String = "";
      
      private var _logOutTime:Object;
      
      public var JJCcount:int;
      
      private var _JJCMaxCount:int;
      
      public var crossGuildTeamId:int;
      
      private var _hasViceHero:Boolean = false;
      
      private var _enterChildData:ChildData = null;
      
      public var isXmlItem:Boolean = false;
      
      public var qteGuide:int;
      
      private var _vehicleTempId:int = 1;
      
      public var avatarChange:SimpleDictionary;
      
      private var _petMaxCount:int = 6;
      
      private var _petFormation:Array;
      
      private var _petList:Array = [];
      
      private var _enterWarPet:PetData;
      
      private var _petChallengeFormation:String;
      
      public var petChallengeFormationOfArray:Array = [];
      
      private var _childPveFormation:String;
      
      public var childPveFormationOfArray:Array = [];
      
      private var _petMatelordsFormation:String = "-1,0,-1,-1,-1,-1";
      
      public var petMatelordsFormationOfArray:Array = [];
      
      private var _petConsortiaBossFormation:String = "-1,0,-1,-1,-1,-1";
      
      public var petConsortiaBossFormationOfArray:Array = [];
      
      private var _petFlameFormation:String = "-1,0,-1,-1,-1,-1,-1,-1";
      
      public var petFlameFormationOfArray:Array = [];
      
      private var _petMonopolyFormation:String = "-1,0,-1,-1,-1,-1,-1,-1";
      
      public var petMonopolyFormationOfArray:Array = [];
      
      private var _multipleAp:int;
      
      private var _dragonSoulType:int;
      
      private var _dragonSoulGrade:int;
      
      private var _dragonSoulGp:int;
      
      private var _vocationIndex:int;
      
      private var _vocationGrades:int;
      
      private var _vocationLevel:int;
      
      private var _vocationStep:int;
      
      private var _vocationGp:int;
      
      private var _battleGuardInfo:BattleGuardInfo = new BattleGuardInfo();
      
      public var mountInfo:SimpleMountInfo;
      
      public var growthGrade2:int = -1;
      
      public function SimplePlayerInfo()
      {
         super();
         _changeObj = new SimpleDictionary();
         playerOrdeInfo = new PlayerOrderInfo();
         avatarChange = new SimpleDictionary();
      }
      
      public function set fantasyMatrixRestNum(param1:int) : void
      {
         if(_fantasyMatrixRestNum == param1)
         {
            return;
         }
         _fantasyMatrixRestNum = param1;
         NotificationManager.instance.sendNotification("REFRESH_fantasyMatrix_NUM");
      }
      
      public function get fantasyMatrixRestNum() : int
      {
         return _fantasyMatrixRestNum;
      }
      
      public function get monsterTempteId() : int
      {
         return _monsterTempteId;
      }
      
      public function set monsterTempteId(param1:int) : void
      {
         _monsterTempteId = param1;
      }
      
      public function get isBackPlayer() : Boolean
      {
         return _isBackPlayer;
      }
      
      public function set isBackPlayer(param1:Boolean) : void
      {
         if(_isBackPlayer != param1)
         {
            _changeObj["OLDBACKER"] = true;
            _isBackPlayer = param1;
         }
      }
      
      public function get multiCopyCount() : int
      {
         return _multiCopyCount;
      }
      
      public function set multiCopyCount(param1:int) : void
      {
         if(_multiCopyCount != param1)
         {
            _changeObj["MUTICOPY_COUNT"] = true;
            _multiCopyCount = param1;
         }
      }
      
      public function get multiCopyMaxCount() : int
      {
         return _multiCopyMaxCount;
      }
      
      public function set multiCopyMaxCount(param1:int) : void
      {
         if(_multiCopyMaxCount != param1)
         {
            _changeObj["MUTICOPY_MAX_COUNT"] = true;
            _multiCopyMaxCount = param1;
         }
      }
      
      public function set dungeoRestNum(param1:int) : void
      {
         if(_dungeoRestNum == param1)
         {
            return;
         }
         _dungeoRestNum = param1;
         NotificationManager.instance.sendNotification("REFRESH_DUNGEO_RESTNUM");
      }
      
      public function get dungeoRestNum() : int
      {
         return _dungeoRestNum;
      }
      
      public function set spacetimeRestNum(param1:int) : void
      {
         if(_spacetimeRestNum == param1)
         {
            return;
         }
         _spacetimeRestNum = param1;
         NotificationManager.instance.sendNotification("REFRESH_SPACE_TIME_RESTNUM");
      }
      
      public function get spacetimeRestNum() : int
      {
         return _spacetimeRestNum;
      }
      
      public function set spacetimePassHistory(param1:String) : void
      {
         if(_spacetimePassHistory == param1)
         {
            return;
         }
         _spacetimePassHistory = param1;
         NotificationManager.instance.sendNotification("REFRESH_SPACE_TIME_HISTORY");
      }
      
      public function get spacetimePassHistory() : String
      {
         return _spacetimePassHistory;
      }
      
      public function set spaceTimeBoxTimeStart(param1:String) : void
      {
         _spaceTimeBoxTimeBegin = DateFormatter.parse(param1,"YYYY-MM-DD hh:mm:ss").time;
      }
      
      public function get spaceTimeBoxTimeBegin() : Number
      {
         return _spaceTimeBoxTimeBegin;
      }
      
      public function set raceAgainstTimeStart(param1:String) : void
      {
         _raceAgainstTimeBegin = int(param1);
      }
      
      public function get raceAgainstTimeBegin() : Number
      {
         return _raceAgainstTimeBegin;
      }
      
      public function get nickName() : String
      {
         return _nickName == _userId + "$" ? LanguageMgr.GetTranslation("public.nickName") : _nickName;
      }
      
      public function set nickName(param1:String) : void
      {
         if(_nickName != param1)
         {
            _changeObj["NICKNAME"] = true;
            _nickName = param1;
         }
      }
      
      public function get consortiaID() : int
      {
         return _consortiaID;
      }
      
      public function set consortiaID(param1:int) : void
      {
         if(_consortiaID != param1)
         {
            _changeObj["CONSORTIA"] = true;
            _consortiaID = param1;
         }
      }
      
      public function get consortiaName() : String
      {
         return _consortiaName;
      }
      
      public function set consortiaName(param1:String) : void
      {
         if(_consortiaName != param1)
         {
            _consortiaName = param1;
            _changeObj["CONSORTIA_NAME"] = true;
         }
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(param1:int) : void
      {
         _userId = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         _changeObj["STATE"] = true;
      }
      
      public function get isOnline() : Boolean
      {
         return _state != 0;
      }
      
      public function get attackCount() : int
      {
         return _attackCount;
      }
      
      public function set attackCount(param1:int) : void
      {
         if(_attackCount != param1)
         {
            _changeObj["ATTACK_COUNT"] = true;
            _attackCount = param1;
         }
      }
      
      public function get dutyId() : int
      {
         return _dutyId;
      }
      
      public function set dutyId(param1:int) : void
      {
         if(param1 && param1 != _dutyId)
         {
            _changeObj["CONSORTIA_DUTY"] = true;
            _dutyId = param1;
         }
      }
      
      public function get consortiaOffer() : int
      {
         return _consortiaOffer;
      }
      
      public function set consortiaOffer(param1:int) : void
      {
         if(_consortiaOffer != param1)
         {
            _changeObj["CONSORTIA_OFFER"] = true;
            _consortiaOffer = param1;
         }
      }
      
      public function get consortiaTotalOffer() : int
      {
         return _consortiaTotalOffer;
      }
      
      public function set consortiaTotalOffer(param1:int) : void
      {
         if(_consortiaTotalOffer != param1)
         {
            _consortiaTotalOffer = param1;
         }
      }
      
      public function get charms() : int
      {
         return _charms;
      }
      
      public function set charms(param1:int) : void
      {
         if(_charms == param1)
         {
            return;
         }
         _charms = param1;
      }
      
      public function get gloryPoint() : int
      {
         return _gloryPoint;
      }
      
      public function set gloryPoint(param1:int) : void
      {
         if(_gloryPoint == param1)
         {
            return;
         }
         _gloryPoint = param1;
         _changeObj["GLORY_CHANGE"] = true;
      }
      
      public function get rewardCount() : int
      {
         return _rewardCount;
      }
      
      public function set rewardCount(param1:int) : void
      {
         if(_rewardCount == param1)
         {
            return;
         }
         _rewardCount = param1;
      }
      
      public function get soulScore() : int
      {
         return _soulScore;
      }
      
      public function set soulScore(param1:int) : void
      {
         if(_soulScore == param1)
         {
            return;
         }
         _soulScore = param1;
      }
      
      public function set honer(param1:int) : void
      {
         if(_honer != param1)
         {
            _changeObj["PLAYER_HONOR"] = true;
            _honer = param1;
         }
      }
      
      public function get honer() : int
      {
         return _honer;
      }
      
      public function set honerDay(param1:int) : void
      {
         if(_honerDay != param1)
         {
            _changeObj["PLAYER_HONOR_DAY"] = true;
            _honerDay = param1;
         }
      }
      
      public function get honerDay() : int
      {
         return _honerDay;
      }
      
      public function set honerDayMax(param1:int) : void
      {
         if(_honerDayMax != param1)
         {
            _changeObj["PLAYER_HONOR_DAY_MAX"] = true;
            _honerDayMax = param1;
         }
      }
      
      public function get honerDayMax() : int
      {
         return _honerDayMax;
      }
      
      public function set honerDayMedicinal(param1:int) : void
      {
         if(_honerDayMedicinal != param1)
         {
            _changeObj["PLAYER_HONOR_DAY"] = true;
            _honerDayMedicinal = param1;
         }
      }
      
      public function get honerDayMedicinal() : int
      {
         return _honerDayMedicinal;
      }
      
      public function get firstHonerTemp() : UpgradeTemplateInfo
      {
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(14);
         _loc1_.sortOn("Data",16);
         return _loc1_[1] as UpgradeTemplateInfo;
      }
      
      public function get honerTemp() : UpgradeTemplateInfo
      {
         var _loc2_:int = 0;
         var _loc1_:UpgradeTemplateInfo = null;
         var _loc3_:Array = TempleteManager.instance.getTemplatesByType(14);
         _loc3_.sortOn("Data",0x10 | 2);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc2_] as UpgradeTemplateInfo;
            if(_honer >= _loc1_.Data)
            {
               return _loc1_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get nextHonerTemp() : UpgradeTemplateInfo
      {
         var _loc2_:int = 0;
         var _loc1_:UpgradeTemplateInfo = null;
         var _loc3_:Array = TempleteManager.instance.getTemplatesByType(14);
         _loc3_.sortOn("Data",0x10 | 2);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc2_] as UpgradeTemplateInfo;
            if(_honer >= _loc1_.Data)
            {
               if(_loc3_[_loc2_ - 1])
               {
                  return _loc3_[_loc2_ - 1] as UpgradeTemplateInfo;
               }
               return _loc1_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get hasViceHero() : Boolean
      {
         return _hasViceHero;
      }
      
      public function get fightingCapacity() : int
      {
         return _fightingCapacity;
      }
      
      public function set fightingCapacity(param1:int) : void
      {
         if(_fightingCapacity != param1)
         {
            _fightingCapacity = param1;
            _changeObj["FIGHTINGCAPACITY_CHANGE"] = true;
            figureMultipleAp();
         }
      }
      
      public function get JJCMaxCount() : int
      {
         if(!_JJCMaxCount)
         {
            if(TempleteManager.instance.getConfigInfoByConfigName("MatchRoom_MaxCount"))
            {
               _JJCMaxCount = int(TempleteManager.instance.getConfigInfoByConfigName("MatchRoom_MaxCount").ConfigValue);
            }
         }
         return _JJCMaxCount;
      }
      
      public function get logOutTime() : Object
      {
         return _logOutTime || new Date();
      }
      
      public function set logOutTime(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 is Date)
         {
            _logOutTime = param1;
         }
         else
         {
            _logOutTime = ClassFactory.copyDateType(param1);
         }
      }
      
      public function get LogOutTimeMs() : Number
      {
         if(isOnline)
         {
            return 1.7976931348623157e+308;
         }
         return (_logOutTime as Date).getTime();
      }
      
      public function get isAuto() : Boolean
      {
         return _isAuto;
      }
      
      public function set isAuto(param1:Boolean) : void
      {
         if(_isAuto == param1)
         {
            return;
         }
         _isAuto = param1;
         _changeObj["IS_AUTO"] = true;
      }
      
      public function get vehicleTempId() : int
      {
         return _vehicleTempId;
      }
      
      public function set vehicleTempId(param1:int) : void
      {
         if(_vehicleTempId != param1)
         {
            _changeObj["VEHICLEID_CHANGE"] = true;
            _vehicleTempId = param1;
         }
      }
      
      public function get vehicleTemplate() : VehicleObjectTempInfo
      {
         return TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(vehicleTempId);
      }
      
      public function get petMaxCount() : int
      {
         return _petMaxCount;
      }
      
      public function set petMaxCount(param1:int) : void
      {
         if(_petMaxCount == param1)
         {
            return;
         }
         _petMaxCount = param1;
         dispatchEvent(new PetEvent("PET_MAXCOUNT_CHANGE",param1));
      }
      
      public function get petList() : Array
      {
         return _petList;
      }
      
      public function get powerMaxPetData() : PetData
      {
         var _loc1_:PetData = null;
         for each(var _loc2_:PetData in petList)
         {
            if(!_loc1_ || _loc2_.fightPower > _loc1_.fightPower)
            {
               _loc1_ = _loc2_;
            }
         }
         return _loc1_;
      }
      
      public function getMixPetData(param1:int, param2:int, param3:int) : PetData
      {
         var _loc4_:PetData = null;
         for each(var _loc5_:PetData in petList)
         {
            if(_loc4_)
            {
               break;
            }
            if(_loc5_.template.PetType == param1 && _loc5_.template.NeedGrade == param2 && _loc5_.grade >= param2 && _loc5_.quality == param3 && _loc5_.isFullRes())
            {
               _loc4_ = _loc5_;
            }
         }
         return _loc4_;
      }
      
      public function addPet(param1:PetData, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PetData = getPet(param1.petId);
         if(param1.isEnterWar)
         {
            enterWarPet = param1;
         }
         else if(param1 == enterWarPet)
         {
            enterWarPet = null;
         }
         if(param2)
         {
            if(_loc3_)
            {
               _loc4_ = _petList.indexOf(_loc3_);
               if(_loc4_ != -1)
               {
                  _petList.splice(_loc4_,1);
               }
            }
            _petList.splice(0,0,param1);
         }
         else if(!_loc3_)
         {
            _petList.push(param1);
         }
         figureMultipleAp();
         if(!_loc3_)
         {
            dispatchEvent(new PetEvent("PET_ADD",param1));
         }
         else
         {
            dispatchEvent(new PetEvent("PET_UPDATE",param1));
         }
      }
      
      public function addEnterWarChild(param1:ChildData) : void
      {
         _enterChildData = param1;
      }
      
      public function get enterChildData() : ChildData
      {
         return _enterChildData;
      }
      
      public function removePet(param1:int) : PetData
      {
         var _loc2_:int = 0;
         for each(var _loc3_:PetData in _petList)
         {
            if(_loc3_.petId == param1)
            {
               _petList.splice(_loc2_,1);
               dispatchEvent(new PetEvent("PET_REMOVE",_loc3_));
               if(_loc3_.isEnterWar || _loc3_ == enterWarPet)
               {
                  enterWarPet = null;
               }
               return _loc3_;
            }
            _loc2_++;
         }
         figureMultipleAp();
         return null;
      }
      
      public function getPet(param1:int) : PetData
      {
         for each(var _loc2_:PetData in _petList)
         {
            if(_loc2_.petId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get enterWarPet() : PetData
      {
         return _enterWarPet;
      }
      
      public function set enterWarPet(param1:PetData) : void
      {
         if(_enterWarPet == param1)
         {
            return;
         }
         _enterWarPet = param1;
         figureMultipleAp();
         dispatchEvent(new PetEvent("PET_ENTERWAR_CHANGE",param1));
      }
      
      public function get petChallengeFormation() : String
      {
         return _petChallengeFormation;
      }
      
      public function set petChallengeFormation(param1:String) : void
      {
         if(_petChallengeFormation == param1)
         {
            return;
         }
         _petChallengeFormation = param1;
         if(param1)
         {
            petChallengeFormationOfArray = param1.split(",");
         }
         else
         {
            petChallengeFormationOfArray = [];
         }
         _changeObj["PLAYER_PET_LIST_CHANGE"] = true;
      }
      
      public function get childPveFormation() : String
      {
         return _childPveFormation;
      }
      
      public function set childPveFormation(param1:String) : void
      {
         if(_childPveFormation == param1)
         {
            return;
         }
         _childPveFormation = param1;
         if(param1)
         {
            childPveFormationOfArray = param1.split(",");
         }
         else
         {
            childPveFormationOfArray = [];
         }
         _changeObj["PLAYER_CHILD_LIST_CHANGE"] = true;
      }
      
      public function get petMatelordsFormation() : String
      {
         return _petMatelordsFormation;
      }
      
      public function set petMatelordsFormation(param1:String) : void
      {
         if(StringHelper.isNullOrEmpty(param1) || param1 == "-1,-1,-1,-1,-1,-1")
         {
            param1 = "-1,0,-1,-1,-1,-1";
         }
         if(_petMatelordsFormation == param1)
         {
            return;
         }
         _petMatelordsFormation = param1;
         if(param1)
         {
            petMatelordsFormationOfArray = param1.split(",");
         }
         else
         {
            petMatelordsFormationOfArray = [];
         }
         _changeObj["PLAYER_PET_LIST_CHANGE"] = true;
      }
      
      public function get petConsortiaBossFormation() : String
      {
         return _petConsortiaBossFormation;
      }
      
      public function set petConsortiaBossFormation(param1:String) : void
      {
         if(StringHelper.isNullOrEmpty(param1) || param1 == "-1,-1,-1,-1,-1,-1")
         {
            param1 = "-1,0,-1,-1,-1,-1";
         }
         if(_petConsortiaBossFormation == param1)
         {
            return;
         }
         _petConsortiaBossFormation = param1;
         if(param1)
         {
            petConsortiaBossFormationOfArray = param1.split(",");
         }
         else
         {
            petConsortiaBossFormationOfArray = [];
         }
         _changeObj["PLAYER_PET_LIST_CHANGE"] = true;
      }
      
      public function get petFlameFormation() : String
      {
         return _petFlameFormation;
      }
      
      public function set petFlameFormation(param1:String) : void
      {
         if(StringHelper.isNullOrEmpty(param1) || param1 == "-1,-1,-1,-1,-1,-1,-1,-1")
         {
            param1 = "-1,0,-1,-1,-1,-1,-1,-1";
         }
         if(_petFlameFormation == param1)
         {
            return;
         }
         _petFlameFormation = param1;
         if(param1)
         {
            petFlameFormationOfArray = param1.split(",");
         }
         else
         {
            petFlameFormationOfArray = [];
         }
         _changeObj["PLAYER_PET_LIST_CHANGE"] = true;
      }
      
      public function get petMonopolyFormation() : String
      {
         return _petMonopolyFormation;
      }
      
      public function set petMonopolyFormation(param1:String) : void
      {
         if(StringHelper.isNullOrEmpty(param1) || param1 == "-1,-1,-1,-1,-1,-1,-1,-1")
         {
            param1 = "-1,0,-1,-1,-1,-1,-1,-1";
         }
         if(_petMonopolyFormation == param1)
         {
            return;
         }
         _petMonopolyFormation = param1;
         if(param1)
         {
            petMonopolyFormationOfArray = param1.split(",");
         }
         else
         {
            petMonopolyFormationOfArray = [];
         }
         _changeObj["PLAYER_PET_LIST_CHANGE"] = true;
      }
      
      public function get petChallengeCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:int in petChallengeFormationOfArray)
         {
            if(_loc2_ > 0)
            {
               _loc1_++;
               break;
            }
         }
         return _loc1_;
      }
      
      private function figureMultipleAp() : void
      {
         var _loc2_:int = 0;
         _multipleAp = _fightingCapacity;
         var _loc1_:Array = petList.concat();
         _loc1_.sort(sortPetByPower);
         if(enterWarPet)
         {
            _loc1_.splice(_loc1_.indexOf(enterWarPet),1);
            _loc2_ = 0;
            while(_loc2_ < 2)
            {
               if(_loc1_.length > _loc2_)
               {
                  _multipleAp += _loc1_[_loc2_].fightPower;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               if(_loc1_.length > _loc2_)
               {
                  _multipleAp += _loc1_[_loc2_].fightPower;
               }
               _loc2_++;
            }
         }
         _changeObj["MULTIPLE_AP"] = true;
      }
      
      private function sortPetByPower(param1:PetData, param2:PetData) : int
      {
         var _loc3_:int = 0;
         if(param1.fightPower > param2.fightPower)
         {
            _loc3_ = -1;
         }
         else if(param1.fightPower < param2.fightPower)
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      public function get multipleAp() : int
      {
         if(_multipleAp <= 0)
         {
            _multipleAp = _fightingCapacity;
         }
         return _multipleAp;
      }
      
      public function get dragonSoulType() : int
      {
         return _dragonSoulType;
      }
      
      public function set dragonSoulType(param1:int) : void
      {
         if(_dragonSoulType != param1)
         {
            _changeObj["DRAGON_SOUL_TYPE"] = true;
            _dragonSoulType = param1;
         }
      }
      
      public function get dragonSoulGrade() : int
      {
         return _dragonSoulGrade;
      }
      
      public function set dragonSoulGrade(param1:int) : void
      {
         if(_dragonSoulGrade != param1)
         {
            _changeObj["DRAGON_SOUL_GRADE"] = true;
            _dragonSoulGrade = param1;
         }
      }
      
      public function get dragonSoulGp() : int
      {
         return _dragonSoulGp;
      }
      
      public function set dragonSoulGp(param1:int) : void
      {
         if(_dragonSoulGp != param1)
         {
            _changeObj["DRAGON_SOUL_GP"] = true;
            _dragonSoulGp = param1;
         }
      }
      
      public function get vocationIndex() : int
      {
         return _vocationIndex;
      }
      
      public function set vocationIndex(param1:int) : void
      {
         if(_vocationIndex != param1)
         {
            _changeObj["VOCATION_INDEX"] = true;
            _vocationIndex = param1;
         }
      }
      
      public function get isChangeJob() : Boolean
      {
         return _vocationIndex > 0;
      }
      
      public function get isAvenger() : Boolean
      {
         return _vocationIndex >= 3;
      }
      
      public function get isHoly() : Boolean
      {
         return _vocationIndex >= 4;
      }
      
      public function get vocationGrades() : int
      {
         return _vocationGrades;
      }
      
      public function set vocationGrades(param1:int) : void
      {
         if(_vocationGrades != param1)
         {
            _changeObj["VOCATION_GRADES"] = true;
            _vocationGrades = param1;
            if(_vocationGrades > 0)
            {
               _vocationLevel = (_vocationGrades - 1) / 10 + 1;
               _vocationStep = _vocationGrades % 10;
               if(_vocationStep == 0)
               {
                  _vocationStep = 10;
               }
            }
            else
            {
               _vocationLevel = 0;
               _vocationStep = 0;
            }
         }
      }
      
      public function get vocationGp() : int
      {
         return _vocationGp;
      }
      
      public function set vocationGp(param1:int) : void
      {
         if(_vocationGp != param1)
         {
            _changeObj["VOCATION_GP"] = true;
            _vocationGp = param1;
         }
      }
      
      public function get vocationLevel() : int
      {
         if(isHoly)
         {
            return _vocationLevel + 19;
         }
         if(isAvenger)
         {
            return _vocationLevel + 16;
         }
         if(_vocationIndex > 0 && _vocationIndex < 3)
         {
            return _vocationLevel + 8;
         }
         return _vocationLevel;
      }
      
      public function get vocationStep() : int
      {
         return _vocationStep;
      }
      
      public function get battleGuardInfo() : BattleGuardInfo
      {
         return _battleGuardInfo;
      }
      
      public function set battleGuardInfo(param1:BattleGuardInfo) : void
      {
         _battleGuardInfo = param1;
      }
      
      public function beginChanges() : void
      {
         _changeObj.clear();
      }
      
      public function commit() : void
      {
         if(_changeObj["ATTACK_COUNT"])
         {
            dispatchEvent(new PlayerEvent("ATTACK_COUNT_CHANGE",this));
         }
         if(_changeObj["CONSORTIA_DUTY"])
         {
            dispatchEvent(new PlayerEvent("CONSORTIA_DUTY_CHANGE",this));
         }
         if(_changeObj["CONSORTIA_OFFER"])
         {
            dispatchEvent(new PlayerEvent("CONSORTIA_OFFER_CHANGE",this));
         }
         if(_changeObj["CONSORTIA"])
         {
            dispatchEvent(new PlayerEvent("CONSORTIA_CHANGE",this));
         }
         if(_changeObj["CONSORTIA_NAME"])
         {
            dispatchEvent(new PlayerEvent("CONSORTIA_NAME_CHANGE",this));
         }
         if(_changeObj["IS_AUTO"])
         {
            dispatchEvent(new PlayerEvent("IS_AUTO_CHANGE",this));
         }
         if(_changeObj["NICKNAME"])
         {
            dispatchEvent(new PlayerEvent("NICKNAME_UPDATE",this));
         }
         if(_changeObj["PLAYER_HONOR"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_HONOR",this));
         }
         if(_changeObj["PLAYER_HONOR_DAY"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_HONOR_DAY",this));
         }
         if(_changeObj["PLAYER_HONOR_DAY_MAX"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_HONOR_DAY_MAX",this));
         }
         if(_changeObj["STATE"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_STATE_CHANGE",this));
         }
         if(_changeObj["VEHICLEID_CHANGE"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_VEHICLE_CHANGE",this));
         }
         if(_changeObj["GLORY_CHANGE"])
         {
            dispatchEvent(new PlayerEvent("GLORY_CHANGE",this));
         }
         if(_changeObj["PLAYER_PET_LIST_CHANGE"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_PET_LIST_CHANGE",this));
         }
         if(_changeObj["PLAYER_CHILD_LIST_CHANGE"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_CHILD_LIST_CHANGE",this));
         }
         if(_changeObj["MUTICOPY_COUNT"])
         {
            dispatchEvent(new PlayerEvent("MUTICOPY_COUNT",this));
         }
         if(_changeObj["MUTICOPY_MAX_COUNT"])
         {
            dispatchEvent(new PlayerEvent("MUTICOPY_MAX_COUNT",this));
         }
         if(_changeObj["DRAGON_SOUL_TYPE"])
         {
            dispatchEvent(new PlayerEvent("DRAGON_SOUL_TYPE",this));
         }
         if(_changeObj["DRAGON_SOUL_GRADE"])
         {
            dispatchEvent(new PlayerEvent("DRAGON_SOUL_GRADE",this));
         }
         if(_changeObj["DRAGON_SOUL_GP"])
         {
            dispatchEvent(new PlayerEvent("DRAGON_SOUL_GP",this));
         }
         if(_changeObj["VOCATION_INDEX"])
         {
            dispatchEvent(new PlayerEvent("VOCATION_INDEX",this));
         }
         if(_changeObj["VOCATION_GRADES"])
         {
            dispatchEvent(new PlayerEvent("VOCATION_GRADES",this));
         }
         if(_changeObj["VOCATION_GP"])
         {
            dispatchEvent(new PlayerEvent("VOCATION_GP",this));
         }
         if(_changeObj["MULTIPLE_AP"])
         {
            dispatchEvent(new PlayerEvent("MULTIPLE_AP_UPDATE",this));
         }
         if(_changeObj["OLDBACKER"])
         {
            dispatchEvent(new PlayerEvent("PLAYER_OLDBACKER_BUFF_CHANGE",this));
         }
         if(_changeObj["FIGHTINGCAPACITY_CHANGE"])
         {
            dispatchEvent(new PlayerEvent("FIGHTINGCAPACITY_CHANGE",this));
         }
         dispatchEvent(new PlayerEvent("PLAYER_INFO_UPDATE",this));
      }
      
      public function get childrenGrade() : int
      {
         return _childrenGrade;
      }
      
      public function set childrenGrade(param1:int) : void
      {
         _childrenGrade = param1;
      }
   }
}

