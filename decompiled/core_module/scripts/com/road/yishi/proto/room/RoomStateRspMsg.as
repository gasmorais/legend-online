package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RoomStateRspMsg extends Message implements IExternalizable
   {
      
      private var room_state$field:int;
      
      private var hasField$0:uint = 0;
      
      public function RoomStateRspMsg()
      {
         super();
      }
      
      public function removeRoomState() : void
      {
         hasField$0 &= 4294967294;
         room_state$field = new int();
      }
      
      public function get hasRoomState() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set roomState(param1:int) : void
      {
         hasField$0 |= 1;
         room_state$field = param1;
      }
      
      public function get roomState() : int
      {
         return room_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRoomState)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,room_state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RoomStateRspMsg.roomState cannot be set twice.");
                  }
                  _loc3_++;
                  roomState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

