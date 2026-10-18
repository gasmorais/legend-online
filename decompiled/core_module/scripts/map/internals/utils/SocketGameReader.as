package map.internals.utils
{
   import battle.BattleManager;
   import battle.data.BufferDamageData;
   import battle.data.DamageData;
   import battle.utils.Int64Utils;
   import com.pickgliss.utils.ArrayUtils;
   import com.road.yishi.proto.army.ArmyMsg;
   import com.road.yishi.proto.army.ArmyPawnInfoMsg;
   import com.road.yishi.proto.army.PropertyMsg;
   import com.road.yishi.proto.battle.AttackOrderMsg;
   import com.road.yishi.proto.battle.BattleItemMsg;
   import com.road.yishi.proto.battle.BufferMsg;
   import com.road.yishi.proto.battle.DamageMsg;
   import com.road.yishi.proto.battle.DropInfoMsg;
   import com.road.yishi.proto.battle.HeroMsg;
   import com.road.yishi.proto.battle.SkillStateMsg;
   import com.road.yishi.proto.battle.SoldierMsg;
   import com.road.yishi.proto.battle.TrialInfoMsg;
   import com.road.yishi.proto.simple.RelationPlayerMsg;
   import map.campaign.data.TrailPropInfo;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.friends.FriendItemCellInfo;
   import yishi.datas.BattlePropItem;
   import yishi.datas.objects.GoddessRoleInfo;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.MonsterRoleInfo;
   import yishi.datas.objects.PawnRoleInfo;
   import yishi.datas.objects.PetRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.objects.SelfChessRoleInfo;
   import yishi.datas.playerinfo.BattleReplaceSkillInfo;
   import yishi.utils.DateFormatter;
   
   public class SocketGameReader
   {
      
      public function SocketGameReader()
      {
         super();
      }
      
      public static function readArmyInfo(param1:BaseArmy, param2:ArmyMsg) : void
      {
         param1.id = param2.armyId;
         param1.userId = param2.playerId;
         param1.nickName = param2.nickName;
         param1.type = param2.type;
         param1.mapId = param2.mapId;
         param1.curPosX = param2.curPosX;
         param1.curPosY = param2.curPosY;
         param1.state = param2.state;
         if(param2.hasMountTempId)
         {
            param1.mountTemplateId = param2.mountTempId;
         }
         if(param2.hasMountGrade)
         {
            param1.mountGrade = param2.mountGrade;
         }
      }
      
      public static function readPawnInfo(param1:ArmyPawn, param2:ArmyPawnInfoMsg) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PropertyMsg = null;
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc3_ = param2.pawnLive[_loc4_] as PropertyMsg;
            param1.getPropertyByType(_loc4_).bagData = _loc3_.bag_Data;
            param1.getPropertyByType(_loc4_).starData = _loc3_.star_Data;
            param1.getPropertyByType(_loc4_).skillData = _loc3_.skill_Data;
            param1.getPropertyByType(_loc4_).effectData = _loc3_.effect_Data;
            param1.getPropertyByType(_loc4_).bagPer = _loc3_.bag_Per;
            param1.getPropertyByType(_loc4_).starPer = _loc3_.star_Per;
            param1.getPropertyByType(_loc4_).skillPer = _loc3_.skill_Per;
            param1.getPropertyByType(_loc4_).effectPer = _loc3_.effect_Per;
            _loc4_++;
         }
         param1.templateId = param2.tempateId;
         param1.ownPawns = param2.ownPawns;
         param1.specialAbility = param2.specialTempIds;
         param1.tempSpecial = param2.comprehednTempIds;
         param1.blessNum = param2.blessNum;
         param1.commit();
      }
      
      public static function readArmyPawnInfo(param1:BaseArmy, param2:ArmyPawnInfoMsg) : void
      {
         var _loc8_:int = 0;
         var _loc7_:PropertyMsg = null;
         var _loc6_:int = param2.armyId;
         var _loc4_:int = param2.sites;
         var _loc3_:int = param2.sonType;
         var _loc5_:int = param2.tempateId;
         var _loc9_:ArmyPawn = param1.getPawnByIndex(_loc4_);
         _loc8_ = 0;
         while(_loc8_ < 6)
         {
            _loc7_ = param2.pawnLive[_loc8_] as PropertyMsg;
            _loc9_.getPropertyByType(_loc8_).bagData = _loc7_.bag_Data;
            _loc9_.getPropertyByType(_loc8_).starData = _loc7_.star_Data;
            _loc9_.getPropertyByType(_loc8_).skillData = _loc7_.skill_Data;
            _loc9_.getPropertyByType(_loc8_).effectData = _loc7_.effect_Data;
            _loc9_.getPropertyByType(_loc8_).bagPer = _loc7_.bag_Per;
            _loc9_.getPropertyByType(_loc8_).starPer = _loc7_.star_Per;
            _loc9_.getPropertyByType(_loc8_).skillPer = _loc7_.skill_Per;
            _loc9_.getPropertyByType(_loc8_).effectPer = _loc7_.effect_Per;
            _loc8_++;
         }
         _loc9_.fightPos = param2.fightPos;
         _loc9_.armyId = _loc6_;
         _loc9_.templateId = _loc5_;
         _loc9_.ownPawns = param2.ownPawns;
         _loc9_.specialAbility = param2.specialTempIds;
         _loc9_.tempSpecial = param2.comprehednTempIds;
         _loc9_.commit();
      }
      
      public static function readBufferII(param1:AttackOrderMsg) : Vector.<BufferDamageData>
      {
         var _loc9_:BufferDamageData = null;
         var _loc5_:Boolean = false;
         var _loc10_:BufferMsg = null;
         var _loc7_:int = 0;
         var _loc6_:DamageMsg = null;
         var _loc3_:DamageData = null;
         var _loc8_:int = 0;
         var _loc2_:int = int(param1.buffers.length);
         var _loc4_:Vector.<BufferDamageData> = new Vector.<BufferDamageData>();
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc10_ = param1.buffers[_loc7_];
            _loc9_ = new BufferDamageData();
            _loc9_.id = _loc10_.bufferId;
            _loc9_.templateId = _loc10_.templateId;
            _loc9_.bufferUser = _loc10_.sourceId;
            _loc9_.target = _loc10_.targetId;
            _loc9_.currentTurn = _loc10_.curTurn;
            _loc9_.countWay = _loc10_.curRound;
            _loc9_.processType = _loc10_.seeType;
            _loc9_.effectiveType = _loc10_.exeWay;
            _loc9_.layerCount = _loc10_.pressedNum;
            _loc9_.unAblesSillIds = _loc10_.unSkillIds;
            _loc9_.isPermanent = _loc10_.isPermanent;
            _loc9_.targetSkillId = _loc10_.targetSkillId;
            if(_loc9_.processType == 0)
            {
               _loc9_.curMaxTurn = _loc10_.maxTurn;
            }
            _loc9_.damages = new Vector.<DamageData>();
            _loc8_ = 0;
            while(_loc8_ < _loc10_.damage.length)
            {
               _loc6_ = _loc10_.damage[_loc8_];
               _loc9_.isIcon = _loc6_.hasIcon;
               _loc3_ = readDamage(_loc6_);
               _loc9_.damages.push(_loc3_);
               _loc8_++;
            }
            _loc9_.execFrameTime = _loc10_.execFrame;
            _loc4_.push(_loc9_);
            _loc7_++;
         }
         return _loc4_;
      }
      
      public static function readDamage(param1:DamageMsg) : DamageData
      {
         var _loc3_:DamageData = new DamageData();
         _loc3_.bloodType = param1.damageType;
         _loc3_.damageValue = Int64Utils.int64ToNumber(param1.damageValue);
         if(param1.hasHpLimit)
         {
            _loc3_.hpMaxAdd = Int64Utils.int64ToNumber(param1.hpLimit);
         }
         _loc3_.displayBlood = _loc3_.damageValue;
         _loc3_.leftValue = Int64Utils.int64ToNumber(param1.leftValue);
         _loc3_.extraData = param1.extraData;
         _loc3_.target = param1.livingId;
         _loc3_.damageCount = param1.order;
         for each(var _loc2_:DropInfoMsg in param1.dropInfos)
         {
            _loc3_.dropList.push(_loc2_);
         }
         return _loc3_;
      }
      
      public static function readAwakenData(param1:AttackOrderMsg) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:SoldierMsg = null;
         var _loc4_:int = 0;
         if(param1.awakenSoldiers.length > 0)
         {
            _loc2_ = [];
            _loc4_ = 0;
            while(_loc4_ < param1.awakenSoldiers.length)
            {
               _loc3_ = param1.awakenSoldiers[_loc4_];
               _loc2_.push(readPawnRoleInfo(_loc3_));
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      public static function readPawnRoleInfo(param1:SoldierMsg) : PawnRoleInfo
      {
         var _loc2_:PawnRoleInfo = new PawnRoleInfo();
         _loc2_.livingId = param1.livingId;
         _loc2_.templateId = param1.tempId;
         _loc2_.armyType = param1.type;
         _loc2_.side = param1.side;
         _loc2_.pos = param1.pos;
         _loc2_.totalBloodA = param1.initHp;
         _loc2_.bloodA = param1.hp;
         _loc2_.skillIds = param1.skillId;
         if(BattleManager.getInstance().battleModel != null)
         {
            _loc2_.face = _loc2_.side == BattleManager.getInstance().battleModel.selfSide ? 1 : 2;
         }
         var _loc3_:Number = param1.qteTime;
         _loc3_ += param1.castTime;
         _loc2_.coldDownTime = _loc3_;
         _loc2_.initView();
         return _loc2_;
      }
      
      public static function readHeroRoleInfo(param1:HeroMsg, param2:HeroMsg, param3:HeroMsg, param4:Boolean = false) : HeroRoleInfo
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc6_:SkillStateMsg = null;
         var _loc12_:TrailPropInfo = null;
         var _loc7_:HeroRoleInfo = new HeroRoleInfo();
         _loc7_.petLivingId = param1.livingId2;
         _loc7_.heroInfo.id = param1.heroId;
         _loc7_.heroInfo.headId = param1.headId;
         _loc7_.heroInfo.isSlavedChild = param1.isSlaveChild;
         _loc7_.heroInfo.childrenSex = param1.userPics;
         _loc7_.heroInfo.childrenJob = param1.job;
         _loc7_.heroInfo.childrenGrade = param1.growthGrade;
         _loc7_.livingId = param1.livingId;
         _loc7_.userId = param1.userId;
         _loc7_.playerIconId = param1.userPics;
         _loc7_.templateId = param1.tempId;
         _loc7_.type = param1.type;
         _loc7_.curturn = param1.curturn;
         _loc7_.canTakeDamage = true;
         _loc7_.isManualChild = param1.isManualChild;
         _loc7_.warsoulSkills = param1.warSoulSkills;
         _loc7_.updateWarsoulSp(param1.warSoulSp);
         _loc7_.warsoulType = param1.warSoulType;
         _loc7_.thessBoxSkills = param1.addSkills;
         _loc7_.heroInfo.nickName = param1.nickName;
         _loc7_.heroInfo.grades = param1.grade;
         _loc7_.side = param1.side;
         _loc7_.pos = param1.pos;
         _loc7_.titanId = 0;
         _loc7_.titanSkill = [];
         _loc7_.titanSkillUsed = [0,0,0,0,0,0,0,0,0,0];
         if(param1.titanInfo)
         {
            _loc7_.titanId = param1.titanInfo.titanId;
            _loc11_ = 0;
            while(_loc11_ < param1.titanInfo.titanSkill.length)
            {
               _loc6_ = param1.titanInfo.titanSkill[_loc11_] as SkillStateMsg;
               _loc7_.titanSkill.push(_loc6_.skillId);
               _loc7_.titanSkillUsed[_loc11_] = _loc6_.state;
               _loc11_++;
            }
         }
         if(BattleManager.getInstance().battleModel != null)
         {
            _loc7_.face = _loc7_.side == BattleManager.getInstance().battleModel.selfSide ? 1 : 2;
         }
         _loc7_.heroInfo.sexs = _loc7_.heroInfo.templateInfo.Sexs;
         _loc7_.totalBloodA = Int64Utils.int64ToNumber(param1.maxHp);
         _loc9_ = Int64Utils.int64ToNumber(param1.hp);
         _loc10_ = Int64Utils.int64ToNumber(param1.hp2);
         if(param1.hasSpMax)
         {
            _loc7_.spMax = param1.spMax;
         }
         _loc7_.updateSp(param1.sp,true,false,false);
         _loc7_.updateBelief(param1.belief);
         if(param1.hasHitPointMax)
         {
            _loc7_.hitPointMax = param1.hitPointMax;
         }
         _loc7_.updateHitPoint(param1.hitPoint,true,false,false);
         _loc7_.updateAvengerSp(param1.avengerSp);
         _loc7_.avengerFightSkills = param1.avengerSkills;
         _loc7_.avengerAllSkills = param1.avengerAllSkills;
         _loc7_.avengerWaitSec = param1.avengerLeftCd;
         _loc7_.heroInfo.userId = param1.userId;
         _loc7_.heroInfo.armsEquipAvata = param1.slotAvata;
         _loc7_.heroInfo.bodyEquipAvata = param1.clothAvate;
         _loc7_.heroInfo.cloakAvata = param1.cloakPath;
         _loc7_.heroInfo.hairEquipAvata = param1.hairPath;
         _loc7_.heroInfo.wingAvata = param1.wingAvata;
         _loc7_.heroInfo.bodyFashionAvata = param1.fashionClothAvata;
         _loc7_.heroInfo.armsFashionAvata = param1.fashionArmAvata;
         _loc7_.heroInfo.hairFashionAvata = param1.hairPath;
         _loc7_.heroInfo.dragonTalkerInfo.battleBeastId = param1.fightMount;
         _loc7_.heroInfo.dragonTalkerInfo.isDragonTalker = param1.isDragonTalker;
         _loc7_.heroInfo.fateSkill = param1.fateSkillTempIds;
         _loc7_.heroInfo.vocationGrades = param1.transferGrade;
         _loc7_.heroInfo.vocationIndex = param1.changeBranch;
         _loc7_.pawnTempId = param1.pawnTempId;
         _loc7_.resPath = param1.res;
         _loc7_.needShow = param1.isShow;
         _loc7_.showShadow = param1.hasShadow;
         var _loc8_:Number = param1.qteTime;
         _loc8_ = _loc8_ + param1.castTime;
         _loc7_.coldDownTime = _loc8_;
         _loc7_.skillIds = ArrayUtils.cloneArray(param1.skillId);
         _loc7_.petSkillIds = ArrayUtils.cloneArray(param1.changeSkillId);
         _loc7_.props = readBattleProps(param1);
         _loc7_.trialProps = readTrialProps(param1);
         _loc7_.battleServerName = param1.serverName;
         _loc7_.multiLordsInspireLevel = param1.multiLordsInspireLevel;
         _loc7_.heroInfo.avengerGrade = param1.avengerGrade;
         if(param1.hasReplaceSkill)
         {
            _loc7_.replaceSkillInfo = new BattleReplaceSkillInfo();
            _loc7_.replaceSkillInfo.fastKey = param1.replaceSkill.fastKey;
            _loc7_.replaceSkillInfo.petFastKey = param1.replaceSkill.petFastKey;
            _loc7_.replaceSkillInfo.childFastKey = param1.replaceSkill.childFastKey;
            _loc7_.replaceSkillInfo.childSkills = param1.replaceSkill.childSkills;
            _loc7_.replaceSkillInfo.talnetSkill = param1.replaceSkill.talnetSkill;
         }
         _loc7_.refreshEffectInfo();
         _loc7_.totalBlood = _loc9_;
         _loc7_.initBloodA = _loc9_;
         _loc7_.initBloodB = _loc10_;
         _loc7_.bloodA = _loc9_;
         _loc7_.bloodB = _loc10_;
         if(_loc9_ <= 0)
         {
            _loc7_.isLiving = false;
         }
         readReinforceBuffer(param1,_loc7_);
         _loc7_.isPetState = param1.isChange;
         _loc7_.marrUserId = param1.mateId;
         for each(var _loc5_:TrialInfoMsg in param1.marSkills)
         {
            _loc12_ = new TrailPropInfo();
            _loc12_.id = _loc5_.skillId;
            _loc12_.useCount = _loc5_.count;
            _loc7_.marrSkills.push(_loc12_);
         }
         if(param2)
         {
            _loc7_.petRoleInfo = SocketGameReader.readPetRoleInfo(param2);
            _loc7_.petRoleInfo.heroRoleInfo = _loc7_;
            _loc7_.heroInfo.petTemplateId = param2.tempId;
         }
         if(param3)
         {
            _loc7_.goddessRoleInfo = SocketGameReader.readGoddessRoleInfo(param3);
            _loc7_.goddessRoleInfo.heroRoleInfo = _loc7_;
            _loc7_.goddessRoleInfo.templateId = param3.tempId;
         }
         _loc7_.isChildFake = param4;
         if(_loc7_.isChildFake)
         {
            if(!_loc7_.heroInfo.isSlavedChild)
            {
               _loc7_.heroInfo.headId = param1.headId;
               _loc7_.updateChildAwaken(param1.awake);
            }
            _loc7_.updateChildChangeValue(param1.childAwake);
         }
         else
         {
            _loc7_.updateAwaken(param1.awake);
         }
         _loc7_.initView();
         if(_loc7_.petRoleInfo)
         {
            _loc7_.petRoleInfo.initView();
         }
         if(_loc7_.goddessRoleInfo)
         {
            _loc7_.goddessRoleInfo.initView();
         }
         return _loc7_;
      }
      
      public static function readSelfChessRoleInfo(param1:HeroMsg) : SelfChessRoleInfo
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:SelfChessRoleInfo = new SelfChessRoleInfo();
         _loc2_.userLivingId = param1.livingId2;
         _loc2_.userId = param1.userId;
         _loc2_.selfChessId = param1.heroId;
         _loc2_.templateId = param1.tempId;
         _loc2_.selfChessTempId = param1.tempId;
         _loc2_.name = param1.nickName;
         _loc2_.heroInfo.nickName = param1.nickName;
         _loc2_.livingId = param1.livingId;
         if(param1.hasPos)
         {
            _loc2_.pos = param1.pos;
         }
         _loc2_.side = param1.side;
         _loc2_.canTakeDamage = true;
         _loc2_.battleServerName = param1.serverName;
         _loc2_.needShow = param1.isShow;
         _loc2_.showShadow = param1.hasShadow;
         _loc2_.trialProps = readTrialProps(param1);
         var _loc3_:Number = param1.qteTime;
         _loc3_ += param1.castTime;
         _loc2_.coldDownTime = _loc3_;
         _loc2_.isChildFake = true;
         _loc2_.updateChildAwaken(param1.awake);
         _loc2_.totalBloodA = Int64Utils.int64ToNumber(param1.maxHp);
         _loc4_ = Int64Utils.int64ToNumber(param1.hp);
         _loc5_ = Int64Utils.int64ToNumber(param1.hp2);
         _loc2_.totalBlood = _loc4_;
         _loc2_.initBloodA = _loc4_;
         _loc2_.initBloodB = _loc5_;
         _loc2_.bloodA = _loc4_;
         _loc2_.bloodB = _loc5_;
         _loc2_.updateSp(param1.sp,false,false,false);
         if(_loc4_ <= 0)
         {
            _loc2_.isLiving = false;
         }
         readReinforceBuffer(param1,_loc2_);
         _loc2_.skillIds = ArrayUtils.cloneArray(param1.skillId);
         if(BattleManager.getInstance().battleModel != null)
         {
            _loc2_.face = _loc2_.side == BattleManager.getInstance().battleModel.selfSide ? 1 : 2;
         }
         _loc2_.initView();
         return _loc2_;
      }
      
      public static function readPetRoleInfo(param1:HeroMsg) : PetRoleInfo
      {
         var _loc2_:PetRoleInfo = new PetRoleInfo();
         _loc2_.userLivingId = param1.livingId2;
         _loc2_.userId = param1.userId;
         _loc2_.petId = param1.heroId;
         _loc2_.templateId = param1.tempId;
         _loc2_.name = param1.nickName;
         if(param1.petQuality < 26)
         {
            _loc2_.quality = (param1.petQuality - 1) / 5 + 1;
         }
         else
         {
            _loc2_.quality = (param1.petQuality - 1) / 5;
         }
         _loc2_.temQuality = param1.petQuality;
         _loc2_.livingId = param1.livingId;
         _loc2_.canTakeDamage = true;
         _loc2_.grades = param1.grade;
         if(param1.hasPos)
         {
            _loc2_.pos = param1.pos;
         }
         _loc2_.side = param1.side;
         if(param1.hasHp)
         {
            _loc2_.bloodA = Int64Utils.int64ToNumber(param1.hp);
         }
         _loc2_.totalBloodA = Int64Utils.int64ToNumber(param1.maxHp);
         _loc2_.skillIds = ArrayUtils.cloneArray(param1.skillId);
         return _loc2_;
      }
      
      public static function readGoddessRoleInfo(param1:HeroMsg) : GoddessRoleInfo
      {
         var _loc2_:GoddessRoleInfo = new GoddessRoleInfo();
         _loc2_.userLivingId = param1.livingId2;
         _loc2_.userId = param1.userId;
         _loc2_.templateId = param1.tempId;
         _loc2_.name = param1.nickName;
         _loc2_.livingId = param1.livingId;
         if(param1.hasPos)
         {
            _loc2_.pos = param1.pos;
         }
         _loc2_.side = param1.side;
         _loc2_.canTakeDamage = true;
         if(BattleManager.getInstance().battleModel != null)
         {
            _loc2_.face = _loc2_.side == BattleManager.getInstance().battleModel.selfSide ? 1 : 2;
         }
         _loc2_.skillIds = ArrayUtils.cloneArray(param1.skillId);
         _loc2_.updateBelief(param1.belief);
         _loc2_.isGoddess = true;
         return _loc2_;
      }
      
      public static function readMonsterRoleInfo(param1:HeroMsg) : MonsterRoleInfo
      {
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:MonsterRoleInfo = new MonsterRoleInfo();
         _loc4_.userLivingId = param1.livingId2;
         _loc4_.userId = param1.userId;
         _loc4_.monsterId = param1.heroId;
         _loc4_.templateId = param1.tempId;
         _loc4_.monsterTempId = param1.tempId;
         _loc4_.name = param1.nickName;
         _loc4_.heroInfo.nickName = param1.nickName;
         _loc4_.livingId = param1.livingId;
         _loc4_.isCaptain = param1.isCaptain;
         if(param1.hasPos)
         {
            _loc4_.pos = param1.pos;
         }
         _loc4_.side = param1.side;
         _loc4_.canTakeDamage = true;
         _loc4_.battleServerName = param1.serverName;
         _loc4_.needShow = param1.isShow;
         _loc4_.showShadow = param1.hasShadow;
         _loc4_.trialProps = readTrialProps(param1);
         var _loc2_:Number = param1.qteTime;
         _loc2_ += param1.castTime;
         _loc4_.coldDownTime = _loc2_;
         _loc4_.totalBloodA = Int64Utils.int64ToNumber(param1.maxHp);
         _loc3_ = Int64Utils.int64ToNumber(param1.hp);
         _loc5_ = Int64Utils.int64ToNumber(param1.hp2);
         _loc4_.totalBlood = _loc3_;
         _loc4_.initBloodA = _loc3_;
         _loc4_.initBloodB = _loc5_;
         _loc4_.bloodA = _loc3_;
         _loc4_.bloodB = _loc5_;
         if(_loc3_ <= 0)
         {
            _loc4_.isLiving = false;
         }
         readReinforceBuffer(param1,_loc4_);
         _loc4_.skillIds = ArrayUtils.cloneArray(param1.skillId);
         if(BattleManager.getInstance().battleModel != null)
         {
            _loc4_.face = _loc4_.side == BattleManager.getInstance().battleModel.selfSide ? 1 : 2;
         }
         _loc4_.initView();
         return _loc4_;
      }
      
      public static function readReinforceBuffer(param1:HeroMsg, param2:RoleInfo) : void
      {
         var _loc5_:int = 0;
         var _loc8_:BufferMsg = null;
         var _loc9_:BufferDamageData = null;
         var _loc6_:int = 0;
         var _loc4_:DamageMsg = null;
         var _loc7_:int = 0;
         var _loc3_:DamageData = null;
         if(param1.buffers)
         {
            _loc5_ = int(param1.buffers.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc8_ = param1.buffers[_loc6_];
               _loc9_ = new BufferDamageData();
               _loc9_.id = _loc8_.bufferId;
               _loc9_.templateId = _loc8_.templateId;
               _loc9_.bufferUser = _loc8_.sourceId;
               _loc9_.target = _loc8_.targetId;
               _loc9_.currentTurn = _loc8_.curTurn;
               _loc9_.countWay = _loc8_.curRound;
               _loc9_.targetSkillId = _loc8_.targetSkillId;
               if(_loc9_.currentTurn > 0 && _loc9_.countWay > 0)
               {
               }
               _loc9_.processType = 0;
               _loc9_.effectiveType = _loc8_.exeWay;
               _loc9_.layerCount = _loc8_.pressedNum;
               _loc9_.unAblesSillIds = _loc8_.unSkillIds;
               _loc9_.isPermanent = _loc8_.isPermanent;
               _loc9_.damages = new Vector.<DamageData>();
               _loc7_ = 0;
               while(_loc7_ < _loc8_.damage.length)
               {
                  _loc4_ = _loc8_.damage[_loc7_];
                  _loc9_.isIcon = _loc4_.hasIcon;
                  _loc3_ = new DamageData();
                  _loc3_.bloodType = _loc4_.damageType;
                  _loc3_.damageValue = Int64Utils.int64ToNumber(_loc4_.damageValue);
                  _loc3_.displayBlood = _loc3_.damageValue;
                  _loc3_.leftValue = Int64Utils.int64ToNumber(_loc4_.leftValue);
                  _loc3_.extraData = _loc4_.extraData;
                  _loc3_.target = _loc4_.livingId;
                  _loc3_.damageCount = _loc4_.order;
                  _loc9_.damages.push(_loc3_);
                  _loc7_++;
               }
               _loc9_.execFrameTime = _loc8_.execFrame;
               param2.addBuffer(_loc9_);
               _loc6_++;
            }
         }
      }
      
      private static function readTrialProps(param1:HeroMsg) : Array
      {
         var _loc4_:TrailPropInfo = null;
         var _loc2_:Array = [];
         for each(var _loc3_:TrialInfoMsg in param1.trials)
         {
            _loc4_ = new TrailPropInfo();
            _loc4_.id = _loc3_.skillId;
            _loc4_.index = _loc3_.index;
            _loc4_.useCount = _loc3_.count;
            _loc4_.coolDown = _loc3_.param4;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      private static function readBattleProps(param1:HeroMsg) : Array
      {
         var _loc3_:BattlePropItem = null;
         var _loc5_:BattleItemMsg = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.item.length)
         {
            _loc3_ = new BattlePropItem();
            _loc5_ = param1.item[_loc4_];
            _loc3_.userId = _loc5_.userId;
            _loc3_.battleId = _loc5_.battleId;
            _loc3_.uItemId = _loc5_.uItemId;
            _loc3_.useCount = _loc5_.count;
            _loc3_.tempId = _loc5_.tempId;
            _loc3_.bagPos = _loc5_.bagPos;
            _loc3_.skillTempId = _loc5_.skillTempId;
            _loc3_.sonType = _loc5_.sonType;
            _loc2_.push(_loc3_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function readSimpleAndSnsInfo(param1:FriendItemCellInfo, param2:RelationPlayerMsg) : void
      {
         param1.userId = param2.player.userId;
         param1.nickName = param2.player.nickName;
         param1.templateId = param2.player.job;
         param1.job = param2.player.job;
         param1.sexs = param2.player.sexs;
         param1.pics = param2.player.pics;
         param1.camp = param2.player.camp;
         param1.state = param2.player.state;
         param1.jewelGrades = param2.player.storeGrade;
         param1.consortiaID = param2.player.consortiaID;
         if(param2.player.hasStrategy)
         {
            param1.strategy = Int64Utils.int64ToNumber(param2.player.strategy);
         }
         param1.consortiaName = param2.player.consortiaName;
         param1.consortiaOffer = param2.player.consortiaOffer;
         param1.consortiaTotalOffer = param2.player.consortiaTotalOffer;
         param1.claimId = param2.player.claimId;
         param1.claimName = param2.player.claimName;
         param1.grades = param2.player.grades;
         if(param2.player.hasGp)
         {
            param1.gp = Int64Utils.int64ToNumber(param2.player.gp);
         }
         param1.repute = param2.player.repute;
         if(param2.player.hasLogOutTime)
         {
            param1.logOutTime = DateFormatter.parse(param2.player.logOutTime,"YYYY-MM-DD hh:mm:ss");
         }
         param1.dutyId = param2.player.dutyId;
         param1.parameter1 = param2.player.parameter1;
         param1.playerOrdeInfo.gpOrder = param2.player.gpOrder;
         param1.fightingCapacity = param2.player.fightingCapacity;
         param1.matchWin = param2.player.matchWin;
         param1.matchFailed = param2.player.matchFailed;
         param1.right = param2.player.right;
         param1.relation = param2.relation;
         param1.groupId = param2.groupId;
         param1.type = 0;
         param1.friendGp = param2.friendRp;
         param1.friendGrade = param2.friendGrade;
         param1.vocationGrades = param2.transGrade;
         param1.vocationIndex = param2.changeBranch;
         if(param2.snsInfo)
         {
            if(param2.snsInfo.hasUserId)
            {
               param1.snsInfo.userId = param2.snsInfo.userId;
            }
            if(param2.snsInfo.hasNickname)
            {
               param1.snsInfo.nickName = param2.snsInfo.nickname;
            }
            if(param2.snsInfo.hasHeadId)
            {
               param1.snsInfo.headId = param2.snsInfo.headId;
            }
            if(param2.snsInfo.hasSignDesc)
            {
               param1.snsInfo.sign = param2.snsInfo.signDesc;
            }
            if(param2.snsInfo.hasSex)
            {
               param1.snsInfo.sex = param2.snsInfo.sex;
            }
            if(param2.snsInfo.hasBirthdayType)
            {
               param1.snsInfo.birthdayType = param2.snsInfo.birthdayType;
            }
            if(param2.snsInfo.hasBirthYear)
            {
               param1.snsInfo.birthYear = param2.snsInfo.birthYear;
            }
            if(param2.snsInfo.hasBirthMonth)
            {
               param1.snsInfo.birthMonth = param2.snsInfo.birthMonth;
            }
            if(param2.snsInfo.hasBirthDay)
            {
               param1.snsInfo.birthDay = param2.snsInfo.birthDay;
            }
            if(param2.snsInfo.hasStarId)
            {
               param1.snsInfo.horoscope = param2.snsInfo.starId;
            }
            if(param2.snsInfo.hasBloodType)
            {
               param1.snsInfo.bloodType = param2.snsInfo.bloodType;
            }
            if(param2.snsInfo.hasCountry)
            {
               param1.snsInfo.country = param2.snsInfo.country;
            }
            if(param2.snsInfo.hasProvince)
            {
               param1.snsInfo.province = param2.snsInfo.province;
            }
            if(param2.snsInfo.hasCity)
            {
               param1.snsInfo.city = param2.snsInfo.city;
            }
         }
      }
   }
}

