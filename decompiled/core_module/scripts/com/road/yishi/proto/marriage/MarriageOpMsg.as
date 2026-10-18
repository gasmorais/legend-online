package com.road.yishi.proto.marriage
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarriageOpMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var op_type$field:int;
      
      private var pay_type$field:int;
      
      private var property1$field:int;
      
      private var property2$field:int;
      
      private var property3$field:String;
      
      private var property4$field:String;
      
      private var property5$field:Boolean;
      
      [ArrayElementType("int")]
      public var userIds:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.marriage.PropertyListMsg")]
      public var properties:Array = [];
      
      private var isNoGet$field:Boolean;
      
      public function MarriageOpMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
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
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967291;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 4;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeProperty1() : void
      {
         hasField$0 &= 4294967287;
         property1$field = new int();
      }
      
      public function get hasProperty1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set property1(param1:int) : void
      {
         hasField$0 |= 8;
         property1$field = param1;
      }
      
      public function get property1() : int
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         hasField$0 &= 4294967279;
         property2$field = new int();
      }
      
      public function get hasProperty2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set property2(param1:int) : void
      {
         hasField$0 |= 16;
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
      
      public function removeProperty5() : void
      {
         hasField$0 &= 4294967263;
         property5$field = new Boolean();
      }
      
      public function get hasProperty5() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set property5(param1:Boolean) : void
      {
         hasField$0 |= 32;
         property5$field = param1;
      }
      
      public function get property5() : Boolean
      {
         return property5$field;
      }
      
      public function removeIsNoGet() : void
      {
         hasField$0 &= 4294967231;
         isNoGet$field = new Boolean();
      }
      
      public function get hasIsNoGet() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isNoGet(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isNoGet$field = param1;
      }
      
      public function get isNoGet() : Boolean
      {
         return isNoGet$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,property2$field);
         }
         if(hasProperty3)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,property3$field);
         }
         if(hasProperty4)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,property4$field);
         }
         if(hasProperty5)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,property5$field);
         }
         _loc3_ = 0;
         while(_loc3_ < userIds.length)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,userIds[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < properties.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,properties[_loc2_]);
            _loc2_++;
         }
         if(hasIsNoGet)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,isNoGet$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc5_:PropertyListMsg = null;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageOpMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageOpMsg.opType cannot be set twice.");
                  }
                  _loc8_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageOpMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageOpMsg.property1 cannot be set twice.");
                  }
                  _loc9_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageOpMsg.property2 cannot be set twice.");
                  }
                  _loc13_++;
                  property2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageOpMsg.property3 cannot be set twice.");
                  }
                  _loc7_++;
                  property3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageOpMsg.property4 cannot be set twice.");
                  }
                  _loc4_++;
                  property4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageOpMsg.property5 cannot be set twice.");
                  }
                  _loc3_++;
                  property5 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if((_loc11_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userIds);
                  }
                  else
                  {
                     userIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 9:
                  _loc5_ = new PropertyListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  properties.push(_loc5_);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageOpMsg.isNoGet cannot be set twice.");
                  }
                  _loc12_++;
                  isNoGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

