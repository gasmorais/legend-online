package com.road.yishi.proto.building
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OrderInfoMsg extends Message implements IExternalizable
   {
      
      private var order_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var order_type$field:int;
      
      private var remain_time$field:int;
      
      private var user_id$field:int;
      
      private var begin_time$field:String;
      
      private var need_time$field:int;
      
      public function OrderInfoMsg()
      {
         super();
      }
      
      public function removeOrderId() : void
      {
         hasField$0 &= 4294967294;
         order_id$field = new int();
      }
      
      public function get hasOrderId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set orderId(param1:int) : void
      {
         hasField$0 |= 1;
         order_id$field = param1;
      }
      
      public function get orderId() : int
      {
         return order_id$field;
      }
      
      public function removeOrderType() : void
      {
         hasField$0 &= 4294967293;
         order_type$field = new int();
      }
      
      public function get hasOrderType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set orderType(param1:int) : void
      {
         hasField$0 |= 2;
         order_type$field = param1;
      }
      
      public function get orderType() : int
      {
         return order_type$field;
      }
      
      public function removeRemainTime() : void
      {
         hasField$0 &= 4294967291;
         remain_time$field = new int();
      }
      
      public function get hasRemainTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set remainTime(param1:int) : void
      {
         hasField$0 |= 4;
         remain_time$field = param1;
      }
      
      public function get remainTime() : int
      {
         return remain_time$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967287;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 8;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeBeginTime() : void
      {
         begin_time$field = null;
      }
      
      public function get hasBeginTime() : Boolean
      {
         return begin_time$field != null;
      }
      
      public function set beginTime(param1:String) : void
      {
         begin_time$field = param1;
      }
      
      public function get beginTime() : String
      {
         return begin_time$field;
      }
      
      public function removeNeedTime() : void
      {
         hasField$0 &= 4294967279;
         need_time$field = new int();
      }
      
      public function get hasNeedTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set needTime(param1:int) : void
      {
         hasField$0 |= 16;
         need_time$field = param1;
      }
      
      public function get needTime() : int
      {
         return need_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOrderId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,order_id$field);
         }
         if(hasOrderType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,order_type$field);
         }
         if(hasRemainTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,remain_time$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasBeginTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,begin_time$field);
         }
         if(hasNeedTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,need_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: OrderInfoMsg.orderId cannot be set twice.");
                  }
                  _loc8_++;
                  orderId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OrderInfoMsg.orderType cannot be set twice.");
                  }
                  _loc4_++;
                  orderType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: OrderInfoMsg.remainTime cannot be set twice.");
                  }
                  _loc5_++;
                  remainTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: OrderInfoMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OrderInfoMsg.beginTime cannot be set twice.");
                  }
                  _loc6_++;
                  beginTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OrderInfoMsg.needTime cannot be set twice.");
                  }
                  _loc3_++;
                  needTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

