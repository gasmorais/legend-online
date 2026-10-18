package com.road.yishi.proto.star
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarRandRspMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.star.StarRandMsg")]
      public var starRand:Array = [];
      
      [ArrayElementType("int")]
      public var site:Array = [];
      
      public function StarRandRspMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < starRand.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,starRand[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < site.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,site[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:StarRandMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new StarRandMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  starRand.push(_loc3_);
                  break;
               case 2:
                  if((_loc4_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,site);
                  }
                  else
                  {
                     site.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

