package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RoomMsg extends Message implements IExternalizable
   {
      
      private var room_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaignId$field:int;
      
      private var master_id$field:int;
      
      private var name$field:String;
      
      private var count$field:int;
      
      private var capacity$field:int;
      
      private var room_state$field:int;
      
      private var room_type$field:int;
      
      private var is_set_password$field:Boolean;
      
      private var masterServerName$field:String;
      
      private var masterName$field:String;
      
      private var masterScore$field:int;
      
      public function RoomMsg()
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
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967293;
         campaignId$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 2;
         campaignId$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaignId$field;
      }
      
      public function removeMasterId() : void
      {
         hasField$0 &= 4294967291;
         master_id$field = new int();
      }
      
      public function get hasMasterId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set masterId(param1:int) : void
      {
         hasField$0 |= 4;
         master_id$field = param1;
      }
      
      public function get masterId() : int
      {
         return master_id$field;
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
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967287;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 8;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeCapacity() : void
      {
         hasField$0 &= 4294967279;
         capacity$field = new int();
      }
      
      public function get hasCapacity() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set capacity(param1:int) : void
      {
         hasField$0 |= 16;
         capacity$field = param1;
      }
      
      public function get capacity() : int
      {
         return capacity$field;
      }
      
      public function removeRoomState() : void
      {
         hasField$0 &= 4294967263;
         room_state$field = new int();
      }
      
      public function get hasRoomState() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set roomState(param1:int) : void
      {
         hasField$0 |= 32;
         room_state$field = param1;
      }
      
      public function get roomState() : int
      {
         return room_state$field;
      }
      
      public function removeRoomType() : void
      {
         hasField$0 &= 4294967231;
         room_type$field = new int();
      }
      
      public function get hasRoomType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set roomType(param1:int) : void
      {
         hasField$0 |= 64;
         room_type$field = param1;
      }
      
      public function get roomType() : int
      {
         return room_type$field;
      }
      
      public function removeIsSetPassword() : void
      {
         hasField$0 &= 4294967167;
         is_set_password$field = new Boolean();
      }
      
      public function get hasIsSetPassword() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isSetPassword(param1:Boolean) : void
      {
         hasField$0 |= 128;
         is_set_password$field = param1;
      }
      
      public function get isSetPassword() : Boolean
      {
         return is_set_password$field;
      }
      
      public function removeMasterServerName() : void
      {
         masterServerName$field = null;
      }
      
      public function get hasMasterServerName() : Boolean
      {
         return masterServerName$field != null;
      }
      
      public function set masterServerName(param1:String) : void
      {
         masterServerName$field = param1;
      }
      
      public function get masterServerName() : String
      {
         return masterServerName$field;
      }
      
      public function removeMasterName() : void
      {
         masterName$field = null;
      }
      
      public function get hasMasterName() : Boolean
      {
         return masterName$field != null;
      }
      
      public function set masterName(param1:String) : void
      {
         masterName$field = param1;
      }
      
      public function get masterName() : String
      {
         return masterName$field;
      }
      
      public function removeMasterScore() : void
      {
         hasField$0 &= 4294967039;
         masterScore$field = new int();
      }
      
      public function get hasMasterScore() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set masterScore(param1:int) : void
      {
         hasField$0 |= 256;
         masterScore$field = param1;
      }
      
      public function get masterScore() : int
      {
         return masterScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRoomId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,room_id$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,campaignId$field);
         }
         if(hasMasterId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,master_id$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,name$field);
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
         if(hasRoomState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,room_state$field);
         }
         if(hasRoomType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,room_type$field);
         }
         if(hasIsSetPassword)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,is_set_password$field);
         }
         if(hasMasterServerName)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,masterServerName$field);
         }
         if(hasMasterName)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,masterName$field);
         }
         if(hasMasterScore)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,masterScore$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc15_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.roomId cannot be set twice.");
                  }
                  _loc13_++;
                  roomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.campaignId cannot be set twice.");
                  }
                  _loc7_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.masterId cannot be set twice.");
                  }
                  _loc6_++;
                  masterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.name cannot be set twice.");
                  }
                  _loc8_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.capacity cannot be set twice.");
                  }
                  _loc11_++;
                  capacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.roomState cannot be set twice.");
                  }
                  _loc5_++;
                  roomState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.roomType cannot be set twice.");
                  }
                  _loc9_++;
                  roomType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.isSetPassword cannot be set twice.");
                  }
                  _loc10_++;
                  isSetPassword = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.masterServerName cannot be set twice.");
                  }
                  _loc12_++;
                  masterServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.masterName cannot be set twice.");
                  }
                  _loc15_++;
                  masterName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RoomMsg.masterScore cannot be set twice.");
                  }
                  _loc4_++;
                  masterScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

