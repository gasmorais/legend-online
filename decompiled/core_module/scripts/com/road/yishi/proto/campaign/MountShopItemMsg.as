package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MountShopItemMsg extends Message implements IExternalizable
   {
      
      private var item_temp_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var item_count$field:int;
      
      private var price$field:int;
      
      private var can_buy$field:Boolean;
      
      public function MountShopItemMsg()
      {
         super();
      }
      
      public function removeItemTempId() : void
      {
         hasField$0 &= 4294967294;
         item_temp_id$field = new int();
      }
      
      public function get hasItemTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set itemTempId(param1:int) : void
      {
         hasField$0 |= 1;
         item_temp_id$field = param1;
      }
      
      public function get itemTempId() : int
      {
         return item_temp_id$field;
      }
      
      public function removeItemCount() : void
      {
         hasField$0 &= 4294967293;
         item_count$field = new int();
      }
      
      public function get hasItemCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemCount(param1:int) : void
      {
         hasField$0 |= 2;
         item_count$field = param1;
      }
      
      public function get itemCount() : int
      {
         return item_count$field;
      }
      
      public function removePrice() : void
      {
         hasField$0 &= 4294967291;
         price$field = new int();
      }
      
      public function get hasPrice() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set price(param1:int) : void
      {
         hasField$0 |= 4;
         price$field = param1;
      }
      
      public function get price() : int
      {
         return price$field;
      }
      
      public function removeCanBuy() : void
      {
         hasField$0 &= 4294967287;
         can_buy$field = new Boolean();
      }
      
      public function get hasCanBuy() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set canBuy(param1:Boolean) : void
      {
         hasField$0 |= 8;
         can_buy$field = param1;
      }
      
      public function get canBuy() : Boolean
      {
         return can_buy$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasItemTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,item_temp_id$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,item_count$field);
         }
         if(hasPrice)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,price$field);
         }
         if(hasCanBuy)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,can_buy$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MountShopItemMsg.itemTempId cannot be set twice.");
                  }
                  _loc3_++;
                  itemTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MountShopItemMsg.itemCount cannot be set twice.");
                  }
                  _loc7_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MountShopItemMsg.price cannot be set twice.");
                  }
                  _loc5_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MountShopItemMsg.canBuy cannot be set twice.");
                  }
                  _loc4_++;
                  canBuy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

