package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadStateMsg extends Message implements IExternalizable
   {
      
      private var group_time$field:Int64;
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var can_sign_in$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadOpenTimeMsg")]
      public var hugeHeadOpenTime:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadOpenTimeMsg")]
      public var hugeHeadNextOpenTime:Array = [];
      
      private var huge_head_session$field:int;
      
      private var huge_head_state$field:int;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadOpenTimeMsg")]
      public var stackHeadOpenTime:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadOpenTimeMsg")]
      public var stackHeadNextOpenTime:Array = [];
      
      private var stack_head_session$field:int;
      
      private var stack_head_state$field:int;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadActiveMsg")]
      public var activeList:Array = [];
      
      public function HugeHeadStateMsg()
      {
         super();
      }
      
      public function removeGroupTime() : void
      {
         group_time$field = null;
      }
      
      public function get hasGroupTime() : Boolean
      {
         return group_time$field != null;
      }
      
      public function set groupTime(param1:Int64) : void
      {
         group_time$field = param1;
      }
      
      public function get groupTime() : Int64
      {
         return group_time$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967294;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 1;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeCanSignIn() : void
      {
         hasField$0 &= 4294967293;
         can_sign_in$field = new Boolean();
      }
      
      public function get hasCanSignIn() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set canSignIn(param1:Boolean) : void
      {
         hasField$0 |= 2;
         can_sign_in$field = param1;
      }
      
      public function get canSignIn() : Boolean
      {
         return can_sign_in$field;
      }
      
      public function removeHugeHeadSession() : void
      {
         hasField$0 &= 4294967291;
         huge_head_session$field = new int();
      }
      
      public function get hasHugeHeadSession() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set hugeHeadSession(param1:int) : void
      {
         hasField$0 |= 4;
         huge_head_session$field = param1;
      }
      
      public function get hugeHeadSession() : int
      {
         return huge_head_session$field;
      }
      
      public function removeHugeHeadState() : void
      {
         hasField$0 &= 4294967287;
         huge_head_state$field = new int();
      }
      
      public function get hasHugeHeadState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set hugeHeadState(param1:int) : void
      {
         hasField$0 |= 8;
         huge_head_state$field = param1;
      }
      
      public function get hugeHeadState() : int
      {
         return huge_head_state$field;
      }
      
      public function removeStackHeadSession() : void
      {
         hasField$0 &= 4294967279;
         stack_head_session$field = new int();
      }
      
      public function get hasStackHeadSession() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set stackHeadSession(param1:int) : void
      {
         hasField$0 |= 16;
         stack_head_session$field = param1;
      }
      
      public function get stackHeadSession() : int
      {
         return stack_head_session$field;
      }
      
      public function removeStackHeadState() : void
      {
         hasField$0 &= 4294967263;
         stack_head_state$field = new int();
      }
      
      public function get hasStackHeadState() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set stackHeadState(param1:int) : void
      {
         hasField$0 |= 32;
         stack_head_state$field = param1;
      }
      
      public function get stackHeadState() : int
      {
         return stack_head_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc6_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         if(hasGroupTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT64(param1,group_time$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasCanSignIn)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,can_sign_in$field);
         }
         _loc4_ = 0;
         while(_loc4_ < hugeHeadOpenTime.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,hugeHeadOpenTime[_loc4_]);
            _loc4_++;
         }
         _loc6_ = 0;
         while(_loc6_ < hugeHeadNextOpenTime.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,hugeHeadNextOpenTime[_loc6_]);
            _loc6_++;
         }
         if(hasHugeHeadSession)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,huge_head_session$field);
         }
         if(hasHugeHeadState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,huge_head_state$field);
         }
         _loc2_ = 0;
         while(_loc2_ < stackHeadOpenTime.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,stackHeadOpenTime[_loc2_]);
            _loc2_++;
         }
         _loc5_ = 0;
         while(_loc5_ < stackHeadNextOpenTime.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,stackHeadNextOpenTime[_loc5_]);
            _loc5_++;
         }
         if(hasStackHeadSession)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,stack_head_session$field);
         }
         if(hasStackHeadState)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,stack_head_state$field);
         }
         _loc3_ = 0;
         while(_loc3_ < activeList.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,activeList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc10_:HugeHeadOpenTimeMsg = null;
         var _loc11_:HugeHeadOpenTimeMsg = null;
         var _loc5_:HugeHeadOpenTimeMsg = null;
         var _loc15_:HugeHeadOpenTimeMsg = null;
         var _loc13_:HugeHeadActiveMsg = null;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadStateMsg.groupTime cannot be set twice.");
                  }
                  _loc9_++;
                  groupTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadStateMsg.index cannot be set twice.");
                  }
                  _loc8_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadStateMsg.canSignIn cannot be set twice.");
                  }
                  _loc12_++;
                  canSignIn = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  _loc10_ = new HugeHeadOpenTimeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  hugeHeadOpenTime.push(_loc10_);
                  break;
               case 4:
                  _loc11_ = new HugeHeadOpenTimeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  hugeHeadNextOpenTime.push(_loc11_);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadStateMsg.hugeHeadSession cannot be set twice.");
                  }
                  _loc3_++;
                  hugeHeadSession = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadStateMsg.hugeHeadState cannot be set twice.");
                  }
                  _loc7_++;
                  hugeHeadState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc5_ = new HugeHeadOpenTimeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  stackHeadOpenTime.push(_loc5_);
                  break;
               case 8:
                  _loc15_ = new HugeHeadOpenTimeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc15_);
                  stackHeadNextOpenTime.push(_loc15_);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadStateMsg.stackHeadSession cannot be set twice.");
                  }
                  _loc6_++;
                  stackHeadSession = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadStateMsg.stackHeadState cannot be set twice.");
                  }
                  _loc4_++;
                  stackHeadState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  _loc13_ = new HugeHeadActiveMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  activeList.push(_loc13_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

