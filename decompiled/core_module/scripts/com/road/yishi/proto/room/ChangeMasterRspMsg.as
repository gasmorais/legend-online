package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChangeMasterRspMsg extends Message implements IExternalizable
   {
      
      private var room_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var master_id$field:int;
      
      private var serverName$field:String;
      
      private var isCross$field:Boolean;
      
      public function ChangeMasterRspMsg()
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
      
      public function removeMasterId() : void
      {
         hasField$0 &= 4294967293;
         master_id$field = new int();
      }
      
      public function get hasMasterId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set masterId(param1:int) : void
      {
         hasField$0 |= 2;
         master_id$field = param1;
      }
      
      public function get masterId() : int
      {
         return master_id$field;
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
      
      public function removeIsCross() : void
      {
         hasField$0 &= 4294967291;
         isCross$field = new Boolean();
      }
      
      public function get hasIsCross() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isCross(param1:Boolean) : void
      {
         hasField$0 |= 4;
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
         if(hasMasterId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,master_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasIsCross)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isCross$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChangeMasterRspMsg.roomId cannot be set twice.");
                  }
                  _loc5_++;
                  roomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChangeMasterRspMsg.masterId cannot be set twice.");
                  }
                  _loc4_++;
                  masterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChangeMasterRspMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChangeMasterRspMsg.isCross cannot be set twice.");
                  }
                  _loc7_++;
                  isCross = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

