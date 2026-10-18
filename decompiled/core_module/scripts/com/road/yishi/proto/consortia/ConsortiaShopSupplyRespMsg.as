package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaShopSupplyRespMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("int")]
      public var mapShopId:Array = [];
      
      public function ConsortiaShopSupplyRespMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < mapShopId.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mapShopId[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if((_loc3_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,mapShopId);
                  }
                  else
                  {
                     mapShopId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

