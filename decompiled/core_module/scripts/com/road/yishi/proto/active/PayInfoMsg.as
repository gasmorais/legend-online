package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PayInfoMsg extends Message implements IExternalizable
   {
      
      private var day_num$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pay_point$field:int;
      
      public function PayInfoMsg()
      {
         super();
      }
      
      public function removeDayNum() : void
      {
         hasField$0 &= 4294967294;
         day_num$field = new int();
      }
      
      public function get hasDayNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dayNum(param1:int) : void
      {
         hasField$0 |= 1;
         day_num$field = param1;
      }
      
      public function get dayNum() : int
      {
         return day_num$field;
      }
      
      public function removePayPoint() : void
      {
         hasField$0 &= 4294967293;
         pay_point$field = new int();
      }
      
      public function get hasPayPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payPoint(param1:int) : void
      {
         hasField$0 |= 2;
         pay_point$field = param1;
      }
      
      public function get payPoint() : int
      {
         return pay_point$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasDayNum)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,day_num$field);
         }
         if(hasPayPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pay_point$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PayInfoMsg.dayNum cannot be set twice.");
                  }
                  _loc4_++;
                  dayNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PayInfoMsg.payPoint cannot be set twice.");
                  }
                  _loc3_++;
                  payPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

