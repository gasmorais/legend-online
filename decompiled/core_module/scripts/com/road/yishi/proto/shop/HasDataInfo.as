package com.road.yishi.proto.shop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HasDataInfo extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var item_id$field:int;
      
      private var counts$field:int;
      
      private var buy_date$field:String;
      
      private var is_discount$field:Boolean;
      
      public function HasDataInfo()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967293;
         item_id$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 2;
         item_id$field = param1;
      }
      
      public function get itemId() : int
      {
         return item_id$field;
      }
      
      public function removeCounts() : void
      {
         hasField$0 &= 4294967291;
         counts$field = new int();
      }
      
      public function get hasCounts() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set counts(param1:int) : void
      {
         hasField$0 |= 4;
         counts$field = param1;
      }
      
      public function get counts() : int
      {
         return counts$field;
      }
      
      public function removeBuyDate() : void
      {
         buy_date$field = null;
      }
      
      public function get hasBuyDate() : Boolean
      {
         return buy_date$field != null;
      }
      
      public function set buyDate(param1:String) : void
      {
         buy_date$field = param1;
      }
      
      public function get buyDate() : String
      {
         return buy_date$field;
      }
      
      public function removeIsDiscount() : void
      {
         hasField$0 &= 4294967287;
         is_discount$field = new Boolean();
      }
      
      public function get hasIsDiscount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isDiscount(param1:Boolean) : void
      {
         hasField$0 |= 8;
         is_discount$field = param1;
      }
      
      public function get isDiscount() : Boolean
      {
         return is_discount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,item_id$field);
         }
         if(hasCounts)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,counts$field);
         }
         if(hasBuyDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,buy_date$field);
         }
         if(hasIsDiscount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,is_discount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HasDataInfo.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HasDataInfo.itemId cannot be set twice.");
                  }
                  _loc5_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HasDataInfo.counts cannot be set twice.");
                  }
                  _loc3_++;
                  counts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HasDataInfo.buyDate cannot be set twice.");
                  }
                  _loc4_++;
                  buyDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HasDataInfo.isDiscount cannot be set twice.");
                  }
                  _loc6_++;
                  isDiscount = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

