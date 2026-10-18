package com.road.yishi.proto.shop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShopTempInfoListMsg extends Message implements IExternalizable
   {
      
      private var shop_type$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.shop.ShopTempInfoMsg")]
      public var shopTempInfo:Array = [];
      
      public function ShopTempInfoListMsg()
      {
         super();
      }
      
      public function removeShopType() : void
      {
         hasField$0 &= 4294967294;
         shop_type$field = new int();
      }
      
      public function get hasShopType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set shopType(param1:int) : void
      {
         hasField$0 |= 1;
         shop_type$field = param1;
      }
      
      public function get shopType() : int
      {
         return shop_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasShopType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,shop_type$field);
         }
         _loc2_ = 0;
         while(_loc2_ < shopTempInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,shopTempInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:ShopTempInfoMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShopTempInfoListMsg.shopType cannot be set twice.");
                  }
                  _loc3_++;
                  shopType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new ShopTempInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  shopTempInfo.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

