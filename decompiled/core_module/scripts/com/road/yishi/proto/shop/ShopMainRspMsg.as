package com.road.yishi.proto.shop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShopMainRspMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.shop.MainUrlInfo")]
      public var urlInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.shop.MainGoodInfo")]
      public var goodInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.shop.MainDiscountInfo")]
      public var discountInfo:Array = [];
      
      private var flag$field:int;
      
      private var hasField$0:uint = 0;
      
      public function ShopMainRspMsg()
      {
         super();
      }
      
      public function removeFlag() : void
      {
         hasField$0 &= 4294967294;
         flag$field = new int();
      }
      
      public function get hasFlag() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set flag(param1:int) : void
      {
         hasField$0 |= 1;
         flag$field = param1;
      }
      
      public function get flag() : int
      {
         return flag$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < urlInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,urlInfo[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < goodInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,goodInfo[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < discountInfo.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,discountInfo[_loc2_]);
            _loc2_++;
         }
         if(hasFlag)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,flag$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:MainUrlInfo = null;
         var _loc3_:MainGoodInfo = null;
         var _loc4_:MainDiscountInfo = null;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new MainUrlInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  urlInfo.push(_loc7_);
                  break;
               case 1:
                  _loc3_ = new MainGoodInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  goodInfo.push(_loc3_);
                  break;
               case 2:
                  _loc4_ = new MainDiscountInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  discountInfo.push(_loc4_);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ShopMainRspMsg.flag cannot be set twice.");
                  }
                  _loc6_++;
                  flag = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

