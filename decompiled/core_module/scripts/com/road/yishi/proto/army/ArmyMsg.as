package com.road.yishi.proto.army
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArmyMsg extends Message implements IExternalizable
   {
      
      private var army_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var player_id$field:int;
      
      private var nick_name$field:String;
      
      private var map_id$field:int;
      
      private var cur_pos_x$field:int;
      
      private var cur_pos_y$field:int;
      
      private var state$field:int;
      
      private var type$field:int;
      
      [ArrayElementType("com.road.yishi.proto.army.ArmyPawnInfoMsg")]
      public var armyPawn:Array = [];
      
      private var simple_hero_info$field:SimpleHeroInfoMsg;
      
      private var consortia_id$field:int;
      
      private var consortia_name$field:String;
      
      private var fightingCapacity$field:int;
      
      private var gpOrder$field:int;
      
      private var grades$field:int;
      
      private var arm$field:String;
      
      private var cloth$field:String;
      
      private var job$field:int;
      
      private var change_sharp$field:int;
      
      private var hero_tempId$field:int;
      
      [ArrayElementType("int")]
      public var userIds:Array = [];
      
      private var geste$field:int;
      
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
      
      private var fate_skills$field:String;
      
      private var pet_tempId$field:int;
      
      private var pet_quqlity$field:int;
      
      private var pet_name$field:String;
      
      private var child_job$field:int;
      
      private var child_name$field:String;
      
      private var child_sex$field:int;
      
      private var growth_grade$field:int;
      
      private var monster_id$field:int;
      
      private var avenger_grade$field:int;
      
      private var growth_grade2$field:int;
      
      public function ArmyMsg()
      {
         super();
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967294;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 1;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967293;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 2;
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
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967291;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 4;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removeCurPosX() : void
      {
         hasField$0 &= 4294967287;
         cur_pos_x$field = new int();
      }
      
      public function get hasCurPosX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set curPosX(param1:int) : void
      {
         hasField$0 |= 8;
         cur_pos_x$field = param1;
      }
      
      public function get curPosX() : int
      {
         return cur_pos_x$field;
      }
      
      public function removeCurPosY() : void
      {
         hasField$0 &= 4294967279;
         cur_pos_y$field = new int();
      }
      
      public function get hasCurPosY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set curPosY(param1:int) : void
      {
         hasField$0 |= 16;
         cur_pos_y$field = param1;
      }
      
      public function get curPosY() : int
      {
         return cur_pos_y$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967263;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 32;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967231;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 64;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeSimpleHeroInfo() : void
      {
         simple_hero_info$field = null;
      }
      
      public function get hasSimpleHeroInfo() : Boolean
      {
         return simple_hero_info$field != null;
      }
      
      public function set simpleHeroInfo(param1:SimpleHeroInfoMsg) : void
      {
         simple_hero_info$field = param1;
      }
      
      public function get simpleHeroInfo() : SimpleHeroInfoMsg
      {
         return simple_hero_info$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967167;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 128;
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
      
      public function removeFightingCapacity() : void
      {
         hasField$0 &= 4294967039;
         fightingCapacity$field = new int();
      }
      
      public function get hasFightingCapacity() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set fightingCapacity(param1:int) : void
      {
         hasField$0 |= 256;
         fightingCapacity$field = param1;
      }
      
      public function get fightingCapacity() : int
      {
         return fightingCapacity$field;
      }
      
      public function removeGpOrder() : void
      {
         hasField$0 &= 4294966783;
         gpOrder$field = new int();
      }
      
      public function get hasGpOrder() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set gpOrder(param1:int) : void
      {
         hasField$0 |= 512;
         gpOrder$field = param1;
      }
      
      public function get gpOrder() : int
      {
         return gpOrder$field;
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
      
      public function removeJob() : void
      {
         hasField$0 &= 4294965247;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 2048;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeChangeSharp() : void
      {
         hasField$0 &= 4294963199;
         change_sharp$field = new int();
      }
      
      public function get hasChangeSharp() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set changeSharp(param1:int) : void
      {
         hasField$0 |= 4096;
         change_sharp$field = param1;
      }
      
      public function get changeSharp() : int
      {
         return change_sharp$field;
      }
      
      public function removeHeroTempId() : void
      {
         hasField$0 &= 4294959103;
         hero_tempId$field = new int();
      }
      
      public function get hasHeroTempId() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set heroTempId(param1:int) : void
      {
         hasField$0 |= 8192;
         hero_tempId$field = param1;
      }
      
      public function get heroTempId() : int
      {
         return hero_tempId$field;
      }
      
      public function removeGeste() : void
      {
         hasField$0 &= 4294950911;
         geste$field = new int();
      }
      
      public function get hasGeste() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set geste(param1:int) : void
      {
         hasField$0 |= 16384;
         geste$field = param1;
      }
      
      public function get geste() : int
      {
         return geste$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294934527;
         is_vip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 32768;
         is_vip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return is_vip$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294901759;
         vip_type$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 65536;
         vip_type$field = param1;
      }
      
      public function get vipType() : int
      {
         return vip_type$field;
      }
      
      public function removeMountTempId() : void
      {
         hasField$0 &= 4294836223;
         mount_tempId$field = new int();
      }
      
      public function get hasMountTempId() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set mountTempId(param1:int) : void
      {
         hasField$0 |= 131072;
         mount_tempId$field = param1;
      }
      
      public function get mountTempId() : int
      {
         return mount_tempId$field;
      }
      
      public function removeMountGrade() : void
      {
         hasField$0 &= 4294705151;
         mount_grade$field = new int();
      }
      
      public function get hasMountGrade() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set mountGrade(param1:int) : void
      {
         hasField$0 |= 262144;
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
         hasField$0 &= 4294443007;
         hide$field = new Boolean();
      }
      
      public function get hasHide() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set hide(param1:Boolean) : void
      {
         hasField$0 |= 524288;
         hide$field = param1;
      }
      
      public function get hide() : Boolean
      {
         return hide$field;
      }
      
      public function removeAppellid() : void
      {
         hasField$0 &= 4293918719;
         appellid$field = new int();
      }
      
      public function get hasAppellid() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set appellid(param1:int) : void
      {
         hasField$0 |= 1048576;
         appellid$field = param1;
      }
      
      public function get appellid() : int
      {
         return appellid$field;
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
      
      public function removePetTempId() : void
      {
         hasField$0 &= 4292870143;
         pet_tempId$field = new int();
      }
      
      public function get hasPetTempId() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set petTempId(param1:int) : void
      {
         hasField$0 |= 2097152;
         pet_tempId$field = param1;
      }
      
      public function get petTempId() : int
      {
         return pet_tempId$field;
      }
      
      public function removePetQuqlity() : void
      {
         hasField$0 &= 4290772991;
         pet_quqlity$field = new int();
      }
      
      public function get hasPetQuqlity() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set petQuqlity(param1:int) : void
      {
         hasField$0 |= 4194304;
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
      
      public function removeChildJob() : void
      {
         hasField$0 &= 4286578687;
         child_job$field = new int();
      }
      
      public function get hasChildJob() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set childJob(param1:int) : void
      {
         hasField$0 |= 8388608;
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
         hasField$0 &= 4278190079;
         child_sex$field = new int();
      }
      
      public function get hasChildSex() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set childSex(param1:int) : void
      {
         hasField$0 |= 16777216;
         child_sex$field = param1;
      }
      
      public function get childSex() : int
      {
         return child_sex$field;
      }
      
      public function removeGrowthGrade() : void
      {
         hasField$0 &= 4261412863;
         growth_grade$field = new int();
      }
      
      public function get hasGrowthGrade() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set growthGrade(param1:int) : void
      {
         hasField$0 |= 33554432;
         growth_grade$field = param1;
      }
      
      public function get growthGrade() : int
      {
         return growth_grade$field;
      }
      
      public function removeMonsterId() : void
      {
         hasField$0 &= 4227858431;
         monster_id$field = new int();
      }
      
      public function get hasMonsterId() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set monsterId(param1:int) : void
      {
         hasField$0 |= 67108864;
         monster_id$field = param1;
      }
      
      public function get monsterId() : int
      {
         return monster_id$field;
      }
      
      public function removeAvengerGrade() : void
      {
         hasField$0 &= 4160749567;
         avenger_grade$field = new int();
      }
      
      public function get hasAvengerGrade() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set avengerGrade(param1:int) : void
      {
         hasField$0 |= 134217728;
         avenger_grade$field = param1;
      }
      
      public function get avengerGrade() : int
      {
         return avenger_grade$field;
      }
      
      public function removeGrowthGrade2() : void
      {
         hasField$0 &= 4026531839;
         growth_grade2$field = new int();
      }
      
      public function get hasGrowthGrade2() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set growthGrade2(param1:int) : void
      {
         hasField$0 |= 268435456;
         growth_grade2$field = param1;
      }
      
      public function get growthGrade2() : int
      {
         return growth_grade2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasCurPosX)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_x$field);
         }
         if(hasCurPosY)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_y$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         _loc2_ = 0;
         while(_loc2_ < armyPawn.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,armyPawn[_loc2_]);
            _loc2_++;
         }
         if(hasSimpleHeroInfo)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,simple_hero_info$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasFightingCapacity)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,fightingCapacity$field);
         }
         if(hasGpOrder)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,gpOrder$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasCloth)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,cloth$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasChangeSharp)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,change_sharp$field);
         }
         if(hasHeroTempId)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,hero_tempId$field);
         }
         _loc3_ = 0;
         while(_loc3_ < userIds.length)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,userIds[_loc3_]);
            _loc3_++;
         }
         if(hasGeste)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,geste$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_BOOL(param1,is_vip$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,vip_type$field);
         }
         if(hasMountTempId)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,mount_tempId$field);
         }
         if(hasMountGrade)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,mount_grade$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,27);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,28);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,29);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,30);
            WriteUtils.write$TYPE_STRING(param1,fashion_arm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,31);
            WriteUtils.write$TYPE_STRING(param1,fashion_cloth$field);
         }
         if(hasHide)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_BOOL(param1,hide$field);
         }
         if(hasAppellid)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_INT32(param1,appellid$field);
         }
         if(hasFateSkills)
         {
            WriteUtils.writeTag(param1,2,34);
            WriteUtils.write$TYPE_STRING(param1,fate_skills$field);
         }
         if(hasPetTempId)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,pet_tempId$field);
         }
         if(hasPetQuqlity)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,pet_quqlity$field);
         }
         if(hasPetName)
         {
            WriteUtils.writeTag(param1,2,37);
            WriteUtils.write$TYPE_STRING(param1,pet_name$field);
         }
         if(hasChildJob)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_INT32(param1,child_job$field);
         }
         if(hasChildName)
         {
            WriteUtils.writeTag(param1,2,39);
            WriteUtils.write$TYPE_STRING(param1,child_name$field);
         }
         if(hasChildSex)
         {
            WriteUtils.writeTag(param1,0,40);
            WriteUtils.write$TYPE_INT32(param1,child_sex$field);
         }
         if(hasGrowthGrade)
         {
            WriteUtils.writeTag(param1,0,41);
            WriteUtils.write$TYPE_INT32(param1,growth_grade$field);
         }
         if(hasMonsterId)
         {
            WriteUtils.writeTag(param1,0,42);
            WriteUtils.write$TYPE_INT32(param1,monster_id$field);
         }
         if(hasAvengerGrade)
         {
            WriteUtils.writeTag(param1,0,43);
            WriteUtils.write$TYPE_INT32(param1,avenger_grade$field);
         }
         if(hasGrowthGrade2)
         {
            WriteUtils.writeTag(param1,0,44);
            WriteUtils.write$TYPE_INT32(param1,growth_grade2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc22_:* = 0;
         var _loc33_:ArmyPawnInfoMsg = null;
         var _loc40_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc44_:uint = 0;
         var _loc8_:uint = 0;
         var _loc26_:uint = 0;
         var _loc20_:uint = 0;
         var _loc35_:uint = 0;
         var _loc11_:uint = 0;
         var _loc15_:uint = 0;
         var _loc7_:uint = 0;
         var _loc17_:uint = 0;
         var _loc41_:uint = 0;
         var _loc23_:uint = 0;
         var _loc16_:uint = 0;
         var _loc43_:uint = 0;
         var _loc18_:uint = 0;
         var _loc38_:uint = 0;
         var _loc32_:uint = 0;
         var _loc24_:uint = 0;
         var _loc27_:uint = 0;
         var _loc21_:uint = 0;
         var _loc25_:uint = 0;
         var _loc29_:uint = 0;
         var _loc19_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc42_:uint = 0;
         var _loc30_:uint = 0;
         var _loc31_:uint = 0;
         var _loc28_:uint = 0;
         var _loc5_:uint = 0;
         var _loc39_:uint = 0;
         var _loc14_:uint = 0;
         var _loc9_:uint = 0;
         var _loc37_:uint = 0;
         var _loc36_:uint = 0;
         var _loc46_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc34_:uint = 0;
         var _loc45_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc22_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.armyId cannot be set twice.");
                  }
                  _loc40_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.playerId cannot be set twice.");
                  }
                  _loc6_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.mapId cannot be set twice.");
                  }
                  _loc44_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.curPosX cannot be set twice.");
                  }
                  _loc8_++;
                  curPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.curPosY cannot be set twice.");
                  }
                  _loc26_++;
                  curPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.state cannot be set twice.");
                  }
                  _loc20_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.type cannot be set twice.");
                  }
                  _loc35_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  _loc33_ = new ArmyPawnInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc33_);
                  armyPawn.push(_loc33_);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.simpleHeroInfo cannot be set twice.");
                  }
                  _loc11_++;
                  simpleHeroInfo = new SimpleHeroInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,simpleHeroInfo);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.consortiaId cannot be set twice.");
                  }
                  _loc15_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.consortiaName cannot be set twice.");
                  }
                  _loc7_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.fightingCapacity cannot be set twice.");
                  }
                  _loc17_++;
                  fightingCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.gpOrder cannot be set twice.");
                  }
                  _loc41_++;
                  gpOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.grades cannot be set twice.");
                  }
                  _loc23_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.arm cannot be set twice.");
                  }
                  _loc16_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc43_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.cloth cannot be set twice.");
                  }
                  _loc43_++;
                  cloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 18:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.job cannot be set twice.");
                  }
                  _loc18_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.changeSharp cannot be set twice.");
                  }
                  _loc38_++;
                  changeSharp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.heroTempId cannot be set twice.");
                  }
                  _loc32_++;
                  heroTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if((_loc22_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userIds);
                  }
                  else
                  {
                     userIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 22:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.geste cannot be set twice.");
                  }
                  _loc24_++;
                  geste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.isVip cannot be set twice.");
                  }
                  _loc27_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 24:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.vipType cannot be set twice.");
                  }
                  _loc21_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.mountTempId cannot be set twice.");
                  }
                  _loc25_++;
                  mountTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.mountGrade cannot be set twice.");
                  }
                  _loc29_++;
                  mountGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.wing cannot be set twice.");
                  }
                  _loc19_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 28:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.serverName cannot be set twice.");
                  }
                  _loc12_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 29:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.hat cannot be set twice.");
                  }
                  _loc3_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 30:
                  if(_loc42_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.fashionArm cannot be set twice.");
                  }
                  _loc42_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 31:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.fashionCloth cannot be set twice.");
                  }
                  _loc30_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 32:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.hide cannot be set twice.");
                  }
                  _loc31_++;
                  hide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 33:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.appellid cannot be set twice.");
                  }
                  _loc28_++;
                  appellid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 34:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.fateSkills cannot be set twice.");
                  }
                  _loc5_++;
                  fateSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 35:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.petTempId cannot be set twice.");
                  }
                  _loc39_++;
                  petTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 36:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.petQuqlity cannot be set twice.");
                  }
                  _loc14_++;
                  petQuqlity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 37:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.petName cannot be set twice.");
                  }
                  _loc9_++;
                  petName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 38:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.childJob cannot be set twice.");
                  }
                  _loc37_++;
                  childJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 39:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.childName cannot be set twice.");
                  }
                  _loc36_++;
                  childName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 40:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.childSex cannot be set twice.");
                  }
                  _loc46_++;
                  childSex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 41:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.growthGrade cannot be set twice.");
                  }
                  _loc10_++;
                  growthGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 42:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.monsterId cannot be set twice.");
                  }
                  _loc13_++;
                  monsterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 43:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.avengerGrade cannot be set twice.");
                  }
                  _loc34_++;
                  avengerGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 44:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.growthGrade2 cannot be set twice.");
                  }
                  _loc45_++;
                  growthGrade2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc22_ & 7);
            }
         }
      }
   }
}

