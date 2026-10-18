package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimpleHeroInfoMsg extends Message implements IExternalizable
   {
      
      private var hero_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var tempate_id$field:int;
      
      private var player_id$field:int;
      
      private var remain_point$field:int;
      
      private var skill_point$field:int;
      
      private var skill_script$field:String;
      
      private var fast_key$field:String;
      
      private var hp$field:int;
      
      private var blood$field:int;
      
      private var blood_id$field:int;
      
      private var total_power$field:int;
      
      private var total_agility$field:int;
      
      private var total_intellect$field:int;
      
      private var total_captain$field:int;
      
      private var total_physique$field:int;
      
      private var total_phy_attack$field:int;
      
      private var total_phy_defence$field:int;
      
      private var total_magic_attack$field:int;
      
      private var total_magic_defence$field:int;
      
      private var total_force_hit$field:int;
      
      private var total_parry$field:int;
      
      private var total_conat_army$field:int;
      
      private var total_live$field:int;
      
      private var base_power$field:int;
      
      private var base_agility$field:int;
      
      private var base_intellect$field:int;
      
      private var base_captain$field:int;
      
      private var base_physique$field:int;
      
      private var base_phy_attack$field:int;
      
      private var base_phy_defence$field:int;
      
      private var base_magic_attack$field:int;
      
      private var base_magic_defence$field:int;
      
      private var base_force_hit$field:int;
      
      private var base_parry$field:int;
      
      private var base_conat_army$field:int;
      
      private var hasField$1:uint = 0;
      
      private var base_live$field:int;
      
      private var power_point$field:int;
      
      private var agility_point$field:int;
      
      private var intellect_point$field:int;
      
      private var captain_point$field:int;
      
      private var physique_point$field:int;
      
      private var fight_pos$field:int;
      
      private var skill_index$field:int;
      
      private var is_activeSecond$field:Boolean;
      
      private var head_id$field:int;
      
      private var talent_point$field:int;
      
      private var talent_grade$field:int;
      
      private var talent_skill$field:String;
      
      private var grade$field:int;
      
      private var arm$field:String;
      
      private var cloth$field:String;
      
      private var wing$field:String;
      
      private var fighting_capacity$field:int;
      
      private var server_name$field:String;
      
      private var hat$field:String;
      
      private var fashion_arm$field:String;
      
      private var fashion_cloth$field:String;
      
      private var hide$field:Boolean;
      
      private var rune$field:HeroRuneMsg;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var lightResi$field:int;
      
      private var reduce_resi$field:int;
      
      private var total_strength$field:int;
      
      private var base_strength$field:int;
      
      private var total_tenacity$field:int;
      
      private var base_tenacity$field:int;
      
      private var total_penetrate$field:int;
      
      private var base_penetrate$field:int;
      
      private var advanced_talent_point$field:int;
      
      private var advanced_talent_grade$field:int;
      
      private var advanced_talent_skill$field:String;
      
      private var total_stunAttr$field:int;
      
      private var base_stunAttr$field:int;
      
      private var hasField$2:uint = 0;
      
      private var total_reduce_resi_against$field:int;
      
      private var reduce_resi_against$field:int;
      
      private var total_resi_penetrate$field:int;
      
      private var resi_penetrate$field:int;
      
      public function SimpleHeroInfoMsg()
      {
         super();
      }
      
      public function removeHeroId() : void
      {
         hasField$0 &= 4294967294;
         hero_id$field = new int();
      }
      
      public function get hasHeroId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set heroId(param1:int) : void
      {
         hasField$0 |= 1;
         hero_id$field = param1;
      }
      
      public function get heroId() : int
      {
         return hero_id$field;
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeTempateId() : void
      {
         hasField$0 &= 4294967293;
         tempate_id$field = new int();
      }
      
      public function get hasTempateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tempateId(param1:int) : void
      {
         hasField$0 |= 2;
         tempate_id$field = param1;
      }
      
      public function get tempateId() : int
      {
         return tempate_id$field;
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967291;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 4;
         player_id$field = param1;
      }
      
      public function get playerId() : int
      {
         return player_id$field;
      }
      
      public function removeRemainPoint() : void
      {
         hasField$0 &= 4294967287;
         remain_point$field = new int();
      }
      
      public function get hasRemainPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set remainPoint(param1:int) : void
      {
         hasField$0 |= 8;
         remain_point$field = param1;
      }
      
      public function get remainPoint() : int
      {
         return remain_point$field;
      }
      
      public function removeSkillPoint() : void
      {
         hasField$0 &= 4294967279;
         skill_point$field = new int();
      }
      
      public function get hasSkillPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set skillPoint(param1:int) : void
      {
         hasField$0 |= 16;
         skill_point$field = param1;
      }
      
      public function get skillPoint() : int
      {
         return skill_point$field;
      }
      
      public function removeSkillScript() : void
      {
         skill_script$field = null;
      }
      
      public function get hasSkillScript() : Boolean
      {
         return skill_script$field != null;
      }
      
      public function set skillScript(param1:String) : void
      {
         skill_script$field = param1;
      }
      
      public function get skillScript() : String
      {
         return skill_script$field;
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
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967263;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 32;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      public function removeBlood() : void
      {
         hasField$0 &= 4294967231;
         blood$field = new int();
      }
      
      public function get hasBlood() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set blood(param1:int) : void
      {
         hasField$0 |= 64;
         blood$field = param1;
      }
      
      public function get blood() : int
      {
         return blood$field;
      }
      
      public function removeBloodId() : void
      {
         hasField$0 &= 4294967167;
         blood_id$field = new int();
      }
      
      public function get hasBloodId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set bloodId(param1:int) : void
      {
         hasField$0 |= 128;
         blood_id$field = param1;
      }
      
      public function get bloodId() : int
      {
         return blood_id$field;
      }
      
      public function removeTotalPower() : void
      {
         hasField$0 &= 4294967039;
         total_power$field = new int();
      }
      
      public function get hasTotalPower() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set totalPower(param1:int) : void
      {
         hasField$0 |= 256;
         total_power$field = param1;
      }
      
      public function get totalPower() : int
      {
         return total_power$field;
      }
      
      public function removeTotalAgility() : void
      {
         hasField$0 &= 4294966783;
         total_agility$field = new int();
      }
      
      public function get hasTotalAgility() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set totalAgility(param1:int) : void
      {
         hasField$0 |= 512;
         total_agility$field = param1;
      }
      
      public function get totalAgility() : int
      {
         return total_agility$field;
      }
      
      public function removeTotalIntellect() : void
      {
         hasField$0 &= 4294966271;
         total_intellect$field = new int();
      }
      
      public function get hasTotalIntellect() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set totalIntellect(param1:int) : void
      {
         hasField$0 |= 1024;
         total_intellect$field = param1;
      }
      
      public function get totalIntellect() : int
      {
         return total_intellect$field;
      }
      
      public function removeTotalCaptain() : void
      {
         hasField$0 &= 4294965247;
         total_captain$field = new int();
      }
      
      public function get hasTotalCaptain() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set totalCaptain(param1:int) : void
      {
         hasField$0 |= 2048;
         total_captain$field = param1;
      }
      
      public function get totalCaptain() : int
      {
         return total_captain$field;
      }
      
      public function removeTotalPhysique() : void
      {
         hasField$0 &= 4294963199;
         total_physique$field = new int();
      }
      
      public function get hasTotalPhysique() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set totalPhysique(param1:int) : void
      {
         hasField$0 |= 4096;
         total_physique$field = param1;
      }
      
      public function get totalPhysique() : int
      {
         return total_physique$field;
      }
      
      public function removeTotalPhyAttack() : void
      {
         hasField$0 &= 4294959103;
         total_phy_attack$field = new int();
      }
      
      public function get hasTotalPhyAttack() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set totalPhyAttack(param1:int) : void
      {
         hasField$0 |= 8192;
         total_phy_attack$field = param1;
      }
      
      public function get totalPhyAttack() : int
      {
         return total_phy_attack$field;
      }
      
      public function removeTotalPhyDefence() : void
      {
         hasField$0 &= 4294950911;
         total_phy_defence$field = new int();
      }
      
      public function get hasTotalPhyDefence() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set totalPhyDefence(param1:int) : void
      {
         hasField$0 |= 16384;
         total_phy_defence$field = param1;
      }
      
      public function get totalPhyDefence() : int
      {
         return total_phy_defence$field;
      }
      
      public function removeTotalMagicAttack() : void
      {
         hasField$0 &= 4294934527;
         total_magic_attack$field = new int();
      }
      
      public function get hasTotalMagicAttack() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set totalMagicAttack(param1:int) : void
      {
         hasField$0 |= 32768;
         total_magic_attack$field = param1;
      }
      
      public function get totalMagicAttack() : int
      {
         return total_magic_attack$field;
      }
      
      public function removeTotalMagicDefence() : void
      {
         hasField$0 &= 4294901759;
         total_magic_defence$field = new int();
      }
      
      public function get hasTotalMagicDefence() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set totalMagicDefence(param1:int) : void
      {
         hasField$0 |= 65536;
         total_magic_defence$field = param1;
      }
      
      public function get totalMagicDefence() : int
      {
         return total_magic_defence$field;
      }
      
      public function removeTotalForceHit() : void
      {
         hasField$0 &= 4294836223;
         total_force_hit$field = new int();
      }
      
      public function get hasTotalForceHit() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set totalForceHit(param1:int) : void
      {
         hasField$0 |= 131072;
         total_force_hit$field = param1;
      }
      
      public function get totalForceHit() : int
      {
         return total_force_hit$field;
      }
      
      public function removeTotalParry() : void
      {
         hasField$0 &= 4294705151;
         total_parry$field = new int();
      }
      
      public function get hasTotalParry() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set totalParry(param1:int) : void
      {
         hasField$0 |= 262144;
         total_parry$field = param1;
      }
      
      public function get totalParry() : int
      {
         return total_parry$field;
      }
      
      public function removeTotalConatArmy() : void
      {
         hasField$0 &= 4294443007;
         total_conat_army$field = new int();
      }
      
      public function get hasTotalConatArmy() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set totalConatArmy(param1:int) : void
      {
         hasField$0 |= 524288;
         total_conat_army$field = param1;
      }
      
      public function get totalConatArmy() : int
      {
         return total_conat_army$field;
      }
      
      public function removeTotalLive() : void
      {
         hasField$0 &= 4293918719;
         total_live$field = new int();
      }
      
      public function get hasTotalLive() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set totalLive(param1:int) : void
      {
         hasField$0 |= 1048576;
         total_live$field = param1;
      }
      
      public function get totalLive() : int
      {
         return total_live$field;
      }
      
      public function removeBasePower() : void
      {
         hasField$0 &= 4292870143;
         base_power$field = new int();
      }
      
      public function get hasBasePower() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set basePower(param1:int) : void
      {
         hasField$0 |= 2097152;
         base_power$field = param1;
      }
      
      public function get basePower() : int
      {
         return base_power$field;
      }
      
      public function removeBaseAgility() : void
      {
         hasField$0 &= 4290772991;
         base_agility$field = new int();
      }
      
      public function get hasBaseAgility() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set baseAgility(param1:int) : void
      {
         hasField$0 |= 4194304;
         base_agility$field = param1;
      }
      
      public function get baseAgility() : int
      {
         return base_agility$field;
      }
      
      public function removeBaseIntellect() : void
      {
         hasField$0 &= 4286578687;
         base_intellect$field = new int();
      }
      
      public function get hasBaseIntellect() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set baseIntellect(param1:int) : void
      {
         hasField$0 |= 8388608;
         base_intellect$field = param1;
      }
      
      public function get baseIntellect() : int
      {
         return base_intellect$field;
      }
      
      public function removeBaseCaptain() : void
      {
         hasField$0 &= 4278190079;
         base_captain$field = new int();
      }
      
      public function get hasBaseCaptain() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set baseCaptain(param1:int) : void
      {
         hasField$0 |= 16777216;
         base_captain$field = param1;
      }
      
      public function get baseCaptain() : int
      {
         return base_captain$field;
      }
      
      public function removeBasePhysique() : void
      {
         hasField$0 &= 4261412863;
         base_physique$field = new int();
      }
      
      public function get hasBasePhysique() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set basePhysique(param1:int) : void
      {
         hasField$0 |= 33554432;
         base_physique$field = param1;
      }
      
      public function get basePhysique() : int
      {
         return base_physique$field;
      }
      
      public function removeBasePhyAttack() : void
      {
         hasField$0 &= 4227858431;
         base_phy_attack$field = new int();
      }
      
      public function get hasBasePhyAttack() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set basePhyAttack(param1:int) : void
      {
         hasField$0 |= 67108864;
         base_phy_attack$field = param1;
      }
      
      public function get basePhyAttack() : int
      {
         return base_phy_attack$field;
      }
      
      public function removeBasePhyDefence() : void
      {
         hasField$0 &= 4160749567;
         base_phy_defence$field = new int();
      }
      
      public function get hasBasePhyDefence() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set basePhyDefence(param1:int) : void
      {
         hasField$0 |= 134217728;
         base_phy_defence$field = param1;
      }
      
      public function get basePhyDefence() : int
      {
         return base_phy_defence$field;
      }
      
      public function removeBaseMagicAttack() : void
      {
         hasField$0 &= 4026531839;
         base_magic_attack$field = new int();
      }
      
      public function get hasBaseMagicAttack() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set baseMagicAttack(param1:int) : void
      {
         hasField$0 |= 268435456;
         base_magic_attack$field = param1;
      }
      
      public function get baseMagicAttack() : int
      {
         return base_magic_attack$field;
      }
      
      public function removeBaseMagicDefence() : void
      {
         hasField$0 &= 3758096383;
         base_magic_defence$field = new int();
      }
      
      public function get hasBaseMagicDefence() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set baseMagicDefence(param1:int) : void
      {
         hasField$0 |= 536870912;
         base_magic_defence$field = param1;
      }
      
      public function get baseMagicDefence() : int
      {
         return base_magic_defence$field;
      }
      
      public function removeBaseForceHit() : void
      {
         hasField$0 &= 3221225471;
         base_force_hit$field = new int();
      }
      
      public function get hasBaseForceHit() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set baseForceHit(param1:int) : void
      {
         hasField$0 |= 1073741824;
         base_force_hit$field = param1;
      }
      
      public function get baseForceHit() : int
      {
         return base_force_hit$field;
      }
      
      public function removeBaseParry() : void
      {
         hasField$0 &= 2147483647;
         base_parry$field = new int();
      }
      
      public function get hasBaseParry() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set baseParry(param1:int) : void
      {
         hasField$0 |= 2147483648;
         base_parry$field = param1;
      }
      
      public function get baseParry() : int
      {
         return base_parry$field;
      }
      
      public function removeBaseConatArmy() : void
      {
         hasField$1 &= 4294967294;
         base_conat_army$field = new int();
      }
      
      public function get hasBaseConatArmy() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set baseConatArmy(param1:int) : void
      {
         hasField$1 |= 1;
         base_conat_army$field = param1;
      }
      
      public function get baseConatArmy() : int
      {
         return base_conat_army$field;
      }
      
      public function removeBaseLive() : void
      {
         hasField$1 &= 4294967293;
         base_live$field = new int();
      }
      
      public function get hasBaseLive() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set baseLive(param1:int) : void
      {
         hasField$1 |= 2;
         base_live$field = param1;
      }
      
      public function get baseLive() : int
      {
         return base_live$field;
      }
      
      public function removePowerPoint() : void
      {
         hasField$1 &= 4294967291;
         power_point$field = new int();
      }
      
      public function get hasPowerPoint() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set powerPoint(param1:int) : void
      {
         hasField$1 |= 4;
         power_point$field = param1;
      }
      
      public function get powerPoint() : int
      {
         return power_point$field;
      }
      
      public function removeAgilityPoint() : void
      {
         hasField$1 &= 4294967287;
         agility_point$field = new int();
      }
      
      public function get hasAgilityPoint() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set agilityPoint(param1:int) : void
      {
         hasField$1 |= 8;
         agility_point$field = param1;
      }
      
      public function get agilityPoint() : int
      {
         return agility_point$field;
      }
      
      public function removeIntellectPoint() : void
      {
         hasField$1 &= 4294967279;
         intellect_point$field = new int();
      }
      
      public function get hasIntellectPoint() : Boolean
      {
         return (hasField$1 & 0x10) != 0;
      }
      
      public function set intellectPoint(param1:int) : void
      {
         hasField$1 |= 16;
         intellect_point$field = param1;
      }
      
      public function get intellectPoint() : int
      {
         return intellect_point$field;
      }
      
      public function removeCaptainPoint() : void
      {
         hasField$1 &= 4294967263;
         captain_point$field = new int();
      }
      
      public function get hasCaptainPoint() : Boolean
      {
         return (hasField$1 & 0x20) != 0;
      }
      
      public function set captainPoint(param1:int) : void
      {
         hasField$1 |= 32;
         captain_point$field = param1;
      }
      
      public function get captainPoint() : int
      {
         return captain_point$field;
      }
      
      public function removePhysiquePoint() : void
      {
         hasField$1 &= 4294967231;
         physique_point$field = new int();
      }
      
      public function get hasPhysiquePoint() : Boolean
      {
         return (hasField$1 & 0x40) != 0;
      }
      
      public function set physiquePoint(param1:int) : void
      {
         hasField$1 |= 64;
         physique_point$field = param1;
      }
      
      public function get physiquePoint() : int
      {
         return physique_point$field;
      }
      
      public function removeFightPos() : void
      {
         hasField$1 &= 4294967167;
         fight_pos$field = new int();
      }
      
      public function get hasFightPos() : Boolean
      {
         return (hasField$1 & 0x80) != 0;
      }
      
      public function set fightPos(param1:int) : void
      {
         hasField$1 |= 128;
         fight_pos$field = param1;
      }
      
      public function get fightPos() : int
      {
         return fight_pos$field;
      }
      
      public function removeSkillIndex() : void
      {
         hasField$1 &= 4294967039;
         skill_index$field = new int();
      }
      
      public function get hasSkillIndex() : Boolean
      {
         return (hasField$1 & 0x0100) != 0;
      }
      
      public function set skillIndex(param1:int) : void
      {
         hasField$1 |= 256;
         skill_index$field = param1;
      }
      
      public function get skillIndex() : int
      {
         return skill_index$field;
      }
      
      public function removeIsActiveSecond() : void
      {
         hasField$1 &= 4294966783;
         is_activeSecond$field = new Boolean();
      }
      
      public function get hasIsActiveSecond() : Boolean
      {
         return (hasField$1 & 0x0200) != 0;
      }
      
      public function set isActiveSecond(param1:Boolean) : void
      {
         hasField$1 |= 512;
         is_activeSecond$field = param1;
      }
      
      public function get isActiveSecond() : Boolean
      {
         return is_activeSecond$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$1 &= 4294966271;
         head_id$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$1 & 0x0400) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$1 |= 1024;
         head_id$field = param1;
      }
      
      public function get headId() : int
      {
         return head_id$field;
      }
      
      public function removeTalentPoint() : void
      {
         hasField$1 &= 4294965247;
         talent_point$field = new int();
      }
      
      public function get hasTalentPoint() : Boolean
      {
         return (hasField$1 & 0x0800) != 0;
      }
      
      public function set talentPoint(param1:int) : void
      {
         hasField$1 |= 2048;
         talent_point$field = param1;
      }
      
      public function get talentPoint() : int
      {
         return talent_point$field;
      }
      
      public function removeTalentGrade() : void
      {
         hasField$1 &= 4294963199;
         talent_grade$field = new int();
      }
      
      public function get hasTalentGrade() : Boolean
      {
         return (hasField$1 & 0x1000) != 0;
      }
      
      public function set talentGrade(param1:int) : void
      {
         hasField$1 |= 4096;
         talent_grade$field = param1;
      }
      
      public function get talentGrade() : int
      {
         return talent_grade$field;
      }
      
      public function removeTalentSkill() : void
      {
         talent_skill$field = null;
      }
      
      public function get hasTalentSkill() : Boolean
      {
         return talent_skill$field != null;
      }
      
      public function set talentSkill(param1:String) : void
      {
         talent_skill$field = param1;
      }
      
      public function get talentSkill() : String
      {
         return talent_skill$field;
      }
      
      public function removeGrade() : void
      {
         hasField$1 &= 4294959103;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$1 & 0x2000) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$1 |= 8192;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeArm() : void
      {
         arm$field = null;
      }
      
      public function get hasArm() : Boolean
      {
         return arm$field != null;
      }
      
      public function set arm(param1:String) : void
      {
         arm$field = param1;
      }
      
      public function get arm() : String
      {
         return arm$field;
      }
      
      public function removeCloth() : void
      {
         cloth$field = null;
      }
      
      public function get hasCloth() : Boolean
      {
         return cloth$field != null;
      }
      
      public function set cloth(param1:String) : void
      {
         cloth$field = param1;
      }
      
      public function get cloth() : String
      {
         return cloth$field;
      }
      
      public function removeWing() : void
      {
         wing$field = null;
      }
      
      public function get hasWing() : Boolean
      {
         return wing$field != null;
      }
      
      public function set wing(param1:String) : void
      {
         wing$field = param1;
      }
      
      public function get wing() : String
      {
         return wing$field;
      }
      
      public function removeFightingCapacity() : void
      {
         hasField$1 &= 4294950911;
         fighting_capacity$field = new int();
      }
      
      public function get hasFightingCapacity() : Boolean
      {
         return (hasField$1 & 0x4000) != 0;
      }
      
      public function set fightingCapacity(param1:int) : void
      {
         hasField$1 |= 16384;
         fighting_capacity$field = param1;
      }
      
      public function get fightingCapacity() : int
      {
         return fighting_capacity$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeHat() : void
      {
         hat$field = null;
      }
      
      public function get hasHat() : Boolean
      {
         return hat$field != null;
      }
      
      public function set hat(param1:String) : void
      {
         hat$field = param1;
      }
      
      public function get hat() : String
      {
         return hat$field;
      }
      
      public function removeFashionArm() : void
      {
         fashion_arm$field = null;
      }
      
      public function get hasFashionArm() : Boolean
      {
         return fashion_arm$field != null;
      }
      
      public function set fashionArm(param1:String) : void
      {
         fashion_arm$field = param1;
      }
      
      public function get fashionArm() : String
      {
         return fashion_arm$field;
      }
      
      public function removeFashionCloth() : void
      {
         fashion_cloth$field = null;
      }
      
      public function get hasFashionCloth() : Boolean
      {
         return fashion_cloth$field != null;
      }
      
      public function set fashionCloth(param1:String) : void
      {
         fashion_cloth$field = param1;
      }
      
      public function get fashionCloth() : String
      {
         return fashion_cloth$field;
      }
      
      public function removeHide() : void
      {
         hasField$1 &= 4294934527;
         hide$field = new Boolean();
      }
      
      public function get hasHide() : Boolean
      {
         return (hasField$1 & 0x8000) != 0;
      }
      
      public function set hide(param1:Boolean) : void
      {
         hasField$1 |= 32768;
         hide$field = param1;
      }
      
      public function get hide() : Boolean
      {
         return hide$field;
      }
      
      public function removeRune() : void
      {
         rune$field = null;
      }
      
      public function get hasRune() : Boolean
      {
         return rune$field != null;
      }
      
      public function set rune(param1:HeroRuneMsg) : void
      {
         rune$field = param1;
      }
      
      public function get rune() : HeroRuneMsg
      {
         return rune$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$1 &= 4294901759;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$1 & 0x010000) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$1 |= 65536;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$1 &= 4294836223;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$1 & 0x020000) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$1 |= 131072;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$1 &= 4294705151;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$1 & 0x040000) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$1 |= 262144;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$1 &= 4294443007;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$1 & 0x080000) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$1 |= 524288;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$1 &= 4293918719;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$1 & 0x100000) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$1 |= 1048576;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$1 &= 4292870143;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$1 & 0x200000) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$1 |= 2097152;
         lightResi$field = param1;
      }
      
      public function get lightResi() : int
      {
         return lightResi$field;
      }
      
      public function removeReduceResi() : void
      {
         hasField$1 &= 4290772991;
         reduce_resi$field = new int();
      }
      
      public function get hasReduceResi() : Boolean
      {
         return (hasField$1 & 0x400000) != 0;
      }
      
      public function set reduceResi(param1:int) : void
      {
         hasField$1 |= 4194304;
         reduce_resi$field = param1;
      }
      
      public function get reduceResi() : int
      {
         return reduce_resi$field;
      }
      
      public function removeTotalStrength() : void
      {
         hasField$1 &= 4286578687;
         total_strength$field = new int();
      }
      
      public function get hasTotalStrength() : Boolean
      {
         return (hasField$1 & 0x800000) != 0;
      }
      
      public function set totalStrength(param1:int) : void
      {
         hasField$1 |= 8388608;
         total_strength$field = param1;
      }
      
      public function get totalStrength() : int
      {
         return total_strength$field;
      }
      
      public function removeBaseStrength() : void
      {
         hasField$1 &= 4278190079;
         base_strength$field = new int();
      }
      
      public function get hasBaseStrength() : Boolean
      {
         return (hasField$1 & 0x01000000) != 0;
      }
      
      public function set baseStrength(param1:int) : void
      {
         hasField$1 |= 16777216;
         base_strength$field = param1;
      }
      
      public function get baseStrength() : int
      {
         return base_strength$field;
      }
      
      public function removeTotalTenacity() : void
      {
         hasField$1 &= 4261412863;
         total_tenacity$field = new int();
      }
      
      public function get hasTotalTenacity() : Boolean
      {
         return (hasField$1 & 0x02000000) != 0;
      }
      
      public function set totalTenacity(param1:int) : void
      {
         hasField$1 |= 33554432;
         total_tenacity$field = param1;
      }
      
      public function get totalTenacity() : int
      {
         return total_tenacity$field;
      }
      
      public function removeBaseTenacity() : void
      {
         hasField$1 &= 4227858431;
         base_tenacity$field = new int();
      }
      
      public function get hasBaseTenacity() : Boolean
      {
         return (hasField$1 & 0x04000000) != 0;
      }
      
      public function set baseTenacity(param1:int) : void
      {
         hasField$1 |= 67108864;
         base_tenacity$field = param1;
      }
      
      public function get baseTenacity() : int
      {
         return base_tenacity$field;
      }
      
      public function removeTotalPenetrate() : void
      {
         hasField$1 &= 4160749567;
         total_penetrate$field = new int();
      }
      
      public function get hasTotalPenetrate() : Boolean
      {
         return (hasField$1 & 0x08000000) != 0;
      }
      
      public function set totalPenetrate(param1:int) : void
      {
         hasField$1 |= 134217728;
         total_penetrate$field = param1;
      }
      
      public function get totalPenetrate() : int
      {
         return total_penetrate$field;
      }
      
      public function removeBasePenetrate() : void
      {
         hasField$1 &= 4026531839;
         base_penetrate$field = new int();
      }
      
      public function get hasBasePenetrate() : Boolean
      {
         return (hasField$1 & 0x10000000) != 0;
      }
      
      public function set basePenetrate(param1:int) : void
      {
         hasField$1 |= 268435456;
         base_penetrate$field = param1;
      }
      
      public function get basePenetrate() : int
      {
         return base_penetrate$field;
      }
      
      public function removeAdvancedTalentPoint() : void
      {
         hasField$1 &= 3758096383;
         advanced_talent_point$field = new int();
      }
      
      public function get hasAdvancedTalentPoint() : Boolean
      {
         return (hasField$1 & 0x20000000) != 0;
      }
      
      public function set advancedTalentPoint(param1:int) : void
      {
         hasField$1 |= 536870912;
         advanced_talent_point$field = param1;
      }
      
      public function get advancedTalentPoint() : int
      {
         return advanced_talent_point$field;
      }
      
      public function removeAdvancedTalentGrade() : void
      {
         hasField$1 &= 3221225471;
         advanced_talent_grade$field = new int();
      }
      
      public function get hasAdvancedTalentGrade() : Boolean
      {
         return (hasField$1 & 0x40000000) != 0;
      }
      
      public function set advancedTalentGrade(param1:int) : void
      {
         hasField$1 |= 1073741824;
         advanced_talent_grade$field = param1;
      }
      
      public function get advancedTalentGrade() : int
      {
         return advanced_talent_grade$field;
      }
      
      public function removeAdvancedTalentSkill() : void
      {
         advanced_talent_skill$field = null;
      }
      
      public function get hasAdvancedTalentSkill() : Boolean
      {
         return advanced_talent_skill$field != null;
      }
      
      public function set advancedTalentSkill(param1:String) : void
      {
         advanced_talent_skill$field = param1;
      }
      
      public function get advancedTalentSkill() : String
      {
         return advanced_talent_skill$field;
      }
      
      public function removeTotalStunAttr() : void
      {
         hasField$1 &= 2147483647;
         total_stunAttr$field = new int();
      }
      
      public function get hasTotalStunAttr() : Boolean
      {
         return (hasField$1 & 0x80000000) != 0;
      }
      
      public function set totalStunAttr(param1:int) : void
      {
         hasField$1 |= 2147483648;
         total_stunAttr$field = param1;
      }
      
      public function get totalStunAttr() : int
      {
         return total_stunAttr$field;
      }
      
      public function removeBaseStunAttr() : void
      {
         hasField$2 &= 4294967294;
         base_stunAttr$field = new int();
      }
      
      public function get hasBaseStunAttr() : Boolean
      {
         return (hasField$2 & 1) != 0;
      }
      
      public function set baseStunAttr(param1:int) : void
      {
         hasField$2 |= 1;
         base_stunAttr$field = param1;
      }
      
      public function get baseStunAttr() : int
      {
         return base_stunAttr$field;
      }
      
      public function removeTotalReduceResiAgainst() : void
      {
         hasField$2 &= 4294967293;
         total_reduce_resi_against$field = new int();
      }
      
      public function get hasTotalReduceResiAgainst() : Boolean
      {
         return (hasField$2 & 2) != 0;
      }
      
      public function set totalReduceResiAgainst(param1:int) : void
      {
         hasField$2 |= 2;
         total_reduce_resi_against$field = param1;
      }
      
      public function get totalReduceResiAgainst() : int
      {
         return total_reduce_resi_against$field;
      }
      
      public function removeReduceResiAgainst() : void
      {
         hasField$2 &= 4294967291;
         reduce_resi_against$field = new int();
      }
      
      public function get hasReduceResiAgainst() : Boolean
      {
         return (hasField$2 & 4) != 0;
      }
      
      public function set reduceResiAgainst(param1:int) : void
      {
         hasField$2 |= 4;
         reduce_resi_against$field = param1;
      }
      
      public function get reduceResiAgainst() : int
      {
         return reduce_resi_against$field;
      }
      
      public function removeTotalResiPenetrate() : void
      {
         hasField$2 &= 4294967287;
         total_resi_penetrate$field = new int();
      }
      
      public function get hasTotalResiPenetrate() : Boolean
      {
         return (hasField$2 & 8) != 0;
      }
      
      public function set totalResiPenetrate(param1:int) : void
      {
         hasField$2 |= 8;
         total_resi_penetrate$field = param1;
      }
      
      public function get totalResiPenetrate() : int
      {
         return total_resi_penetrate$field;
      }
      
      public function removeResiPenetrate() : void
      {
         hasField$2 &= 4294967279;
         resi_penetrate$field = new int();
      }
      
      public function get hasResiPenetrate() : Boolean
      {
         return (hasField$2 & 0x10) != 0;
      }
      
      public function set resiPenetrate(param1:int) : void
      {
         hasField$2 |= 16;
         resi_penetrate$field = param1;
      }
      
      public function get resiPenetrate() : int
      {
         return resi_penetrate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasHeroId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,hero_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasTempateId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,tempate_id$field);
         }
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasRemainPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,remain_point$field);
         }
         if(hasSkillPoint)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,skill_point$field);
         }
         if(hasSkillScript)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,skill_script$field);
         }
         if(hasFastKey)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,fast_key$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         if(hasBlood)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,blood$field);
         }
         if(hasBloodId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,blood_id$field);
         }
         if(hasTotalPower)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,total_power$field);
         }
         if(hasTotalAgility)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,total_agility$field);
         }
         if(hasTotalIntellect)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,total_intellect$field);
         }
         if(hasTotalCaptain)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,total_captain$field);
         }
         if(hasTotalPhysique)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,total_physique$field);
         }
         if(hasTotalPhyAttack)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,total_phy_attack$field);
         }
         if(hasTotalPhyDefence)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,total_phy_defence$field);
         }
         if(hasTotalMagicAttack)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,total_magic_attack$field);
         }
         if(hasTotalMagicDefence)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,total_magic_defence$field);
         }
         if(hasTotalForceHit)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,total_force_hit$field);
         }
         if(hasTotalParry)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,total_parry$field);
         }
         if(hasTotalConatArmy)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,total_conat_army$field);
         }
         if(hasTotalLive)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,total_live$field);
         }
         if(hasBasePower)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,base_power$field);
         }
         if(hasBaseAgility)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,base_agility$field);
         }
         if(hasBaseIntellect)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,base_intellect$field);
         }
         if(hasBaseCaptain)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,base_captain$field);
         }
         if(hasBasePhysique)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,base_physique$field);
         }
         if(hasBasePhyAttack)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,base_phy_attack$field);
         }
         if(hasBasePhyDefence)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,base_phy_defence$field);
         }
         if(hasBaseMagicAttack)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_INT32(param1,base_magic_attack$field);
         }
         if(hasBaseMagicDefence)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_INT32(param1,base_magic_defence$field);
         }
         if(hasBaseForceHit)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_INT32(param1,base_force_hit$field);
         }
         if(hasBaseParry)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,base_parry$field);
         }
         if(hasBaseConatArmy)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,base_conat_army$field);
         }
         if(hasBaseLive)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_INT32(param1,base_live$field);
         }
         if(hasPowerPoint)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_INT32(param1,power_point$field);
         }
         if(hasAgilityPoint)
         {
            WriteUtils.writeTag(param1,0,39);
            WriteUtils.write$TYPE_INT32(param1,agility_point$field);
         }
         if(hasIntellectPoint)
         {
            WriteUtils.writeTag(param1,0,40);
            WriteUtils.write$TYPE_INT32(param1,intellect_point$field);
         }
         if(hasCaptainPoint)
         {
            WriteUtils.writeTag(param1,0,41);
            WriteUtils.write$TYPE_INT32(param1,captain_point$field);
         }
         if(hasPhysiquePoint)
         {
            WriteUtils.writeTag(param1,0,42);
            WriteUtils.write$TYPE_INT32(param1,physique_point$field);
         }
         if(hasFightPos)
         {
            WriteUtils.writeTag(param1,0,43);
            WriteUtils.write$TYPE_INT32(param1,fight_pos$field);
         }
         if(hasSkillIndex)
         {
            WriteUtils.writeTag(param1,0,44);
            WriteUtils.write$TYPE_INT32(param1,skill_index$field);
         }
         if(hasIsActiveSecond)
         {
            WriteUtils.writeTag(param1,0,45);
            WriteUtils.write$TYPE_BOOL(param1,is_activeSecond$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,46);
            WriteUtils.write$TYPE_INT32(param1,head_id$field);
         }
         if(hasTalentPoint)
         {
            WriteUtils.writeTag(param1,0,47);
            WriteUtils.write$TYPE_INT32(param1,talent_point$field);
         }
         if(hasTalentGrade)
         {
            WriteUtils.writeTag(param1,0,48);
            WriteUtils.write$TYPE_INT32(param1,talent_grade$field);
         }
         if(hasTalentSkill)
         {
            WriteUtils.writeTag(param1,2,49);
            WriteUtils.write$TYPE_STRING(param1,talent_skill$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,50);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,51);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasCloth)
         {
            WriteUtils.writeTag(param1,2,52);
            WriteUtils.write$TYPE_STRING(param1,cloth$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,53);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasFightingCapacity)
         {
            WriteUtils.writeTag(param1,0,54);
            WriteUtils.write$TYPE_INT32(param1,fighting_capacity$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,55);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,56);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,57);
            WriteUtils.write$TYPE_STRING(param1,fashion_arm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,58);
            WriteUtils.write$TYPE_STRING(param1,fashion_cloth$field);
         }
         if(hasHide)
         {
            WriteUtils.writeTag(param1,0,59);
            WriteUtils.write$TYPE_BOOL(param1,hide$field);
         }
         if(hasRune)
         {
            WriteUtils.writeTag(param1,2,60);
            WriteUtils.write$TYPE_MESSAGE(param1,rune$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,61);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,62);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,63);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,64);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,65);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,66);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
         if(hasReduceResi)
         {
            WriteUtils.writeTag(param1,0,67);
            WriteUtils.write$TYPE_INT32(param1,reduce_resi$field);
         }
         if(hasTotalStrength)
         {
            WriteUtils.writeTag(param1,0,68);
            WriteUtils.write$TYPE_INT32(param1,total_strength$field);
         }
         if(hasBaseStrength)
         {
            WriteUtils.writeTag(param1,0,69);
            WriteUtils.write$TYPE_INT32(param1,base_strength$field);
         }
         if(hasTotalTenacity)
         {
            WriteUtils.writeTag(param1,0,70);
            WriteUtils.write$TYPE_INT32(param1,total_tenacity$field);
         }
         if(hasBaseTenacity)
         {
            WriteUtils.writeTag(param1,0,71);
            WriteUtils.write$TYPE_INT32(param1,base_tenacity$field);
         }
         if(hasTotalPenetrate)
         {
            WriteUtils.writeTag(param1,0,72);
            WriteUtils.write$TYPE_INT32(param1,total_penetrate$field);
         }
         if(hasBasePenetrate)
         {
            WriteUtils.writeTag(param1,0,73);
            WriteUtils.write$TYPE_INT32(param1,base_penetrate$field);
         }
         if(hasAdvancedTalentPoint)
         {
            WriteUtils.writeTag(param1,0,74);
            WriteUtils.write$TYPE_INT32(param1,advanced_talent_point$field);
         }
         if(hasAdvancedTalentGrade)
         {
            WriteUtils.writeTag(param1,0,75);
            WriteUtils.write$TYPE_INT32(param1,advanced_talent_grade$field);
         }
         if(hasAdvancedTalentSkill)
         {
            WriteUtils.writeTag(param1,2,76);
            WriteUtils.write$TYPE_STRING(param1,advanced_talent_skill$field);
         }
         if(hasTotalStunAttr)
         {
            WriteUtils.writeTag(param1,0,77);
            WriteUtils.write$TYPE_INT32(param1,total_stunAttr$field);
         }
         if(hasBaseStunAttr)
         {
            WriteUtils.writeTag(param1,0,78);
            WriteUtils.write$TYPE_INT32(param1,base_stunAttr$field);
         }
         if(hasTotalReduceResiAgainst)
         {
            WriteUtils.writeTag(param1,0,79);
            WriteUtils.write$TYPE_INT32(param1,total_reduce_resi_against$field);
         }
         if(hasReduceResiAgainst)
         {
            WriteUtils.writeTag(param1,0,80);
            WriteUtils.write$TYPE_INT32(param1,reduce_resi_against$field);
         }
         if(hasTotalResiPenetrate)
         {
            WriteUtils.writeTag(param1,0,81);
            WriteUtils.write$TYPE_INT32(param1,total_resi_penetrate$field);
         }
         if(hasResiPenetrate)
         {
            WriteUtils.writeTag(param1,0,82);
            WriteUtils.write$TYPE_INT32(param1,resi_penetrate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc37_:uint = 0;
         var _loc60_:uint = 0;
         var _loc55_:uint = 0;
         var _loc5_:uint = 0;
         var _loc29_:uint = 0;
         var _loc31_:uint = 0;
         var _loc34_:uint = 0;
         var _loc73_:uint = 0;
         var _loc50_:uint = 0;
         var _loc56_:uint = 0;
         var _loc47_:uint = 0;
         var _loc53_:uint = 0;
         var _loc62_:uint = 0;
         var _loc7_:uint = 0;
         var _loc85_:uint = 0;
         var _loc64_:uint = 0;
         var _loc20_:uint = 0;
         var _loc43_:uint = 0;
         var _loc54_:uint = 0;
         var _loc16_:uint = 0;
         var _loc25_:uint = 0;
         var _loc78_:uint = 0;
         var _loc84_:uint = 0;
         var _loc57_:uint = 0;
         var _loc27_:uint = 0;
         var _loc9_:uint = 0;
         var _loc17_:uint = 0;
         var _loc19_:uint = 0;
         var _loc6_:uint = 0;
         var _loc35_:uint = 0;
         var _loc26_:uint = 0;
         var _loc48_:uint = 0;
         var _loc81_:uint = 0;
         var _loc22_:uint = 0;
         var _loc68_:uint = 0;
         var _loc42_:uint = 0;
         var _loc23_:uint = 0;
         var _loc45_:uint = 0;
         var _loc79_:uint = 0;
         var _loc61_:uint = 0;
         var _loc69_:uint = 0;
         var _loc12_:uint = 0;
         var _loc75_:uint = 0;
         var _loc46_:uint = 0;
         var _loc71_:uint = 0;
         var _loc36_:uint = 0;
         var _loc65_:uint = 0;
         var _loc24_:uint = 0;
         var _loc83_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         var _loc51_:uint = 0;
         var _loc18_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc58_:uint = 0;
         var _loc49_:uint = 0;
         var _loc30_:uint = 0;
         var _loc66_:uint = 0;
         var _loc3_:uint = 0;
         var _loc70_:uint = 0;
         var _loc76_:uint = 0;
         var _loc52_:uint = 0;
         var _loc38_:uint = 0;
         var _loc28_:uint = 0;
         var _loc15_:uint = 0;
         var _loc39_:uint = 0;
         var _loc77_:uint = 0;
         var _loc59_:uint = 0;
         var _loc74_:uint = 0;
         var _loc82_:uint = 0;
         var _loc4_:uint = 0;
         var _loc41_:uint = 0;
         var _loc80_:uint = 0;
         var _loc13_:uint = 0;
         var _loc63_:uint = 0;
         var _loc44_:uint = 0;
         var _loc40_:uint = 0;
         var _loc32_:uint = 0;
         var _loc72_:uint = 0;
         var _loc33_:uint = 0;
         var _loc67_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.heroId cannot be set twice.");
                  }
                  _loc37_++;
                  heroId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc60_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.nickName cannot be set twice.");
                  }
                  _loc60_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc55_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.tempateId cannot be set twice.");
                  }
                  _loc55_++;
                  tempateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.playerId cannot be set twice.");
                  }
                  _loc5_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.remainPoint cannot be set twice.");
                  }
                  _loc29_++;
                  remainPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.skillPoint cannot be set twice.");
                  }
                  _loc31_++;
                  skillPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.skillScript cannot be set twice.");
                  }
                  _loc34_++;
                  skillScript = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc73_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.fastKey cannot be set twice.");
                  }
                  _loc73_++;
                  fastKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc50_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.hp cannot be set twice.");
                  }
                  _loc50_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc56_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.blood cannot be set twice.");
                  }
                  _loc56_++;
                  blood = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc47_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.bloodId cannot be set twice.");
                  }
                  _loc47_++;
                  bloodId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc53_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalPower cannot be set twice.");
                  }
                  _loc53_++;
                  totalPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc62_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalAgility cannot be set twice.");
                  }
                  _loc62_++;
                  totalAgility = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalIntellect cannot be set twice.");
                  }
                  _loc7_++;
                  totalIntellect = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc85_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalCaptain cannot be set twice.");
                  }
                  _loc85_++;
                  totalCaptain = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc64_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalPhysique cannot be set twice.");
                  }
                  _loc64_++;
                  totalPhysique = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalPhyAttack cannot be set twice.");
                  }
                  _loc20_++;
                  totalPhyAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc43_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalPhyDefence cannot be set twice.");
                  }
                  _loc43_++;
                  totalPhyDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc54_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalMagicAttack cannot be set twice.");
                  }
                  _loc54_++;
                  totalMagicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalMagicDefence cannot be set twice.");
                  }
                  _loc16_++;
                  totalMagicDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalForceHit cannot be set twice.");
                  }
                  _loc25_++;
                  totalForceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc78_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalParry cannot be set twice.");
                  }
                  _loc78_++;
                  totalParry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc84_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalConatArmy cannot be set twice.");
                  }
                  _loc84_++;
                  totalConatArmy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc57_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalLive cannot be set twice.");
                  }
                  _loc57_++;
                  totalLive = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.basePower cannot be set twice.");
                  }
                  _loc27_++;
                  basePower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseAgility cannot be set twice.");
                  }
                  _loc9_++;
                  baseAgility = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseIntellect cannot be set twice.");
                  }
                  _loc17_++;
                  baseIntellect = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseCaptain cannot be set twice.");
                  }
                  _loc19_++;
                  baseCaptain = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.basePhysique cannot be set twice.");
                  }
                  _loc6_++;
                  basePhysique = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.basePhyAttack cannot be set twice.");
                  }
                  _loc35_++;
                  basePhyAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.basePhyDefence cannot be set twice.");
                  }
                  _loc26_++;
                  basePhyDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 32:
                  if(_loc48_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseMagicAttack cannot be set twice.");
                  }
                  _loc48_++;
                  baseMagicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 33:
                  if(_loc81_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseMagicDefence cannot be set twice.");
                  }
                  _loc81_++;
                  baseMagicDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 34:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseForceHit cannot be set twice.");
                  }
                  _loc22_++;
                  baseForceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 35:
                  if(_loc68_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseParry cannot be set twice.");
                  }
                  _loc68_++;
                  baseParry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 36:
                  if(_loc42_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseConatArmy cannot be set twice.");
                  }
                  _loc42_++;
                  baseConatArmy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 37:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseLive cannot be set twice.");
                  }
                  _loc23_++;
                  baseLive = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 38:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.powerPoint cannot be set twice.");
                  }
                  _loc45_++;
                  powerPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 39:
                  if(_loc79_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.agilityPoint cannot be set twice.");
                  }
                  _loc79_++;
                  agilityPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 40:
                  if(_loc61_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.intellectPoint cannot be set twice.");
                  }
                  _loc61_++;
                  intellectPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 41:
                  if(_loc69_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.captainPoint cannot be set twice.");
                  }
                  _loc69_++;
                  captainPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 42:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.physiquePoint cannot be set twice.");
                  }
                  _loc12_++;
                  physiquePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 43:
                  if(_loc75_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.fightPos cannot be set twice.");
                  }
                  _loc75_++;
                  fightPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 44:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.skillIndex cannot be set twice.");
                  }
                  _loc46_++;
                  skillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 45:
                  if(_loc71_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.isActiveSecond cannot be set twice.");
                  }
                  _loc71_++;
                  isActiveSecond = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 46:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.headId cannot be set twice.");
                  }
                  _loc36_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 47:
                  if(_loc65_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.talentPoint cannot be set twice.");
                  }
                  _loc65_++;
                  talentPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 48:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.talentGrade cannot be set twice.");
                  }
                  _loc24_++;
                  talentGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 49:
                  if(_loc83_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.talentSkill cannot be set twice.");
                  }
                  _loc83_++;
                  talentSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 50:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.grade cannot be set twice.");
                  }
                  _loc8_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 51:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.arm cannot be set twice.");
                  }
                  _loc14_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 52:
                  if(_loc51_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.cloth cannot be set twice.");
                  }
                  _loc51_++;
                  cloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 53:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.wing cannot be set twice.");
                  }
                  _loc18_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 54:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.fightingCapacity cannot be set twice.");
                  }
                  _loc11_++;
                  fightingCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 55:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 56:
                  if(_loc58_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.hat cannot be set twice.");
                  }
                  _loc58_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 57:
                  if(_loc49_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.fashionArm cannot be set twice.");
                  }
                  _loc49_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 58:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.fashionCloth cannot be set twice.");
                  }
                  _loc30_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 59:
                  if(_loc66_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.hide cannot be set twice.");
                  }
                  _loc66_++;
                  hide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 60:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.rune cannot be set twice.");
                  }
                  _loc3_++;
                  rune = new HeroRuneMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,rune);
                  break;
               case 61:
                  if(_loc70_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.fireResi cannot be set twice.");
                  }
                  _loc70_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 62:
                  if(_loc76_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.waterResi cannot be set twice.");
                  }
                  _loc76_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 63:
                  if(_loc52_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.electResi cannot be set twice.");
                  }
                  _loc52_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 64:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.windResi cannot be set twice.");
                  }
                  _loc38_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 65:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.darkResi cannot be set twice.");
                  }
                  _loc28_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 66:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.lightResi cannot be set twice.");
                  }
                  _loc15_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 67:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.reduceResi cannot be set twice.");
                  }
                  _loc39_++;
                  reduceResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 68:
                  if(_loc77_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalStrength cannot be set twice.");
                  }
                  _loc77_++;
                  totalStrength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 69:
                  if(_loc59_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseStrength cannot be set twice.");
                  }
                  _loc59_++;
                  baseStrength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 70:
                  if(_loc74_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalTenacity cannot be set twice.");
                  }
                  _loc74_++;
                  totalTenacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 71:
                  if(_loc82_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseTenacity cannot be set twice.");
                  }
                  _loc82_++;
                  baseTenacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 72:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalPenetrate cannot be set twice.");
                  }
                  _loc4_++;
                  totalPenetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 73:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.basePenetrate cannot be set twice.");
                  }
                  _loc41_++;
                  basePenetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 74:
                  if(_loc80_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.advancedTalentPoint cannot be set twice.");
                  }
                  _loc80_++;
                  advancedTalentPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 75:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.advancedTalentGrade cannot be set twice.");
                  }
                  _loc13_++;
                  advancedTalentGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 76:
                  if(_loc63_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.advancedTalentSkill cannot be set twice.");
                  }
                  _loc63_++;
                  advancedTalentSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 77:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalStunAttr cannot be set twice.");
                  }
                  _loc44_++;
                  totalStunAttr = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 78:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.baseStunAttr cannot be set twice.");
                  }
                  _loc40_++;
                  baseStunAttr = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 79:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalReduceResiAgainst cannot be set twice.");
                  }
                  _loc32_++;
                  totalReduceResiAgainst = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 80:
                  if(_loc72_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.reduceResiAgainst cannot be set twice.");
                  }
                  _loc72_++;
                  reduceResiAgainst = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 81:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.totalResiPenetrate cannot be set twice.");
                  }
                  _loc33_++;
                  totalResiPenetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 82:
                  if(_loc67_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleHeroInfoMsg.resiPenetrate cannot be set twice.");
                  }
                  _loc67_++;
                  resiPenetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

