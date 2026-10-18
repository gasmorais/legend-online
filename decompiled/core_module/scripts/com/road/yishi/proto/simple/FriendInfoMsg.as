package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FriendInfoMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var relation$field:int;
      
      private var sex$field:int;
      
      private var pic$field:int;
      
      private var grades$field:int;
      
      private var nick_name$field:String;
      
      private var online_state$field:int;
      
      private var relation_grade$field:int;
      
      private var relation_gp$field:int;
      
      private var consortia_id$field:int;
      
      private var consortia_name$field:String;
      
      private var result$field:Boolean;
      
      private var add_msg$field:String;
      
      private var fight_capacity$field:int;
      
      private var job$field:int;
      
      private var group_id$field:int;
      
      private var exp_added$field:int;
      
      private var sns_info$field:SNSInfoMsg;
      
      private var chat_state$field:int;
      
      private var vip_type$field:int;
      
      private var is_vip$field:Boolean;
      
      private var trans_grade$field:int;
      
      private var changeBranch$field:int;
      
      public function FriendInfoMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeRelation() : void
      {
         hasField$0 &= 4294967293;
         relation$field = new int();
      }
      
      public function get hasRelation() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set relation(param1:int) : void
      {
         hasField$0 |= 2;
         relation$field = param1;
      }
      
      public function get relation() : int
      {
         return relation$field;
      }
      
      public function removeSex() : void
      {
         hasField$0 &= 4294967291;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 4;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removePic() : void
      {
         hasField$0 &= 4294967287;
         pic$field = new int();
      }
      
      public function get hasPic() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pic(param1:int) : void
      {
         hasField$0 |= 8;
         pic$field = param1;
      }
      
      public function get pic() : int
      {
         return pic$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967279;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 16;
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
      
      public function removeOnlineState() : void
      {
         hasField$0 &= 4294967263;
         online_state$field = new int();
      }
      
      public function get hasOnlineState() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set onlineState(param1:int) : void
      {
         hasField$0 |= 32;
         online_state$field = param1;
      }
      
      public function get onlineState() : int
      {
         return online_state$field;
      }
      
      public function removeRelationGrade() : void
      {
         hasField$0 &= 4294967231;
         relation_grade$field = new int();
      }
      
      public function get hasRelationGrade() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set relationGrade(param1:int) : void
      {
         hasField$0 |= 64;
         relation_grade$field = param1;
      }
      
      public function get relationGrade() : int
      {
         return relation_grade$field;
      }
      
      public function removeRelationGp() : void
      {
         hasField$0 &= 4294967167;
         relation_gp$field = new int();
      }
      
      public function get hasRelationGp() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set relationGp(param1:int) : void
      {
         hasField$0 |= 128;
         relation_gp$field = param1;
      }
      
      public function get relationGp() : int
      {
         return relation_gp$field;
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
      
      public function removeResult() : void
      {
         hasField$0 &= 4294966783;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 512;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeAddMsg() : void
      {
         add_msg$field = null;
      }
      
      public function get hasAddMsg() : Boolean
      {
         return add_msg$field != null;
      }
      
      public function set addMsg(param1:String) : void
      {
         add_msg$field = param1;
      }
      
      public function get addMsg() : String
      {
         return add_msg$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294966271;
         fight_capacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 1024;
         fight_capacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fight_capacity$field;
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
      
      public function removeGroupId() : void
      {
         hasField$0 &= 4294963199;
         group_id$field = new int();
      }
      
      public function get hasGroupId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set groupId(param1:int) : void
      {
         hasField$0 |= 4096;
         group_id$field = param1;
      }
      
      public function get groupId() : int
      {
         return group_id$field;
      }
      
      public function removeExpAdded() : void
      {
         hasField$0 &= 4294959103;
         exp_added$field = new int();
      }
      
      public function get hasExpAdded() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set expAdded(param1:int) : void
      {
         hasField$0 |= 8192;
         exp_added$field = param1;
      }
      
      public function get expAdded() : int
      {
         return exp_added$field;
      }
      
      public function removeSnsInfo() : void
      {
         sns_info$field = null;
      }
      
      public function get hasSnsInfo() : Boolean
      {
         return sns_info$field != null;
      }
      
      public function set snsInfo(param1:SNSInfoMsg) : void
      {
         sns_info$field = param1;
      }
      
      public function get snsInfo() : SNSInfoMsg
      {
         return sns_info$field;
      }
      
      public function removeChatState() : void
      {
         hasField$0 &= 4294950911;
         chat_state$field = new int();
      }
      
      public function get hasChatState() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set chatState(param1:int) : void
      {
         hasField$0 |= 16384;
         chat_state$field = param1;
      }
      
      public function get chatState() : int
      {
         return chat_state$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294934527;
         vip_type$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 32768;
         vip_type$field = param1;
      }
      
      public function get vipType() : int
      {
         return vip_type$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294901759;
         is_vip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 65536;
         is_vip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return is_vip$field;
      }
      
      public function removeTransGrade() : void
      {
         hasField$0 &= 4294836223;
         trans_grade$field = new int();
      }
      
      public function get hasTransGrade() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set transGrade(param1:int) : void
      {
         hasField$0 |= 131072;
         trans_grade$field = param1;
      }
      
      public function get transGrade() : int
      {
         return trans_grade$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$0 &= 4294705151;
         changeBranch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$0 |= 262144;
         changeBranch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return changeBranch$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasRelation)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,relation$field);
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
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasOnlineState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,online_state$field);
         }
         if(hasRelationGrade)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,relation_grade$field);
         }
         if(hasRelationGp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,relation_gp$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasAddMsg)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,add_msg$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,fight_capacity$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasGroupId)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,group_id$field);
         }
         if(hasExpAdded)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,exp_added$field);
         }
         if(hasSnsInfo)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_MESSAGE(param1,sns_info$field);
         }
         if(hasChatState)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,chat_state$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,vip_type$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_BOOL(param1,is_vip$field);
         }
         if(hasTransGrade)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,trans_grade$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,changeBranch$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc15_:uint = 0;
         var _loc22_:uint = 0;
         var _loc7_:uint = 0;
         var _loc19_:uint = 0;
         var _loc18_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc24_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc23_:uint = 0;
         var _loc26_:uint = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         var _loc25_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc20_:uint = 0;
         var _loc8_:uint = 0;
         var _loc21_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.userId cannot be set twice.");
                  }
                  _loc15_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.relation cannot be set twice.");
                  }
                  _loc22_++;
                  relation = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.sex cannot be set twice.");
                  }
                  _loc7_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.pic cannot be set twice.");
                  }
                  _loc19_++;
                  pic = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.grades cannot be set twice.");
                  }
                  _loc18_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.onlineState cannot be set twice.");
                  }
                  _loc5_++;
                  onlineState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.relationGrade cannot be set twice.");
                  }
                  _loc10_++;
                  relationGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.relationGp cannot be set twice.");
                  }
                  _loc24_++;
                  relationGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.consortiaId cannot be set twice.");
                  }
                  _loc13_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.consortiaName cannot be set twice.");
                  }
                  _loc6_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.result cannot be set twice.");
                  }
                  _loc9_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.addMsg cannot be set twice.");
                  }
                  _loc23_++;
                  addMsg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.fightCapacity cannot be set twice.");
                  }
                  _loc26_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.job cannot be set twice.");
                  }
                  _loc14_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.groupId cannot be set twice.");
                  }
                  _loc11_++;
                  groupId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.expAdded cannot be set twice.");
                  }
                  _loc25_++;
                  expAdded = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.snsInfo cannot be set twice.");
                  }
                  _loc3_++;
                  snsInfo = new SNSInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,snsInfo);
                  break;
               case 19:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.chatState cannot be set twice.");
                  }
                  _loc12_++;
                  chatState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.vipType cannot be set twice.");
                  }
                  _loc16_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.isVip cannot be set twice.");
                  }
                  _loc20_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 22:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.transGrade cannot be set twice.");
                  }
                  _loc8_++;
                  transGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: FriendInfoMsg.changeBranch cannot be set twice.");
                  }
                  _loc21_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

