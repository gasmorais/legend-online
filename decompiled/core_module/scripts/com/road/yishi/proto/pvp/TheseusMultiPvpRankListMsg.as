package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusMultiPvpRankListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.pvp.TheseusMultiPvpRankMsg")]
      public var ranks:Array = [];
      
      public function TheseusMultiPvpRankListMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < ranks.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ranks[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:TheseusMultiPvpRankMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new TheseusMultiPvpRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  ranks.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

