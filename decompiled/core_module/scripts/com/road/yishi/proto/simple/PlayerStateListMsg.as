package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerStateListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.simple.WorldBossPlayerStateMsg")]
      public var playerState:Array = [];
      
      [ArrayElementType("int")]
      public var userId:Array = [];
      
      public function PlayerStateListMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < playerState.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,playerState[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < userId.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:WorldBossPlayerStateMsg = null;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new WorldBossPlayerStateMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  playerState.push(_loc4_);
                  break;
               case 1:
                  if((_loc3_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userId);
                  }
                  else
                  {
                     userId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

