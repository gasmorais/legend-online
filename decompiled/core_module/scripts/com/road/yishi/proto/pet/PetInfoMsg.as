package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetInfoMsg extends Message implements IExternalizable
   {
      
      private var pet_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var template_id$field:int;
      
      private var pet_name$field:String;
      
      private var cur_gp$field:int;
      
      private var cur_grade$field:int;
      
      private var power$field:int;
      
      private var intel$field:int;
      
      private var physi$field:int;
      
      private var armor$field:int;
      
      private var remainPoints$field:int;
      
      private var initPowerApti$field:int;
      
      private var initIntelApti$field:int;
      
      private var initPhysiApti$field:int;
      
      private var initArmorApti$field:int;
      
      private var powerApti$field:int;
      
      private var intelApti$field:int;
      
      private var physiApti$field:int;
      
      private var armorApti$field:int;
      
      private var curQualityGp$field:int;
      
      private var growthRate$field:int;
      
      private var maxHp$field:int;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var lightResi$field:int;
      
      private var followSkills$field:String;
      
      private var changeSkills$field:String;
      
      private var isFight$field:Boolean;
      
      private var isPractice$field:Boolean;
      
      private var isBind$field:Boolean;
      
      private var total_gp$field:Int64;
      
      private var fightingCapacity$field:int;
      
      private var isDel$field:Boolean;
      
      private var quality$field:int;
      
      private var isGuard$field:Boolean;
      
      private var hasField$1:uint = 0;
      
      private var cha_skill_indexs$field:String;
      
      private var fast_key$field:String;
      
      private var init_quality$field:int;
      
      private var position$field:int;
      
      private var is_locked$field:Boolean;
      
      private var lords_skill_indexs$field:String;
      
      private var monopoly_skill_indexs$field:String;
      
      private var bag_attack$field:int;
      
      private var bag_defence$field:int;
      
      private var bag_magicattack$field:int;
      
      private var bag_magicdefence$field:int;
      
      private var bag_living$field:int;
      
      private var consortia_skill_indexs$field:String;
      
      private var remote_pet_skill_indexs$field:String;
      
      private var remoteHp$field:int;
      
      private var isRemote$field:Boolean;
      
      private var isChildFight$field:int;
      
      private var mate_lords_skill_indexs$field:String;
      
      private var transfer_skill_indexs$field:String;
      
      public function PetInfoMsg()
      {
         super();
      }
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967294;
         pet_id$field = new int();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set petId(param1:int) : void
      {
         hasField$0 |= 1;
         pet_id$field = param1;
      }
      
      public function get petId() : int
      {
         return pet_id$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removePetName() : void
      {
         pet_name$field = null;
      }
      
      public function get hasPetName() : Boolean
      {
         return pet_name$field != null;
      }
      
      public function set petName(param1:String) : void
      {
         pet_name$field = param1;
      }
      
      public function get petName() : String
      {
         return pet_name$field;
      }
      
      public function removeCurGp() : void
      {
         hasField$0 &= 4294967291;
         cur_gp$field = new int();
      }
      
      public function get hasCurGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curGp(param1:int) : void
      {
         hasField$0 |= 4;
         cur_gp$field = param1;
      }
      
      public function get curGp() : int
      {
         return cur_gp$field;
      }
      
      public function removeCurGrade() : void
      {
         hasField$0 &= 4294967287;
         cur_grade$field = new int();
      }
      
      public function get hasCurGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set curGrade(param1:int) : void
      {
         hasField$0 |= 8;
         cur_grade$field = param1;
      }
      
      public function get curGrade() : int
      {
         return cur_grade$field;
      }
      
      public function removePower() : void
      {
         hasField$0 &= 4294967279;
         power$field = new int();
      }
      
      public function get hasPower() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set power(param1:int) : void
      {
         hasField$0 |= 16;
         power$field = param1;
      }
      
      public function get power() : int
      {
         return power$field;
      }
      
      public function removeIntel() : void
      {
         hasField$0 &= 4294967263;
         intel$field = new int();
      }
      
      public function get hasIntel() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set intel(param1:int) : void
      {
         hasField$0 |= 32;
         intel$field = param1;
      }
      
      public function get intel() : int
      {
         return intel$field;
      }
      
      public function removePhysi() : void
      {
         hasField$0 &= 4294967231;
         physi$field = new int();
      }
      
      public function get hasPhysi() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set physi(param1:int) : void
      {
         hasField$0 |= 64;
         physi$field = param1;
      }
      
      public function get physi() : int
      {
         return physi$field;
      }
      
      public function removeArmor() : void
      {
         hasField$0 &= 4294967167;
         armor$field = new int();
      }
      
      public function get hasArmor() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set armor(param1:int) : void
      {
         hasField$0 |= 128;
         armor$field = param1;
      }
      
      public function get armor() : int
      {
         return armor$field;
      }
      
      public function removeRemainPoints() : void
      {
         hasField$0 &= 4294967039;
         remainPoints$field = new int();
      }
      
      public function get hasRemainPoints() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set remainPoints(param1:int) : void
      {
         hasField$0 |= 256;
         remainPoints$field = param1;
      }
      
      public function get remainPoints() : int
      {
         return remainPoints$field;
      }
      
      public function removeInitPowerApti() : void
      {
         hasField$0 &= 4294966783;
         initPowerApti$field = new int();
      }
      
      public function get hasInitPowerApti() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set initPowerApti(param1:int) : void
      {
         hasField$0 |= 512;
         initPowerApti$field = param1;
      }
      
      public function get initPowerApti() : int
      {
         return initPowerApti$field;
      }
      
      public function removeInitIntelApti() : void
      {
         hasField$0 &= 4294966271;
         initIntelApti$field = new int();
      }
      
      public function get hasInitIntelApti() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set initIntelApti(param1:int) : void
      {
         hasField$0 |= 1024;
         initIntelApti$field = param1;
      }
      
      public function get initIntelApti() : int
      {
         return initIntelApti$field;
      }
      
      public function removeInitPhysiApti() : void
      {
         hasField$0 &= 4294965247;
         initPhysiApti$field = new int();
      }
      
      public function get hasInitPhysiApti() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set initPhysiApti(param1:int) : void
      {
         hasField$0 |= 2048;
         initPhysiApti$field = param1;
      }
      
      public function get initPhysiApti() : int
      {
         return initPhysiApti$field;
      }
      
      public function removeInitArmorApti() : void
      {
         hasField$0 &= 4294963199;
         initArmorApti$field = new int();
      }
      
      public function get hasInitArmorApti() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set initArmorApti(param1:int) : void
      {
         hasField$0 |= 4096;
         initArmorApti$field = param1;
      }
      
      public function get initArmorApti() : int
      {
         return initArmorApti$field;
      }
      
      public function removePowerApti() : void
      {
         hasField$0 &= 4294959103;
         powerApti$field = new int();
      }
      
      public function get hasPowerApti() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set powerApti(param1:int) : void
      {
         hasField$0 |= 8192;
         powerApti$field = param1;
      }
      
      public function get powerApti() : int
      {
         return powerApti$field;
      }
      
      public function removeIntelApti() : void
      {
         hasField$0 &= 4294950911;
         intelApti$field = new int();
      }
      
      public function get hasIntelApti() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set intelApti(param1:int) : void
      {
         hasField$0 |= 16384;
         intelApti$field = param1;
      }
      
      public function get intelApti() : int
      {
         return intelApti$field;
      }
      
      public function removePhysiApti() : void
      {
         hasField$0 &= 4294934527;
         physiApti$field = new int();
      }
      
      public function get hasPhysiApti() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set physiApti(param1:int) : void
      {
         hasField$0 |= 32768;
         physiApti$field = param1;
      }
      
      public function get physiApti() : int
      {
         return physiApti$field;
      }
      
      public function removeArmorApti() : void
      {
         hasField$0 &= 4294901759;
         armorApti$field = new int();
      }
      
      public function get hasArmorApti() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set armorApti(param1:int) : void
      {
         hasField$0 |= 65536;
         armorApti$field = param1;
      }
      
      public function get armorApti() : int
      {
         return armorApti$field;
      }
      
      public function removeCurQualityGp() : void
      {
         hasField$0 &= 4294836223;
         curQualityGp$field = new int();
      }
      
      public function get hasCurQualityGp() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set curQualityGp(param1:int) : void
      {
         hasField$0 |= 131072;
         curQualityGp$field = param1;
      }
      
      public function get curQualityGp() : int
      {
         return curQualityGp$field;
      }
      
      public function removeGrowthRate() : void
      {
         hasField$0 &= 4294705151;
         growthRate$field = new int();
      }
      
      public function get hasGrowthRate() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set growthRate(param1:int) : void
      {
         hasField$0 |= 262144;
         growthRate$field = param1;
      }
      
      public function get growthRate() : int
      {
         return growthRate$field;
      }
      
      public function removeMaxHp() : void
      {
         hasField$0 &= 4294443007;
         maxHp$field = new int();
      }
      
      public function get hasMaxHp() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set maxHp(param1:int) : void
      {
         hasField$0 |= 524288;
         maxHp$field = param1;
      }
      
      public function get maxHp() : int
      {
         return maxHp$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$0 &= 4293918719;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$0 |= 1048576;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$0 &= 4292870143;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$0 |= 2097152;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$0 &= 4290772991;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$0 |= 4194304;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$0 &= 4286578687;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$0 |= 8388608;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$0 &= 4278190079;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$0 |= 16777216;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$0 &= 4261412863;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$0 |= 33554432;
         lightResi$field = param1;
      }
      
      public function get lightResi() : int
      {
         return lightResi$field;
      }
      
      public function removeFollowSkills() : void
      {
         followSkills$field = null;
      }
      
      public function get hasFollowSkills() : Boolean
      {
         return followSkills$field != null;
      }
      
      public function set followSkills(param1:String) : void
      {
         followSkills$field = param1;
      }
      
      public function get followSkills() : String
      {
         return followSkills$field;
      }
      
      public function removeChangeSkills() : void
      {
         changeSkills$field = null;
      }
      
      public function get hasChangeSkills() : Boolean
      {
         return changeSkills$field != null;
      }
      
      public function set changeSkills(param1:String) : void
      {
         changeSkills$field = param1;
      }
      
      public function get changeSkills() : String
      {
         return changeSkills$field;
      }
      
      public function removeIsFight() : void
      {
         hasField$0 &= 4227858431;
         isFight$field = new Boolean();
      }
      
      public function get hasIsFight() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         hasField$0 |= 67108864;
         isFight$field = param1;
      }
      
      public function get isFight() : Boolean
      {
         return isFight$field;
      }
      
      public function removeIsPractice() : void
      {
         hasField$0 &= 4160749567;
         isPractice$field = new Boolean();
      }
      
      public function get hasIsPractice() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set isPractice(param1:Boolean) : void
      {
         hasField$0 |= 134217728;
         isPractice$field = param1;
      }
      
      public function get isPractice() : Boolean
      {
         return isPractice$field;
      }
      
      public function removeIsBind() : void
      {
         hasField$0 &= 4026531839;
         isBind$field = new Boolean();
      }
      
      public function get hasIsBind() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set isBind(param1:Boolean) : void
      {
         hasField$0 |= 268435456;
         isBind$field = param1;
      }
      
      public function get isBind() : Boolean
      {
         return isBind$field;
      }
      
      public function removeTotalGp() : void
      {
         total_gp$field = null;
      }
      
      public function get hasTotalGp() : Boolean
      {
         return total_gp$field != null;
      }
      
      public function set totalGp(param1:Int64) : void
      {
         total_gp$field = param1;
      }
      
      public function get totalGp() : Int64
      {
         return total_gp$field;
      }
      
      public function removeFightingCapacity() : void
      {
         hasField$0 &= 3758096383;
         fightingCapacity$field = new int();
      }
      
      public function get hasFightingCapacity() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set fightingCapacity(param1:int) : void
      {
         hasField$0 |= 536870912;
         fightingCapacity$field = param1;
      }
      
      public function get fightingCapacity() : int
      {
         return fightingCapacity$field;
      }
      
      public function removeIsDel() : void
      {
         hasField$0 &= 3221225471;
         isDel$field = new Boolean();
      }
      
      public function get hasIsDel() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set isDel(param1:Boolean) : void
      {
         hasField$0 |= 1073741824;
         isDel$field = param1;
      }
      
      public function get isDel() : Boolean
      {
         return isDel$field;
      }
      
      public function removeQuality() : void
      {
         hasField$0 &= 2147483647;
         quality$field = new int();
      }
      
      public function get hasQuality() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set quality(param1:int) : void
      {
         hasField$0 |= 2147483648;
         quality$field = param1;
      }
      
      public function get quality() : int
      {
         return quality$field;
      }
      
      public function removeIsGuard() : void
      {
         hasField$1 &= 4294967294;
         isGuard$field = new Boolean();
      }
      
      public function get hasIsGuard() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set isGuard(param1:Boolean) : void
      {
         hasField$1 |= 1;
         isGuard$field = param1;
      }
      
      public function get isGuard() : Boolean
      {
         return isGuard$field;
      }
      
      public function removeChaSkillIndexs() : void
      {
         cha_skill_indexs$field = null;
      }
      
      public function get hasChaSkillIndexs() : Boolean
      {
         return cha_skill_indexs$field != null;
      }
      
      public function set chaSkillIndexs(param1:String) : void
      {
         cha_skill_indexs$field = param1;
      }
      
      public function get chaSkillIndexs() : String
      {
         return cha_skill_indexs$field;
      }
      
      public function removeFastKey() : void
      {
         fast_key$field = null;
      }
      
      public function get hasFastKey() : Boolean
      {
         return fast_key$field != null;
      }
      
      public function set fastKey(param1:String) : void
      {
         fast_key$field = param1;
      }
      
      public function get fastKey() : String
      {
         return fast_key$field;
      }
      
      public function removeInitQuality() : void
      {
         hasField$1 &= 4294967293;
         init_quality$field = new int();
      }
      
      public function get hasInitQuality() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set initQuality(param1:int) : void
      {
         hasField$1 |= 2;
         init_quality$field = param1;
      }
      
      public function get initQuality() : int
      {
         return init_quality$field;
      }
      
      public function removePosition() : void
      {
         hasField$1 &= 4294967291;
         position$field = new int();
      }
      
      public function get hasPosition() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set position(param1:int) : void
      {
         hasField$1 |= 4;
         position$field = param1;
      }
      
      public function get position() : int
      {
         return position$field;
      }
      
      public function removeIsLocked() : void
      {
         hasField$1 &= 4294967287;
         is_locked$field = new Boolean();
      }
      
      public function get hasIsLocked() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         hasField$1 |= 8;
         is_locked$field = param1;
      }
      
      public function get isLocked() : Boolean
      {
         return is_locked$field;
      }
      
      public function removeLordsSkillIndexs() : void
      {
         lords_skill_indexs$field = null;
      }
      
      public function get hasLordsSkillIndexs() : Boolean
      {
         return lords_skill_indexs$field != null;
      }
      
      public function set lordsSkillIndexs(param1:String) : void
      {
         lords_skill_indexs$field = param1;
      }
      
      public function get lordsSkillIndexs() : String
      {
         return lords_skill_indexs$field;
      }
      
      public function removeMonopolySkillIndexs() : void
      {
         monopoly_skill_indexs$field = null;
      }
      
      public function get hasMonopolySkillIndexs() : Boolean
      {
         return monopoly_skill_indexs$field != null;
      }
      
      public function set monopolySkillIndexs(param1:String) : void
      {
         monopoly_skill_indexs$field = param1;
      }
      
      public function get monopolySkillIndexs() : String
      {
         return monopoly_skill_indexs$field;
      }
      
      public function removeBagAttack() : void
      {
         hasField$1 &= 4294967279;
         bag_attack$field = new int();
      }
      
      public function get hasBagAttack() : Boolean
      {
         return (hasField$1 & 0x10) != 0;
      }
      
      public function set bagAttack(param1:int) : void
      {
         hasField$1 |= 16;
         bag_attack$field = param1;
      }
      
      public function get bagAttack() : int
      {
         return bag_attack$field;
      }
      
      public function removeBagDefence() : void
      {
         hasField$1 &= 4294967263;
         bag_defence$field = new int();
      }
      
      public function get hasBagDefence() : Boolean
      {
         return (hasField$1 & 0x20) != 0;
      }
      
      public function set bagDefence(param1:int) : void
      {
         hasField$1 |= 32;
         bag_defence$field = param1;
      }
      
      public function get bagDefence() : int
      {
         return bag_defence$field;
      }
      
      public function removeBagMagicattack() : void
      {
         hasField$1 &= 4294967231;
         bag_magicattack$field = new int();
      }
      
      public function get hasBagMagicattack() : Boolean
      {
         return (hasField$1 & 0x40) != 0;
      }
      
      public function set bagMagicattack(param1:int) : void
      {
         hasField$1 |= 64;
         bag_magicattack$field = param1;
      }
      
      public function get bagMagicattack() : int
      {
         return bag_magicattack$field;
      }
      
      public function removeBagMagicdefence() : void
      {
         hasField$1 &= 4294967167;
         bag_magicdefence$field = new int();
      }
      
      public function get hasBagMagicdefence() : Boolean
      {
         return (hasField$1 & 0x80) != 0;
      }
      
      public function set bagMagicdefence(param1:int) : void
      {
         hasField$1 |= 128;
         bag_magicdefence$field = param1;
      }
      
      public function get bagMagicdefence() : int
      {
         return bag_magicdefence$field;
      }
      
      public function removeBagLiving() : void
      {
         hasField$1 &= 4294967039;
         bag_living$field = new int();
      }
      
      public function get hasBagLiving() : Boolean
      {
         return (hasField$1 & 0x0100) != 0;
      }
      
      public function set bagLiving(param1:int) : void
      {
         hasField$1 |= 256;
         bag_living$field = param1;
      }
      
      public function get bagLiving() : int
      {
         return bag_living$field;
      }
      
      public function removeConsortiaSkillIndexs() : void
      {
         consortia_skill_indexs$field = null;
      }
      
      public function get hasConsortiaSkillIndexs() : Boolean
      {
         return consortia_skill_indexs$field != null;
      }
      
      public function set consortiaSkillIndexs(param1:String) : void
      {
         consortia_skill_indexs$field = param1;
      }
      
      public function get consortiaSkillIndexs() : String
      {
         return consortia_skill_indexs$field;
      }
      
      public function removeRemotePetSkillIndexs() : void
      {
         remote_pet_skill_indexs$field = null;
      }
      
      public function get hasRemotePetSkillIndexs() : Boolean
      {
         return remote_pet_skill_indexs$field != null;
      }
      
      public function set remotePetSkillIndexs(param1:String) : void
      {
         remote_pet_skill_indexs$field = param1;
      }
      
      public function get remotePetSkillIndexs() : String
      {
         return remote_pet_skill_indexs$field;
      }
      
      public function removeRemoteHp() : void
      {
         hasField$1 &= 4294966783;
         remoteHp$field = new int();
      }
      
      public function get hasRemoteHp() : Boolean
      {
         return (hasField$1 & 0x0200) != 0;
      }
      
      public function set remoteHp(param1:int) : void
      {
         hasField$1 |= 512;
         remoteHp$field = param1;
      }
      
      public function get remoteHp() : int
      {
         return remoteHp$field;
      }
      
      public function removeIsRemote() : void
      {
         hasField$1 &= 4294966271;
         isRemote$field = new Boolean();
      }
      
      public function get hasIsRemote() : Boolean
      {
         return (hasField$1 & 0x0400) != 0;
      }
      
      public function set isRemote(param1:Boolean) : void
      {
         hasField$1 |= 1024;
         isRemote$field = param1;
      }
      
      public function get isRemote() : Boolean
      {
         return isRemote$field;
      }
      
      public function removeIsChildFight() : void
      {
         hasField$1 &= 4294965247;
         isChildFight$field = new int();
      }
      
      public function get hasIsChildFight() : Boolean
      {
         return (hasField$1 & 0x0800) != 0;
      }
      
      public function set isChildFight(param1:int) : void
      {
         hasField$1 |= 2048;
         isChildFight$field = param1;
      }
      
      public function get isChildFight() : int
      {
         return isChildFight$field;
      }
      
      public function removeMateLordsSkillIndexs() : void
      {
         mate_lords_skill_indexs$field = null;
      }
      
      public function get hasMateLordsSkillIndexs() : Boolean
      {
         return mate_lords_skill_indexs$field != null;
      }
      
      public function set mateLordsSkillIndexs(param1:String) : void
      {
         mate_lords_skill_indexs$field = param1;
      }
      
      public function get mateLordsSkillIndexs() : String
      {
         return mate_lords_skill_indexs$field;
      }
      
      public function removeTransferSkillIndexs() : void
      {
         transfer_skill_indexs$field = null;
      }
      
      public function get hasTransferSkillIndexs() : Boolean
      {
         return transfer_skill_indexs$field != null;
      }
      
      public function set transferSkillIndexs(param1:String) : void
      {
         transfer_skill_indexs$field = param1;
      }
      
      public function get transferSkillIndexs() : String
      {
         return transfer_skill_indexs$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pet_id$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasPetName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,pet_name$field);
         }
         if(hasCurGp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cur_gp$field);
         }
         if(hasCurGrade)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,cur_grade$field);
         }
         if(hasPower)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,power$field);
         }
         if(hasIntel)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,intel$field);
         }
         if(hasPhysi)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,physi$field);
         }
         if(hasArmor)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,armor$field);
         }
         if(hasRemainPoints)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,remainPoints$field);
         }
         if(hasInitPowerApti)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,initPowerApti$field);
         }
         if(hasInitIntelApti)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,initIntelApti$field);
         }
         if(hasInitPhysiApti)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,initPhysiApti$field);
         }
         if(hasInitArmorApti)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,initArmorApti$field);
         }
         if(hasPowerApti)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,powerApti$field);
         }
         if(hasIntelApti)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,intelApti$field);
         }
         if(hasPhysiApti)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,physiApti$field);
         }
         if(hasArmorApti)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,armorApti$field);
         }
         if(hasCurQualityGp)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,curQualityGp$field);
         }
         if(hasGrowthRate)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,growthRate$field);
         }
         if(hasMaxHp)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,maxHp$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
         if(hasFollowSkills)
         {
            WriteUtils.writeTag(param1,2,28);
            WriteUtils.write$TYPE_STRING(param1,followSkills$field);
         }
         if(hasChangeSkills)
         {
            WriteUtils.writeTag(param1,2,29);
            WriteUtils.write$TYPE_STRING(param1,changeSkills$field);
         }
         if(hasIsFight)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_BOOL(param1,isFight$field);
         }
         if(hasIsPractice)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_BOOL(param1,isPractice$field);
         }
         if(hasIsBind)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_BOOL(param1,isBind$field);
         }
         if(hasTotalGp)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_INT64(param1,total_gp$field);
         }
         if(hasFightingCapacity)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_INT32(param1,fightingCapacity$field);
         }
         if(hasIsDel)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_BOOL(param1,isDel$field);
         }
         if(hasQuality)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,quality$field);
         }
         if(hasIsGuard)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_BOOL(param1,isGuard$field);
         }
         if(hasChaSkillIndexs)
         {
            WriteUtils.writeTag(param1,2,38);
            WriteUtils.write$TYPE_STRING(param1,cha_skill_indexs$field);
         }
         if(hasFastKey)
         {
            WriteUtils.writeTag(param1,2,39);
            WriteUtils.write$TYPE_STRING(param1,fast_key$field);
         }
         if(hasInitQuality)
         {
            WriteUtils.writeTag(param1,0,40);
            WriteUtils.write$TYPE_INT32(param1,init_quality$field);
         }
         if(hasPosition)
         {
            WriteUtils.writeTag(param1,0,41);
            WriteUtils.write$TYPE_INT32(param1,position$field);
         }
         if(hasIsLocked)
         {
            WriteUtils.writeTag(param1,0,42);
            WriteUtils.write$TYPE_BOOL(param1,is_locked$field);
         }
         if(hasLordsSkillIndexs)
         {
            WriteUtils.writeTag(param1,2,43);
            WriteUtils.write$TYPE_STRING(param1,lords_skill_indexs$field);
         }
         if(hasMonopolySkillIndexs)
         {
            WriteUtils.writeTag(param1,2,45);
            WriteUtils.write$TYPE_STRING(param1,monopoly_skill_indexs$field);
         }
         if(hasBagAttack)
         {
            WriteUtils.writeTag(param1,0,46);
            WriteUtils.write$TYPE_INT32(param1,bag_attack$field);
         }
         if(hasBagDefence)
         {
            WriteUtils.writeTag(param1,0,47);
            WriteUtils.write$TYPE_INT32(param1,bag_defence$field);
         }
         if(hasBagMagicattack)
         {
            WriteUtils.writeTag(param1,0,48);
            WriteUtils.write$TYPE_INT32(param1,bag_magicattack$field);
         }
         if(hasBagMagicdefence)
         {
            WriteUtils.writeTag(param1,0,49);
            WriteUtils.write$TYPE_INT32(param1,bag_magicdefence$field);
         }
         if(hasBagLiving)
         {
            WriteUtils.writeTag(param1,0,50);
            WriteUtils.write$TYPE_INT32(param1,bag_living$field);
         }
         if(hasConsortiaSkillIndexs)
         {
            WriteUtils.writeTag(param1,2,51);
            WriteUtils.write$TYPE_STRING(param1,consortia_skill_indexs$field);
         }
         if(hasRemotePetSkillIndexs)
         {
            WriteUtils.writeTag(param1,2,52);
            WriteUtils.write$TYPE_STRING(param1,remote_pet_skill_indexs$field);
         }
         if(hasRemoteHp)
         {
            WriteUtils.writeTag(param1,0,53);
            WriteUtils.write$TYPE_INT32(param1,remoteHp$field);
         }
         if(hasIsRemote)
         {
            WriteUtils.writeTag(param1,0,54);
            WriteUtils.write$TYPE_BOOL(param1,isRemote$field);
         }
         if(hasIsChildFight)
         {
            WriteUtils.writeTag(param1,0,55);
            WriteUtils.write$TYPE_INT32(param1,isChildFight$field);
         }
         if(hasMateLordsSkillIndexs)
         {
            WriteUtils.writeTag(param1,2,56);
            WriteUtils.write$TYPE_STRING(param1,mate_lords_skill_indexs$field);
         }
         if(hasTransferSkillIndexs)
         {
            WriteUtils.writeTag(param1,2,57);
            WriteUtils.write$TYPE_STRING(param1,transfer_skill_indexs$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc22_:* = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc31_:uint = 0;
         var _loc28_:uint = 0;
         var _loc43_:uint = 0;
         var _loc30_:uint = 0;
         var _loc9_:uint = 0;
         var _loc40_:uint = 0;
         var _loc36_:uint = 0;
         var _loc27_:uint = 0;
         var _loc11_:uint = 0;
         var _loc20_:uint = 0;
         var _loc6_:uint = 0;
         var _loc47_:uint = 0;
         var _loc38_:uint = 0;
         var _loc34_:uint = 0;
         var _loc21_:uint = 0;
         var _loc51_:uint = 0;
         var _loc54_:uint = 0;
         var _loc37_:uint = 0;
         var _loc33_:uint = 0;
         var _loc24_:uint = 0;
         var _loc14_:uint = 0;
         var _loc45_:uint = 0;
         var _loc49_:uint = 0;
         var _loc55_:uint = 0;
         var _loc12_:uint = 0;
         var _loc41_:uint = 0;
         var _loc10_:uint = 0;
         var _loc16_:uint = 0;
         var _loc32_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc44_:uint = 0;
         var _loc53_:uint = 0;
         var _loc35_:uint = 0;
         var _loc29_:uint = 0;
         var _loc46_:uint = 0;
         var _loc17_:uint = 0;
         var _loc39_:uint = 0;
         var _loc52_:uint = 0;
         var _loc48_:uint = 0;
         var _loc59_:uint = 0;
         var _loc56_:uint = 0;
         var _loc42_:uint = 0;
         var _loc13_:uint = 0;
         var _loc50_:uint = 0;
         var _loc57_:uint = 0;
         var _loc25_:uint = 0;
         var _loc26_:uint = 0;
         var _loc58_:uint = 0;
         var _loc23_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc22_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.petId cannot be set twice.");
                  }
                  _loc18_++;
                  petId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.templateId cannot be set twice.");
                  }
                  _loc19_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.petName cannot be set twice.");
                  }
                  _loc7_++;
                  petName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.curGp cannot be set twice.");
                  }
                  _loc8_++;
                  curGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.curGrade cannot be set twice.");
                  }
                  _loc3_++;
                  curGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.power cannot be set twice.");
                  }
                  _loc15_++;
                  power = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.intel cannot be set twice.");
                  }
                  _loc31_++;
                  intel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.physi cannot be set twice.");
                  }
                  _loc28_++;
                  physi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc43_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.armor cannot be set twice.");
                  }
                  _loc43_++;
                  armor = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.remainPoints cannot be set twice.");
                  }
                  _loc30_++;
                  remainPoints = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.initPowerApti cannot be set twice.");
                  }
                  _loc9_++;
                  initPowerApti = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.initIntelApti cannot be set twice.");
                  }
                  _loc40_++;
                  initIntelApti = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.initPhysiApti cannot be set twice.");
                  }
                  _loc36_++;
                  initPhysiApti = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.initArmorApti cannot be set twice.");
                  }
                  _loc27_++;
                  initArmorApti = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.powerApti cannot be set twice.");
                  }
                  _loc11_++;
                  powerApti = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.intelApti cannot be set twice.");
                  }
                  _loc20_++;
                  intelApti = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.physiApti cannot be set twice.");
                  }
                  _loc6_++;
                  physiApti = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc47_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.armorApti cannot be set twice.");
                  }
                  _loc47_++;
                  armorApti = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.curQualityGp cannot be set twice.");
                  }
                  _loc38_++;
                  curQualityGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.growthRate cannot be set twice.");
                  }
                  _loc34_++;
                  growthRate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.maxHp cannot be set twice.");
                  }
                  _loc21_++;
                  maxHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc51_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.fireResi cannot be set twice.");
                  }
                  _loc51_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc54_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.waterResi cannot be set twice.");
                  }
                  _loc54_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.electResi cannot be set twice.");
                  }
                  _loc37_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.windResi cannot be set twice.");
                  }
                  _loc33_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.darkResi cannot be set twice.");
                  }
                  _loc24_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.lightResi cannot be set twice.");
                  }
                  _loc14_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.followSkills cannot be set twice.");
                  }
                  _loc45_++;
                  followSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 29:
                  if(_loc49_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.changeSkills cannot be set twice.");
                  }
                  _loc49_++;
                  changeSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 30:
                  if(_loc55_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.isFight cannot be set twice.");
                  }
                  _loc55_++;
                  isFight = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 31:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.isPractice cannot be set twice.");
                  }
                  _loc12_++;
                  isPractice = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 32:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.isBind cannot be set twice.");
                  }
                  _loc41_++;
                  isBind = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 33:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.totalGp cannot be set twice.");
                  }
                  _loc10_++;
                  totalGp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 34:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.fightingCapacity cannot be set twice.");
                  }
                  _loc16_++;
                  fightingCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 35:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.isDel cannot be set twice.");
                  }
                  _loc32_++;
                  isDel = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 36:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.quality cannot be set twice.");
                  }
                  _loc4_++;
                  quality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 37:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.isGuard cannot be set twice.");
                  }
                  _loc5_++;
                  isGuard = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 38:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.chaSkillIndexs cannot be set twice.");
                  }
                  _loc44_++;
                  chaSkillIndexs = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 39:
                  if(_loc53_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.fastKey cannot be set twice.");
                  }
                  _loc53_++;
                  fastKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 40:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.initQuality cannot be set twice.");
                  }
                  _loc35_++;
                  initQuality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 41:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.position cannot be set twice.");
                  }
                  _loc29_++;
                  position = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 42:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.isLocked cannot be set twice.");
                  }
                  _loc46_++;
                  isLocked = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 43:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.lordsSkillIndexs cannot be set twice.");
                  }
                  _loc17_++;
                  lordsSkillIndexs = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 45:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.monopolySkillIndexs cannot be set twice.");
                  }
                  _loc39_++;
                  monopolySkillIndexs = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 46:
                  if(_loc52_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.bagAttack cannot be set twice.");
                  }
                  _loc52_++;
                  bagAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 47:
                  if(_loc48_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.bagDefence cannot be set twice.");
                  }
                  _loc48_++;
                  bagDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 48:
                  if(_loc59_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.bagMagicattack cannot be set twice.");
                  }
                  _loc59_++;
                  bagMagicattack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 49:
                  if(_loc56_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.bagMagicdefence cannot be set twice.");
                  }
                  _loc56_++;
                  bagMagicdefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 50:
                  if(_loc42_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.bagLiving cannot be set twice.");
                  }
                  _loc42_++;
                  bagLiving = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 51:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.consortiaSkillIndexs cannot be set twice.");
                  }
                  _loc13_++;
                  consortiaSkillIndexs = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 52:
                  if(_loc50_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.remotePetSkillIndexs cannot be set twice.");
                  }
                  _loc50_++;
                  remotePetSkillIndexs = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 53:
                  if(_loc57_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.remoteHp cannot be set twice.");
                  }
                  _loc57_++;
                  remoteHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 54:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.isRemote cannot be set twice.");
                  }
                  _loc25_++;
                  isRemote = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 55:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.isChildFight cannot be set twice.");
                  }
                  _loc26_++;
                  isChildFight = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 56:
                  if(_loc58_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.mateLordsSkillIndexs cannot be set twice.");
                  }
                  _loc58_++;
                  mateLordsSkillIndexs = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 57:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: PetInfoMsg.transferSkillIndexs cannot be set twice.");
                  }
                  _loc23_++;
                  transferSkillIndexs = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc22_ & 7);
            }
         }
      }
   }
}

