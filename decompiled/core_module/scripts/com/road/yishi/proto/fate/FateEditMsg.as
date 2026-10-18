package com.road.yishi.proto.fate
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FateEditMsg extends Message implements IExternalizable
   {
      
      private var skill_sonType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var use_itemCount$field:int;
      
      private var is_disable$field:Boolean;
      
      private var turn_num$field:int;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      private var is_success$field:Boolean;
      
      private var curr_count$field:int;
      
      [ArrayElementType("int")]
      public var count:Array = [];
      
      private var pay_type$field:int;
      
      private var index$field:int;
      
      public function FateEditMsg()
      {
         super();
      }
      
      public function removeSkillSonType() : void
      {
         hasField$0 &= 4294967294;
         skill_sonType$field = new int();
      }
      
      public function get hasSkillSonType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillSonType(param1:int) : void
      {
         hasField$0 |= 1;
         skill_sonType$field = param1;
      }
      
      public function get skillSonType() : int
      {
         return skill_sonType$field;
      }
      
      public function removeUseItemCount() : void
      {
         hasField$0 &= 4294967293;
         use_itemCount$field = new int();
      }
      
      public function get hasUseItemCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set useItemCount(param1:int) : void
      {
         hasField$0 |= 2;
         use_itemCount$field = param1;
      }
      
      public function get useItemCount() : int
      {
         return use_itemCount$field;
      }
      
      public function removeIsDisable() : void
      {
         hasField$0 &= 4294967291;
         is_disable$field = new Boolean();
      }
      
      public function get hasIsDisable() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isDisable(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_disable$field = param1;
      }
      
      public function get isDisable() : Boolean
      {
         return is_disable$field;
      }
      
      public function removeTurnNum() : void
      {
         hasField$0 &= 4294967287;
         turn_num$field = new int();
      }
      
      public function get hasTurnNum() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set turnNum(param1:int) : void
      {
         hasField$0 |= 8;
         turn_num$field = param1;
      }
      
      public function get turnNum() : int
      {
         return turn_num$field;
      }
      
      public function removeParam1() : void
      {
         param1$field = null;
      }
      
      public function get hasParam1() : Boolean
      {
         return param1$field != null;
      }
      
      public function set param1(param1:String) : void
      {
         param1$field = param1;
      }
      
      public function get param1() : String
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      public function removeIsSuccess() : void
      {
         hasField$0 &= 4294967279;
         is_success$field = new Boolean();
      }
      
      public function get hasIsSuccess() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isSuccess(param1:Boolean) : void
      {
         hasField$0 |= 16;
         is_success$field = param1;
      }
      
      public function get isSuccess() : Boolean
      {
         return is_success$field;
      }
      
      public function removeCurrCount() : void
      {
         hasField$0 &= 4294967263;
         curr_count$field = new int();
      }
      
      public function get hasCurrCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set currCount(param1:int) : void
      {
         hasField$0 |= 32;
         curr_count$field = param1;
      }
      
      public function get currCount() : int
      {
         return curr_count$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967231;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 64;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967167;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 128;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasSkillSonType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skill_sonType$field);
         }
         if(hasUseItemCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,use_itemCount$field);
         }
         if(hasIsDisable)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_disable$field);
         }
         if(hasTurnNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,turn_num$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasIsSuccess)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,is_success$field);
         }
         if(hasCurrCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,curr_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < count.length)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,count[_loc2_]);
            _loc2_++;
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.skillSonType cannot be set twice.");
                  }
                  _loc8_++;
                  skillSonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.useItemCount cannot be set twice.");
                  }
                  _loc4_++;
                  useItemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.isDisable cannot be set twice.");
                  }
                  _loc7_++;
                  isDisable = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.turnNum cannot be set twice.");
                  }
                  _loc12_++;
                  turnNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.param2 cannot be set twice.");
                  }
                  _loc13_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.isSuccess cannot be set twice.");
                  }
                  _loc9_++;
                  isSuccess = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.currCount cannot be set twice.");
                  }
                  _loc11_++;
                  currCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if((_loc10_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,count);
                  }
                  else
                  {
                     count.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.payType cannot be set twice.");
                  }
                  _loc5_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FateEditMsg.index cannot be set twice.");
                  }
                  _loc6_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

