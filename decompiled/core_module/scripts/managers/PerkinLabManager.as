package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.avenger.AvengerSkillMsg;
   import com.road.yishi.proto.dragontalker.SymbiontGp;
   import com.road.yishi.proto.dragontalker.TalismanMsg;
   import com.road.yishi.proto.perkinlab.PerkinLabClientMsg;
   import com.road.yishi.proto.perkinlab.PerkinLabKengMsg;
   import com.road.yishi.proto.perkinlab.PerkinLabLogListMsg;
   import com.road.yishi.proto.perkinlab.PerkinLabLogMsg;
   import com.road.yishi.proto.perkinlab.PerkinLabRobMsg;
   import com.road.yishi.proto.perkinlab.PerkinLabSelfMsg;
   import com.road.yishi.proto.pet.PetHallowInfoMsg;
   import com.road.yishi.proto.pet.PetInfoMsg;
   import com.road.yishi.proto.simple.DetailRspMsg;
   import com.road.yishi.proto.simple.SimpleArmyPawnMsg;
   import com.road.yishi.proto.simple.SimpleHeroMsg;
   import com.road.yishi.proto.simple.SimpleItemInfoMsg;
   import com.road.yishi.proto.simple.SimpleMagicCardInfoMsg;
   import com.road.yishi.proto.simple.SimpleStarAdditionMsg;
   import com.road.yishi.proto.simple.SimpleStarInfoMsg;
   import com.road.yishi.proto.simple.SimpleWatchMsg;
   import com.road.yishi.proto.tattoo.TattooHoleMsg;
   import com.road.yishi.proto.theseus.TheseusEquipMsg;
   import com.road.yishi.proto.titan.TitanDataMsg;
   import events.PerkinLabEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.avenger.AvengerSkillInfo;
   import mvc.module.card.MagicCardFightInfo;
   import mvc.module.children.ChildData;
   import mvc.module.dragonTitan.DragonTitanData;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import mvc.module.goddess.GoddessInfo;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.perkinlab.PerkinLabKengInfo;
   import mvc.module.perkinlab.PerkinLabLogInfo;
   import mvc.module.perkinlab.PerkinLabModel;
   import mvc.module.perkinlab.PerkinLabThaneInfo;
   import mvc.module.pet.PetData;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.star.StarInfo;
   import mvc.module.star.StarTroughInfo;
   import mvc.module.tattoo.TattooHole;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.BattleGuardSocketInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.SimpleMountInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.ThaneEquipShowHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class PerkinLabManager extends EventDispatcher
   {
      
      private static var _instance:PerkinLabManager;
      
      private var _model:PerkinLabModel;
      
      public function PerkinLabManager()
      {
         super();
      }
      
      public static function get instance() : PerkinLabManager
      {
         if(!_instance)
         {
            _instance = new PerkinLabManager();
         }
         return _instance;
      }
      
      public function get model() : PerkinLabModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new PerkinLabModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 272,__updateSelfKengList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 273,__updateRobKengList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 275,__updateRobLogList);
      }
      
      private function __updateSelfKengList(param1:SLGSocketEvent) : void
      {
         var _loc3_:PerkinLabKengInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PerkinLabSelfMsg = new PerkinLabSelfMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PerkinLabSelfMsg;
         model.robCount = _loc2_.robCount;
         model.selfKengList = [];
         for each(var _loc5_:PerkinLabKengMsg in _loc2_.kengList)
         {
            _loc3_ = new PerkinLabKengInfo();
            _loc3_.uid = _loc5_.uid;
            _loc3_.index = _loc5_.index;
            if(_loc5_.hasHarvestTime)
            {
               _loc3_.harvestTime = Math.ceil(Int64Utils.int64ToNumber(_loc5_.harvestTime) / 1000);
            }
            _loc3_.missingReward = _loc5_.missingReward;
            model.selfKengList.push(_loc3_);
         }
         dispatchEvent(new PerkinLabEvent("UPDATE_SELF_LIST",null));
      }
      
      private function __updateRobKengList(param1:SLGSocketEvent) : void
      {
         var _loc3_:PerkinLabKengInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PerkinLabRobMsg = new PerkinLabRobMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PerkinLabRobMsg;
         model.isLoadedData = _loc2_.success;
         if(!model.isLoadedData)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("perkinlab.robList.alert"));
            return;
         }
         model.robCount = _loc2_.robCount;
         model.refreshCost = _loc2_.refreshCost;
         model.nextRefreshTime = Int64Utils.int64ToNumber(_loc2_.nextRefreshTime) / 1000;
         model.robCdTime = Int64Utils.int64ToNumber(_loc2_.robCdTime) / 1000;
         if(_loc2_.hasKeng && _loc2_.keng)
         {
            _loc3_ = model.getKengInfoByIndexFromList(_loc2_.keng.index,model.robKengList);
            if(!_loc3_)
            {
               _loc3_ = new PerkinLabKengInfo();
               model.robKengList.push(_loc3_);
            }
            _loc3_.uid = _loc2_.keng.uid;
            _loc3_.index = _loc2_.keng.index;
            if(_loc2_.keng.hasHarvestTime)
            {
               _loc3_.harvestTime = Math.ceil(Int64Utils.int64ToNumber(_loc2_.keng.harvestTime) / 1000);
            }
            _loc3_.robReward = _loc2_.keng.robReward;
            _loc3_.robState = _loc2_.keng.robState;
            _loc3_.thane = new PerkinLabThaneInfo();
            readDetailRspMsg(_loc3_.thane,_loc2_.keng.rivalDetail);
         }
         dispatchEvent(new PerkinLabEvent("UPDATE_ROB_LIST",_loc3_));
      }
      
      private function readDetailRspMsg(param1:PerkinLabThaneInfo, param2:DetailRspMsg) : void
      {
         var _loc34_:SimpleHeroMsg = null;
         var _loc24_:DragonTalkerSymbioteInfo = null;
         var _loc45_:DragonTalkerTalismanInfo = null;
         var _loc40_:Array = null;
         var _loc19_:TattooHoleMsg = null;
         var _loc46_:int = 0;
         var _loc49_:TattooHole = null;
         var _loc55_:Array = null;
         var _loc54_:PetHallowsInfo = null;
         var _loc20_:DragonTitanData = null;
         var _loc12_:TitanDataMsg = null;
         var _loc36_:int = 0;
         var _loc21_:int = 0;
         var _loc29_:int = 0;
         var _loc18_:Array = null;
         var _loc56_:* = null;
         var _loc38_:Array = null;
         var _loc47_:int = 0;
         var _loc27_:SimpleArmyPawnMsg = null;
         var _loc35_:SimpleItemInfoMsg = null;
         var _loc7_:GoodsInfo = null;
         var _loc8_:GoodsInfo = null;
         var _loc4_:GoodsInfo = null;
         var _loc15_:GoodsInfo = null;
         var _loc26_:GoodsInfo = null;
         var _loc44_:GoodsInfo = null;
         var _loc28_:GoodsInfo = null;
         var _loc5_:GoodsInfo = null;
         var _loc9_:SimpleStarInfoMsg = null;
         var _loc33_:StarInfo = null;
         var _loc42_:SimpleMagicCardInfoMsg = null;
         var _loc39_:MagicCardFightInfo = null;
         var _loc16_:int = 0;
         var _loc6_:SimpleStarAdditionMsg = null;
         var _loc52_:int = 0;
         var _loc32_:StarTroughInfo = null;
         var _loc14_:BattleGuardSocketInfo = null;
         var _loc23_:AvengerSkillInfo = null;
         var _loc50_:WarFrameItemInfo = null;
         var _loc48_:PetData = null;
         var _loc11_:GoodsInfo = null;
         var _loc17_:ChildData = null;
         var _loc10_:GoodsInfo = null;
         if(param2.army.hasSimpleHero)
         {
            _loc34_ = param2.army.simpleHero;
            if(!param1)
            {
               param1 = new PerkinLabThaneInfo();
            }
            param1.id = _loc34_.heroId;
            param1.nickName = _loc34_.nickName;
            param1.nickNameB = _loc34_.nickNameB;
            param1.grades = param2.grade;
            param1.fightingCapacity = param2.fightCapacity;
            param1.marryRingGrade = _loc34_.ringGrade;
            param1.templateId = _loc34_.tempateId;
            param1.consortiaID = param2.army.consortiaId;
            param1.consortiaName = param2.army.consortiaName;
            param1.hideFashion = param2.hideFashion;
            param1.charms = _loc34_.totalCharm;
            param1.honer = _loc34_.totalGeste;
            param1.appellId = param2.army.appellid;
            param1.attackProrerty.totalPhyAttack = _loc34_.totalPhyAttack;
            param1.attackProrerty.totalPhyDefence = _loc34_.totalPhyDefence;
            param1.attackProrerty.totalMagicAttack = _loc34_.totalMagicAttack;
            param1.attackProrerty.totalMagicDefence = _loc34_.totalMagicDefence;
            param1.attackProrerty.totalLive = _loc34_.totalLive;
            param1.attackProrerty.totalForceHit = _loc34_.totalForceHit;
            param1.attackProrerty.totalConatArmy = _loc34_.totalConatArmy;
            param1.baseProperty.totalPower = _loc34_.totalPower;
            param1.baseProperty.totalAgility = _loc34_.totalAgility;
            param1.baseProperty.totalIntellect = _loc34_.totalIntellect;
            param1.baseProperty.totalCaptain = _loc34_.totalCaptain;
            param1.baseProperty.totalPhysique = _loc34_.totalPhysique;
            param1.attackProrerty.totalParry = _loc34_.totalParry;
            param1.attackProrerty.totalIntensity = _loc34_.totalStrength;
            param1.attackProrerty.totalTenacity = _loc34_.totalTenacity;
            param1.attackProrerty.totalPenetrate = _loc34_.totalPenetrate;
            param1.attackProrerty.totalDingli = _loc34_.totalStunAttr;
            param1.attackProrerty.basePhyAttack = _loc34_.basePhyAttack;
            param1.attackProrerty.basePhyDefence = _loc34_.basePhyDefence;
            param1.attackProrerty.baseMagicAttack = _loc34_.baseMagicAttack;
            param1.attackProrerty.baseMagicDefence = _loc34_.baseMagicDefence;
            param1.attackProrerty.baseLive = _loc34_.baseLive;
            param1.attackProrerty.baseForceHit = _loc34_.baseForceHit;
            param1.attackProrerty.baseConatArmy = _loc34_.baseConatArmy;
            param1.attackProrerty.baseParry = _loc34_.baseParry;
            param1.attackProrerty.baseIntensity = _loc34_.baseStrength;
            param1.attackProrerty.baseTenacity = _loc34_.baseTenacity;
            param1.attackProrerty.basePenetrate = _loc34_.basePenetrate;
            param1.attackProrerty.baseDingli = _loc34_.baseStunAttr;
            param1.IsVipAndNoExpirt = param2.army.isVip;
            param1.vipType = param2.army.vipType;
            param1.jewelGrades = param2.army.storeGrade;
            param1.seniorStoreGrade = param2.army.seniorStoreGrade;
            param1.fateTotalGp = param2.army.fateTotalGp;
            param1.fateGrades = param2.army.fateGrades;
            param1.conciseGrades = param2.army.equipmentRefiningGrade;
            param1.baseProperty.totalBattleWill = _loc34_.reduceResi;
            param1.baseProperty.totalFireResi = _loc34_.fireResi;
            param1.baseProperty.totalWaterResi = _loc34_.waterResi;
            param1.baseProperty.totalWindResi = _loc34_.windResi;
            param1.baseProperty.totalElecResi = _loc34_.electResi;
            param1.baseProperty.totalLightResi = _loc34_.lightResi;
            param1.baseProperty.totalDarkResi = _loc34_.darkResi;
            param1.baseProperty.totalStrikeResi = _loc34_.totalResiPenetrate;
            param1.baseProperty.totalResistResi = _loc34_.totalReduceResiAgainst;
            param1.baseProperty.hasSetBattleInfoFlag = true;
            param1.baseProperty.fashionPower = _loc34_.fashionAddPower;
            param1.baseProperty.fashionAgility = _loc34_.fashionAddArmor;
            param1.baseProperty.fashionIntellect = _loc34_.fashionAddIntellect;
            param1.baseProperty.fashionPhysigue = _loc34_.fashionAddLife;
            param1.baseProperty.hasSetFashionProperty = true;
            if(param2.dragonTalkerInfo)
            {
               param1.isOpenDragonTalker = param2.dragonTalkerInfo.isOpen;
               param1.dragonTalkerInfo.isDragonTalker = param2.dragonTalkerInfo.isNowDragonTalker;
               param1.dragonTalkerInfo.battleBeastId = param2.dragonTalkerInfo.currentFightMount;
               param1.dragonTalkerInfo.fightMountGp = param2.dragonTalkerInfo.fightMountGp;
               param1.dragonTalkerInfo.symbiontList = param2.dragonTalkerInfo.symbiontGpList;
               if(param2.dragonTalkerInfo.symbiontGpList)
               {
                  param1.dragonTalkerInfo.symbiontList = [];
                  for each(var _loc57_:SymbiontGp in param2.dragonTalkerInfo.symbiontGpList)
                  {
                     _loc24_ = new DragonTalkerSymbioteInfo();
                     _loc24_.index = _loc57_.index;
                     _loc24_.currentExp = _loc57_.totalGp;
                     param1.dragonTalkerInfo.symbiontList.push(_loc24_);
                  }
               }
               if(param2.talismanInfo)
               {
                  param1.dragonTalkerInfo.talismanList = [];
                  for each(var _loc25_:TalismanMsg in param2.talismanInfo)
                  {
                     _loc45_ = new DragonTalkerTalismanInfo();
                     _loc45_.id = _loc25_.id;
                     _loc45_.tempId = _loc25_.templateId;
                     _loc45_.pos = _loc25_.pos;
                     _loc45_.equipPos = _loc25_.equipslot;
                     _loc45_.isExist = _loc25_.isExist;
                     _loc45_.grade = _loc25_.grade;
                     _loc45_.exp = _loc25_.gp;
                     _loc45_.randomSkillList = _loc25_.randomSkillList;
                     _loc45_.newSkillId = _loc25_.newSkillId;
                     _loc45_.oldSkillIndex = _loc25_.oldSkillIndex;
                     _loc45_.count = _loc25_.count;
                     _loc45_.isNew = _loc25_.isNew;
                     _loc45_.isSelf = false;
                     param1.dragonTalkerInfo.talismanList.push(_loc45_);
                  }
               }
            }
            _loc40_ = [];
            if(param2.holeInfo)
            {
               _loc46_ = 0;
               while(_loc46_ < param2.holeInfo.length)
               {
                  _loc19_ = param2.holeInfo[_loc46_];
                  _loc49_ = new TattooHole();
                  _loc49_.index = _loc46_ + 1;
                  _loc49_.oldTattooType = _loc19_.oldTattooType;
                  _loc49_.oldAddProperty = _loc19_.oldAddProperty;
                  _loc49_.oldAddingValue = _loc19_.oldAddingValue;
                  _loc49_.oldReduceProperty = _loc19_.oldReduceProperty;
                  _loc49_.oldReduceValue = _loc19_.oldReduceValue;
                  _loc49_.newTattooType = _loc19_.newTattooType;
                  _loc49_.newAddProperty = _loc19_.newAddProperty;
                  _loc49_.newAddingValue = _loc19_.newAddingValue;
                  _loc49_.newReduceProperty = _loc19_.newReduceProperty;
                  _loc49_.newReduceValue = _loc19_.newReduceValue;
                  _loc40_.push(_loc49_);
                  _loc46_++;
               }
            }
            param1.holes = _loc40_;
            _loc55_ = [];
            if(param2.petHallowInfo)
            {
               for each(var _loc37_:PetHallowInfoMsg in param2.petHallowInfo)
               {
                  _loc54_ = new PetHallowsInfo();
                  _loc54_.hallowTempId = _loc37_.hallowTempId;
                  _loc54_.hallowType = _loc37_.hallowSonType;
                  _loc54_.lookFightPower = _loc37_.attackData;
                  _loc55_.push(_loc54_);
               }
            }
            param1.petHallowsArr = _loc55_;
            _loc20_ = new DragonTitanData();
            if(param2.titanInfo)
            {
               _loc12_ = param2.titanInfo;
               _loc20_.userId = _loc12_.userId;
               _loc20_.templateId = _loc12_.templateId;
               _loc20_.starExp = _loc12_.starExp;
               _loc20_.starLevel = _loc12_.starLevel;
               _loc20_.devourTitan = _loc12_.devourTitan;
               _loc20_.attack = _loc12_.attack;
               _loc20_.defence = _loc12_.defence;
               _loc20_.magicAttack = _loc12_.magicAttack;
               _loc20_.magicDefence = _loc12_.magicDefence;
               _loc20_.live = _loc12_.live;
               _loc20_.forceHit = _loc12_.forceHit;
               _loc20_.parry = _loc12_.parry;
               _loc20_.strength = _loc12_.strength;
               _loc20_.tenacity = _loc12_.tenacity;
               _loc20_.reduceResi = _loc12_.reduceResi;
               _loc20_.fireResi = _loc12_.fireResi;
               _loc20_.waterResi = _loc12_.waterResi;
               _loc20_.electResi = _loc12_.electResi;
               _loc20_.windResi = _loc12_.windResi;
               _loc20_.darkResi = _loc12_.darkResi;
               _loc20_.lightResi = _loc12_.lightResi;
               _loc20_.penetrate = _loc12_.penetrate;
               _loc20_.stunAttr = _loc12_.stunAttr;
            }
            param1.titanInfo = _loc20_;
            if(param2.army.hasDragonGrade)
            {
               _loc18_ = param2.army.dragonGrade.split("|");
               for each(_loc56_ in _loc18_)
               {
                  _loc38_ = _loc56_.split(",");
                  if(int(_loc38_[0]) > _loc36_)
                  {
                     _loc36_ = int(_loc38_[0]);
                     _loc21_ = int(_loc38_[1]);
                     _loc29_ = int(_loc38_[2]);
                  }
               }
               param1.dragonSoulType = _loc36_;
               param1.dragonSoulGrade = _loc21_;
               param1.dragonSoulGp = _loc29_;
            }
            if(param2.army.hasTransferGrade)
            {
               param1.vocationGrades = param2.army.transferGrade;
            }
            if(param2.army.hasChangeBranch)
            {
               param1.vocationIndex = param2.army.changeBranch;
            }
         }
         if(param2.army.armyPawn.length > 0)
         {
            _loc47_ = 0;
            while(_loc47_ < param2.army.armyPawn.length)
            {
               _loc27_ = param2.army.armyPawn[_loc47_] as SimpleArmyPawnMsg;
               _loc47_++;
            }
         }
         if(param2.item.length > 0 || param2.star.length > 0)
         {
            param1.equipDic = new SimpleDictionary(true);
         }
         _loc46_ = 0;
         while(_loc46_ < param2.item.length)
         {
            _loc35_ = param2.item[_loc46_] as SimpleItemInfoMsg;
            _loc7_ = new GoodsInfo();
            _loc7_.id = _loc35_.id;
            _loc7_.bagType = _loc35_.bagType;
            _loc7_.objectId = _loc35_.objectId;
            _loc7_.pos = _loc35_.pos;
            _loc7_.templateId = _loc35_.templateId;
            _loc7_.isBinds = _loc35_.bind;
            _loc7_.count = _loc35_.count;
            _loc7_.beginDate = DateFormatter.parse(_loc35_.beginDate,"YYYY-MM-DD hh:mm:ss");
            _loc7_.validDate = _loc35_.validDate;
            _loc7_.strengthenGrade = _loc35_.strengthenGrade;
            _loc7_.join1 = _loc35_.join_1;
            _loc7_.join2 = _loc35_.join_2;
            _loc7_.join3 = _loc35_.join_3;
            _loc7_.join4 = _loc35_.join_4;
            _loc7_.randomSkill1 = _loc35_.randomSkill_1;
            _loc7_.randomSkill2 = _loc35_.randomSkill_2;
            _loc7_.randomSkill3 = _loc35_.randomSkill_3;
            _loc7_.randomSkill4 = _loc35_.randomSkill_4;
            _loc7_.randomSkill5 = _loc35_.randomSkill_5;
            _loc7_.mouldGrade = _loc35_.mouldGrade;
            if(_loc35_.hasLifeSkill)
            {
               _loc7_.enchantSkillId = _loc35_.lifeSkill;
            }
            param1.equipDic[_loc7_.pos + "_" + _loc7_.objectId + "_" + _loc7_.bagType] = _loc7_;
            _loc46_++;
         }
         param1.fashionMsg.gp = _loc34_.fashionGp;
         param1.fashionMsg.grades = _loc34_.fashionGrades;
         var _loc41_:int = param1.id;
         if(_loc34_.fashionHat)
         {
            _loc8_ = new GoodsInfo();
            _loc8_.pos = 9;
            _loc8_.bagType = 4;
            _loc8_.templateId = _loc34_.fashionHat;
            param1.equipDic[_loc8_.pos + "_" + _loc41_ + "_" + _loc8_.bagType] = _loc8_;
         }
         if(_loc34_.fashionCloth)
         {
            _loc8_ = new GoodsInfo();
            _loc8_.pos = 10;
            _loc8_.bagType = 4;
            _loc8_.templateId = _loc34_.fashionCloth;
            param1.equipDic[_loc8_.pos + "_" + _loc41_ + "_" + _loc8_.bagType] = _loc8_;
         }
         if(_loc34_.fashionArm)
         {
            _loc8_ = new GoodsInfo();
            _loc8_.pos = 11;
            _loc8_.bagType = 4;
            _loc8_.templateId = _loc34_.fashionArm;
            param1.equipDic[_loc8_.pos + "_" + _loc41_ + "_" + _loc8_.bagType] = _loc8_;
         }
         if(_loc34_.fashionWing)
         {
            _loc8_ = new GoodsInfo();
            _loc8_.pos = 8;
            _loc8_.bagType = 4;
            _loc8_.templateId = _loc34_.fashionWing;
            param1.equipDic[_loc8_.pos + "_" + _loc41_ + "_" + _loc8_.bagType] = _loc8_;
         }
         if(param1.equipDic)
         {
            _loc4_ = param1.equipDic["2_" + param1.id + "_" + 4];
            _loc15_ = param1.equipDic["0_" + param1.id + "_" + 4];
            _loc26_ = param1.equipDic["8_" + param1.id + "_" + 4];
            _loc44_ = param1.equipDic["9_" + param1.id + "_" + 4];
            _loc28_ = param1.equipDic["10_" + param1.id + "_" + 4];
            _loc5_ = param1.equipDic["11_" + param1.id + "_" + 4];
            param1.bodyEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc4_);
            param1.armsEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc15_);
            param1.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc26_);
            param1.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc44_);
            param1.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc28_);
            param1.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         }
         _loc46_ = 0;
         while(_loc46_ < param2.star.length)
         {
            _loc9_ = param2.star[_loc46_] as SimpleStarInfoMsg;
            _loc33_ = new StarInfo();
            _loc33_.id = _loc9_.id;
            _loc33_.bagType = _loc9_.bagType;
            _loc33_.pos = _loc9_.pos;
            _loc33_.tempId = _loc9_.templateId;
            _loc33_.gp = _loc9_.gp;
            _loc33_.grade = _loc9_.grade;
            param1.equipDic[_loc33_.pos + "_0_" + _loc33_.bagType] = _loc33_;
            _loc46_++;
         }
         param1.activeMagicCards = [];
         _loc46_ = 0;
         while(_loc46_ < param2.cardInfos.length)
         {
            _loc42_ = param2.cardInfos[_loc46_] as SimpleMagicCardInfoMsg;
            _loc39_ = new MagicCardFightInfo();
            _loc39_.templeteId = _loc42_.templateId;
            _loc39_.gardes = _loc42_.grades;
            param1.activeMagicCards.push(_loc39_);
            _loc46_++;
         }
         if(param2.starAdd)
         {
            _loc16_ = int(param2.starAdd.length);
            _loc52_ = 0;
            while(_loc52_ < _loc16_)
            {
               _loc6_ = param2.starAdd[_loc52_] as SimpleStarAdditionMsg;
               _loc32_ = new StarTroughInfo();
               _loc32_.pos = _loc6_.pos;
               _loc32_.grade = _loc6_.grade;
               param1.starTroughs[_loc6_.pos] = _loc32_;
               _loc52_++;
            }
         }
         for each(var _loc13_:SimpleWatchMsg in param2.watch)
         {
            _loc14_ = param1.battleGuardInfo.getSocketInfo(_loc13_.gridType,_loc13_.gridPos - 1);
            _loc14_.addItem(_loc13_.jion1,0);
            _loc14_.addItem(_loc13_.jion2,1);
            _loc14_.addItem(_loc13_.jion3,2);
            _loc14_.state = 1;
            _loc14_.commit();
         }
         if(param2.mount)
         {
            param1.mountInfo = SimpleMountInfo.createFromMountInfoMsg(param2.mount);
            if(param1.vocationGrades <= 0)
            {
               param1.mountInfo.star = -1;
            }
         }
         var _loc51_:GoddessInfo = new GoddessInfo();
         if(param2.goddessInfo)
         {
            _loc51_.userId = param2.goddessInfo.userId;
            _loc51_.templateId = param2.goddessInfo.templateId;
            _loc51_.grade = param2.goddessInfo.grade;
            _loc51_.step = param2.goddessInfo.step;
            _loc51_.devote = param2.goddessInfo.devote;
            _loc51_.attack = param2.goddessInfo.attack;
            _loc51_.defance = param2.goddessInfo.defance;
            _loc51_.magicAttack = param2.goddessInfo.magicAttack;
            _loc51_.magicDefance = param2.goddessInfo.magicDefance;
            _loc51_.live = param2.goddessInfo.live;
            _loc51_.isActive = true;
         }
         param1.goddessInfo = _loc51_;
         var _loc53_:MonsterInfo = new MonsterInfo();
         if(param2.monsterInfo)
         {
            _loc53_.monsterId = param2.monsterInfo.monsterId;
            _loc53_.isExist = param2.monsterInfo.isExist;
            _loc53_.firstValue = param2.monsterInfo.first;
            _loc53_.enterWar = param2.monsterInfo.isFight;
            _loc53_.isLock = param2.monsterInfo.isLock;
            _loc53_.name = param2.monsterInfo.name;
            _loc53_.fightPower = param2.monsterInfo.fightPower;
            _loc53_.type = param2.monsterInfo.type;
            _loc53_.star = param2.monsterInfo.star;
            _loc53_.grade = param2.monsterInfo.level;
            _loc53_.curExp = param2.monsterInfo.exp;
            _loc53_.stageGrade = param2.monsterInfo.stageLevel;
            _loc53_.stageExp = param2.monsterInfo.stateExp;
            _loc53_.skillExpValue = param2.monsterInfo.skills;
            _loc53_.isFollow = param2.monsterInfo.isFollow;
            _loc53_.setOtherData();
         }
         param1.monsterInfo = _loc53_;
         var _loc43_:AvengerModel = new AvengerModel();
         if(param2.avengerInfo)
         {
            if(param2.avengerInfo.hasGrade)
            {
               _loc43_.bodyInfo.grade = param2.avengerInfo.grade;
            }
            if(param2.avengerInfo.hasExp)
            {
               _loc43_.bodyInfo.exp = param2.avengerInfo.exp;
            }
            for each(var _loc31_:AvengerSkillMsg in param2.avengerInfo.skillDatas)
            {
               _loc23_ = _loc43_.skillDic[_loc31_.skillSonType];
               if(!_loc23_)
               {
                  _loc23_ = new AvengerSkillInfo();
                  _loc43_.skillDic.add(_loc31_.skillSonType,_loc23_);
               }
               _loc23_.skillTempId = _loc31_.skillId;
               _loc23_.skillSontype = _loc31_.skillSonType;
               _loc23_.isFight = _loc31_.isUse;
               _loc23_.attack = _loc31_.attack;
               _loc23_.defence = _loc31_.defence;
               _loc23_.magicDefence = _loc31_.magicDefence;
               _loc23_.live = _loc31_.live;
               _loc23_.forceHit = _loc31_.forcehit;
               _loc23_.parry = _loc31_.parry;
               _loc23_.penetrate = _loc31_.penetrate;
               _loc23_.reduceResi = _loc31_.reduceResi;
               _loc23_.fireResi = _loc31_.fireResi;
               _loc23_.waterResi = _loc31_.waterResi;
               _loc23_.electResi = _loc31_.electResi;
               _loc23_.windResi = _loc31_.windResi;
               _loc23_.darkResi = _loc31_.darkResi;
               _loc23_.lightResi = _loc31_.lightResi;
               _loc23_.needItems = _loc31_.itemInfo;
            }
         }
         param1.avengerInfo = _loc43_;
         var _loc30_:TheseussoulModel = new TheseussoulModel();
         if(param2.theseusInfo)
         {
            _loc30_.propertys.armour = param2.theseusInfo.armour;
            _loc30_.level = param2.theseusInfo.level;
            if(param2.theseusInfo.theseusEquipList)
            {
               for each(var _loc22_:TheseusEquipMsg in param2.theseusInfo.theseusEquipList)
               {
                  _loc50_ = new WarFrameItemInfo();
                  _loc50_.id = _loc22_.id;
                  _loc50_.type = _loc22_.type;
                  _loc50_.pos = _loc22_.pos;
                  _loc50_.templateId = _loc22_.templateId;
                  _loc50_.strengthen = _loc22_.strengthen;
                  _loc50_.reform = _loc22_.quality;
                  _loc50_.isEquip = _loc22_.isEquip;
                  _loc50_.isExist = _loc22_.isExist;
                  _loc50_.count = _loc22_.count;
                  _loc30_.updateSuite1(_loc22_.equipPos,_loc50_.id,"suite" + _loc50_.warTempInfo.Property1);
                  _loc30_.putItem(_loc50_.id,_loc50_);
               }
            }
         }
         param1.theseusInfo = _loc30_;
         if(param2.fightPet)
         {
            for each(var _loc3_:PetInfoMsg in param2.fightPet.petInfo)
            {
               _loc48_ = new PetData();
               _loc48_.userId = param1.userId;
               _loc46_ = 0;
               while(_loc46_ < param2.fightPet.equipmets.length)
               {
                  _loc11_ = new GoodsInfo();
                  _loc11_.templateId = param2.fightPet.equipmets[_loc46_].templateId;
                  _loc11_.pos = param2.fightPet.equipmets[_loc46_].pos;
                  _loc11_.isBind = param2.fightPet.equipmets[_loc46_].isBind;
                  _loc11_.join1 = param2.fightPet.equipmets[_loc46_].join1;
                  _loc11_.join2 = param2.fightPet.equipmets[_loc46_].join2;
                  _loc11_.join3 = param2.fightPet.equipmets[_loc46_].join3;
                  _loc11_.join4 = param2.fightPet.equipmets[_loc46_].join4;
                  _loc11_.isBinds = param2.fightPet.equipmets[_loc46_].isBind;
                  _loc11_.randomSkill1 = param2.fightPet.equipmets[_loc46_].randomSkill1;
                  _loc11_.randomSkill2 = param2.fightPet.equipmets[_loc46_].randomSkill2;
                  _loc11_.randomSkill3 = param2.fightPet.equipmets[_loc46_].randomSkill3;
                  _loc11_.randomSkill4 = param2.fightPet.equipmets[_loc46_].randomSkill4;
                  _loc11_.randomSkill5 = param2.fightPet.equipmets[_loc46_].randomSkill5;
                  _loc11_.mouldGrade = param2.fightPet.equipmets[_loc46_].mouldGrade;
                  _loc48_.equipList.push(_loc11_);
                  _loc46_++;
               }
               PetData.createWithMsg(_loc3_,_loc48_);
            }
            param1.enterWarPet = _loc48_;
         }
         if(param2.fightChild)
         {
            _loc17_ = new ChildData();
            _loc17_.userIdA = param2.fightChild.userIdA;
            _loc17_.isSelfData = false;
            _loc46_ = 0;
            while(_loc46_ < param2.fightChild.equipmets.length)
            {
               _loc10_ = new GoodsInfo();
               _loc10_.id = 1;
               _loc10_.templateId = param2.fightChild.equipmets[_loc46_].templateId;
               _loc10_.pos = param2.fightChild.equipmets[_loc46_].pos;
               _loc10_.isBind = param2.fightChild.equipmets[_loc46_].isBind;
               _loc10_.join1 = param2.fightChild.equipmets[_loc46_].join1;
               _loc10_.join2 = param2.fightChild.equipmets[_loc46_].join2;
               _loc10_.join3 = param2.fightChild.equipmets[_loc46_].join3;
               _loc10_.join4 = param2.fightChild.equipmets[_loc46_].join4;
               _loc10_.isBinds = param2.fightChild.equipmets[_loc46_].isBind;
               _loc10_.randomSkill1 = param2.fightChild.equipmets[_loc46_].randomSkill1;
               _loc10_.randomSkill2 = param2.fightChild.equipmets[_loc46_].randomSkill2;
               _loc10_.randomSkill3 = param2.fightChild.equipmets[_loc46_].randomSkill3;
               _loc10_.randomSkill4 = param2.fightChild.equipmets[_loc46_].randomSkill4;
               _loc10_.randomSkill5 = param2.fightChild.equipmets[_loc46_].randomSkill5;
               _loc10_.mouldGrade = param2.fightChild.equipmets[_loc46_].mouldGrade;
               _loc10_.strengthenGrade = param2.fightChild.equipmets[_loc46_].strengthenGrade;
               _loc10_.objectId = _loc17_.childId;
               _loc17_.equipList.push(_loc10_);
               _loc46_++;
            }
            _loc17_.createChildWithMsg(param2.fightChild,_loc17_);
            param1.addEnterWarChild(_loc17_);
         }
      }
      
      private function __updateRobLogList(param1:SLGSocketEvent) : void
      {
         var _loc4_:PerkinLabLogInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PerkinLabLogListMsg = new PerkinLabLogListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PerkinLabLogListMsg;
         model.logList = [];
         for each(var _loc3_:PerkinLabLogMsg in _loc2_.logList)
         {
            _loc4_ = new PerkinLabLogInfo();
            _loc4_.logTime = DateFormatter.parse(_loc3_.time,"YYYY-MM-DD hh:mm:ss");
            _loc4_.type = _loc3_.type;
            _loc4_.isWin = _loc3_.win;
            _loc4_.rivalName = _loc3_.rivalName;
            _loc4_.robReward = _loc3_.robReward;
            model.logList.push(_loc4_);
         }
         model.logList.sortOn("logTime",0x10 | 2);
         if(model.logList.length > 20)
         {
            model.logList.splice(20,model.logList.length - 20);
         }
         dispatchEvent(new PerkinLabEvent("UPDATE_LOG_LIST",null));
      }
      
      public function sendLabOperate(param1:int, param2:int = -1) : void
      {
         var _loc4_:PackageOut = new PackageOut(9566);
         var _loc3_:PerkinLabClientMsg = new PerkinLabClientMsg();
         _loc3_.op = param1;
         _loc3_.index = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function get checkHasPick() : Boolean
      {
         for each(var _loc1_:PerkinLabKengInfo in model.selfKengList)
         {
            if(playerModel.sysSecond >= _loc1_.harvestTime)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function inCastle() : Boolean
      {
         return SceneManager.instance.currentType == "CASTLE_SCENE";
      }
      
      private function inSpace() : Boolean
      {
         return SceneManager.instance.currentType == "SPACE_SCENE";
      }
   }
}

