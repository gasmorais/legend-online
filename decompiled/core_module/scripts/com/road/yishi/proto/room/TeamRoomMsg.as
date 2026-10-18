package com.road.yishi.proto.room
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TeamRoomMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var name$field:String;
      
      private var pwd$field:String;
      
      private var room_state$field:int;
      
      private var count$field:int;
      
      private var capacity$field:int;
      
      [ArrayElementType("com.road.yishi.proto.room.TeamPlayerMsg")]
      public var infos:Array = [];
      
      private var master_id$field:int;
      
      private var boss_count$field:int;
      
      private var is_invite$field:Boolean;
      
      public function TeamRoomMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
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
      
      public function removePwd() : void
      {
         pwd$field = null;
      }
      
      public function get hasPwd() : Boolean
      {
         return pwd$field != null;
      }
      
      public function set pwd(param1:String) : void
      {
         pwd$field = param1;
      }
      
      public function get pwd() : String
      {
         return pwd$field;
      }
      
      public function removeRoomState() : void
      {
         hasField$0 &= 4294967293;
         room_state$field = new int();
      }
      
      public function get hasRoomState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set roomState(param1:int) : void
      {
         hasField$0 |= 2;
         room_state$field = param1;
      }
      
      public function get roomState() : int
      {
         return room_state$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeCapacity() : void
      {
         hasField$0 &= 4294967287;
         capacity$field = new int();
      }
      
      public function get hasCapacity() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set capacity(param1:int) : void
      {
         hasField$0 |= 8;
         capacity$field = param1;
      }
      
      public function get capacity() : int
      {
         return capacity$field;
      }
      
      public function removeMasterId() : void
      {
         hasField$0 &= 4294967279;
         master_id$field = new int();
      }
      
      public function get hasMasterId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set masterId(param1:int) : void
      {
         hasField$0 |= 16;
         master_id$field = param1;
      }
      
      public function get masterId() : int
      {
         return master_id$field;
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
      
      public function removeIsInvite() : void
      {
         hasField$0 &= 4294967231;
         is_invite$field = new Boolean();
      }
      
      public function get hasIsInvite() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isInvite(param1:Boolean) : void
      {
         hasField$0 |= 64;
         is_invite$field = param1;
      }
      
      public function get isInvite() : Boolean
      {
         return is_invite$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasPwd)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,pwd$field);
         }
         if(hasRoomState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,room_state$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasCapacity)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,capacity$field);
         }
         _loc2_ = 0;
         while(_loc2_ < infos.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,infos[_loc2_]);
            _loc2_++;
         }
         if(hasMasterId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,master_id$field);
         }
         if(hasBossCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,boss_count$field);
         }
         if(hasIsInvite)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,is_invite$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc7_:TeamPlayerMsg = null;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TeamRoomMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TeamRoomMsg.name cannot be set twice.");
                  }
                  _loc10_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TeamRoomMsg.pwd cannot be set twice.");
                  }
                  _loc8_++;
                  pwd = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TeamRoomMsg.roomState cannot be set twice.");
                  }
                  _loc4_++;
                  roomState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TeamRoomMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TeamRoomMsg.capacity cannot be set twice.");
                  }
                  _loc12_++;
                  capacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc7_ = new TeamPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  infos.push(_loc7_);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TeamRoomMsg.masterId cannot be set twice.");
                  }
                  _loc6_++;
                  masterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TeamRoomMsg.bossCount cannot be set twice.");
                  }
                  _loc11_++;
                  bossCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TeamRoomMsg.isInvite cannot be set twice.");
                  }
                  _loc9_++;
                  isInvite = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

