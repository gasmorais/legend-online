package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PayTypeMsg extends Message implements IExternalizable
   {
      
      private var pay_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var property1$field:int;
      
      private var property2$field:int;
      
      private var type$field:int;
      
      public function PayTypeMsg()
      {
         super();
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967294;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 1;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
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
         hasField$0 &= 4294967291;
         property2$field = new int();
      }
      
      public function get hasProperty2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set property2(param1:int) : void
      {
         hasField$0 |= 4;
         property2$field = param1;
      }
      
      public function get property2() : int
      {
         return property2$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967287;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 8;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,property2$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PayTypeMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PayTypeMsg.property1 cannot be set twice.");
                  }
                  _loc3_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PayTypeMsg.property2 cannot be set twice.");
                  }
                  _loc7_++;
                  property2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PayTypeMsg.type cannot be set twice.");
                  }
                  _loc4_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

