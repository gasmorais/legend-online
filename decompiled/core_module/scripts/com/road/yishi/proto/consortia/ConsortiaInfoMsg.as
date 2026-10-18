package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaInfoMsg extends Message implements IExternalizable
   {
      
      private var consortia_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var creator_id$field:int;
      
      private var chairman_id$field:int;
      
      private var levels$field:int;
      
      private var add_count$field:int;
      
      private var current_count$field:int;
      
      private var kick_count$field:int;
      
      private var shop_level$field:int;
      
      private var store_level$field:int;
      
      private var altar_level$field:int;
      
      private var school_level$field:int;
      
      private var attack_level$field:int;
      
      private var defence_level$field:int;
      
      private var agility_level$field:int;
      
      private var ability_level$field:int;
      
      private var captain_level$field:int;
      
      private var gold_level$field:int;
      
      private var fight_power$field:Int64;
      
      private var own_wildlands$field:int;
      
      private var offer$field:int;
      
      private var honor$field:int;
      
      private var bless_temp_id$field:int;
      
      private var bless_count$field:int;
      
      private var code_type$field:int;
      
      private var total_offer$field:int;
      
      private var op$field:int;
      
      private var placard$field:String;
      
      private var description$field:String;
      
      private var consortia_name$field:String;
      
      private var creator_name$field:String;
      
      private var chairman_name$field:String;
      
      private var renames$field:String;
      
      private var quit_result$field:String;
      
      private var open_app$field:Boolean;
      
      private var is_exist$field:Boolean;
      
      private var create_date$field:String;
      
      private var kick_date$field:String;
      
      private var deduct_date$field:String;
      
      private var warn_date$field:String;
      
      private var quit_date$field:String;
      
      private var code_begin_date$field:String;
      
      private var current_date$field:String;
      
      private var code_need_date$field:int;
      
      private var orderInfo$field:ConsortiaOrderInfoMsg;
      
      private var physique_level$field:int;
      
      private var is_robot$field:Boolean;
      
      [ArrayElementType("int")]
      public var site:Array = [];
      
      private var speak_times$field:int;
      
      private var votingDate$field:String;
      
      private var votingStatic$field:int;
      
      private var votingId$field:int;
      
      private var hasField$1:uint = 0;
      
      private var activeData$field:int;
      
      private var group_placard$field:String;
      
      private var altar_date$field:String;
      
      private var altar_state$field:int;
      
      private var max_mave$field:int;
      
      private var new_power_lv$field:int;
      
      private var new_agility_lv$field:int;
      
      private var new_intellect_lv$field:int;
      
      private var new_physique_lv$field:int;
      
      private var fam_gp_lv$field:int;
      
      private var medal_lv$field:int;
      
      private var honor_lv$field:int;
      
      private var score_lv$field:int;
      
      private var boss_info$field:ConsortiaBossMsg;
      
      private var storage_expire_time1$field:String;
      
      private var storage_expire_time2$field:String;
      
      private var is_storage_expire1$field:Boolean;
      
      private var is_storage_expire2$field:Boolean;
      
      private var consortia_active_point$field:int;
      
      private var consortia_asset$field:int;
      
      private var master_power_lv$field:int;
      
      private var master_agility_lv$field:int;
      
      private var master_intellect_lv$field:int;
      
      private var master_physique_lv$field:int;
      
      private var master_skill_research_cd_end$field:Int64;
      
      private var consortia_weekly_active_point$field:int;
      
      private var master_school_lv$field:int;
      
      private var quest_lobby_lv$field:int;
      
      private var new_shop_lv$field:int;
      
      public function ConsortiaInfoMsg()
      {
         super();
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967294;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 1;
         consortia_id$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortia_id$field;
      }
      
      public function removeCreatorId() : void
      {
         hasField$0 &= 4294967293;
         creator_id$field = new int();
      }
      
      public function get hasCreatorId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set creatorId(param1:int) : void
      {
         hasField$0 |= 2;
         creator_id$field = param1;
      }
      
      public function get creatorId() : int
      {
         return creator_id$field;
      }
      
      public function removeChairmanId() : void
      {
         hasField$0 &= 4294967291;
         chairman_id$field = new int();
      }
      
      public function get hasChairmanId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set chairmanId(param1:int) : void
      {
         hasField$0 |= 4;
         chairman_id$field = param1;
      }
      
      public function get chairmanId() : int
      {
         return chairman_id$field;
      }
      
      public function removeLevels() : void
      {
         hasField$0 &= 4294967287;
         levels$field = new int();
      }
      
      public function get hasLevels() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set levels(param1:int) : void
      {
         hasField$0 |= 8;
         levels$field = param1;
      }
      
      public function get levels() : int
      {
         return levels$field;
      }
      
      public function removeAddCount() : void
      {
         hasField$0 &= 4294967279;
         add_count$field = new int();
      }
      
      public function get hasAddCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set addCount(param1:int) : void
      {
         hasField$0 |= 16;
         add_count$field = param1;
      }
      
      public function get addCount() : int
      {
         return add_count$field;
      }
      
      public function removeCurrentCount() : void
      {
         hasField$0 &= 4294967263;
         current_count$field = new int();
      }
      
      public function get hasCurrentCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set currentCount(param1:int) : void
      {
         hasField$0 |= 32;
         current_count$field = param1;
      }
      
      public function get currentCount() : int
      {
         return current_count$field;
      }
      
      public function removeKickCount() : void
      {
         hasField$0 &= 4294967231;
         kick_count$field = new int();
      }
      
      public function get hasKickCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set kickCount(param1:int) : void
      {
         hasField$0 |= 64;
         kick_count$field = param1;
      }
      
      public function get kickCount() : int
      {
         return kick_count$field;
      }
      
      public function removeShopLevel() : void
      {
         hasField$0 &= 4294967167;
         shop_level$field = new int();
      }
      
      public function get hasShopLevel() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set shopLevel(param1:int) : void
      {
         hasField$0 |= 128;
         shop_level$field = param1;
      }
      
      public function get shopLevel() : int
      {
         return shop_level$field;
      }
      
      public function removeStoreLevel() : void
      {
         hasField$0 &= 4294967039;
         store_level$field = new int();
      }
      
      public function get hasStoreLevel() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set storeLevel(param1:int) : void
      {
         hasField$0 |= 256;
         store_level$field = param1;
      }
      
      public function get storeLevel() : int
      {
         return store_level$field;
      }
      
      public function removeAltarLevel() : void
      {
         hasField$0 &= 4294966783;
         altar_level$field = new int();
      }
      
      public function get hasAltarLevel() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set altarLevel(param1:int) : void
      {
         hasField$0 |= 512;
         altar_level$field = param1;
      }
      
      public function get altarLevel() : int
      {
         return altar_level$field;
      }
      
      public function removeSchoolLevel() : void
      {
         hasField$0 &= 4294966271;
         school_level$field = new int();
      }
      
      public function get hasSchoolLevel() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set schoolLevel(param1:int) : void
      {
         hasField$0 |= 1024;
         school_level$field = param1;
      }
      
      public function get schoolLevel() : int
      {
         return school_level$field;
      }
      
      public function removeAttackLevel() : void
      {
         hasField$0 &= 4294965247;
         attack_level$field = new int();
      }
      
      public function get hasAttackLevel() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set attackLevel(param1:int) : void
      {
         hasField$0 |= 2048;
         attack_level$field = param1;
      }
      
      public function get attackLevel() : int
      {
         return attack_level$field;
      }
      
      public function removeDefenceLevel() : void
      {
         hasField$0 &= 4294963199;
         defence_level$field = new int();
      }
      
      public function get hasDefenceLevel() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set defenceLevel(param1:int) : void
      {
         hasField$0 |= 4096;
         defence_level$field = param1;
      }
      
      public function get defenceLevel() : int
      {
         return defence_level$field;
      }
      
      public function removeAgilityLevel() : void
      {
         hasField$0 &= 4294959103;
         agility_level$field = new int();
      }
      
      public function get hasAgilityLevel() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set agilityLevel(param1:int) : void
      {
         hasField$0 |= 8192;
         agility_level$field = param1;
      }
      
      public function get agilityLevel() : int
      {
         return agility_level$field;
      }
      
      public function removeAbilityLevel() : void
      {
         hasField$0 &= 4294950911;
         ability_level$field = new int();
      }
      
      public function get hasAbilityLevel() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set abilityLevel(param1:int) : void
      {
         hasField$0 |= 16384;
         ability_level$field = param1;
      }
      
      public function get abilityLevel() : int
      {
         return ability_level$field;
      }
      
      public function removeCaptainLevel() : void
      {
         hasField$0 &= 4294934527;
         captain_level$field = new int();
      }
      
      public function get hasCaptainLevel() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set captainLevel(param1:int) : void
      {
         hasField$0 |= 32768;
         captain_level$field = param1;
      }
      
      public function get captainLevel() : int
      {
         return captain_level$field;
      }
      
      public function removeGoldLevel() : void
      {
         hasField$0 &= 4294901759;
         gold_level$field = new int();
      }
      
      public function get hasGoldLevel() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set goldLevel(param1:int) : void
      {
         hasField$0 |= 65536;
         gold_level$field = param1;
      }
      
      public function get goldLevel() : int
      {
         return gold_level$field;
      }
      
      public function removeFightPower() : void
      {
         fight_power$field = null;
      }
      
      public function get hasFightPower() : Boolean
      {
         return fight_power$field != null;
      }
      
      public function set fightPower(param1:Int64) : void
      {
         fight_power$field = param1;
      }
      
      public function get fightPower() : Int64
      {
         return fight_power$field;
      }
      
      public function removeOwnWildlands() : void
      {
         hasField$0 &= 4294836223;
         own_wildlands$field = new int();
      }
      
      public function get hasOwnWildlands() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set ownWildlands(param1:int) : void
      {
         hasField$0 |= 131072;
         own_wildlands$field = param1;
      }
      
      public function get ownWildlands() : int
      {
         return own_wildlands$field;
      }
      
      public function removeOffer() : void
      {
         hasField$0 &= 4294705151;
         offer$field = new int();
      }
      
      public function get hasOffer() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set offer(param1:int) : void
      {
         hasField$0 |= 262144;
         offer$field = param1;
      }
      
      public function get offer() : int
      {
         return offer$field;
      }
      
      public function removeHonor() : void
      {
         hasField$0 &= 4294443007;
         honor$field = new int();
      }
      
      public function get hasHonor() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set honor(param1:int) : void
      {
         hasField$0 |= 524288;
         honor$field = param1;
      }
      
      public function get honor() : int
      {
         return honor$field;
      }
      
      public function removeBlessTempId() : void
      {
         hasField$0 &= 4293918719;
         bless_temp_id$field = new int();
      }
      
      public function get hasBlessTempId() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set blessTempId(param1:int) : void
      {
         hasField$0 |= 1048576;
         bless_temp_id$field = param1;
      }
      
      public function get blessTempId() : int
      {
         return bless_temp_id$field;
      }
      
      public function removeBlessCount() : void
      {
         hasField$0 &= 4292870143;
         bless_count$field = new int();
      }
      
      public function get hasBlessCount() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set blessCount(param1:int) : void
      {
         hasField$0 |= 2097152;
         bless_count$field = param1;
      }
      
      public function get blessCount() : int
      {
         return bless_count$field;
      }
      
      public function removeCodeType() : void
      {
         hasField$0 &= 4290772991;
         code_type$field = new int();
      }
      
      public function get hasCodeType() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set codeType(param1:int) : void
      {
         hasField$0 |= 4194304;
         code_type$field = param1;
      }
      
      public function get codeType() : int
      {
         return code_type$field;
      }
      
      public function removeTotalOffer() : void
      {
         hasField$0 &= 4286578687;
         total_offer$field = new int();
      }
      
      public function get hasTotalOffer() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set totalOffer(param1:int) : void
      {
         hasField$0 |= 8388608;
         total_offer$field = param1;
      }
      
      public function get totalOffer() : int
      {
         return total_offer$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4278190079;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 16777216;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removePlacard() : void
      {
         placard$field = null;
      }
      
      public function get hasPlacard() : Boolean
      {
         return placard$field != null;
      }
      
      public function set placard(param1:String) : void
      {
         placard$field = param1;
      }
      
      public function get placard() : String
      {
         return placard$field;
      }
      
      public function removeDescription() : void
      {
         description$field = null;
      }
      
      public function get hasDescription() : Boolean
      {
         return description$field != null;
      }
      
      public function set description(param1:String) : void
      {
         description$field = param1;
      }
      
      public function get description() : String
      {
         return description$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortia_name$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortia_name$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortia_name$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortia_name$field;
      }
      
      public function removeCreatorName() : void
      {
         creator_name$field = null;
      }
      
      public function get hasCreatorName() : Boolean
      {
         return creator_name$field != null;
      }
      
      public function set creatorName(param1:String) : void
      {
         creator_name$field = param1;
      }
      
      public function get creatorName() : String
      {
         return creator_name$field;
      }
      
      public function removeChairmanName() : void
      {
         chairman_name$field = null;
      }
      
      public function get hasChairmanName() : Boolean
      {
         return chairman_name$field != null;
      }
      
      public function set chairmanName(param1:String) : void
      {
         chairman_name$field = param1;
      }
      
      public function get chairmanName() : String
      {
         return chairman_name$field;
      }
      
      public function removeRenames() : void
      {
         renames$field = null;
      }
      
      public function get hasRenames() : Boolean
      {
         return renames$field != null;
      }
      
      public function set renames(param1:String) : void
      {
         renames$field = param1;
      }
      
      public function get renames() : String
      {
         return renames$field;
      }
      
      public function removeQuitResult() : void
      {
         quit_result$field = null;
      }
      
      public function get hasQuitResult() : Boolean
      {
         return quit_result$field != null;
      }
      
      public function set quitResult(param1:String) : void
      {
         quit_result$field = param1;
      }
      
      public function get quitResult() : String
      {
         return quit_result$field;
      }
      
      public function removeOpenApp() : void
      {
         hasField$0 &= 4261412863;
         open_app$field = new Boolean();
      }
      
      public function get hasOpenApp() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set openApp(param1:Boolean) : void
      {
         hasField$0 |= 33554432;
         open_app$field = param1;
      }
      
      public function get openApp() : Boolean
      {
         return open_app$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4227858431;
         is_exist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 67108864;
         is_exist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return is_exist$field;
      }
      
      public function removeCreateDate() : void
      {
         create_date$field = null;
      }
      
      public function get hasCreateDate() : Boolean
      {
         return create_date$field != null;
      }
      
      public function set createDate(param1:String) : void
      {
         create_date$field = param1;
      }
      
      public function get createDate() : String
      {
         return create_date$field;
      }
      
      public function removeKickDate() : void
      {
         kick_date$field = null;
      }
      
      public function get hasKickDate() : Boolean
      {
         return kick_date$field != null;
      }
      
      public function set kickDate(param1:String) : void
      {
         kick_date$field = param1;
      }
      
      public function get kickDate() : String
      {
         return kick_date$field;
      }
      
      public function removeDeductDate() : void
      {
         deduct_date$field = null;
      }
      
      public function get hasDeductDate() : Boolean
      {
         return deduct_date$field != null;
      }
      
      public function set deductDate(param1:String) : void
      {
         deduct_date$field = param1;
      }
      
      public function get deductDate() : String
      {
         return deduct_date$field;
      }
      
      public function removeWarnDate() : void
      {
         warn_date$field = null;
      }
      
      public function get hasWarnDate() : Boolean
      {
         return warn_date$field != null;
      }
      
      public function set warnDate(param1:String) : void
      {
         warn_date$field = param1;
      }
      
      public function get warnDate() : String
      {
         return warn_date$field;
      }
      
      public function removeQuitDate() : void
      {
         quit_date$field = null;
      }
      
      public function get hasQuitDate() : Boolean
      {
         return quit_date$field != null;
      }
      
      public function set quitDate(param1:String) : void
      {
         quit_date$field = param1;
      }
      
      public function get quitDate() : String
      {
         return quit_date$field;
      }
      
      public function removeCodeBeginDate() : void
      {
         code_begin_date$field = null;
      }
      
      public function get hasCodeBeginDate() : Boolean
      {
         return code_begin_date$field != null;
      }
      
      public function set codeBeginDate(param1:String) : void
      {
         code_begin_date$field = param1;
      }
      
      public function get codeBeginDate() : String
      {
         return code_begin_date$field;
      }
      
      public function removeCurrentDate() : void
      {
         current_date$field = null;
      }
      
      public function get hasCurrentDate() : Boolean
      {
         return current_date$field != null;
      }
      
      public function set currentDate(param1:String) : void
      {
         current_date$field = param1;
      }
      
      public function get currentDate() : String
      {
         return current_date$field;
      }
      
      public function removeCodeNeedDate() : void
      {
         hasField$0 &= 4160749567;
         code_need_date$field = new int();
      }
      
      public function get hasCodeNeedDate() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set codeNeedDate(param1:int) : void
      {
         hasField$0 |= 134217728;
         code_need_date$field = param1;
      }
      
      public function get codeNeedDate() : int
      {
         return code_need_date$field;
      }
      
      public function removeOrderInfo() : void
      {
         orderInfo$field = null;
      }
      
      public function get hasOrderInfo() : Boolean
      {
         return orderInfo$field != null;
      }
      
      public function set orderInfo(param1:ConsortiaOrderInfoMsg) : void
      {
         orderInfo$field = param1;
      }
      
      public function get orderInfo() : ConsortiaOrderInfoMsg
      {
         return orderInfo$field;
      }
      
      public function removePhysiqueLevel() : void
      {
         hasField$0 &= 4026531839;
         physique_level$field = new int();
      }
      
      public function get hasPhysiqueLevel() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set physiqueLevel(param1:int) : void
      {
         hasField$0 |= 268435456;
         physique_level$field = param1;
      }
      
      public function get physiqueLevel() : int
      {
         return physique_level$field;
      }
      
      public function removeIsRobot() : void
      {
         hasField$0 &= 3758096383;
         is_robot$field = new Boolean();
      }
      
      public function get hasIsRobot() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set isRobot(param1:Boolean) : void
      {
         hasField$0 |= 536870912;
         is_robot$field = param1;
      }
      
      public function get isRobot() : Boolean
      {
         return is_robot$field;
      }
      
      public function removeSpeakTimes() : void
      {
         hasField$0 &= 3221225471;
         speak_times$field = new int();
      }
      
      public function get hasSpeakTimes() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set speakTimes(param1:int) : void
      {
         hasField$0 |= 1073741824;
         speak_times$field = param1;
      }
      
      public function get speakTimes() : int
      {
         return speak_times$field;
      }
      
      public function removeVotingDate() : void
      {
         votingDate$field = null;
      }
      
      public function get hasVotingDate() : Boolean
      {
         return votingDate$field != null;
      }
      
      public function set votingDate(param1:String) : void
      {
         votingDate$field = param1;
      }
      
      public function get votingDate() : String
      {
         return votingDate$field;
      }
      
      public function removeVotingStatic() : void
      {
         hasField$0 &= 2147483647;
         votingStatic$field = new int();
      }
      
      public function get hasVotingStatic() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set votingStatic(param1:int) : void
      {
         hasField$0 |= 2147483648;
         votingStatic$field = param1;
      }
      
      public function get votingStatic() : int
      {
         return votingStatic$field;
      }
      
      public function removeVotingId() : void
      {
         hasField$1 &= 4294967294;
         votingId$field = new int();
      }
      
      public function get hasVotingId() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set votingId(param1:int) : void
      {
         hasField$1 |= 1;
         votingId$field = param1;
      }
      
      public function get votingId() : int
      {
         return votingId$field;
      }
      
      public function removeActiveData() : void
      {
         hasField$1 &= 4294967293;
         activeData$field = new int();
      }
      
      public function get hasActiveData() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set activeData(param1:int) : void
      {
         hasField$1 |= 2;
         activeData$field = param1;
      }
      
      public function get activeData() : int
      {
         return activeData$field;
      }
      
      public function removeGroupPlacard() : void
      {
         group_placard$field = null;
      }
      
      public function get hasGroupPlacard() : Boolean
      {
         return group_placard$field != null;
      }
      
      public function set groupPlacard(param1:String) : void
      {
         group_placard$field = param1;
      }
      
      public function get groupPlacard() : String
      {
         return group_placard$field;
      }
      
      public function removeAltarDate() : void
      {
         altar_date$field = null;
      }
      
      public function get hasAltarDate() : Boolean
      {
         return altar_date$field != null;
      }
      
      public function set altarDate(param1:String) : void
      {
         altar_date$field = param1;
      }
      
      public function get altarDate() : String
      {
         return altar_date$field;
      }
      
      public function removeAltarState() : void
      {
         hasField$1 &= 4294967291;
         altar_state$field = new int();
      }
      
      public function get hasAltarState() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set altarState(param1:int) : void
      {
         hasField$1 |= 4;
         altar_state$field = param1;
      }
      
      public function get altarState() : int
      {
         return altar_state$field;
      }
      
      public function removeMaxMave() : void
      {
         hasField$1 &= 4294967287;
         max_mave$field = new int();
      }
      
      public function get hasMaxMave() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set maxMave(param1:int) : void
      {
         hasField$1 |= 8;
         max_mave$field = param1;
      }
      
      public function get maxMave() : int
      {
         return max_mave$field;
      }
      
      public function removeNewPowerLv() : void
      {
         hasField$1 &= 4294967279;
         new_power_lv$field = new int();
      }
      
      public function get hasNewPowerLv() : Boolean
      {
         return (hasField$1 & 0x10) != 0;
      }
      
      public function set newPowerLv(param1:int) : void
      {
         hasField$1 |= 16;
         new_power_lv$field = param1;
      }
      
      public function get newPowerLv() : int
      {
         return new_power_lv$field;
      }
      
      public function removeNewAgilityLv() : void
      {
         hasField$1 &= 4294967263;
         new_agility_lv$field = new int();
      }
      
      public function get hasNewAgilityLv() : Boolean
      {
         return (hasField$1 & 0x20) != 0;
      }
      
      public function set newAgilityLv(param1:int) : void
      {
         hasField$1 |= 32;
         new_agility_lv$field = param1;
      }
      
      public function get newAgilityLv() : int
      {
         return new_agility_lv$field;
      }
      
      public function removeNewIntellectLv() : void
      {
         hasField$1 &= 4294967231;
         new_intellect_lv$field = new int();
      }
      
      public function get hasNewIntellectLv() : Boolean
      {
         return (hasField$1 & 0x40) != 0;
      }
      
      public function set newIntellectLv(param1:int) : void
      {
         hasField$1 |= 64;
         new_intellect_lv$field = param1;
      }
      
      public function get newIntellectLv() : int
      {
         return new_intellect_lv$field;
      }
      
      public function removeNewPhysiqueLv() : void
      {
         hasField$1 &= 4294967167;
         new_physique_lv$field = new int();
      }
      
      public function get hasNewPhysiqueLv() : Boolean
      {
         return (hasField$1 & 0x80) != 0;
      }
      
      public function set newPhysiqueLv(param1:int) : void
      {
         hasField$1 |= 128;
         new_physique_lv$field = param1;
      }
      
      public function get newPhysiqueLv() : int
      {
         return new_physique_lv$field;
      }
      
      public function removeFamGpLv() : void
      {
         hasField$1 &= 4294967039;
         fam_gp_lv$field = new int();
      }
      
      public function get hasFamGpLv() : Boolean
      {
         return (hasField$1 & 0x0100) != 0;
      }
      
      public function set famGpLv(param1:int) : void
      {
         hasField$1 |= 256;
         fam_gp_lv$field = param1;
      }
      
      public function get famGpLv() : int
      {
         return fam_gp_lv$field;
      }
      
      public function removeMedalLv() : void
      {
         hasField$1 &= 4294966783;
         medal_lv$field = new int();
      }
      
      public function get hasMedalLv() : Boolean
      {
         return (hasField$1 & 0x0200) != 0;
      }
      
      public function set medalLv(param1:int) : void
      {
         hasField$1 |= 512;
         medal_lv$field = param1;
      }
      
      public function get medalLv() : int
      {
         return medal_lv$field;
      }
      
      public function removeHonorLv() : void
      {
         hasField$1 &= 4294966271;
         honor_lv$field = new int();
      }
      
      public function get hasHonorLv() : Boolean
      {
         return (hasField$1 & 0x0400) != 0;
      }
      
      public function set honorLv(param1:int) : void
      {
         hasField$1 |= 1024;
         honor_lv$field = param1;
      }
      
      public function get honorLv() : int
      {
         return honor_lv$field;
      }
      
      public function removeScoreLv() : void
      {
         hasField$1 &= 4294965247;
         score_lv$field = new int();
      }
      
      public function get hasScoreLv() : Boolean
      {
         return (hasField$1 & 0x0800) != 0;
      }
      
      public function set scoreLv(param1:int) : void
      {
         hasField$1 |= 2048;
         score_lv$field = param1;
      }
      
      public function get scoreLv() : int
      {
         return score_lv$field;
      }
      
      public function removeBossInfo() : void
      {
         boss_info$field = null;
      }
      
      public function get hasBossInfo() : Boolean
      {
         return boss_info$field != null;
      }
      
      public function set bossInfo(param1:ConsortiaBossMsg) : void
      {
         boss_info$field = param1;
      }
      
      public function get bossInfo() : ConsortiaBossMsg
      {
         return boss_info$field;
      }
      
      public function removeStorageExpireTime1() : void
      {
         storage_expire_time1$field = null;
      }
      
      public function get hasStorageExpireTime1() : Boolean
      {
         return storage_expire_time1$field != null;
      }
      
      public function set storageExpireTime1(param1:String) : void
      {
         storage_expire_time1$field = param1;
      }
      
      public function get storageExpireTime1() : String
      {
         return storage_expire_time1$field;
      }
      
      public function removeStorageExpireTime2() : void
      {
         storage_expire_time2$field = null;
      }
      
      public function get hasStorageExpireTime2() : Boolean
      {
         return storage_expire_time2$field != null;
      }
      
      public function set storageExpireTime2(param1:String) : void
      {
         storage_expire_time2$field = param1;
      }
      
      public function get storageExpireTime2() : String
      {
         return storage_expire_time2$field;
      }
      
      public function removeIsStorageExpire1() : void
      {
         hasField$1 &= 4294963199;
         is_storage_expire1$field = new Boolean();
      }
      
      public function get hasIsStorageExpire1() : Boolean
      {
         return (hasField$1 & 0x1000) != 0;
      }
      
      public function set isStorageExpire1(param1:Boolean) : void
      {
         hasField$1 |= 4096;
         is_storage_expire1$field = param1;
      }
      
      public function get isStorageExpire1() : Boolean
      {
         return is_storage_expire1$field;
      }
      
      public function removeIsStorageExpire2() : void
      {
         hasField$1 &= 4294959103;
         is_storage_expire2$field = new Boolean();
      }
      
      public function get hasIsStorageExpire2() : Boolean
      {
         return (hasField$1 & 0x2000) != 0;
      }
      
      public function set isStorageExpire2(param1:Boolean) : void
      {
         hasField$1 |= 8192;
         is_storage_expire2$field = param1;
      }
      
      public function get isStorageExpire2() : Boolean
      {
         return is_storage_expire2$field;
      }
      
      public function removeConsortiaActivePoint() : void
      {
         hasField$1 &= 4294950911;
         consortia_active_point$field = new int();
      }
      
      public function get hasConsortiaActivePoint() : Boolean
      {
         return (hasField$1 & 0x4000) != 0;
      }
      
      public function set consortiaActivePoint(param1:int) : void
      {
         hasField$1 |= 16384;
         consortia_active_point$field = param1;
      }
      
      public function get consortiaActivePoint() : int
      {
         return consortia_active_point$field;
      }
      
      public function removeConsortiaAsset() : void
      {
         hasField$1 &= 4294934527;
         consortia_asset$field = new int();
      }
      
      public function get hasConsortiaAsset() : Boolean
      {
         return (hasField$1 & 0x8000) != 0;
      }
      
      public function set consortiaAsset(param1:int) : void
      {
         hasField$1 |= 32768;
         consortia_asset$field = param1;
      }
      
      public function get consortiaAsset() : int
      {
         return consortia_asset$field;
      }
      
      public function removeMasterPowerLv() : void
      {
         hasField$1 &= 4294901759;
         master_power_lv$field = new int();
      }
      
      public function get hasMasterPowerLv() : Boolean
      {
         return (hasField$1 & 0x010000) != 0;
      }
      
      public function set masterPowerLv(param1:int) : void
      {
         hasField$1 |= 65536;
         master_power_lv$field = param1;
      }
      
      public function get masterPowerLv() : int
      {
         return master_power_lv$field;
      }
      
      public function removeMasterAgilityLv() : void
      {
         hasField$1 &= 4294836223;
         master_agility_lv$field = new int();
      }
      
      public function get hasMasterAgilityLv() : Boolean
      {
         return (hasField$1 & 0x020000) != 0;
      }
      
      public function set masterAgilityLv(param1:int) : void
      {
         hasField$1 |= 131072;
         master_agility_lv$field = param1;
      }
      
      public function get masterAgilityLv() : int
      {
         return master_agility_lv$field;
      }
      
      public function removeMasterIntellectLv() : void
      {
         hasField$1 &= 4294705151;
         master_intellect_lv$field = new int();
      }
      
      public function get hasMasterIntellectLv() : Boolean
      {
         return (hasField$1 & 0x040000) != 0;
      }
      
      public function set masterIntellectLv(param1:int) : void
      {
         hasField$1 |= 262144;
         master_intellect_lv$field = param1;
      }
      
      public function get masterIntellectLv() : int
      {
         return master_intellect_lv$field;
      }
      
      public function removeMasterPhysiqueLv() : void
      {
         hasField$1 &= 4294443007;
         master_physique_lv$field = new int();
      }
      
      public function get hasMasterPhysiqueLv() : Boolean
      {
         return (hasField$1 & 0x080000) != 0;
      }
      
      public function set masterPhysiqueLv(param1:int) : void
      {
         hasField$1 |= 524288;
         master_physique_lv$field = param1;
      }
      
      public function get masterPhysiqueLv() : int
      {
         return master_physique_lv$field;
      }
      
      public function removeMasterSkillResearchCdEnd() : void
      {
         master_skill_research_cd_end$field = null;
      }
      
      public function get hasMasterSkillResearchCdEnd() : Boolean
      {
         return master_skill_research_cd_end$field != null;
      }
      
      public function set masterSkillResearchCdEnd(param1:Int64) : void
      {
         master_skill_research_cd_end$field = param1;
      }
      
      public function get masterSkillResearchCdEnd() : Int64
      {
         return master_skill_research_cd_end$field;
      }
      
      public function removeConsortiaWeeklyActivePoint() : void
      {
         hasField$1 &= 4293918719;
         consortia_weekly_active_point$field = new int();
      }
      
      public function get hasConsortiaWeeklyActivePoint() : Boolean
      {
         return (hasField$1 & 0x100000) != 0;
      }
      
      public function set consortiaWeeklyActivePoint(param1:int) : void
      {
         hasField$1 |= 1048576;
         consortia_weekly_active_point$field = param1;
      }
      
      public function get consortiaWeeklyActivePoint() : int
      {
         return consortia_weekly_active_point$field;
      }
      
      public function removeMasterSchoolLv() : void
      {
         hasField$1 &= 4292870143;
         master_school_lv$field = new int();
      }
      
      public function get hasMasterSchoolLv() : Boolean
      {
         return (hasField$1 & 0x200000) != 0;
      }
      
      public function set masterSchoolLv(param1:int) : void
      {
         hasField$1 |= 2097152;
         master_school_lv$field = param1;
      }
      
      public function get masterSchoolLv() : int
      {
         return master_school_lv$field;
      }
      
      public function removeQuestLobbyLv() : void
      {
         hasField$1 &= 4290772991;
         quest_lobby_lv$field = new int();
      }
      
      public function get hasQuestLobbyLv() : Boolean
      {
         return (hasField$1 & 0x400000) != 0;
      }
      
      public function set questLobbyLv(param1:int) : void
      {
         hasField$1 |= 4194304;
         quest_lobby_lv$field = param1;
      }
      
      public function get questLobbyLv() : int
      {
         return quest_lobby_lv$field;
      }
      
      public function removeNewShopLv() : void
      {
         hasField$1 &= 4286578687;
         new_shop_lv$field = new int();
      }
      
      public function get hasNewShopLv() : Boolean
      {
         return (hasField$1 & 0x800000) != 0;
      }
      
      public function set newShopLv(param1:int) : void
      {
         hasField$1 |= 8388608;
         new_shop_lv$field = param1;
      }
      
      public function get newShopLv() : int
      {
         return new_shop_lv$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasCreatorId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,creator_id$field);
         }
         if(hasChairmanId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,chairman_id$field);
         }
         if(hasLevels)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,levels$field);
         }
         if(hasAddCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,add_count$field);
         }
         if(hasCurrentCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,current_count$field);
         }
         if(hasKickCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,kick_count$field);
         }
         if(hasShopLevel)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,shop_level$field);
         }
         if(hasStoreLevel)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,store_level$field);
         }
         if(hasAltarLevel)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,altar_level$field);
         }
         if(hasSchoolLevel)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,school_level$field);
         }
         if(hasAttackLevel)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,attack_level$field);
         }
         if(hasDefenceLevel)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,defence_level$field);
         }
         if(hasAgilityLevel)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,agility_level$field);
         }
         if(hasAbilityLevel)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,ability_level$field);
         }
         if(hasCaptainLevel)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,captain_level$field);
         }
         if(hasGoldLevel)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,gold_level$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT64(param1,fight_power$field);
         }
         if(hasOwnWildlands)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,own_wildlands$field);
         }
         if(hasOffer)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,offer$field);
         }
         if(hasHonor)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,honor$field);
         }
         if(hasBlessTempId)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,bless_temp_id$field);
         }
         if(hasBlessCount)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,bless_count$field);
         }
         if(hasCodeType)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,code_type$field);
         }
         if(hasTotalOffer)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,total_offer$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasPlacard)
         {
            WriteUtils.writeTag(param1,2,27);
            WriteUtils.write$TYPE_STRING(param1,placard$field);
         }
         if(hasDescription)
         {
            WriteUtils.writeTag(param1,2,28);
            WriteUtils.write$TYPE_STRING(param1,description$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,29);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasCreatorName)
         {
            WriteUtils.writeTag(param1,2,30);
            WriteUtils.write$TYPE_STRING(param1,creator_name$field);
         }
         if(hasChairmanName)
         {
            WriteUtils.writeTag(param1,2,31);
            WriteUtils.write$TYPE_STRING(param1,chairman_name$field);
         }
         if(hasRenames)
         {
            WriteUtils.writeTag(param1,2,32);
            WriteUtils.write$TYPE_STRING(param1,renames$field);
         }
         if(hasQuitResult)
         {
            WriteUtils.writeTag(param1,2,33);
            WriteUtils.write$TYPE_STRING(param1,quit_result$field);
         }
         if(hasOpenApp)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_BOOL(param1,open_app$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_BOOL(param1,is_exist$field);
         }
         if(hasCreateDate)
         {
            WriteUtils.writeTag(param1,2,36);
            WriteUtils.write$TYPE_STRING(param1,create_date$field);
         }
         if(hasKickDate)
         {
            WriteUtils.writeTag(param1,2,37);
            WriteUtils.write$TYPE_STRING(param1,kick_date$field);
         }
         if(hasDeductDate)
         {
            WriteUtils.writeTag(param1,2,38);
            WriteUtils.write$TYPE_STRING(param1,deduct_date$field);
         }
         if(hasWarnDate)
         {
            WriteUtils.writeTag(param1,2,39);
            WriteUtils.write$TYPE_STRING(param1,warn_date$field);
         }
         if(hasQuitDate)
         {
            WriteUtils.writeTag(param1,2,40);
            WriteUtils.write$TYPE_STRING(param1,quit_date$field);
         }
         if(hasCodeBeginDate)
         {
            WriteUtils.writeTag(param1,2,41);
            WriteUtils.write$TYPE_STRING(param1,code_begin_date$field);
         }
         if(hasCurrentDate)
         {
            WriteUtils.writeTag(param1,2,42);
            WriteUtils.write$TYPE_STRING(param1,current_date$field);
         }
         if(hasCodeNeedDate)
         {
            WriteUtils.writeTag(param1,0,43);
            WriteUtils.write$TYPE_INT32(param1,code_need_date$field);
         }
         if(hasOrderInfo)
         {
            WriteUtils.writeTag(param1,2,44);
            WriteUtils.write$TYPE_MESSAGE(param1,orderInfo$field);
         }
         if(hasPhysiqueLevel)
         {
            WriteUtils.writeTag(param1,0,45);
            WriteUtils.write$TYPE_INT32(param1,physique_level$field);
         }
         if(hasIsRobot)
         {
            WriteUtils.writeTag(param1,0,46);
            WriteUtils.write$TYPE_BOOL(param1,is_robot$field);
         }
         _loc2_ = 0;
         while(_loc2_ < site.length)
         {
            WriteUtils.writeTag(param1,0,47);
            WriteUtils.write$TYPE_INT32(param1,site[_loc2_]);
            _loc2_++;
         }
         if(hasSpeakTimes)
         {
            WriteUtils.writeTag(param1,0,48);
            WriteUtils.write$TYPE_INT32(param1,speak_times$field);
         }
         if(hasVotingDate)
         {
            WriteUtils.writeTag(param1,2,49);
            WriteUtils.write$TYPE_STRING(param1,votingDate$field);
         }
         if(hasVotingStatic)
         {
            WriteUtils.writeTag(param1,0,50);
            WriteUtils.write$TYPE_INT32(param1,votingStatic$field);
         }
         if(hasVotingId)
         {
            WriteUtils.writeTag(param1,0,51);
            WriteUtils.write$TYPE_INT32(param1,votingId$field);
         }
         if(hasActiveData)
         {
            WriteUtils.writeTag(param1,0,52);
            WriteUtils.write$TYPE_INT32(param1,activeData$field);
         }
         if(hasGroupPlacard)
         {
            WriteUtils.writeTag(param1,2,53);
            WriteUtils.write$TYPE_STRING(param1,group_placard$field);
         }
         if(hasAltarDate)
         {
            WriteUtils.writeTag(param1,2,54);
            WriteUtils.write$TYPE_STRING(param1,altar_date$field);
         }
         if(hasAltarState)
         {
            WriteUtils.writeTag(param1,0,55);
            WriteUtils.write$TYPE_INT32(param1,altar_state$field);
         }
         if(hasMaxMave)
         {
            WriteUtils.writeTag(param1,0,56);
            WriteUtils.write$TYPE_INT32(param1,max_mave$field);
         }
         if(hasNewPowerLv)
         {
            WriteUtils.writeTag(param1,0,57);
            WriteUtils.write$TYPE_INT32(param1,new_power_lv$field);
         }
         if(hasNewAgilityLv)
         {
            WriteUtils.writeTag(param1,0,58);
            WriteUtils.write$TYPE_INT32(param1,new_agility_lv$field);
         }
         if(hasNewIntellectLv)
         {
            WriteUtils.writeTag(param1,0,59);
            WriteUtils.write$TYPE_INT32(param1,new_intellect_lv$field);
         }
         if(hasNewPhysiqueLv)
         {
            WriteUtils.writeTag(param1,0,60);
            WriteUtils.write$TYPE_INT32(param1,new_physique_lv$field);
         }
         if(hasFamGpLv)
         {
            WriteUtils.writeTag(param1,0,61);
            WriteUtils.write$TYPE_INT32(param1,fam_gp_lv$field);
         }
         if(hasMedalLv)
         {
            WriteUtils.writeTag(param1,0,62);
            WriteUtils.write$TYPE_INT32(param1,medal_lv$field);
         }
         if(hasHonorLv)
         {
            WriteUtils.writeTag(param1,0,63);
            WriteUtils.write$TYPE_INT32(param1,honor_lv$field);
         }
         if(hasScoreLv)
         {
            WriteUtils.writeTag(param1,0,64);
            WriteUtils.write$TYPE_INT32(param1,score_lv$field);
         }
         if(hasBossInfo)
         {
            WriteUtils.writeTag(param1,2,65);
            WriteUtils.write$TYPE_MESSAGE(param1,boss_info$field);
         }
         if(hasStorageExpireTime1)
         {
            WriteUtils.writeTag(param1,2,66);
            WriteUtils.write$TYPE_STRING(param1,storage_expire_time1$field);
         }
         if(hasStorageExpireTime2)
         {
            WriteUtils.writeTag(param1,2,67);
            WriteUtils.write$TYPE_STRING(param1,storage_expire_time2$field);
         }
         if(hasIsStorageExpire1)
         {
            WriteUtils.writeTag(param1,0,68);
            WriteUtils.write$TYPE_BOOL(param1,is_storage_expire1$field);
         }
         if(hasIsStorageExpire2)
         {
            WriteUtils.writeTag(param1,0,69);
            WriteUtils.write$TYPE_BOOL(param1,is_storage_expire2$field);
         }
         if(hasConsortiaActivePoint)
         {
            WriteUtils.writeTag(param1,0,70);
            WriteUtils.write$TYPE_INT32(param1,consortia_active_point$field);
         }
         if(hasConsortiaAsset)
         {
            WriteUtils.writeTag(param1,0,71);
            WriteUtils.write$TYPE_INT32(param1,consortia_asset$field);
         }
         if(hasMasterPowerLv)
         {
            WriteUtils.writeTag(param1,0,72);
            WriteUtils.write$TYPE_INT32(param1,master_power_lv$field);
         }
         if(hasMasterAgilityLv)
         {
            WriteUtils.writeTag(param1,0,73);
            WriteUtils.write$TYPE_INT32(param1,master_agility_lv$field);
         }
         if(hasMasterIntellectLv)
         {
            WriteUtils.writeTag(param1,0,74);
            WriteUtils.write$TYPE_INT32(param1,master_intellect_lv$field);
         }
         if(hasMasterPhysiqueLv)
         {
            WriteUtils.writeTag(param1,0,75);
            WriteUtils.write$TYPE_INT32(param1,master_physique_lv$field);
         }
         if(hasMasterSkillResearchCdEnd)
         {
            WriteUtils.writeTag(param1,0,76);
            WriteUtils.write$TYPE_INT64(param1,master_skill_research_cd_end$field);
         }
         if(hasConsortiaWeeklyActivePoint)
         {
            WriteUtils.writeTag(param1,0,77);
            WriteUtils.write$TYPE_INT32(param1,consortia_weekly_active_point$field);
         }
         if(hasMasterSchoolLv)
         {
            WriteUtils.writeTag(param1,0,78);
            WriteUtils.write$TYPE_INT32(param1,master_school_lv$field);
         }
         if(hasQuestLobbyLv)
         {
            WriteUtils.writeTag(param1,0,79);
            WriteUtils.write$TYPE_INT32(param1,quest_lobby_lv$field);
         }
         if(hasNewShopLv)
         {
            WriteUtils.writeTag(param1,0,80);
            WriteUtils.write$TYPE_INT32(param1,new_shop_lv$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc48_:uint = 0;
         var _loc26_:uint = 0;
         var _loc50_:uint = 0;
         var _loc24_:uint = 0;
         var _loc8_:uint = 0;
         var _loc72_:uint = 0;
         var _loc59_:uint = 0;
         var _loc10_:uint = 0;
         var _loc63_:uint = 0;
         var _loc61_:uint = 0;
         var _loc34_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc31_:uint = 0;
         var _loc53_:uint = 0;
         var _loc28_:uint = 0;
         var _loc22_:uint = 0;
         var _loc54_:uint = 0;
         var _loc14_:uint = 0;
         var _loc60_:uint = 0;
         var _loc36_:uint = 0;
         var _loc62_:uint = 0;
         var _loc37_:uint = 0;
         var _loc3_:uint = 0;
         var _loc43_:uint = 0;
         var _loc81_:uint = 0;
         var _loc33_:uint = 0;
         var _loc19_:uint = 0;
         var _loc9_:uint = 0;
         var _loc76_:uint = 0;
         var _loc57_:uint = 0;
         var _loc29_:uint = 0;
         var _loc80_:uint = 0;
         var _loc45_:uint = 0;
         var _loc7_:uint = 0;
         var _loc20_:uint = 0;
         var _loc40_:uint = 0;
         var _loc4_:uint = 0;
         var _loc51_:uint = 0;
         var _loc64_:uint = 0;
         var _loc25_:uint = 0;
         var _loc65_:uint = 0;
         var _loc71_:uint = 0;
         var _loc77_:uint = 0;
         var _loc5_:uint = 0;
         var _loc67_:uint = 0;
         var _loc58_:uint = 0;
         var _loc73_:uint = 0;
         var _loc32_:uint = 0;
         var _loc30_:uint = 0;
         var _loc74_:uint = 0;
         var _loc46_:uint = 0;
         var _loc52_:uint = 0;
         var _loc15_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc56_:uint = 0;
         var _loc47_:uint = 0;
         var _loc75_:uint = 0;
         var _loc38_:uint = 0;
         var _loc79_:uint = 0;
         var _loc27_:uint = 0;
         var _loc41_:uint = 0;
         var _loc69_:uint = 0;
         var _loc42_:uint = 0;
         var _loc66_:uint = 0;
         var _loc35_:uint = 0;
         var _loc55_:uint = 0;
         var _loc18_:uint = 0;
         var _loc16_:uint = 0;
         var _loc23_:uint = 0;
         var _loc44_:uint = 0;
         var _loc39_:uint = 0;
         var _loc68_:uint = 0;
         var _loc78_:uint = 0;
         var _loc17_:uint = 0;
         var _loc70_:uint = 0;
         var _loc49_:uint = 0;
         var _loc82_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc48_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.consortiaId cannot be set twice.");
                  }
                  _loc48_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.creatorId cannot be set twice.");
                  }
                  _loc26_++;
                  creatorId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc50_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.chairmanId cannot be set twice.");
                  }
                  _loc50_++;
                  chairmanId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.levels cannot be set twice.");
                  }
                  _loc24_++;
                  levels = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.addCount cannot be set twice.");
                  }
                  _loc8_++;
                  addCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc72_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.currentCount cannot be set twice.");
                  }
                  _loc72_++;
                  currentCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc59_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.kickCount cannot be set twice.");
                  }
                  _loc59_++;
                  kickCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.shopLevel cannot be set twice.");
                  }
                  _loc10_++;
                  shopLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc63_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.storeLevel cannot be set twice.");
                  }
                  _loc63_++;
                  storeLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc61_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.altarLevel cannot be set twice.");
                  }
                  _loc61_++;
                  altarLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.schoolLevel cannot be set twice.");
                  }
                  _loc34_++;
                  schoolLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.attackLevel cannot be set twice.");
                  }
                  _loc6_++;
                  attackLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.defenceLevel cannot be set twice.");
                  }
                  _loc13_++;
                  defenceLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.agilityLevel cannot be set twice.");
                  }
                  _loc31_++;
                  agilityLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc53_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.abilityLevel cannot be set twice.");
                  }
                  _loc53_++;
                  abilityLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.captainLevel cannot be set twice.");
                  }
                  _loc28_++;
                  captainLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.goldLevel cannot be set twice.");
                  }
                  _loc22_++;
                  goldLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc54_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc54_++;
                  fightPower = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 19:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.ownWildlands cannot be set twice.");
                  }
                  _loc14_++;
                  ownWildlands = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc60_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.offer cannot be set twice.");
                  }
                  _loc60_++;
                  offer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.honor cannot be set twice.");
                  }
                  _loc36_++;
                  honor = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc62_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.blessTempId cannot be set twice.");
                  }
                  _loc62_++;
                  blessTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.blessCount cannot be set twice.");
                  }
                  _loc37_++;
                  blessCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.codeType cannot be set twice.");
                  }
                  _loc3_++;
                  codeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc43_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.totalOffer cannot be set twice.");
                  }
                  _loc43_++;
                  totalOffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc81_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.op cannot be set twice.");
                  }
                  _loc81_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.placard cannot be set twice.");
                  }
                  _loc33_++;
                  placard = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 28:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.description cannot be set twice.");
                  }
                  _loc19_++;
                  description = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 29:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.consortiaName cannot be set twice.");
                  }
                  _loc9_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 30:
                  if(_loc76_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.creatorName cannot be set twice.");
                  }
                  _loc76_++;
                  creatorName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 31:
                  if(_loc57_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.chairmanName cannot be set twice.");
                  }
                  _loc57_++;
                  chairmanName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 32:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.renames cannot be set twice.");
                  }
                  _loc29_++;
                  renames = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 33:
                  if(_loc80_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.quitResult cannot be set twice.");
                  }
                  _loc80_++;
                  quitResult = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 34:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.openApp cannot be set twice.");
                  }
                  _loc45_++;
                  openApp = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 35:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.isExist cannot be set twice.");
                  }
                  _loc7_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 36:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.createDate cannot be set twice.");
                  }
                  _loc20_++;
                  createDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 37:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.kickDate cannot be set twice.");
                  }
                  _loc40_++;
                  kickDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 38:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.deductDate cannot be set twice.");
                  }
                  _loc4_++;
                  deductDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 39:
                  if(_loc51_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.warnDate cannot be set twice.");
                  }
                  _loc51_++;
                  warnDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 40:
                  if(_loc64_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.quitDate cannot be set twice.");
                  }
                  _loc64_++;
                  quitDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 41:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.codeBeginDate cannot be set twice.");
                  }
                  _loc25_++;
                  codeBeginDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 42:
                  if(_loc65_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.currentDate cannot be set twice.");
                  }
                  _loc65_++;
                  currentDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 43:
                  if(_loc71_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.codeNeedDate cannot be set twice.");
                  }
                  _loc71_++;
                  codeNeedDate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 44:
                  if(_loc77_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.orderInfo cannot be set twice.");
                  }
                  _loc77_++;
                  orderInfo = new ConsortiaOrderInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,orderInfo);
                  break;
               case 45:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.physiqueLevel cannot be set twice.");
                  }
                  _loc5_++;
                  physiqueLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 46:
                  if(_loc67_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.isRobot cannot be set twice.");
                  }
                  _loc67_++;
                  isRobot = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 47:
                  if((_loc21_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,site);
                  }
                  else
                  {
                     site.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 48:
                  if(_loc58_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.speakTimes cannot be set twice.");
                  }
                  _loc58_++;
                  speakTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 49:
                  if(_loc73_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.votingDate cannot be set twice.");
                  }
                  _loc73_++;
                  votingDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 50:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.votingStatic cannot be set twice.");
                  }
                  _loc32_++;
                  votingStatic = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 51:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.votingId cannot be set twice.");
                  }
                  _loc30_++;
                  votingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 52:
                  if(_loc74_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.activeData cannot be set twice.");
                  }
                  _loc74_++;
                  activeData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 53:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.groupPlacard cannot be set twice.");
                  }
                  _loc46_++;
                  groupPlacard = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 54:
                  if(_loc52_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.altarDate cannot be set twice.");
                  }
                  _loc52_++;
                  altarDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 55:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.altarState cannot be set twice.");
                  }
                  _loc15_++;
                  altarState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 56:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.maxMave cannot be set twice.");
                  }
                  _loc11_++;
                  maxMave = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 57:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.newPowerLv cannot be set twice.");
                  }
                  _loc12_++;
                  newPowerLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 58:
                  if(_loc56_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.newAgilityLv cannot be set twice.");
                  }
                  _loc56_++;
                  newAgilityLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 59:
                  if(_loc47_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.newIntellectLv cannot be set twice.");
                  }
                  _loc47_++;
                  newIntellectLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 60:
                  if(_loc75_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.newPhysiqueLv cannot be set twice.");
                  }
                  _loc75_++;
                  newPhysiqueLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 61:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.famGpLv cannot be set twice.");
                  }
                  _loc38_++;
                  famGpLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 62:
                  if(_loc79_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.medalLv cannot be set twice.");
                  }
                  _loc79_++;
                  medalLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 63:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.honorLv cannot be set twice.");
                  }
                  _loc27_++;
                  honorLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 64:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.scoreLv cannot be set twice.");
                  }
                  _loc41_++;
                  scoreLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 65:
                  if(_loc69_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.bossInfo cannot be set twice.");
                  }
                  _loc69_++;
                  bossInfo = new ConsortiaBossMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,bossInfo);
                  break;
               case 66:
                  if(_loc42_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.storageExpireTime1 cannot be set twice.");
                  }
                  _loc42_++;
                  storageExpireTime1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 67:
                  if(_loc66_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.storageExpireTime2 cannot be set twice.");
                  }
                  _loc66_++;
                  storageExpireTime2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 68:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.isStorageExpire1 cannot be set twice.");
                  }
                  _loc35_++;
                  isStorageExpire1 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 69:
                  if(_loc55_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.isStorageExpire2 cannot be set twice.");
                  }
                  _loc55_++;
                  isStorageExpire2 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 70:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.consortiaActivePoint cannot be set twice.");
                  }
                  _loc18_++;
                  consortiaActivePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 71:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.consortiaAsset cannot be set twice.");
                  }
                  _loc16_++;
                  consortiaAsset = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 72:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.masterPowerLv cannot be set twice.");
                  }
                  _loc23_++;
                  masterPowerLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 73:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.masterAgilityLv cannot be set twice.");
                  }
                  _loc44_++;
                  masterAgilityLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 74:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.masterIntellectLv cannot be set twice.");
                  }
                  _loc39_++;
                  masterIntellectLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 75:
                  if(_loc68_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.masterPhysiqueLv cannot be set twice.");
                  }
                  _loc68_++;
                  masterPhysiqueLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 76:
                  if(_loc78_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.masterSkillResearchCdEnd cannot be set twice.");
                  }
                  _loc78_++;
                  masterSkillResearchCdEnd = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 77:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.consortiaWeeklyActivePoint cannot be set twice.");
                  }
                  _loc17_++;
                  consortiaWeeklyActivePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 78:
                  if(_loc70_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.masterSchoolLv cannot be set twice.");
                  }
                  _loc70_++;
                  masterSchoolLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 79:
                  if(_loc49_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.questLobbyLv cannot be set twice.");
                  }
                  _loc49_++;
                  questLobbyLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 80:
                  if(_loc82_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaInfoMsg.newShopLv cannot be set twice.");
                  }
                  _loc82_++;
                  newShopLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

