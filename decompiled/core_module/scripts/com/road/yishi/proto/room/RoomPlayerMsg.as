package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RoomPlayerMsg extends Message implements IExternalizable
   {
      
      private var room_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count$field:int;
      
      private var current_room_index$field:int;
      
      private var player_state$field:int;
      
      private var hero_id$field:int;
      
      private var player_id$field:int;
      
      private var grades$field:int;
      
      private var nick_name$field:String;
      
      private var sex$field:int;
      
      private var template_id$field:int;
      
      private var arm$field:String;
      
      private var cloth$field:String;
      
      private var army_id$field:int;
      
      private var fighting_capacity$field:int;
      
      private var cur_pos_x$field:int;
      
      private var cur_pos_y$field:int;
      
      private var campaign_id$field:int;
      
      private var online_state$field:Boolean;
      
      private var consortia_id$field:int;
      
      private var consortia_name$field:String;
      
      private var change_shapeId$field:int;
      
      private var army_state$field:int;
      
      private var team_id$field:int;
      
      private var buffer_tempId$field:int;
      
      private var geste$field:int;
      
      private var head_id$field:int;
      
      private var is_vip$field:Boolean;
      
      private var vip_type$field:int;
      
      private var mount_tempId$field:int;
      
      private var mount_grade$field:int;
      
      private var wing$field:String;
      
      private var server_name$field:String;
      
      private var hat$field:String;
      
      private var fashion_arm$field:String;
      
      private var fashion_cloth$field:String;
      
      private var hide$field:Boolean;
      
      private var appellid$field:int;
      
      private var vehicleTemplateId$field:int;
      
      private var fate_skills$field:String;
      
      private var petTemplateId$field:int;
      
      private var pet_quqlity$field:int;
      
      private var pet_name$field:String;
      
      private var isNoGet$field:Boolean;
      
      private var dragon_grade$field:String;
      
      private var transfer_grade$field:int;
      
      private var hasField$1:uint = 0;
      
      private var rank$field:int;
      
      private var group_type$field:int;
      
      private var is_back_player$field:Boolean;
      
      private var child_job$field:int;
      
      private var child_name$field:String;
      
      private var child_sex$field:int;
      
      private var child_fightcap$field:int;
      
      private var growth_grade$field:int;
      
      private var change_branch$field:int;
      
      private var player_uuid$field:String;
      
      private var monster_id$field:int;
      
      private var avenger_grade$field:int;
      
      private var growth_grade2$field:int;
      
      private var theseusMultiPvpRankName$field:String;
      
      private var theseusMultiPvpIntegral$field:int;
      
      public function RoomPlayerMsg()
      {
         super();
      }
      
      public function removeRoomId() : void
      {
         hasField$0 &= 4294967294;
         room_id$field = new int();
      }
      
      public function get hasRoomId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set roomId(param1:int) : void
      {
         hasField$0 |= 1;
         room_id$field = param1;
      }
      
      public function get roomId() : int
      {
         return room_id$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967293;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 2;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeCurrentRoomIndex() : void
      {
         hasField$0 &= 4294967291;
         current_room_index$field = new int();
      }
      
      public function get hasCurrentRoomIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currentRoomIndex(param1:int) : void
      {
         hasField$0 |= 4;
         current_room_index$field = param1;
      }
      
      public function get currentRoomIndex() : int
      {
         return current_room_index$field;
      }
      
      public function removePlayerState() : void
      {
         hasField$0 &= 4294967287;
         player_state$field = new int();
      }
      
      public function get hasPlayerState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set playerState(param1:int) : void
      {
         hasField$0 |= 8;
         player_state$field = param1;
      }
      
      public function get playerState() : int
      {
         return player_state$field;
      }
      
      public function removeHeroId() : void
      {
         hasField$0 &= 4294967279;
         hero_id$field = new int();
      }
      
      public function get hasHeroId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set heroId(param1:int) : void
      {
         hasField$0 |= 16;
         hero_id$field = param1;
      }
      
      public function get heroId() : int
      {
         return hero_id$field;
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967263;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 32;
         player_id$field = param1;
      }
      
      public function get playerId() : int
      {
         return player_id$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967231;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 64;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
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
         hasField$0 &= 4294967167;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 128;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967039;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 256;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
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
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294966783;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 512;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removeFightingCapacity() : void
      {
         hasField$0 &= 4294966271;
         fighting_capacity$field = new int();
      }
      
      public function get hasFightingCapacity() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set fightingCapacity(param1:int) : void
      {
         hasField$0 |= 1024;
         fighting_capacity$field = param1;
      }
      
      public function get fightingCapacity() : int
      {
         return fighting_capacity$field;
      }
      
      public function removeCurPosX() : void
      {
         hasField$0 &= 4294965247;
         cur_pos_x$field = new int();
      }
      
      public function get hasCurPosX() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set curPosX(param1:int) : void
      {
         hasField$0 |= 2048;
         cur_pos_x$field = param1;
      }
      
      public function get curPosX() : int
      {
         return cur_pos_x$field;
      }
      
      public function removeCurPosY() : void
      {
         hasField$0 &= 4294963199;
         cur_pos_y$field = new int();
      }
      
      public function get hasCurPosY() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set curPosY(param1:int) : void
      {
         hasField$0 |= 4096;
         cur_pos_y$field = param1;
      }
      
      public function get curPosY() : int
      {
         return cur_pos_y$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294959103;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 8192;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeOnlineState() : void
      {
         hasField$0 &= 4294950911;
         online_state$field = new Boolean();
      }
      
      public function get hasOnlineState() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set onlineState(param1:Boolean) : void
      {
         hasField$0 |= 16384;
         online_state$field = param1;
      }
      
      public function get onlineState() : Boolean
      {
         return online_state$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294934527;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 32768;
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
      
      public function removeChangeShapeId() : void
      {
         hasField$0 &= 4294901759;
         change_shapeId$field = new int();
      }
      
      public function get hasChangeShapeId() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set changeShapeId(param1:int) : void
      {
         hasField$0 |= 65536;
         change_shapeId$field = param1;
      }
      
      public function get changeShapeId() : int
      {
         return change_shapeId$field;
      }
      
      public function removeArmyState() : void
      {
         hasField$0 &= 4294836223;
         army_state$field = new int();
      }
      
      public function get hasArmyState() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set armyState(param1:int) : void
      {
         hasField$0 |= 131072;
         army_state$field = param1;
      }
      
      public function get armyState() : int
      {
         return army_state$field;
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294705151;
         team_id$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 262144;
         team_id$field = param1;
      }
      
      public function get teamId() : int
      {
         return team_id$field;
      }
      
      public function removeBufferTempId() : void
      {
         hasField$0 &= 4294443007;
         buffer_tempId$field = new int();
      }
      
      public function get hasBufferTempId() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set bufferTempId(param1:int) : void
      {
         hasField$0 |= 524288;
         buffer_tempId$field = param1;
      }
      
      public function get bufferTempId() : int
      {
         return buffer_tempId$field;
      }
      
      public function removeGeste() : void
      {
         hasField$0 &= 4293918719;
         geste$field = new int();
      }
      
      public function get hasGeste() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set geste(param1:int) : void
      {
         hasField$0 |= 1048576;
         geste$field = param1;
      }
      
      public function get geste() : int
      {
         return geste$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4292870143;
         head_id$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 2097152;
         head_id$field = param1;
      }
      
      public function get headId() : int
      {
         return head_id$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4290772991;
         is_vip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 4194304;
         is_vip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return is_vip$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4286578687;
         vip_type$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 8388608;
         vip_type$field = param1;
      }
      
      public function get vipType() : int
      {
         return vip_type$field;
      }
      
      public function removeMountTempId() : void
      {
         hasField$0 &= 4278190079;
         mount_tempId$field = new int();
      }
      
      public function get hasMountTempId() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set mountTempId(param1:int) : void
      {
         hasField$0 |= 16777216;
         mount_tempId$field = param1;
      }
      
      public function get mountTempId() : int
      {
         return mount_tempId$field;
      }
      
      public function removeMountGrade() : void
      {
         hasField$0 &= 4261412863;
         mount_grade$field = new int();
      }
      
      public function get hasMountGrade() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set mountGrade(param1:int) : void
      {
         hasField$0 |= 33554432;
         mount_grade$field = param1;
      }
      
      public function get mountGrade() : int
      {
         return mount_grade$field;
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
      
      public function removeAppellid() : void
      {
         hasField$0 &= 4160749567;
         appellid$field = new int();
      }
      
      public function get hasAppellid() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set appellid(param1:int) : void
      {
         hasField$0 |= 134217728;
         appellid$field = param1;
      }
      
      public function get appellid() : int
      {
         return appellid$field;
      }
      
      public function removeVehicleTemplateId() : void
      {
         hasField$0 &= 4026531839;
         vehicleTemplateId$field = new int();
      }
      
      public function get hasVehicleTemplateId() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set vehicleTemplateId(param1:int) : void
      {
         hasField$0 |= 268435456;
         vehicleTemplateId$field = param1;
      }
      
      public function get vehicleTemplateId() : int
      {
         return vehicleTemplateId$field;
      }
      
      public function removeFateSkills() : void
      {
         fate_skills$field = null;
      }
      
      public function get hasFateSkills() : Boolean
      {
         return fate_skills$field != null;
      }
      
      public function set fateSkills(param1:String) : void
      {
         fate_skills$field = param1;
      }
      
      public function get fateSkills() : String
      {
         return fate_skills$field;
      }
      
      public function removePetTemplateId() : void
      {
         hasField$0 &= 3758096383;
         petTemplateId$field = new int();
      }
      
      public function get hasPetTemplateId() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set petTemplateId(param1:int) : void
      {
         hasField$0 |= 536870912;
         petTemplateId$field = param1;
      }
      
      public function get petTemplateId() : int
      {
         return petTemplateId$field;
      }
      
      public function removePetQuqlity() : void
      {
         hasField$0 &= 3221225471;
         pet_quqlity$field = new int();
      }
      
      public function get hasPetQuqlity() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set petQuqlity(param1:int) : void
      {
         hasField$0 |= 1073741824;
         pet_quqlity$field = param1;
      }
      
      public function get petQuqlity() : int
      {
         return pet_quqlity$field;
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
      
      public function removeIsNoGet() : void
      {
         hasField$0 &= 2147483647;
         isNoGet$field = new Boolean();
      }
      
      public function get hasIsNoGet() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set isNoGet(param1:Boolean) : void
      {
         hasField$0 |= 2147483648;
         isNoGet$field = param1;
      }
      
      public function get isNoGet() : Boolean
      {
         return isNoGet$field;
      }
      
      public function removeDragonGrade() : void
      {
         dragon_grade$field = null;
      }
      
      public function get hasDragonGrade() : Boolean
      {
         return dragon_grade$field != null;
      }
      
      public function set dragonGrade(param1:String) : void
      {
         dragon_grade$field = param1;
      }
      
      public function get dragonGrade() : String
      {
         return dragon_grade$field;
      }
      
      public function removeTransferGrade() : void
      {
         hasField$1 &= 4294967294;
         transfer_grade$field = new int();
      }
      
      public function get hasTransferGrade() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set transferGrade(param1:int) : void
      {
         hasField$1 |= 1;
         transfer_grade$field = param1;
      }
      
      public function get transferGrade() : int
      {
         return transfer_grade$field;
      }
      
      public function removeRank() : void
      {
         hasField$1 &= 4294967293;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$1 |= 2;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeGroupType() : void
      {
         hasField$1 &= 4294967291;
         group_type$field = new int();
      }
      
      public function get hasGroupType() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set groupType(param1:int) : void
      {
         hasField$1 |= 4;
         group_type$field = param1;
      }
      
      public function get groupType() : int
      {
         return group_type$field;
      }
      
      public function removeIsBackPlayer() : void
      {
         hasField$1 &= 4294967287;
         is_back_player$field = new Boolean();
      }
      
      public function get hasIsBackPlayer() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set isBackPlayer(param1:Boolean) : void
      {
         hasField$1 |= 8;
         is_back_player$field = param1;
      }
      
      public function get isBackPlayer() : Boolean
      {
         return is_back_player$field;
      }
      
      public function removeChildJob() : void
      {
         hasField$1 &= 4294967279;
         child_job$field = new int();
      }
      
      public function get hasChildJob() : Boolean
      {
         return (hasField$1 & 0x10) != 0;
      }
      
      public function set childJob(param1:int) : void
      {
         hasField$1 |= 16;
         child_job$field = param1;
      }
      
      public function get childJob() : int
      {
         return child_job$field;
      }
      
      public function removeChildName() : void
      {
         child_name$field = null;
      }
      
      public function get hasChildName() : Boolean
      {
         return child_name$field != null;
      }
      
      public function set childName(param1:String) : void
      {
         child_name$field = param1;
      }
      
      public function get childName() : String
      {
         return child_name$field;
      }
      
      public function removeChildSex() : void
      {
         hasField$1 &= 4294967263;
         child_sex$field = new int();
      }
      
      public function get hasChildSex() : Boolean
      {
         return (hasField$1 & 0x20) != 0;
      }
      
      public function set childSex(param1:int) : void
      {
         hasField$1 |= 32;
         child_sex$field = param1;
      }
      
      public function get childSex() : int
      {
         return child_sex$field;
      }
      
      public function removeChildFightcap() : void
      {
         hasField$1 &= 4294967231;
         child_fightcap$field = new int();
      }
      
      public function get hasChildFightcap() : Boolean
      {
         return (hasField$1 & 0x40) != 0;
      }
      
      public function set childFightcap(param1:int) : void
      {
         hasField$1 |= 64;
         child_fightcap$field = param1;
      }
      
      public function get childFightcap() : int
      {
         return child_fightcap$field;
      }
      
      public function removeGrowthGrade() : void
      {
         hasField$1 &= 4294967167;
         growth_grade$field = new int();
      }
      
      public function get hasGrowthGrade() : Boolean
      {
         return (hasField$1 & 0x80) != 0;
      }
      
      public function set growthGrade(param1:int) : void
      {
         hasField$1 |= 128;
         growth_grade$field = param1;
      }
      
      public function get growthGrade() : int
      {
         return growth_grade$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$1 &= 4294967039;
         change_branch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$1 & 0x0100) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$1 |= 256;
         change_branch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return change_branch$field;
      }
      
      public function removePlayerUuid() : void
      {
         player_uuid$field = null;
      }
      
      public function get hasPlayerUuid() : Boolean
      {
         return player_uuid$field != null;
      }
      
      public function set playerUuid(param1:String) : void
      {
         player_uuid$field = param1;
      }
      
      public function get playerUuid() : String
      {
         return player_uuid$field;
      }
      
      public function removeMonsterId() : void
      {
         hasField$1 &= 4294966783;
         monster_id$field = new int();
      }
      
      public function get hasMonsterId() : Boolean
      {
         return (hasField$1 & 0x0200) != 0;
      }
      
      public function set monsterId(param1:int) : void
      {
         hasField$1 |= 512;
         monster_id$field = param1;
      }
      
      public function get monsterId() : int
      {
         return monster_id$field;
      }
      
      public function removeAvengerGrade() : void
      {
         hasField$1 &= 4294966271;
         avenger_grade$field = new int();
      }
      
      public function get hasAvengerGrade() : Boolean
      {
         return (hasField$1 & 0x0400) != 0;
      }
      
      public function set avengerGrade(param1:int) : void
      {
         hasField$1 |= 1024;
         avenger_grade$field = param1;
      }
      
      public function get avengerGrade() : int
      {
         return avenger_grade$field;
      }
      
      public function removeGrowthGrade2() : void
      {
         hasField$1 &= 4294965247;
         growth_grade2$field = new int();
      }
      
      public function get hasGrowthGrade2() : Boolean
      {
         return (hasField$1 & 0x0800) != 0;
      }
      
      public function set growthGrade2(param1:int) : void
      {
         hasField$1 |= 2048;
         growth_grade2$field = param1;
      }
      
      public function get growthGrade2() : int
      {
         return growth_grade2$field;
      }
      
      public function removeTheseusMultiPvpRankName() : void
      {
         theseusMultiPvpRankName$field = null;
      }
      
      public function get hasTheseusMultiPvpRankName() : Boolean
      {
         return theseusMultiPvpRankName$field != null;
      }
      
      public function set theseusMultiPvpRankName(param1:String) : void
      {
         theseusMultiPvpRankName$field = param1;
      }
      
      public function get theseusMultiPvpRankName() : String
      {
         return theseusMultiPvpRankName$field;
      }
      
      public function removeTheseusMultiPvpIntegral() : void
      {
         hasField$1 &= 4294963199;
         theseusMultiPvpIntegral$field = new int();
      }
      
      public function get hasTheseusMultiPvpIntegral() : Boolean
      {
         return (hasField$1 & 0x1000) != 0;
      }
      
      public function set theseusMultiPvpIntegral(param1:int) : void
      {
         hasField$1 |= 4096;
         theseusMultiPvpIntegral$field = param1;
      }
      
      public function get theseusMultiPvpIntegral() : int
      {
         return theseusMultiPvpIntegral$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRoomId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,room_id$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasCurrentRoomIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,current_room_index$field);
         }
         if(hasPlayerState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,player_state$field);
         }
         if(hasHeroId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,hero_id$field);
         }
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasSex)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,sex$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasCloth)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,cloth$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasFightingCapacity)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,fighting_capacity$field);
         }
         if(hasCurPosX)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_x$field);
         }
         if(hasCurPosY)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_y$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasOnlineState)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_BOOL(param1,online_state$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasChangeShapeId)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,change_shapeId$field);
         }
         if(hasArmyState)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,army_state$field);
         }
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,team_id$field);
         }
         if(hasBufferTempId)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,buffer_tempId$field);
         }
         if(hasGeste)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,geste$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,head_id$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_BOOL(param1,is_vip$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,vip_type$field);
         }
         if(hasMountTempId)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,mount_tempId$field);
         }
         if(hasMountGrade)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,mount_grade$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,31);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,32);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,33);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,34);
            WriteUtils.write$TYPE_STRING(param1,fashion_arm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,35);
            WriteUtils.write$TYPE_STRING(param1,fashion_cloth$field);
         }
         if(hasHide)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_BOOL(param1,hide$field);
         }
         if(hasAppellid)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_INT32(param1,appellid$field);
         }
         if(hasVehicleTemplateId)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_INT32(param1,vehicleTemplateId$field);
         }
         if(hasFateSkills)
         {
            WriteUtils.writeTag(param1,2,39);
            WriteUtils.write$TYPE_STRING(param1,fate_skills$field);
         }
         if(hasPetTemplateId)
         {
            WriteUtils.writeTag(param1,0,40);
            WriteUtils.write$TYPE_INT32(param1,petTemplateId$field);
         }
         if(hasPetQuqlity)
         {
            WriteUtils.writeTag(param1,0,41);
            WriteUtils.write$TYPE_INT32(param1,pet_quqlity$field);
         }
         if(hasPetName)
         {
            WriteUtils.writeTag(param1,2,42);
            WriteUtils.write$TYPE_STRING(param1,pet_name$field);
         }
         if(hasIsNoGet)
         {
            WriteUtils.writeTag(param1,0,43);
            WriteUtils.write$TYPE_BOOL(param1,isNoGet$field);
         }
         if(hasDragonGrade)
         {
            WriteUtils.writeTag(param1,2,44);
            WriteUtils.write$TYPE_STRING(param1,dragon_grade$field);
         }
         if(hasTransferGrade)
         {
            WriteUtils.writeTag(param1,0,45);
            WriteUtils.write$TYPE_INT32(param1,transfer_grade$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,46);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasGroupType)
         {
            WriteUtils.writeTag(param1,0,47);
            WriteUtils.write$TYPE_INT32(param1,group_type$field);
         }
         if(hasIsBackPlayer)
         {
            WriteUtils.writeTag(param1,0,48);
            WriteUtils.write$TYPE_BOOL(param1,is_back_player$field);
         }
         if(hasChildJob)
         {
            WriteUtils.writeTag(param1,0,49);
            WriteUtils.write$TYPE_INT32(param1,child_job$field);
         }
         if(hasChildName)
         {
            WriteUtils.writeTag(param1,2,50);
            WriteUtils.write$TYPE_STRING(param1,child_name$field);
         }
         if(hasChildSex)
         {
            WriteUtils.writeTag(param1,0,51);
            WriteUtils.write$TYPE_INT32(param1,child_sex$field);
         }
         if(hasChildFightcap)
         {
            WriteUtils.writeTag(param1,0,52);
            WriteUtils.write$TYPE_INT32(param1,child_fightcap$field);
         }
         if(hasGrowthGrade)
         {
            WriteUtils.writeTag(param1,0,53);
            WriteUtils.write$TYPE_INT32(param1,growth_grade$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,54);
            WriteUtils.write$TYPE_INT32(param1,change_branch$field);
         }
         if(hasPlayerUuid)
         {
            WriteUtils.writeTag(param1,2,55);
            WriteUtils.write$TYPE_STRING(param1,player_uuid$field);
         }
         if(hasMonsterId)
         {
            WriteUtils.writeTag(param1,0,56);
            WriteUtils.write$TYPE_INT32(param1,monster_id$field);
         }
         if(hasAvengerGrade)
         {
            WriteUtils.writeTag(param1,0,57);
            WriteUtils.write$TYPE_INT32(param1,avenger_grade$field);
         }
         if(hasGrowthGrade2)
         {
            WriteUtils.writeTag(param1,0,58);
            WriteUtils.write$TYPE_INT32(param1,growth_grade2$field);
         }
         if(hasTheseusMultiPvpRankName)
         {
            WriteUtils.writeTag(param1,2,59);
            WriteUtils.write$TYPE_STRING(param1,theseusMultiPvpRankName$field);
         }
         if(hasTheseusMultiPvpIntegral)
         {
            WriteUtils.writeTag(param1,0,60);
            WriteUtils.write$TYPE_INT32(param1,theseusMultiPvpIntegral$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc32_:uint = 0;
         var _loc3_:uint = 0;
         var _loc50_:uint = 0;
         var _loc63_:uint = 0;
         var _loc27_:uint = 0;
         var _loc4_:uint = 0;
         var _loc54_:uint = 0;
         var _loc39_:uint = 0;
         var _loc43_:uint = 0;
         var _loc17_:uint = 0;
         var _loc13_:uint = 0;
         var _loc34_:uint = 0;
         var _loc30_:uint = 0;
         var _loc9_:uint = 0;
         var _loc44_:uint = 0;
         var _loc19_:uint = 0;
         var _loc49_:uint = 0;
         var _loc42_:uint = 0;
         var _loc51_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc29_:uint = 0;
         var _loc48_:uint = 0;
         var _loc7_:uint = 0;
         var _loc55_:uint = 0;
         var _loc26_:uint = 0;
         var _loc57_:uint = 0;
         var _loc16_:uint = 0;
         var _loc56_:uint = 0;
         var _loc23_:uint = 0;
         var _loc15_:uint = 0;
         var _loc8_:uint = 0;
         var _loc38_:uint = 0;
         var _loc33_:uint = 0;
         var _loc24_:uint = 0;
         var _loc58_:uint = 0;
         var _loc21_:uint = 0;
         var _loc46_:uint = 0;
         var _loc40_:uint = 0;
         var _loc41_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc35_:uint = 0;
         var _loc47_:uint = 0;
         var _loc14_:uint = 0;
         var _loc22_:uint = 0;
         var _loc62_:uint = 0;
         var _loc52_:uint = 0;
         var _loc61_:uint = 0;
         var _loc60_:uint = 0;
         var _loc37_:uint = 0;
         var _loc20_:uint = 0;
         var _loc45_:uint = 0;
         var _loc53_:uint = 0;
         var _loc28_:uint = 0;
         var _loc10_:uint = 0;
         var _loc25_:uint = 0;
         var _loc36_:uint = 0;
         var _loc59_:uint = 0;
         var _loc31_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.roomId cannot be set twice.");
                  }
                  _loc32_++;
                  roomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc50_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.currentRoomIndex cannot be set twice.");
                  }
                  _loc50_++;
                  currentRoomIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc63_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.playerState cannot be set twice.");
                  }
                  _loc63_++;
                  playerState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.heroId cannot be set twice.");
                  }
                  _loc27_++;
                  heroId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.playerId cannot be set twice.");
                  }
                  _loc4_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc54_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.grades cannot be set twice.");
                  }
                  _loc54_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.nickName cannot be set twice.");
                  }
                  _loc39_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc43_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.sex cannot be set twice.");
                  }
                  _loc43_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.templateId cannot be set twice.");
                  }
                  _loc17_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.arm cannot be set twice.");
                  }
                  _loc13_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.cloth cannot be set twice.");
                  }
                  _loc34_++;
                  cloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.armyId cannot be set twice.");
                  }
                  _loc30_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.fightingCapacity cannot be set twice.");
                  }
                  _loc9_++;
                  fightingCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.curPosX cannot be set twice.");
                  }
                  _loc44_++;
                  curPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.curPosY cannot be set twice.");
                  }
                  _loc19_++;
                  curPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc49_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.campaignId cannot be set twice.");
                  }
                  _loc49_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc42_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.onlineState cannot be set twice.");
                  }
                  _loc42_++;
                  onlineState = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 19:
                  if(_loc51_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.consortiaId cannot be set twice.");
                  }
                  _loc51_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.consortiaName cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 21:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.changeShapeId cannot be set twice.");
                  }
                  _loc11_++;
                  changeShapeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.armyState cannot be set twice.");
                  }
                  _loc29_++;
                  armyState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc48_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.teamId cannot be set twice.");
                  }
                  _loc48_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.bufferTempId cannot be set twice.");
                  }
                  _loc7_++;
                  bufferTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc55_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.geste cannot be set twice.");
                  }
                  _loc55_++;
                  geste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.headId cannot be set twice.");
                  }
                  _loc26_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc57_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.isVip cannot be set twice.");
                  }
                  _loc57_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 28:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.vipType cannot be set twice.");
                  }
                  _loc16_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc56_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.mountTempId cannot be set twice.");
                  }
                  _loc56_++;
                  mountTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.mountGrade cannot be set twice.");
                  }
                  _loc23_++;
                  mountGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.wing cannot be set twice.");
                  }
                  _loc15_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 32:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.serverName cannot be set twice.");
                  }
                  _loc8_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 33:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.hat cannot be set twice.");
                  }
                  _loc38_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 34:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.fashionArm cannot be set twice.");
                  }
                  _loc33_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 35:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.fashionCloth cannot be set twice.");
                  }
                  _loc24_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 36:
                  if(_loc58_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.hide cannot be set twice.");
                  }
                  _loc58_++;
                  hide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 37:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.appellid cannot be set twice.");
                  }
                  _loc21_++;
                  appellid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 38:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.vehicleTemplateId cannot be set twice.");
                  }
                  _loc46_++;
                  vehicleTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 39:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.fateSkills cannot be set twice.");
                  }
                  _loc40_++;
                  fateSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 40:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.petTemplateId cannot be set twice.");
                  }
                  _loc41_++;
                  petTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 41:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.petQuqlity cannot be set twice.");
                  }
                  _loc12_++;
                  petQuqlity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 42:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.petName cannot be set twice.");
                  }
                  _loc6_++;
                  petName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 43:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.isNoGet cannot be set twice.");
                  }
                  _loc35_++;
                  isNoGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 44:
                  if(_loc47_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.dragonGrade cannot be set twice.");
                  }
                  _loc47_++;
                  dragonGrade = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 45:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.transferGrade cannot be set twice.");
                  }
                  _loc14_++;
                  transferGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 46:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.rank cannot be set twice.");
                  }
                  _loc22_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 47:
                  if(_loc62_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.groupType cannot be set twice.");
                  }
                  _loc62_++;
                  groupType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 48:
                  if(_loc52_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.isBackPlayer cannot be set twice.");
                  }
                  _loc52_++;
                  isBackPlayer = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 49:
                  if(_loc61_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.childJob cannot be set twice.");
                  }
                  _loc61_++;
                  childJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 50:
                  if(_loc60_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.childName cannot be set twice.");
                  }
                  _loc60_++;
                  childName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 51:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.childSex cannot be set twice.");
                  }
                  _loc37_++;
                  childSex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 52:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.childFightcap cannot be set twice.");
                  }
                  _loc20_++;
                  childFightcap = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 53:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.growthGrade cannot be set twice.");
                  }
                  _loc45_++;
                  growthGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 54:
                  if(_loc53_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.changeBranch cannot be set twice.");
                  }
                  _loc53_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 55:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.playerUuid cannot be set twice.");
                  }
                  _loc28_++;
                  playerUuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 56:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.monsterId cannot be set twice.");
                  }
                  _loc10_++;
                  monsterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 57:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.avengerGrade cannot be set twice.");
                  }
                  _loc25_++;
                  avengerGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 58:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.growthGrade2 cannot be set twice.");
                  }
                  _loc36_++;
                  growthGrade2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 59:
                  if(_loc59_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.theseusMultiPvpRankName cannot be set twice.");
                  }
                  _loc59_++;
                  theseusMultiPvpRankName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 60:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: RoomPlayerMsg.theseusMultiPvpIntegral cannot be set twice.");
                  }
                  _loc31_++;
                  theseusMultiPvpIntegral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

