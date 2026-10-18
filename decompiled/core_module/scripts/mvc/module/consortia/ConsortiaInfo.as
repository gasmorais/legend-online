package mvc.module.consortia
{
   import events.ConsortiaEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import yishi.utils.ClassFactory;
   
   public class ConsortiaInfo extends EventDispatcher
   {
      
      public var consortiaId:int;
      
      public var consortiaName:String;
      
      public var creatorID:int;
      
      public var creatorName:String;
      
      private var _createDate:Object;
      
      public var chairmanID:int;
      
      public var chairmanName:String;
      
      public var description:String;
      
      public var placard:String;
      
      public var groupPlacard:String;
      
      public var storageExpireTime1:String;
      
      public var storageExpireTime2:String;
      
      public var isStorageExpire1:Boolean;
      
      public var isStorageExpire2:Boolean;
      
      public var levels:int;
      
      public var addCount:int;
      
      public var currentCount:int;
      
      private var _offer:int;
      
      public var honor:int;
      
      public var openApp:Boolean;
      
      public var renames:String;
      
      public var kickDate:Object;
      
      public var kickCount:int;
      
      private var _fightPower:Number;
      
      public var shopLevel:int;
      
      public var storeLevel:int;
      
      public var altarLevel:int;
      
      public var schoolLevel:int;
      
      public var attackLevel:int;
      
      public var defenceLevel:int;
      
      public var agilityLevel:int;
      
      public var abilityLevel:int;
      
      public var captainLevel:int;
      
      public var goldLevel:int;
      
      public var physiqueLevel:int;
      
      public var newPowerLv:int;
      
      public var newAgilityLv:int;
      
      public var newIntellectLv:int;
      
      public var newPhysiqueLv:int;
      
      public var famGpLv:int;
      
      public var medalLv:int;
      
      public var honorLv:int;
      
      public var scoreLv:int;
      
      public var ownWildlands:int;
      
      public var isExist:Boolean;
      
      private var _deductDate:Object;
      
      public var warnDate:Date;
      
      public var speakTimes:int;
      
      public var codeType:int;
      
      public var totalOffer:int;
      
      public var quitResult:String;
      
      private var _quitDate:Object;
      
      private var _codeBeginDate:Object;
      
      private var _currentDate:Object;
      
      public var op:int;
      
      public var codeNeedDate:int;
      
      private var _isRobot:Boolean;
      
      public var orderInfo:ConsortiaOrderInfo;
      
      public var masterSchoolLevel:int;
      
      public var taskSchoolLevel:int;
      
      public var businessLevel:int;
      
      public var consortiaAsset:int;
      
      public var masterPowerLv:int;
      
      public var masterAgilityLv:int;
      
      public var masterIntellectLv:int;
      
      public var masterPhysiqueLv:int;
      
      public var masterSkillResearchCd:int;
      
      public var consortiaWeeklyActivePoint:int;
      
      public var consortiaActivePoint:int;
      
      public var buildBtnTypeAry:Array = [1,2,3,4,5,26];
      
      public var votingDate:Date = null;
      
      public var votingState:int = -1;
      
      public var votingId:int = -1;
      
      public var maxMave:int;
      
      public function ConsortiaInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get fightPower() : Number
      {
         return _fightPower;
      }
      
      public function set fightPower(param1:Number) : void
      {
         _fightPower = param1;
      }
      
      public function set offer(param1:int) : void
      {
         if(_offer != param1)
         {
            _offer = param1;
            dispatchEvent(new ConsortiaEvent("CONSORTIA_OFFER_CHANGE"));
         }
         _offer = param1;
      }
      
      public function get offer() : int
      {
         return _offer;
      }
      
      public function get deductDate() : Object
      {
         return _deductDate;
      }
      
      public function set deductDate(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 is Date)
         {
            _deductDate = param1;
         }
         else
         {
            _deductDate = ClassFactory.copyDateType(param1);
         }
      }
      
      public function get createDate() : Object
      {
         return _createDate;
      }
      
      public function set createDate(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 is Date)
         {
            _createDate = param1;
         }
         else
         {
            _createDate = ClassFactory.copyDateType(param1);
         }
      }
      
      public function get codeBeginDate() : Object
      {
         return _codeBeginDate;
      }
      
      public function set codeBeginDate(param1:Object) : void
      {
         if(param1 is Date)
         {
            _codeBeginDate = param1;
         }
         else
         {
            _codeBeginDate = ClassFactory.copyDateType(param1);
         }
      }
      
      public function get currentDate() : Object
      {
         return _currentDate;
      }
      
      public function set currentDate(param1:Object) : void
      {
         if(param1 is Date)
         {
            _currentDate = param1;
         }
         else
         {
            _currentDate = ClassFactory.copyDateType(param1);
         }
      }
      
      public function getLevelByUpgradeType(param1:int) : int
      {
         switch(param1)
         {
            case 1:
               return levels;
            case 2:
               return shopLevel;
            case 3:
               return altarLevel;
            case 4:
               return schoolLevel;
            case 5:
               return storeLevel;
            case 6:
               return attackLevel;
            case 7:
               return defenceLevel;
            case 8:
               return agilityLevel;
            case 9:
               return abilityLevel;
            case 10:
               return captainLevel;
            case 11:
               return goldLevel;
            case 12:
               return physiqueLevel;
            case 13:
               return newPowerLv;
            case 14:
               return newAgilityLv;
            case 15:
               return newIntellectLv;
            case 16:
               return newPhysiqueLv;
            case 17:
               return famGpLv;
            case 18:
               return medalLv;
            case 19:
               return honorLv;
            case 21:
               return scoreLv;
            case 22:
               return masterPowerLv;
            case 23:
               return masterAgilityLv;
            case 24:
               return masterIntellectLv;
            case 25:
               return masterPhysiqueLv;
            default:
               return 0;
         }
      }
      
      public function get quitDate() : Object
      {
         return _quitDate;
      }
      
      public function set quitDate(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 is Date)
         {
            _quitDate = param1;
         }
         else
         {
            _quitDate = ClassFactory.copyDateType(param1);
         }
      }
      
      public function get isRobot() : Boolean
      {
         return _isRobot;
      }
      
      public function set isRobot(param1:Boolean) : void
      {
         _isRobot = param1;
      }
      
      public function get buildBtnLevelAry() : Array
      {
         return [levels,shopLevel,altarLevel,schoolLevel,storeLevel,masterSchoolLevel];
      }
      
      public function get masterSkillLevelAry() : Array
      {
         return [masterPowerLv,masterAgilityLv,masterIntellectLv,masterPhysiqueLv];
      }
   }
}

