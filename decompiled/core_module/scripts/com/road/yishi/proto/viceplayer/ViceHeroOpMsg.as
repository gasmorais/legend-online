package com.road.yishi.proto.viceplayer
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ViceHeroOpMsg extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pay_type$field:int;
      
      private var property1$field:int;
      
      private var property2$field:int;
      
      private var property3$field:String;
      
      private var property4$field:String;
      
      public function ViceHeroOpMsg()
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
      
      public function removeProperty1() : void
      {
         hasField$0 &= 4294967291;
         property1$field = new int();
      }
      
      public function get hasProperty1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set property1(param1:int) : void
      {
         hasField$0 |= 4;
         property1$field = param1;
      }
      
      public function get property1() : int
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         hasField$0 &= 4294967287;
         property2$field = new int();
      }
      
      public function get hasProperty2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set property2(param1:int) : void
      {
         hasField$0 |= 8;
         property2$field = param1;
      }
      
      public function get property2() : int
      {
         return property2$field;
      }
      
      public function removeProperty3() : void
      {
         property3$field = null;
      }
      
      public function get hasProperty3() : Boolean
      {
         return property3$field != null;
      }
      
      public function set property3(param1:String) : void
      {
         property3$field = param1;
      }
      
      public function get property3() : String
      {
         return property3$field;
      }
      
      public function removeProperty4() : void
      {
         property4$field = null;
      }
      
      public function get hasProperty4() : Boolean
      {
         return property4$field != null;
      }
      
      public function set property4(param1:String) : void
      {
         property4$field = param1;
      }
      
      public function get property4() : String
      {
         return property4$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,property2$field);
         }
         if(hasProperty3)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,property3$field);
         }
         if(hasProperty4)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,property4$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ViceHeroOpMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ViceHeroOpMsg.payType cannot be set twice.");
                  }
                  _loc8_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ViceHeroOpMsg.property1 cannot be set twice.");
                  }
                  _loc5_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ViceHeroOpMsg.property2 cannot be set twice.");
                  }
                  _loc9_++;
                  property2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ViceHeroOpMsg.property3 cannot be set twice.");
                  }
                  _loc3_++;
                  property3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ViceHeroOpMsg.property4 cannot be set twice.");
                  }
                  _loc6_++;
                  property4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

