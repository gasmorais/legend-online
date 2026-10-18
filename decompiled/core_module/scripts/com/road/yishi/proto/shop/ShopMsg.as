package com.road.yishi.proto.shop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShopMsg extends Message implements IExternalizable
   {
      
      private var buyInfo$field:BuyInfo;
      
      [ArrayElementType("com.road.yishi.proto.shop.HasDataInfo")]
      public var hasDataInfo:Array = [];
      
      private var refresh_date$field:String;
      
      private var pay_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var item_templateId$field:int;
      
      private var refresh_interval$field:int;
      
      public function ShopMsg()
      {
         super();
      }
      
      public function removeBuyInfo() : void
      {
         buyInfo$field = null;
      }
      
      public function get hasBuyInfo() : Boolean
      {
         return buyInfo$field != null;
      }
      
      public function set buyInfo(param1:BuyInfo) : void
      {
         buyInfo$field = param1;
      }
      
      public function get buyInfo() : BuyInfo
      {
         return buyInfo$field;
      }
      
      public function removeRefreshDate() : void
      {
         refresh_date$field = null;
      }
      
      public function get hasRefreshDate() : Boolean
      {
         return refresh_date$field != null;
      }
      
      public function set refreshDate(param1:String) : void
      {
         refresh_date$field = param1;
      }
      
      public function get refreshDate() : String
      {
         return refresh_date$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967294;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 1;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeItemTemplateId() : void
      {
         hasField$0 &= 4294967293;
         item_templateId$field = new int();
      }
      
      public function get hasItemTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemTemplateId(param1:int) : void
      {
         hasField$0 |= 2;
         item_templateId$field = param1;
      }
      
      public function get itemTemplateId() : int
      {
         return item_templateId$field;
      }
      
      public function removeRefreshInterval() : void
      {
         hasField$0 &= 4294967291;
         refresh_interval$field = new int();
      }
      
      public function get hasRefreshInterval() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set refreshInterval(param1:int) : void
      {
         hasField$0 |= 4;
         refresh_interval$field = param1;
      }
      
      public function get refreshInterval() : int
      {
         return refresh_interval$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBuyInfo)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,buyInfo$field);
         }
         _loc2_ = 0;
         while(_loc2_ < hasDataInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,hasDataInfo[_loc2_]);
            _loc2_++;
         }
         if(hasRefreshDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,refresh_date$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasItemTemplateId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,item_templateId$field);
         }
         if(hasRefreshInterval)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,refresh_interval$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:HasDataInfo = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShopMsg.buyInfo cannot be set twice.");
                  }
                  _loc3_++;
                  buyInfo = new BuyInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,buyInfo);
                  break;
               case 1:
                  _loc5_ = new HasDataInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  hasDataInfo.push(_loc5_);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ShopMsg.refreshDate cannot be set twice.");
                  }
                  _loc6_++;
                  refreshDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ShopMsg.payType cannot be set twice.");
                  }
                  _loc9_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ShopMsg.itemTemplateId cannot be set twice.");
                  }
                  _loc7_++;
                  itemTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ShopMsg.refreshInterval cannot be set twice.");
                  }
                  _loc4_++;
                  refreshInterval = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

