package com.road.yishi.proto.shop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FashionShopMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.shop.BuyInfo")]
      public var buyInfos:Array = [];
      
      private var result$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var pay_type$field:int;
      
      private var item_templateId$field:int;
      
      public function FashionShopMsg()
      {
         super();
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeItemTemplateId() : void
      {
         hasField$0 &= 4294967291;
         item_templateId$field = new int();
      }
      
      public function get hasItemTemplateId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set itemTemplateId(param1:int) : void
      {
         hasField$0 |= 4;
         item_templateId$field = param1;
      }
      
      public function get itemTemplateId() : int
      {
         return item_templateId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < buyInfos.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,buyInfos[_loc2_]);
            _loc2_++;
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasItemTemplateId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,item_templateId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:BuyInfo = null;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new BuyInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  buyInfos.push(_loc3_);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FashionShopMsg.result cannot be set twice.");
                  }
                  _loc4_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FashionShopMsg.payType cannot be set twice.");
                  }
                  _loc7_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FashionShopMsg.itemTemplateId cannot be set twice.");
                  }
                  _loc5_++;
                  itemTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

