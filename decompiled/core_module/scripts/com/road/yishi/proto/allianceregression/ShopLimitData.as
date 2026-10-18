package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShopLimitData extends Message implements IExternalizable
   {
      
      private var GoodsId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var ExchangeCount$field:int;
      
      public function ShopLimitData()
      {
         super();
      }
      
      public function removeGoodsId() : void
      {
         hasField$0 &= 4294967294;
         GoodsId$field = new int();
      }
      
      public function get hasGoodsId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set goodsId(param1:int) : void
      {
         hasField$0 |= 1;
         GoodsId$field = param1;
      }
      
      public function get goodsId() : int
      {
         return GoodsId$field;
      }
      
      public function removeExchangeCount() : void
      {
         hasField$0 &= 4294967293;
         ExchangeCount$field = new int();
      }
      
      public function get hasExchangeCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set exchangeCount(param1:int) : void
      {
         hasField$0 |= 2;
         ExchangeCount$field = param1;
      }
      
      public function get exchangeCount() : int
      {
         return ExchangeCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGoodsId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,GoodsId$field);
         }
         if(hasExchangeCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,ExchangeCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShopLimitData.goodsId cannot be set twice.");
                  }
                  _loc3_++;
                  goodsId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ShopLimitData.exchangeCount cannot be set twice.");
                  }
                  _loc4_++;
                  exchangeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

