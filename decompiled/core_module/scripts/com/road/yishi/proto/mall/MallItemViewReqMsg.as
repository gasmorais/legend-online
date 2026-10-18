package com.road.yishi.proto.mall
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MallItemViewReqMsg extends Message implements IExternalizable
   {
      
      private var page$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count$field:int;
      
      private var from$field:int;
      
      private var order_by$field:int;
      
      private var order_type$field:int;
      
      public function MallItemViewReqMsg()
      {
         super();
      }
      
      public function removePage() : void
      {
         hasField$0 &= 4294967294;
         page$field = new int();
      }
      
      public function get hasPage() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set page(param1:int) : void
      {
         hasField$0 |= 1;
         page$field = param1;
      }
      
      public function get page() : int
      {
         return page$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967293;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 2;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeFrom() : void
      {
         hasField$0 &= 4294967291;
         from$field = new int();
      }
      
      public function get hasFrom() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set from(param1:int) : void
      {
         hasField$0 |= 4;
         from$field = param1;
      }
      
      public function get from() : int
      {
         return from$field;
      }
      
      public function removeOrderBy() : void
      {
         hasField$0 &= 4294967287;
         order_by$field = new int();
      }
      
      public function get hasOrderBy() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set orderBy(param1:int) : void
      {
         hasField$0 |= 8;
         order_by$field = param1;
      }
      
      public function get orderBy() : int
      {
         return order_by$field;
      }
      
      public function removeOrderType() : void
      {
         hasField$0 &= 4294967279;
         order_type$field = new int();
      }
      
      public function get hasOrderType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set orderType(param1:int) : void
      {
         hasField$0 |= 16;
         order_type$field = param1;
      }
      
      public function get orderType() : int
      {
         return order_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPage)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,page$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasFrom)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,from$field);
         }
         if(hasOrderBy)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,order_by$field);
         }
         if(hasOrderType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,order_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemViewReqMsg.page cannot be set twice.");
                  }
                  _loc6_++;
                  page = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemViewReqMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemViewReqMsg.from cannot be set twice.");
                  }
                  _loc8_++;
                  from = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemViewReqMsg.orderBy cannot be set twice.");
                  }
                  _loc4_++;
                  orderBy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemViewReqMsg.orderType cannot be set twice.");
                  }
                  _loc5_++;
                  orderType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

