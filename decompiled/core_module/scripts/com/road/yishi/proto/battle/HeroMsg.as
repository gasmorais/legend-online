package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroMsg extends Message implements IExternalizable
   {
      
      private var hero_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var living_id$field:int;
      
      private var user_id$field:int;
      
      private var user_pics$field:int;
      
      private var temp_id$field:int;
      
      private var type$field:int;
      
      private var nick_name$field:String;
      
      private var grade$field:int;
      
      private var side$field:int;
      
      private var pos$field:int;
      
      private var max_hp$field:Int64;
      
      private var init_hp$field:Int64;
      
      private var hp$field:Int64;
      
      private var init_hp2$field:Int64;
      
      private var hp2$field:Int64;
      
      private var sp$field:int;
      
      private var slot_avata$field:String;
      
      private var cloth_avate$field:String;
      
      private var cloak_path$field:String;
      
      private var hair_path$field:String;
      
      private var captain$field:int;
      
      private var res$field:String;
      
      private var qte_time$field:int;
      
      private var cast_time$field:int;
      
      private var pics$field:int;
      
      private var job$field:int;
      
      private var phy_attack$field:int;
      
      private var phy_defence$field:int;
      
      private var mag_attack$field:int;
      
      private var mag_defence$field:int;
      
      private var force_hit$field:int;
      
      private var parry$field:int;
      
      private var sites$field:int;
      
      private var skill_script$field:String;
      
      private var pawn_temp_id$field:int;
      
      [ArrayElementType("int")]
      public var skillId:Array = [];
      
      private var attack_wound$field:Int64;
      
      private var hit_wound$field:Int64;
      
      private var attack_model$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.StarBufferMsg")]
      public var starBuffer:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.BattleItemMsg")]
      public var item:Array = [];
      
      private var head_id$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.BufferMsg")]
      public var buffers:Array = [];
      
      private var is_show$field:Boolean;
      
      private var server_name$field:String;
      
      private var wing_avata$field:String;
      
      [ArrayElementType("com.road.yishi.proto.battle.TrialInfoMsg")]
      public var trials:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.BaseItemMsg")]
      public var battleDrop:Array = [];
      
      private var hat_avata$field:String;
      
      private var fashion_arm_avata$field:String;
      
      private var fashion_cloth_avata$field:String;
      
      private var hide$field:Boolean;
      
      private var appell_id$field:int;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var hasField$1:uint = 0;
      
      private var lightResi$field:int;
      
      private var followSkills$field:String;
      
      private var changeSkills$field:String;
      
      private var defaultSkills$field:String;
      
      private var awake$field:int;
      
      private var living_id2$field:int;
      
      [ArrayElementType("int")]
      public var changeSkillId:Array = [];
      
      private var fate_skillTempIds$field:String;
      
      private var is_change$field:Boolean;
      
      private var pet_quality$field:int;
      
      private var fight_capacity$field:int;
      
      private var reduce_resi$field:int;
      
      private var strength$field:int;
      
      private var tenacity$field:int;
      
      private var has_shadow$field:Boolean;
      
      private var penetrate$field:int;
      
      private var transfer_grade$field:int;
      
      [ArrayElementType("int")]
      public var marriageSkills:Array = [];
      
      private var mate_id$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.TrialInfoMsg")]
      public var marSkills:Array = [];
      
      private var mate_server_name$field:String;
      
      private var stunAttr$field:int;
      
      private var isFollow$field:Boolean;
      
      private var multiLordsInspireLevel$field:int;
      
      private var spMax$field:int;
      
      private var hitPoint$field:int;
      
      private var hitPointMax$field:int;
      
      private var spLimit$field:int;
      
      private var growth_grade$field:int;
      
      private var curturn$field:int;
      
      private var scuffleSequence$field:int;
      
      private var isFight$field:Boolean;
      
      private var changeBranch$field:int;
      
      private var titanInfo$field:TitanInfoMsg;
      
      private var isSlaveChild$field:Boolean;
      
      private var followChild$field:int;
      
      private var relicSkillId$field:int;
      
      private var awakeBuffers$field:String;
      
      private var awakeSkillId$field:int;
      
      private var childAwake$field:int;
      
      private var isManualChild$field:Boolean;
      
      private var isDragonTalker$field:Boolean;
      
      private var hasField$2:uint = 0;
      
      private var fightMount$field:int;
      
      private var belief$field:int;
      
      private var action_belief$field:int;
      
      private var replaceSkill$field:ReplaceSkillMsg;
      
      private var isCaptain$field:Boolean;
      
      private var avengerSp$field:int;
      
      private var avengerCd$field:int;
      
      private var avengerLeftCd$field:int;
      
      [ArrayElementType("int")]
      public var avengerSkills:Array = [];
      
      [ArrayElementType("int")]
      public var avengerAllSkills:Array = [];
      
      private var avengerGrade$field:int;
      
      private var reduceResiAgainst$field:int;
      
      private var resiPenetrate$field:int;
      
      [ArrayElementType("int")]
      public var warSoulSkills:Array = [];
      
      private var warSoulSp$field:int;
      
      private var warSoulType$field:int;
      
      [ArrayElementType("int")]
      public var addSkills:Array = [];
      
      public function HeroMsg()
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
      
      public function removeLivingId() : void
      {
         hasField$0 &= 4294967293;
         living_id$field = new int();
      }
      
      public function get hasLivingId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set livingId(param1:int) : void
      {
         hasField$0 |= 2;
         living_id$field = param1;
      }
      
      public function get livingId() : int
      {
         return living_id$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeUserPics() : void
      {
         hasField$0 &= 4294967287;
         user_pics$field = new int();
      }
      
      public function get hasUserPics() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set userPics(param1:int) : void
      {
         hasField$0 |= 8;
         user_pics$field = param1;
      }
      
      public function get userPics() : int
      {
         return user_pics$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967279;
         temp_id$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 16;
         temp_id$field = param1;
      }
      
      public function get tempId() : int
      {
         return temp_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967263;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 32;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
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
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967231;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 64;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeSide() : void
      {
         hasField$0 &= 4294967167;
         side$field = new int();
      }
      
      public function get hasSide() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set side(param1:int) : void
      {
         hasField$0 |= 128;
         side$field = param1;
      }
      
      public function get side() : int
      {
         return side$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967039;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 256;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeMaxHp() : void
      {
         max_hp$field = null;
      }
      
      public function get hasMaxHp() : Boolean
      {
         return max_hp$field != null;
      }
      
      public function set maxHp(param1:Int64) : void
      {
         max_hp$field = param1;
      }
      
      public function get maxHp() : Int64
      {
         return max_hp$field;
      }
      
      public function removeInitHp() : void
      {
         init_hp$field = null;
      }
      
      public function get hasInitHp() : Boolean
      {
         return init_hp$field != null;
      }
      
      public function set initHp(param1:Int64) : void
      {
         init_hp$field = param1;
      }
      
      public function get initHp() : Int64
      {
         return init_hp$field;
      }
      
      public function removeHp() : void
      {
         hp$field = null;
      }
      
      public function get hasHp() : Boolean
      {
         return hp$field != null;
      }
      
      public function set hp(param1:Int64) : void
      {
         hp$field = param1;
      }
      
      public function get hp() : Int64
      {
         return hp$field;
      }
      
      public function removeInitHp2() : void
      {
         init_hp2$field = null;
      }
      
      public function get hasInitHp2() : Boolean
      {
         return init_hp2$field != null;
      }
      
      public function set initHp2(param1:Int64) : void
      {
         init_hp2$field = param1;
      }
      
      public function get initHp2() : Int64
      {
         return init_hp2$field;
      }
      
      public function removeHp2() : void
      {
         hp2$field = null;
      }
      
      public function get hasHp2() : Boolean
      {
         return hp2$field != null;
      }
      
      public function set hp2(param1:Int64) : void
      {
         hp2$field = param1;
      }
      
      public function get hp2() : Int64
      {
         return hp2$field;
      }
      
      public function removeSp() : void
      {
         hasField$0 &= 4294966783;
         sp$field = new int();
      }
      
      public function get hasSp() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set sp(param1:int) : void
      {
         hasField$0 |= 512;
         sp$field = param1;
      }
      
      public function get sp() : int
      {
         return sp$field;
      }
      
      public function removeSlotAvata() : void
      {
         slot_avata$field = null;
      }
      
      public function get hasSlotAvata() : Boolean
      {
         return slot_avata$field != null;
      }
      
      public function set slotAvata(param1:String) : void
      {
         slot_avata$field = param1;
      }
      
      public function get slotAvata() : String
      {
         return slot_avata$field;
      }
      
      public function removeClothAvate() : void
      {
         cloth_avate$field = null;
      }
      
      public function get hasClothAvate() : Boolean
      {
         return cloth_avate$field != null;
      }
      
      public function set clothAvate(param1:String) : void
      {
         cloth_avate$field = param1;
      }
      
      public function get clothAvate() : String
      {
         return cloth_avate$field;
      }
      
      public function removeCloakPath() : void
      {
         cloak_path$field = null;
      }
      
      public function get hasCloakPath() : Boolean
      {
         return cloak_path$field != null;
      }
      
      public function set cloakPath(param1:String) : void
      {
         cloak_path$field = param1;
      }
      
      public function get cloakPath() : String
      {
         return cloak_path$field;
      }
      
      public function removeHairPath() : void
      {
         hair_path$field = null;
      }
      
      public function get hasHairPath() : Boolean
      {
         return hair_path$field != null;
      }
      
      public function set hairPath(param1:String) : void
      {
         hair_path$field = param1;
      }
      
      public function get hairPath() : String
      {
         return hair_path$field;
      }
      
      public function removeCaptain() : void
      {
         hasField$0 &= 4294966271;
         captain$field = new int();
      }
      
      public function get hasCaptain() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set captain(param1:int) : void
      {
         hasField$0 |= 1024;
         captain$field = param1;
      }
      
      public function get captain() : int
      {
         return captain$field;
      }
      
      public function removeRes() : void
      {
         res$field = null;
      }
      
      public function get hasRes() : Boolean
      {
         return res$field != null;
      }
      
      public function set res(param1:String) : void
      {
         res$field = param1;
      }
      
      public function get res() : String
      {
         return res$field;
      }
      
      public function removeQteTime() : void
      {
         hasField$0 &= 4294965247;
         qte_time$field = new int();
      }
      
      public function get hasQteTime() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set qteTime(param1:int) : void
      {
         hasField$0 |= 2048;
         qte_time$field = param1;
      }
      
      public function get qteTime() : int
      {
         return qte_time$field;
      }
      
      public function removeCastTime() : void
      {
         hasField$0 &= 4294963199;
         cast_time$field = new int();
      }
      
      public function get hasCastTime() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set castTime(param1:int) : void
      {
         hasField$0 |= 4096;
         cast_time$field = param1;
      }
      
      public function get castTime() : int
      {
         return cast_time$field;
      }
      
      public function removePics() : void
      {
         hasField$0 &= 4294959103;
         pics$field = new int();
      }
      
      public function get hasPics() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set pics(param1:int) : void
      {
         hasField$0 |= 8192;
         pics$field = param1;
      }
      
      public function get pics() : int
      {
         return pics$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294950911;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 16384;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removePhyAttack() : void
      {
         hasField$0 &= 4294934527;
         phy_attack$field = new int();
      }
      
      public function get hasPhyAttack() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set phyAttack(param1:int) : void
      {
         hasField$0 |= 32768;
         phy_attack$field = param1;
      }
      
      public function get phyAttack() : int
      {
         return phy_attack$field;
      }
      
      public function removePhyDefence() : void
      {
         hasField$0 &= 4294901759;
         phy_defence$field = new int();
      }
      
      public function get hasPhyDefence() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set phyDefence(param1:int) : void
      {
         hasField$0 |= 65536;
         phy_defence$field = param1;
      }
      
      public function get phyDefence() : int
      {
         return phy_defence$field;
      }
      
      public function removeMagAttack() : void
      {
         hasField$0 &= 4294836223;
         mag_attack$field = new int();
      }
      
      public function get hasMagAttack() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set magAttack(param1:int) : void
      {
         hasField$0 |= 131072;
         mag_attack$field = param1;
      }
      
      public function get magAttack() : int
      {
         return mag_attack$field;
      }
      
      public function removeMagDefence() : void
      {
         hasField$0 &= 4294705151;
         mag_defence$field = new int();
      }
      
      public function get hasMagDefence() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set magDefence(param1:int) : void
      {
         hasField$0 |= 262144;
         mag_defence$field = param1;
      }
      
      public function get magDefence() : int
      {
         return mag_defence$field;
      }
      
      public function removeForceHit() : void
      {
         hasField$0 &= 4294443007;
         force_hit$field = new int();
      }
      
      public function get hasForceHit() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set forceHit(param1:int) : void
      {
         hasField$0 |= 524288;
         force_hit$field = param1;
      }
      
      public function get forceHit() : int
      {
         return force_hit$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4293918719;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 1048576;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removeSites() : void
      {
         hasField$0 &= 4292870143;
         sites$field = new int();
      }
      
      public function get hasSites() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set sites(param1:int) : void
      {
         hasField$0 |= 2097152;
         sites$field = param1;
      }
      
      public function get sites() : int
      {
         return sites$field;
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
      
      public function removePawnTempId() : void
      {
         hasField$0 &= 4290772991;
         pawn_temp_id$field = new int();
      }
      
      public function get hasPawnTempId() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set pawnTempId(param1:int) : void
      {
         hasField$0 |= 4194304;
         pawn_temp_id$field = param1;
      }
      
      public function get pawnTempId() : int
      {
         return pawn_temp_id$field;
      }
      
      public function removeAttackWound() : void
      {
         attack_wound$field = null;
      }
      
      public function get hasAttackWound() : Boolean
      {
         return attack_wound$field != null;
      }
      
      public function set attackWound(param1:Int64) : void
      {
         attack_wound$field = param1;
      }
      
      public function get attackWound() : Int64
      {
         return attack_wound$field;
      }
      
      public function removeHitWound() : void
      {
         hit_wound$field = null;
      }
      
      public function get hasHitWound() : Boolean
      {
         return hit_wound$field != null;
      }
      
      public function set hitWound(param1:Int64) : void
      {
         hit_wound$field = param1;
      }
      
      public function get hitWound() : Int64
      {
         return hit_wound$field;
      }
      
      public function removeAttackModel() : void
      {
         hasField$0 &= 4286578687;
         attack_model$field = new int();
      }
      
      public function get hasAttackModel() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set attackModel(param1:int) : void
      {
         hasField$0 |= 8388608;
         attack_model$field = param1;
      }
      
      public function get attackModel() : int
      {
         return attack_model$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4278190079;
         head_id$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 16777216;
         head_id$field = param1;
      }
      
      public function get headId() : int
      {
         return head_id$field;
      }
      
      public function removeIsShow() : void
      {
         hasField$0 &= 4261412863;
         is_show$field = new Boolean();
      }
      
      public function get hasIsShow() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         hasField$0 |= 33554432;
         is_show$field = param1;
      }
      
      public function get isShow() : Boolean
      {
         return is_show$field;
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
      
      public function removeWingAvata() : void
      {
         wing_avata$field = null;
      }
      
      public function get hasWingAvata() : Boolean
      {
         return wing_avata$field != null;
      }
      
      public function set wingAvata(param1:String) : void
      {
         wing_avata$field = param1;
      }
      
      public function get wingAvata() : String
      {
         return wing_avata$field;
      }
      
      public function removeHatAvata() : void
      {
         hat_avata$field = null;
      }
      
      public function get hasHatAvata() : Boolean
      {
         return hat_avata$field != null;
      }
      
      public function set hatAvata(param1:String) : void
      {
         hat_avata$field = param1;
      }
      
      public function get hatAvata() : String
      {
         return hat_avata$field;
      }
      
      public function removeFashionArmAvata() : void
      {
         fashion_arm_avata$field = null;
      }
      
      public function get hasFashionArmAvata() : Boolean
      {
         return fashion_arm_avata$field != null;
      }
      
      public function set fashionArmAvata(param1:String) : void
      {
         fashion_arm_avata$field = param1;
      }
      
      public function get fashionArmAvata() : String
      {
         return fashion_arm_avata$field;
      }
      
      public function removeFashionClothAvata() : void
      {
         fashion_cloth_avata$field = null;
      }
      
      public function get hasFashionClothAvata() : Boolean
      {
         return fashion_cloth_avata$field != null;
      }
      
      public function set fashionClothAvata(param1:String) : void
      {
         fashion_cloth_avata$field = param1;
      }
      
      public function get fashionClothAvata() : String
      {
         return fashion_cloth_avata$field;
      }
      
      public function removeHide() : void
      {
         hasField$0 &= 4227858431;
         hide$field = new Boolean();
      }
      
      public function get hasHide() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set hide(param1:Boolean) : void
      {
         hasField$0 |= 67108864;
         hide$field = param1;
      }
      
      public function get hide() : Boolean
      {
         return hide$field;
      }
      
      public function removeAppellId() : void
      {
         hasField$0 &= 4160749567;
         appell_id$field = new int();
      }
      
      public function get hasAppellId() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set appellId(param1:int) : void
      {
         hasField$0 |= 134217728;
         appell_id$field = param1;
      }
      
      public function get appellId() : int
      {
         return appell_id$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$0 &= 4026531839;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$0 |= 268435456;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$0 &= 3758096383;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$0 |= 536870912;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$0 &= 3221225471;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$0 |= 1073741824;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$0 &= 2147483647;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$0 |= 2147483648;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$1 &= 4294967294;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$1 |= 1;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$1 &= 4294967293;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$1 |= 2;
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
      
      public function removeDefaultSkills() : void
      {
         defaultSkills$field = null;
      }
      
      public function get hasDefaultSkills() : Boolean
      {
         return defaultSkills$field != null;
      }
      
      public function set defaultSkills(param1:String) : void
      {
         defaultSkills$field = param1;
      }
      
      public function get defaultSkills() : String
      {
         return defaultSkills$field;
      }
      
      public function removeAwake() : void
      {
         hasField$1 &= 4294967291;
         awake$field = new int();
      }
      
      public function get hasAwake() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set awake(param1:int) : void
      {
         hasField$1 |= 4;
         awake$field = param1;
      }
      
      public function get awake() : int
      {
         return awake$field;
      }
      
      public function removeLivingId2() : void
      {
         hasField$1 &= 4294967287;
         living_id2$field = new int();
      }
      
      public function get hasLivingId2() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set livingId2(param1:int) : void
      {
         hasField$1 |= 8;
         living_id2$field = param1;
      }
      
      public function get livingId2() : int
      {
         return living_id2$field;
      }
      
      public function removeFateSkillTempIds() : void
      {
         fate_skillTempIds$field = null;
      }
      
      public function get hasFateSkillTempIds() : Boolean
      {
         return fate_skillTempIds$field != null;
      }
      
      public function set fateSkillTempIds(param1:String) : void
      {
         fate_skillTempIds$field = param1;
      }
      
      public function get fateSkillTempIds() : String
      {
         return fate_skillTempIds$field;
      }
      
      public function removeIsChange() : void
      {
         hasField$1 &= 4294967279;
         is_change$field = new Boolean();
      }
      
      public function get hasIsChange() : Boolean
      {
         return (hasField$1 & 0x10) != 0;
      }
      
      public function set isChange(param1:Boolean) : void
      {
         hasField$1 |= 16;
         is_change$field = param1;
      }
      
      public function get isChange() : Boolean
      {
         return is_change$field;
      }
      
      public function removePetQuality() : void
      {
         hasField$1 &= 4294967263;
         pet_quality$field = new int();
      }
      
      public function get hasPetQuality() : Boolean
      {
         return (hasField$1 & 0x20) != 0;
      }
      
      public function set petQuality(param1:int) : void
      {
         hasField$1 |= 32;
         pet_quality$field = param1;
      }
      
      public function get petQuality() : int
      {
         return pet_quality$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$1 &= 4294967231;
         fight_capacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$1 & 0x40) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$1 |= 64;
         fight_capacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fight_capacity$field;
      }
      
      public function removeReduceResi() : void
      {
         hasField$1 &= 4294967167;
         reduce_resi$field = new int();
      }
      
      public function get hasReduceResi() : Boolean
      {
         return (hasField$1 & 0x80) != 0;
      }
      
      public function set reduceResi(param1:int) : void
      {
         hasField$1 |= 128;
         reduce_resi$field = param1;
      }
      
      public function get reduceResi() : int
      {
         return reduce_resi$field;
      }
      
      public function removeStrength() : void
      {
         hasField$1 &= 4294967039;
         strength$field = new int();
      }
      
      public function get hasStrength() : Boolean
      {
         return (hasField$1 & 0x0100) != 0;
      }
      
      public function set strength(param1:int) : void
      {
         hasField$1 |= 256;
         strength$field = param1;
      }
      
      public function get strength() : int
      {
         return strength$field;
      }
      
      public function removeTenacity() : void
      {
         hasField$1 &= 4294966783;
         tenacity$field = new int();
      }
      
      public function get hasTenacity() : Boolean
      {
         return (hasField$1 & 0x0200) != 0;
      }
      
      public function set tenacity(param1:int) : void
      {
         hasField$1 |= 512;
         tenacity$field = param1;
      }
      
      public function get tenacity() : int
      {
         return tenacity$field;
      }
      
      public function removeHasShadow() : void
      {
         hasField$1 &= 4294966271;
         has_shadow$field = new Boolean();
      }
      
      public function get hasHasShadow() : Boolean
      {
         return (hasField$1 & 0x0400) != 0;
      }
      
      public function set hasShadow(param1:Boolean) : void
      {
         hasField$1 |= 1024;
         has_shadow$field = param1;
      }
      
      public function get hasShadow() : Boolean
      {
         return has_shadow$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$1 &= 4294965247;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$1 & 0x0800) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$1 |= 2048;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      public function removeTransferGrade() : void
      {
         hasField$1 &= 4294963199;
         transfer_grade$field = new int();
      }
      
      public function get hasTransferGrade() : Boolean
      {
         return (hasField$1 & 0x1000) != 0;
      }
      
      public function set transferGrade(param1:int) : void
      {
         hasField$1 |= 4096;
         transfer_grade$field = param1;
      }
      
      public function get transferGrade() : int
      {
         return transfer_grade$field;
      }
      
      public function removeMateId() : void
      {
         hasField$1 &= 4294959103;
         mate_id$field = new int();
      }
      
      public function get hasMateId() : Boolean
      {
         return (hasField$1 & 0x2000) != 0;
      }
      
      public function set mateId(param1:int) : void
      {
         hasField$1 |= 8192;
         mate_id$field = param1;
      }
      
      public function get mateId() : int
      {
         return mate_id$field;
      }
      
      public function removeMateServerName() : void
      {
         mate_server_name$field = null;
      }
      
      public function get hasMateServerName() : Boolean
      {
         return mate_server_name$field != null;
      }
      
      public function set mateServerName(param1:String) : void
      {
         mate_server_name$field = param1;
      }
      
      public function get mateServerName() : String
      {
         return mate_server_name$field;
      }
      
      public function removeStunAttr() : void
      {
         hasField$1 &= 4294950911;
         stunAttr$field = new int();
      }
      
      public function get hasStunAttr() : Boolean
      {
         return (hasField$1 & 0x4000) != 0;
      }
      
      public function set stunAttr(param1:int) : void
      {
         hasField$1 |= 16384;
         stunAttr$field = param1;
      }
      
      public function get stunAttr() : int
      {
         return stunAttr$field;
      }
      
      public function removeIsFollow() : void
      {
         hasField$1 &= 4294934527;
         isFollow$field = new Boolean();
      }
      
      public function get hasIsFollow() : Boolean
      {
         return (hasField$1 & 0x8000) != 0;
      }
      
      public function set isFollow(param1:Boolean) : void
      {
         hasField$1 |= 32768;
         isFollow$field = param1;
      }
      
      public function get isFollow() : Boolean
      {
         return isFollow$field;
      }
      
      public function removeMultiLordsInspireLevel() : void
      {
         hasField$1 &= 4294901759;
         multiLordsInspireLevel$field = new int();
      }
      
      public function get hasMultiLordsInspireLevel() : Boolean
      {
         return (hasField$1 & 0x010000) != 0;
      }
      
      public function set multiLordsInspireLevel(param1:int) : void
      {
         hasField$1 |= 65536;
         multiLordsInspireLevel$field = param1;
      }
      
      public function get multiLordsInspireLevel() : int
      {
         return multiLordsInspireLevel$field;
      }
      
      public function removeSpMax() : void
      {
         hasField$1 &= 4294836223;
         spMax$field = new int();
      }
      
      public function get hasSpMax() : Boolean
      {
         return (hasField$1 & 0x020000) != 0;
      }
      
      public function set spMax(param1:int) : void
      {
         hasField$1 |= 131072;
         spMax$field = param1;
      }
      
      public function get spMax() : int
      {
         return spMax$field;
      }
      
      public function removeHitPoint() : void
      {
         hasField$1 &= 4294705151;
         hitPoint$field = new int();
      }
      
      public function get hasHitPoint() : Boolean
      {
         return (hasField$1 & 0x040000) != 0;
      }
      
      public function set hitPoint(param1:int) : void
      {
         hasField$1 |= 262144;
         hitPoint$field = param1;
      }
      
      public function get hitPoint() : int
      {
         return hitPoint$field;
      }
      
      public function removeHitPointMax() : void
      {
         hasField$1 &= 4294443007;
         hitPointMax$field = new int();
      }
      
      public function get hasHitPointMax() : Boolean
      {
         return (hasField$1 & 0x080000) != 0;
      }
      
      public function set hitPointMax(param1:int) : void
      {
         hasField$1 |= 524288;
         hitPointMax$field = param1;
      }
      
      public function get hitPointMax() : int
      {
         return hitPointMax$field;
      }
      
      public function removeSpLimit() : void
      {
         hasField$1 &= 4293918719;
         spLimit$field = new int();
      }
      
      public function get hasSpLimit() : Boolean
      {
         return (hasField$1 & 0x100000) != 0;
      }
      
      public function set spLimit(param1:int) : void
      {
         hasField$1 |= 1048576;
         spLimit$field = param1;
      }
      
      public function get spLimit() : int
      {
         return spLimit$field;
      }
      
      public function removeGrowthGrade() : void
      {
         hasField$1 &= 4292870143;
         growth_grade$field = new int();
      }
      
      public function get hasGrowthGrade() : Boolean
      {
         return (hasField$1 & 0x200000) != 0;
      }
      
      public function set growthGrade(param1:int) : void
      {
         hasField$1 |= 2097152;
         growth_grade$field = param1;
      }
      
      public function get growthGrade() : int
      {
         return growth_grade$field;
      }
      
      public function removeCurturn() : void
      {
         hasField$1 &= 4290772991;
         curturn$field = new int();
      }
      
      public function get hasCurturn() : Boolean
      {
         return (hasField$1 & 0x400000) != 0;
      }
      
      public function set curturn(param1:int) : void
      {
         hasField$1 |= 4194304;
         curturn$field = param1;
      }
      
      public function get curturn() : int
      {
         return curturn$field;
      }
      
      public function removeScuffleSequence() : void
      {
         hasField$1 &= 4286578687;
         scuffleSequence$field = new int();
      }
      
      public function get hasScuffleSequence() : Boolean
      {
         return (hasField$1 & 0x800000) != 0;
      }
      
      public function set scuffleSequence(param1:int) : void
      {
         hasField$1 |= 8388608;
         scuffleSequence$field = param1;
      }
      
      public function get scuffleSequence() : int
      {
         return scuffleSequence$field;
      }
      
      public function removeIsFight() : void
      {
         hasField$1 &= 4278190079;
         isFight$field = new Boolean();
      }
      
      public function get hasIsFight() : Boolean
      {
         return (hasField$1 & 0x01000000) != 0;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         hasField$1 |= 16777216;
         isFight$field = param1;
      }
      
      public function get isFight() : Boolean
      {
         return isFight$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$1 &= 4261412863;
         changeBranch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$1 & 0x02000000) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$1 |= 33554432;
         changeBranch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return changeBranch$field;
      }
      
      public function removeTitanInfo() : void
      {
         titanInfo$field = null;
      }
      
      public function get hasTitanInfo() : Boolean
      {
         return titanInfo$field != null;
      }
      
      public function set titanInfo(param1:TitanInfoMsg) : void
      {
         titanInfo$field = param1;
      }
      
      public function get titanInfo() : TitanInfoMsg
      {
         return titanInfo$field;
      }
      
      public function removeIsSlaveChild() : void
      {
         hasField$1 &= 4227858431;
         isSlaveChild$field = new Boolean();
      }
      
      public function get hasIsSlaveChild() : Boolean
      {
         return (hasField$1 & 0x04000000) != 0;
      }
      
      public function set isSlaveChild(param1:Boolean) : void
      {
         hasField$1 |= 67108864;
         isSlaveChild$field = param1;
      }
      
      public function get isSlaveChild() : Boolean
      {
         return isSlaveChild$field;
      }
      
      public function removeFollowChild() : void
      {
         hasField$1 &= 4160749567;
         followChild$field = new int();
      }
      
      public function get hasFollowChild() : Boolean
      {
         return (hasField$1 & 0x08000000) != 0;
      }
      
      public function set followChild(param1:int) : void
      {
         hasField$1 |= 134217728;
         followChild$field = param1;
      }
      
      public function get followChild() : int
      {
         return followChild$field;
      }
      
      public function removeRelicSkillId() : void
      {
         hasField$1 &= 4026531839;
         relicSkillId$field = new int();
      }
      
      public function get hasRelicSkillId() : Boolean
      {
         return (hasField$1 & 0x10000000) != 0;
      }
      
      public function set relicSkillId(param1:int) : void
      {
         hasField$1 |= 268435456;
         relicSkillId$field = param1;
      }
      
      public function get relicSkillId() : int
      {
         return relicSkillId$field;
      }
      
      public function removeAwakeBuffers() : void
      {
         awakeBuffers$field = null;
      }
      
      public function get hasAwakeBuffers() : Boolean
      {
         return awakeBuffers$field != null;
      }
      
      public function set awakeBuffers(param1:String) : void
      {
         awakeBuffers$field = param1;
      }
      
      public function get awakeBuffers() : String
      {
         return awakeBuffers$field;
      }
      
      public function removeAwakeSkillId() : void
      {
         hasField$1 &= 3758096383;
         awakeSkillId$field = new int();
      }
      
      public function get hasAwakeSkillId() : Boolean
      {
         return (hasField$1 & 0x20000000) != 0;
      }
      
      public function set awakeSkillId(param1:int) : void
      {
         hasField$1 |= 536870912;
         awakeSkillId$field = param1;
      }
      
      public function get awakeSkillId() : int
      {
         return awakeSkillId$field;
      }
      
      public function removeChildAwake() : void
      {
         hasField$1 &= 3221225471;
         childAwake$field = new int();
      }
      
      public function get hasChildAwake() : Boolean
      {
         return (hasField$1 & 0x40000000) != 0;
      }
      
      public function set childAwake(param1:int) : void
      {
         hasField$1 |= 1073741824;
         childAwake$field = param1;
      }
      
      public function get childAwake() : int
      {
         return childAwake$field;
      }
      
      public function removeIsManualChild() : void
      {
         hasField$1 &= 2147483647;
         isManualChild$field = new Boolean();
      }
      
      public function get hasIsManualChild() : Boolean
      {
         return (hasField$1 & 0x80000000) != 0;
      }
      
      public function set isManualChild(param1:Boolean) : void
      {
         hasField$1 |= 2147483648;
         isManualChild$field = param1;
      }
      
      public function get isManualChild() : Boolean
      {
         return isManualChild$field;
      }
      
      public function removeIsDragonTalker() : void
      {
         hasField$2 &= 4294967294;
         isDragonTalker$field = new Boolean();
      }
      
      public function get hasIsDragonTalker() : Boolean
      {
         return (hasField$2 & 1) != 0;
      }
      
      public function set isDragonTalker(param1:Boolean) : void
      {
         hasField$2 |= 1;
         isDragonTalker$field = param1;
      }
      
      public function get isDragonTalker() : Boolean
      {
         return isDragonTalker$field;
      }
      
      public function removeFightMount() : void
      {
         hasField$2 &= 4294967293;
         fightMount$field = new int();
      }
      
      public function get hasFightMount() : Boolean
      {
         return (hasField$2 & 2) != 0;
      }
      
      public function set fightMount(param1:int) : void
      {
         hasField$2 |= 2;
         fightMount$field = param1;
      }
      
      public function get fightMount() : int
      {
         return fightMount$field;
      }
      
      public function removeBelief() : void
      {
         hasField$2 &= 4294967291;
         belief$field = new int();
      }
      
      public function get hasBelief() : Boolean
      {
         return (hasField$2 & 4) != 0;
      }
      
      public function set belief(param1:int) : void
      {
         hasField$2 |= 4;
         belief$field = param1;
      }
      
      public function get belief() : int
      {
         return belief$field;
      }
      
      public function removeActionBelief() : void
      {
         hasField$2 &= 4294967287;
         action_belief$field = new int();
      }
      
      public function get hasActionBelief() : Boolean
      {
         return (hasField$2 & 8) != 0;
      }
      
      public function set actionBelief(param1:int) : void
      {
         hasField$2 |= 8;
         action_belief$field = param1;
      }
      
      public function get actionBelief() : int
      {
         return action_belief$field;
      }
      
      public function removeReplaceSkill() : void
      {
         replaceSkill$field = null;
      }
      
      public function get hasReplaceSkill() : Boolean
      {
         return replaceSkill$field != null;
      }
      
      public function set replaceSkill(param1:ReplaceSkillMsg) : void
      {
         replaceSkill$field = param1;
      }
      
      public function get replaceSkill() : ReplaceSkillMsg
      {
         return replaceSkill$field;
      }
      
      public function removeIsCaptain() : void
      {
         hasField$2 &= 4294967279;
         isCaptain$field = new Boolean();
      }
      
      public function get hasIsCaptain() : Boolean
      {
         return (hasField$2 & 0x10) != 0;
      }
      
      public function set isCaptain(param1:Boolean) : void
      {
         hasField$2 |= 16;
         isCaptain$field = param1;
      }
      
      public function get isCaptain() : Boolean
      {
         return isCaptain$field;
      }
      
      public function removeAvengerSp() : void
      {
         hasField$2 &= 4294967263;
         avengerSp$field = new int();
      }
      
      public function get hasAvengerSp() : Boolean
      {
         return (hasField$2 & 0x20) != 0;
      }
      
      public function set avengerSp(param1:int) : void
      {
         hasField$2 |= 32;
         avengerSp$field = param1;
      }
      
      public function get avengerSp() : int
      {
         return avengerSp$field;
      }
      
      public function removeAvengerCd() : void
      {
         hasField$2 &= 4294967231;
         avengerCd$field = new int();
      }
      
      public function get hasAvengerCd() : Boolean
      {
         return (hasField$2 & 0x40) != 0;
      }
      
      public function set avengerCd(param1:int) : void
      {
         hasField$2 |= 64;
         avengerCd$field = param1;
      }
      
      public function get avengerCd() : int
      {
         return avengerCd$field;
      }
      
      public function removeAvengerLeftCd() : void
      {
         hasField$2 &= 4294967167;
         avengerLeftCd$field = new int();
      }
      
      public function get hasAvengerLeftCd() : Boolean
      {
         return (hasField$2 & 0x80) != 0;
      }
      
      public function set avengerLeftCd(param1:int) : void
      {
         hasField$2 |= 128;
         avengerLeftCd$field = param1;
      }
      
      public function get avengerLeftCd() : int
      {
         return avengerLeftCd$field;
      }
      
      public function removeAvengerGrade() : void
      {
         hasField$2 &= 4294967039;
         avengerGrade$field = new int();
      }
      
      public function get hasAvengerGrade() : Boolean
      {
         return (hasField$2 & 0x0100) != 0;
      }
      
      public function set avengerGrade(param1:int) : void
      {
         hasField$2 |= 256;
         avengerGrade$field = param1;
      }
      
      public function get avengerGrade() : int
      {
         return avengerGrade$field;
      }
      
      public function removeReduceResiAgainst() : void
      {
         hasField$2 &= 4294966783;
         reduceResiAgainst$field = new int();
      }
      
      public function get hasReduceResiAgainst() : Boolean
      {
         return (hasField$2 & 0x0200) != 0;
      }
      
      public function set reduceResiAgainst(param1:int) : void
      {
         hasField$2 |= 512;
         reduceResiAgainst$field = param1;
      }
      
      public function get reduceResiAgainst() : int
      {
         return reduceResiAgainst$field;
      }
      
      public function removeResiPenetrate() : void
      {
         hasField$2 &= 4294966271;
         resiPenetrate$field = new int();
      }
      
      public function get hasResiPenetrate() : Boolean
      {
         return (hasField$2 & 0x0400) != 0;
      }
      
      public function set resiPenetrate(param1:int) : void
      {
         hasField$2 |= 1024;
         resiPenetrate$field = param1;
      }
      
      public function get resiPenetrate() : int
      {
         return resiPenetrate$field;
      }
      
      public function removeWarSoulSp() : void
      {
         hasField$2 &= 4294965247;
         warSoulSp$field = new int();
      }
      
      public function get hasWarSoulSp() : Boolean
      {
         return (hasField$2 & 0x0800) != 0;
      }
      
      public function set warSoulSp(param1:int) : void
      {
         hasField$2 |= 2048;
         warSoulSp$field = param1;
      }
      
      public function get warSoulSp() : int
      {
         return warSoulSp$field;
      }
      
      public function removeWarSoulType() : void
      {
         hasField$2 &= 4294963199;
         warSoulType$field = new int();
      }
      
      public function get hasWarSoulType() : Boolean
      {
         return (hasField$2 & 0x1000) != 0;
      }
      
      public function set warSoulType(param1:int) : void
      {
         hasField$2 |= 4096;
         warSoulType$field = param1;
      }
      
      public function get warSoulType() : int
      {
         return warSoulType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc11_:* = 0;
         var _loc14_:* = 0;
         var _loc12_:* = 0;
         var _loc6_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc13_:* = 0;
         var _loc9_:* = 0;
         var _loc7_:* = 0;
         var _loc10_:* = 0;
         var _loc8_:* = 0;
         if(hasHeroId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,hero_id$field);
         }
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasUserPics)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,user_pics$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,temp_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasMaxHp)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT64(param1,max_hp$field);
         }
         if(hasInitHp)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT64(param1,init_hp$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT64(param1,hp$field);
         }
         if(hasInitHp2)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT64(param1,init_hp2$field);
         }
         if(hasHp2)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT64(param1,hp2$field);
         }
         if(hasSp)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,sp$field);
         }
         if(hasSlotAvata)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,slot_avata$field);
         }
         if(hasClothAvate)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,cloth_avate$field);
         }
         if(hasCloakPath)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,cloak_path$field);
         }
         if(hasHairPath)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_STRING(param1,hair_path$field);
         }
         if(hasCaptain)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,captain$field);
         }
         if(hasRes)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_STRING(param1,res$field);
         }
         if(hasQteTime)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,qte_time$field);
         }
         if(hasCastTime)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,cast_time$field);
         }
         if(hasPics)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,pics$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasPhyAttack)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,phy_attack$field);
         }
         if(hasPhyDefence)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,phy_defence$field);
         }
         if(hasMagAttack)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,mag_attack$field);
         }
         if(hasMagDefence)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,mag_defence$field);
         }
         if(hasForceHit)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,force_hit$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasSites)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_INT32(param1,sites$field);
         }
         if(hasSkillScript)
         {
            WriteUtils.writeTag(param1,2,34);
            WriteUtils.write$TYPE_STRING(param1,skill_script$field);
         }
         if(hasPawnTempId)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,pawn_temp_id$field);
         }
         _loc3_ = 0;
         while(_loc3_ < skillId.length)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,skillId[_loc3_]);
            _loc3_++;
         }
         if(hasAttackWound)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_INT64(param1,attack_wound$field);
         }
         if(hasHitWound)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_INT64(param1,hit_wound$field);
         }
         if(hasAttackModel)
         {
            WriteUtils.writeTag(param1,0,39);
            WriteUtils.write$TYPE_INT32(param1,attack_model$field);
         }
         _loc5_ = 0;
         while(_loc5_ < starBuffer.length)
         {
            WriteUtils.writeTag(param1,2,40);
            WriteUtils.write$TYPE_MESSAGE(param1,starBuffer[_loc5_]);
            _loc5_++;
         }
         _loc11_ = 0;
         while(_loc11_ < item.length)
         {
            WriteUtils.writeTag(param1,2,41);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc11_]);
            _loc11_++;
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,42);
            WriteUtils.write$TYPE_INT32(param1,head_id$field);
         }
         _loc14_ = 0;
         while(_loc14_ < buffers.length)
         {
            WriteUtils.writeTag(param1,2,43);
            WriteUtils.write$TYPE_MESSAGE(param1,buffers[_loc14_]);
            _loc14_++;
         }
         if(hasIsShow)
         {
            WriteUtils.writeTag(param1,0,44);
            WriteUtils.write$TYPE_BOOL(param1,is_show$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,45);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasWingAvata)
         {
            WriteUtils.writeTag(param1,2,46);
            WriteUtils.write$TYPE_STRING(param1,wing_avata$field);
         }
         _loc12_ = 0;
         while(_loc12_ < trials.length)
         {
            WriteUtils.writeTag(param1,2,47);
            WriteUtils.write$TYPE_MESSAGE(param1,trials[_loc12_]);
            _loc12_++;
         }
         _loc6_ = 0;
         while(_loc6_ < battleDrop.length)
         {
            WriteUtils.writeTag(param1,2,48);
            WriteUtils.write$TYPE_MESSAGE(param1,battleDrop[_loc6_]);
            _loc6_++;
         }
         if(hasHatAvata)
         {
            WriteUtils.writeTag(param1,2,49);
            WriteUtils.write$TYPE_STRING(param1,hat_avata$field);
         }
         if(hasFashionArmAvata)
         {
            WriteUtils.writeTag(param1,2,50);
            WriteUtils.write$TYPE_STRING(param1,fashion_arm_avata$field);
         }
         if(hasFashionClothAvata)
         {
            WriteUtils.writeTag(param1,2,51);
            WriteUtils.write$TYPE_STRING(param1,fashion_cloth_avata$field);
         }
         if(hasHide)
         {
            WriteUtils.writeTag(param1,0,52);
            WriteUtils.write$TYPE_BOOL(param1,hide$field);
         }
         if(hasAppellId)
         {
            WriteUtils.writeTag(param1,0,53);
            WriteUtils.write$TYPE_INT32(param1,appell_id$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,54);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,55);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,56);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,57);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,58);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,59);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
         if(hasFollowSkills)
         {
            WriteUtils.writeTag(param1,2,60);
            WriteUtils.write$TYPE_STRING(param1,followSkills$field);
         }
         if(hasChangeSkills)
         {
            WriteUtils.writeTag(param1,2,61);
            WriteUtils.write$TYPE_STRING(param1,changeSkills$field);
         }
         if(hasDefaultSkills)
         {
            WriteUtils.writeTag(param1,2,62);
            WriteUtils.write$TYPE_STRING(param1,defaultSkills$field);
         }
         if(hasAwake)
         {
            WriteUtils.writeTag(param1,0,63);
            WriteUtils.write$TYPE_INT32(param1,awake$field);
         }
         if(hasLivingId2)
         {
            WriteUtils.writeTag(param1,0,64);
            WriteUtils.write$TYPE_INT32(param1,living_id2$field);
         }
         _loc2_ = 0;
         while(_loc2_ < changeSkillId.length)
         {
            WriteUtils.writeTag(param1,0,65);
            WriteUtils.write$TYPE_INT32(param1,changeSkillId[_loc2_]);
            _loc2_++;
         }
         if(hasFateSkillTempIds)
         {
            WriteUtils.writeTag(param1,2,66);
            WriteUtils.write$TYPE_STRING(param1,fate_skillTempIds$field);
         }
         if(hasIsChange)
         {
            WriteUtils.writeTag(param1,0,67);
            WriteUtils.write$TYPE_BOOL(param1,is_change$field);
         }
         if(hasPetQuality)
         {
            WriteUtils.writeTag(param1,0,68);
            WriteUtils.write$TYPE_INT32(param1,pet_quality$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,69);
            WriteUtils.write$TYPE_INT32(param1,fight_capacity$field);
         }
         if(hasReduceResi)
         {
            WriteUtils.writeTag(param1,0,70);
            WriteUtils.write$TYPE_INT32(param1,reduce_resi$field);
         }
         if(hasStrength)
         {
            WriteUtils.writeTag(param1,0,71);
            WriteUtils.write$TYPE_INT32(param1,strength$field);
         }
         if(hasTenacity)
         {
            WriteUtils.writeTag(param1,0,72);
            WriteUtils.write$TYPE_INT32(param1,tenacity$field);
         }
         if(hasHasShadow)
         {
            WriteUtils.writeTag(param1,0,73);
            WriteUtils.write$TYPE_BOOL(param1,has_shadow$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,74);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasTransferGrade)
         {
            WriteUtils.writeTag(param1,0,75);
            WriteUtils.write$TYPE_INT32(param1,transfer_grade$field);
         }
         _loc4_ = 0;
         while(_loc4_ < marriageSkills.length)
         {
            WriteUtils.writeTag(param1,0,76);
            WriteUtils.write$TYPE_INT32(param1,marriageSkills[_loc4_]);
            _loc4_++;
         }
         if(hasMateId)
         {
            WriteUtils.writeTag(param1,0,77);
            WriteUtils.write$TYPE_INT32(param1,mate_id$field);
         }
         _loc13_ = 0;
         while(_loc13_ < marSkills.length)
         {
            WriteUtils.writeTag(param1,2,78);
            WriteUtils.write$TYPE_MESSAGE(param1,marSkills[_loc13_]);
            _loc13_++;
         }
         if(hasMateServerName)
         {
            WriteUtils.writeTag(param1,2,79);
            WriteUtils.write$TYPE_STRING(param1,mate_server_name$field);
         }
         if(hasStunAttr)
         {
            WriteUtils.writeTag(param1,0,80);
            WriteUtils.write$TYPE_INT32(param1,stunAttr$field);
         }
         if(hasIsFollow)
         {
            WriteUtils.writeTag(param1,0,81);
            WriteUtils.write$TYPE_BOOL(param1,isFollow$field);
         }
         if(hasMultiLordsInspireLevel)
         {
            WriteUtils.writeTag(param1,0,82);
            WriteUtils.write$TYPE_INT32(param1,multiLordsInspireLevel$field);
         }
         if(hasSpMax)
         {
            WriteUtils.writeTag(param1,0,83);
            WriteUtils.write$TYPE_INT32(param1,spMax$field);
         }
         if(hasHitPoint)
         {
            WriteUtils.writeTag(param1,0,84);
            WriteUtils.write$TYPE_INT32(param1,hitPoint$field);
         }
         if(hasHitPointMax)
         {
            WriteUtils.writeTag(param1,0,85);
            WriteUtils.write$TYPE_INT32(param1,hitPointMax$field);
         }
         if(hasSpLimit)
         {
            WriteUtils.writeTag(param1,0,86);
            WriteUtils.write$TYPE_INT32(param1,spLimit$field);
         }
         if(hasGrowthGrade)
         {
            WriteUtils.writeTag(param1,0,87);
            WriteUtils.write$TYPE_INT32(param1,growth_grade$field);
         }
         if(hasCurturn)
         {
            WriteUtils.writeTag(param1,0,88);
            WriteUtils.write$TYPE_INT32(param1,curturn$field);
         }
         if(hasScuffleSequence)
         {
            WriteUtils.writeTag(param1,0,89);
            WriteUtils.write$TYPE_INT32(param1,scuffleSequence$field);
         }
         if(hasIsFight)
         {
            WriteUtils.writeTag(param1,0,90);
            WriteUtils.write$TYPE_BOOL(param1,isFight$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,91);
            WriteUtils.write$TYPE_INT32(param1,changeBranch$field);
         }
         if(hasTitanInfo)
         {
            WriteUtils.writeTag(param1,2,92);
            WriteUtils.write$TYPE_MESSAGE(param1,titanInfo$field);
         }
         if(hasIsSlaveChild)
         {
            WriteUtils.writeTag(param1,0,93);
            WriteUtils.write$TYPE_BOOL(param1,isSlaveChild$field);
         }
         if(hasFollowChild)
         {
            WriteUtils.writeTag(param1,0,94);
            WriteUtils.write$TYPE_INT32(param1,followChild$field);
         }
         if(hasRelicSkillId)
         {
            WriteUtils.writeTag(param1,0,95);
            WriteUtils.write$TYPE_INT32(param1,relicSkillId$field);
         }
         if(hasAwakeBuffers)
         {
            WriteUtils.writeTag(param1,2,96);
            WriteUtils.write$TYPE_STRING(param1,awakeBuffers$field);
         }
         if(hasAwakeSkillId)
         {
            WriteUtils.writeTag(param1,0,97);
            WriteUtils.write$TYPE_INT32(param1,awakeSkillId$field);
         }
         if(hasChildAwake)
         {
            WriteUtils.writeTag(param1,0,98);
            WriteUtils.write$TYPE_INT32(param1,childAwake$field);
         }
         if(hasIsManualChild)
         {
            WriteUtils.writeTag(param1,0,99);
            WriteUtils.write$TYPE_BOOL(param1,isManualChild$field);
         }
         if(hasIsDragonTalker)
         {
            WriteUtils.writeTag(param1,0,100);
            WriteUtils.write$TYPE_BOOL(param1,isDragonTalker$field);
         }
         if(hasFightMount)
         {
            WriteUtils.writeTag(param1,0,101);
            WriteUtils.write$TYPE_INT32(param1,fightMount$field);
         }
         if(hasBelief)
         {
            WriteUtils.writeTag(param1,0,102);
            WriteUtils.write$TYPE_INT32(param1,belief$field);
         }
         if(hasActionBelief)
         {
            WriteUtils.writeTag(param1,0,103);
            WriteUtils.write$TYPE_INT32(param1,action_belief$field);
         }
         if(hasReplaceSkill)
         {
            WriteUtils.writeTag(param1,2,104);
            WriteUtils.write$TYPE_MESSAGE(param1,replaceSkill$field);
         }
         if(hasIsCaptain)
         {
            WriteUtils.writeTag(param1,0,105);
            WriteUtils.write$TYPE_BOOL(param1,isCaptain$field);
         }
         if(hasAvengerSp)
         {
            WriteUtils.writeTag(param1,0,106);
            WriteUtils.write$TYPE_INT32(param1,avengerSp$field);
         }
         if(hasAvengerCd)
         {
            WriteUtils.writeTag(param1,0,107);
            WriteUtils.write$TYPE_INT32(param1,avengerCd$field);
         }
         if(hasAvengerLeftCd)
         {
            WriteUtils.writeTag(param1,0,108);
            WriteUtils.write$TYPE_INT32(param1,avengerLeftCd$field);
         }
         _loc9_ = 0;
         while(_loc9_ < avengerSkills.length)
         {
            WriteUtils.writeTag(param1,0,109);
            WriteUtils.write$TYPE_INT32(param1,avengerSkills[_loc9_]);
            _loc9_++;
         }
         _loc7_ = 0;
         while(_loc7_ < avengerAllSkills.length)
         {
            WriteUtils.writeTag(param1,0,110);
            WriteUtils.write$TYPE_INT32(param1,avengerAllSkills[_loc7_]);
            _loc7_++;
         }
         if(hasAvengerGrade)
         {
            WriteUtils.writeTag(param1,0,111);
            WriteUtils.write$TYPE_INT32(param1,avengerGrade$field);
         }
         if(hasReduceResiAgainst)
         {
            WriteUtils.writeTag(param1,0,112);
            WriteUtils.write$TYPE_INT32(param1,reduceResiAgainst$field);
         }
         if(hasResiPenetrate)
         {
            WriteUtils.writeTag(param1,0,113);
            WriteUtils.write$TYPE_INT32(param1,resiPenetrate$field);
         }
         _loc10_ = 0;
         while(_loc10_ < warSoulSkills.length)
         {
            WriteUtils.writeTag(param1,0,114);
            WriteUtils.write$TYPE_INT32(param1,warSoulSkills[_loc10_]);
            _loc10_++;
         }
         if(hasWarSoulSp)
         {
            WriteUtils.writeTag(param1,0,115);
            WriteUtils.write$TYPE_INT32(param1,warSoulSp$field);
         }
         if(hasWarSoulType)
         {
            WriteUtils.writeTag(param1,0,116);
            WriteUtils.write$TYPE_INT32(param1,warSoulType$field);
         }
         _loc8_ = 0;
         while(_loc8_ < addSkills.length)
         {
            WriteUtils.writeTag(param1,0,117);
            WriteUtils.write$TYPE_INT32(param1,addSkills[_loc8_]);
            _loc8_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc76_:* = 0;
         var _loc31_:StarBufferMsg = null;
         var _loc42_:BattleItemMsg = null;
         var _loc12_:BufferMsg = null;
         var _loc96_:TrialInfoMsg = null;
         var _loc43_:BaseItemMsg = null;
         var _loc61_:TrialInfoMsg = null;
         var _loc23_:uint = 0;
         var _loc62_:uint = 0;
         var _loc49_:uint = 0;
         var _loc73_:uint = 0;
         var _loc105_:uint = 0;
         var _loc21_:uint = 0;
         var _loc40_:uint = 0;
         var _loc64_:uint = 0;
         var _loc57_:uint = 0;
         var _loc80_:uint = 0;
         var _loc65_:uint = 0;
         var _loc8_:uint = 0;
         var _loc35_:uint = 0;
         var _loc91_:uint = 0;
         var _loc45_:uint = 0;
         var _loc113_:uint = 0;
         var _loc59_:uint = 0;
         var _loc16_:uint = 0;
         var _loc3_:uint = 0;
         var _loc95_:uint = 0;
         var _loc7_:uint = 0;
         var _loc97_:uint = 0;
         var _loc52_:uint = 0;
         var _loc33_:uint = 0;
         var _loc13_:uint = 0;
         var _loc48_:uint = 0;
         var _loc41_:uint = 0;
         var _loc18_:uint = 0;
         var _loc88_:uint = 0;
         var _loc37_:uint = 0;
         var _loc90_:uint = 0;
         var _loc75_:uint = 0;
         var _loc38_:uint = 0;
         var _loc19_:uint = 0;
         var _loc72_:uint = 0;
         var _loc101_:uint = 0;
         var _loc6_:uint = 0;
         var _loc82_:uint = 0;
         var _loc81_:uint = 0;
         var _loc22_:uint = 0;
         var _loc68_:uint = 0;
         var _loc32_:uint = 0;
         var _loc4_:uint = 0;
         var _loc60_:uint = 0;
         var _loc112_:uint = 0;
         var _loc102_:uint = 0;
         var _loc70_:uint = 0;
         var _loc103_:uint = 0;
         var _loc54_:uint = 0;
         var _loc36_:uint = 0;
         var _loc25_:uint = 0;
         var _loc77_:uint = 0;
         var _loc11_:uint = 0;
         var _loc98_:uint = 0;
         var _loc53_:uint = 0;
         var _loc110_:uint = 0;
         var _loc108_:uint = 0;
         var _loc79_:uint = 0;
         var _loc56_:uint = 0;
         var _loc67_:uint = 0;
         var _loc44_:uint = 0;
         var _loc63_:uint = 0;
         var _loc83_:uint = 0;
         var _loc111_:uint = 0;
         var _loc104_:uint = 0;
         var _loc87_:uint = 0;
         var _loc93_:uint = 0;
         var _loc10_:uint = 0;
         var _loc34_:uint = 0;
         var _loc24_:uint = 0;
         var _loc29_:uint = 0;
         var _loc69_:uint = 0;
         var _loc20_:uint = 0;
         var _loc30_:uint = 0;
         var _loc66_:uint = 0;
         var _loc15_:uint = 0;
         var _loc92_:uint = 0;
         var _loc46_:uint = 0;
         var _loc99_:uint = 0;
         var _loc9_:uint = 0;
         var _loc55_:uint = 0;
         var _loc17_:uint = 0;
         var _loc71_:uint = 0;
         var _loc28_:uint = 0;
         var _loc27_:uint = 0;
         var _loc100_:uint = 0;
         var _loc5_:uint = 0;
         var _loc51_:uint = 0;
         var _loc26_:uint = 0;
         var _loc14_:uint = 0;
         var _loc94_:uint = 0;
         var _loc84_:uint = 0;
         var _loc89_:uint = 0;
         var _loc58_:uint = 0;
         var _loc107_:uint = 0;
         var _loc50_:uint = 0;
         var _loc85_:uint = 0;
         var _loc106_:uint = 0;
         var _loc74_:uint = 0;
         var _loc47_:uint = 0;
         var _loc78_:uint = 0;
         var _loc109_:uint = 0;
         var _loc39_:uint = 0;
         var _loc86_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc76_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.heroId cannot be set twice.");
                  }
                  _loc23_++;
                  heroId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc62_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.livingId cannot be set twice.");
                  }
                  _loc62_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc49_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.userId cannot be set twice.");
                  }
                  _loc49_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc73_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.userPics cannot be set twice.");
                  }
                  _loc73_++;
                  userPics = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc105_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.tempId cannot be set twice.");
                  }
                  _loc105_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.type cannot be set twice.");
                  }
                  _loc21_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.nickName cannot be set twice.");
                  }
                  _loc40_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc64_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.grade cannot be set twice.");
                  }
                  _loc64_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc57_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.side cannot be set twice.");
                  }
                  _loc57_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc80_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.pos cannot be set twice.");
                  }
                  _loc80_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc65_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.maxHp cannot be set twice.");
                  }
                  _loc65_++;
                  maxHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 12:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.initHp cannot be set twice.");
                  }
                  _loc8_++;
                  initHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 13:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.hp cannot be set twice.");
                  }
                  _loc35_++;
                  hp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 14:
                  if(_loc91_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.initHp2 cannot be set twice.");
                  }
                  _loc91_++;
                  initHp2 = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 15:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.hp2 cannot be set twice.");
                  }
                  _loc45_++;
                  hp2 = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 16:
                  if(_loc113_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.sp cannot be set twice.");
                  }
                  _loc113_++;
                  sp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc59_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.slotAvata cannot be set twice.");
                  }
                  _loc59_++;
                  slotAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 18:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.clothAvate cannot be set twice.");
                  }
                  _loc16_++;
                  clothAvate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 19:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.cloakPath cannot be set twice.");
                  }
                  _loc3_++;
                  cloakPath = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 20:
                  if(_loc95_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.hairPath cannot be set twice.");
                  }
                  _loc95_++;
                  hairPath = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 21:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.captain cannot be set twice.");
                  }
                  _loc7_++;
                  captain = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc97_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.res cannot be set twice.");
                  }
                  _loc97_++;
                  res = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 23:
                  if(_loc52_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.qteTime cannot be set twice.");
                  }
                  _loc52_++;
                  qteTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.castTime cannot be set twice.");
                  }
                  _loc33_++;
                  castTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.pics cannot be set twice.");
                  }
                  _loc13_++;
                  pics = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc48_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.job cannot be set twice.");
                  }
                  _loc48_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.phyAttack cannot be set twice.");
                  }
                  _loc41_++;
                  phyAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.phyDefence cannot be set twice.");
                  }
                  _loc18_++;
                  phyDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc88_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.magAttack cannot be set twice.");
                  }
                  _loc88_++;
                  magAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.magDefence cannot be set twice.");
                  }
                  _loc37_++;
                  magDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc90_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.forceHit cannot be set twice.");
                  }
                  _loc90_++;
                  forceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 32:
                  if(_loc75_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.parry cannot be set twice.");
                  }
                  _loc75_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 33:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.sites cannot be set twice.");
                  }
                  _loc38_++;
                  sites = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 34:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.skillScript cannot be set twice.");
                  }
                  _loc19_++;
                  skillScript = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 35:
                  if(_loc72_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.pawnTempId cannot be set twice.");
                  }
                  _loc72_++;
                  pawnTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 36:
                  if((_loc76_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,skillId);
                  }
                  else
                  {
                     skillId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 37:
                  if(_loc101_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.attackWound cannot be set twice.");
                  }
                  _loc101_++;
                  attackWound = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 38:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.hitWound cannot be set twice.");
                  }
                  _loc6_++;
                  hitWound = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 39:
                  if(_loc82_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.attackModel cannot be set twice.");
                  }
                  _loc82_++;
                  attackModel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 40:
                  _loc31_ = new StarBufferMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc31_);
                  starBuffer.push(_loc31_);
                  break;
               case 41:
                  _loc42_ = new BattleItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc42_);
                  item.push(_loc42_);
                  break;
               case 42:
                  if(_loc81_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.headId cannot be set twice.");
                  }
                  _loc81_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 43:
                  _loc12_ = new BufferMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc12_);
                  buffers.push(_loc12_);
                  break;
               case 44:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.isShow cannot be set twice.");
                  }
                  _loc22_++;
                  isShow = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 45:
                  if(_loc68_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.serverName cannot be set twice.");
                  }
                  _loc68_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 46:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.wingAvata cannot be set twice.");
                  }
                  _loc32_++;
                  wingAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 47:
                  _loc96_ = new TrialInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc96_);
                  trials.push(_loc96_);
                  break;
               case 48:
                  _loc43_ = new BaseItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc43_);
                  battleDrop.push(_loc43_);
                  break;
               case 49:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.hatAvata cannot be set twice.");
                  }
                  _loc4_++;
                  hatAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 50:
                  if(_loc60_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.fashionArmAvata cannot be set twice.");
                  }
                  _loc60_++;
                  fashionArmAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 51:
                  if(_loc112_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.fashionClothAvata cannot be set twice.");
                  }
                  _loc112_++;
                  fashionClothAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 52:
                  if(_loc102_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.hide cannot be set twice.");
                  }
                  _loc102_++;
                  hide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 53:
                  if(_loc70_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.appellId cannot be set twice.");
                  }
                  _loc70_++;
                  appellId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 54:
                  if(_loc103_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.fireResi cannot be set twice.");
                  }
                  _loc103_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 55:
                  if(_loc54_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.waterResi cannot be set twice.");
                  }
                  _loc54_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 56:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.electResi cannot be set twice.");
                  }
                  _loc36_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 57:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.windResi cannot be set twice.");
                  }
                  _loc25_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 58:
                  if(_loc77_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.darkResi cannot be set twice.");
                  }
                  _loc77_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 59:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.lightResi cannot be set twice.");
                  }
                  _loc11_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 60:
                  if(_loc98_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.followSkills cannot be set twice.");
                  }
                  _loc98_++;
                  followSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 61:
                  if(_loc53_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.changeSkills cannot be set twice.");
                  }
                  _loc53_++;
                  changeSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 62:
                  if(_loc110_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.defaultSkills cannot be set twice.");
                  }
                  _loc110_++;
                  defaultSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 63:
                  if(_loc108_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.awake cannot be set twice.");
                  }
                  _loc108_++;
                  awake = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 64:
                  if(_loc79_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.livingId2 cannot be set twice.");
                  }
                  _loc79_++;
                  livingId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 65:
                  if((_loc76_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,changeSkillId);
                  }
                  else
                  {
                     changeSkillId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 66:
                  if(_loc56_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.fateSkillTempIds cannot be set twice.");
                  }
                  _loc56_++;
                  fateSkillTempIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 67:
                  if(_loc67_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.isChange cannot be set twice.");
                  }
                  _loc67_++;
                  isChange = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 68:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.petQuality cannot be set twice.");
                  }
                  _loc44_++;
                  petQuality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 69:
                  if(_loc63_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.fightCapacity cannot be set twice.");
                  }
                  _loc63_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 70:
                  if(_loc83_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.reduceResi cannot be set twice.");
                  }
                  _loc83_++;
                  reduceResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 71:
                  if(_loc111_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.strength cannot be set twice.");
                  }
                  _loc111_++;
                  strength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 72:
                  if(_loc104_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.tenacity cannot be set twice.");
                  }
                  _loc104_++;
                  tenacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 73:
                  if(_loc87_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.hasShadow cannot be set twice.");
                  }
                  _loc87_++;
                  hasShadow = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 74:
                  if(_loc93_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.penetrate cannot be set twice.");
                  }
                  _loc93_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 75:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.transferGrade cannot be set twice.");
                  }
                  _loc10_++;
                  transferGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 76:
                  if((_loc76_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,marriageSkills);
                  }
                  else
                  {
                     marriageSkills.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 77:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.mateId cannot be set twice.");
                  }
                  _loc34_++;
                  mateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 78:
                  _loc61_ = new TrialInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc61_);
                  marSkills.push(_loc61_);
                  break;
               case 79:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.mateServerName cannot be set twice.");
                  }
                  _loc24_++;
                  mateServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 80:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.stunAttr cannot be set twice.");
                  }
                  _loc29_++;
                  stunAttr = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 81:
                  if(_loc69_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.isFollow cannot be set twice.");
                  }
                  _loc69_++;
                  isFollow = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 82:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.multiLordsInspireLevel cannot be set twice.");
                  }
                  _loc20_++;
                  multiLordsInspireLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 83:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.spMax cannot be set twice.");
                  }
                  _loc30_++;
                  spMax = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 84:
                  if(_loc66_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.hitPoint cannot be set twice.");
                  }
                  _loc66_++;
                  hitPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 85:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.hitPointMax cannot be set twice.");
                  }
                  _loc15_++;
                  hitPointMax = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 86:
                  if(_loc92_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.spLimit cannot be set twice.");
                  }
                  _loc92_++;
                  spLimit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 87:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.growthGrade cannot be set twice.");
                  }
                  _loc46_++;
                  growthGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 88:
                  if(_loc99_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.curturn cannot be set twice.");
                  }
                  _loc99_++;
                  curturn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 89:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.scuffleSequence cannot be set twice.");
                  }
                  _loc9_++;
                  scuffleSequence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 90:
                  if(_loc55_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.isFight cannot be set twice.");
                  }
                  _loc55_++;
                  isFight = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 91:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.changeBranch cannot be set twice.");
                  }
                  _loc17_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 92:
                  if(_loc71_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.titanInfo cannot be set twice.");
                  }
                  _loc71_++;
                  titanInfo = new TitanInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,titanInfo);
                  break;
               case 93:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.isSlaveChild cannot be set twice.");
                  }
                  _loc28_++;
                  isSlaveChild = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 94:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.followChild cannot be set twice.");
                  }
                  _loc27_++;
                  followChild = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 95:
                  if(_loc100_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.relicSkillId cannot be set twice.");
                  }
                  _loc100_++;
                  relicSkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 96:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.awakeBuffers cannot be set twice.");
                  }
                  _loc5_++;
                  awakeBuffers = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 97:
                  if(_loc51_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.awakeSkillId cannot be set twice.");
                  }
                  _loc51_++;
                  awakeSkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 98:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.childAwake cannot be set twice.");
                  }
                  _loc26_++;
                  childAwake = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 99:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.isManualChild cannot be set twice.");
                  }
                  _loc14_++;
                  isManualChild = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 100:
                  if(_loc94_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.isDragonTalker cannot be set twice.");
                  }
                  _loc94_++;
                  isDragonTalker = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 101:
                  if(_loc84_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.fightMount cannot be set twice.");
                  }
                  _loc84_++;
                  fightMount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 102:
                  if(_loc89_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.belief cannot be set twice.");
                  }
                  _loc89_++;
                  belief = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 103:
                  if(_loc58_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.actionBelief cannot be set twice.");
                  }
                  _loc58_++;
                  actionBelief = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 104:
                  if(_loc107_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.replaceSkill cannot be set twice.");
                  }
                  _loc107_++;
                  replaceSkill = new ReplaceSkillMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,replaceSkill);
                  break;
               case 105:
                  if(_loc50_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.isCaptain cannot be set twice.");
                  }
                  _loc50_++;
                  isCaptain = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 106:
                  if(_loc85_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.avengerSp cannot be set twice.");
                  }
                  _loc85_++;
                  avengerSp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 107:
                  if(_loc106_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.avengerCd cannot be set twice.");
                  }
                  _loc106_++;
                  avengerCd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 108:
                  if(_loc74_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.avengerLeftCd cannot be set twice.");
                  }
                  _loc74_++;
                  avengerLeftCd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 109:
                  if((_loc76_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,avengerSkills);
                  }
                  else
                  {
                     avengerSkills.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 110:
                  if((_loc76_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,avengerAllSkills);
                  }
                  else
                  {
                     avengerAllSkills.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 111:
                  if(_loc47_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.avengerGrade cannot be set twice.");
                  }
                  _loc47_++;
                  avengerGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 112:
                  if(_loc78_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.reduceResiAgainst cannot be set twice.");
                  }
                  _loc78_++;
                  reduceResiAgainst = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 113:
                  if(_loc109_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.resiPenetrate cannot be set twice.");
                  }
                  _loc109_++;
                  resiPenetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 114:
                  if((_loc76_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,warSoulSkills);
                  }
                  else
                  {
                     warSoulSkills.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 115:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.warSoulSp cannot be set twice.");
                  }
                  _loc39_++;
                  warSoulSp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 116:
                  if(_loc86_ != 0)
                  {
                     throw new IOError("Bad data format: HeroMsg.warSoulType cannot be set twice.");
                  }
                  _loc86_++;
                  warSoulType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 117:
                  if((_loc76_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,addSkills);
                  }
                  else
                  {
                     addSkills.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc76_ & 7);
            }
         }
      }
   }
}

