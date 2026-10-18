package com.road.yishi.proto.shop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShopCarListMsg extends Message implements IExternalizable
   {
      
      private var result$field:int;
      
      private var hasField$0:uint = 0;
      
      private var receiveUserId$field:int;
      
      private var discountTempId$field:int;
      
      private var isMail$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.shop.CarItemInfoMsg")]
      public var carItemInfo:Array = [];
      
      public function ShopCarListMsg()
      {
         super();
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeReceiveUserId() : void
      {
         hasField$0 &= 4294967293;
         receiveUserId$field = new int();
      }
      
      public function get hasReceiveUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set receiveUserId(param1:int) : void
      {
         hasField$0 |= 2;
         receiveUserId$field = param1;
      }
      
      public function get receiveUserId() : int
      {
         return receiveUserId$field;
      }
      
      public function removeDiscountTempId() : void
      {
         hasField$0 &= 4294967291;
         discountTempId$field = new int();
      }
      
      public function get hasDiscountTempId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set discountTempId(param1:int) : void
      {
         hasField$0 |= 4;
         discountTempId$field = param1;
      }
      
      public function get discountTempId() : int
      {
         return discountTempId$field;
      }
      
      public function removeIsMail() : void
      {
         hasField$0 &= 4294967294;
         isMail$field = new Boolean();
      }
      
      public function get hasIsMail() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isMail(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isMail$field = param1;
      }
      
      public function get isMail() : Boolean
      {
         return isMail$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasReceiveUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,receiveUserId$field);
         }
         if(hasDiscountTempId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,discountTempId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < carItemInfo.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,carItemInfo[_loc2_]);
            _loc2_++;
         }
         if(hasIsMail)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isMail$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:CarItemInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ShopCarListMsg.result cannot be set twice.");
                  }
                  _loc5_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ShopCarListMsg.receiveUserId cannot be set twice.");
                  }
                  _loc4_++;
                  receiveUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShopCarListMsg.discountTempId cannot be set twice.");
                  }
                  _loc3_++;
                  discountTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc6_ = new CarItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  carItemInfo.push(_loc6_);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ItemMsg.isMail cannot be set twice.");
                  }
                  _loc8_++;
                  isMail = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

