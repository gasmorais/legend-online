package com.road.yishi.proto.stackhead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadNodeEventUpdatedMsg extends Message implements IExternalizable
   {
      
      public function StackHeadNodeEventUpdatedMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            var _loc4_:int = _loc3_ >>> 3;
            ReadUtils.skip(param1,_loc3_ & 7);
         }
      }
   }
}

