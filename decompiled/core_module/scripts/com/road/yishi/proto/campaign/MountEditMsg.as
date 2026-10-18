package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MountEditMsg extends Message implements IExternalizable
   {
      
      private var property_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pay_type$field:int;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      public var op:int;
      
      public function MountEditMsg()
      {
         super();
      }
      
      public function removePropertyType() : void
      {
         hasField$0 &= 4294967294;
         property_type$field = new int();
      }
      
      public function get hasPropertyType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set propertyType(param1:int) : void
      {
         hasField$0 |= 1;
         property_type$field = param1;
      }
      
      public function get propertyType() : int
      {
         return property_type$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967291;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 4;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967287;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 8;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPropertyType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,property_type$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         WriteUtils.writeTag(param1,0,5);
         WriteUtils.write$TYPE_INT32(param1,op);
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MountEditMsg.propertyType cannot be set twice.");
                  }
                  _loc6_++;
                  propertyType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MountEditMsg.payType cannot be set twice.");
                  }
                  _loc5_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MountEditMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MountEditMsg.param2 cannot be set twice.");
                  }
                  _loc8_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MountEditMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
         if(_loc7_ != 1)
         {
            throw new IOError("Bad data format: MountEditMsg.op must be set.");
         }
      }
   }
}

