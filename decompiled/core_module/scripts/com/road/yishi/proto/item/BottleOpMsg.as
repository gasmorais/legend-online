package com.road.yishi.proto.item
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BottleOpMsg extends Message implements IExternalizable
   {
      
      private var alter_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var op_type$field:int;
      
      private var stick_first$field:int;
      
      public function BottleOpMsg()
      {
         super();
      }
      
      public function removeAlterType() : void
      {
         hasField$0 &= 4294967294;
         alter_type$field = new int();
      }
      
      public function get hasAlterType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set alterType(param1:int) : void
      {
         hasField$0 |= 1;
         alter_type$field = param1;
      }
      
      public function get alterType() : int
      {
         return alter_type$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967293;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 2;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeStickFirst() : void
      {
         hasField$0 &= 4294967291;
         stick_first$field = new int();
      }
      
      public function get hasStickFirst() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set stickFirst(param1:int) : void
      {
         hasField$0 |= 4;
         stick_first$field = param1;
      }
      
      public function get stickFirst() : int
      {
         return stick_first$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAlterType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,alter_type$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasStickFirst)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,stick_first$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BottleOpMsg.alterType cannot be set twice.");
                  }
                  _loc3_++;
                  alterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BottleOpMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BottleOpMsg.stickFirst cannot be set twice.");
                  }
                  _loc6_++;
                  stickFirst = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

