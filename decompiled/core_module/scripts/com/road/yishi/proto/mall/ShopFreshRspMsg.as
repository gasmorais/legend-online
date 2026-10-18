package com.road.yishi.proto.mall
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShopFreshRspMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("int")]
      public var itemId:Array = [];
      
      private var fresh_lastdate$field:String;
      
      [ArrayElementType("int")]
      public var isCanBuy:Array = [];
      
      private var buy_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var max_buy_count$field:int;
      
      public function ShopFreshRspMsg()
      {
         super();
      }
      
      public function removeFreshLastdate() : void
      {
         fresh_lastdate$field = null;
      }
      
      public function get hasFreshLastdate() : Boolean
      {
         return fresh_lastdate$field != null;
      }
      
      public function set freshLastdate(param1:String) : void
      {
         fresh_lastdate$field = param1;
      }
      
      public function get freshLastdate() : String
      {
         return fresh_lastdate$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967294;
         buy_count$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 1;
         buy_count$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buy_count$field;
      }
      
      public function removeMaxBuyCount() : void
      {
         hasField$0 &= 4294967293;
         max_buy_count$field = new int();
      }
      
      public function get hasMaxBuyCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxBuyCount(param1:int) : void
      {
         hasField$0 |= 2;
         max_buy_count$field = param1;
      }
      
      public function get maxBuyCount() : int
      {
         return max_buy_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < itemId.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,itemId[_loc3_]);
            _loc3_++;
         }
         if(hasFreshLastdate)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,fresh_lastdate$field);
         }
         _loc2_ = 0;
         while(_loc2_ < isCanBuy.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,isCanBuy[_loc2_]);
            _loc2_++;
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,buy_count$field);
         }
         if(hasMaxBuyCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,max_buy_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,itemId);
                  }
                  else
                  {
                     itemId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ShopFreshRspMsg.freshLastdate cannot be set twice.");
                  }
                  _loc6_++;
                  freshLastdate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,isCanBuy);
                  }
                  else
                  {
                     isCanBuy.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShopFreshRspMsg.buyCount cannot be set twice.");
                  }
                  _loc3_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ShopFreshRspMsg.maxBuyCount cannot be set twice.");
                  }
                  _loc4_++;
                  maxBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

