package com.road.pb.helper.army
{
   import com.road.yishi.proto.army.ArmyMsg;
   import com.road.yishi.proto.army.HeroRuneInfoMsg;
   import com.road.yishi.proto.army.SimpleHeroInfoMsg;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.armyII.RuneInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   
   public class ThaneInfoHelper
   {
      
      public function ThaneInfoHelper()
      {
         super();
      }
      
      public static function readOuterCityArmyInfo(param1:BaseArmy, param2:ArmyMsg) : BaseArmy
      {
         param1.nickName = param2.nickName;
         param1.type = param2.type;
         param1.mapId = param2.mapId;
         param1.curPosX = param2.curPosX;
         param1.curPosY = param2.curPosY;
         param1.state = param2.state;
         var _loc3_:ThaneInfo = param1.baseHero;
         _loc3_.nickName = param2.nickName;
         _loc3_.templateId = param2.heroTempId;
         _loc3_.consortiaID = param2.consortiaId;
         _loc3_.consortiaName = param2.consortiaName;
         _loc3_.fightingCapacity = param2.fightingCapacity;
         _loc3_.playerOrdeInfo.gpOrder = param2.gpOrder;
         _loc3_.grades = param2.grades;
         _loc3_.bodyEquipAvata = param2.cloth;
         param2.hasWing && (_loc3_.wingAvata = param2.wing);
         _loc3_.armsEquipAvata = param2.arm;
         _loc3_.job = param2.job;
         _loc3_.userId = param2.playerId;
         _loc3_.changeShapeId = param2.changeSharp;
         _loc3_.honer = param2.geste;
         _loc3_.appellId = param2.appellid;
         _loc3_.avengerGrade = param2.avengerGrade;
         if(param2.hasFateSkills)
         {
            _loc3_.fateSkill = param2.fateSkills;
         }
         if(param2.hasMountTempId)
         {
            param1.mountTemplateId = param2.mountTempId;
         }
         if(param2.hasMountGrade)
         {
            param1.mountGrade = param2.mountGrade;
         }
         if(param2.hasHide)
         {
            _loc3_.hideFashion = param2.hide;
         }
         if(param2.hasFashionCloth)
         {
            _loc3_.bodyFashionAvata = param2.fashionCloth;
         }
         if(param2.hasFashionArm)
         {
            _loc3_.armsFashionAvata = param2.fashionArm;
         }
         if(param2.hasHat)
         {
            _loc3_.hairFashionAvata = param2.hat;
         }
         if(param2.hasPetTempId)
         {
            param1.petInfo.petTemplateId = param2.petTempId;
            _loc3_.petTemplateId = param2.petTempId;
         }
         if(param2.hasPetName)
         {
            param1.petInfo.petName = param2.petName;
            _loc3_.petName = param2.petName;
         }
         if(param2.hasPetQuqlity)
         {
            if(param2.petQuqlity < 26)
            {
               param1.petInfo.petQuaity = (param2.petQuqlity - 1) / 5 + 1;
               _loc3_.petQuaity = (param2.petQuqlity - 1) / 5 + 1;
            }
            else
            {
               param1.petInfo.petQuaity = (param2.petQuqlity - 1) / 5;
               _loc3_.petQuaity = (param2.petQuqlity - 1) / 5;
            }
            param1.petInfo.petTemQuality = param2.petQuqlity;
            _loc3_.temQuality = param2.petQuqlity;
         }
         if(param2.hasChildName)
         {
            param1.childrenInfo.childrenName = param2.childName;
         }
         if(param2.hasChildJob)
         {
            param1.childrenInfo.childrenJob = param2.childJob;
         }
         if(param2.hasChildSex)
         {
            param1.childrenInfo.childrenSex = param2.childSex;
         }
         if(param2.hasGrowthGrade)
         {
            param1.childrenInfo.childrenGrade = param2.growthGrade;
         }
         if(param2.hasMonsterId)
         {
            param1.monsterInfo.monsterTemplateId = param2.monsterId;
         }
         if(param2.hasGrowthGrade2)
         {
            param1.childrenInfo.growthGrade2 = param2.growthGrade2;
         }
         return param1;
      }
      
      public static function cloneArmyInfo(param1:BaseArmy, param2:BaseArmy) : BaseArmy
      {
         param1.nickName = param2.nickName;
         param1.type = param2.type;
         param1.mapId = param2.mapId;
         param1.curPosX = param2.curPosX;
         param1.curPosY = param2.curPosY;
         param1.state = param2.state;
         param1.mountTemplateId = param2.mountTemplateId;
         param1.mountGrade = param2.mountGrade;
         var _loc3_:ThaneInfo = param1.baseHero;
         var _loc4_:ThaneInfo = param2.baseHero;
         _loc3_.nickName = _loc4_.nickName;
         _loc3_.templateId = _loc4_.templateId;
         _loc3_.consortiaID = _loc4_.consortiaID;
         _loc3_.consortiaName = _loc4_.consortiaName;
         _loc3_.fightingCapacity = _loc4_.fightingCapacity;
         _loc3_.playerOrdeInfo.gpOrder = _loc4_.playerOrdeInfo.gpOrder;
         _loc3_.grades = _loc4_.grades;
         _loc3_.bodyEquipAvata = _loc4_.bodyEquipAvata;
         _loc3_.armsEquipAvata = _loc4_.armsEquipAvata;
         _loc3_.wingAvata = _loc4_.wingAvata;
         _loc3_.job = _loc4_.job;
         _loc3_.userId = _loc4_.userId;
         _loc3_.changeShapeId = _loc4_.changeShapeId;
         _loc3_.honer = _loc4_.honer;
         _loc3_.appellId = _loc4_.appellId;
         _loc3_.hideFashion = _loc4_.hideFashion;
         _loc3_.bodyFashionAvata = _loc4_.bodyFashionAvata;
         _loc3_.armsFashionAvata = _loc4_.armsFashionAvata;
         _loc3_.hairFashionAvata = _loc4_.hairFashionAvata;
         _loc3_.wingAvata = _loc4_.wingAvata;
         return param1;
      }
      
      public static function readHeroInfo(param1:ThaneInfo, param2:SimpleHeroInfoMsg, param3:ArmyMsg = null) : void
      {
         param1.beginChanges();
         if(param3)
         {
            param1.bodyEquipAvata = param3.cloth;
            param1.armsEquipAvata = param3.arm;
            if(param3.hasWing)
            {
               param1.wingAvata = param3.wing;
            }
            if(param3.hasHide)
            {
               param1.hideFashion = param3.hide;
            }
            if(param3.hasFashionCloth)
            {
               param1.bodyFashionAvata = param3.fashionCloth;
            }
            if(param3.hasFashionArm)
            {
               param1.armsFashionAvata = param3.fashionArm;
            }
            if(param3.hasHat)
            {
               param1.hairFashionAvata = param3.hat;
            }
            if(param3.hasAppellid)
            {
               param1.appellId = param3.appellid;
            }
            if(param3.hasChangeSharp)
            {
               param1.changeShapeId = param3.changeSharp;
            }
            if(param3.hasAvengerGrade)
            {
               param1.avengerGrade = param3.avengerGrade;
            }
         }
         if(param2.hasHeroId)
         {
            param1.id = param2.heroId;
         }
         if(param2.hasNickName)
         {
            param1.nickName = param2.nickName;
         }
         if(param2.hasTempateId)
         {
            param1.templateId = param2.tempateId;
         }
         if(param2.hasHeadId)
         {
            param1.headId = param2.headId;
         }
         if(param2.hasPlayerId)
         {
            param1.userId = param2.playerId;
         }
         if(param2.hasHp)
         {
            param1.hp = param2.hp;
         }
         if(param2.hasBlood)
         {
            param1.blood = param2.blood;
         }
         if(param2.hasBloodId)
         {
            param1.bloodId = param2.bloodId;
         }
         if(param2.hasRemainPoint)
         {
            param1.baseProperty.remainPoint = param2.remainPoint;
         }
         if(param2.hasBasePower)
         {
            param1.baseProperty.basePowerPoint = param2.basePower;
         }
         if(param2.hasBaseAgility)
         {
            param1.baseProperty.baseAgilityPoint = param2.baseAgility;
         }
         if(param2.hasBaseIntellect)
         {
            param1.baseProperty.baseIntellectPoint = param2.baseIntellect;
         }
         if(param2.hasBaseCaptain)
         {
            param1.baseProperty.baseCaptainPoint = param2.baseCaptain;
         }
         if(param2.hasBasePhysique)
         {
            param1.baseProperty.basePhysiquePoint = param2.basePhysique;
         }
         if(param2.hasPowerPoint)
         {
            param1.baseProperty.addPowerPoint = param2.powerPoint;
         }
         if(param2.hasAgilityPoint)
         {
            param1.baseProperty.addAgilityPoint = param2.agilityPoint;
         }
         if(param2.hasIntellectPoint)
         {
            param1.baseProperty.addIntellectPoint = param2.intellectPoint;
         }
         if(param2.hasPhysiquePoint)
         {
            param1.baseProperty.addPhysiquePoint = param2.physiquePoint;
         }
         if(param2.hasCaptainPoint)
         {
            param1.baseProperty.addCaptainPoint = param2.captainPoint;
         }
         if(param2.hasTotalPower)
         {
            param1.baseProperty.totalPower = param2.totalPower;
         }
         if(param2.hasTotalAgility)
         {
            param1.baseProperty.totalAgility = param2.totalAgility;
         }
         if(param2.hasTotalIntellect)
         {
            param1.baseProperty.totalIntellect = param2.totalIntellect;
         }
         if(param2.hasTotalCaptain)
         {
            param1.baseProperty.totalCaptain = param2.totalCaptain;
         }
         if(param2.hasTotalPhysique)
         {
            param1.baseProperty.totalPhysique = param2.totalPhysique;
         }
         if(param2.hasBasePhyAttack)
         {
            param1.attackProrerty.basePhyAttack = param2.basePhyAttack;
         }
         if(param2.hasBasePhyDefence)
         {
            param1.attackProrerty.basePhyDefence = param2.basePhyDefence;
         }
         if(param2.hasBaseMagicAttack)
         {
            param1.attackProrerty.baseMagicAttack = param2.baseMagicAttack;
         }
         if(param2.hasBaseMagicDefence)
         {
            param1.attackProrerty.baseMagicDefence = param2.baseMagicDefence;
         }
         if(param2.hasBaseForceHit)
         {
            param1.attackProrerty.baseForceHit = param2.baseForceHit;
         }
         if(param2.hasBaseLive)
         {
            param1.attackProrerty.baseLive = param2.baseLive;
         }
         if(param2.hasBaseConatArmy)
         {
            param1.attackProrerty.baseConatArmy = param2.baseConatArmy;
         }
         if(param2.hasBaseParry)
         {
            param1.attackProrerty.baseParry = param2.baseParry;
         }
         if(param2.hasBasePenetrate)
         {
            param1.attackProrerty.basePenetrate = param2.basePenetrate;
         }
         if(param2.hasBaseStunAttr)
         {
            param1.attackProrerty.baseDingli = param2.baseStunAttr;
         }
         if(param2.hasTotalStunAttr)
         {
            param1.attackProrerty.totalDingli = param2.totalStunAttr;
         }
         if(param2.hasTotalPhyAttack)
         {
            param1.attackProrerty.totalPhyAttack = param2.totalPhyAttack;
         }
         if(param2.hasTotalPhyDefence)
         {
            param1.attackProrerty.totalPhyDefence = param2.totalPhyDefence;
         }
         if(param2.hasTotalMagicAttack)
         {
            param1.attackProrerty.totalMagicAttack = param2.totalMagicAttack;
         }
         if(param2.hasTotalMagicDefence)
         {
            param1.attackProrerty.totalMagicDefence = param2.totalMagicDefence;
         }
         if(param2.hasTotalForceHit)
         {
            param1.attackProrerty.totalForceHit = param2.totalForceHit;
         }
         if(param2.hasTotalLive)
         {
            param1.attackProrerty.totalLive = param2.totalLive;
         }
         if(param2.hasTotalConatArmy)
         {
            param1.attackProrerty.totalConatArmy = param2.totalConatArmy;
         }
         if(param2.hasTotalParry)
         {
            param1.attackProrerty.totalParry = param2.totalParry;
         }
         if(param2.hasBaseStrength)
         {
            param1.attackProrerty.baseIntensity = param2.baseStrength;
         }
         if(param2.hasTotalStrength)
         {
            param1.attackProrerty.totalIntensity = param2.totalStrength;
         }
         if(param2.hasBaseTenacity)
         {
            param1.attackProrerty.baseTenacity = param2.baseTenacity;
         }
         if(param2.hasTotalTenacity)
         {
            param1.attackProrerty.totalTenacity = param2.totalTenacity;
         }
         if(param2.hasTotalPenetrate)
         {
            param1.attackProrerty.totalPenetrate = param2.totalPenetrate;
         }
         param1.skillCate.beginChange();
         if(param2.hasSkillPoint)
         {
            param1.skillCate.skillPoint = param2.skillPoint;
         }
         if(param2.hasSkillScript)
         {
            param1.skillCate.skillScript = param2.skillScript;
         }
         if(param2.hasFastKey)
         {
            param1.skillCate.fastKey = param2.fastKey;
         }
         if(param2.hasSkillIndex)
         {
            param1.skillCate.skillIndex = param2.skillIndex;
         }
         if(param2.hasIsActiveSecond)
         {
            param1.skillCate.activeDouble = param2.isActiveSecond;
         }
         param1.talentData.beginChange();
         if(param2.hasTalentPoint)
         {
            param1.talentData.talentPoint = param2.talentPoint;
         }
         if(param2.hasTalentGrade)
         {
            param1.talentData.talentGrade = param2.talentGrade;
         }
         if(param2.hasAdvancedTalentGrade)
         {
            param1.talentData.advTalentGrade = param2.advancedTalentGrade;
         }
         if(param2.hasAdvancedTalentPoint)
         {
            param1.talentData.advTalentPoint = param2.advancedTalentPoint;
         }
         if(param2.hasTalentSkill)
         {
            param1.talentData.talentScript = param2.talentSkill;
         }
         if(param2.hasAdvancedTalentSkill)
         {
            param1.talentData.advTalentScript = param2.advancedTalentSkill;
         }
         if(param2.hasRune)
         {
            readHeroRuneInfo(param1,param2);
         }
         param1.fightPos = param2.fightPos;
         param1.baseProperty.totalBattleWill = param2.reduceResi;
         param1.baseProperty.totalFireResi = param2.fireResi;
         param1.baseProperty.totalWaterResi = param2.waterResi;
         param1.baseProperty.totalWindResi = param2.windResi;
         param1.baseProperty.totalElecResi = param2.electResi;
         param1.baseProperty.totalLightResi = param2.lightResi;
         param1.baseProperty.totalDarkResi = param2.darkResi;
         param1.baseProperty.totalStrikeResi = param2.totalResiPenetrate;
         param1.baseProperty.totalResistResi = param2.totalReduceResiAgainst;
         param1.baseProperty.hasSetBattleInfoFlag = true;
         param1.baseProperty.commit();
         param1.attackProrerty.commit();
         param1.skillCate.commit();
         param1.talentData.commit();
         param1.checkFirst();
         param1.commit();
      }
      
      private static function readHeroRuneInfo(param1:ThaneInfo, param2:SimpleHeroInfoMsg) : void
      {
         var _loc6_:HeroRuneInfoMsg = null;
         var _loc7_:RuneInfo = null;
         var _loc3_:RuneTemplateInfo = null;
         var _loc5_:int = 0;
         param1.runeCate.runeScript = param2.rune.runeKey;
         var _loc4_:int = int(param2.rune.runeinfo.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param2.rune.runeinfo[_loc5_];
            _loc3_ = TempleteManager.instance.getRuneTemplateByTid(_loc6_.runeId);
            _loc7_ = new RuneInfo();
            _loc7_.grade = _loc3_.RuneGrade;
            _loc7_.runeId = _loc6_.runeId;
            _loc7_.runeCurGp = _loc6_.runeGp;
            _loc7_.swallowCount = _loc6_.swallowCount;
            _loc7_.baseProperties.readData(_loc6_.baseProperties);
            _loc7_.runeHole = _loc6_.runeHole;
            if(_loc7_.runeHole != null && _loc7_.runeHole != "")
            {
               param1.runeStoneOpen = true;
            }
            _loc7_.runeTempHole = _loc6_.tempHole;
            _loc7_.newSkillTempId = _loc6_.newSkillTempId;
            param1.runeCate.studiedRuneList.add(_loc7_.templateInfo.RuneType,_loc7_);
            _loc5_++;
         }
      }
      
      public static function getJob(param1:int) : int
      {
         switch(param1)
         {
            case 1:
            case 4:
               break;
            case 2:
            case 5:
               return 2;
            case 3:
            case 6:
               return 3;
            case 101:
            case 102:
               return 4;
            default:
               return 1;
         }
         return 1;
      }
      
      public static function getSelfJobStr() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = ArmyManager.instance.thane.templateInfo.Job;
         switch(_loc1_ - 1)
         {
            case 0:
               _loc2_ = "warrior";
               break;
            case 1:
               _loc2_ = "hunter";
               break;
            case 2:
               _loc2_ = "wizard";
               break;
            case 3:
               _loc2_ = "dragonic/dragonman";
               break;
            default:
               _loc2_ = "wizard";
         }
         return _loc2_;
      }
      
      public static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public static function get vice() : ThaneInfo
      {
         return ArmyManager.instance.vice;
      }
      
      public static function get currentThane() : ThaneInfo
      {
         if(vice.isViceHero)
         {
            return vice;
         }
         return thane;
      }
      
      public static function getPawnMaxTempIDBySontype(param1:int) : int
      {
         return int(param1 + "80");
      }
   }
}

