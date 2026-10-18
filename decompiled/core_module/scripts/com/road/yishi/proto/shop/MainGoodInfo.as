package com.road.yishi.proto.shop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MainGoodInfo extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var shopId$field:int;
      
      private var templateId$field:int;
      
      private var sortId$field:int;
      
      private var types$field:int;
      
      public function MainGoodInfo()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeShopId() : void
      {
         hasField$0 &= 4294967293;
         shopId$field = new int();
      }
      
      public function get hasShopId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set shopId(param1:int) : void
      {
         hasField$0 |= 2;
         shopId$field = param1;
      }
      
      public function get shopId() : int
      {
         return shopId$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967291;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 4;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeSortId() : void
      {
         hasField$0 &= 4294967287;
         sortId$field = new int();
      }
      
      public function get hasSortId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set sortId(param1:int) : void
      {
         hasField$0 |= 8;
         sortId$field = param1;
      }
      
      public function get sortId() : int
      {
         return sortId$field;
      }
      
      public function removeTypes() : void
      {
         hasField$0 &= 4294967279;
         types$field = new int();
      }
      
      public function get hasTypes() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set types(param1:int) : void
      {
         hasField$0 |= 16;
         types$field = param1;
      }
      
      public function get types() : int
      {
         return types$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasShopId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,shopId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasSortId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,sortId$field);
         }
         if(hasTypes)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,types$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MainGoodInfo.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MainGoodInfo.shopId cannot be set twice.");
                  }
                  _loc3_++;
                  shopId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MainGoodInfo.templateId cannot be set twice.");
                  }
                  _loc6_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MainGoodInfo.sortId cannot be set twice.");
                  }
                  _loc8_++;
                  sortId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MainGoodInfo.types cannot be set twice.");
                  }
                  _loc4_++;
                  types = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

