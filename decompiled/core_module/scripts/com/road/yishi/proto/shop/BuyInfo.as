package com.road.yishi.proto.shop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BuyInfo extends Message implements IExternalizable
   {
      
      private var is_discount$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var good_id$field:int;
      
      private var count$field:int;
      
      private var receive_id$field:int;
      
      private var result$field:int;
      
      private var type$field:int;
      
      public function BuyInfo()
      {
         super();
      }
      
      public function removeIsDiscount() : void
      {
         hasField$0 &= 4294967294;
         is_discount$field = new Boolean();
      }
      
      public function get hasIsDiscount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isDiscount(param1:Boolean) : void
      {
         hasField$0 |= 1;
         is_discount$field = param1;
      }
      
      public function get isDiscount() : Boolean
      {
         return is_discount$field;
      }
      
      public function removeGoodId() : void
      {
         hasField$0 &= 4294967293;
         good_id$field = new int();
      }
      
      public function get hasGoodId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set goodId(param1:int) : void
      {
         hasField$0 |= 2;
         good_id$field = param1;
      }
      
      public function get goodId() : int
      {
         return good_id$field;
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
      
      public function removeReceiveId() : void
      {
         hasField$0 &= 4294967287;
         receive_id$field = new int();
      }
      
      public function get hasReceiveId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set receiveId(param1:int) : void
      {
         hasField$0 |= 8;
         receive_id$field = param1;
      }
      
      public function get receiveId() : int
      {
         return receive_id$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967279;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 16;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967263;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 32;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsDiscount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,is_discount$field);
         }
         if(hasGoodId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,good_id$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasReceiveId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,receive_id$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BuyInfo.isDiscount cannot be set twice.");
                  }
                  _loc6_++;
                  isDiscount = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BuyInfo.goodId cannot be set twice.");
                  }
                  _loc5_++;
                  goodId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BuyInfo.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BuyInfo.receiveId cannot be set twice.");
                  }
                  _loc3_++;
                  receiveId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BuyInfo.result cannot be set twice.");
                  }
                  _loc7_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BuyInfo.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

