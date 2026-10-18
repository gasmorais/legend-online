package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MoneyReturnMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var percent$field:int;
      
      private var left$field:int;
      
      public function MoneyReturnMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removePercent() : void
      {
         hasField$0 &= 4294967293;
         percent$field = new int();
      }
      
      public function get hasPercent() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set percent(param1:int) : void
      {
         hasField$0 |= 2;
         percent$field = param1;
      }
      
      public function get percent() : int
      {
         return percent$field;
      }
      
      public function removeLeft() : void
      {
         hasField$0 &= 4294967291;
         left$field = new int();
      }
      
      public function get hasLeft() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set left(param1:int) : void
      {
         hasField$0 |= 4;
         left$field = param1;
      }
      
      public function get left() : int
      {
         return left$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasPercent)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,percent$field);
         }
         if(hasLeft)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,left$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MoneyReturnMsg.op cannot be set twice.");
                  }
                  _loc5_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MoneyReturnMsg.percent cannot be set twice.");
                  }
                  _loc3_++;
                  percent = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MoneyReturnMsg.left cannot be set twice.");
                  }
                  _loc6_++;
                  left = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

