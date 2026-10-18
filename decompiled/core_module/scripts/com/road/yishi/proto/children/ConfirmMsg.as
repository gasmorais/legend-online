package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConfirmMsg extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var property1$field:int;
      
      private var property2$field:String;
      
      public function ConfirmMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeProperty1() : void
      {
         hasField$0 &= 4294967293;
         property1$field = new int();
      }
      
      public function get hasProperty1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set property1(param1:int) : void
      {
         hasField$0 |= 2;
         property1$field = param1;
      }
      
      public function get property1() : int
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         property2$field = null;
      }
      
      public function get hasProperty2() : Boolean
      {
         return property2$field != null;
      }
      
      public function set property2(param1:String) : void
      {
         property2$field = param1;
      }
      
      public function get property2() : String
      {
         return property2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
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
                     throw new IOError("Bad data format: ConfirmMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConfirmMsg.property1 cannot be set twice.");
                  }
                  _loc4_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConfirmMsg.property2 cannot be set twice.");
                  }
                  _loc6_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

