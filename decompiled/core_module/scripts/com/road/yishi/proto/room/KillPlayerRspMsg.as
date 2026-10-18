package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class KillPlayerRspMsg extends Message implements IExternalizable
   {
      
      private var room_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var killed_player_id$field:int;
      
      public function KillPlayerRspMsg()
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
      
      public function removeKilledPlayerId() : void
      {
         hasField$0 &= 4294967293;
         killed_player_id$field = new int();
      }
      
      public function get hasKilledPlayerId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set killedPlayerId(param1:int) : void
      {
         hasField$0 |= 2;
         killed_player_id$field = param1;
      }
      
      public function get killedPlayerId() : int
      {
         return killed_player_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRoomId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,room_id$field);
         }
         if(hasKilledPlayerId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,killed_player_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: KillPlayerRspMsg.roomId cannot be set twice.");
                  }
                  _loc4_++;
                  roomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: KillPlayerRspMsg.killedPlayerId cannot be set twice.");
                  }
                  _loc3_++;
                  killedPlayerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

