package com.road.yishi.proto.room
{
   import com.netease.protobuf.*;
   import com.road.yishi.proto.room.PlayerReadyRspMsg.PlayerReady;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerReadyRspMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.room.PlayerReadyRspMsg.PlayerReady")]
      public var readyState:Array = [];
      
      public function PlayerReadyRspMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < readyState.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,readyState[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:com.road.yishi.proto.room.PlayerReadyRspMsg.PlayerReady = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new com.road.yishi.proto.room.PlayerReadyRspMsg.PlayerReady();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  readyState.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

