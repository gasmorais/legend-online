package com.road.yishi.proto.player
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerMsg extends Message implements IExternalizable
   {
      
      private var player_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var sex$field:int;
      
      private var pic$field:int;
      
      private var camp$field:int;
      
      private var point$field:int;
      
      private var gift_token$field:int;
      
      private var state$field:int;
      
      private var last_award$field:String;
      
      private var quest_site_len$field:int;
      
      private var quest_site$field:ByteArray;
      
      private var consortia_id$field:int;
      
      private var consortia_name$field:String;
      
      private var claim_id$field:int;
      
      private var claim_name$field:String;
      
      private var grades$field:int;
      
      private var gp$field:Int64;
      
      private var repute$field:int;
      
      private var consortia_offer$field:int;
      
      private var strategy$field:Int64;
      
      private var weary$field:int;
      
      private var attack_left_count$field:int;
      
      private var novice_process$field:int;
      
      private var consortia_attack$field:int;
      
      private var consortia_defence$field:int;
      
      private var consortia_agility$field:int;
      
      private var consortia_ability$field:int;
      
      private var consortia_captain$field:int;
      
      private var gp_order$field:int;
      
      private var fighting_capacity$field:int;
      
      private var grade_process$field:String;
      
      private var time_process$field:int;
      
      private var time_get$field:Boolean;
      
      private var campaign_site$field:String;
      
      private var bag_count$field:int;
      
      private var match_win$field:int;
      
      private var match_failed$field:int;
      
      private var consortia_gold$field:int;
      
      private var consortia_physique$field:int;
      
      private var right$field:int;
      
      private var job$field:int;
      
      private var leed_process$field:int;
      
      private var hasField$1:uint = 0;
      
      private var star_count$field:int;
      
      private var signDate$field:String;
      
      private var signTimes$field:int;
      
      private var signSite$field:int;
      
      private var order$field:PlayerOrderMsg;
      
      private var startFree$field:int;
      
      private var totalGp$field:Int64;
      
      private var refuseFriend$field:Boolean;
      
      private var refuseInvite$field:Boolean;
      
      private var consortia_totaloffer$field:int;
      
      private var show_version$field:Boolean;
      
      private var campaign_count$field:int;
      
      private var time_run$field:int;
      
      private var qte_guide$field:int;
      
      private var starpoint$field:int;
      
      private var is_auto$field:Boolean;
      
      private var lastOutConsortia$field:String;
      
      private var geste$field:int;
      
      private var storeGrade$field:int;
      
      private var storeGp$field:int;
      
      private var relogin_process$field:int;
      
      private var relogin_count$field:int;
      
      private var blessingCount$field:int;
      
      private var blessingBuff$field:int;
      
      private var blessingMaxCount$field:int;
      
      private var first_charge$field:Boolean;
      
      private var charm$field:int;
      
      private var match_room_count$field:int;
      
      private var king_buff$field:Boolean;
      
      private var leave_gp$field:int;
      
      private var altar_consortiaId$field:int;
      
      private var server_name$field:String;
      
      private var reward_times$field:int;
      
      private var war_field_count$field:int;
      
      private var trial_count$field:int;
      
      private var appell_id$field:int;
      
      private var cross_score$field:int;
      
      private var hasField$2:uint = 0;
      
      private var trial_max_count$field:int;
      
      private var weary_limit$field:int;
      
      private var lords_score$field:int;
      
      private var is_received$field:Boolean;
      
      private var mine_score$field:int;
      
      private var is_back_player$field:Boolean;
      
      private var refuseTeamInvite$field:Boolean;
      
      private var campaign_maxcount$field:int;
      
      private var seniorStoreGrade$field:int;
      
      private var seniorStoreGp$field:int;
      
      private var dragonCampaign_Count$field:int;
      
      private var dragonCampaign_MaxCount$field:int;
      
      private var cross_guild_score$field:int;
      
      private var cross_league_medal$field:int;
      
      private var applle_property_Open$field:Boolean;
      
      private var hasVicePassword$field:int;
      
      private var isDuringToResetTime$field:int;
      
      private var rentalBagTime$field:String;
      
      private var status$field:int;
      
      private var new_power_lv$field:int;
      
      private var new_agility_lv$field:int;
      
      private var new_intellect_lv$field:int;
      
      private var new_physique_lv$field:int;
      
      private var fam_gp_lv$field:int;
      
      private var medal_lv$field:int;
      
      private var honor_lv$field:int;
      
      private var property_lv$field:int;
      
      private var leadExtractTimes$field:int;
      
      private var randomBossCount$field:int;
      
      private var monopolyCampaignCount$field:int;
      
      private var jump_novice$field:Boolean;
      
      private var skills$field:String;
      
      private var skill_grade$field:String;
      
      private var skill_proficiency$field:String;
      
      private var is_cost$field:Boolean;
      
      private var skill_compose_times$field:int;
      
      private var hasField$3:uint = 0;
      
      private var skill_collect_times$field:int;
      
      private var composeId$field:String;
      
      private var team_count$field:int;
      
      private var team_max_count$field:int;
      
      private var seekSurplusTime$field:int;
      
      private var recoverGP$field:int;
      
      private var terra_temple_count$field:int;
      
      private var terra_temple_max_count$field:int;
      
      private var lastFreeSkillLearnTime$field:String;
      
      private var stoneBagCount$field:int;
      
      private var tramcarCount$field:int;
      
      private var weekCampaignCount$field:int;
      
      private var weekCampaignMaxCount$field:int;
      
      private var trialTowerCampaignCount$field:int;
      
      private var trialTowerCampaignMaxCount$field:int;
      
      private var fantasyMatrixCampaignCount$field:int;
      
      private var fantasyMatrixCampaignMaxCount$field:int;
      
      private var bloodyRealmCampaignCount$field:int;
      
      private var bloodyRealmCampaignMaxCount$field:int;
      
      private var equipmentRefiningGrade$field:int;
      
      private var equipmentRefiningGp$field:int;
      
      private var uuid$field:String;
      
      private var petPveCount$field:int;
      
      private var petPveMaxCount$field:int;
      
      private var quickPassCount$field:int;
      
      private var guardWarCount$field:int;
      
      private var guardWarMaxCount$field:int;
      
      private var time_vortex_count$field:int;
      
      private var time_vortex_node$field:int;
      
      private var isOpenDragonTalker$field:Boolean;
      
      private var isCurrentDragonTalker$field:Boolean;
      
      private var master_power_lv$field:int;
      
      private var master_agility_lv$field:int;
      
      private var master_intellect_lv$field:int;
      
      private var master_physique_lv$field:int;
      
      private var hasField$4:uint = 0;
      
      private var abyssPrisonCount$field:int;
      
      private var abyssPrisonMaxCount$field:int;
      
      private var BlackGoldCaveLeftCount$field:int;
      
      private var BlackGoldCaveMaxCount$field:int;
      
      private var RushCustomsLeftCount$field:int;
      
      private var RushCustomsMaxCount$field:int;
      
      private var ElementSilvaMaxCount$field:int;
      
      private var ElementSilvaLeftCount$field:int;
      
      private var DungeonTurnLeftRewardCount$field:int;
      
      private var DungeonTurnMaxRewardCount$field:int;
      
      private var TimeSpaceLeftRewardCount$field:int;
      
      private var TimeSpaceMaxRewardCount$field:int;
      
      private var skyStepCount$field:int;
      
      private var skyStepMaxCount$field:int;
      
      private var rune_count$field:int;
      
      private var runePowerPoint$field:int;
      
      public function PlayerMsg()
      {
         super();
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967294;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 1;
         player_id$field = param1;
      }
      
      public function get playerId() : int
      {
         return player_id$field;
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
      
      public function removeSex() : void
      {
         hasField$0 &= 4294967293;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 2;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removePic() : void
      {
         hasField$0 &= 4294967291;
         pic$field = new int();
      }
      
      public function get hasPic() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pic(param1:int) : void
      {
         hasField$0 |= 4;
         pic$field = param1;
      }
      
      public function get pic() : int
      {
         return pic$field;
      }
      
      public function removeCamp() : void
      {
         hasField$0 &= 4294967287;
         camp$field = new int();
      }
      
      public function get hasCamp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set camp(param1:int) : void
      {
         hasField$0 |= 8;
         camp$field = param1;
      }
      
      public function get camp() : int
      {
         return camp$field;
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967279;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 16;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removeGiftToken() : void
      {
         hasField$0 &= 4294967263;
         gift_token$field = new int();
      }
      
      public function get hasGiftToken() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set giftToken(param1:int) : void
      {
         hasField$0 |= 32;
         gift_token$field = param1;
      }
      
      public function get giftToken() : int
      {
         return gift_token$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967231;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 64;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeLastAward() : void
      {
         last_award$field = null;
      }
      
      public function get hasLastAward() : Boolean
      {
         return last_award$field != null;
      }
      
      public function set lastAward(param1:String) : void
      {
         last_award$field = param1;
      }
      
      public function get lastAward() : String
      {
         return last_award$field;
      }
      
      public function removeQuestSiteLen() : void
      {
         hasField$0 &= 4294967167;
         quest_site_len$field = new int();
      }
      
      public function get hasQuestSiteLen() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set questSiteLen(param1:int) : void
      {
         hasField$0 |= 128;
         quest_site_len$field = param1;
      }
      
      public function get questSiteLen() : int
      {
         return quest_site_len$field;
      }
      
      public function removeQuestSite() : void
      {
         quest_site$field = null;
      }
      
      public function get hasQuestSite() : Boolean
      {
         return quest_site$field != null;
      }
      
      public function set questSite(param1:ByteArray) : void
      {
         quest_site$field = param1;
      }
      
      public function get questSite() : ByteArray
      {
         return quest_site$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967039;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 256;
         consortia_id$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortia_id$field;
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
      
      public function removeClaimId() : void
      {
         hasField$0 &= 4294966783;
         claim_id$field = new int();
      }
      
      public function get hasClaimId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set claimId(param1:int) : void
      {
         hasField$0 |= 512;
         claim_id$field = param1;
      }
      
      public function get claimId() : int
      {
         return claim_id$field;
      }
      
      public function removeClaimName() : void
      {
         claim_name$field = null;
      }
      
      public function get hasClaimName() : Boolean
      {
         return claim_name$field != null;
      }
      
      public function set claimName(param1:String) : void
      {
         claim_name$field = param1;
      }
      
      public function get claimName() : String
      {
         return claim_name$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294966271;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 1024;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeGp() : void
      {
         gp$field = null;
      }
      
      public function get hasGp() : Boolean
      {
         return gp$field != null;
      }
      
      public function set gp(param1:Int64) : void
      {
         gp$field = param1;
      }
      
      public function get gp() : Int64
      {
         return gp$field;
      }
      
      public function removeRepute() : void
      {
         hasField$0 &= 4294965247;
         repute$field = new int();
      }
      
      public function get hasRepute() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set repute(param1:int) : void
      {
         hasField$0 |= 2048;
         repute$field = param1;
      }
      
      public function get repute() : int
      {
         return repute$field;
      }
      
      public function removeConsortiaOffer() : void
      {
         hasField$0 &= 4294963199;
         consortia_offer$field = new int();
      }
      
      public function get hasConsortiaOffer() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set consortiaOffer(param1:int) : void
      {
         hasField$0 |= 4096;
         consortia_offer$field = param1;
      }
      
      public function get consortiaOffer() : int
      {
         return consortia_offer$field;
      }
      
      public function removeStrategy() : void
      {
         strategy$field = null;
      }
      
      public function get hasStrategy() : Boolean
      {
         return strategy$field != null;
      }
      
      public function set strategy(param1:Int64) : void
      {
         strategy$field = param1;
      }
      
      public function get strategy() : Int64
      {
         return strategy$field;
      }
      
      public function removeWeary() : void
      {
         hasField$0 &= 4294959103;
         weary$field = new int();
      }
      
      public function get hasWeary() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set weary(param1:int) : void
      {
         hasField$0 |= 8192;
         weary$field = param1;
      }
      
      public function get weary() : int
      {
         return weary$field;
      }
      
      public function removeAttackLeftCount() : void
      {
         hasField$0 &= 4294950911;
         attack_left_count$field = new int();
      }
      
      public function get hasAttackLeftCount() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set attackLeftCount(param1:int) : void
      {
         hasField$0 |= 16384;
         attack_left_count$field = param1;
      }
      
      public function get attackLeftCount() : int
      {
         return attack_left_count$field;
      }
      
      public function removeNoviceProcess() : void
      {
         hasField$0 &= 4294934527;
         novice_process$field = new int();
      }
      
      public function get hasNoviceProcess() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set noviceProcess(param1:int) : void
      {
         hasField$0 |= 32768;
         novice_process$field = param1;
      }
      
      public function get noviceProcess() : int
      {
         return novice_process$field;
      }
      
      public function removeConsortiaAttack() : void
      {
         hasField$0 &= 4294901759;
         consortia_attack$field = new int();
      }
      
      public function get hasConsortiaAttack() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set consortiaAttack(param1:int) : void
      {
         hasField$0 |= 65536;
         consortia_attack$field = param1;
      }
      
      public function get consortiaAttack() : int
      {
         return consortia_attack$field;
      }
      
      public function removeConsortiaDefence() : void
      {
         hasField$0 &= 4294836223;
         consortia_defence$field = new int();
      }
      
      public function get hasConsortiaDefence() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set consortiaDefence(param1:int) : void
      {
         hasField$0 |= 131072;
         consortia_defence$field = param1;
      }
      
      public function get consortiaDefence() : int
      {
         return consortia_defence$field;
      }
      
      public function removeConsortiaAgility() : void
      {
         hasField$0 &= 4294705151;
         consortia_agility$field = new int();
      }
      
      public function get hasConsortiaAgility() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set consortiaAgility(param1:int) : void
      {
         hasField$0 |= 262144;
         consortia_agility$field = param1;
      }
      
      public function get consortiaAgility() : int
      {
         return consortia_agility$field;
      }
      
      public function removeConsortiaAbility() : void
      {
         hasField$0 &= 4294443007;
         consortia_ability$field = new int();
      }
      
      public function get hasConsortiaAbility() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set consortiaAbility(param1:int) : void
      {
         hasField$0 |= 524288;
         consortia_ability$field = param1;
      }
      
      public function get consortiaAbility() : int
      {
         return consortia_ability$field;
      }
      
      public function removeConsortiaCaptain() : void
      {
         hasField$0 &= 4293918719;
         consortia_captain$field = new int();
      }
      
      public function get hasConsortiaCaptain() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set consortiaCaptain(param1:int) : void
      {
         hasField$0 |= 1048576;
         consortia_captain$field = param1;
      }
      
      public function get consortiaCaptain() : int
      {
         return consortia_captain$field;
      }
      
      public function removeGpOrder() : void
      {
         hasField$0 &= 4292870143;
         gp_order$field = new int();
      }
      
      public function get hasGpOrder() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set gpOrder(param1:int) : void
      {
         hasField$0 |= 2097152;
         gp_order$field = param1;
      }
      
      public function get gpOrder() : int
      {
         return gp_order$field;
      }
      
      public function removeFightingCapacity() : void
      {
         hasField$0 &= 4290772991;
         fighting_capacity$field = new int();
      }
      
      public function get hasFightingCapacity() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set fightingCapacity(param1:int) : void
      {
         hasField$0 |= 4194304;
         fighting_capacity$field = param1;
      }
      
      public function get fightingCapacity() : int
      {
         return fighting_capacity$field;
      }
      
      public function removeGradeProcess() : void
      {
         grade_process$field = null;
      }
      
      public function get hasGradeProcess() : Boolean
      {
         return grade_process$field != null;
      }
      
      public function set gradeProcess(param1:String) : void
      {
         grade_process$field = param1;
      }
      
      public function get gradeProcess() : String
      {
         return grade_process$field;
      }
      
      public function removeTimeProcess() : void
      {
         hasField$0 &= 4286578687;
         time_process$field = new int();
      }
      
      public function get hasTimeProcess() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set timeProcess(param1:int) : void
      {
         hasField$0 |= 8388608;
         time_process$field = param1;
      }
      
      public function get timeProcess() : int
      {
         return time_process$field;
      }
      
      public function removeTimeGet() : void
      {
         hasField$0 &= 4278190079;
         time_get$field = new Boolean();
      }
      
      public function get hasTimeGet() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set timeGet(param1:Boolean) : void
      {
         hasField$0 |= 16777216;
         time_get$field = param1;
      }
      
      public function get timeGet() : Boolean
      {
         return time_get$field;
      }
      
      public function removeCampaignSite() : void
      {
         campaign_site$field = null;
      }
      
      public function get hasCampaignSite() : Boolean
      {
         return campaign_site$field != null;
      }
      
      public function set campaignSite(param1:String) : void
      {
         campaign_site$field = param1;
      }
      
      public function get campaignSite() : String
      {
         return campaign_site$field;
      }
      
      public function removeBagCount() : void
      {
         hasField$0 &= 4261412863;
         bag_count$field = new int();
      }
      
      public function get hasBagCount() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set bagCount(param1:int) : void
      {
         hasField$0 |= 33554432;
         bag_count$field = param1;
      }
      
      public function get bagCount() : int
      {
         return bag_count$field;
      }
      
      public function removeMatchWin() : void
      {
         hasField$0 &= 4227858431;
         match_win$field = new int();
      }
      
      public function get hasMatchWin() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set matchWin(param1:int) : void
      {
         hasField$0 |= 67108864;
         match_win$field = param1;
      }
      
      public function get matchWin() : int
      {
         return match_win$field;
      }
      
      public function removeMatchFailed() : void
      {
         hasField$0 &= 4160749567;
         match_failed$field = new int();
      }
      
      public function get hasMatchFailed() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set matchFailed(param1:int) : void
      {
         hasField$0 |= 134217728;
         match_failed$field = param1;
      }
      
      public function get matchFailed() : int
      {
         return match_failed$field;
      }
      
      public function removeConsortiaGold() : void
      {
         hasField$0 &= 4026531839;
         consortia_gold$field = new int();
      }
      
      public function get hasConsortiaGold() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set consortiaGold(param1:int) : void
      {
         hasField$0 |= 268435456;
         consortia_gold$field = param1;
      }
      
      public function get consortiaGold() : int
      {
         return consortia_gold$field;
      }
      
      public function removeConsortiaPhysique() : void
      {
         hasField$0 &= 3758096383;
         consortia_physique$field = new int();
      }
      
      public function get hasConsortiaPhysique() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set consortiaPhysique(param1:int) : void
      {
         hasField$0 |= 536870912;
         consortia_physique$field = param1;
      }
      
      public function get consortiaPhysique() : int
      {
         return consortia_physique$field;
      }
      
      public function removeRight() : void
      {
         hasField$0 &= 3221225471;
         right$field = new int();
      }
      
      public function get hasRight() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set right(param1:int) : void
      {
         hasField$0 |= 1073741824;
         right$field = param1;
      }
      
      public function get right() : int
      {
         return right$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 2147483647;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 2147483648;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeLeedProcess() : void
      {
         hasField$1 &= 4294967294;
         leed_process$field = new int();
      }
      
      public function get hasLeedProcess() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set leedProcess(param1:int) : void
      {
         hasField$1 |= 1;
         leed_process$field = param1;
      }
      
      public function get leedProcess() : int
      {
         return leed_process$field;
      }
      
      public function removeStarCount() : void
      {
         hasField$1 &= 4294967293;
         star_count$field = new int();
      }
      
      public function get hasStarCount() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set starCount(param1:int) : void
      {
         hasField$1 |= 2;
         star_count$field = param1;
      }
      
      public function get starCount() : int
      {
         return star_count$field;
      }
      
      public function removeSignDate() : void
      {
         signDate$field = null;
      }
      
      public function get hasSignDate() : Boolean
      {
         return signDate$field != null;
      }
      
      public function set signDate(param1:String) : void
      {
         signDate$field = param1;
      }
      
      public function get signDate() : String
      {
         return signDate$field;
      }
      
      public function removeSignTimes() : void
      {
         hasField$1 &= 4294967291;
         signTimes$field = new int();
      }
      
      public function get hasSignTimes() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set signTimes(param1:int) : void
      {
         hasField$1 |= 4;
         signTimes$field = param1;
      }
      
      public function get signTimes() : int
      {
         return signTimes$field;
      }
      
      public function removeSignSite() : void
      {
         hasField$1 &= 4294967287;
         signSite$field = new int();
      }
      
      public function get hasSignSite() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set signSite(param1:int) : void
      {
         hasField$1 |= 8;
         signSite$field = param1;
      }
      
      public function get signSite() : int
      {
         return signSite$field;
      }
      
      public function removeOrder() : void
      {
         order$field = null;
      }
      
      public function get hasOrder() : Boolean
      {
         return order$field != null;
      }
      
      public function set order(param1:PlayerOrderMsg) : void
      {
         order$field = param1;
      }
      
      public function get order() : PlayerOrderMsg
      {
         return order$field;
      }
      
      public function removeStartFree() : void
      {
         hasField$1 &= 4294967279;
         startFree$field = new int();
      }
      
      public function get hasStartFree() : Boolean
      {
         return (hasField$1 & 0x10) != 0;
      }
      
      public function set startFree(param1:int) : void
      {
         hasField$1 |= 16;
         startFree$field = param1;
      }
      
      public function get startFree() : int
      {
         return startFree$field;
      }
      
      public function removeTotalGp() : void
      {
         totalGp$field = null;
      }
      
      public function get hasTotalGp() : Boolean
      {
         return totalGp$field != null;
      }
      
      public function set totalGp(param1:Int64) : void
      {
         totalGp$field = param1;
      }
      
      public function get totalGp() : Int64
      {
         return totalGp$field;
      }
      
      public function removeRefuseFriend() : void
      {
         hasField$1 &= 4294967263;
         refuseFriend$field = new Boolean();
      }
      
      public function get hasRefuseFriend() : Boolean
      {
         return (hasField$1 & 0x20) != 0;
      }
      
      public function set refuseFriend(param1:Boolean) : void
      {
         hasField$1 |= 32;
         refuseFriend$field = param1;
      }
      
      public function get refuseFriend() : Boolean
      {
         return refuseFriend$field;
      }
      
      public function removeRefuseInvite() : void
      {
         hasField$1 &= 4294967231;
         refuseInvite$field = new Boolean();
      }
      
      public function get hasRefuseInvite() : Boolean
      {
         return (hasField$1 & 0x40) != 0;
      }
      
      public function set refuseInvite(param1:Boolean) : void
      {
         hasField$1 |= 64;
         refuseInvite$field = param1;
      }
      
      public function get refuseInvite() : Boolean
      {
         return refuseInvite$field;
      }
      
      public function removeConsortiaTotaloffer() : void
      {
         hasField$1 &= 4294967167;
         consortia_totaloffer$field = new int();
      }
      
      public function get hasConsortiaTotaloffer() : Boolean
      {
         return (hasField$1 & 0x80) != 0;
      }
      
      public function set consortiaTotaloffer(param1:int) : void
      {
         hasField$1 |= 128;
         consortia_totaloffer$field = param1;
      }
      
      public function get consortiaTotaloffer() : int
      {
         return consortia_totaloffer$field;
      }
      
      public function removeShowVersion() : void
      {
         hasField$1 &= 4294967039;
         show_version$field = new Boolean();
      }
      
      public function get hasShowVersion() : Boolean
      {
         return (hasField$1 & 0x0100) != 0;
      }
      
      public function set showVersion(param1:Boolean) : void
      {
         hasField$1 |= 256;
         show_version$field = param1;
      }
      
      public function get showVersion() : Boolean
      {
         return show_version$field;
      }
      
      public function removeCampaignCount() : void
      {
         hasField$1 &= 4294966783;
         campaign_count$field = new int();
      }
      
      public function get hasCampaignCount() : Boolean
      {
         return (hasField$1 & 0x0200) != 0;
      }
      
      public function set campaignCount(param1:int) : void
      {
         hasField$1 |= 512;
         campaign_count$field = param1;
      }
      
      public function get campaignCount() : int
      {
         return campaign_count$field;
      }
      
      public function removeTimeRun() : void
      {
         hasField$1 &= 4294966271;
         time_run$field = new int();
      }
      
      public function get hasTimeRun() : Boolean
      {
         return (hasField$1 & 0x0400) != 0;
      }
      
      public function set timeRun(param1:int) : void
      {
         hasField$1 |= 1024;
         time_run$field = param1;
      }
      
      public function get timeRun() : int
      {
         return time_run$field;
      }
      
      public function removeQteGuide() : void
      {
         hasField$1 &= 4294965247;
         qte_guide$field = new int();
      }
      
      public function get hasQteGuide() : Boolean
      {
         return (hasField$1 & 0x0800) != 0;
      }
      
      public function set qteGuide(param1:int) : void
      {
         hasField$1 |= 2048;
         qte_guide$field = param1;
      }
      
      public function get qteGuide() : int
      {
         return qte_guide$field;
      }
      
      public function removeStarpoint() : void
      {
         hasField$1 &= 4294963199;
         starpoint$field = new int();
      }
      
      public function get hasStarpoint() : Boolean
      {
         return (hasField$1 & 0x1000) != 0;
      }
      
      public function set starpoint(param1:int) : void
      {
         hasField$1 |= 4096;
         starpoint$field = param1;
      }
      
      public function get starpoint() : int
      {
         return starpoint$field;
      }
      
      public function removeIsAuto() : void
      {
         hasField$1 &= 4294959103;
         is_auto$field = new Boolean();
      }
      
      public function get hasIsAuto() : Boolean
      {
         return (hasField$1 & 0x2000) != 0;
      }
      
      public function set isAuto(param1:Boolean) : void
      {
         hasField$1 |= 8192;
         is_auto$field = param1;
      }
      
      public function get isAuto() : Boolean
      {
         return is_auto$field;
      }
      
      public function removeLastOutConsortia() : void
      {
         lastOutConsortia$field = null;
      }
      
      public function get hasLastOutConsortia() : Boolean
      {
         return lastOutConsortia$field != null;
      }
      
      public function set lastOutConsortia(param1:String) : void
      {
         lastOutConsortia$field = param1;
      }
      
      public function get lastOutConsortia() : String
      {
         return lastOutConsortia$field;
      }
      
      public function removeGeste() : void
      {
         hasField$1 &= 4294950911;
         geste$field = new int();
      }
      
      public function get hasGeste() : Boolean
      {
         return (hasField$1 & 0x4000) != 0;
      }
      
      public function set geste(param1:int) : void
      {
         hasField$1 |= 16384;
         geste$field = param1;
      }
      
      public function get geste() : int
      {
         return geste$field;
      }
      
      public function removeStoreGrade() : void
      {
         hasField$1 &= 4294934527;
         storeGrade$field = new int();
      }
      
      public function get hasStoreGrade() : Boolean
      {
         return (hasField$1 & 0x8000) != 0;
      }
      
      public function set storeGrade(param1:int) : void
      {
         hasField$1 |= 32768;
         storeGrade$field = param1;
      }
      
      public function get storeGrade() : int
      {
         return storeGrade$field;
      }
      
      public function removeStoreGp() : void
      {
         hasField$1 &= 4294901759;
         storeGp$field = new int();
      }
      
      public function get hasStoreGp() : Boolean
      {
         return (hasField$1 & 0x010000) != 0;
      }
      
      public function set storeGp(param1:int) : void
      {
         hasField$1 |= 65536;
         storeGp$field = param1;
      }
      
      public function get storeGp() : int
      {
         return storeGp$field;
      }
      
      public function removeReloginProcess() : void
      {
         hasField$1 &= 4294836223;
         relogin_process$field = new int();
      }
      
      public function get hasReloginProcess() : Boolean
      {
         return (hasField$1 & 0x020000) != 0;
      }
      
      public function set reloginProcess(param1:int) : void
      {
         hasField$1 |= 131072;
         relogin_process$field = param1;
      }
      
      public function get reloginProcess() : int
      {
         return relogin_process$field;
      }
      
      public function removeReloginCount() : void
      {
         hasField$1 &= 4294705151;
         relogin_count$field = new int();
      }
      
      public function get hasReloginCount() : Boolean
      {
         return (hasField$1 & 0x040000) != 0;
      }
      
      public function set reloginCount(param1:int) : void
      {
         hasField$1 |= 262144;
         relogin_count$field = param1;
      }
      
      public function get reloginCount() : int
      {
         return relogin_count$field;
      }
      
      public function removeBlessingCount() : void
      {
         hasField$1 &= 4294443007;
         blessingCount$field = new int();
      }
      
      public function get hasBlessingCount() : Boolean
      {
         return (hasField$1 & 0x080000) != 0;
      }
      
      public function set blessingCount(param1:int) : void
      {
         hasField$1 |= 524288;
         blessingCount$field = param1;
      }
      
      public function get blessingCount() : int
      {
         return blessingCount$field;
      }
      
      public function removeBlessingBuff() : void
      {
         hasField$1 &= 4293918719;
         blessingBuff$field = new int();
      }
      
      public function get hasBlessingBuff() : Boolean
      {
         return (hasField$1 & 0x100000) != 0;
      }
      
      public function set blessingBuff(param1:int) : void
      {
         hasField$1 |= 1048576;
         blessingBuff$field = param1;
      }
      
      public function get blessingBuff() : int
      {
         return blessingBuff$field;
      }
      
      public function removeBlessingMaxCount() : void
      {
         hasField$1 &= 4292870143;
         blessingMaxCount$field = new int();
      }
      
      public function get hasBlessingMaxCount() : Boolean
      {
         return (hasField$1 & 0x200000) != 0;
      }
      
      public function set blessingMaxCount(param1:int) : void
      {
         hasField$1 |= 2097152;
         blessingMaxCount$field = param1;
      }
      
      public function get blessingMaxCount() : int
      {
         return blessingMaxCount$field;
      }
      
      public function removeFirstCharge() : void
      {
         hasField$1 &= 4290772991;
         first_charge$field = new Boolean();
      }
      
      public function get hasFirstCharge() : Boolean
      {
         return (hasField$1 & 0x400000) != 0;
      }
      
      public function set firstCharge(param1:Boolean) : void
      {
         hasField$1 |= 4194304;
         first_charge$field = param1;
      }
      
      public function get firstCharge() : Boolean
      {
         return first_charge$field;
      }
      
      public function removeCharm() : void
      {
         hasField$1 &= 4286578687;
         charm$field = new int();
      }
      
      public function get hasCharm() : Boolean
      {
         return (hasField$1 & 0x800000) != 0;
      }
      
      public function set charm(param1:int) : void
      {
         hasField$1 |= 8388608;
         charm$field = param1;
      }
      
      public function get charm() : int
      {
         return charm$field;
      }
      
      public function removeMatchRoomCount() : void
      {
         hasField$1 &= 4278190079;
         match_room_count$field = new int();
      }
      
      public function get hasMatchRoomCount() : Boolean
      {
         return (hasField$1 & 0x01000000) != 0;
      }
      
      public function set matchRoomCount(param1:int) : void
      {
         hasField$1 |= 16777216;
         match_room_count$field = param1;
      }
      
      public function get matchRoomCount() : int
      {
         return match_room_count$field;
      }
      
      public function removeKingBuff() : void
      {
         hasField$1 &= 4261412863;
         king_buff$field = new Boolean();
      }
      
      public function get hasKingBuff() : Boolean
      {
         return (hasField$1 & 0x02000000) != 0;
      }
      
      public function set kingBuff(param1:Boolean) : void
      {
         hasField$1 |= 33554432;
         king_buff$field = param1;
      }
      
      public function get kingBuff() : Boolean
      {
         return king_buff$field;
      }
      
      public function removeLeaveGp() : void
      {
         hasField$1 &= 4227858431;
         leave_gp$field = new int();
      }
      
      public function get hasLeaveGp() : Boolean
      {
         return (hasField$1 & 0x04000000) != 0;
      }
      
      public function set leaveGp(param1:int) : void
      {
         hasField$1 |= 67108864;
         leave_gp$field = param1;
      }
      
      public function get leaveGp() : int
      {
         return leave_gp$field;
      }
      
      public function removeAltarConsortiaId() : void
      {
         hasField$1 &= 4160749567;
         altar_consortiaId$field = new int();
      }
      
      public function get hasAltarConsortiaId() : Boolean
      {
         return (hasField$1 & 0x08000000) != 0;
      }
      
      public function set altarConsortiaId(param1:int) : void
      {
         hasField$1 |= 134217728;
         altar_consortiaId$field = param1;
      }
      
      public function get altarConsortiaId() : int
      {
         return altar_consortiaId$field;
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
      
      public function removeRewardTimes() : void
      {
         hasField$1 &= 4026531839;
         reward_times$field = new int();
      }
      
      public function get hasRewardTimes() : Boolean
      {
         return (hasField$1 & 0x10000000) != 0;
      }
      
      public function set rewardTimes(param1:int) : void
      {
         hasField$1 |= 268435456;
         reward_times$field = param1;
      }
      
      public function get rewardTimes() : int
      {
         return reward_times$field;
      }
      
      public function removeWarFieldCount() : void
      {
         hasField$1 &= 3758096383;
         war_field_count$field = new int();
      }
      
      public function get hasWarFieldCount() : Boolean
      {
         return (hasField$1 & 0x20000000) != 0;
      }
      
      public function set warFieldCount(param1:int) : void
      {
         hasField$1 |= 536870912;
         war_field_count$field = param1;
      }
      
      public function get warFieldCount() : int
      {
         return war_field_count$field;
      }
      
      public function removeTrialCount() : void
      {
         hasField$1 &= 3221225471;
         trial_count$field = new int();
      }
      
      public function get hasTrialCount() : Boolean
      {
         return (hasField$1 & 0x40000000) != 0;
      }
      
      public function set trialCount(param1:int) : void
      {
         hasField$1 |= 1073741824;
         trial_count$field = param1;
      }
      
      public function get trialCount() : int
      {
         return trial_count$field;
      }
      
      public function removeAppellId() : void
      {
         hasField$1 &= 2147483647;
         appell_id$field = new int();
      }
      
      public function get hasAppellId() : Boolean
      {
         return (hasField$1 & 0x80000000) != 0;
      }
      
      public function set appellId(param1:int) : void
      {
         hasField$1 |= 2147483648;
         appell_id$field = param1;
      }
      
      public function get appellId() : int
      {
         return appell_id$field;
      }
      
      public function removeCrossScore() : void
      {
         hasField$2 &= 4294967294;
         cross_score$field = new int();
      }
      
      public function get hasCrossScore() : Boolean
      {
         return (hasField$2 & 1) != 0;
      }
      
      public function set crossScore(param1:int) : void
      {
         hasField$2 |= 1;
         cross_score$field = param1;
      }
      
      public function get crossScore() : int
      {
         return cross_score$field;
      }
      
      public function removeTrialMaxCount() : void
      {
         hasField$2 &= 4294967293;
         trial_max_count$field = new int();
      }
      
      public function get hasTrialMaxCount() : Boolean
      {
         return (hasField$2 & 2) != 0;
      }
      
      public function set trialMaxCount(param1:int) : void
      {
         hasField$2 |= 2;
         trial_max_count$field = param1;
      }
      
      public function get trialMaxCount() : int
      {
         return trial_max_count$field;
      }
      
      public function removeWearyLimit() : void
      {
         hasField$2 &= 4294967291;
         weary_limit$field = new int();
      }
      
      public function get hasWearyLimit() : Boolean
      {
         return (hasField$2 & 4) != 0;
      }
      
      public function set wearyLimit(param1:int) : void
      {
         hasField$2 |= 4;
         weary_limit$field = param1;
      }
      
      public function get wearyLimit() : int
      {
         return weary_limit$field;
      }
      
      public function removeLordsScore() : void
      {
         hasField$2 &= 4294967287;
         lords_score$field = new int();
      }
      
      public function get hasLordsScore() : Boolean
      {
         return (hasField$2 & 8) != 0;
      }
      
      public function set lordsScore(param1:int) : void
      {
         hasField$2 |= 8;
         lords_score$field = param1;
      }
      
      public function get lordsScore() : int
      {
         return lords_score$field;
      }
      
      public function removeIsReceived() : void
      {
         hasField$2 &= 4294967279;
         is_received$field = new Boolean();
      }
      
      public function get hasIsReceived() : Boolean
      {
         return (hasField$2 & 0x10) != 0;
      }
      
      public function set isReceived(param1:Boolean) : void
      {
         hasField$2 |= 16;
         is_received$field = param1;
      }
      
      public function get isReceived() : Boolean
      {
         return is_received$field;
      }
      
      public function removeMineScore() : void
      {
         hasField$2 &= 4294967263;
         mine_score$field = new int();
      }
      
      public function get hasMineScore() : Boolean
      {
         return (hasField$2 & 0x20) != 0;
      }
      
      public function set mineScore(param1:int) : void
      {
         hasField$2 |= 32;
         mine_score$field = param1;
      }
      
      public function get mineScore() : int
      {
         return mine_score$field;
      }
      
      public function removeIsBackPlayer() : void
      {
         hasField$2 &= 4294967231;
         is_back_player$field = new Boolean();
      }
      
      public function get hasIsBackPlayer() : Boolean
      {
         return (hasField$2 & 0x40) != 0;
      }
      
      public function set isBackPlayer(param1:Boolean) : void
      {
         hasField$2 |= 64;
         is_back_player$field = param1;
      }
      
      public function get isBackPlayer() : Boolean
      {
         return is_back_player$field;
      }
      
      public function removeRefuseTeamInvite() : void
      {
         hasField$2 &= 4294967167;
         refuseTeamInvite$field = new Boolean();
      }
      
      public function get hasRefuseTeamInvite() : Boolean
      {
         return (hasField$2 & 0x80) != 0;
      }
      
      public function set refuseTeamInvite(param1:Boolean) : void
      {
         hasField$2 |= 128;
         refuseTeamInvite$field = param1;
      }
      
      public function get refuseTeamInvite() : Boolean
      {
         return refuseTeamInvite$field;
      }
      
      public function removeCampaignMaxcount() : void
      {
         hasField$2 &= 4294967039;
         campaign_maxcount$field = new int();
      }
      
      public function get hasCampaignMaxcount() : Boolean
      {
         return (hasField$2 & 0x0100) != 0;
      }
      
      public function set campaignMaxcount(param1:int) : void
      {
         hasField$2 |= 256;
         campaign_maxcount$field = param1;
      }
      
      public function get campaignMaxcount() : int
      {
         return campaign_maxcount$field;
      }
      
      public function removeSeniorStoreGrade() : void
      {
         hasField$2 &= 4294966783;
         seniorStoreGrade$field = new int();
      }
      
      public function get hasSeniorStoreGrade() : Boolean
      {
         return (hasField$2 & 0x0200) != 0;
      }
      
      public function set seniorStoreGrade(param1:int) : void
      {
         hasField$2 |= 512;
         seniorStoreGrade$field = param1;
      }
      
      public function get seniorStoreGrade() : int
      {
         return seniorStoreGrade$field;
      }
      
      public function removeSeniorStoreGp() : void
      {
         hasField$2 &= 4294966271;
         seniorStoreGp$field = new int();
      }
      
      public function get hasSeniorStoreGp() : Boolean
      {
         return (hasField$2 & 0x0400) != 0;
      }
      
      public function set seniorStoreGp(param1:int) : void
      {
         hasField$2 |= 1024;
         seniorStoreGp$field = param1;
      }
      
      public function get seniorStoreGp() : int
      {
         return seniorStoreGp$field;
      }
      
      public function removeDragonCampaign_Count() : void
      {
         hasField$2 &= 4294965247;
         dragonCampaign_Count$field = new int();
      }
      
      public function get hasDragonCampaign_Count() : Boolean
      {
         return (hasField$2 & 0x0800) != 0;
      }
      
      public function set dragonCampaign_Count(param1:int) : void
      {
         hasField$2 |= 2048;
         dragonCampaign_Count$field = param1;
      }
      
      public function get dragonCampaign_Count() : int
      {
         return dragonCampaign_Count$field;
      }
      
      public function removeDragonCampaign_MaxCount() : void
      {
         hasField$2 &= 4294963199;
         dragonCampaign_MaxCount$field = new int();
      }
      
      public function get hasDragonCampaign_MaxCount() : Boolean
      {
         return (hasField$2 & 0x1000) != 0;
      }
      
      public function set dragonCampaign_MaxCount(param1:int) : void
      {
         hasField$2 |= 4096;
         dragonCampaign_MaxCount$field = param1;
      }
      
      public function get dragonCampaign_MaxCount() : int
      {
         return dragonCampaign_MaxCount$field;
      }
      
      public function removeCrossGuildScore() : void
      {
         hasField$2 &= 4294959103;
         cross_guild_score$field = new int();
      }
      
      public function get hasCrossGuildScore() : Boolean
      {
         return (hasField$2 & 0x2000) != 0;
      }
      
      public function set crossGuildScore(param1:int) : void
      {
         hasField$2 |= 8192;
         cross_guild_score$field = param1;
      }
      
      public function get crossGuildScore() : int
      {
         return cross_guild_score$field;
      }
      
      public function removeCrossLeagueMedal() : void
      {
         hasField$2 &= 4294950911;
         cross_league_medal$field = new int();
      }
      
      public function get hasCrossLeagueMedal() : Boolean
      {
         return (hasField$2 & 0x4000) != 0;
      }
      
      public function set crossLeagueMedal(param1:int) : void
      {
         hasField$2 |= 16384;
         cross_league_medal$field = param1;
      }
      
      public function get crossLeagueMedal() : int
      {
         return cross_league_medal$field;
      }
      
      public function removeApplleProperty_Open() : void
      {
         hasField$2 &= 4294934527;
         applle_property_Open$field = new Boolean();
      }
      
      public function get hasApplleProperty_Open() : Boolean
      {
         return (hasField$2 & 0x8000) != 0;
      }
      
      public function set applleProperty_Open(param1:Boolean) : void
      {
         hasField$2 |= 32768;
         applle_property_Open$field = param1;
      }
      
      public function get applleProperty_Open() : Boolean
      {
         return applle_property_Open$field;
      }
      
      public function removeHasVicePassword() : void
      {
         hasField$2 &= 4294901759;
         hasVicePassword$field = new int();
      }
      
      public function get hasHasVicePassword() : Boolean
      {
         return (hasField$2 & 0x010000) != 0;
      }
      
      public function set hasVicePassword(param1:int) : void
      {
         hasField$2 |= 65536;
         hasVicePassword$field = param1;
      }
      
      public function get hasVicePassword() : int
      {
         return hasVicePassword$field;
      }
      
      public function removeIsDuringToResetTime() : void
      {
         hasField$2 &= 4294836223;
         isDuringToResetTime$field = new int();
      }
      
      public function get hasIsDuringToResetTime() : Boolean
      {
         return (hasField$2 & 0x020000) != 0;
      }
      
      public function set isDuringToResetTime(param1:int) : void
      {
         hasField$2 |= 131072;
         isDuringToResetTime$field = param1;
      }
      
      public function get isDuringToResetTime() : int
      {
         return isDuringToResetTime$field;
      }
      
      public function removeRentalBagTime() : void
      {
         rentalBagTime$field = null;
      }
      
      public function get hasRentalBagTime() : Boolean
      {
         return rentalBagTime$field != null;
      }
      
      public function set rentalBagTime(param1:String) : void
      {
         rentalBagTime$field = param1;
      }
      
      public function get rentalBagTime() : String
      {
         return rentalBagTime$field;
      }
      
      public function removeStatus() : void
      {
         hasField$2 &= 4294705151;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$2 & 0x040000) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$2 |= 262144;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      public function removeNewPowerLv() : void
      {
         hasField$2 &= 4294443007;
         new_power_lv$field = new int();
      }
      
      public function get hasNewPowerLv() : Boolean
      {
         return (hasField$2 & 0x080000) != 0;
      }
      
      public function set newPowerLv(param1:int) : void
      {
         hasField$2 |= 524288;
         new_power_lv$field = param1;
      }
      
      public function get newPowerLv() : int
      {
         return new_power_lv$field;
      }
      
      public function removeNewAgilityLv() : void
      {
         hasField$2 &= 4293918719;
         new_agility_lv$field = new int();
      }
      
      public function get hasNewAgilityLv() : Boolean
      {
         return (hasField$2 & 0x100000) != 0;
      }
      
      public function set newAgilityLv(param1:int) : void
      {
         hasField$2 |= 1048576;
         new_agility_lv$field = param1;
      }
      
      public function get newAgilityLv() : int
      {
         return new_agility_lv$field;
      }
      
      public function removeNewIntellectLv() : void
      {
         hasField$2 &= 4292870143;
         new_intellect_lv$field = new int();
      }
      
      public function get hasNewIntellectLv() : Boolean
      {
         return (hasField$2 & 0x200000) != 0;
      }
      
      public function set newIntellectLv(param1:int) : void
      {
         hasField$2 |= 2097152;
         new_intellect_lv$field = param1;
      }
      
      public function get newIntellectLv() : int
      {
         return new_intellect_lv$field;
      }
      
      public function removeNewPhysiqueLv() : void
      {
         hasField$2 &= 4290772991;
         new_physique_lv$field = new int();
      }
      
      public function get hasNewPhysiqueLv() : Boolean
      {
         return (hasField$2 & 0x400000) != 0;
      }
      
      public function set newPhysiqueLv(param1:int) : void
      {
         hasField$2 |= 4194304;
         new_physique_lv$field = param1;
      }
      
      public function get newPhysiqueLv() : int
      {
         return new_physique_lv$field;
      }
      
      public function removeFamGpLv() : void
      {
         hasField$2 &= 4286578687;
         fam_gp_lv$field = new int();
      }
      
      public function get hasFamGpLv() : Boolean
      {
         return (hasField$2 & 0x800000) != 0;
      }
      
      public function set famGpLv(param1:int) : void
      {
         hasField$2 |= 8388608;
         fam_gp_lv$field = param1;
      }
      
      public function get famGpLv() : int
      {
         return fam_gp_lv$field;
      }
      
      public function removeMedalLv() : void
      {
         hasField$2 &= 4278190079;
         medal_lv$field = new int();
      }
      
      public function get hasMedalLv() : Boolean
      {
         return (hasField$2 & 0x01000000) != 0;
      }
      
      public function set medalLv(param1:int) : void
      {
         hasField$2 |= 16777216;
         medal_lv$field = param1;
      }
      
      public function get medalLv() : int
      {
         return medal_lv$field;
      }
      
      public function removeHonorLv() : void
      {
         hasField$2 &= 4261412863;
         honor_lv$field = new int();
      }
      
      public function get hasHonorLv() : Boolean
      {
         return (hasField$2 & 0x02000000) != 0;
      }
      
      public function set honorLv(param1:int) : void
      {
         hasField$2 |= 33554432;
         honor_lv$field = param1;
      }
      
      public function get honorLv() : int
      {
         return honor_lv$field;
      }
      
      public function removePropertyLv() : void
      {
         hasField$2 &= 4227858431;
         property_lv$field = new int();
      }
      
      public function get hasPropertyLv() : Boolean
      {
         return (hasField$2 & 0x04000000) != 0;
      }
      
      public function set propertyLv(param1:int) : void
      {
         hasField$2 |= 67108864;
         property_lv$field = param1;
      }
      
      public function get propertyLv() : int
      {
         return property_lv$field;
      }
      
      public function removeLeadExtractTimes() : void
      {
         hasField$2 &= 4160749567;
         leadExtractTimes$field = new int();
      }
      
      public function get hasLeadExtractTimes() : Boolean
      {
         return (hasField$2 & 0x08000000) != 0;
      }
      
      public function set leadExtractTimes(param1:int) : void
      {
         hasField$2 |= 134217728;
         leadExtractTimes$field = param1;
      }
      
      public function get leadExtractTimes() : int
      {
         return leadExtractTimes$field;
      }
      
      public function removeRandomBossCount() : void
      {
         hasField$2 &= 4026531839;
         randomBossCount$field = new int();
      }
      
      public function get hasRandomBossCount() : Boolean
      {
         return (hasField$2 & 0x10000000) != 0;
      }
      
      public function set randomBossCount(param1:int) : void
      {
         hasField$2 |= 268435456;
         randomBossCount$field = param1;
      }
      
      public function get randomBossCount() : int
      {
         return randomBossCount$field;
      }
      
      public function removeMonopolyCampaignCount() : void
      {
         hasField$2 &= 3758096383;
         monopolyCampaignCount$field = new int();
      }
      
      public function get hasMonopolyCampaignCount() : Boolean
      {
         return (hasField$2 & 0x20000000) != 0;
      }
      
      public function set monopolyCampaignCount(param1:int) : void
      {
         hasField$2 |= 536870912;
         monopolyCampaignCount$field = param1;
      }
      
      public function get monopolyCampaignCount() : int
      {
         return monopolyCampaignCount$field;
      }
      
      public function removeJumpNovice() : void
      {
         hasField$2 &= 3221225471;
         jump_novice$field = new Boolean();
      }
      
      public function get hasJumpNovice() : Boolean
      {
         return (hasField$2 & 0x40000000) != 0;
      }
      
      public function set jumpNovice(param1:Boolean) : void
      {
         hasField$2 |= 1073741824;
         jump_novice$field = param1;
      }
      
      public function get jumpNovice() : Boolean
      {
         return jump_novice$field;
      }
      
      public function removeSkills() : void
      {
         skills$field = null;
      }
      
      public function get hasSkills() : Boolean
      {
         return skills$field != null;
      }
      
      public function set skills(param1:String) : void
      {
         skills$field = param1;
      }
      
      public function get skills() : String
      {
         return skills$field;
      }
      
      public function removeSkillGrade() : void
      {
         skill_grade$field = null;
      }
      
      public function get hasSkillGrade() : Boolean
      {
         return skill_grade$field != null;
      }
      
      public function set skillGrade(param1:String) : void
      {
         skill_grade$field = param1;
      }
      
      public function get skillGrade() : String
      {
         return skill_grade$field;
      }
      
      public function removeSkillProficiency() : void
      {
         skill_proficiency$field = null;
      }
      
      public function get hasSkillProficiency() : Boolean
      {
         return skill_proficiency$field != null;
      }
      
      public function set skillProficiency(param1:String) : void
      {
         skill_proficiency$field = param1;
      }
      
      public function get skillProficiency() : String
      {
         return skill_proficiency$field;
      }
      
      public function removeIsCost() : void
      {
         hasField$2 &= 2147483647;
         is_cost$field = new Boolean();
      }
      
      public function get hasIsCost() : Boolean
      {
         return (hasField$2 & 0x80000000) != 0;
      }
      
      public function set isCost(param1:Boolean) : void
      {
         hasField$2 |= 2147483648;
         is_cost$field = param1;
      }
      
      public function get isCost() : Boolean
      {
         return is_cost$field;
      }
      
      public function removeSkillComposeTimes() : void
      {
         hasField$3 &= 4294967294;
         skill_compose_times$field = new int();
      }
      
      public function get hasSkillComposeTimes() : Boolean
      {
         return (hasField$3 & 1) != 0;
      }
      
      public function set skillComposeTimes(param1:int) : void
      {
         hasField$3 |= 1;
         skill_compose_times$field = param1;
      }
      
      public function get skillComposeTimes() : int
      {
         return skill_compose_times$field;
      }
      
      public function removeSkillCollectTimes() : void
      {
         hasField$3 &= 4294967293;
         skill_collect_times$field = new int();
      }
      
      public function get hasSkillCollectTimes() : Boolean
      {
         return (hasField$3 & 2) != 0;
      }
      
      public function set skillCollectTimes(param1:int) : void
      {
         hasField$3 |= 2;
         skill_collect_times$field = param1;
      }
      
      public function get skillCollectTimes() : int
      {
         return skill_collect_times$field;
      }
      
      public function removeComposeId() : void
      {
         composeId$field = null;
      }
      
      public function get hasComposeId() : Boolean
      {
         return composeId$field != null;
      }
      
      public function set composeId(param1:String) : void
      {
         composeId$field = param1;
      }
      
      public function get composeId() : String
      {
         return composeId$field;
      }
      
      public function removeTeamCount() : void
      {
         hasField$3 &= 4294967291;
         team_count$field = new int();
      }
      
      public function get hasTeamCount() : Boolean
      {
         return (hasField$3 & 4) != 0;
      }
      
      public function set teamCount(param1:int) : void
      {
         hasField$3 |= 4;
         team_count$field = param1;
      }
      
      public function get teamCount() : int
      {
         return team_count$field;
      }
      
      public function removeTeamMaxCount() : void
      {
         hasField$3 &= 4294967287;
         team_max_count$field = new int();
      }
      
      public function get hasTeamMaxCount() : Boolean
      {
         return (hasField$3 & 8) != 0;
      }
      
      public function set teamMaxCount(param1:int) : void
      {
         hasField$3 |= 8;
         team_max_count$field = param1;
      }
      
      public function get teamMaxCount() : int
      {
         return team_max_count$field;
      }
      
      public function removeSeekSurplusTime() : void
      {
         hasField$3 &= 4294967279;
         seekSurplusTime$field = new int();
      }
      
      public function get hasSeekSurplusTime() : Boolean
      {
         return (hasField$3 & 0x10) != 0;
      }
      
      public function set seekSurplusTime(param1:int) : void
      {
         hasField$3 |= 16;
         seekSurplusTime$field = param1;
      }
      
      public function get seekSurplusTime() : int
      {
         return seekSurplusTime$field;
      }
      
      public function removeRecoverGP() : void
      {
         hasField$3 &= 4294967263;
         recoverGP$field = new int();
      }
      
      public function get hasRecoverGP() : Boolean
      {
         return (hasField$3 & 0x20) != 0;
      }
      
      public function set recoverGP(param1:int) : void
      {
         hasField$3 |= 32;
         recoverGP$field = param1;
      }
      
      public function get recoverGP() : int
      {
         return recoverGP$field;
      }
      
      public function removeTerraTempleCount() : void
      {
         hasField$3 &= 4294967231;
         terra_temple_count$field = new int();
      }
      
      public function get hasTerraTempleCount() : Boolean
      {
         return (hasField$3 & 0x40) != 0;
      }
      
      public function set terraTempleCount(param1:int) : void
      {
         hasField$3 |= 64;
         terra_temple_count$field = param1;
      }
      
      public function get terraTempleCount() : int
      {
         return terra_temple_count$field;
      }
      
      public function removeTerraTempleMaxCount() : void
      {
         hasField$3 &= 4294967167;
         terra_temple_max_count$field = new int();
      }
      
      public function get hasTerraTempleMaxCount() : Boolean
      {
         return (hasField$3 & 0x80) != 0;
      }
      
      public function set terraTempleMaxCount(param1:int) : void
      {
         hasField$3 |= 128;
         terra_temple_max_count$field = param1;
      }
      
      public function get terraTempleMaxCount() : int
      {
         return terra_temple_max_count$field;
      }
      
      public function removeLastFreeSkillLearnTime() : void
      {
         lastFreeSkillLearnTime$field = null;
      }
      
      public function get hasLastFreeSkillLearnTime() : Boolean
      {
         return lastFreeSkillLearnTime$field != null;
      }
      
      public function set lastFreeSkillLearnTime(param1:String) : void
      {
         lastFreeSkillLearnTime$field = param1;
      }
      
      public function get lastFreeSkillLearnTime() : String
      {
         return lastFreeSkillLearnTime$field;
      }
      
      public function removeStoneBagCount() : void
      {
         hasField$3 &= 4294967039;
         stoneBagCount$field = new int();
      }
      
      public function get hasStoneBagCount() : Boolean
      {
         return (hasField$3 & 0x0100) != 0;
      }
      
      public function set stoneBagCount(param1:int) : void
      {
         hasField$3 |= 256;
         stoneBagCount$field = param1;
      }
      
      public function get stoneBagCount() : int
      {
         return stoneBagCount$field;
      }
      
      public function removeTramcarCount() : void
      {
         hasField$3 &= 4294966783;
         tramcarCount$field = new int();
      }
      
      public function get hasTramcarCount() : Boolean
      {
         return (hasField$3 & 0x0200) != 0;
      }
      
      public function set tramcarCount(param1:int) : void
      {
         hasField$3 |= 512;
         tramcarCount$field = param1;
      }
      
      public function get tramcarCount() : int
      {
         return tramcarCount$field;
      }
      
      public function removeWeekCampaignCount() : void
      {
         hasField$3 &= 4294966271;
         weekCampaignCount$field = new int();
      }
      
      public function get hasWeekCampaignCount() : Boolean
      {
         return (hasField$3 & 0x0400) != 0;
      }
      
      public function set weekCampaignCount(param1:int) : void
      {
         hasField$3 |= 1024;
         weekCampaignCount$field = param1;
      }
      
      public function get weekCampaignCount() : int
      {
         return weekCampaignCount$field;
      }
      
      public function removeWeekCampaignMaxCount() : void
      {
         hasField$3 &= 4294965247;
         weekCampaignMaxCount$field = new int();
      }
      
      public function get hasWeekCampaignMaxCount() : Boolean
      {
         return (hasField$3 & 0x0800) != 0;
      }
      
      public function set weekCampaignMaxCount(param1:int) : void
      {
         hasField$3 |= 2048;
         weekCampaignMaxCount$field = param1;
      }
      
      public function get weekCampaignMaxCount() : int
      {
         return weekCampaignMaxCount$field;
      }
      
      public function removeTrialTowerCampaignCount() : void
      {
         hasField$3 &= 4294963199;
         trialTowerCampaignCount$field = new int();
      }
      
      public function get hasTrialTowerCampaignCount() : Boolean
      {
         return (hasField$3 & 0x1000) != 0;
      }
      
      public function set trialTowerCampaignCount(param1:int) : void
      {
         hasField$3 |= 4096;
         trialTowerCampaignCount$field = param1;
      }
      
      public function get trialTowerCampaignCount() : int
      {
         return trialTowerCampaignCount$field;
      }
      
      public function removeTrialTowerCampaignMaxCount() : void
      {
         hasField$3 &= 4294959103;
         trialTowerCampaignMaxCount$field = new int();
      }
      
      public function get hasTrialTowerCampaignMaxCount() : Boolean
      {
         return (hasField$3 & 0x2000) != 0;
      }
      
      public function set trialTowerCampaignMaxCount(param1:int) : void
      {
         hasField$3 |= 8192;
         trialTowerCampaignMaxCount$field = param1;
      }
      
      public function get trialTowerCampaignMaxCount() : int
      {
         return trialTowerCampaignMaxCount$field;
      }
      
      public function removeFantasyMatrixCampaignCount() : void
      {
         hasField$3 &= 4294950911;
         fantasyMatrixCampaignCount$field = new int();
      }
      
      public function get hasFantasyMatrixCampaignCount() : Boolean
      {
         return (hasField$3 & 0x4000) != 0;
      }
      
      public function set fantasyMatrixCampaignCount(param1:int) : void
      {
         hasField$3 |= 16384;
         fantasyMatrixCampaignCount$field = param1;
      }
      
      public function get fantasyMatrixCampaignCount() : int
      {
         return fantasyMatrixCampaignCount$field;
      }
      
      public function removeFantasyMatrixCampaignMaxCount() : void
      {
         hasField$3 &= 4294934527;
         fantasyMatrixCampaignMaxCount$field = new int();
      }
      
      public function get hasFantasyMatrixCampaignMaxCount() : Boolean
      {
         return (hasField$3 & 0x8000) != 0;
      }
      
      public function set fantasyMatrixCampaignMaxCount(param1:int) : void
      {
         hasField$3 |= 32768;
         fantasyMatrixCampaignMaxCount$field = param1;
      }
      
      public function get fantasyMatrixCampaignMaxCount() : int
      {
         return fantasyMatrixCampaignMaxCount$field;
      }
      
      public function removeBloodyRealmCampaignCount() : void
      {
         hasField$3 &= 4294901759;
         bloodyRealmCampaignCount$field = new int();
      }
      
      public function get hasBloodyRealmCampaignCount() : Boolean
      {
         return (hasField$3 & 0x010000) != 0;
      }
      
      public function set bloodyRealmCampaignCount(param1:int) : void
      {
         hasField$3 |= 65536;
         bloodyRealmCampaignCount$field = param1;
      }
      
      public function get bloodyRealmCampaignCount() : int
      {
         return bloodyRealmCampaignCount$field;
      }
      
      public function removeBloodyRealmCampaignMaxCount() : void
      {
         hasField$3 &= 4294836223;
         bloodyRealmCampaignMaxCount$field = new int();
      }
      
      public function get hasBloodyRealmCampaignMaxCount() : Boolean
      {
         return (hasField$3 & 0x020000) != 0;
      }
      
      public function set bloodyRealmCampaignMaxCount(param1:int) : void
      {
         hasField$3 |= 131072;
         bloodyRealmCampaignMaxCount$field = param1;
      }
      
      public function get bloodyRealmCampaignMaxCount() : int
      {
         return bloodyRealmCampaignMaxCount$field;
      }
      
      public function removeEquipmentRefiningGrade() : void
      {
         hasField$3 &= 4294705151;
         equipmentRefiningGrade$field = new int();
      }
      
      public function get hasEquipmentRefiningGrade() : Boolean
      {
         return (hasField$3 & 0x040000) != 0;
      }
      
      public function set equipmentRefiningGrade(param1:int) : void
      {
         hasField$3 |= 262144;
         equipmentRefiningGrade$field = param1;
      }
      
      public function get equipmentRefiningGrade() : int
      {
         return equipmentRefiningGrade$field;
      }
      
      public function removeEquipmentRefiningGp() : void
      {
         hasField$3 &= 4294443007;
         equipmentRefiningGp$field = new int();
      }
      
      public function get hasEquipmentRefiningGp() : Boolean
      {
         return (hasField$3 & 0x080000) != 0;
      }
      
      public function set equipmentRefiningGp(param1:int) : void
      {
         hasField$3 |= 524288;
         equipmentRefiningGp$field = param1;
      }
      
      public function get equipmentRefiningGp() : int
      {
         return equipmentRefiningGp$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removePetPveCount() : void
      {
         hasField$3 &= 4293918719;
         petPveCount$field = new int();
      }
      
      public function get hasPetPveCount() : Boolean
      {
         return (hasField$3 & 0x100000) != 0;
      }
      
      public function set petPveCount(param1:int) : void
      {
         hasField$3 |= 1048576;
         petPveCount$field = param1;
      }
      
      public function get petPveCount() : int
      {
         return petPveCount$field;
      }
      
      public function removePetPveMaxCount() : void
      {
         hasField$3 &= 4292870143;
         petPveMaxCount$field = new int();
      }
      
      public function get hasPetPveMaxCount() : Boolean
      {
         return (hasField$3 & 0x200000) != 0;
      }
      
      public function set petPveMaxCount(param1:int) : void
      {
         hasField$3 |= 2097152;
         petPveMaxCount$field = param1;
      }
      
      public function get petPveMaxCount() : int
      {
         return petPveMaxCount$field;
      }
      
      public function removeQuickPassCount() : void
      {
         hasField$3 &= 4290772991;
         quickPassCount$field = new int();
      }
      
      public function get hasQuickPassCount() : Boolean
      {
         return (hasField$3 & 0x400000) != 0;
      }
      
      public function set quickPassCount(param1:int) : void
      {
         hasField$3 |= 4194304;
         quickPassCount$field = param1;
      }
      
      public function get quickPassCount() : int
      {
         return quickPassCount$field;
      }
      
      public function removeGuardWarCount() : void
      {
         hasField$3 &= 4286578687;
         guardWarCount$field = new int();
      }
      
      public function get hasGuardWarCount() : Boolean
      {
         return (hasField$3 & 0x800000) != 0;
      }
      
      public function set guardWarCount(param1:int) : void
      {
         hasField$3 |= 8388608;
         guardWarCount$field = param1;
      }
      
      public function get guardWarCount() : int
      {
         return guardWarCount$field;
      }
      
      public function removeGuardWarMaxCount() : void
      {
         hasField$3 &= 4278190079;
         guardWarMaxCount$field = new int();
      }
      
      public function get hasGuardWarMaxCount() : Boolean
      {
         return (hasField$3 & 0x01000000) != 0;
      }
      
      public function set guardWarMaxCount(param1:int) : void
      {
         hasField$3 |= 16777216;
         guardWarMaxCount$field = param1;
      }
      
      public function get guardWarMaxCount() : int
      {
         return guardWarMaxCount$field;
      }
      
      public function removeTimeVortexCount() : void
      {
         hasField$3 &= 4261412863;
         time_vortex_count$field = new int();
      }
      
      public function get hasTimeVortexCount() : Boolean
      {
         return (hasField$3 & 0x02000000) != 0;
      }
      
      public function set timeVortexCount(param1:int) : void
      {
         hasField$3 |= 33554432;
         time_vortex_count$field = param1;
      }
      
      public function get timeVortexCount() : int
      {
         return time_vortex_count$field;
      }
      
      public function removeTimeVortexNode() : void
      {
         hasField$3 &= 4227858431;
         time_vortex_node$field = new int();
      }
      
      public function get hasTimeVortexNode() : Boolean
      {
         return (hasField$3 & 0x04000000) != 0;
      }
      
      public function set timeVortexNode(param1:int) : void
      {
         hasField$3 |= 67108864;
         time_vortex_node$field = param1;
      }
      
      public function get timeVortexNode() : int
      {
         return time_vortex_node$field;
      }
      
      public function removeIsOpenDragonTalker() : void
      {
         hasField$3 &= 4160749567;
         isOpenDragonTalker$field = new Boolean();
      }
      
      public function get hasIsOpenDragonTalker() : Boolean
      {
         return (hasField$3 & 0x08000000) != 0;
      }
      
      public function set isOpenDragonTalker(param1:Boolean) : void
      {
         hasField$3 |= 134217728;
         isOpenDragonTalker$field = param1;
      }
      
      public function get isOpenDragonTalker() : Boolean
      {
         return isOpenDragonTalker$field;
      }
      
      public function removeIsCurrentDragonTalker() : void
      {
         hasField$3 &= 4026531839;
         isCurrentDragonTalker$field = new Boolean();
      }
      
      public function get hasIsCurrentDragonTalker() : Boolean
      {
         return (hasField$3 & 0x10000000) != 0;
      }
      
      public function set isCurrentDragonTalker(param1:Boolean) : void
      {
         hasField$3 |= 268435456;
         isCurrentDragonTalker$field = param1;
      }
      
      public function get isCurrentDragonTalker() : Boolean
      {
         return isCurrentDragonTalker$field;
      }
      
      public function removeMasterPowerLv() : void
      {
         hasField$3 &= 3758096383;
         master_power_lv$field = new int();
      }
      
      public function get hasMasterPowerLv() : Boolean
      {
         return (hasField$3 & 0x20000000) != 0;
      }
      
      public function set masterPowerLv(param1:int) : void
      {
         hasField$3 |= 536870912;
         master_power_lv$field = param1;
      }
      
      public function get masterPowerLv() : int
      {
         return master_power_lv$field;
      }
      
      public function removeMasterAgilityLv() : void
      {
         hasField$3 &= 3221225471;
         master_agility_lv$field = new int();
      }
      
      public function get hasMasterAgilityLv() : Boolean
      {
         return (hasField$3 & 0x40000000) != 0;
      }
      
      public function set masterAgilityLv(param1:int) : void
      {
         hasField$3 |= 1073741824;
         master_agility_lv$field = param1;
      }
      
      public function get masterAgilityLv() : int
      {
         return master_agility_lv$field;
      }
      
      public function removeMasterIntellectLv() : void
      {
         hasField$3 &= 2147483647;
         master_intellect_lv$field = new int();
      }
      
      public function get hasMasterIntellectLv() : Boolean
      {
         return (hasField$3 & 0x80000000) != 0;
      }
      
      public function set masterIntellectLv(param1:int) : void
      {
         hasField$3 |= 2147483648;
         master_intellect_lv$field = param1;
      }
      
      public function get masterIntellectLv() : int
      {
         return master_intellect_lv$field;
      }
      
      public function removeMasterPhysiqueLv() : void
      {
         hasField$4 &= 4294967294;
         master_physique_lv$field = new int();
      }
      
      public function get hasMasterPhysiqueLv() : Boolean
      {
         return (hasField$4 & 1) != 0;
      }
      
      public function set masterPhysiqueLv(param1:int) : void
      {
         hasField$4 |= 1;
         master_physique_lv$field = param1;
      }
      
      public function get masterPhysiqueLv() : int
      {
         return master_physique_lv$field;
      }
      
      public function removeAbyssPrisonCount() : void
      {
         hasField$4 &= 4294967293;
         abyssPrisonCount$field = new int();
      }
      
      public function get hasAbyssPrisonCount() : Boolean
      {
         return (hasField$4 & 2) != 0;
      }
      
      public function set abyssPrisonCount(param1:int) : void
      {
         hasField$4 |= 2;
         abyssPrisonCount$field = param1;
      }
      
      public function get abyssPrisonCount() : int
      {
         return abyssPrisonCount$field;
      }
      
      public function removeAbyssPrisonMaxCount() : void
      {
         hasField$4 &= 4294967291;
         abyssPrisonMaxCount$field = new int();
      }
      
      public function get hasAbyssPrisonMaxCount() : Boolean
      {
         return (hasField$4 & 4) != 0;
      }
      
      public function set abyssPrisonMaxCount(param1:int) : void
      {
         hasField$4 |= 4;
         abyssPrisonMaxCount$field = param1;
      }
      
      public function get abyssPrisonMaxCount() : int
      {
         return abyssPrisonMaxCount$field;
      }
      
      public function removeBlackGoldCaveLeftCount() : void
      {
         hasField$4 &= 4294967287;
         BlackGoldCaveLeftCount$field = new int();
      }
      
      public function get hasBlackGoldCaveLeftCount() : Boolean
      {
         return (hasField$4 & 8) != 0;
      }
      
      public function set blackGoldCaveLeftCount(param1:int) : void
      {
         hasField$4 |= 8;
         BlackGoldCaveLeftCount$field = param1;
      }
      
      public function get blackGoldCaveLeftCount() : int
      {
         return BlackGoldCaveLeftCount$field;
      }
      
      public function removeBlackGoldCaveMaxCount() : void
      {
         hasField$4 &= 4294967279;
         BlackGoldCaveMaxCount$field = new int();
      }
      
      public function get hasBlackGoldCaveMaxCount() : Boolean
      {
         return (hasField$4 & 0x10) != 0;
      }
      
      public function set blackGoldCaveMaxCount(param1:int) : void
      {
         hasField$4 |= 16;
         BlackGoldCaveMaxCount$field = param1;
      }
      
      public function get blackGoldCaveMaxCount() : int
      {
         return BlackGoldCaveMaxCount$field;
      }
      
      public function removeRushCustomsLeftCount() : void
      {
         hasField$4 &= 4294967263;
         RushCustomsLeftCount$field = new int();
      }
      
      public function get hasRushCustomsLeftCount() : Boolean
      {
         return (hasField$4 & 0x20) != 0;
      }
      
      public function set rushCustomsLeftCount(param1:int) : void
      {
         hasField$4 |= 32;
         RushCustomsLeftCount$field = param1;
      }
      
      public function get rushCustomsLeftCount() : int
      {
         return RushCustomsLeftCount$field;
      }
      
      public function removeRushCustomsMaxCount() : void
      {
         hasField$4 &= 4294967231;
         RushCustomsMaxCount$field = new int();
      }
      
      public function get hasRushCustomsMaxCount() : Boolean
      {
         return (hasField$4 & 0x40) != 0;
      }
      
      public function set rushCustomsMaxCount(param1:int) : void
      {
         hasField$4 |= 64;
         RushCustomsMaxCount$field = param1;
      }
      
      public function get rushCustomsMaxCount() : int
      {
         return RushCustomsMaxCount$field;
      }
      
      public function removeElementSilvaMaxCount() : void
      {
         hasField$4 &= 4294967167;
         ElementSilvaMaxCount$field = new int();
      }
      
      public function get hasElementSilvaMaxCount() : Boolean
      {
         return (hasField$4 & 0x80) != 0;
      }
      
      public function set elementSilvaMaxCount(param1:int) : void
      {
         hasField$4 |= 128;
         ElementSilvaMaxCount$field = param1;
      }
      
      public function get elementSilvaMaxCount() : int
      {
         return ElementSilvaMaxCount$field;
      }
      
      public function removeElementSilvaLeftCount() : void
      {
         hasField$4 &= 4294967039;
         ElementSilvaLeftCount$field = new int();
      }
      
      public function get hasElementSilvaLeftCount() : Boolean
      {
         return (hasField$4 & 0x0100) != 0;
      }
      
      public function set elementSilvaLeftCount(param1:int) : void
      {
         hasField$4 |= 256;
         ElementSilvaLeftCount$field = param1;
      }
      
      public function get elementSilvaLeftCount() : int
      {
         return ElementSilvaLeftCount$field;
      }
      
      public function removeDungeonTurnLeftRewardCount() : void
      {
         hasField$4 &= 4294966783;
         DungeonTurnLeftRewardCount$field = new int();
      }
      
      public function get hasDungeonTurnLeftRewardCount() : Boolean
      {
         return (hasField$4 & 0x0200) != 0;
      }
      
      public function set dungeonTurnLeftRewardCount(param1:int) : void
      {
         hasField$4 |= 512;
         DungeonTurnLeftRewardCount$field = param1;
      }
      
      public function get dungeonTurnLeftRewardCount() : int
      {
         return DungeonTurnLeftRewardCount$field;
      }
      
      public function removeDungeonTurnMaxRewardCount() : void
      {
         hasField$4 &= 4294966271;
         DungeonTurnMaxRewardCount$field = new int();
      }
      
      public function get hasDungeonTurnMaxRewardCount() : Boolean
      {
         return (hasField$4 & 0x0400) != 0;
      }
      
      public function set dungeonTurnMaxRewardCount(param1:int) : void
      {
         hasField$4 |= 1024;
         DungeonTurnMaxRewardCount$field = param1;
      }
      
      public function get dungeonTurnMaxRewardCount() : int
      {
         return DungeonTurnMaxRewardCount$field;
      }
      
      public function removeTimeSpaceLeftRewardCount() : void
      {
         hasField$4 &= 4294965247;
         TimeSpaceLeftRewardCount$field = new int();
      }
      
      public function get hasTimeSpaceLeftRewardCount() : Boolean
      {
         return (hasField$4 & 0x0800) != 0;
      }
      
      public function set timeSpaceLeftRewardCount(param1:int) : void
      {
         hasField$4 |= 2048;
         TimeSpaceLeftRewardCount$field = param1;
      }
      
      public function get timeSpaceLeftRewardCount() : int
      {
         return TimeSpaceLeftRewardCount$field;
      }
      
      public function removeTimeSpaceMaxRewardCount() : void
      {
         hasField$4 &= 4294963199;
         TimeSpaceMaxRewardCount$field = new int();
      }
      
      public function get hasTimeSpaceMaxRewardCount() : Boolean
      {
         return (hasField$4 & 0x1000) != 0;
      }
      
      public function set timeSpaceMaxRewardCount(param1:int) : void
      {
         hasField$4 |= 4096;
         TimeSpaceMaxRewardCount$field = param1;
      }
      
      public function get timeSpaceMaxRewardCount() : int
      {
         return TimeSpaceMaxRewardCount$field;
      }
      
      public function removeSkyStepCount() : void
      {
         hasField$4 &= 4294959103;
         skyStepCount$field = new int();
      }
      
      public function get hasSkyStepCount() : Boolean
      {
         return (hasField$4 & 0x2000) != 0;
      }
      
      public function set skyStepCount(param1:int) : void
      {
         hasField$4 |= 8192;
         skyStepCount$field = param1;
      }
      
      public function get skyStepCount() : int
      {
         return skyStepCount$field;
      }
      
      public function removeSkyStepMaxCount() : void
      {
         hasField$4 &= 4294950911;
         skyStepMaxCount$field = new int();
      }
      
      public function get hasSkyStepMaxCount() : Boolean
      {
         return (hasField$4 & 0x4000) != 0;
      }
      
      public function set skyStepMaxCount(param1:int) : void
      {
         hasField$4 |= 16384;
         skyStepMaxCount$field = param1;
      }
      
      public function get skyStepMaxCount() : int
      {
         return skyStepMaxCount$field;
      }
      
      public function removeRuneCount() : void
      {
         hasField$4 &= 4294934527;
         rune_count$field = new int();
      }
      
      public function get hasRuneCount() : Boolean
      {
         return (hasField$4 & 0x8000) != 0;
      }
      
      public function set runeCount(param1:int) : void
      {
         hasField$4 |= 32768;
         rune_count$field = param1;
      }
      
      public function get runeCount() : int
      {
         return rune_count$field;
      }
      
      public function removeRunePowerPoint() : void
      {
         hasField$4 &= 4294901759;
         runePowerPoint$field = new int();
      }
      
      public function get hasRunePowerPoint() : Boolean
      {
         return (hasField$4 & 0x010000) != 0;
      }
      
      public function set runePowerPoint(param1:int) : void
      {
         hasField$4 |= 65536;
         runePowerPoint$field = param1;
      }
      
      public function get runePowerPoint() : int
      {
         return runePowerPoint$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasSex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,sex$field);
         }
         if(hasPic)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pic$field);
         }
         if(hasCamp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,camp$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasGiftToken)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,gift_token$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasLastAward)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,last_award$field);
         }
         if(hasQuestSiteLen)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,quest_site_len$field);
         }
         if(hasQuestSite)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_BYTES(param1,quest_site$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasClaimId)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,claim_id$field);
         }
         if(hasClaimName)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,claim_name$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT64(param1,gp$field);
         }
         if(hasRepute)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,repute$field);
         }
         if(hasConsortiaOffer)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,consortia_offer$field);
         }
         if(hasStrategy)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT64(param1,strategy$field);
         }
         if(hasWeary)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,weary$field);
         }
         if(hasAttackLeftCount)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,attack_left_count$field);
         }
         if(hasNoviceProcess)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,novice_process$field);
         }
         if(hasConsortiaAttack)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,consortia_attack$field);
         }
         if(hasConsortiaDefence)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,consortia_defence$field);
         }
         if(hasConsortiaAgility)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,consortia_agility$field);
         }
         if(hasConsortiaAbility)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,consortia_ability$field);
         }
         if(hasConsortiaCaptain)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,consortia_captain$field);
         }
         if(hasGpOrder)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,gp_order$field);
         }
         if(hasFightingCapacity)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,fighting_capacity$field);
         }
         if(hasGradeProcess)
         {
            WriteUtils.writeTag(param1,2,31);
            WriteUtils.write$TYPE_STRING(param1,grade_process$field);
         }
         if(hasTimeProcess)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_INT32(param1,time_process$field);
         }
         if(hasTimeGet)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_BOOL(param1,time_get$field);
         }
         if(hasCampaignSite)
         {
            WriteUtils.writeTag(param1,2,34);
            WriteUtils.write$TYPE_STRING(param1,campaign_site$field);
         }
         if(hasBagCount)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,bag_count$field);
         }
         if(hasMatchWin)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,match_win$field);
         }
         if(hasMatchFailed)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_INT32(param1,match_failed$field);
         }
         if(hasConsortiaGold)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_INT32(param1,consortia_gold$field);
         }
         if(hasConsortiaPhysique)
         {
            WriteUtils.writeTag(param1,0,39);
            WriteUtils.write$TYPE_INT32(param1,consortia_physique$field);
         }
         if(hasRight)
         {
            WriteUtils.writeTag(param1,0,40);
            WriteUtils.write$TYPE_INT32(param1,right$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,41);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasLeedProcess)
         {
            WriteUtils.writeTag(param1,0,42);
            WriteUtils.write$TYPE_INT32(param1,leed_process$field);
         }
         if(hasStarCount)
         {
            WriteUtils.writeTag(param1,0,43);
            WriteUtils.write$TYPE_INT32(param1,star_count$field);
         }
         if(hasSignDate)
         {
            WriteUtils.writeTag(param1,2,44);
            WriteUtils.write$TYPE_STRING(param1,signDate$field);
         }
         if(hasSignTimes)
         {
            WriteUtils.writeTag(param1,0,45);
            WriteUtils.write$TYPE_INT32(param1,signTimes$field);
         }
         if(hasSignSite)
         {
            WriteUtils.writeTag(param1,0,46);
            WriteUtils.write$TYPE_INT32(param1,signSite$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,2,47);
            WriteUtils.write$TYPE_MESSAGE(param1,order$field);
         }
         if(hasStartFree)
         {
            WriteUtils.writeTag(param1,0,48);
            WriteUtils.write$TYPE_INT32(param1,startFree$field);
         }
         if(hasTotalGp)
         {
            WriteUtils.writeTag(param1,0,49);
            WriteUtils.write$TYPE_INT64(param1,totalGp$field);
         }
         if(hasRefuseFriend)
         {
            WriteUtils.writeTag(param1,0,50);
            WriteUtils.write$TYPE_BOOL(param1,refuseFriend$field);
         }
         if(hasRefuseInvite)
         {
            WriteUtils.writeTag(param1,0,51);
            WriteUtils.write$TYPE_BOOL(param1,refuseInvite$field);
         }
         if(hasConsortiaTotaloffer)
         {
            WriteUtils.writeTag(param1,0,52);
            WriteUtils.write$TYPE_INT32(param1,consortia_totaloffer$field);
         }
         if(hasShowVersion)
         {
            WriteUtils.writeTag(param1,0,53);
            WriteUtils.write$TYPE_BOOL(param1,show_version$field);
         }
         if(hasCampaignCount)
         {
            WriteUtils.writeTag(param1,0,54);
            WriteUtils.write$TYPE_INT32(param1,campaign_count$field);
         }
         if(hasTimeRun)
         {
            WriteUtils.writeTag(param1,0,55);
            WriteUtils.write$TYPE_INT32(param1,time_run$field);
         }
         if(hasQteGuide)
         {
            WriteUtils.writeTag(param1,0,56);
            WriteUtils.write$TYPE_INT32(param1,qte_guide$field);
         }
         if(hasStarpoint)
         {
            WriteUtils.writeTag(param1,0,57);
            WriteUtils.write$TYPE_INT32(param1,starpoint$field);
         }
         if(hasIsAuto)
         {
            WriteUtils.writeTag(param1,0,58);
            WriteUtils.write$TYPE_BOOL(param1,is_auto$field);
         }
         if(hasLastOutConsortia)
         {
            WriteUtils.writeTag(param1,2,59);
            WriteUtils.write$TYPE_STRING(param1,lastOutConsortia$field);
         }
         if(hasGeste)
         {
            WriteUtils.writeTag(param1,0,60);
            WriteUtils.write$TYPE_INT32(param1,geste$field);
         }
         if(hasStoreGrade)
         {
            WriteUtils.writeTag(param1,0,61);
            WriteUtils.write$TYPE_INT32(param1,storeGrade$field);
         }
         if(hasStoreGp)
         {
            WriteUtils.writeTag(param1,0,62);
            WriteUtils.write$TYPE_INT32(param1,storeGp$field);
         }
         if(hasReloginProcess)
         {
            WriteUtils.writeTag(param1,0,63);
            WriteUtils.write$TYPE_INT32(param1,relogin_process$field);
         }
         if(hasReloginCount)
         {
            WriteUtils.writeTag(param1,0,64);
            WriteUtils.write$TYPE_INT32(param1,relogin_count$field);
         }
         if(hasBlessingCount)
         {
            WriteUtils.writeTag(param1,0,65);
            WriteUtils.write$TYPE_INT32(param1,blessingCount$field);
         }
         if(hasBlessingBuff)
         {
            WriteUtils.writeTag(param1,0,66);
            WriteUtils.write$TYPE_INT32(param1,blessingBuff$field);
         }
         if(hasBlessingMaxCount)
         {
            WriteUtils.writeTag(param1,0,67);
            WriteUtils.write$TYPE_INT32(param1,blessingMaxCount$field);
         }
         if(hasFirstCharge)
         {
            WriteUtils.writeTag(param1,0,68);
            WriteUtils.write$TYPE_BOOL(param1,first_charge$field);
         }
         if(hasCharm)
         {
            WriteUtils.writeTag(param1,0,69);
            WriteUtils.write$TYPE_INT32(param1,charm$field);
         }
         if(hasMatchRoomCount)
         {
            WriteUtils.writeTag(param1,0,70);
            WriteUtils.write$TYPE_INT32(param1,match_room_count$field);
         }
         if(hasKingBuff)
         {
            WriteUtils.writeTag(param1,0,71);
            WriteUtils.write$TYPE_BOOL(param1,king_buff$field);
         }
         if(hasLeaveGp)
         {
            WriteUtils.writeTag(param1,0,72);
            WriteUtils.write$TYPE_INT32(param1,leave_gp$field);
         }
         if(hasAltarConsortiaId)
         {
            WriteUtils.writeTag(param1,0,73);
            WriteUtils.write$TYPE_INT32(param1,altar_consortiaId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,74);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasRewardTimes)
         {
            WriteUtils.writeTag(param1,0,75);
            WriteUtils.write$TYPE_INT32(param1,reward_times$field);
         }
         if(hasWarFieldCount)
         {
            WriteUtils.writeTag(param1,0,76);
            WriteUtils.write$TYPE_INT32(param1,war_field_count$field);
         }
         if(hasTrialCount)
         {
            WriteUtils.writeTag(param1,0,77);
            WriteUtils.write$TYPE_INT32(param1,trial_count$field);
         }
         if(hasAppellId)
         {
            WriteUtils.writeTag(param1,0,78);
            WriteUtils.write$TYPE_INT32(param1,appell_id$field);
         }
         if(hasCrossScore)
         {
            WriteUtils.writeTag(param1,0,79);
            WriteUtils.write$TYPE_INT32(param1,cross_score$field);
         }
         if(hasTrialMaxCount)
         {
            WriteUtils.writeTag(param1,0,80);
            WriteUtils.write$TYPE_INT32(param1,trial_max_count$field);
         }
         if(hasWearyLimit)
         {
            WriteUtils.writeTag(param1,0,81);
            WriteUtils.write$TYPE_INT32(param1,weary_limit$field);
         }
         if(hasLordsScore)
         {
            WriteUtils.writeTag(param1,0,82);
            WriteUtils.write$TYPE_INT32(param1,lords_score$field);
         }
         if(hasIsReceived)
         {
            WriteUtils.writeTag(param1,0,83);
            WriteUtils.write$TYPE_BOOL(param1,is_received$field);
         }
         if(hasMineScore)
         {
            WriteUtils.writeTag(param1,0,84);
            WriteUtils.write$TYPE_INT32(param1,mine_score$field);
         }
         if(hasIsBackPlayer)
         {
            WriteUtils.writeTag(param1,0,85);
            WriteUtils.write$TYPE_BOOL(param1,is_back_player$field);
         }
         if(hasRefuseTeamInvite)
         {
            WriteUtils.writeTag(param1,0,86);
            WriteUtils.write$TYPE_BOOL(param1,refuseTeamInvite$field);
         }
         if(hasCampaignMaxcount)
         {
            WriteUtils.writeTag(param1,0,87);
            WriteUtils.write$TYPE_INT32(param1,campaign_maxcount$field);
         }
         if(hasSeniorStoreGrade)
         {
            WriteUtils.writeTag(param1,0,88);
            WriteUtils.write$TYPE_INT32(param1,seniorStoreGrade$field);
         }
         if(hasSeniorStoreGp)
         {
            WriteUtils.writeTag(param1,0,89);
            WriteUtils.write$TYPE_INT32(param1,seniorStoreGp$field);
         }
         if(hasDragonCampaign_Count)
         {
            WriteUtils.writeTag(param1,0,90);
            WriteUtils.write$TYPE_INT32(param1,dragonCampaign_Count$field);
         }
         if(hasDragonCampaign_MaxCount)
         {
            WriteUtils.writeTag(param1,0,91);
            WriteUtils.write$TYPE_INT32(param1,dragonCampaign_MaxCount$field);
         }
         if(hasCrossGuildScore)
         {
            WriteUtils.writeTag(param1,0,92);
            WriteUtils.write$TYPE_INT32(param1,cross_guild_score$field);
         }
         if(hasCrossLeagueMedal)
         {
            WriteUtils.writeTag(param1,0,93);
            WriteUtils.write$TYPE_INT32(param1,cross_league_medal$field);
         }
         if(hasApplleProperty_Open)
         {
            WriteUtils.writeTag(param1,0,94);
            WriteUtils.write$TYPE_BOOL(param1,applle_property_Open$field);
         }
         if(hasHasVicePassword)
         {
            WriteUtils.writeTag(param1,0,95);
            WriteUtils.write$TYPE_INT32(param1,hasVicePassword$field);
         }
         if(hasIsDuringToResetTime)
         {
            WriteUtils.writeTag(param1,0,96);
            WriteUtils.write$TYPE_INT32(param1,isDuringToResetTime$field);
         }
         if(hasRentalBagTime)
         {
            WriteUtils.writeTag(param1,2,97);
            WriteUtils.write$TYPE_STRING(param1,rentalBagTime$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,98);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
         if(hasNewPowerLv)
         {
            WriteUtils.writeTag(param1,0,99);
            WriteUtils.write$TYPE_INT32(param1,new_power_lv$field);
         }
         if(hasNewAgilityLv)
         {
            WriteUtils.writeTag(param1,0,100);
            WriteUtils.write$TYPE_INT32(param1,new_agility_lv$field);
         }
         if(hasNewIntellectLv)
         {
            WriteUtils.writeTag(param1,0,101);
            WriteUtils.write$TYPE_INT32(param1,new_intellect_lv$field);
         }
         if(hasNewPhysiqueLv)
         {
            WriteUtils.writeTag(param1,0,102);
            WriteUtils.write$TYPE_INT32(param1,new_physique_lv$field);
         }
         if(hasFamGpLv)
         {
            WriteUtils.writeTag(param1,0,103);
            WriteUtils.write$TYPE_INT32(param1,fam_gp_lv$field);
         }
         if(hasMedalLv)
         {
            WriteUtils.writeTag(param1,0,104);
            WriteUtils.write$TYPE_INT32(param1,medal_lv$field);
         }
         if(hasHonorLv)
         {
            WriteUtils.writeTag(param1,0,105);
            WriteUtils.write$TYPE_INT32(param1,honor_lv$field);
         }
         if(hasPropertyLv)
         {
            WriteUtils.writeTag(param1,0,106);
            WriteUtils.write$TYPE_INT32(param1,property_lv$field);
         }
         if(hasLeadExtractTimes)
         {
            WriteUtils.writeTag(param1,0,107);
            WriteUtils.write$TYPE_INT32(param1,leadExtractTimes$field);
         }
         if(hasRandomBossCount)
         {
            WriteUtils.writeTag(param1,0,108);
            WriteUtils.write$TYPE_INT32(param1,randomBossCount$field);
         }
         if(hasMonopolyCampaignCount)
         {
            WriteUtils.writeTag(param1,0,109);
            WriteUtils.write$TYPE_INT32(param1,monopolyCampaignCount$field);
         }
         if(hasJumpNovice)
         {
            WriteUtils.writeTag(param1,0,110);
            WriteUtils.write$TYPE_BOOL(param1,jump_novice$field);
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,111);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
         if(hasSkillGrade)
         {
            WriteUtils.writeTag(param1,2,112);
            WriteUtils.write$TYPE_STRING(param1,skill_grade$field);
         }
         if(hasSkillProficiency)
         {
            WriteUtils.writeTag(param1,2,113);
            WriteUtils.write$TYPE_STRING(param1,skill_proficiency$field);
         }
         if(hasIsCost)
         {
            WriteUtils.writeTag(param1,0,114);
            WriteUtils.write$TYPE_BOOL(param1,is_cost$field);
         }
         if(hasSkillComposeTimes)
         {
            WriteUtils.writeTag(param1,0,115);
            WriteUtils.write$TYPE_INT32(param1,skill_compose_times$field);
         }
         if(hasSkillCollectTimes)
         {
            WriteUtils.writeTag(param1,0,116);
            WriteUtils.write$TYPE_INT32(param1,skill_collect_times$field);
         }
         if(hasComposeId)
         {
            WriteUtils.writeTag(param1,2,117);
            WriteUtils.write$TYPE_STRING(param1,composeId$field);
         }
         if(hasTeamCount)
         {
            WriteUtils.writeTag(param1,0,118);
            WriteUtils.write$TYPE_INT32(param1,team_count$field);
         }
         if(hasTeamMaxCount)
         {
            WriteUtils.writeTag(param1,0,119);
            WriteUtils.write$TYPE_INT32(param1,team_max_count$field);
         }
         if(hasSeekSurplusTime)
         {
            WriteUtils.writeTag(param1,0,120);
            WriteUtils.write$TYPE_INT32(param1,seekSurplusTime$field);
         }
         if(hasRecoverGP)
         {
            WriteUtils.writeTag(param1,0,121);
            WriteUtils.write$TYPE_INT32(param1,recoverGP$field);
         }
         if(hasTerraTempleCount)
         {
            WriteUtils.writeTag(param1,0,122);
            WriteUtils.write$TYPE_INT32(param1,terra_temple_count$field);
         }
         if(hasTerraTempleMaxCount)
         {
            WriteUtils.writeTag(param1,0,123);
            WriteUtils.write$TYPE_INT32(param1,terra_temple_max_count$field);
         }
         if(hasLastFreeSkillLearnTime)
         {
            WriteUtils.writeTag(param1,2,124);
            WriteUtils.write$TYPE_STRING(param1,lastFreeSkillLearnTime$field);
         }
         if(hasStoneBagCount)
         {
            WriteUtils.writeTag(param1,0,125);
            WriteUtils.write$TYPE_INT32(param1,stoneBagCount$field);
         }
         if(hasTramcarCount)
         {
            WriteUtils.writeTag(param1,0,126);
            WriteUtils.write$TYPE_INT32(param1,tramcarCount$field);
         }
         if(hasWeekCampaignCount)
         {
            WriteUtils.writeTag(param1,0,127);
            WriteUtils.write$TYPE_INT32(param1,weekCampaignCount$field);
         }
         if(hasWeekCampaignMaxCount)
         {
            WriteUtils.writeTag(param1,0,128);
            WriteUtils.write$TYPE_INT32(param1,weekCampaignMaxCount$field);
         }
         if(hasTrialTowerCampaignCount)
         {
            WriteUtils.writeTag(param1,0,129);
            WriteUtils.write$TYPE_INT32(param1,trialTowerCampaignCount$field);
         }
         if(hasTrialTowerCampaignMaxCount)
         {
            WriteUtils.writeTag(param1,0,130);
            WriteUtils.write$TYPE_INT32(param1,trialTowerCampaignMaxCount$field);
         }
         if(hasFantasyMatrixCampaignCount)
         {
            WriteUtils.writeTag(param1,0,131);
            WriteUtils.write$TYPE_INT32(param1,fantasyMatrixCampaignCount$field);
         }
         if(hasFantasyMatrixCampaignMaxCount)
         {
            WriteUtils.writeTag(param1,0,132);
            WriteUtils.write$TYPE_INT32(param1,fantasyMatrixCampaignMaxCount$field);
         }
         if(hasBloodyRealmCampaignCount)
         {
            WriteUtils.writeTag(param1,0,133);
            WriteUtils.write$TYPE_INT32(param1,bloodyRealmCampaignCount$field);
         }
         if(hasBloodyRealmCampaignMaxCount)
         {
            WriteUtils.writeTag(param1,0,134);
            WriteUtils.write$TYPE_INT32(param1,bloodyRealmCampaignMaxCount$field);
         }
         if(hasEquipmentRefiningGrade)
         {
            WriteUtils.writeTag(param1,0,135);
            WriteUtils.write$TYPE_INT32(param1,equipmentRefiningGrade$field);
         }
         if(hasEquipmentRefiningGp)
         {
            WriteUtils.writeTag(param1,0,136);
            WriteUtils.write$TYPE_INT32(param1,equipmentRefiningGp$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,137);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasPetPveCount)
         {
            WriteUtils.writeTag(param1,0,138);
            WriteUtils.write$TYPE_INT32(param1,petPveCount$field);
         }
         if(hasPetPveMaxCount)
         {
            WriteUtils.writeTag(param1,0,139);
            WriteUtils.write$TYPE_INT32(param1,petPveMaxCount$field);
         }
         if(hasQuickPassCount)
         {
            WriteUtils.writeTag(param1,0,140);
            WriteUtils.write$TYPE_INT32(param1,quickPassCount$field);
         }
         if(hasGuardWarCount)
         {
            WriteUtils.writeTag(param1,0,141);
            WriteUtils.write$TYPE_INT32(param1,guardWarCount$field);
         }
         if(hasGuardWarMaxCount)
         {
            WriteUtils.writeTag(param1,0,142);
            WriteUtils.write$TYPE_INT32(param1,guardWarMaxCount$field);
         }
         if(hasTimeVortexCount)
         {
            WriteUtils.writeTag(param1,0,143);
            WriteUtils.write$TYPE_INT32(param1,time_vortex_count$field);
         }
         if(hasTimeVortexNode)
         {
            WriteUtils.writeTag(param1,0,144);
            WriteUtils.write$TYPE_INT32(param1,time_vortex_node$field);
         }
         if(hasIsOpenDragonTalker)
         {
            WriteUtils.writeTag(param1,0,145);
            WriteUtils.write$TYPE_BOOL(param1,isOpenDragonTalker$field);
         }
         if(hasIsCurrentDragonTalker)
         {
            WriteUtils.writeTag(param1,0,146);
            WriteUtils.write$TYPE_BOOL(param1,isCurrentDragonTalker$field);
         }
         if(hasMasterPowerLv)
         {
            WriteUtils.writeTag(param1,0,147);
            WriteUtils.write$TYPE_INT32(param1,master_power_lv$field);
         }
         if(hasMasterAgilityLv)
         {
            WriteUtils.writeTag(param1,0,148);
            WriteUtils.write$TYPE_INT32(param1,master_agility_lv$field);
         }
         if(hasMasterIntellectLv)
         {
            WriteUtils.writeTag(param1,0,149);
            WriteUtils.write$TYPE_INT32(param1,master_intellect_lv$field);
         }
         if(hasMasterPhysiqueLv)
         {
            WriteUtils.writeTag(param1,0,150);
            WriteUtils.write$TYPE_INT32(param1,master_physique_lv$field);
         }
         if(hasAbyssPrisonCount)
         {
            WriteUtils.writeTag(param1,0,151);
            WriteUtils.write$TYPE_INT32(param1,abyssPrisonCount$field);
         }
         if(hasAbyssPrisonMaxCount)
         {
            WriteUtils.writeTag(param1,0,152);
            WriteUtils.write$TYPE_INT32(param1,abyssPrisonMaxCount$field);
         }
         if(hasBlackGoldCaveLeftCount)
         {
            WriteUtils.writeTag(param1,0,153);
            WriteUtils.write$TYPE_INT32(param1,BlackGoldCaveLeftCount$field);
         }
         if(hasBlackGoldCaveMaxCount)
         {
            WriteUtils.writeTag(param1,0,154);
            WriteUtils.write$TYPE_INT32(param1,BlackGoldCaveMaxCount$field);
         }
         if(hasRushCustomsLeftCount)
         {
            WriteUtils.writeTag(param1,0,155);
            WriteUtils.write$TYPE_INT32(param1,RushCustomsLeftCount$field);
         }
         if(hasRushCustomsMaxCount)
         {
            WriteUtils.writeTag(param1,0,156);
            WriteUtils.write$TYPE_INT32(param1,RushCustomsMaxCount$field);
         }
         if(hasElementSilvaMaxCount)
         {
            WriteUtils.writeTag(param1,0,157);
            WriteUtils.write$TYPE_INT32(param1,ElementSilvaMaxCount$field);
         }
         if(hasElementSilvaLeftCount)
         {
            WriteUtils.writeTag(param1,0,158);
            WriteUtils.write$TYPE_INT32(param1,ElementSilvaLeftCount$field);
         }
         if(hasDungeonTurnLeftRewardCount)
         {
            WriteUtils.writeTag(param1,0,159);
            WriteUtils.write$TYPE_INT32(param1,DungeonTurnLeftRewardCount$field);
         }
         if(hasDungeonTurnMaxRewardCount)
         {
            WriteUtils.writeTag(param1,0,160);
            WriteUtils.write$TYPE_INT32(param1,DungeonTurnMaxRewardCount$field);
         }
         if(hasTimeSpaceLeftRewardCount)
         {
            WriteUtils.writeTag(param1,0,161);
            WriteUtils.write$TYPE_INT32(param1,TimeSpaceLeftRewardCount$field);
         }
         if(hasTimeSpaceMaxRewardCount)
         {
            WriteUtils.writeTag(param1,0,162);
            WriteUtils.write$TYPE_INT32(param1,TimeSpaceMaxRewardCount$field);
         }
         if(hasSkyStepCount)
         {
            WriteUtils.writeTag(param1,0,163);
            WriteUtils.write$TYPE_INT32(param1,skyStepCount$field);
         }
         if(hasSkyStepMaxCount)
         {
            WriteUtils.writeTag(param1,0,164);
            WriteUtils.write$TYPE_INT32(param1,skyStepMaxCount$field);
         }
         if(hasRuneCount)
         {
            WriteUtils.writeTag(param1,0,165);
            WriteUtils.write$TYPE_INT32(param1,rune_count$field);
         }
         if(hasRunePowerPoint)
         {
            WriteUtils.writeTag(param1,0,166);
            WriteUtils.write$TYPE_INT32(param1,runePowerPoint$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc109_:* = 0;
         var _loc3_:uint = 0;
         var _loc45_:uint = 0;
         var _loc132_:uint = 0;
         var _loc27_:uint = 0;
         var _loc32_:uint = 0;
         var _loc147_:uint = 0;
         var _loc52_:uint = 0;
         var _loc146_:uint = 0;
         var _loc44_:uint = 0;
         var _loc8_:uint = 0;
         var _loc92_:uint = 0;
         var _loc142_:uint = 0;
         var _loc5_:uint = 0;
         var _loc148_:uint = 0;
         var _loc19_:uint = 0;
         var _loc151_:uint = 0;
         var _loc168_:uint = 0;
         var _loc31_:uint = 0;
         var _loc91_:uint = 0;
         var _loc21_:uint = 0;
         var _loc112_:uint = 0;
         var _loc75_:uint = 0;
         var _loc165_:uint = 0;
         var _loc20_:uint = 0;
         var _loc88_:uint = 0;
         var _loc128_:uint = 0;
         var _loc55_:uint = 0;
         var _loc87_:uint = 0;
         var _loc64_:uint = 0;
         var _loc97_:uint = 0;
         var _loc53_:uint = 0;
         var _loc130_:uint = 0;
         var _loc72_:uint = 0;
         var _loc59_:uint = 0;
         var _loc157_:uint = 0;
         var _loc101_:uint = 0;
         var _loc50_:uint = 0;
         var _loc29_:uint = 0;
         var _loc80_:uint = 0;
         var _loc155_:uint = 0;
         var _loc61_:uint = 0;
         var _loc122_:uint = 0;
         var _loc39_:uint = 0;
         var _loc124_:uint = 0;
         var _loc15_:uint = 0;
         var _loc169_:uint = 0;
         var _loc38_:uint = 0;
         var _loc25_:uint = 0;
         var _loc4_:uint = 0;
         var _loc125_:uint = 0;
         var _loc67_:uint = 0;
         var _loc34_:uint = 0;
         var _loc111_:uint = 0;
         var _loc96_:uint = 0;
         var _loc6_:uint = 0;
         var _loc37_:uint = 0;
         var _loc107_:uint = 0;
         var _loc83_:uint = 0;
         var _loc159_:uint = 0;
         var _loc152_:uint = 0;
         var _loc26_:uint = 0;
         var _loc162_:uint = 0;
         var _loc120_:uint = 0;
         var _loc23_:uint = 0;
         var _loc77_:uint = 0;
         var _loc164_:uint = 0;
         var _loc22_:uint = 0;
         var _loc102_:uint = 0;
         var _loc106_:uint = 0;
         var _loc13_:uint = 0;
         var _loc24_:uint = 0;
         var _loc145_:uint = 0;
         var _loc129_:uint = 0;
         var _loc94_:uint = 0;
         var _loc33_:uint = 0;
         var _loc42_:uint = 0;
         var _loc78_:uint = 0;
         var _loc100_:uint = 0;
         var _loc138_:uint = 0;
         var _loc73_:uint = 0;
         var _loc133_:uint = 0;
         var _loc143_:uint = 0;
         var _loc136_:uint = 0;
         var _loc103_:uint = 0;
         var _loc60_:uint = 0;
         var _loc43_:uint = 0;
         var _loc144_:uint = 0;
         var _loc51_:uint = 0;
         var _loc118_:uint = 0;
         var _loc131_:uint = 0;
         var _loc160_:uint = 0;
         var _loc158_:uint = 0;
         var _loc81_:uint = 0;
         var _loc127_:uint = 0;
         var _loc166_:uint = 0;
         var _loc153_:uint = 0;
         var _loc104_:uint = 0;
         var _loc74_:uint = 0;
         var _loc11_:uint = 0;
         var _loc149_:uint = 0;
         var _loc56_:uint = 0;
         var _loc82_:uint = 0;
         var _loc123_:uint = 0;
         var _loc86_:uint = 0;
         var _loc28_:uint = 0;
         var _loc119_:uint = 0;
         var _loc54_:uint = 0;
         var _loc116_:uint = 0;
         var _loc70_:uint = 0;
         var _loc98_:uint = 0;
         var _loc139_:uint = 0;
         var _loc89_:uint = 0;
         var _loc30_:uint = 0;
         var _loc114_:uint = 0;
         var _loc95_:uint = 0;
         var _loc47_:uint = 0;
         var _loc16_:uint = 0;
         var _loc84_:uint = 0;
         var _loc35_:uint = 0;
         var _loc12_:uint = 0;
         var _loc126_:uint = 0;
         var _loc49_:uint = 0;
         var _loc71_:uint = 0;
         var _loc161_:uint = 0;
         var _loc36_:uint = 0;
         var _loc68_:uint = 0;
         var _loc69_:uint = 0;
         var _loc167_:uint = 0;
         var _loc62_:uint = 0;
         var _loc7_:uint = 0;
         var _loc40_:uint = 0;
         var _loc134_:uint = 0;
         var _loc17_:uint = 0;
         var _loc9_:uint = 0;
         var _loc140_:uint = 0;
         var _loc105_:uint = 0;
         var _loc141_:uint = 0;
         var _loc117_:uint = 0;
         var _loc18_:uint = 0;
         var _loc99_:uint = 0;
         var _loc121_:uint = 0;
         var _loc46_:uint = 0;
         var _loc90_:uint = 0;
         var _loc66_:uint = 0;
         var _loc156_:uint = 0;
         var _loc63_:uint = 0;
         var _loc110_:uint = 0;
         var _loc137_:uint = 0;
         var _loc41_:uint = 0;
         var _loc76_:uint = 0;
         var _loc10_:uint = 0;
         var _loc108_:uint = 0;
         var _loc79_:uint = 0;
         var _loc163_:uint = 0;
         var _loc115_:uint = 0;
         var _loc65_:uint = 0;
         var _loc85_:uint = 0;
         var _loc154_:uint = 0;
         var _loc93_:uint = 0;
         var _loc48_:uint = 0;
         var _loc14_:uint = 0;
         var _loc113_:uint = 0;
         var _loc135_:uint = 0;
         var _loc57_:uint = 0;
         var _loc58_:uint = 0;
         var _loc150_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc109_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.playerId cannot be set twice.");
                  }
                  _loc3_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.nickName cannot be set twice.");
                  }
                  _loc45_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc132_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.sex cannot be set twice.");
                  }
                  _loc132_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.pic cannot be set twice.");
                  }
                  _loc27_++;
                  pic = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.camp cannot be set twice.");
                  }
                  _loc32_++;
                  camp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc147_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.point cannot be set twice.");
                  }
                  _loc147_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc52_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.giftToken cannot be set twice.");
                  }
                  _loc52_++;
                  giftToken = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc146_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.state cannot be set twice.");
                  }
                  _loc146_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.lastAward cannot be set twice.");
                  }
                  _loc44_++;
                  lastAward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.questSiteLen cannot be set twice.");
                  }
                  _loc8_++;
                  questSiteLen = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc92_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.questSite cannot be set twice.");
                  }
                  _loc92_++;
                  questSite = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 12:
                  if(_loc142_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaId cannot be set twice.");
                  }
                  _loc142_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaName cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc148_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.claimId cannot be set twice.");
                  }
                  _loc148_++;
                  claimId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.claimName cannot be set twice.");
                  }
                  _loc19_++;
                  claimName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc151_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.grades cannot be set twice.");
                  }
                  _loc151_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc168_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.gp cannot be set twice.");
                  }
                  _loc168_++;
                  gp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 18:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.repute cannot be set twice.");
                  }
                  _loc31_++;
                  repute = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc91_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaOffer cannot be set twice.");
                  }
                  _loc91_++;
                  consortiaOffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.strategy cannot be set twice.");
                  }
                  _loc21_++;
                  strategy = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 21:
                  if(_loc112_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.weary cannot be set twice.");
                  }
                  _loc112_++;
                  weary = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc75_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.attackLeftCount cannot be set twice.");
                  }
                  _loc75_++;
                  attackLeftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc165_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.noviceProcess cannot be set twice.");
                  }
                  _loc165_++;
                  noviceProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaAttack cannot be set twice.");
                  }
                  _loc20_++;
                  consortiaAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc88_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaDefence cannot be set twice.");
                  }
                  _loc88_++;
                  consortiaDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc128_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaAgility cannot be set twice.");
                  }
                  _loc128_++;
                  consortiaAgility = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc55_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaAbility cannot be set twice.");
                  }
                  _loc55_++;
                  consortiaAbility = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc87_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaCaptain cannot be set twice.");
                  }
                  _loc87_++;
                  consortiaCaptain = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc64_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.gpOrder cannot be set twice.");
                  }
                  _loc64_++;
                  gpOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc97_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.fightingCapacity cannot be set twice.");
                  }
                  _loc97_++;
                  fightingCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc53_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.gradeProcess cannot be set twice.");
                  }
                  _loc53_++;
                  gradeProcess = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 32:
                  if(_loc130_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.timeProcess cannot be set twice.");
                  }
                  _loc130_++;
                  timeProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 33:
                  if(_loc72_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.timeGet cannot be set twice.");
                  }
                  _loc72_++;
                  timeGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 34:
                  if(_loc59_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.campaignSite cannot be set twice.");
                  }
                  _loc59_++;
                  campaignSite = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 35:
                  if(_loc157_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.bagCount cannot be set twice.");
                  }
                  _loc157_++;
                  bagCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 36:
                  if(_loc101_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.matchWin cannot be set twice.");
                  }
                  _loc101_++;
                  matchWin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 37:
                  if(_loc50_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.matchFailed cannot be set twice.");
                  }
                  _loc50_++;
                  matchFailed = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 38:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaGold cannot be set twice.");
                  }
                  _loc29_++;
                  consortiaGold = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 39:
                  if(_loc80_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaPhysique cannot be set twice.");
                  }
                  _loc80_++;
                  consortiaPhysique = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 40:
                  if(_loc155_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.right cannot be set twice.");
                  }
                  _loc155_++;
                  right = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 41:
                  if(_loc61_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.job cannot be set twice.");
                  }
                  _loc61_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 42:
                  if(_loc122_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.leedProcess cannot be set twice.");
                  }
                  _loc122_++;
                  leedProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 43:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.starCount cannot be set twice.");
                  }
                  _loc39_++;
                  starCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 44:
                  if(_loc124_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.signDate cannot be set twice.");
                  }
                  _loc124_++;
                  signDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 45:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.signTimes cannot be set twice.");
                  }
                  _loc15_++;
                  signTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 46:
                  if(_loc169_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.signSite cannot be set twice.");
                  }
                  _loc169_++;
                  signSite = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 47:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.order cannot be set twice.");
                  }
                  _loc38_++;
                  order = new PlayerOrderMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,order);
                  break;
               case 48:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.startFree cannot be set twice.");
                  }
                  _loc25_++;
                  startFree = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 49:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.totalGp cannot be set twice.");
                  }
                  _loc4_++;
                  totalGp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 50:
                  if(_loc125_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.refuseFriend cannot be set twice.");
                  }
                  _loc125_++;
                  refuseFriend = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 51:
                  if(_loc67_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.refuseInvite cannot be set twice.");
                  }
                  _loc67_++;
                  refuseInvite = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 52:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.consortiaTotaloffer cannot be set twice.");
                  }
                  _loc34_++;
                  consortiaTotaloffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 53:
                  if(_loc111_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.showVersion cannot be set twice.");
                  }
                  _loc111_++;
                  showVersion = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 54:
                  if(_loc96_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.campaignCount cannot be set twice.");
                  }
                  _loc96_++;
                  campaignCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 55:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.timeRun cannot be set twice.");
                  }
                  _loc6_++;
                  timeRun = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 56:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.qteGuide cannot be set twice.");
                  }
                  _loc37_++;
                  qteGuide = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 57:
                  if(_loc107_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.starpoint cannot be set twice.");
                  }
                  _loc107_++;
                  starpoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 58:
                  if(_loc83_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.isAuto cannot be set twice.");
                  }
                  _loc83_++;
                  isAuto = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 59:
                  if(_loc159_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.lastOutConsortia cannot be set twice.");
                  }
                  _loc159_++;
                  lastOutConsortia = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 60:
                  if(_loc152_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.geste cannot be set twice.");
                  }
                  _loc152_++;
                  geste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 61:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.storeGrade cannot be set twice.");
                  }
                  _loc26_++;
                  storeGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 62:
                  if(_loc162_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.storeGp cannot be set twice.");
                  }
                  _loc162_++;
                  storeGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 63:
                  if(_loc120_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.reloginProcess cannot be set twice.");
                  }
                  _loc120_++;
                  reloginProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 64:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.reloginCount cannot be set twice.");
                  }
                  _loc23_++;
                  reloginCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 65:
                  if(_loc77_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.blessingCount cannot be set twice.");
                  }
                  _loc77_++;
                  blessingCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 66:
                  if(_loc164_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.blessingBuff cannot be set twice.");
                  }
                  _loc164_++;
                  blessingBuff = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 67:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.blessingMaxCount cannot be set twice.");
                  }
                  _loc22_++;
                  blessingMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 68:
                  if(_loc102_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.firstCharge cannot be set twice.");
                  }
                  _loc102_++;
                  firstCharge = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 69:
                  if(_loc106_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.charm cannot be set twice.");
                  }
                  _loc106_++;
                  charm = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 70:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.matchRoomCount cannot be set twice.");
                  }
                  _loc13_++;
                  matchRoomCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 71:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.kingBuff cannot be set twice.");
                  }
                  _loc24_++;
                  kingBuff = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 72:
                  if(_loc145_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.leaveGp cannot be set twice.");
                  }
                  _loc145_++;
                  leaveGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 73:
                  if(_loc129_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.altarConsortiaId cannot be set twice.");
                  }
                  _loc129_++;
                  altarConsortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 74:
                  if(_loc94_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.serverName cannot be set twice.");
                  }
                  _loc94_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 75:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.rewardTimes cannot be set twice.");
                  }
                  _loc33_++;
                  rewardTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 76:
                  if(_loc42_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.warFieldCount cannot be set twice.");
                  }
                  _loc42_++;
                  warFieldCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 77:
                  if(_loc78_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.trialCount cannot be set twice.");
                  }
                  _loc78_++;
                  trialCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 78:
                  if(_loc100_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.appellId cannot be set twice.");
                  }
                  _loc100_++;
                  appellId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 79:
                  if(_loc138_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.crossScore cannot be set twice.");
                  }
                  _loc138_++;
                  crossScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 80:
                  if(_loc73_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.trialMaxCount cannot be set twice.");
                  }
                  _loc73_++;
                  trialMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 81:
                  if(_loc133_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.wearyLimit cannot be set twice.");
                  }
                  _loc133_++;
                  wearyLimit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 82:
                  if(_loc143_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.lordsScore cannot be set twice.");
                  }
                  _loc143_++;
                  lordsScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 83:
                  if(_loc136_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.isReceived cannot be set twice.");
                  }
                  _loc136_++;
                  isReceived = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 84:
                  if(_loc103_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.mineScore cannot be set twice.");
                  }
                  _loc103_++;
                  mineScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 85:
                  if(_loc60_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.isBackPlayer cannot be set twice.");
                  }
                  _loc60_++;
                  isBackPlayer = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 86:
                  if(_loc43_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.refuseTeamInvite cannot be set twice.");
                  }
                  _loc43_++;
                  refuseTeamInvite = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 87:
                  if(_loc144_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.campaignMaxcount cannot be set twice.");
                  }
                  _loc144_++;
                  campaignMaxcount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 88:
                  if(_loc51_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.seniorStoreGrade cannot be set twice.");
                  }
                  _loc51_++;
                  seniorStoreGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 89:
                  if(_loc118_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.seniorStoreGp cannot be set twice.");
                  }
                  _loc118_++;
                  seniorStoreGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 90:
                  if(_loc131_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.dragonCampaign_Count cannot be set twice.");
                  }
                  _loc131_++;
                  dragonCampaign_Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 91:
                  if(_loc160_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.dragonCampaign_MaxCount cannot be set twice.");
                  }
                  _loc160_++;
                  dragonCampaign_MaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 92:
                  if(_loc158_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.crossGuildScore cannot be set twice.");
                  }
                  _loc158_++;
                  crossGuildScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 93:
                  if(_loc81_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.crossLeagueMedal cannot be set twice.");
                  }
                  _loc81_++;
                  crossLeagueMedal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 94:
                  if(_loc127_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.applleProperty_Open cannot be set twice.");
                  }
                  _loc127_++;
                  applleProperty_Open = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 95:
                  if(_loc166_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.hasVicePassword cannot be set twice.");
                  }
                  _loc166_++;
                  hasVicePassword = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 96:
                  if(_loc153_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.isDuringToResetTime cannot be set twice.");
                  }
                  _loc153_++;
                  isDuringToResetTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 97:
                  if(_loc104_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.rentalBagTime cannot be set twice.");
                  }
                  _loc104_++;
                  rentalBagTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 98:
                  if(_loc74_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.status cannot be set twice.");
                  }
                  _loc74_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 99:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.newPowerLv cannot be set twice.");
                  }
                  _loc11_++;
                  newPowerLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 100:
                  if(_loc149_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.newAgilityLv cannot be set twice.");
                  }
                  _loc149_++;
                  newAgilityLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 101:
                  if(_loc56_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.newIntellectLv cannot be set twice.");
                  }
                  _loc56_++;
                  newIntellectLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 102:
                  if(_loc82_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.newPhysiqueLv cannot be set twice.");
                  }
                  _loc82_++;
                  newPhysiqueLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 103:
                  if(_loc123_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.famGpLv cannot be set twice.");
                  }
                  _loc123_++;
                  famGpLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 104:
                  if(_loc86_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.medalLv cannot be set twice.");
                  }
                  _loc86_++;
                  medalLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 105:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.honorLv cannot be set twice.");
                  }
                  _loc28_++;
                  honorLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 106:
                  if(_loc119_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.propertyLv cannot be set twice.");
                  }
                  _loc119_++;
                  propertyLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 107:
                  if(_loc54_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.leadExtractTimes cannot be set twice.");
                  }
                  _loc54_++;
                  leadExtractTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 108:
                  if(_loc116_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.randomBossCount cannot be set twice.");
                  }
                  _loc116_++;
                  randomBossCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 109:
                  if(_loc70_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.monopolyCampaignCount cannot be set twice.");
                  }
                  _loc70_++;
                  monopolyCampaignCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 110:
                  if(_loc98_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.jumpNovice cannot be set twice.");
                  }
                  _loc98_++;
                  jumpNovice = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 111:
                  if(_loc139_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.skills cannot be set twice.");
                  }
                  _loc139_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 112:
                  if(_loc89_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.skillGrade cannot be set twice.");
                  }
                  _loc89_++;
                  skillGrade = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 113:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.skillProficiency cannot be set twice.");
                  }
                  _loc30_++;
                  skillProficiency = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 114:
                  if(_loc114_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.isCost cannot be set twice.");
                  }
                  _loc114_++;
                  isCost = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 115:
                  if(_loc95_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.skillComposeTimes cannot be set twice.");
                  }
                  _loc95_++;
                  skillComposeTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 116:
                  if(_loc47_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.skillCollectTimes cannot be set twice.");
                  }
                  _loc47_++;
                  skillCollectTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 117:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.composeId cannot be set twice.");
                  }
                  _loc16_++;
                  composeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 118:
                  if(_loc84_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.teamCount cannot be set twice.");
                  }
                  _loc84_++;
                  teamCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 119:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.teamMaxCount cannot be set twice.");
                  }
                  _loc35_++;
                  teamMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 120:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.seekSurplusTime cannot be set twice.");
                  }
                  _loc12_++;
                  seekSurplusTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 121:
                  if(_loc126_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.recoverGP cannot be set twice.");
                  }
                  _loc126_++;
                  recoverGP = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 122:
                  if(_loc49_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.terraTempleCount cannot be set twice.");
                  }
                  _loc49_++;
                  terraTempleCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 123:
                  if(_loc71_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.terraTempleMaxCount cannot be set twice.");
                  }
                  _loc71_++;
                  terraTempleMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 124:
                  if(_loc161_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.lastFreeSkillLearnTime cannot be set twice.");
                  }
                  _loc161_++;
                  lastFreeSkillLearnTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 125:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.stoneBagCount cannot be set twice.");
                  }
                  _loc36_++;
                  stoneBagCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 126:
                  if(_loc68_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.tramcarCount cannot be set twice.");
                  }
                  _loc68_++;
                  tramcarCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 127:
                  if(_loc69_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.weekCampaignCount cannot be set twice.");
                  }
                  _loc69_++;
                  weekCampaignCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 128:
                  if(_loc167_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.weekCampaignMaxCount cannot be set twice.");
                  }
                  _loc167_++;
                  weekCampaignMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 129:
                  if(_loc62_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.trialTowerCampaignCount cannot be set twice.");
                  }
                  _loc62_++;
                  trialTowerCampaignCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 130:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.trialTowerCampaignMaxCount cannot be set twice.");
                  }
                  _loc7_++;
                  trialTowerCampaignMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 131:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.fantasyMatrixCampaignCount cannot be set twice.");
                  }
                  _loc40_++;
                  fantasyMatrixCampaignCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 132:
                  if(_loc134_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.fantasyMatrixCampaignMaxCount cannot be set twice.");
                  }
                  _loc134_++;
                  fantasyMatrixCampaignMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 133:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.bloodyRealmCampaignCount cannot be set twice.");
                  }
                  _loc17_++;
                  bloodyRealmCampaignCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 134:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.bloodyRealmCampaignMaxCount cannot be set twice.");
                  }
                  _loc9_++;
                  bloodyRealmCampaignMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 135:
                  if(_loc140_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.equipmentRefiningGrade cannot be set twice.");
                  }
                  _loc140_++;
                  equipmentRefiningGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 136:
                  if(_loc105_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.equipmentRefiningGp cannot be set twice.");
                  }
                  _loc105_++;
                  equipmentRefiningGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 137:
                  if(_loc141_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.uuid cannot be set twice.");
                  }
                  _loc141_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 138:
                  if(_loc117_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.petPveCount cannot be set twice.");
                  }
                  _loc117_++;
                  petPveCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 139:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.petPveMaxCount cannot be set twice.");
                  }
                  _loc18_++;
                  petPveMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 140:
                  if(_loc99_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.quickPassCount cannot be set twice.");
                  }
                  _loc99_++;
                  quickPassCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 141:
                  if(_loc121_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.guardWarCount cannot be set twice.");
                  }
                  _loc121_++;
                  guardWarCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 142:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.guardWarMaxCount cannot be set twice.");
                  }
                  _loc46_++;
                  guardWarMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 143:
                  if(_loc90_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.timeVortexCount cannot be set twice.");
                  }
                  _loc90_++;
                  timeVortexCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 144:
                  if(_loc66_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.timeVortexNode cannot be set twice.");
                  }
                  _loc66_++;
                  timeVortexNode = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 145:
                  if(_loc156_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.isOpenDragonTalker cannot be set twice.");
                  }
                  _loc156_++;
                  isOpenDragonTalker = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 146:
                  if(_loc63_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.isCurrentDragonTalker cannot be set twice.");
                  }
                  _loc63_++;
                  isCurrentDragonTalker = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 147:
                  if(_loc110_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.masterPowerLv cannot be set twice.");
                  }
                  _loc110_++;
                  masterPowerLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 148:
                  if(_loc137_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.masterAgilityLv cannot be set twice.");
                  }
                  _loc137_++;
                  masterAgilityLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 149:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.masterIntellectLv cannot be set twice.");
                  }
                  _loc41_++;
                  masterIntellectLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 150:
                  if(_loc76_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.masterPhysiqueLv cannot be set twice.");
                  }
                  _loc76_++;
                  masterPhysiqueLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 151:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.abyssPrisonCount cannot be set twice.");
                  }
                  _loc10_++;
                  abyssPrisonCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 152:
                  if(_loc108_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.abyssPrisonMaxCount cannot be set twice.");
                  }
                  _loc108_++;
                  abyssPrisonMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 153:
                  if(_loc79_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.blackGoldCaveLeftCount cannot be set twice.");
                  }
                  _loc79_++;
                  blackGoldCaveLeftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 154:
                  if(_loc163_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.blackGoldCaveMaxCount cannot be set twice.");
                  }
                  _loc163_++;
                  blackGoldCaveMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 155:
                  if(_loc115_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.rushCustomsLeftCount cannot be set twice.");
                  }
                  _loc115_++;
                  rushCustomsLeftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 156:
                  if(_loc65_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.rushCustomsMaxCount cannot be set twice.");
                  }
                  _loc65_++;
                  rushCustomsMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 157:
                  if(_loc85_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.elementSilvaMaxCount cannot be set twice.");
                  }
                  _loc85_++;
                  elementSilvaMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 158:
                  if(_loc154_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.elementSilvaLeftCount cannot be set twice.");
                  }
                  _loc154_++;
                  elementSilvaLeftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 159:
                  if(_loc93_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.dungeonTurnLeftRewardCount cannot be set twice.");
                  }
                  _loc93_++;
                  dungeonTurnLeftRewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 160:
                  if(_loc48_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.dungeonTurnMaxRewardCount cannot be set twice.");
                  }
                  _loc48_++;
                  dungeonTurnMaxRewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 161:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.timeSpaceLeftRewardCount cannot be set twice.");
                  }
                  _loc14_++;
                  timeSpaceLeftRewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 162:
                  if(_loc113_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.timeSpaceMaxRewardCount cannot be set twice.");
                  }
                  _loc113_++;
                  timeSpaceMaxRewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 163:
                  if(_loc135_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.skyStepCount cannot be set twice.");
                  }
                  _loc135_++;
                  skyStepCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 164:
                  if(_loc57_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.skyStepMaxCount cannot be set twice.");
                  }
                  _loc57_++;
                  skyStepMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 165:
                  if(_loc58_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.runeCount cannot be set twice.");
                  }
                  _loc58_++;
                  runeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 166:
                  if(_loc150_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMsg.runePowerPoint cannot be set twice.");
                  }
                  _loc150_++;
                  runePowerPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc109_ & 7);
            }
         }
      }
   }
}

