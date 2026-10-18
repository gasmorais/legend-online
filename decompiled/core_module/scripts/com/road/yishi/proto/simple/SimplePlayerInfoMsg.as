package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimplePlayerInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var isExist$field:int;
      
      private var sexs$field:int;
      
      private var pics$field:int;
      
      private var camp$field:int;
      
      private var state$field:int;
      
      private var consortiaID$field:int;
      
      private var strategy$field:Int64;
      
      private var consortiaName$field:String;
      
      private var consortiaOffer$field:int;
      
      private var claimId$field:int;
      
      private var claimName$field:String;
      
      private var grades$field:int;
      
      private var gp$field:Int64;
      
      private var repute$field:int;
      
      private var logOutTime$field:String;
      
      private var dutyId$field:int;
      
      private var parameter1$field:int;
      
      private var gpOrder$field:int;
      
      private var fightingCapacity$field:int;
      
      private var matchWin$field:int;
      
      private var matchFailed$field:int;
      
      private var right$field:int;
      
      private var challenge_rank$field:int;
      
      private var job$field:int;
      
      private var consortiaTotalOffer$field:int;
      
      private var storeGrade$field:int;
      
      private var storeGp$field:int;
      
      private var is_teamPlayer$field:Boolean;
      
      private var role$field:int;
      
      private var is_vip$field:Boolean;
      
      private var vip_type$field:int;
      
      private var is_inwar$field:int;
      
      private var head_id$field:int;
      
      private var seniorStoreGrade$field:int;
      
      private var cross_guildTeamId$field:int;
      
      private var trans_grade$field:int;
      
      private var is_hide$field:Boolean;
      
      private var hasField$1:uint = 0;
      
      private var cur_fightPetTempId$field:int;
      
      private var is_back_player$field:Boolean;
      
      private var changeBranch$field:int;
      
      private var uuid$field:String;
      
      public function SimplePlayerInfoMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967293;
         isExist$field = new int();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isExist(param1:int) : void
      {
         hasField$0 |= 2;
         isExist$field = param1;
      }
      
      public function get isExist() : int
      {
         return isExist$field;
      }
      
      public function removeSexs() : void
      {
         hasField$0 &= 4294967291;
         sexs$field = new int();
      }
      
      public function get hasSexs() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sexs(param1:int) : void
      {
         hasField$0 |= 4;
         sexs$field = param1;
      }
      
      public function get sexs() : int
      {
         return sexs$field;
      }
      
      public function removePics() : void
      {
         hasField$0 &= 4294967287;
         pics$field = new int();
      }
      
      public function get hasPics() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pics(param1:int) : void
      {
         hasField$0 |= 8;
         pics$field = param1;
      }
      
      public function get pics() : int
      {
         return pics$field;
      }
      
      public function removeCamp() : void
      {
         hasField$0 &= 4294967279;
         camp$field = new int();
      }
      
      public function get hasCamp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set camp(param1:int) : void
      {
         hasField$0 |= 16;
         camp$field = param1;
      }
      
      public function get camp() : int
      {
         return camp$field;
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
      
      public function removeConsortiaID() : void
      {
         hasField$0 &= 4294967231;
         consortiaID$field = new int();
      }
      
      public function get hasConsortiaID() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set consortiaID(param1:int) : void
      {
         hasField$0 |= 64;
         consortiaID$field = param1;
      }
      
      public function get consortiaID() : int
      {
         return consortiaID$field;
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
      
      public function removeConsortiaName() : void
      {
         consortiaName$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortiaName$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortiaName$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortiaName$field;
      }
      
      public function removeConsortiaOffer() : void
      {
         hasField$0 &= 4294967167;
         consortiaOffer$field = new int();
      }
      
      public function get hasConsortiaOffer() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set consortiaOffer(param1:int) : void
      {
         hasField$0 |= 128;
         consortiaOffer$field = param1;
      }
      
      public function get consortiaOffer() : int
      {
         return consortiaOffer$field;
      }
      
      public function removeClaimId() : void
      {
         hasField$0 &= 4294967039;
         claimId$field = new int();
      }
      
      public function get hasClaimId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set claimId(param1:int) : void
      {
         hasField$0 |= 256;
         claimId$field = param1;
      }
      
      public function get claimId() : int
      {
         return claimId$field;
      }
      
      public function removeClaimName() : void
      {
         claimName$field = null;
      }
      
      public function get hasClaimName() : Boolean
      {
         return claimName$field != null;
      }
      
      public function set claimName(param1:String) : void
      {
         claimName$field = param1;
      }
      
      public function get claimName() : String
      {
         return claimName$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294966783;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 512;
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
         hasField$0 &= 4294966271;
         repute$field = new int();
      }
      
      public function get hasRepute() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set repute(param1:int) : void
      {
         hasField$0 |= 1024;
         repute$field = param1;
      }
      
      public function get repute() : int
      {
         return repute$field;
      }
      
      public function removeLogOutTime() : void
      {
         logOutTime$field = null;
      }
      
      public function get hasLogOutTime() : Boolean
      {
         return logOutTime$field != null;
      }
      
      public function set logOutTime(param1:String) : void
      {
         logOutTime$field = param1;
      }
      
      public function get logOutTime() : String
      {
         return logOutTime$field;
      }
      
      public function removeDutyId() : void
      {
         hasField$0 &= 4294965247;
         dutyId$field = new int();
      }
      
      public function get hasDutyId() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set dutyId(param1:int) : void
      {
         hasField$0 |= 2048;
         dutyId$field = param1;
      }
      
      public function get dutyId() : int
      {
         return dutyId$field;
      }
      
      public function removeParameter1() : void
      {
         hasField$0 &= 4294963199;
         parameter1$field = new int();
      }
      
      public function get hasParameter1() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set parameter1(param1:int) : void
      {
         hasField$0 |= 4096;
         parameter1$field = param1;
      }
      
      public function get parameter1() : int
      {
         return parameter1$field;
      }
      
      public function removeGpOrder() : void
      {
         hasField$0 &= 4294959103;
         gpOrder$field = new int();
      }
      
      public function get hasGpOrder() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set gpOrder(param1:int) : void
      {
         hasField$0 |= 8192;
         gpOrder$field = param1;
      }
      
      public function get gpOrder() : int
      {
         return gpOrder$field;
      }
      
      public function removeFightingCapacity() : void
      {
         hasField$0 &= 4294950911;
         fightingCapacity$field = new int();
      }
      
      public function get hasFightingCapacity() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set fightingCapacity(param1:int) : void
      {
         hasField$0 |= 16384;
         fightingCapacity$field = param1;
      }
      
      public function get fightingCapacity() : int
      {
         return fightingCapacity$field;
      }
      
      public function removeMatchWin() : void
      {
         hasField$0 &= 4294934527;
         matchWin$field = new int();
      }
      
      public function get hasMatchWin() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set matchWin(param1:int) : void
      {
         hasField$0 |= 32768;
         matchWin$field = param1;
      }
      
      public function get matchWin() : int
      {
         return matchWin$field;
      }
      
      public function removeMatchFailed() : void
      {
         hasField$0 &= 4294901759;
         matchFailed$field = new int();
      }
      
      public function get hasMatchFailed() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set matchFailed(param1:int) : void
      {
         hasField$0 |= 65536;
         matchFailed$field = param1;
      }
      
      public function get matchFailed() : int
      {
         return matchFailed$field;
      }
      
      public function removeRight() : void
      {
         hasField$0 &= 4294836223;
         right$field = new int();
      }
      
      public function get hasRight() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set right(param1:int) : void
      {
         hasField$0 |= 131072;
         right$field = param1;
      }
      
      public function get right() : int
      {
         return right$field;
      }
      
      public function removeChallengeRank() : void
      {
         hasField$0 &= 4294705151;
         challenge_rank$field = new int();
      }
      
      public function get hasChallengeRank() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set challengeRank(param1:int) : void
      {
         hasField$0 |= 262144;
         challenge_rank$field = param1;
      }
      
      public function get challengeRank() : int
      {
         return challenge_rank$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294443007;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 524288;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeConsortiaTotalOffer() : void
      {
         hasField$0 &= 4293918719;
         consortiaTotalOffer$field = new int();
      }
      
      public function get hasConsortiaTotalOffer() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set consortiaTotalOffer(param1:int) : void
      {
         hasField$0 |= 1048576;
         consortiaTotalOffer$field = param1;
      }
      
      public function get consortiaTotalOffer() : int
      {
         return consortiaTotalOffer$field;
      }
      
      public function removeStoreGrade() : void
      {
         hasField$0 &= 4292870143;
         storeGrade$field = new int();
      }
      
      public function get hasStoreGrade() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set storeGrade(param1:int) : void
      {
         hasField$0 |= 2097152;
         storeGrade$field = param1;
      }
      
      public function get storeGrade() : int
      {
         return storeGrade$field;
      }
      
      public function removeStoreGp() : void
      {
         hasField$0 &= 4290772991;
         storeGp$field = new int();
      }
      
      public function get hasStoreGp() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set storeGp(param1:int) : void
      {
         hasField$0 |= 4194304;
         storeGp$field = param1;
      }
      
      public function get storeGp() : int
      {
         return storeGp$field;
      }
      
      public function removeIsTeamPlayer() : void
      {
         hasField$0 &= 4286578687;
         is_teamPlayer$field = new Boolean();
      }
      
      public function get hasIsTeamPlayer() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set isTeamPlayer(param1:Boolean) : void
      {
         hasField$0 |= 8388608;
         is_teamPlayer$field = param1;
      }
      
      public function get isTeamPlayer() : Boolean
      {
         return is_teamPlayer$field;
      }
      
      public function removeRole() : void
      {
         hasField$0 &= 4278190079;
         role$field = new int();
      }
      
      public function get hasRole() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set role(param1:int) : void
      {
         hasField$0 |= 16777216;
         role$field = param1;
      }
      
      public function get role() : int
      {
         return role$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4261412863;
         is_vip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 33554432;
         is_vip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return is_vip$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4227858431;
         vip_type$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 67108864;
         vip_type$field = param1;
      }
      
      public function get vipType() : int
      {
         return vip_type$field;
      }
      
      public function removeIsInwar() : void
      {
         hasField$0 &= 4160749567;
         is_inwar$field = new int();
      }
      
      public function get hasIsInwar() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set isInwar(param1:int) : void
      {
         hasField$0 |= 134217728;
         is_inwar$field = param1;
      }
      
      public function get isInwar() : int
      {
         return is_inwar$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4026531839;
         head_id$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 268435456;
         head_id$field = param1;
      }
      
      public function get headId() : int
      {
         return head_id$field;
      }
      
      public function removeSeniorStoreGrade() : void
      {
         hasField$0 &= 3758096383;
         seniorStoreGrade$field = new int();
      }
      
      public function get hasSeniorStoreGrade() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set seniorStoreGrade(param1:int) : void
      {
         hasField$0 |= 536870912;
         seniorStoreGrade$field = param1;
      }
      
      public function get seniorStoreGrade() : int
      {
         return seniorStoreGrade$field;
      }
      
      public function removeCrossGuildTeamId() : void
      {
         hasField$0 &= 3221225471;
         cross_guildTeamId$field = new int();
      }
      
      public function get hasCrossGuildTeamId() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set crossGuildTeamId(param1:int) : void
      {
         hasField$0 |= 1073741824;
         cross_guildTeamId$field = param1;
      }
      
      public function get crossGuildTeamId() : int
      {
         return cross_guildTeamId$field;
      }
      
      public function removeTransGrade() : void
      {
         hasField$0 &= 2147483647;
         trans_grade$field = new int();
      }
      
      public function get hasTransGrade() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set transGrade(param1:int) : void
      {
         hasField$0 |= 2147483648;
         trans_grade$field = param1;
      }
      
      public function get transGrade() : int
      {
         return trans_grade$field;
      }
      
      public function removeIsHide() : void
      {
         hasField$1 &= 4294967294;
         is_hide$field = new Boolean();
      }
      
      public function get hasIsHide() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set isHide(param1:Boolean) : void
      {
         hasField$1 |= 1;
         is_hide$field = param1;
      }
      
      public function get isHide() : Boolean
      {
         return is_hide$field;
      }
      
      public function removeCurFightPetTempId() : void
      {
         hasField$1 &= 4294967293;
         cur_fightPetTempId$field = new int();
      }
      
      public function get hasCurFightPetTempId() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set curFightPetTempId(param1:int) : void
      {
         hasField$1 |= 2;
         cur_fightPetTempId$field = param1;
      }
      
      public function get curFightPetTempId() : int
      {
         return cur_fightPetTempId$field;
      }
      
      public function removeIsBackPlayer() : void
      {
         hasField$1 &= 4294967291;
         is_back_player$field = new Boolean();
      }
      
      public function get hasIsBackPlayer() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set isBackPlayer(param1:Boolean) : void
      {
         hasField$1 |= 4;
         is_back_player$field = param1;
      }
      
      public function get isBackPlayer() : Boolean
      {
         return is_back_player$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$1 &= 4294967287;
         changeBranch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$1 |= 8;
         changeBranch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return changeBranch$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,isExist$field);
         }
         if(hasSexs)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,sexs$field);
         }
         if(hasPics)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,pics$field);
         }
         if(hasCamp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,camp$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasConsortiaID)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,consortiaID$field);
         }
         if(hasStrategy)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT64(param1,strategy$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,consortiaName$field);
         }
         if(hasConsortiaOffer)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,consortiaOffer$field);
         }
         if(hasClaimId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,claimId$field);
         }
         if(hasClaimName)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,claimName$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT64(param1,gp$field);
         }
         if(hasRepute)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,repute$field);
         }
         if(hasLogOutTime)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,logOutTime$field);
         }
         if(hasDutyId)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,dutyId$field);
         }
         if(hasParameter1)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,parameter1$field);
         }
         if(hasGpOrder)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,gpOrder$field);
         }
         if(hasFightingCapacity)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,fightingCapacity$field);
         }
         if(hasMatchWin)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,matchWin$field);
         }
         if(hasMatchFailed)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,matchFailed$field);
         }
         if(hasRight)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,right$field);
         }
         if(hasChallengeRank)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,challenge_rank$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasConsortiaTotalOffer)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,consortiaTotalOffer$field);
         }
         if(hasStoreGrade)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,storeGrade$field);
         }
         if(hasStoreGp)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,storeGp$field);
         }
         if(hasIsTeamPlayer)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_BOOL(param1,is_teamPlayer$field);
         }
         if(hasRole)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,role$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_BOOL(param1,is_vip$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_INT32(param1,vip_type$field);
         }
         if(hasIsInwar)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_INT32(param1,is_inwar$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,head_id$field);
         }
         if(hasSeniorStoreGrade)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,seniorStoreGrade$field);
         }
         if(hasCrossGuildTeamId)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_INT32(param1,cross_guildTeamId$field);
         }
         if(hasTransGrade)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_INT32(param1,trans_grade$field);
         }
         if(hasIsHide)
         {
            WriteUtils.writeTag(param1,0,39);
            WriteUtils.write$TYPE_BOOL(param1,is_hide$field);
         }
         if(hasCurFightPetTempId)
         {
            WriteUtils.writeTag(param1,0,40);
            WriteUtils.write$TYPE_INT32(param1,cur_fightPetTempId$field);
         }
         if(hasIsBackPlayer)
         {
            WriteUtils.writeTag(param1,0,41);
            WriteUtils.write$TYPE_BOOL(param1,is_back_player$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,42);
            WriteUtils.write$TYPE_INT32(param1,changeBranch$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,43);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc32_:uint = 0;
         var _loc9_:uint = 0;
         var _loc28_:uint = 0;
         var _loc39_:uint = 0;
         var _loc21_:uint = 0;
         var _loc31_:uint = 0;
         var _loc17_:uint = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc35_:uint = 0;
         var _loc24_:uint = 0;
         var _loc40_:uint = 0;
         var _loc23_:uint = 0;
         var _loc45_:uint = 0;
         var _loc29_:uint = 0;
         var _loc22_:uint = 0;
         var _loc43_:uint = 0;
         var _loc46_:uint = 0;
         var _loc41_:uint = 0;
         var _loc15_:uint = 0;
         var _loc44_:uint = 0;
         var _loc10_:uint = 0;
         var _loc30_:uint = 0;
         var _loc42_:uint = 0;
         var _loc16_:uint = 0;
         var _loc13_:uint = 0;
         var _loc20_:uint = 0;
         var _loc36_:uint = 0;
         var _loc37_:uint = 0;
         var _loc33_:uint = 0;
         var _loc26_:uint = 0;
         var _loc18_:uint = 0;
         var _loc25_:uint = 0;
         var _loc34_:uint = 0;
         var _loc6_:uint = 0;
         var _loc38_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc27_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.userId cannot be set twice.");
                  }
                  _loc32_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.nickName cannot be set twice.");
                  }
                  _loc9_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.isExist cannot be set twice.");
                  }
                  _loc28_++;
                  isExist = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.sexs cannot be set twice.");
                  }
                  _loc39_++;
                  sexs = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.pics cannot be set twice.");
                  }
                  _loc21_++;
                  pics = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.camp cannot be set twice.");
                  }
                  _loc31_++;
                  camp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.state cannot be set twice.");
                  }
                  _loc17_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.consortiaID cannot be set twice.");
                  }
                  _loc14_++;
                  consortiaID = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.strategy cannot be set twice.");
                  }
                  _loc11_++;
                  strategy = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.consortiaName cannot be set twice.");
                  }
                  _loc3_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.consortiaOffer cannot be set twice.");
                  }
                  _loc35_++;
                  consortiaOffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.claimId cannot be set twice.");
                  }
                  _loc24_++;
                  claimId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.claimName cannot be set twice.");
                  }
                  _loc40_++;
                  claimName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.grades cannot be set twice.");
                  }
                  _loc23_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc45_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.gp cannot be set twice.");
                  }
                  _loc45_++;
                  gp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 16:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.repute cannot be set twice.");
                  }
                  _loc29_++;
                  repute = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.logOutTime cannot be set twice.");
                  }
                  _loc22_++;
                  logOutTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 18:
                  if(_loc43_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.dutyId cannot be set twice.");
                  }
                  _loc43_++;
                  dutyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc46_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.parameter1 cannot be set twice.");
                  }
                  _loc46_++;
                  parameter1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.gpOrder cannot be set twice.");
                  }
                  _loc41_++;
                  gpOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.fightingCapacity cannot be set twice.");
                  }
                  _loc15_++;
                  fightingCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc44_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.matchWin cannot be set twice.");
                  }
                  _loc44_++;
                  matchWin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.matchFailed cannot be set twice.");
                  }
                  _loc10_++;
                  matchFailed = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.right cannot be set twice.");
                  }
                  _loc30_++;
                  right = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc42_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.challengeRank cannot be set twice.");
                  }
                  _loc42_++;
                  challengeRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.job cannot be set twice.");
                  }
                  _loc16_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.consortiaTotalOffer cannot be set twice.");
                  }
                  _loc13_++;
                  consortiaTotalOffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.storeGrade cannot be set twice.");
                  }
                  _loc20_++;
                  storeGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.storeGp cannot be set twice.");
                  }
                  _loc36_++;
                  storeGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.isTeamPlayer cannot be set twice.");
                  }
                  _loc37_++;
                  isTeamPlayer = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 31:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.role cannot be set twice.");
                  }
                  _loc33_++;
                  role = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 32:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.isVip cannot be set twice.");
                  }
                  _loc26_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 33:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.vipType cannot be set twice.");
                  }
                  _loc18_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 34:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.isInwar cannot be set twice.");
                  }
                  _loc25_++;
                  isInwar = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 35:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.headId cannot be set twice.");
                  }
                  _loc34_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 36:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.seniorStoreGrade cannot be set twice.");
                  }
                  _loc6_++;
                  seniorStoreGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 37:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.crossGuildTeamId cannot be set twice.");
                  }
                  _loc38_++;
                  crossGuildTeamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 38:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.transGrade cannot be set twice.");
                  }
                  _loc4_++;
                  transGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 39:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.isHide cannot be set twice.");
                  }
                  _loc8_++;
                  isHide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 40:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.curFightPetTempId cannot be set twice.");
                  }
                  _loc5_++;
                  curFightPetTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 41:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.isBackPlayer cannot be set twice.");
                  }
                  _loc12_++;
                  isBackPlayer = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 42:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.changeBranch cannot be set twice.");
                  }
                  _loc27_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 43:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.uuid cannot be set twice.");
                  }
                  _loc7_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

