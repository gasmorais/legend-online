package mvc.module.pet
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.pet.PetInfoMsg;
   import events.PetEvent;
   import farm.FarmManager;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class PetData extends EventDispatcher
   {
      
      public static const PETINFO_CHANGE:String = "PETINFO_CHANGE";
      
      public static const MORPH_OPEN_GRADE:int = 55;
      
      public static const EACH_LEVEL_POINT:int = 5;
      
      public static const EXP_TRANSFORM_RATIO:Number = 0.5;
      
      public static const QUALITY_LEVEL_UP_SER:Number = 0.02;
      
      public static const COMMON_SKILL_TYPE:int = 107;
      
      public static const MIN_PET_EQUIP_REFINERY_QUALITY:uint = 3;
      
      public static const MAX_PET_EQUIP_REFINERY_QUALITY:uint = 6;
      
      public static const MIN_PET_EQUIP_UPGRAED_QUALITY:uint = 3;
      
      public static const MAX_PET_EQUIP_UPGRAED_QUALITY:uint = 5;
      
      public static const PET_EQUIP_STRENG_COST:uint = 3;
      
      public static const MAX_TEMQUALITY:int = 31;
      
      public static const MAX_GRADE:int = 80;
      
      public static const UPGRAD_TYPE:int = 25;
      
      private static var _upgradeTemplates:Array;
      
      public static const QUALITY_UPGRADE_TYPE:int = 27;
      
      public static const QUALITY_UPGRADE_TYPE2:int = 29;
      
      public static const QUALITY_UPGRADE_TYPE3:int = 107;
      
      private static var _qualityUpgradeTemplates:Dictionary;
      
      private static var _petCarryLimit:int = -1;
      
      public var remoteHp:int;
      
      public var isRemote:Boolean;
      
      public var petId:int;
      
      public var name:String;
      
      public var userId:int;
      
      public var thaneInfo:ThaneInfo;
      
      public var playerInfo:PlayerInfo;
      
      private var _equipList:Array;
      
      public var template:PetTemplate;
      
      private var _templateId:int;
      
      public var pos:int = 0;
      
      public var grade:int = 1;
      
      public var curExp:Number = 0;
      
      public var totalExp:Number = 0;
      
      public var life:int;
      
      public var fightPower:int = 0;
      
      public var strength:int;
      
      public var intellect:int;
      
      public var stamina:int;
      
      public var armor:int;
      
      public var remainPoint:int;
      
      public var coeStrengthBase:int;
      
      public var coeIntellectBase:int;
      
      public var coeStaminaBase:int;
      
      public var coeArmorBase:int;
      
      public var coeStrength:int;
      
      public var coeIntellect:int;
      
      public var coeStamina:int;
      
      public var coeArmor:int;
      
      public var equipMagicAttack:int;
      
      public var equipMagicDefense:int;
      
      public var equipPhysicalAttack:int;
      
      public var equipPhysicalDefense:int;
      
      public var equipHp:int;
      
      public var resFire:int;
      
      public var resWater:int;
      
      public var resElect:int;
      
      public var resWind:int;
      
      public var resDark:int;
      
      public var resLight:int;
      
      public var isBind:Boolean;
      
      public var isEnterWar:Boolean;
      
      public var isChildWar:int;
      
      public var followSkillTemplates:Array = [];
      
      public var changeSkillTemplates:Array = [];
      
      private var _followSkills:String;
      
      private var _changeSkills:String;
      
      protected var _changeObj:SimpleDictionary;
      
      public var isLock:Boolean;
      
      public var qualityGp:int = 0;
      
      private var _quality:int = 1;
      
      private var _initQuality:int = 0;
      
      private var _temQuality:int = 1;
      
      public var coeStrengthLimit:int;
      
      public var coeIntellectLimit:int;
      
      public var coeStaminaLimit:int;
      
      public var coeArmorLimit:int;
      
      private var _petChallengeSkillsOfString:String;
      
      private var _petWarlordsSkillsOfString:String;
      
      private var _petMatelordsSkillsOfString:String;
      
      private var _petConsortiaSkillsOfString:String;
      
      private var _petFlameSkillsOfString:String;
      
      private var _petMonopolySkillsOfString:String;
      
      private var _petFastKeyOfString:String = "";
      
      private var _remotePetSkillsOfString:String;
      
      public function PetData()
      {
         super();
         _changeObj = new SimpleDictionary();
         _equipList = [];
      }
      
      public static function calculatefightPower(param1:PetData) : int
      {
         var _loc2_:int = 700;
         return int(_loc2_ + (param1.MagicAttack + param1.MagicDefence + param1.Attack + param1.Defence + param1.Live / 5));
      }
      
      public static function get upgradeTemplates() : Array
      {
         if(!_upgradeTemplates)
         {
            _upgradeTemplates = TempleteManager.instance.getTemplatesByType(25);
            _upgradeTemplates.sortOn("Grades",16);
         }
         return _upgradeTemplates;
      }
      
      public static function get maxGrade() : int
      {
         if(upgradeTemplates.length == 0)
         {
            return 0;
         }
         return upgradeTemplates[upgradeTemplates.length - 1].Grades;
      }
      
      public static function get qualityUpgradeTemplates() : Dictionary
      {
         var _loc1_:Array = null;
         if(!_qualityUpgradeTemplates)
         {
            _qualityUpgradeTemplates = new Dictionary();
            _loc1_ = TempleteManager.instance.getTemplatesByType(27);
            _loc1_.sortOn("Grades",16);
            _qualityUpgradeTemplates["1"] = _loc1_;
            _loc1_ = TempleteManager.instance.getTemplatesByType(29);
            _loc1_.sortOn("Grades",16);
            _qualityUpgradeTemplates["2"] = _loc1_;
            _loc1_ = TempleteManager.instance.getTemplatesByType(107);
            _loc1_.sortOn("Grades",16);
            _qualityUpgradeTemplates["3"] = _loc1_;
         }
         return _qualityUpgradeTemplates;
      }
      
      public static function tempToQuality(param1:int) : int
      {
         if(param1 < 26)
         {
            return (param1 - 1) / 5 + 1;
         }
         return (param1 - 1) / 5;
      }
      
      public static function tempToStar(param1:int) : int
      {
         var _loc2_:int = 0;
         if(param1 < 21)
         {
            _loc2_ = param1 % 5;
            _loc2_ = int(_loc2_ == 0 ? 5 : _loc2_);
         }
         else
         {
            _loc2_ = param1 % 10;
            _loc2_ = int(_loc2_ == 0 ? 10 : _loc2_);
         }
         return _loc2_;
      }
      
      public static function calculateCoeLimit(param1:PetTemplate, param2:int, param3:String) : int
      {
         var _loc11_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = tempToQuality(param2);
         var _loc8_:int = tempToStar(param2);
         var _loc6_:int = _loc10_ == 5 ? 10 : 5;
         var _loc9_:int = param1.TemplateId + _loc10_ - param1.Quality;
         var _loc5_:PetTemplate = TempleteManager.instance.petTemplateCate.getTemplateById(_loc9_);
         var _loc4_:PetTemplate = TempleteManager.instance.petTemplateCate.getTemplateById(_loc9_ + 1);
         if(_loc5_ == null)
         {
            return 0;
         }
         switch(param3)
         {
            case "PowerCoeLimit":
               _loc11_ = _loc5_.InitPowerCoeLimit;
               if(_loc4_ == null)
               {
                  return _loc11_;
               }
               _loc7_ = _loc4_.InitPowerCoeLimit;
               break;
            case "IntelCoeLimit":
               _loc11_ = _loc5_.InitIntelCoeLimit;
               if(_loc4_ == null)
               {
                  return _loc11_;
               }
               _loc7_ = _loc4_.InitIntelCoeLimit;
               break;
            case "PhysiCoeLimit":
               _loc11_ = _loc5_.InitPhysiCoeLimit;
               if(_loc4_ == null)
               {
                  return _loc11_;
               }
               _loc7_ = _loc4_.InitPhysiCoeLimit;
               break;
            case "ArmorCoeLimit":
               _loc11_ = _loc5_.InitArmorCoeLimit;
               if(_loc4_ == null)
               {
                  return _loc11_;
               }
               _loc7_ = _loc4_.InitArmorCoeLimit;
               break;
            case "lateCoeLimit":
               _loc11_ = _loc5_.GrowthRate;
               if(_loc4_ == null)
               {
                  return _loc11_;
               }
               _loc7_ = _loc4_.GrowthRate;
               break;
            case "CoeStrength":
               _loc11_ = _loc5_.InitPowerCoeLimitMin;
               if(_loc4_ == null)
               {
                  return _loc11_;
               }
               _loc7_ = _loc4_.InitPowerCoeLimitMin;
               break;
            case "CoeArmor":
               _loc11_ = _loc5_.InitArmorCoeLimitMin;
               if(_loc4_ == null)
               {
                  return _loc11_;
               }
               _loc7_ = _loc4_.InitArmorCoeLimitMin;
               break;
            case "CoeIntellect":
               _loc11_ = _loc5_.InitIntelCoeLimitMin;
               if(_loc4_ == null)
               {
                  return _loc11_;
               }
               _loc7_ = _loc4_.InitIntelCoeLimitMin;
               break;
            case "CoeStamina":
               _loc11_ = _loc5_.InitPhysiCoeLimitMin;
               if(_loc4_ == null)
               {
                  return _loc11_;
               }
               _loc7_ = _loc4_.InitPhysiCoeLimitMin;
         }
         return _loc11_ + int((_loc7_ - _loc11_) / _loc6_) * (_loc8_ - 1);
      }
      
      public static function calculateCoeLimitMin(param1:int, param2:PetTemplate, param3:int, param4:String) : int
      {
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:int = tempToQuality(param3);
         var _loc10_:int = tempToStar(param3);
         var _loc8_:int = _loc11_ == 5 ? 10 : 5;
         var _loc12_:int = param2.TemplateId + _loc11_ - param2.Quality;
         var _loc7_:PetTemplate = TempleteManager.instance.petTemplateCate.getTemplateById(_loc12_);
         var _loc5_:PetTemplate = TempleteManager.instance.petTemplateCate.getTemplateById(_loc12_ + 1);
         if(_loc7_ == null)
         {
            return 0;
         }
         _loc6_ = calculateCoeLimit(param2,param3 - 1,param4);
         switch(param4)
         {
            case "CoeStrength":
               _loc13_ = _loc7_.InitPowerCoeLimitMin;
               if(_loc5_ == null)
               {
                  return _loc13_ + (param1 - _loc6_);
               }
               _loc9_ = _loc5_.InitPowerCoeLimitMin;
               break;
            case "CoeArmor":
               _loc13_ = _loc7_.InitArmorCoeLimitMin;
               if(_loc5_ == null)
               {
                  return _loc13_ + (param1 - _loc6_);
               }
               _loc9_ = _loc5_.InitArmorCoeLimitMin;
               break;
            case "CoeIntellect":
               _loc13_ = _loc7_.InitIntelCoeLimitMin;
               if(_loc5_ == null)
               {
                  return _loc13_ + (param1 - _loc6_);
               }
               _loc9_ = _loc5_.InitIntelCoeLimitMin;
               break;
            case "CoeStamina":
               _loc13_ = _loc7_.InitPhysiCoeLimitMin;
               if(_loc5_ == null)
               {
                  return _loc13_ + (param1 - _loc6_);
               }
               _loc9_ = _loc5_.InitPhysiCoeLimitMin;
         }
         return _loc13_ + int((_loc9_ - _loc13_) / _loc8_) * (_loc10_ - 1) + (param1 - _loc6_);
      }
      
      public static function createWithMsg(param1:PetInfoMsg, param2:PetData = null) : PetData
      {
         if(!param2)
         {
            param2 = new PetData();
         }
         if(param1.hasPetId)
         {
            param2.petId = param1.petId;
         }
         if(param1.hasTemplateId)
         {
            param2.templateId = param1.templateId;
         }
         if(param1.hasPetName)
         {
            param2.name = param1.petName;
         }
         if(param1.hasCurGp)
         {
            param2.curExp = param1.curGp;
         }
         if(param1.hasTotalGp)
         {
            param2.totalExp = Int64Utils.int64ToNumber(param1.totalGp);
         }
         if(param1.hasCurGrade)
         {
            param2.grade = param1.curGrade;
         }
         if(param1.hasFightingCapacity)
         {
            param2.fightPower = param1.fightingCapacity;
         }
         if(param1.hasQuality)
         {
            if(param1.quality < 26)
            {
               param2.quality = (param1.quality - 1) / 5 + 1;
            }
            else
            {
               param2.quality = (param1.quality - 1) / 5;
            }
            param2.temQuality = param1.quality;
         }
         if(param1.hasInitQuality)
         {
            param2.initQuality = param1.initQuality;
         }
         if(param1.hasCurQualityGp)
         {
            param2.qualityGp = param1.curQualityGp;
         }
         if(param1.hasIsFight)
         {
            param2.isEnterWar = param1.isFight;
         }
         if(param1.hasIsChildFight)
         {
            param2.isChildWar = param1.isChildFight;
         }
         if(param1.hasIsBind)
         {
            param2.isBind = param1.isBind;
         }
         if(param1.hasPower)
         {
            param2.strength = param1.power;
         }
         if(param1.hasIntel)
         {
            param2.intellect = param1.intel;
         }
         if(param1.hasPhysi)
         {
            param2.stamina = param1.physi;
         }
         if(param1.hasArmor)
         {
            param2.armor = param1.armor;
         }
         if(param1.hasRemainPoints)
         {
            param2.remainPoint = param1.remainPoints;
         }
         if(param1.hasInitPowerApti)
         {
            param2.coeStrengthBase = param1.initPowerApti;
         }
         if(param1.hasInitIntelApti)
         {
            param2.coeIntellectBase = param1.initIntelApti;
         }
         if(param1.hasInitPhysiApti)
         {
            param2.coeStaminaBase = param1.initPhysiApti;
         }
         if(param1.hasInitArmorApti)
         {
            param2.coeArmorBase = param1.initArmorApti;
         }
         if(param1.hasPowerApti)
         {
            param2.coeStrength = param1.powerApti;
         }
         if(param1.hasIntelApti)
         {
            param2.coeIntellect = param1.intelApti;
         }
         if(param1.hasPhysiApti)
         {
            param2.coeStamina = param1.physiApti;
         }
         if(param1.hasArmorApti)
         {
            param2.coeArmor = param1.armorApti;
         }
         if(param1.hasFireResi)
         {
            param2.resFire = param1.fireResi;
         }
         if(param1.hasWaterResi)
         {
            param2.resWater = param1.waterResi;
         }
         if(param1.hasElectResi)
         {
            param2.resElect = param1.electResi;
         }
         if(param1.hasWindResi)
         {
            param2.resWind = param1.windResi;
         }
         if(param1.hasDarkResi)
         {
            param2.resDark = param1.darkResi;
         }
         if(param1.lightResi)
         {
            param2.resLight = param1.lightResi;
         }
         if(param1.hasFollowSkills)
         {
            param2.followSkills = param1.followSkills;
         }
         if(param1.hasChangeSkills)
         {
            param2.changeSkills = param1.changeSkills;
         }
         if(param1.hasChaSkillIndexs)
         {
            param2.petChallengeSkillsOfString = param1.chaSkillIndexs;
         }
         if(param1.hasLordsSkillIndexs)
         {
            param2.petWarlordsSkillsOfString = param1.lordsSkillIndexs;
         }
         if(param1.hasMateLordsSkillIndexs)
         {
            param2.petMatelordsSkillsOfString = param1.mateLordsSkillIndexs;
         }
         if(param1.hasMonopolySkillIndexs)
         {
            param2.petMonopolySkillsOfString = param1.monopolySkillIndexs;
         }
         if(param1.hasConsortiaSkillIndexs)
         {
            param2.petConsortiaSkillsOfString = param1.consortiaSkillIndexs;
         }
         if(param1.hasTransferSkillIndexs)
         {
            param2.petFlameSkillsOfString = param1.transferSkillIndexs;
         }
         if(param1.hasFastKey)
         {
            param2.petFastKeyOfString = param1.fastKey;
         }
         if(param1.hasPosition)
         {
            param2.pos = param1.position;
         }
         if(param1.hasIsLocked)
         {
            param2.isLock = param1.isLocked;
         }
         if(param1.hasBagAttack)
         {
            param2.equipPhysicalAttack = param1.bagAttack;
         }
         if(param1.hasBagDefence)
         {
            param2.equipPhysicalDefense = param1.bagDefence;
         }
         if(param1.hasBagMagicattack)
         {
            param2.equipMagicAttack = param1.bagMagicattack;
         }
         if(param1.hasBagMagicdefence)
         {
            param2.equipMagicDefense = param1.bagMagicdefence;
         }
         if(param1.hasBagLiving)
         {
            param2.equipHp = param1.bagLiving;
         }
         if(param1.hasRemoteHp)
         {
            param2.remoteHp = param1.remoteHp;
         }
         if(param1.hasRemotePetSkillIndexs)
         {
            param2.remotePetSkillsOfString = param1.remotePetSkillIndexs;
         }
         if(param1.hasIsRemote)
         {
            param2.isRemote = param1.isRemote;
         }
         return param2;
      }
      
      public static function createWidthString(param1:String) : PetData
      {
         if(StringHelper.isNullOrEmpty(param1))
         {
            return null;
         }
         var _loc5_:PetData = new PetData();
         var _loc2_:Array = param1.split("|");
         var _loc4_:Array = (_loc2_[0] as String).split(",");
         _loc5_.templateId = parseInt(_loc4_[0]);
         _loc5_.name = _loc5_.template.TemplateName;
         if(parseInt(_loc4_[1]) < 26)
         {
            _loc5_.quality = (parseInt(_loc4_[1]) - 1) / 5 + 1;
         }
         else
         {
            _loc5_.quality = (parseInt(_loc4_[1]) - 1) / 5;
         }
         _loc5_.temQuality = parseInt(_loc4_[1]);
         _loc5_.qualityGp = parseInt(_loc4_[2]);
         _loc5_.grade = parseInt(_loc4_[4]);
         _loc5_.curExp = parseInt(_loc4_[5]);
         _loc5_.totalExp = Number(_loc4_[6]);
         if(_loc4_[7])
         {
            _loc5_.initQuality = int(_loc4_[7]);
         }
         var _loc6_:Array = (_loc2_[1] as String).split(",");
         _loc5_.coeStrength = int(_loc6_[0]);
         _loc5_.coeIntellect = int(_loc6_[1]);
         _loc5_.coeStamina = int(_loc6_[2]);
         _loc5_.coeArmor = int(_loc6_[3]);
         _loc5_.strength = int(_loc6_[4]);
         _loc5_.intellect = int(_loc6_[5]);
         _loc5_.stamina = int(_loc6_[6]);
         _loc5_.armor = int(_loc6_[7]);
         _loc5_.remainPoint = (_loc5_.grade - 1) * 5 - (_loc5_.staminaAdd + _loc5_.strengthAdd + _loc5_.intellectAdd + _loc5_.armorAdd);
         var _loc3_:Array = (_loc2_[2] as String).split(",");
         _loc5_.resFire = int(_loc3_[0]);
         _loc5_.resWater = int(_loc3_[1]);
         _loc5_.resElect = int(_loc3_[2]);
         _loc5_.resWind = int(_loc3_[3]);
         _loc5_.resDark = int(_loc3_[4]);
         _loc5_.resLight = int(_loc3_[5]);
         _loc5_.followSkills = _loc2_[3] as String;
         _loc5_.changeSkills = _loc2_[4] as String;
         _loc5_.fightPower = PetData.calculatefightPower(_loc5_);
         return _loc5_;
      }
      
      public static function createWithXML(param1:XML) : PetData
      {
         var _loc3_:GoodsInfo = null;
         var _loc4_:PetData = new PetData();
         _loc4_.petId = parseInt(param1.@PetId);
         _loc4_.templateId = parseInt(param1.@TemplateId);
         _loc4_.name = param1.@PetName;
         _loc4_.isBind = param1.@IsBinding == "true" ? true : false;
         _loc4_.initQuality = parseInt(param1.@InitQuality);
         if(parseInt(param1.@Quality) < 26)
         {
            _loc4_.quality = (parseInt(param1.@Quality) - 1) / 5 + 1;
         }
         else
         {
            _loc4_.quality = (parseInt(param1.@Quality) - 1) / 5;
         }
         _loc4_.temQuality = parseInt(param1.@Quality);
         _loc4_.qualityGp = parseInt(param1.@CurQualityGp);
         _loc4_.grade = parseInt(param1.@CurGrade);
         _loc4_.curExp = parseInt(param1.@CurGp);
         _loc4_.totalExp = Number(param1.@TotalGp);
         _loc4_.coeStrength = int(param1.@PowerApt);
         _loc4_.coeIntellect = int(param1.@IntelApt);
         _loc4_.coeStamina = int(param1.@PhysiApt);
         _loc4_.coeArmor = int(param1.@ArmorApt);
         _loc4_.strength = int(param1.@Power);
         _loc4_.intellect = int(param1.@Intel);
         _loc4_.stamina = int(param1.@Physi);
         _loc4_.armor = int(param1.@Armor);
         _loc4_.remainPoint = (_loc4_.grade - 1) * 5 - (_loc4_.staminaAdd + _loc4_.strengthAdd + _loc4_.intellectAdd + _loc4_.armorAdd);
         _loc4_.resFire = int(param1.@FireResi);
         _loc4_.resWater = int(param1.@WaterResi);
         _loc4_.resElect = int(param1.@ElectResi);
         _loc4_.resWind = int(param1.@WindResi);
         _loc4_.resDark = int(param1.@DarkResi);
         _loc4_.resLight = int(param1.@LightResi);
         _loc4_.followSkills = param1.@FollowSkills;
         _loc4_.changeSkills = param1.@ChangeSkills;
         _loc4_.fightPower = int(param1.@FightCapacity);
         for each(var _loc2_:XML in param1..PetItemInfo)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_.@TemplateId;
            _loc3_.pos = _loc2_.@Pos;
            _loc3_.isBinds = _loc2_.@IsBinds;
            _loc3_.join1 = _loc2_.@Join1;
            _loc3_.join2 = _loc2_.@Join2;
            _loc3_.join3 = _loc2_.@Join3;
            _loc3_.join4 = _loc2_.@Join4;
            _loc3_.randomSkill1 = _loc2_.@RandomSkill1;
            _loc3_.randomSkill2 = _loc2_.@RandomSkill2;
            _loc3_.randomSkill3 = _loc2_.@RandomSkill3;
            _loc3_.randomSkill4 = _loc2_.@RandomSkill4;
            _loc3_.randomSkill5 = _loc2_.@RandomSkill5;
            _loc3_.mouldGrade = _loc2_.@MouldGrade;
            _loc4_.equipList.push(_loc3_);
         }
         return _loc4_;
      }
      
      public static function get petCarryLimit() : int
      {
         var _loc1_:ConfigInfosTempInfo = null;
         if(PetData._petCarryLimit <= 0)
         {
            PetData._petCarryLimit = 18;
            _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("pet_maxCount");
            if(_loc1_)
            {
               PetData._petCarryLimit = parseInt(_loc1_.ConfigValue);
            }
         }
         return PetData._petCarryLimit;
      }
      
      public function get equipList() : Array
      {
         return _equipList;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         if(_templateId == param1)
         {
            return;
         }
         _templateId = param1;
         template = TempleteManager.instance.petTemplateCate.getTemplateById(_templateId);
         updateCoeLimit();
      }
      
      public function get Live() : int
      {
         var _loc1_:int = Math.floor(6 * stamina * coeStamina / 1000);
         if(template)
         {
            _loc1_ += template.MaxHp;
         }
         return int(_loc1_ + (equipHp + getHallowsAddValueByIndex(3)));
      }
      
      public function get hpAdd() : int
      {
         return Math.ceil(staminaAdd * 6 * coeStamina / 1000) + equipHp + getHallowsAddValueByIndex(3);
      }
      
      public function get hpBase() : int
      {
         return Live - hpAdd;
      }
      
      private function get growWithGrade() : Number
      {
         return growthRate / 80;
      }
      
      public function get strengthBase() : int
      {
         var _loc1_:int = 0;
         if(template)
         {
            _loc1_ += template.Power;
         }
         return int(_loc1_ + Math.floor((grade - 1) * growWithGrade));
      }
      
      public function get intellectBase() : int
      {
         var _loc1_:int = 0;
         if(template)
         {
            _loc1_ += template.Intel;
         }
         return int(_loc1_ + Math.floor((grade - 1) * growWithGrade));
      }
      
      public function get staminaBase() : int
      {
         var _loc1_:int = 0;
         if(template)
         {
            _loc1_ += template.Physi;
         }
         return int(_loc1_ + Math.floor((grade - 1) * growWithGrade));
      }
      
      public function get armorBase() : int
      {
         var _loc1_:int = 0;
         if(template)
         {
            _loc1_ += template.Armor;
         }
         return int(_loc1_ + Math.floor((grade - 1) * growWithGrade));
      }
      
      public function get strengthAdd() : int
      {
         return strength - strengthBase;
      }
      
      public function get intellectAdd() : int
      {
         return intellect - intellectBase;
      }
      
      public function get staminaAdd() : int
      {
         return stamina - staminaBase;
      }
      
      public function get armorAdd() : int
      {
         return armor - armorBase;
      }
      
      public function get coeStrengthAdd() : int
      {
         return coeStrength - coeStrengthBase;
      }
      
      public function get coeIntellectAdd() : int
      {
         return coeIntellect - coeIntellectBase;
      }
      
      public function get coeStaminaAdd() : int
      {
         return coeStamina - coeStaminaBase;
      }
      
      public function get coeArmorAdd() : int
      {
         return coeArmor - coeArmorBase;
      }
      
      public function get coeStrengthAutoAdd() : int
      {
         var _loc1_:Number = Math.pow(1.2,quality - initQuality) - 1;
         var _loc2_:PetTemplate = TempleteManager.instance.petTemplateCate.getQualityGradeTemplate(template,initQuality);
         if(_loc2_)
         {
            _loc1_ = _loc2_.InitPowerCoeLimitMin * _loc1_;
         }
         return int(_loc1_);
      }
      
      public function get coeIntellectAutoAdd() : int
      {
         var _loc1_:Number = Math.pow(1.2,quality - initQuality) - 1;
         var _loc2_:PetTemplate = TempleteManager.instance.petTemplateCate.getQualityGradeTemplate(template,initQuality);
         if(_loc2_)
         {
            _loc1_ = _loc2_.InitIntelCoeLimitMin * _loc1_;
         }
         return _loc1_;
      }
      
      public function get coeStaminaAutoAdd() : int
      {
         var _loc1_:Number = Math.pow(1.2,quality - initQuality) - 1;
         var _loc2_:PetTemplate = TempleteManager.instance.petTemplateCate.getQualityGradeTemplate(template,initQuality);
         if(_loc2_)
         {
            _loc1_ = _loc2_.InitPhysiCoeLimitMin * _loc1_;
         }
         return _loc1_;
      }
      
      public function get coeArmorAutoAdd() : int
      {
         var _loc1_:Number = Math.pow(1.2,quality - initQuality) - 1;
         var _loc2_:PetTemplate = TempleteManager.instance.petTemplateCate.getQualityGradeTemplate(template,initQuality);
         if(_loc2_)
         {
            _loc1_ = _loc2_.InitArmorCoeLimitMin * _loc1_;
         }
         return _loc1_;
      }
      
      public function get MagicAttack() : int
      {
         return Math.floor(intellect * 1.8 * coeIntellect / 1000) + equipMagicAttack + getHallowsAddValueByIndex(0);
      }
      
      public function get magicAttackBase() : int
      {
         return Math.floor(intellectBase * 1.8 * coeIntellect / 1000);
      }
      
      public function get magicAttackAdd() : int
      {
         return MagicAttack - magicAttackBase;
      }
      
      public function get MagicDefence() : int
      {
         return Math.floor((armor * 0.9 * coeArmor + intellect * 0.9 * coeIntellect) / 1000) + equipMagicDefense + getHallowsAddValueByIndex(2);
      }
      
      public function get magicDefenseBase() : int
      {
         return Math.floor((armorBase * 0.9 * coeArmor + intellect * 0.9 * coeIntellect) / 1000);
      }
      
      public function get magicDefenseAdd() : int
      {
         return MagicDefence - magicDefenseBase;
      }
      
      public function get Attack() : int
      {
         return Math.floor(strength * 1.8 * coeStrength / 1000) + equipPhysicalAttack + getHallowsAddValueByIndex(0);
      }
      
      public function get physicalAttackBase() : int
      {
         return Math.floor(strengthBase * 1.8 * coeStrength / 1000);
      }
      
      public function get physicalAttackAdd() : int
      {
         return Attack - physicalAttackBase;
      }
      
      public function get Defence() : int
      {
         return Math.floor((armor * 0.9 * coeArmor + strength * 0.9 * coeStrength) / 1000) + equipPhysicalDefense + getHallowsAddValueByIndex(1);
      }
      
      public function get physicalDefenseBase() : int
      {
         return Math.floor((armorBase * 0.9 * coeArmor + strength * 0.9 * coeStrength) / 1000);
      }
      
      public function get physicalDefenseAdd() : int
      {
         return Defence - physicalDefenseBase;
      }
      
      public function get resFireAdd() : int
      {
         return resFire - resFireBase;
      }
      
      public function get resFireBase() : int
      {
         if(template)
         {
            return template.FireResi;
         }
         return 0;
      }
      
      public function get resWaterAdd() : int
      {
         return resWater - resWaterBase;
      }
      
      public function get resWaterBase() : int
      {
         if(template)
         {
            return template.WaterResi;
         }
         return 0;
      }
      
      public function get resElectAdd() : int
      {
         return resElect - resElectBase;
      }
      
      public function get resElectBase() : int
      {
         if(template)
         {
            return template.ElectResi;
         }
         return 0;
      }
      
      public function get resWindAdd() : int
      {
         return resWind - resWindBase;
      }
      
      public function get resWindBase() : int
      {
         if(template)
         {
            return template.WindResi;
         }
         return 0;
      }
      
      public function get resDarkAdd() : int
      {
         return resDark - resDarkBase;
      }
      
      public function get resDarkBase() : int
      {
         if(template)
         {
            return template.DarkResi;
         }
         return 0;
      }
      
      public function get resLightAdd() : int
      {
         return resLight - resLightBase;
      }
      
      public function get resLightBase() : int
      {
         if(template)
         {
            return template.LightResi;
         }
         return 0;
      }
      
      public function get isPractice() : Boolean
      {
         return FarmManager.instance.checkIsPartice(petId);
      }
      
      public function get isDefenser() : Boolean
      {
         return FarmManager.instance.checkIsDefenser(petId);
      }
      
      public function get followSkills() : String
      {
         return _followSkills;
      }
      
      public function set followSkills(param1:String) : void
      {
         _followSkills = param1;
         followSkillTemplates = TempleteManager.instance.getSkillTemplateInfoByIds(param1);
      }
      
      public function get changeSkills() : String
      {
         return _changeSkills;
      }
      
      public function set changeSkills(param1:String) : void
      {
         _changeSkills = param1;
         changeSkillTemplates = TempleteManager.instance.getSkillTemplateInfoByIds(param1);
      }
      
      public function beginChanges() : void
      {
         _changeObj.clear();
      }
      
      public function commit() : void
      {
         dispatchEvent(new PetEvent("PETINFO_CHANGE",this));
      }
      
      public function get upgradeTemplte() : UpgradeTemplateInfo
      {
         return upgradeTemplates[grade];
      }
      
      public function get temQuality() : int
      {
         return _temQuality;
      }
      
      public function set temQuality(param1:int) : void
      {
         _temQuality = param1;
         if(_temQuality < 1)
         {
            _temQuality = 1;
         }
         updateCoeLimit();
      }
      
      public function get initQuality() : int
      {
         if(_initQuality == 0 && template)
         {
            return template.Quality;
         }
         return _initQuality;
      }
      
      public function set initQuality(param1:int) : void
      {
         _initQuality = param1;
      }
      
      public function getQuaityTotalGp() : int
      {
         var _loc2_:int = 0;
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc1_:int = qualityGp;
         var _loc3_:Array = PetData.qualityUpgradeTemplates[template.NeedGrade];
         var _loc5_:int;
         _loc2_ = _loc5_ = 0;
         while(_loc2_ < quality)
         {
            _loc4_ = _loc3_[_loc2_];
            if(_loc4_)
            {
               _loc1_ += _loc4_.Data;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get quality() : int
      {
         return _quality;
      }
      
      public function get growthRate() : int
      {
         return getGrowthRate(temQuality);
      }
      
      public function getGrowthRate(param1:int) : int
      {
         return calculateCoeLimit(template,param1,"lateCoeLimit");
      }
      
      public function set quality(param1:int) : void
      {
         _quality = param1;
         if(_quality < 1)
         {
            _quality = 1;
         }
      }
      
      private function updateCoeLimit() : void
      {
         if(!template)
         {
            return;
         }
         var _loc1_:PetTemplate = TempleteManager.instance.petTemplateCate.getQualityGradeTemplate(template,quality);
         this.coeStrengthLimit = PetData.calculateCoeLimit(template,temQuality,"PowerCoeLimit");
         this.coeIntellectLimit = PetData.calculateCoeLimit(template,temQuality,"IntelCoeLimit");
         this.coeStaminaLimit = PetData.calculateCoeLimit(template,temQuality,"PhysiCoeLimit");
         this.coeArmorLimit = PetData.calculateCoeLimit(template,temQuality,"ArmorCoeLimit");
      }
      
      private function findQualityUpgradeTemplateInfo(param1:int) : UpgradeTemplateInfo
      {
         var _loc2_:Array = PetData.qualityUpgradeTemplates[this.template.NeedGrade] as Array;
         for each(var _loc3_:UpgradeTemplateInfo in _loc2_)
         {
            if(_loc3_.Grades == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function get coeStrengthInit() : int
      {
         if(template)
         {
            return template.InitPowerCoeLimit;
         }
         return 0;
      }
      
      public function get coeIntellectInit() : int
      {
         if(template)
         {
            return template.InitIntelCoeLimit;
         }
         return 0;
      }
      
      public function get coeStaminaInit() : int
      {
         if(template)
         {
            return template.InitPhysiCoeLimit;
         }
         return 0;
      }
      
      public function get coeArmorInit() : int
      {
         if(template)
         {
            return template.InitArmorCoeLimit;
         }
         return 0;
      }
      
      public function get qualityUpgradeTemplateInfo() : UpgradeTemplateInfo
      {
         if(template.NeedGrade < 3 && temQuality == 30)
         {
            return null;
         }
         return findQualityUpgradeTemplateInfo(temQuality + 1);
      }
      
      public function get currentQualityUpgradeTemplateInfo() : UpgradeTemplateInfo
      {
         return findQualityUpgradeTemplateInfo(temQuality);
      }
      
      public function isFullRes() : Boolean
      {
         var _loc1_:Boolean = false;
         if(coeArmor >= coeArmorLimit && coeIntellect >= coeIntellectLimit && coeStamina >= coeStaminaLimit && coeStrength >= coeStrengthLimit)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function isFullExp() : Boolean
      {
         var _loc1_:int = 0;
         if(thaneInfo)
         {
            _loc1_ = thaneInfo.grades;
            if(this.grade == PetData.maxGrade)
            {
               return true;
            }
            if(this.grade > _loc1_ || this.grade == _loc1_ && this.curExp >= this.upgradeTemplte.Data)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkSkillIsLearned(param1:int) : Boolean
      {
         for each(var _loc2_:SkillTempInfo in changeSkillTemplates)
         {
            if(_loc2_.TemplateId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function convertToGoods() : GoodsInfo
      {
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.petData = this;
         _loc1_.count = 1;
         _loc1_.templateId = -900;
         _loc1_.isBinds = this.isBind;
         _loc1_.isLock = this.isLock;
         return _loc1_;
      }
      
      public function get activeSkillList() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:SkillTempInfo in changeSkillTemplates)
         {
            if(_loc1_.UseWay == 1)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function get passiveSkillList() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:SkillTempInfo in changeSkillTemplates)
         {
            if(_loc1_.UseWay == 2)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function get activeSkillIsFull() : Boolean
      {
         return activeSkillList.length >= 5;
      }
      
      public function get passiveSkillIsFull() : Boolean
      {
         return passiveSkillList.length >= 3;
      }
      
      public function get petChallengeSkillsOfString() : String
      {
         return _petChallengeSkillsOfString;
      }
      
      public function set petChallengeSkillsOfString(param1:String) : void
      {
         if(_petChallengeSkillsOfString == param1)
         {
            return;
         }
         _petChallengeSkillsOfString = param1;
         dispatchEvent(new PetEvent("PET_CHALLENGE_SKILL_CHANGE",this));
      }
      
      public function get petWarlordsSkillsOfString() : String
      {
         return _petWarlordsSkillsOfString;
      }
      
      public function set petWarlordsSkillsOfString(param1:String) : void
      {
         if(_petWarlordsSkillsOfString == param1)
         {
            return;
         }
         _petWarlordsSkillsOfString = param1;
         dispatchEvent(new PetEvent("PET_CHALLENGE_SKILL_CHANGE",this));
      }
      
      public function get petMatelordsSkillsOfString() : String
      {
         return _petMatelordsSkillsOfString;
      }
      
      public function set petMatelordsSkillsOfString(param1:String) : void
      {
         if(_petMatelordsSkillsOfString == param1)
         {
            return;
         }
         _petMatelordsSkillsOfString = param1;
         dispatchEvent(new PetEvent("PET_CHALLENGE_SKILL_CHANGE",this));
      }
      
      public function get petConsortiaSkillsOfString() : String
      {
         return _petConsortiaSkillsOfString;
      }
      
      public function set petConsortiaSkillsOfString(param1:String) : void
      {
         if(_petConsortiaSkillsOfString == param1)
         {
            return;
         }
         _petConsortiaSkillsOfString = param1;
         dispatchEvent(new PetEvent("PET_CHALLENGE_SKILL_CHANGE",this));
      }
      
      public function get petFlameSkillsOfString() : String
      {
         return _petFlameSkillsOfString;
      }
      
      public function set petFlameSkillsOfString(param1:String) : void
      {
         if(_petFlameSkillsOfString == param1)
         {
            return;
         }
         _petFlameSkillsOfString = param1;
         dispatchEvent(new PetEvent("PET_CHALLENGE_SKILL_CHANGE",this));
      }
      
      public function get petMonopolySkillsOfString() : String
      {
         return _petMonopolySkillsOfString;
      }
      
      public function set petMonopolySkillsOfString(param1:String) : void
      {
         if(_petMonopolySkillsOfString == param1)
         {
            return;
         }
         _petMonopolySkillsOfString = param1;
         dispatchEvent(new PetEvent("PET_CHALLENGE_SKILL_CHANGE",this));
      }
      
      public function get petFastKeyOfString() : String
      {
         return _petFastKeyOfString;
      }
      
      public function set petFastKeyOfString(param1:String) : void
      {
         if(_petFastKeyOfString == param1)
         {
            return;
         }
         _petFastKeyOfString = param1;
         dispatchEvent(new PetEvent("PET_SKILL_CHANGE",this));
      }
      
      public function get petChallengeSkillList() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = [null,null,null];
         if(!petChallengeSkillsOfString)
         {
            return _loc4_;
         }
         if(!_changeSkills)
         {
            return _loc4_;
         }
         var _loc1_:Array = petChallengeSkillsOfString.split(",");
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = parseInt(_loc1_[_loc2_]);
            if(isNaN(_loc3_) || _loc3_ < 0)
            {
               _loc4_[_loc2_] = null;
            }
            else
            {
               _loc4_[_loc2_] = changeSkillTemplates[_loc3_];
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get petWarlordsSkillList() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = [null,null,null];
         if(!petWarlordsSkillsOfString)
         {
            return _loc4_;
         }
         if(!_changeSkills)
         {
            return _loc4_;
         }
         var _loc1_:Array = petWarlordsSkillsOfString.split(",");
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = parseInt(_loc1_[_loc2_]);
            if(isNaN(_loc3_) || _loc3_ < 0)
            {
               _loc4_[_loc2_] = null;
            }
            else
            {
               _loc4_[_loc2_] = changeSkillTemplates[_loc3_];
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get petMatelordsSkillList() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = [null,null,null];
         if(!petMatelordsSkillsOfString)
         {
            return _loc4_;
         }
         if(!_changeSkills)
         {
            return _loc4_;
         }
         var _loc1_:Array = petMatelordsSkillsOfString.split(",");
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = parseInt(_loc1_[_loc2_]);
            if(isNaN(_loc3_) || _loc3_ < 0)
            {
               _loc4_[_loc2_] = null;
            }
            else
            {
               _loc4_[_loc2_] = changeSkillTemplates[_loc3_];
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get petMonopolySkillList() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = [null,null,null];
         if(!petMonopolySkillsOfString)
         {
            return _loc4_;
         }
         if(!_changeSkills)
         {
            return _loc4_;
         }
         var _loc1_:Array = petMonopolySkillsOfString.split(",");
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = parseInt(_loc1_[_loc2_]);
            if(isNaN(_loc3_) || _loc3_ < 0)
            {
               _loc4_[_loc2_] = null;
            }
            else
            {
               _loc4_[_loc2_] = changeSkillTemplates[_loc3_];
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get consortiaBossSkillList() : Array
      {
         return [null,null,null];
      }
      
      public function get petFlameSkillList() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = [null,null,null];
         if(!_petFlameSkillsOfString)
         {
            return _loc4_;
         }
         if(!_changeSkills)
         {
            return _loc4_;
         }
         var _loc1_:Array = _petFlameSkillsOfString.split(",");
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = parseInt(_loc1_[_loc2_]);
            if(isNaN(_loc3_) || _loc3_ < 0)
            {
               _loc4_[_loc2_] = null;
            }
            else
            {
               _loc4_[_loc2_] = changeSkillTemplates[_loc3_];
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get remotePetSkillsOfString() : String
      {
         return _remotePetSkillsOfString;
      }
      
      public function set remotePetSkillsOfString(param1:String) : void
      {
         if(_remotePetSkillsOfString == param1)
         {
            return;
         }
         _remotePetSkillsOfString = param1;
         dispatchEvent(new PetEvent("PET_CHALLENGE_SKILL_CHANGE",this));
      }
      
      public function get remotePetSkillList() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = [null,null,null];
         if(!_remotePetSkillsOfString)
         {
            return _loc4_;
         }
         if(!_changeSkills)
         {
            return _loc4_;
         }
         var _loc1_:Array = _remotePetSkillsOfString.split(",");
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = parseInt(_loc1_[_loc2_]);
            if(isNaN(_loc3_) || _loc3_ < 0)
            {
               _loc4_[_loc2_] = null;
            }
            else
            {
               _loc4_[_loc2_] = changeSkillTemplates[_loc3_];
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get petTypeLanguage() : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = LanguageMgr.GetTranslation("pet.petTypeList");
         var _loc1_:Array = _loc2_.split("|");
         if(template.PetType < 107)
         {
            _loc3_ = template.PetType - 100;
         }
         else if(template.PetType == 117)
         {
            _loc3_ = 7;
         }
         else if(template.PetType == 118)
         {
            _loc3_ = 8;
         }
         else if(template.PetType == 119)
         {
            _loc3_ = 9;
         }
         return _loc1_[_loc3_ - 1];
      }
      
      public function clone() : PetData
      {
         var _loc1_:PetData = new PetData();
         _loc1_.templateId = this.templateId;
         _loc1_.name = this.name;
         _loc1_.curExp = this.curExp;
         _loc1_.totalExp = this.totalExp;
         _loc1_.grade = this.grade;
         _loc1_.fightPower = this.fightPower;
         _loc1_.initQuality = this.initQuality;
         _loc1_.quality = this.quality;
         _loc1_.temQuality = this.temQuality;
         _loc1_.qualityGp = this.qualityGp;
         _loc1_.isEnterWar = this.isEnterWar;
         _loc1_.isBind = this.isBind;
         _loc1_.strength = this.strength;
         _loc1_.stamina = this.stamina;
         _loc1_.armor = this.armor;
         _loc1_.intellect = this.intellect;
         _loc1_.remainPoint = this.remainPoint;
         _loc1_.coeStrengthBase = this.coeStrengthBase;
         _loc1_.coeIntellectBase = this.coeIntellectBase;
         _loc1_.coeStaminaBase = this.coeStaminaBase;
         _loc1_.coeArmorBase = this.coeArmorBase;
         _loc1_.coeStrength = this.coeStrength;
         _loc1_.coeIntellect = this.coeIntellect;
         _loc1_.coeStamina = this.coeStamina;
         _loc1_.coeArmor = this.coeArmor;
         _loc1_.resFire = this.resFire;
         _loc1_.resWater = this.resWater;
         _loc1_.resElect = this.resElect;
         _loc1_.resWind = this.resWind;
         _loc1_.resDark = this.resDark;
         _loc1_.resLight = this.resLight;
         _loc1_.followSkills = this.followSkills;
         _loc1_.changeSkills = this.changeSkills;
         _loc1_.petChallengeSkillsOfString = this.petChallengeSkillsOfString;
         _loc1_.petWarlordsSkillsOfString = this.petWarlordsSkillsOfString;
         _loc1_.petMatelordsSkillsOfString = this.petMatelordsSkillsOfString;
         _loc1_.petMonopolySkillsOfString = this.petMonopolySkillsOfString;
         _loc1_.petConsortiaSkillsOfString = this.petConsortiaSkillsOfString;
         _loc1_.petFlameSkillsOfString = this.petFlameSkillsOfString;
         _loc1_.petFastKeyOfString = this.petFastKeyOfString;
         return _loc1_;
      }
      
      public function getLevelString() : String
      {
         var _loc1_:String = LanguageMgr.GetTranslation("pet.petTypeList");
         var _loc2_:Array = _loc1_.split("|");
         var _loc3_:int = int(this.template.PetType.toString().charAt(2));
         return LanguageMgr.GetTranslation("pet.needGradeTxt" + this.template.NeedGrade,_loc2_[_loc3_ - 1]);
      }
      
      public function getHallowsAddValueByIndex(param1:int) : int
      {
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         for each(var _loc2_:PetHallowsInfo in pethallowsModel.hallowsInfoList)
         {
            if(_loc2_.equipPetId == petId)
            {
               _loc3_ = TempleteManager.instance.getTemplateByLevelAndType(_loc2_["propAddGrade" + param1],127);
               _loc4_ = int(_loc2_["propAddValue" + param1]);
               _loc6_ = _loc3_ ? Math.floor(_loc4_ * _loc3_.ActiveObject / 100) : 0;
               _loc5_ = _loc4_ + _loc6_;
               break;
            }
         }
         return _loc5_;
      }
      
      private function get pethallowsModel() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
   }
}

