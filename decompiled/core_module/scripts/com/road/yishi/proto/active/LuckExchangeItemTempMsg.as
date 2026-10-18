package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LuckExchangeItemTempMsg extends Message implements IExternalizable
   {
      
      private var item_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var item_count$field:int;
      
      private var rare$field:Boolean;
      
      private var drop_type$field:int;
      
      public function LuckExchangeItemTempMsg()
      {
         super();
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967294;
         item_id$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 1;
         item_id$field = param1;
      }
      
      public function get itemId() : int
      {
         return item_id$field;
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
      
      public function removeRare() : void
      {
         hasField$0 &= 4294967291;
         rare$field = new Boolean();
      }
      
      public function get hasRare() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rare(param1:Boolean) : void
      {
         hasField$0 |= 4;
         rare$field = param1;
      }
      
      public function get rare() : Boolean
      {
         return rare$field;
      }
      
      public function removeDropType() : void
      {
         hasField$0 &= 4294967287;
         drop_type$field = new int();
      }
      
      public function get hasDropType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set dropType(param1:int) : void
      {
         hasField$0 |= 8;
         drop_type$field = param1;
      }
      
      public function get dropType() : int
      {
         return drop_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,item_id$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,item_count$field);
         }
         if(hasRare)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,rare$field);
         }
         if(hasDropType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,drop_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeItemTempMsg.itemId cannot be set twice.");
                  }
                  _loc3_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeItemTempMsg.itemCount cannot be set twice.");
                  }
                  _loc6_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeItemTempMsg.rare cannot be set twice.");
                  }
                  _loc7_++;
                  rare = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeItemTempMsg.dropType cannot be set twice.");
                  }
                  _loc4_++;
                  dropType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

