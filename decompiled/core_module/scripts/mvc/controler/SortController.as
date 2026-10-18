package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.FrameController;
   import mvc.module.avenger.AvengerDevilArmorHoleInfo;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.avenger.AvengerSkillInfo;
   import mvc.module.card.MagicCardFightInfo;
   import mvc.module.children.ChildData;
   import mvc.module.dragonTitan.DragonTitanData;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import mvc.module.goddess.GoddessEquipInfo;
   import mvc.module.goddess.GoddessInfo;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.pet.PetData;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.sort.SortData;
   import mvc.module.sort.SortModel;
   import mvc.module.star.StarInfo;
   import mvc.module.star.StarTroughInfo;
   import mvc.module.tattoo.TattooHole;
   import mvc.module.tattoo.TattooHoleInfoII;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import mvc.module.theseus.TheseusYiCellInfo;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import mvc.module.theseus.WarSoulModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ArtifactThaneInfo;
   import yishi.datas.playerinfo.BattleGuardInfo;
   import yishi.datas.playerinfo.BattleGuardSocketInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.SimpleMountInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   import yishi.view.community.LoadingSceneView;
   
   public class SortController extends FrameController
   {
      
      private var _model:SortModel;
      
      private var _loadNum:int;
      
      private var _progressDic:Dictionary = new Dictionary(true);
      
      private var _loadRecall:Function;
      
      private var _localxmlNum:int = 6;
      
      private var _crossxmlNum:int = 6;
      
      public function SortController()
      {
         super();
         _model = new SortModel();
      }
      
      private static function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public static function read(param1:XML) : SortData
      {
         var _loc55_:int = 0;
         var _loc45_:MagicCardFightInfo = null;
         var _loc24_:Array = null;
         var _loc8_:int = 0;
         var _loc57_:int = 0;
         var _loc14_:int = 0;
         var _loc13_:DragonTalkerSymbioteInfo = null;
         var _loc53_:DragonTalkerTalismanInfo = null;
         var _loc69_:GoodsInfo = null;
         var _loc31_:StarInfo = null;
         var _loc20_:StarTroughInfo = null;
         var _loc49_:MagicCardFightInfo = null;
         var _loc71_:PetData = null;
         var _loc21_:ChildData = null;
         var _loc11_:BattleGuardSocketInfo = null;
         var _loc39_:int = 0;
         var _loc27_:int = 0;
         var _loc34_:int = 0;
         var _loc61_:TattooHole = null;
         var _loc19_:TattooHoleInfoII = null;
         var _loc67_:PetHallowsInfo = null;
         var _loc56_:GoddessEquipInfo = null;
         var _loc30_:AvengerSkillInfo = null;
         var _loc3_:AvengerDevilArmorHoleInfo = null;
         var _loc41_:int = 0;
         var _loc62_:WarFrameItemInfo = null;
         var _loc60_:String = null;
         var _loc23_:Array = null;
         var _loc26_:Array = null;
         var _loc33_:TheseusYiCellInfo = null;
         var _loc59_:TheseusWarsoulItemInfo = null;
         var _loc38_:GoodsInfo = null;
         var _loc52_:SortData = new SortData();
         _loc52_.uuid = param1.@uuid;
         _loc52_.orderId = int(param1.@orderId);
         _loc52_.nikcName = param1.@nikcName;
         _loc52_.grades = int(param1.@grades);
         _loc52_.gp = Number(param1.@gp);
         _loc52_.fightCapacity = int(param1.@fightCapaity);
         _loc52_.multipleCapacity = int(param1.@FightCapacity);
         _loc52_.consortiaName = String(param1.@ConsortiaName);
         _loc52_.HideFashion = param1.@HideFashion == "true" ? true : false;
         _loc52_.consortiaLevel = int(param1.@Levels);
         _loc52_.offer = int(param1.@Offer);
         _loc52_.consortiaFightPower = Number(param1.@FightPower);
         _loc52_.selfHonour = int(param1.@CurrentGeste);
         _loc52_.charms = int(param1.@charm);
         _loc52_.pvpScore = int(param1.@weekScore);
         _loc52_.soulScore = int(param1.@CurrentSoulScore);
         _loc52_.serverName = LanguageMgr.GetTranslation("sort.serverName",String(param1.@serverId));
         _loc52_.regressTime = String(param1.@ReturnedTime);
         _loc52_.activeMagicCards = [];
         var _loc43_:String = param1.@MagicCards;
         var _loc68_:Array = _loc43_.split("|");
         _loc55_ = 0;
         while(_loc55_ < _loc68_.length)
         {
            _loc45_ = new MagicCardFightInfo();
            _loc45_.templeteId = String(_loc68_[_loc55_]).split(",")[0];
            _loc45_.gardes = String(_loc68_[_loc55_]).split(",")[1];
            _loc52_.activeMagicCards.push(_loc45_);
            _loc55_++;
         }
         _loc52_.army.nickName = param1.@nikcName;
         _loc52_.army.baseHero.userId = int(param1.@userid);
         _loc52_.army.baseHero.templateId = int(param1.@Job);
         _loc52_.army.baseHero.baseTemplateId = int(param1.@baseJob);
         if(_loc52_.army.baseHero.templateId == 0)
         {
            _loc52_.army.baseHero.templateId = int(param1.@job);
         }
         _loc52_.army.baseHero.grades = int(param1.@grades);
         _loc52_.army.baseHero.gp = int(param1.@CurrentGp);
         _loc52_.army.baseHero.IsVipAndNoExpirt = param1.@IsVip == "true" ? true : false;
         _loc52_.army.baseHero.vipType = int(param1.@VipType);
         _loc52_.army.baseHero.jewelGrades = int(param1.@StoreGrade);
         _loc52_.army.baseHero.conciseGrades = int(param1.@EquipmentRefiningGrade);
         _loc52_.army.baseHero.seniorStoreGrade = int(param1.@SeniorStoreGrade);
         _loc52_.army.baseHero.fateTotalGp = int(param1.@fateTotalGp);
         _loc52_.army.baseHero.fateGrades = String(param1.@fateGrades);
         _loc52_.army.baseHero.nickName = param1.@nikcName;
         _loc52_.army.baseHero.consortiaName = param1.@constainName;
         _loc52_.army.baseHero.consortiaID = param1.@ConsortiaId;
         _loc52_.army.baseHero.playerOrdeInfo.gpDayOrder = int(param1.@gpOrde);
         _loc52_.army.baseHero.playerOrdeInfo.gpWeekOrder = int(param1.@gpOrde);
         _loc52_.army.baseHero.playerOrdeInfo.gpOrder = int(param1.@CurrentOrder);
         _loc52_.army.baseHero.playerOrdeInfo.fightCapacityOrder = int(param1.@gpOrde);
         _loc52_.army.baseHero.playerOrdeInfo.multipleApOrder = int(param1.@gpOrde);
         _loc52_.army.baseHero.playerOrdeInfo.honourOrder = int(param1.@CurrentOrder);
         _loc52_.army.baseHero.playerOrdeInfo.charmsOrder = int(param1.@charmOrder);
         _loc52_.army.baseHero.fightingCapacity = param1.@fightCapaity;
         _loc52_.army.baseHero.attackProrerty.totalParry = param1.@parry;
         _loc52_.army.baseHero.attackProrerty.totalPhyAttack = param1.@totalPhyAttack;
         _loc52_.army.baseHero.attackProrerty.totalPhyDefence = param1.@totalPhyDefence;
         _loc52_.army.baseHero.attackProrerty.totalMagicAttack = param1.@totalMagicAttack;
         _loc52_.army.baseHero.attackProrerty.totalMagicDefence = param1.@totalMagicDefence;
         _loc52_.army.baseHero.attackProrerty.totalForceHit = param1.@totalForceHit;
         _loc52_.army.baseHero.attackProrerty.totalConatArmy = param1.@totalConatArmy;
         _loc52_.army.baseHero.attackProrerty.totalLive = param1.@live;
         _loc52_.army.baseHero.attackProrerty.totalTenacity = param1.@Tenacity;
         _loc52_.army.baseHero.attackProrerty.totalIntensity = param1.@Strength;
         _loc52_.army.baseHero.attackProrerty.totalPenetrate = param1.@Penetrate;
         _loc52_.army.baseHero.attackProrerty.totalDingli = param1.@StunAttr;
         _loc52_.army.baseHero.baseProperty.totalPower = param1.@power;
         _loc52_.army.baseHero.baseProperty.totalAgility = param1.@agility;
         _loc52_.army.baseHero.baseProperty.totalIntellect = param1.@intellect;
         _loc52_.army.baseHero.baseProperty.totalCaptain = param1.@captain;
         _loc52_.army.baseHero.baseProperty.totalPhysique = param1.@physique;
         _loc52_.army.baseHero.baseProperty.totalBattleWill = param1.@totalBattleWill;
         _loc52_.army.baseHero.baseProperty.totalFireResi = param1.@totalFireResi;
         _loc52_.army.baseHero.baseProperty.totalWaterResi = param1.@totalWaterResi;
         _loc52_.army.baseHero.baseProperty.totalWindResi = param1.@totalWindResi;
         _loc52_.army.baseHero.baseProperty.totalElecResi = param1.@totalElecResi;
         _loc52_.army.baseHero.baseProperty.totalLightResi = param1.@totalLightResi;
         _loc52_.army.baseHero.baseProperty.totalDarkResi = param1.@totalDarkResi;
         _loc52_.army.baseHero.baseProperty.totalStrikeResi = param1.@totalResiPenetrate;
         _loc52_.army.baseHero.baseProperty.totalResistResi = param1.@totalReduceResiAgainst;
         _loc52_.army.baseHero.baseProperty.fashionPower = param1.@fashionPower;
         _loc52_.army.baseHero.baseProperty.fashionAgility = param1.@fashionArmor;
         _loc52_.army.baseHero.baseProperty.fashionIntellect = param1.@fashionIntellect;
         _loc52_.army.baseHero.baseProperty.fashionPhysigue = param1.@fashionPhysique;
         _loc52_.army.baseHero.baseProperty.hasSetFashionProperty = true;
         _loc52_.army.baseHero.charms = int(param1.@totalCharm);
         _loc52_.army.baseHero.honer = int(param1.@geste);
         _loc52_.army.baseHero.appellId = int(param1.@appellId);
         _loc52_.army.baseHero.nickNameB = String(param1.@NickNameB);
         _loc52_.army.baseHero.marryRingGrade = int(param1.@RingGrade);
         _loc52_.army.baseHero.isXmlItem = true;
         _loc52_.army.baseHero.isOpenDragonTalker = false;
         for each(var _loc44_:XML in param1.DragonTalkerInfo)
         {
            _loc52_.army.baseHero.isOpenDragonTalker = true;
            _loc52_.army.baseHero.dragonTalkerInfo.isDragonTalker = _loc44_.@IsNowDragonTalker == "true" ? true : false;
            _loc52_.army.baseHero.dragonTalkerInfo.battleBeastId = int(_loc44_.@CurrentFightMount);
            _loc52_.army.baseHero.dragonTalkerInfo.fightMountGp = int(_loc44_.@FightMountGp);
            _loc52_.army.baseHero.dragonTalkerInfo.dragonFashionWing = int(_loc44_.@DragonFashionWing);
            _loc52_.army.baseHero.dragonTalkerInfo.dragonFashionHat = int(_loc44_.@DragonFashionHat);
            _loc52_.army.baseHero.dragonTalkerInfo.dragonFashionArm = int(_loc44_.@DragonFashionArm);
            _loc52_.army.baseHero.dragonTalkerInfo.dragonFashionCloth = int(_loc44_.@DragonFashionCloth);
            _loc52_.army.baseHero.dragonTalkerInfo.symbiontList = [];
            _loc24_ = _loc44_.@SymbiontGp.split(",");
            _loc8_ = int(_loc24_.length);
            _loc57_ = 0;
            while(_loc57_ < _loc8_)
            {
               _loc14_ = int(_loc24_[_loc57_]);
               _loc13_ = new DragonTalkerSymbioteInfo();
               _loc13_.index = _loc57_;
               _loc13_.currentExp = _loc14_;
               _loc52_.army.baseHero.dragonTalkerInfo.symbiontList.push(_loc13_);
               _loc57_++;
            }
            _loc52_.army.baseHero.dragonTalkerInfo.talismanList = [];
            for each(var _loc66_:XML in _loc44_..TalismanInfo)
            {
               _loc53_ = new DragonTalkerTalismanInfo();
               _loc53_.tempId = _loc66_.@TemplateId;
               _loc53_.equipPos = _loc66_.@Equipslot;
               _loc53_.grade = _loc66_.@Grade;
               _loc53_.exp = _loc66_.@Gp;
               _loc53_.randomSkillList = _loc66_.@RandomSkillList.split(",");
               _loc53_.count = _loc66_.@Count;
               _loc53_.isSelf = false;
               _loc52_.army.baseHero.dragonTalkerInfo.talismanList.push(_loc53_);
            }
         }
         for each(var _loc6_:XML in param1..PlayerSNSInfo)
         {
            _loc52_.army.baseHero.snsInfo.userId = _loc6_.@userId;
            _loc52_.army.baseHero.snsInfo.nickName = _loc52_.army.nickName;
            _loc52_.army.baseHero.snsInfo.headId = _loc6_.@HeadId;
            _loc52_.army.baseHero.snsInfo.sign = _loc6_.@randomSkill1;
            _loc52_.army.baseHero.snsInfo.sex = _loc6_.@Sex;
            _loc52_.army.baseHero.snsInfo.birthdayType = _loc6_.@BirthdayType;
            _loc52_.army.baseHero.snsInfo.birthYear = _loc6_.@BirthYear;
            _loc52_.army.baseHero.snsInfo.birthMonth = _loc6_.@BirthMonth;
            _loc52_.army.baseHero.snsInfo.birthDay = _loc6_.@BirthDay;
            _loc52_.army.baseHero.snsInfo.horoscope = _loc6_.@StarId;
            _loc52_.army.baseHero.snsInfo.bloodType = _loc6_.@BloodType;
            _loc52_.army.baseHero.snsInfo.country = _loc6_.@Country;
            _loc52_.army.baseHero.snsInfo.province = _loc6_.@Province;
            _loc52_.army.baseHero.snsInfo.city = _loc6_.@City;
            _loc52_.army.baseHero.snsInfo.sign = _loc6_.@Desc;
         }
         for each(_loc6_ in param1..Item)
         {
            _loc69_ = new GoodsInfo();
            _loc69_.id = _loc6_.@id;
            _loc69_.pos = _loc6_.@pos;
            _loc69_.objectId = _loc6_.@objectId;
            _loc69_.bagType = _loc6_.@bagType;
            _loc69_.templateId = _loc6_.@templateId;
            _loc69_.isBinds = sloveBooblean(String(_loc6_.@isBinds));
            _loc69_.strengthenGrade = _loc6_.@strengthenGrade;
            _loc69_.join1 = _loc6_.@join1;
            _loc69_.join2 = _loc6_.@join2;
            _loc69_.join3 = _loc6_.@join3;
            _loc69_.join4 = _loc6_.@join4;
            _loc69_.randomSkill1 = _loc6_.@randomSkill1;
            _loc69_.randomSkill2 = _loc6_.@randomSkill2;
            _loc69_.randomSkill3 = _loc6_.@randomSkill3;
            _loc69_.randomSkill4 = _loc6_.@randomSkill4;
            _loc69_.randomSkill5 = _loc6_.@randomSkill5;
            _loc69_.mouldGrade = _loc6_.@mouldGrade;
            _loc52_.army.baseHero.id = _loc6_.@objectId;
            _loc69_.appraisal_skill = _loc6_.@appraisalSkill;
            _loc52_.army.baseHero.equipDic[_loc69_.pos + "_" + _loc69_.objectId + "_" + _loc69_.bagType] = _loc69_;
         }
         for each(_loc6_ in param1..StarInfo)
         {
            _loc31_ = new StarInfo();
            _loc31_.id = _loc6_.@id;
            _loc31_.userId = _loc6_.@userId;
            _loc31_.bagType = _loc6_.@bagType;
            _loc31_.pos = _loc6_.@pos;
            _loc31_.tempId = _loc6_.@templateId;
            _loc31_.grade = _loc6_.@grade;
            _loc31_.gp = _loc6_.@gp;
            _loc52_.army.baseHero.equipDic[_loc31_.pos + "_0_" + _loc31_.bagType] = _loc31_;
         }
         for each(_loc6_ in param1..StarAdditionInfo)
         {
            _loc20_ = new StarTroughInfo();
            _loc20_.pos = _loc6_.@pos;
            _loc20_.grade = _loc6_.@grade;
            _loc52_.army.baseHero.starTroughs[_loc6_.@pos] = _loc20_;
         }
         _loc52_.cardFightInfoList = new Vector.<MagicCardFightInfo>();
         for each(_loc6_ in param1..PowCardFightInfo)
         {
            _loc49_ = new MagicCardFightInfo();
            _loc49_.op = _loc6_.@op;
            _loc49_.userId = _loc6_.@userId;
            _loc49_.campType = _loc6_.@camptype;
            _loc49_.add = _loc6_.@add;
            _loc52_.cardFightInfoList.push(_loc49_);
         }
         for each(var _loc12_:XML in param1..PetInfo)
         {
            _loc71_ = PetData.createWithXML(_loc12_);
            _loc71_.isEnterWar = true;
            _loc52_.army.baseHero.addPet(_loc71_);
         }
         for each(var _loc25_:XML in param1..ChildInfo)
         {
            _loc21_ = ChildData.createChildWithXML(_loc25_);
            _loc52_.army.baseHero.addEnterWarChild(_loc21_);
         }
         for each(var _loc15_:XML in param1.MountInfo)
         {
            _loc52_.army.baseHero.mountInfo = SimpleMountInfo.createFromXml(_loc15_);
            if(_loc52_.army.baseHero.vocationGrades <= 0)
            {
               _loc52_.army.baseHero.mountInfo.star = -1;
            }
         }
         if(!_loc52_.army.baseHero.battleGuardInfo)
         {
            _loc52_.army.baseHero.battleGuardInfo = new BattleGuardInfo();
         }
         for each(var _loc18_:XML in param1..WatchInfo)
         {
            _loc11_ = _loc52_.army.baseHero.battleGuardInfo.getSocketInfo(_loc18_.@GridType,_loc18_.@GridPos - 1);
            _loc11_.addItem(_loc18_.@Jion1,0);
            _loc11_.addItem(_loc18_.@Jion2,1);
            _loc11_.addItem(_loc18_.@Jion3,2);
            _loc11_.state = 1;
            _loc11_.commit();
         }
         for each(var _loc40_:XML in param1..DragonInfo)
         {
            if(int(_loc40_.@Type) > _loc39_)
            {
               _loc39_ = int(_loc40_.@Type);
               _loc27_ = int(_loc40_.@Grade);
               _loc34_ = int(_loc40_.@Gp);
            }
         }
         _loc52_.army.baseHero.dragonSoulType = _loc39_;
         _loc52_.army.baseHero.dragonSoulGrade = _loc27_;
         _loc52_.army.baseHero.dragonSoulGp = _loc34_;
         var _loc47_:Array = [];
         for each(var _loc50_:XML in param1..TattooInfo)
         {
            _loc61_ = new TattooHole();
            _loc61_.index = _loc50_.@hole;
            _loc61_.oldTattooType = _loc50_.@oldTattooType;
            _loc61_.oldAddProperty = _loc50_.@oldAddProperty;
            _loc61_.oldAddingValue = _loc50_.@oldAddingValue;
            _loc61_.oldReduceProperty = _loc50_.@oldReduceProperty;
            _loc61_.oldReduceValue = _loc50_.@oldReduceValue;
            _loc61_.newTattooType = 0;
            _loc61_.newAddProperty = -1;
            _loc61_.newAddingValue = 0;
            _loc61_.newReduceProperty = -1;
            _loc61_.newReduceValue = 0;
            _loc47_.push(_loc61_);
         }
         _loc52_.army.baseHero.holes = _loc47_;
         var _loc4_:Array = [];
         for each(var _loc7_:XML in param1..TattooEnhanceInfo)
         {
            _loc19_ = new TattooHoleInfoII();
            _loc19_.holeId = _loc7_.@HoleId;
            _loc19_.property = _loc7_.@Property;
            _loc19_.level = _loc7_.@Level;
            _loc19_.enable = _loc7_.@Enable;
            _loc4_.push(_loc19_);
         }
         _loc52_.army.baseHero.tattooPrintHoles = _loc4_;
         var _loc17_:Array = [];
         for each(var _loc22_:XML in param1..PetHallowsInfo)
         {
            _loc67_ = new PetHallowsInfo();
            _loc67_.hallowTempId = _loc22_.@HallowTempId;
            _loc67_.hallowType = _loc22_.@HallowSonType;
            _loc67_.lookFightPower = _loc22_.@FightPower;
            _loc17_.push(_loc67_);
         }
         _loc52_.army.baseHero.petHallowsArr = _loc17_;
         for each(var _loc54_:XML in param1..TransferInfo)
         {
            _loc52_.army.baseHero.vocationIndex = int(_loc54_.@ChangeBranch);
            _loc52_.army.baseHero.vocationGrades = int(_loc54_.@Grade);
            _loc52_.army.baseHero.vocationGp = int(_loc54_.@Gp);
         }
         var _loc28_:DragonTitanData = new DragonTitanData();
         for each(var _loc10_:XML in param1..TitanDataInfo)
         {
            _loc28_.userId = _loc10_.@UserId;
            _loc28_.templateId = _loc10_.@TemplateId;
            _loc28_.starExp = _loc10_.@StarExp;
            _loc28_.starLevel = _loc10_.@StarLevel;
            _loc28_.devourTitan = _loc10_.@DevourTitans.toString().split(",");
            _loc28_.skillId = _loc10_.@SkillIds.toString().split(",");
         }
         _loc52_.army.baseHero.titanInfo = _loc28_;
         var _loc70_:ArtifactThaneInfo = new ArtifactThaneInfo();
         for each(var _loc36_:XML in param1..ArtifactInfo)
         {
            _loc70_.userId = _loc36_.@UserId;
            _loc70_.templateId = _loc36_.@TemplateId;
            _loc70_.level = _loc36_.@Level;
            _loc70_.fightPower = _loc36_.@FightPower;
            _loc70_.attack = _loc36_.@Attack;
            _loc70_.magicAttack = _loc36_.@MagicAttack;
            _loc70_.defences = _loc36_.@Defences;
            _loc70_.magicDefences = _loc36_.@MagicDefences;
            _loc70_.penetrate = _loc36_.@Penetrate;
            _loc70_.parry = _loc36_.@Parry;
            _loc70_.live = _loc36_.@Live;
            _loc70_.skills = _loc36_.@Skills;
            _loc70_.addPer = _loc36_.@AddPer;
         }
         _loc52_.army.baseHero.artifactInfo = _loc70_;
         var _loc63_:GoddessInfo = new GoddessInfo();
         for each(var _loc32_:XML in param1.GoddessInfo)
         {
            _loc63_.userId = _loc32_.@UserId;
            _loc63_.templateId = _loc32_.@TemplateId;
            _loc63_.grade = _loc32_.@Grade;
            _loc63_.step = _loc32_.@Step;
            _loc63_.devote = _loc32_.@Devote;
            _loc63_.attack = _loc32_.@Attack;
            _loc63_.defance = _loc32_.@Defance;
            _loc63_.magicAttack = _loc32_.@MagicAttack;
            _loc63_.magicDefance = _loc32_.@MagicDefance;
            _loc63_.live = _loc32_.@Live;
            _loc63_.isActive = true;
            for each(var _loc2_:XML in _loc32_..GoddessEquip)
            {
               _loc56_ = _loc63_.equips[_loc2_.@type];
               if(!_loc56_)
               {
                  _loc56_ = new GoddessEquipInfo();
                  _loc56_.equipType = _loc2_.@type;
                  _loc63_.equips[_loc56_.equipType] = _loc56_;
               }
               _loc56_.equipAdvanceLevel = _loc2_.@advanceLevel;
               _loc56_.equipCurBlessing = _loc2_.@curBlessing;
               _loc56_.equipStrengthenLevel = _loc2_.@strengthenLevel;
               _loc56_.ownerId = _loc32_.@TemplateId;
            }
         }
         _loc52_.army.baseHero.goddessInfo = _loc63_;
         var _loc64_:MonsterInfo = new MonsterInfo();
         for each(var _loc5_:XML in param1.MonsterInfo)
         {
            _loc64_.monsterId = _loc5_.@MonsterId;
            _loc64_.isExist = sloveBooblean(String(_loc5_.@IsExist));
            _loc64_.firstValue = _loc5_.@First;
            _loc64_.enterWar = sloveBooblean(String(_loc5_.@IsFight));
            _loc64_.isLock = sloveBooblean(String(_loc5_.@IsLock));
            _loc64_.name = _loc5_.@Name;
            _loc64_.fightPower = _loc5_.@FightPower;
            _loc64_.type = _loc5_.@Type;
            _loc64_.star = _loc5_.@Star;
            _loc64_.grade = _loc5_.@Level;
            _loc64_.curExp = _loc5_.@Exp;
            _loc64_.stageGrade = _loc5_.@StageLevel;
            _loc64_.stageExp = _loc5_.@StateExp;
            _loc64_.skillExpValue = _loc5_.@Skills;
            _loc64_.isFollow = sloveBooblean(String(_loc5_.@IsFollow));
            _loc64_.setOtherData();
         }
         _loc52_.army.baseHero.monsterInfo = _loc64_;
         var _loc51_:AvengerModel = new AvengerModel();
         for each(var _loc58_:XML in param1.AvengerInfo)
         {
            _loc51_.bodyInfo.grade = _loc58_.@grade;
            _loc51_.bodyInfo.exp = _loc58_.@exp;
            _loc51_.devilArmorInfo.grade = _loc58_.@armorGrade;
            _loc51_.devilArmorInfo.exp = _loc58_.@armorExp;
            for each(var _loc65_:XML in _loc58_..AvengerSkillInfo)
            {
               _loc30_ = _loc51_.skillDic[_loc65_.@skillSonType];
               if(!_loc30_)
               {
                  _loc30_ = new AvengerSkillInfo();
                  _loc51_.skillDic.add(_loc65_.@skillSonType,_loc30_);
               }
               _loc30_.skillTempId = _loc65_.@skillId;
               _loc30_.skillSontype = _loc65_.@skillSonType;
               _loc30_.isFight = sloveBooblean(String(_loc65_.@isUse));
               _loc30_.attack = _loc65_.@attack;
               _loc30_.defence = _loc65_.@defence;
               _loc30_.magicDefence = _loc65_.@magicDefence;
               _loc30_.live = _loc65_.@live;
               _loc30_.forceHit = _loc65_.@forcehit;
               _loc30_.parry = _loc65_.@parry;
               _loc30_.penetrate = _loc65_.@penetrate;
               _loc30_.reduceResi = _loc65_.@reduceResi;
               _loc30_.fireResi = _loc65_.@fireResi;
               _loc30_.waterResi = _loc65_.@waterResi;
               _loc30_.electResi = _loc65_.@electResi;
               _loc30_.windResi = _loc65_.@windResi;
               _loc30_.darkResi = _loc65_.@darkResi;
               _loc30_.lightResi = _loc65_.@lightResi;
               _loc30_.needItems = _loc65_.@itemInfo;
            }
            for each(var _loc46_:XML in _loc58_..AvengerHoleInfo)
            {
               _loc3_ = _loc51_.devilArmorInfo.holeDic[_loc46_.@pos];
               if(!_loc3_)
               {
                  _loc3_ = new AvengerDevilArmorHoleInfo();
                  _loc41_ = int(_loc46_.@pos);
                  _loc51_.devilArmorInfo.holeDic.add(_loc41_,_loc3_);
               }
               _loc3_.pos = _loc46_.@pos;
               _loc3_.grade = _loc46_.@grade;
               _loc3_.exp = _loc46_.@exp;
               _loc3_.inlayItem = _loc46_.@inlayItem;
            }
         }
         _loc52_.army.baseHero.avengerInfo = _loc51_;
         var _loc35_:TheseussoulModel = new TheseussoulModel();
         for each(var _loc29_:XML in param1..EquipData)
         {
            _loc62_ = new WarFrameItemInfo();
            _loc62_.id = _loc29_.@Id;
            _loc62_.pos = _loc29_.@EquipPos;
            _loc62_.templateId = _loc29_.@TemplateId;
            _loc62_.strengthen = _loc29_.@Strengthen;
            _loc62_.reform = _loc29_.@Quality;
            _loc62_.count = 1;
            if(_loc62_.pos != -1)
            {
               _loc35_.updateSuite1(_loc29_.@EquipPos,_loc62_.id,"suite" + _loc62_.warTempInfo.Property1);
               _loc35_.putItem(_loc62_.id,_loc62_);
            }
         }
         for each(var _loc16_:XML in param1.TheseusInfo)
         {
            _loc35_.propertys.armour = _loc16_.@Armour;
            _loc35_.level = _loc16_.@Level;
            _loc35_.hokeInfo = _loc16_.@HokeInfo;
            _loc35_.coreLevel = _loc16_.@CoreLevel;
            _loc60_ = _loc16_.@RageInfo;
            _loc23_ = _loc60_.split("|");
            for each(var _loc37_:String in _loc23_)
            {
               _loc26_ = _loc37_.split(",");
               _loc33_ = new TheseusYiCellInfo();
               _loc33_.pos = _loc26_[0];
               _loc33_.level = _loc26_[1];
               _loc35_.yiDic.add(_loc33_.pos,_loc33_);
            }
         }
         _loc52_.army.baseHero.theseusInfo = _loc35_;
         var _loc42_:WarSoulModel = new WarSoulModel();
         _loc42_.fightIdx = param1.WarSoulList.@FightIdx;
         for each(var _loc9_:XML in param1..WarSoulInfo)
         {
            _loc59_ = new TheseusWarsoulItemInfo();
            _loc59_.id = _loc9_.@Id;
            _loc59_.warSoulId = _loc9_.@WarSoulId;
            _loc59_.star = _loc9_.@Star;
            _loc59_.strengthen = _loc9_.@Strengthen;
            _loc59_.reform = _loc9_.@Reform;
            _loc59_.reformBuff = _loc9_.@ReformBuff;
            _loc59_.learnSkill = _loc9_.@LearnSkill;
            _loc59_.ramdomSkills = _loc9_.@RandomSkills;
            _loc59_.isEquip = _loc9_.@IsEquip;
            _loc59_.isExist = _loc9_.@IsExist;
            _loc42_.putItem(_loc59_.id,_loc59_);
         }
         _loc52_.army.baseHero.warSoulInfo = _loc42_;
         _loc52_.army.baseHero.fashionMsg.gp = param1.@FashionGP;
         _loc52_.army.baseHero.fashionMsg.grades = param1.@FashionGrades;
         var _loc48_:int = _loc52_.army.baseHero.id;
         if(!StringHelper.isNullOrEmpty(param1.@FashionHat))
         {
            _loc38_ = new GoodsInfo();
            _loc38_.pos = 9;
            _loc38_.bagType = 4;
            _loc38_.templateId = int(param1.@FashionHat);
            _loc52_.army.baseHero.equipDic[_loc38_.pos + "_" + _loc48_ + "_" + _loc38_.bagType] = _loc38_;
         }
         if(!StringHelper.isNullOrEmpty(param1.@FashionCloth))
         {
            _loc38_ = new GoodsInfo();
            _loc38_.pos = 10;
            _loc38_.bagType = 4;
            _loc38_.templateId = int(param1.@FashionCloth);
            _loc52_.army.baseHero.equipDic[_loc38_.pos + "_" + _loc48_ + "_" + _loc38_.bagType] = _loc38_;
         }
         if(!StringHelper.isNullOrEmpty(param1.@FashionArm))
         {
            _loc38_ = new GoodsInfo();
            _loc38_.pos = 11;
            _loc38_.bagType = 4;
            _loc38_.templateId = int(param1.@FashionArm);
            _loc52_.army.baseHero.equipDic[_loc38_.pos + "_" + _loc48_ + "_" + _loc38_.bagType] = _loc38_;
         }
         if(!StringHelper.isNullOrEmpty(param1.@FashionWing))
         {
            _loc38_ = new GoodsInfo();
            _loc38_.pos = 8;
            _loc38_.bagType = 4;
            _loc38_.templateId = int(param1.@FashionWing);
            _loc52_.army.baseHero.equipDic[_loc38_.pos + "_" + _loc48_ + "_" + _loc38_.bagType] = _loc38_;
         }
         return _loc52_;
      }
      
      private static function sloveBooblean(param1:*) : Boolean
      {
         if(param1 is String)
         {
            if(String(param1) == "true")
            {
               return true;
            }
            if(String(param1) == "false")
            {
               return false;
            }
            return Boolean(param1);
         }
         return Boolean(param1);
      }
      
      public function setSelectType(param1:int) : void
      {
         if(_model.currentSelected == param1)
         {
            return;
         }
         _model.currentSelected = param1;
         _model.currentPage = 1;
         loadXMLData();
      }
      
      public function setAddType(param1:int) : void
      {
         if(_model.addType == param1)
         {
            return;
         }
         _model.addType = param1;
         _model.currentPage = 1;
         loadXMLData();
      }
      
      public function setCross(param1:Boolean) : void
      {
         if(_model.isCross == param1)
         {
            return;
         }
         _model.isCross = param1;
         _model.currentPage = 1;
         loadXMLData();
      }
      
      public function loadXMLData() : void
      {
         var _loc2_:int = _model.currentSelected;
         var _loc3_:int = _model.addType;
         var _loc4_:Boolean = _model.isCross;
         var _loc5_:String = _loc4_ ? "cross/" : "";
         var _loc1_:String = getSortFileName(_loc2_,_loc3_);
         if(_loc1_)
         {
            _loc1_ = _loc5_ + _loc1_;
            setShowList();
            if(!_model.loaded[_loc1_])
            {
               loadData(_loc1_);
            }
         }
         else
         {
            setShowList();
         }
      }
      
      public function loadAllCrossXML(param1:Array, param2:Function) : void
      {
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc4_:String = null;
         LoadingSceneView.instance.show();
         _loadRecall = param2;
         _loadNum = param1.length;
         _crossxmlNum = param1.length;
         var _loc5_:int = int(param1.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = param1[_loc6_];
            _loc4_ = ComponentSetting.getMD5FileNameByFilePath(_loc3_);
            _progressDic[_loc4_] = 0;
            LoaderManagerII.instance.load(_loc3_,5,8,loadAllCrossHandler,progressHandler);
            _loc6_++;
         }
      }
      
      public function loadAllLocalXML(param1:Array, param2:Function) : void
      {
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc4_:String = null;
         LoadingSceneView.instance.show();
         _loadRecall = param2;
         _loadNum = param1.length;
         _localxmlNum = param1.length;
         var _loc5_:int = int(param1.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = param1[_loc6_];
            _loc4_ = ComponentSetting.getMD5FileNameByFilePath(_loc3_);
            _progressDic[_loc4_] = 0;
            LoaderManagerII.instance.load(_loc3_,5,8,loadAllLocalHandler,progressHandler);
            _loc6_++;
         }
      }
      
      private function progressHandler(param1:LoaderInfo) : void
      {
         var _loc5_:Number = param1.bytesLoaded / param1.bytesTotal;
         var _loc3_:String = ComponentSetting.getMD5FileNameByFilePath(param1.url);
         _progressDic[_loc3_] = _loc5_;
         var _loc4_:Number = 0;
         for each(var _loc2_:Number in _progressDic)
         {
            _loc4_ += _loc2_;
         }
         LoadingSceneView.instance.update(int(_loc4_ / _loadNum * 100));
      }
      
      private function loadAllCrossHandler(param1:LoaderInfo, param2:Object) : void
      {
         _crossxmlNum = _crossxmlNum - 1;
         resolveXML(new XML(param2),true);
         if(_crossxmlNum <= 0)
         {
            LoadingSceneView.instance.update(100);
            if(_loadRecall != null)
            {
               _loadRecall.call(null);
               _loadRecall = null;
            }
            LoadingSceneView.instance.hide();
         }
      }
      
      private function loadAllLocalHandler(param1:LoaderInfo, param2:Object) : void
      {
         _localxmlNum = _localxmlNum - 1;
         resolveXML(new XML(param2),false);
         if(_localxmlNum <= 0)
         {
            LoadingSceneView.instance.update(100);
            if(_loadRecall != null)
            {
               _loadRecall.call(null);
               _loadRecall = null;
            }
            LoadingSceneView.instance.hide();
         }
      }
      
      private function getSortFileName(param1:int, param2:int) : String
      {
         var _loc3_:String = null;
         if(param1 == 2)
         {
            _loc3_ = "fight.xml";
         }
         else if(param1 == 3)
         {
            _loc3_ = "totalfightcapacity.xml";
         }
         else if(param1 == 4)
         {
            _loc3_ = "constainfight.xml";
         }
         else if(param1 == 5)
         {
            _loc3_ = "geste.xml";
         }
         else if(param1 == 7)
         {
            _loc3_ = "soulscore.xml";
         }
         else if(param1 == 1)
         {
            if(param2 == 1)
            {
               _loc3_ = "day.xml";
            }
            else if(param2 == 2)
            {
               _loc3_ = "week.xml";
            }
            else if(param2 == 3)
            {
               _loc3_ = "total.xml";
            }
         }
         else if(param1 == 6)
         {
            if(param2 == 1)
            {
               _loc3_ = "daycharm.xml";
            }
            else if(param2 == 2)
            {
               _loc3_ = "weekcharm.xml";
            }
            else if(param2 == 3)
            {
               _loc3_ = "totalcharm.xml";
            }
         }
         else if(param1 == 9)
         {
            _loc3_ = "petfightcapacityrank.xml";
         }
         else if(param1 == 13)
         {
            _loc3_ = "childfightcapacityrank.xml";
         }
         else if(param1 == 12)
         {
            _loc3_ = "returnedplayers.xml";
         }
         else if(param1 == 14)
         {
            _loc3_ = "theseus.xml";
         }
         else
         {
            _loc3_ = "";
         }
         return _loc3_;
      }
      
      public function loadData(param1:String) : void
      {
         param1 = PathManager.orderPath + param1;
         LoaderManagerII.instance.load(param1,5,8,__onXMLDataLoaded);
      }
      
      private function __onXMLDataLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Boolean = param1.url.indexOf("cross") >= 0;
         var _loc5_:String = param1.url;
         _loc5_ = _loc5_.replace(PathManager.orderPath,"");
         var _loc4_:int = _loc5_.indexOf("?");
         if(_loc4_ != -1)
         {
            _loc5_ = _loc5_.substring(0,_loc4_);
         }
         _model.loaded[_loc5_] = true;
         resolveXML(new XML(param2),_loc3_);
         setShowList();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "sort.SortFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
         _model.currentSelected = 0;
         _model.addType = 0;
         _model.currentPage = 1;
         _model.currentShowList = [];
         _model.loaded = new Dictionary(true);
      }
      
      public function get model() : SortModel
      {
         return _model;
      }
      
      public function pageBtnHandler(param1:Boolean) : void
      {
         if(param1 && _model.currentPage > 1)
         {
            _model.currentPage--;
         }
         else
         {
            if(!(!param1 && _model.currentPage < _model.totalPage))
            {
               return;
            }
            _model.currentPage++;
         }
         _model.commitChange();
      }
      
      private function resolveXML(param1:XML, param2:Boolean) : void
      {
         resolveCharmDayAddXML(param1,param2);
         resolveCharmWeekAddXML(param1,param2);
         resolveCharmTotalAddXML(param1,param2);
         resolveConstainFightXML(param1,param2);
         resolveMultipleApXML(param1,param2);
         resolveDayAddXML(param1,param2);
         resolvePlayerFightXML(param1,param2);
         resolvePlayerGesteXML(param1,param2);
         resolveSoulScoreTotalAddXML(param1,param2);
         resolveTotalAddXML(param1,param2);
         resolveWeekAddXML(param1,param2);
         resolveWarlordsXML(param1,param2);
         resolveMultilordsXML(param1,param2);
         resolvePetPowerXML(param1,param2);
         resolveChildPowerXML(param1,param2);
         resolveRegressPlayerXML(param1,param2);
         resolveTheseusXML(param1,param2);
      }
      
      private function resolveDayAddXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..DayAdd;
         var _loc5_:Array = param2 ? _model.dayAddList2 : _model.dayAddList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolveWeekAddXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc3_:XMLList = param1..WeekAdd;
         var _loc5_:Array = param2 ? _model.weekAddList2 : _model.weekAddList;
         for each(var _loc4_:XML in _loc3_)
         {
            _loc6_ = SortController.read(_loc4_);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolveTotalAddXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..TotalAdd;
         var _loc5_:Array = param2 ? _model.accumulationAddList2 : _model.accumulationAddList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolvePlayerFightXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..PlayerFight;
         var _loc5_:Array = param2 ? _model.playerFightList2 : _model.playerFightList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolveTheseusXML(param1:XML, param2:Boolean) : void
      {
         var _loc9_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc6_:XMLList = param1..Theseus;
         var _loc7_:Array = param2 ? _model.theseusList2 : _model.theseusList;
         for each(var _loc3_:XML in _loc6_)
         {
            _loc9_ = SortController.read(_loc3_);
            _loc7_.push(_loc9_);
         }
         var _loc8_:int = playerInfo.userId;
         var _loc4_:String = playerInfo.nickName;
         var _loc5_:String = playerInfo.serviceName;
         for each(_loc9_ in _loc7_)
         {
            if(_loc9_.army.baseHero.userId == _loc8_)
            {
               if(!param2)
               {
                  _model.theseusRanking = _loc9_;
                  break;
               }
               if(_loc5_ == _loc9_.serverName)
               {
                  _model.theseusRankingCross = _loc9_;
                  break;
               }
            }
         }
      }
      
      private function resolveMultipleApXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..PlayerTotalFight;
         var _loc5_:Array = param2 ? _model.multipleCapacityList2 : _model.multipleCapacityList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            if(playerInfo.userId == int(_loc3_.@userid) && playerInfo.serviceName == _loc6_.serverName)
            {
               playerInfo.playerOrdeInfo.multipleApOrder = int(_loc3_.@gpOrde);
            }
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolveConstainFightXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..fightItems;
         var _loc5_:Array = param2 ? _model.consortiaFightList2 : _model.consortiaFightList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolvePlayerGesteXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..PlayerGeste;
         var _loc5_:Array = param2 ? _model.playerHonourList2 : _model.playerHonourList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc6_.army.baseHero.honer = int(_loc3_.@CurrentGeste);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolveCharmDayAddXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..CharmDayAdd;
         var _loc5_:Array = param2 ? _model.charmsDayAddList2 : _model.charmsDayAddList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolveCharmWeekAddXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..CharmWeekAdd;
         var _loc5_:Array = param2 ? _model.charmsWeekAddList2 : _model.charmsWeekAddList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolveCharmTotalAddXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..CharmTotalAdd;
         var _loc5_:Array = param2 ? _model.charmsTotalAddList2 : _model.charmsTotalAddList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc6_.army.baseHero.charms = int(_loc3_.@totalCharm);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolveSoulScoreTotalAddXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..SoulScoreTotalAdd;
         var _loc5_:Array = param2 ? _model.soulScoreTotalAddList2 : _model.soulScoreTotalAddList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc5_.push(_loc6_);
         }
      }
      
      private function resolveWarlordsXML(param1:XML, param2:Boolean) : void
      {
         var _loc3_:Array = null;
         var _loc4_:SortData = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:XMLList = param1..LordsInfo;
         for each(var _loc6_:XML in _loc8_)
         {
            _loc7_ = int(_loc6_.@job);
            _loc5_ = int(_loc6_.@lordsIndex);
            _loc3_ = _model.warlordsDic[ThaneInfoHelper.getJob(_loc7_)];
            if(!_loc3_)
            {
               _loc3_ = [];
               _model.warlordsDic.add(ThaneInfoHelper.getJob(_loc7_),_loc3_);
            }
            _loc4_ = _loc3_[_loc5_] as SortData;
            if(!_loc4_)
            {
               _loc4_ = new SortData();
               _loc3_[_loc5_] = _loc4_;
            }
            _loc4_.orderId = _loc5_;
            _loc4_.army.baseHero.userId = int(_loc6_.@userId);
            _loc4_.army.baseHero.serviceName = _loc6_.@serverName;
            _loc4_.army.baseHero.nickName = _loc6_.@nickName;
            _loc4_.army.baseHero.templateId = _loc7_;
            _loc4_.army.baseHero.job = _loc7_;
            _loc4_.army.baseHero.grades = int(_loc6_.@grades);
            _loc4_.army.baseHero.IsVipAndNoExpirt = sloveBooblean(String(_loc6_.@isVip));
            _loc4_.army.baseHero.fightingCapacity = int(_loc6_.@fightPower);
            _loc4_.army.baseHero.wingAvata = _loc6_.@fashionWing;
            _loc4_.army.baseHero.hairFashionAvata = _loc6_.@fashionHair;
            _loc4_.army.baseHero.cloakAvata = _loc6_.@fashionHat;
            if(_loc6_.@fashionArm.indexOf("fashion") > -1)
            {
               _loc4_.army.baseHero.armsFashionAvata = _loc6_.@fashionArm;
            }
            else
            {
               _loc4_.army.baseHero.armsEquipAvata = _loc6_.@fashionArm;
            }
            if(_loc6_.@fashionCloth.indexOf("fashion") > -1)
            {
               _loc4_.army.baseHero.bodyFashionAvata = _loc6_.@fashionCloth;
            }
            else
            {
               _loc4_.army.baseHero.bodyEquipAvata = _loc6_.@fashionCloth;
            }
         }
      }
      
      private function resolveMultilordsXML(param1:XML, param2:Boolean) : void
      {
         var _loc7_:Array = null;
         var _loc3_:SortData = null;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:String = null;
         var _loc6_:int = 72;
         var _loc10_:XMLList = param1..TitansRecord;
         for each(var _loc5_:XML in _loc10_)
         {
            _loc4_ = int(_loc5_.@rank);
            _loc9_ = _loc5_.@serverName;
            _loc7_ = _model.multilordsDic[_loc4_];
            if(!_loc7_)
            {
               _loc7_ = [];
               _model.multilordsDic.add(_loc4_,_loc7_);
            }
            _loc8_ = 0;
            for each(var _loc11_:XML in _loc5_..PlayerInfo)
            {
               _loc8_++;
               _loc3_ = _loc7_[_loc8_] as SortData;
               if(!_loc3_)
               {
                  _loc3_ = new SortData();
                  _loc7_[_loc8_] = _loc3_;
               }
               _loc3_.orderId = _loc4_;
               _loc3_.army.baseHero.userId = int(_loc11_.@userId);
               _loc3_.army.baseHero.nickName = _loc11_.@nickName;
               _loc3_.army.baseHero.templateId = _loc11_.@sexJob;
               _loc3_.army.baseHero.job = _loc11_.@job;
               _loc3_.army.baseHero.grades = int(_loc11_.@grades);
               _loc3_.army.baseHero.IsVipAndNoExpirt = sloveBooblean(String(_loc11_.@isVip));
               _loc3_.army.baseHero.fightingCapacity = int(_loc11_.@fightPower);
               _loc3_.army.baseHero.wingAvata = _loc11_.@fashionWing;
               _loc3_.army.baseHero.hairFashionAvata = _loc11_.@fashionHair;
               _loc3_.army.baseHero.cloakAvata = _loc11_.@fashionHat;
               _loc3_.army.baseHero.serviceName = _loc9_;
               _loc3_.army.baseHero.appellId = _loc6_;
               if(_loc11_.@fashionArm.indexOf("fashion") > -1)
               {
                  _loc3_.army.baseHero.armsFashionAvata = _loc11_.@fashionArm;
               }
               else
               {
                  _loc3_.army.baseHero.armsEquipAvata = _loc11_.@fashionArm;
               }
               if(_loc11_.@fashionCloth.indexOf("fashion") > -1)
               {
                  _loc3_.army.baseHero.bodyFashionAvata = _loc11_.@fashionCloth;
               }
               else
               {
                  _loc3_.army.baseHero.bodyEquipAvata = _loc11_.@fashionCloth;
               }
            }
         }
      }
      
      private function resolvePetPowerXML(param1:XML, param2:Boolean) : void
      {
         var _loc9_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc6_:XMLList = param1..PetCapabilityRankInfo;
         var _loc7_:Array = param2 ? _model.petPowerList2 : _model.petPowerList;
         for each(var _loc3_:XML in _loc6_)
         {
            _loc9_ = new SortData();
            _loc9_.orderId = int(_loc3_.@Rank);
            _loc9_.nikcName = _loc3_.@NickName;
            _loc9_.serverName = LanguageMgr.GetTranslation("sort.serverName",String(_loc3_.@serverId));
            _loc9_.army.nickName = _loc3_.@NickName;
            _loc9_.army.baseHero.serviceName = LanguageMgr.GetTranslation("sort.serverName",String(_loc3_.@serverId));
            _loc9_.army.baseHero.userId = int(_loc3_.@UserId);
            _loc9_.army.baseHero.IsVipAndNoExpirt = _loc3_.@IsVip == "true" ? true : false;
            _loc9_.army.baseHero.vipType = int(_loc3_.@VipType);
            _loc9_.army.baseHero.snsInfo.headId = int(_loc3_.@HeadId);
            _loc9_.petData = PetData.createWithXML(_loc3_);
            _loc7_.push(_loc9_);
         }
         var _loc8_:int = playerInfo.userId;
         var _loc4_:String = playerInfo.nickName;
         var _loc5_:String = playerInfo.serviceName;
         for each(_loc9_ in _loc7_)
         {
            if(_loc9_.army.baseHero.userId == _loc8_)
            {
               if(!param2)
               {
                  _model.petRanking = _loc9_;
                  break;
               }
               if(_loc5_ == _loc9_.serverName)
               {
                  _model.petRankingCross = _loc9_;
                  break;
               }
            }
         }
      }
      
      private function resolveChildPowerXML(param1:XML, param2:Boolean) : void
      {
         var _loc9_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc6_:XMLList = param1..ChildCapabilityRankInfo;
         var _loc7_:Array = param2 ? _model.childPowerList2 : _model.childPowerList;
         for each(var _loc3_:XML in _loc6_)
         {
            _loc9_ = new SortData();
            _loc9_.orderId = int(_loc3_.@Rank);
            _loc9_.nikcName = _loc3_.@NickName;
            _loc9_.serverName = LanguageMgr.GetTranslation("sort.serverName",String(_loc3_.@serverId));
            _loc9_.army.nickName = _loc3_.@NickName;
            _loc9_.army.baseHero.serviceName = LanguageMgr.GetTranslation("sort.serverName",String(_loc3_.@serverId));
            _loc9_.army.baseHero.userId = int(_loc3_.@UserId);
            _loc9_.army.baseHero.IsVipAndNoExpirt = _loc3_.@IsVip == "true" ? true : false;
            _loc9_.army.baseHero.vipType = int(_loc3_.@VipType);
            _loc9_.army.baseHero.snsInfo.headId = int(_loc3_.@HeadId);
            _loc9_.childData = ChildData.createChildWithXML(_loc3_);
            _loc7_.push(_loc9_);
         }
         var _loc8_:int = playerInfo.userId;
         var _loc4_:String = playerInfo.nickName;
         var _loc5_:String = playerInfo.serviceName;
         for each(_loc9_ in _loc7_)
         {
            if(_loc9_.army.baseHero.userId == _loc8_)
            {
               if(!param2)
               {
                  _model.childRanking = _loc9_;
                  break;
               }
               if(_loc5_ == _loc9_.serverName)
               {
                  _model.childRankingCross = _loc9_;
                  break;
               }
            }
         }
      }
      
      private function resolveRegressPlayerXML(param1:XML, param2:Boolean) : void
      {
         var _loc6_:SortData = null;
         _model.createDate = DateFormatter.parse(param1.info.@createDate,"YYYY-MM-DD hh:mm:ss");
         _model.createDate.setHours(0,0,0,0);
         var _loc4_:XMLList = param1..ReturnedPalyer;
         var _loc5_:Array = _model.regressPlayerList;
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = SortController.read(_loc3_);
            _loc5_.push(_loc6_);
         }
         _loc5_.sort(byOrderId);
      }
      
      private function byOrderId(param1:SortData, param2:SortData) : int
      {
         if(param1.orderId < param2.orderId)
         {
            return -1;
         }
         if(param1.orderId > param2.orderId)
         {
            return 1;
         }
         return 0;
      }
      
      private function setShowList() : void
      {
         if(_model.isCross)
         {
            cross();
         }
         else
         {
            notCross();
         }
      }
      
      private function cross() : void
      {
         switch(_model.currentSelected - 1)
         {
            case 0:
               if(_model.addType == 1)
               {
                  _model.currentShowList = _model.dayAddList2;
               }
               else if(_model.addType == 2)
               {
                  _model.currentShowList = _model.weekAddList2;
               }
               else
               {
                  _model.currentShowList = _model.accumulationAddList2;
               }
               break;
            case 1:
               _model.currentShowList = _model.playerFightList2;
               break;
            case 2:
               _model.currentShowList = _model.multipleCapacityList2;
               break;
            case 3:
               _model.currentShowList = _model.consortiaFightList2;
               break;
            case 4:
               _model.currentShowList = _model.playerHonourList2;
               break;
            case 5:
               if(_model.addType == 1)
               {
                  _model.currentShowList = _model.charmsDayAddList2;
               }
               else if(_model.addType == 2)
               {
                  _model.currentShowList = _model.charmsWeekAddList2;
               }
               else
               {
                  _model.currentShowList = _model.charmsTotalAddList2;
               }
               break;
            case 6:
               _model.currentShowList = _model.soulScoreTotalAddList2;
               break;
            case 8:
               _model.currentShowList = _model.petPowerList2;
               break;
            case 12:
               _model.currentShowList = _model.childPowerList2;
               break;
            case 13:
               _model.currentShowList = _model.theseusList2;
         }
         _model.commitChange();
      }
      
      private function notCross() : void
      {
         switch(_model.currentSelected - 1)
         {
            case 0:
               if(_model.addType == 1)
               {
                  _model.currentShowList = _model.dayAddList;
               }
               else if(_model.addType == 2)
               {
                  _model.currentShowList = _model.weekAddList;
               }
               else
               {
                  _model.currentShowList = _model.accumulationAddList;
               }
               break;
            case 1:
               _model.currentShowList = _model.playerFightList;
               break;
            case 2:
               _model.currentShowList = _model.multipleCapacityList;
               break;
            case 3:
               _model.currentShowList = _model.consortiaFightList;
               break;
            case 4:
               _model.currentShowList = _model.playerHonourList;
               break;
            case 5:
               if(_model.addType == 1)
               {
                  _model.currentShowList = _model.charmsDayAddList;
               }
               else if(_model.addType == 2)
               {
                  _model.currentShowList = _model.charmsWeekAddList;
               }
               else
               {
                  _model.currentShowList = _model.charmsTotalAddList;
               }
               break;
            case 6:
               _model.currentShowList = _model.soulScoreTotalAddList;
               break;
            case 8:
               _model.currentShowList = _model.petPowerList;
               break;
            case 11:
               _model.currentShowList = _model.regressPlayerList;
               break;
            case 12:
               _model.currentShowList = _model.childPowerList;
               break;
            case 13:
               _model.currentShowList = _model.theseusList;
         }
         _model.commitChange();
      }
   }
}

