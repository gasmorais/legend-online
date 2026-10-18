package com.road.yishi.proto.chat
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChatChannelMsg extends Message implements IExternalizable
   {
      
      private var channel$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var encode_msg$field:String;
      
      private var other_id$field:int;
      
      private var name$field:String;
      
      [ArrayElementType("int")]
      public var team:Array = [];
      
      private var consortia_id$field:int;
      
      private var consortia_name$field:String;
      
      private var user_type$field:int;
      
      private var limit_grade$field:int;
      
      private var max_grade$field:int;
      
      private var is_centerTip$field:Boolean;
      
      private var is_bigTip$field:Boolean;
      
      private var vip_grade$field:int;
      
      [ArrayElementType("int")]
      public var expUserIds:Array = [];
      
      private var bigBugleType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.chat.ChatItemInfoMsg")]
      public var items:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.chat.ChatStarInfoMsg")]
      public var stars:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.chat.ChatPowCardInfoMsg")]
      public var powcards:Array = [];
      
      private var server_name$field:String;
      
      private var battle_id$field:String;
      
      private var is_important$field:Boolean;
      
      private var appellid$field:int;
      
      private var job$field:int;
      
      private var receive_name$field:String;
      
      private var grades$field:int;
      
      private var vipType$field:int;
      
      private var player_uuid$field:String;
      
      [ArrayElementType("String")]
      public var shareTimeSpace:Array = [];
      
      public function ChatChannelMsg()
      {
         super();
      }
      
      public function removeChannel() : void
      {
         hasField$0 &= 4294967294;
         channel$field = new int();
      }
      
      public function get hasChannel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set channel(param1:int) : void
      {
         hasField$0 |= 1;
         channel$field = param1;
      }
      
      public function get channel() : int
      {
         return channel$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         if(!hasType)
         {
            return 1;
         }
         return type$field;
      }
      
      public function removeEncodeMsg() : void
      {
         encode_msg$field = null;
      }
      
      public function get hasEncodeMsg() : Boolean
      {
         return encode_msg$field != null;
      }
      
      public function set encodeMsg(param1:String) : void
      {
         encode_msg$field = param1;
      }
      
      public function get encodeMsg() : String
      {
         return encode_msg$field;
      }
      
      public function removeOtherId() : void
      {
         hasField$0 &= 4294967291;
         other_id$field = new int();
      }
      
      public function get hasOtherId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set otherId(param1:int) : void
      {
         hasField$0 |= 4;
         other_id$field = param1;
      }
      
      public function get otherId() : int
      {
         return other_id$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967287;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 8;
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
      
      public function removeUserType() : void
      {
         hasField$0 &= 4294967279;
         user_type$field = new int();
      }
      
      public function get hasUserType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set userType(param1:int) : void
      {
         hasField$0 |= 16;
         user_type$field = param1;
      }
      
      public function get userType() : int
      {
         return user_type$field;
      }
      
      public function removeLimitGrade() : void
      {
         hasField$0 &= 4294967263;
         limit_grade$field = new int();
      }
      
      public function get hasLimitGrade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set limitGrade(param1:int) : void
      {
         hasField$0 |= 32;
         limit_grade$field = param1;
      }
      
      public function get limitGrade() : int
      {
         return limit_grade$field;
      }
      
      public function removeMaxGrade() : void
      {
         hasField$0 &= 4294967231;
         max_grade$field = new int();
      }
      
      public function get hasMaxGrade() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set maxGrade(param1:int) : void
      {
         hasField$0 |= 64;
         max_grade$field = param1;
      }
      
      public function get maxGrade() : int
      {
         return max_grade$field;
      }
      
      public function removeIsCenterTip() : void
      {
         hasField$0 &= 4294967167;
         is_centerTip$field = new Boolean();
      }
      
      public function get hasIsCenterTip() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isCenterTip(param1:Boolean) : void
      {
         hasField$0 |= 128;
         is_centerTip$field = param1;
      }
      
      public function get isCenterTip() : Boolean
      {
         return is_centerTip$field;
      }
      
      public function removeIsBigTip() : void
      {
         hasField$0 &= 4294967039;
         is_bigTip$field = new Boolean();
      }
      
      public function get hasIsBigTip() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isBigTip(param1:Boolean) : void
      {
         hasField$0 |= 256;
         is_bigTip$field = param1;
      }
      
      public function get isBigTip() : Boolean
      {
         return is_bigTip$field;
      }
      
      public function removeVipGrade() : void
      {
         hasField$0 &= 4294966783;
         vip_grade$field = new int();
      }
      
      public function get hasVipGrade() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set vipGrade(param1:int) : void
      {
         hasField$0 |= 512;
         vip_grade$field = param1;
      }
      
      public function get vipGrade() : int
      {
         return vip_grade$field;
      }
      
      public function removeBigBugleType() : void
      {
         hasField$0 &= 4294966271;
         bigBugleType$field = new int();
      }
      
      public function get hasBigBugleType() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set bigBugleType(param1:int) : void
      {
         hasField$0 |= 1024;
         bigBugleType$field = param1;
      }
      
      public function get bigBugleType() : int
      {
         return bigBugleType$field;
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
      
      public function removeBattleId() : void
      {
         battle_id$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battle_id$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battle_id$field = param1;
      }
      
      public function get battleId() : String
      {
         return battle_id$field;
      }
      
      public function removeIsImportant() : void
      {
         hasField$0 &= 4294965247;
         is_important$field = new Boolean();
      }
      
      public function get hasIsImportant() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isImportant(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         is_important$field = param1;
      }
      
      public function get isImportant() : Boolean
      {
         if(!hasIsImportant)
         {
            return false;
         }
         return is_important$field;
      }
      
      public function removeAppellid() : void
      {
         hasField$0 &= 4294963199;
         appellid$field = new int();
      }
      
      public function get hasAppellid() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set appellid(param1:int) : void
      {
         hasField$0 |= 4096;
         appellid$field = param1;
      }
      
      public function get appellid() : int
      {
         return appellid$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294959103;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 8192;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeReceiveName() : void
      {
         receive_name$field = null;
      }
      
      public function get hasReceiveName() : Boolean
      {
         return receive_name$field != null;
      }
      
      public function set receiveName(param1:String) : void
      {
         receive_name$field = param1;
      }
      
      public function get receiveName() : String
      {
         return receive_name$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294950911;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 16384;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294934527;
         vipType$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 32768;
         vipType$field = param1;
      }
      
      public function get vipType() : int
      {
         return vipType$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc5_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc4_:* = 0;
         if(hasChannel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,channel$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasEncodeMsg)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,encode_msg$field);
         }
         if(hasOtherId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,other_id$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         _loc5_ = 0;
         while(_loc5_ < team.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,team[_loc5_]);
            _loc5_++;
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasUserType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,user_type$field);
         }
         if(hasLimitGrade)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,limit_grade$field);
         }
         if(hasMaxGrade)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,max_grade$field);
         }
         if(hasIsCenterTip)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,is_centerTip$field);
         }
         if(hasIsBigTip)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,is_bigTip$field);
         }
         if(hasVipGrade)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,vip_grade$field);
         }
         _loc2_ = 0;
         while(_loc2_ < expUserIds.length)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,expUserIds[_loc2_]);
            _loc2_++;
         }
         if(hasBigBugleType)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,bigBugleType$field);
         }
         _loc3_ = 0;
         while(_loc3_ < items.length)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc3_]);
            _loc3_++;
         }
         _loc6_ = 0;
         while(_loc6_ < stars.length)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_MESSAGE(param1,stars[_loc6_]);
            _loc6_++;
         }
         _loc7_ = 0;
         while(_loc7_ < powcards.length)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,powcards[_loc7_]);
            _loc7_++;
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_STRING(param1,battle_id$field);
         }
         if(hasIsImportant)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_BOOL(param1,is_important$field);
         }
         if(hasAppellid)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,appellid$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasReceiveName)
         {
            WriteUtils.writeTag(param1,2,25);
            WriteUtils.write$TYPE_STRING(param1,receive_name$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,vipType$field);
         }
         if(hasPlayerUuid)
         {
            WriteUtils.writeTag(param1,2,28);
            WriteUtils.write$TYPE_STRING(param1,player_uuid$field);
         }
         _loc4_ = 0;
         while(_loc4_ < shareTimeSpace.length)
         {
            WriteUtils.writeTag(param1,2,29);
            WriteUtils.write$TYPE_STRING(param1,shareTimeSpace[_loc4_]);
            _loc4_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc15_:ChatItemInfoMsg = null;
         var _loc28_:ChatStarInfoMsg = null;
         var _loc25_:ChatPowCardInfoMsg = null;
         var _loc20_:uint = 0;
         var _loc19_:uint = 0;
         var _loc5_:uint = 0;
         var _loc29_:uint = 0;
         var _loc21_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc26_:uint = 0;
         var _loc7_:uint = 0;
         var _loc23_:uint = 0;
         var _loc18_:uint = 0;
         var _loc16_:uint = 0;
         var _loc3_:uint = 0;
         var _loc24_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc27_:uint = 0;
         var _loc17_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc9_:uint = 0;
         var _loc22_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.channel cannot be set twice.");
                  }
                  _loc20_++;
                  channel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.type cannot be set twice.");
                  }
                  _loc19_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.encodeMsg cannot be set twice.");
                  }
                  _loc5_++;
                  encodeMsg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.otherId cannot be set twice.");
                  }
                  _loc29_++;
                  otherId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.name cannot be set twice.");
                  }
                  _loc21_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if((_loc12_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,team);
                  }
                  else
                  {
                     team.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.consortiaId cannot be set twice.");
                  }
                  _loc10_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.consortiaName cannot be set twice.");
                  }
                  _loc4_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.userType cannot be set twice.");
                  }
                  _loc26_++;
                  userType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.limitGrade cannot be set twice.");
                  }
                  _loc7_++;
                  limitGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.maxGrade cannot be set twice.");
                  }
                  _loc23_++;
                  maxGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.isCenterTip cannot be set twice.");
                  }
                  _loc18_++;
                  isCenterTip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.isBigTip cannot be set twice.");
                  }
                  _loc16_++;
                  isBigTip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 14:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.vipGrade cannot be set twice.");
                  }
                  _loc3_++;
                  vipGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if((_loc12_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,expUserIds);
                  }
                  else
                  {
                     expUserIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 16:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.bigBugleType cannot be set twice.");
                  }
                  _loc24_++;
                  bigBugleType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  _loc15_ = new ChatItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc15_);
                  items.push(_loc15_);
                  break;
               case 18:
                  _loc28_ = new ChatStarInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc28_);
                  stars.push(_loc28_);
                  break;
               case 19:
                  _loc25_ = new ChatPowCardInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc25_);
                  powcards.push(_loc25_);
                  break;
               case 20:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.serverName cannot be set twice.");
                  }
                  _loc6_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 21:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.battleId cannot be set twice.");
                  }
                  _loc8_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 22:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.isImportant cannot be set twice.");
                  }
                  _loc27_++;
                  isImportant = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 23:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.appellid cannot be set twice.");
                  }
                  _loc17_++;
                  appellid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.job cannot be set twice.");
                  }
                  _loc11_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.receiveName cannot be set twice.");
                  }
                  _loc13_++;
                  receiveName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 26:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.grades cannot be set twice.");
                  }
                  _loc14_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.vipType cannot be set twice.");
                  }
                  _loc9_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: ChatChannelMsg.playerUuid cannot be set twice.");
                  }
                  _loc22_++;
                  playerUuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 29:
                  shareTimeSpace.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

