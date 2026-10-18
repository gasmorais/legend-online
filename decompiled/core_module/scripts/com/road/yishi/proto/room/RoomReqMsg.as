package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RoomReqMsg extends Message implements IExternalizable
   {
      
      private var room_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var dungeon_id$field:int;
      
      private var campaign_id$field:int;
      
      private var army_id$field:int;
      
      private var user_id$field:int;
      
      private var state$field:int;
      
      private var index$field:int;
      
      private var open$field:Boolean;
      
      private var room_type$field:int;
      
      private var name_key$field:String;
      
      private var password$field:String;
      
      private var is_invite$field:Boolean;
      
      private var capacity$field:int;
      
      private var is_get$field:Boolean;
      
      private var serverName$field:String;
      
      public function RoomReqMsg()
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
      
      public function removeDungeonId() : void
      {
         hasField$0 &= 4294967293;
         dungeon_id$field = new int();
      }
      
      public function get hasDungeonId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set dungeonId(param1:int) : void
      {
         hasField$0 |= 2;
         dungeon_id$field = param1;
      }
      
      public function get dungeonId() : int
      {
         return dungeon_id$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967291;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 4;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967287;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 8;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967279;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 16;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
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
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967231;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 64;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeOpen() : void
      {
         hasField$0 &= 4294967167;
         open$field = new Boolean();
      }
      
      public function get hasOpen() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set open(param1:Boolean) : void
      {
         hasField$0 |= 128;
         open$field = param1;
      }
      
      public function get open() : Boolean
      {
         return open$field;
      }
      
      public function removeRoomType() : void
      {
         hasField$0 &= 4294967039;
         room_type$field = new int();
      }
      
      public function get hasRoomType() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set roomType(param1:int) : void
      {
         hasField$0 |= 256;
         room_type$field = param1;
      }
      
      public function get roomType() : int
      {
         return room_type$field;
      }
      
      public function removeNameKey() : void
      {
         name_key$field = null;
      }
      
      public function get hasNameKey() : Boolean
      {
         return name_key$field != null;
      }
      
      public function set nameKey(param1:String) : void
      {
         name_key$field = param1;
      }
      
      public function get nameKey() : String
      {
         return name_key$field;
      }
      
      public function removePassword() : void
      {
         password$field = null;
      }
      
      public function get hasPassword() : Boolean
      {
         return password$field != null;
      }
      
      public function set password(param1:String) : void
      {
         password$field = param1;
      }
      
      public function get password() : String
      {
         return password$field;
      }
      
      public function removeIsInvite() : void
      {
         hasField$0 &= 4294966783;
         is_invite$field = new Boolean();
      }
      
      public function get hasIsInvite() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isInvite(param1:Boolean) : void
      {
         hasField$0 |= 512;
         is_invite$field = param1;
      }
      
      public function get isInvite() : Boolean
      {
         return is_invite$field;
      }
      
      public function removeCapacity() : void
      {
         hasField$0 &= 4294966271;
         capacity$field = new int();
      }
      
      public function get hasCapacity() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set capacity(param1:int) : void
      {
         hasField$0 |= 1024;
         capacity$field = param1;
      }
      
      public function get capacity() : int
      {
         return capacity$field;
      }
      
      public function removeIsGet() : void
      {
         hasField$0 &= 4294965247;
         is_get$field = new Boolean();
      }
      
      public function get hasIsGet() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isGet(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         is_get$field = param1;
      }
      
      public function get isGet() : Boolean
      {
         return is_get$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRoomId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,room_id$field);
         }
         if(hasDungeonId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,dungeon_id$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasOpen)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,open$field);
         }
         if(hasRoomType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,room_type$field);
         }
         if(hasNameKey)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,name_key$field);
         }
         if(hasPassword)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,password$field);
         }
         if(hasIsInvite)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,is_invite$field);
         }
         if(hasCapacity)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,capacity$field);
         }
         if(hasIsGet)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,is_get$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc14_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.roomId cannot be set twice.");
                  }
                  _loc14_++;
                  roomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.dungeonId cannot be set twice.");
                  }
                  _loc5_++;
                  dungeonId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.campaignId cannot be set twice.");
                  }
                  _loc6_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.armyId cannot be set twice.");
                  }
                  _loc9_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.userId cannot be set twice.");
                  }
                  _loc15_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.state cannot be set twice.");
                  }
                  _loc16_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.index cannot be set twice.");
                  }
                  _loc8_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.open cannot be set twice.");
                  }
                  _loc11_++;
                  open = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.roomType cannot be set twice.");
                  }
                  _loc10_++;
                  roomType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.nameKey cannot be set twice.");
                  }
                  _loc18_++;
                  nameKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.password cannot be set twice.");
                  }
                  _loc12_++;
                  password = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.isInvite cannot be set twice.");
                  }
                  _loc3_++;
                  isInvite = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.capacity cannot be set twice.");
                  }
                  _loc13_++;
                  capacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.isGet cannot be set twice.");
                  }
                  _loc4_++;
                  isGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 14:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RoomReqMsg.serverName cannot be set twice.");
                  }
                  _loc7_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

