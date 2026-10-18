package com.road.yishi.proto.children
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildrenOpMsg extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pay_type$field:int;
      
      private var property1$field:int;
      
      private var property2$field:int;
      
      private var property3$field:String;
      
      private var property4$field:String;
      
      private var property5$field:Boolean;
      
      private var property6$field:int;
      
      [ArrayElementType("com.road.yishi.proto.children.FurnitureDecMsg")]
      public var furniture:Array = [];
      
      private var property7$field:int;
      
      [ArrayElementType("com.road.yishi.proto.children.PosMsg")]
      public var poses:Array = [];
      
      [ArrayElementType("int")]
      public var inviteFriendids:Array = [];
      
      public function ChildrenOpMsg()
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
      
      public function removeProperty5() : void
      {
         hasField$0 &= 4294967279;
         property5$field = new Boolean();
      }
      
      public function get hasProperty5() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set property5(param1:Boolean) : void
      {
         hasField$0 |= 16;
         property5$field = param1;
      }
      
      public function get property5() : Boolean
      {
         return property5$field;
      }
      
      public function removeProperty6() : void
      {
         hasField$0 &= 4294967263;
         property6$field = new int();
      }
      
      public function get hasProperty6() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set property6(param1:int) : void
      {
         hasField$0 |= 32;
         property6$field = param1;
      }
      
      public function get property6() : int
      {
         return property6$field;
      }
      
      public function removeProperty7() : void
      {
         hasField$0 &= 4294967231;
         property7$field = new int();
      }
      
      public function get hasProperty7() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set property7(param1:int) : void
      {
         hasField$0 |= 64;
         property7$field = param1;
      }
      
      public function get property7() : int
      {
         return property7$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
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
         if(hasProperty5)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,property5$field);
         }
         if(hasProperty6)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,property6$field);
         }
         _loc2_ = 0;
         while(_loc2_ < furniture.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,furniture[_loc2_]);
            _loc2_++;
         }
         if(hasProperty7)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,property7$field);
         }
         _loc4_ = 0;
         while(_loc4_ < poses.length)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_MESSAGE(param1,poses[_loc4_]);
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < inviteFriendids.length)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,inviteFriendids[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc8_:FurnitureDecMsg = null;
         var _loc3_:PosMsg = null;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenOpMsg.opType cannot be set twice.");
                  }
                  _loc9_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenOpMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenOpMsg.property1 cannot be set twice.");
                  }
                  _loc10_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenOpMsg.property2 cannot be set twice.");
                  }
                  _loc14_++;
                  property2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenOpMsg.property3 cannot be set twice.");
                  }
                  _loc7_++;
                  property3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenOpMsg.property4 cannot be set twice.");
                  }
                  _loc5_++;
                  property4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenOpMsg.property5 cannot be set twice.");
                  }
                  _loc4_++;
                  property5 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenOpMsg.property6 cannot be set twice.");
                  }
                  _loc13_++;
                  property6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc8_ = new FurnitureDecMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  furniture.push(_loc8_);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChildrenOpMsg.property7 cannot be set twice.");
                  }
                  _loc11_++;
                  property7 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  _loc3_ = new PosMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  poses.push(_loc3_);
                  break;
               case 11:
                  if((_loc12_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,inviteFriendids);
                  }
                  else
                  {
                     inviteFriendids.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

