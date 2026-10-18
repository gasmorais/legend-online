package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WishPoolShopGoodInfo extends Message implements IExternalizable
   {
      
      private var key$field:int;
      
      private var hasField$0:uint = 0;
      
      private var itemId$field:int;
      
      private var count$field:int;
      
      private var price$field:int;
      
      private var limitBuyCount$field:int;
      
      private var curBuyCount$field:int;
      
      public function WishPoolShopGoodInfo()
      {
         super();
      }
      
      public function removeKey() : void
      {
         hasField$0 &= 4294967294;
         key$field = new int();
      }
      
      public function get hasKey() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set key(param1:int) : void
      {
         hasField$0 |= 1;
         key$field = param1;
      }
      
      public function get key() : int
      {
         return key$field;
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
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removePrice() : void
      {
         hasField$0 &= 4294967287;
         price$field = new int();
      }
      
      public function get hasPrice() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set price(param1:int) : void
      {
         hasField$0 |= 8;
         price$field = param1;
      }
      
      public function get price() : int
      {
         return price$field;
      }
      
      public function removeLimitBuyCount() : void
      {
         hasField$0 &= 4294967279;
         limitBuyCount$field = new int();
      }
      
      public function get hasLimitBuyCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set limitBuyCount(param1:int) : void
      {
         hasField$0 |= 16;
         limitBuyCount$field = param1;
      }
      
      public function get limitBuyCount() : int
      {
         return limitBuyCount$field;
      }
      
      public function removeCurBuyCount() : void
      {
         hasField$0 &= 4294967263;
         curBuyCount$field = new int();
      }
      
      public function get hasCurBuyCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set curBuyCount(param1:int) : void
      {
         hasField$0 |= 32;
         curBuyCount$field = param1;
      }
      
      public function get curBuyCount() : int
      {
         return curBuyCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasKey)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,key$field);
         }
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,itemId$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasPrice)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,price$field);
         }
         if(hasLimitBuyCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,limitBuyCount$field);
         }
         if(hasCurBuyCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,curBuyCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolShopGoodInfo.key cannot be set twice.");
                  }
                  _loc3_++;
                  key = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolShopGoodInfo.itemId cannot be set twice.");
                  }
                  _loc8_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolShopGoodInfo.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolShopGoodInfo.price cannot be set twice.");
                  }
                  _loc5_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolShopGoodInfo.limitBuyCount cannot be set twice.");
                  }
                  _loc6_++;
                  limitBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolShopGoodInfo.curBuyCount cannot be set twice.");
                  }
                  _loc9_++;
                  curBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

