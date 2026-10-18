package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RoomInviteMsg extends Message implements IExternalizable
   {
      
      private var room_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var player_id$field:int;
      
      private var nick_name$field:String;
      
      private var name$field:String;
      
      private var sign_str$field:String;
      
      private var room_type$field:int;
      
      private var temp_id$field:int;
      
      private var position$field:int;
      
      private var userKey$field:String;
      
      private var boss_count$field:int;
      
      private var isCross$field:Boolean;
      
      public function RoomInviteMsg()
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
      
      public function removeSignStr() : void
      {
         sign_str$field = null;
      }
      
      public function get hasSignStr() : Boolean
      {
         return sign_str$field != null;
      }
      
      public function set signStr(param1:String) : void
      {
         sign_str$field = param1;
      }
      
      public function get signStr() : String
      {
         return sign_str$field;
      }
      
      public function removeRoomType() : void
      {
         hasField$0 &= 4294967291;
         room_type$field = new int();
      }
      
      public function get hasRoomType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set roomType(param1:int) : void
      {
         hasField$0 |= 4;
         room_type$field = param1;
      }
      
      public function get roomType() : int
      {
         return room_type$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967287;
         temp_id$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 8;
         temp_id$field = param1;
      }
      
      public function get tempId() : int
      {
         return temp_id$field;
      }
      
      public function removePosition() : void
      {
         hasField$0 &= 4294967279;
         position$field = new int();
      }
      
      public function get hasPosition() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set position(param1:int) : void
      {
         hasField$0 |= 16;
         position$field = param1;
      }
      
      public function get position() : int
      {
         return position$field;
      }
      
      public function removeUserKey() : void
      {
         userKey$field = null;
      }
      
      public function get hasUserKey() : Boolean
      {
         return userKey$field != null;
      }
      
      public function set userKey(param1:String) : void
      {
         userKey$field = param1;
      }
      
      public function get userKey() : String
      {
         return userKey$field;
      }
      
      public function removeBossCount() : void
      {
         hasField$0 &= 4294967263;
         boss_count$field = new int();
      }
      
      public function get hasBossCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set bossCount(param1:int) : void
      {
         hasField$0 |= 32;
         boss_count$field = param1;
      }
      
      public function get bossCount() : int
      {
         return boss_count$field;
      }
      
      public function removeIsCross() : void
      {
         hasField$0 &= 4294967231;
         isCross$field = new Boolean();
      }
      
      public function get hasIsCross() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isCross(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isCross$field = param1;
      }
      
      public function get isCross() : Boolean
      {
         return isCross$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRoomId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,room_id$field);
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
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasSignStr)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,sign_str$field);
         }
         if(hasRoomType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,room_type$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,temp_id$field);
         }
         if(hasPosition)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,position$field);
         }
         if(hasUserKey)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,userKey$field);
         }
         if(hasBossCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,boss_count$field);
         }
         if(hasIsCross)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,isCross$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.roomId cannot be set twice.");
                  }
                  _loc12_++;
                  roomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.playerId cannot be set twice.");
                  }
                  _loc4_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.name cannot be set twice.");
                  }
                  _loc8_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.signStr cannot be set twice.");
                  }
                  _loc13_++;
                  signStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.roomType cannot be set twice.");
                  }
                  _loc10_++;
                  roomType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.tempId cannot be set twice.");
                  }
                  _loc6_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.position cannot be set twice.");
                  }
                  _loc5_++;
                  position = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.userKey cannot be set twice.");
                  }
                  _loc11_++;
                  userKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.bossCount cannot be set twice.");
                  }
                  _loc9_++;
                  bossCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RoomInviteMsg.isCross cannot be set twice.");
                  }
                  _loc7_++;
                  isCross = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

