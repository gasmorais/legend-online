package com.road.yishi.proto.item
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarketMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.item.StallMsg")]
      public var stalls:Array = [];
      
      [ArrayElementType("int")]
      public var userId:Array = [];
      
      public function MarketMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < stalls.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,stalls[_loc3_]);
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
         var _loc4_:* = 0;
         var _loc3_:StallMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new StallMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  stalls.push(_loc3_);
                  break;
               case 1:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userId);
                  }
                  else
                  {
                     userId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

