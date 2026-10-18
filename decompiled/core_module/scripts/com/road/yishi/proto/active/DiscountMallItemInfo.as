package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DiscountMallItemInfo extends Message implements IExternalizable
   {
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var itemId$field:int;
      
      private var price$field:int;
      
      private var limit$field:int;
      
      private var count$field:int;
      
      private var buycount$field:int;
      
      public function DiscountMallItemInfo()
      {
         super();
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967294;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 1;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967293;
         itemId$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 2;
         itemId$field = param1;
      }
      
      public function get itemId() : int
      {
         return itemId$field;
      }
      
      public function removePrice() : void
      {
         hasField$0 &= 4294967291;
         price$field = new int();
      }
      
      public function get hasPrice() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set price(param1:int) : void
      {
         hasField$0 |= 4;
         price$field = param1;
      }
      
      public function get price() : int
      {
         return price$field;
      }
      
      public function removeLimit() : void
      {
         hasField$0 &= 4294967287;
         limit$field = new int();
      }
      
      public function get hasLimit() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set limit(param1:int) : void
      {
         hasField$0 |= 8;
         limit$field = param1;
      }
      
      public function get limit() : int
      {
         return limit$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeBuycount() : void
      {
         hasField$0 &= 4294967263;
         buycount$field = new int();
      }
      
      public function get hasBuycount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set buycount(param1:int) : void
      {
         hasField$0 |= 32;
         buycount$field = param1;
      }
      
      public function get buycount() : int
      {
         return buycount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,itemId$field);
         }
         if(hasPrice)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,price$field);
         }
         if(hasLimit)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,limit$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasBuycount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,buycount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallItemInfo.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallItemInfo.itemId cannot be set twice.");
                  }
                  _loc8_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallItemInfo.price cannot be set twice.");
                  }
                  _loc6_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallItemInfo.limit cannot be set twice.");
                  }
                  _loc5_++;
                  limit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallItemInfo.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DiscountMallItemInfo.buycount cannot be set twice.");
                  }
                  _loc9_++;
                  buycount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

