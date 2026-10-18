package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTreasureExchangeRes extends Message implements IExternalizable
   {
      
      private var info$field:SkyTreasureExchangeActivePB;
      
      private var hasField$0:uint = 0;
      
      public function SkyTreasureExchangeRes()
      {
         super();
      }
      
      public function removeInfo() : void
      {
         hasField$0 &= 4294967294;
         info$field = null;
      }
      
      public function get hasInfo() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set info(param1:SkyTreasureExchangeActivePB) : void
      {
         hasField$0 |= 1;
         info$field = param1;
      }
      
      public function get info() : SkyTreasureExchangeActivePB
      {
         return info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasInfo)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,info$field);
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
                  if(hasInfo)
                  {
                     throw new IOError("Bad data format: SkyTreasureExchangeRes.info cannot be set twice.");
                  }
                  info = new SkyTreasureExchangeActivePB();
                  ReadUtils.read$TYPE_MESSAGE(param1,info$field);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

