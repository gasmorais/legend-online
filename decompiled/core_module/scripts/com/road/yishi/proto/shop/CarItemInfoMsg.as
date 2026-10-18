package com.road.yishi.proto.shop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CarItemInfoMsg extends Message implements IExternalizable
   {
      
      private var shopId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var counts$field:int;
      
      private var payType$field:int;
      
      private var isDiscountShop$field:Boolean;
      
      private var type$field:int;
      
      public function CarItemInfoMsg()
      {
         super();
      }
      
      public function removeShopId() : void
      {
         hasField$0 &= 4294967294;
         shopId$field = new int();
      }
      
      public function get hasShopId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set shopId(param1:int) : void
      {
         hasField$0 |= 1;
         shopId$field = param1;
      }
      
      public function get shopId() : int
      {
         return shopId$field;
      }
      
      public function removeCounts() : void
      {
         hasField$0 &= 4294967293;
         counts$field = new int();
      }
      
      public function get hasCounts() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set counts(param1:int) : void
      {
         hasField$0 |= 2;
         counts$field = param1;
      }
      
      public function get counts() : int
      {
         return counts$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967291;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 4;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeIsDiscountShop() : void
      {
         hasField$0 &= 4294967287;
         isDiscountShop$field = new Boolean();
      }
      
      public function get hasIsDiscountShop() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isDiscountShop(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isDiscountShop$field = param1;
      }
      
      public function get isDiscountShop() : Boolean
      {
         return isDiscountShop$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967279;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 16;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasShopId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,shopId$field);
         }
         if(hasCounts)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,counts$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         if(hasIsDiscountShop)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isDiscountShop$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CarItemInfoMsg.shopId cannot be set twice.");
                  }
                  _loc4_++;
                  shopId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CarItemInfoMsg.counts cannot be set twice.");
                  }
                  _loc3_++;
                  counts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CarItemInfoMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CarItemInfoMsg.isDiscountShop cannot be set twice.");
                  }
                  _loc5_++;
                  isDiscountShop = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CarItemInfoMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

