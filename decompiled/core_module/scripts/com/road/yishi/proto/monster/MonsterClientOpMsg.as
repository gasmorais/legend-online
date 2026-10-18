package com.road.yishi.proto.monster
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterClientOpMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var monsterId$field:int;
      
      private var skillId$field:int;
      
      private var index$field:int;
      
      private var payType$field:int;
      
      [ArrayElementType("int")]
      public var items:Array = [];
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:String;
      
      private var param4$field:String;
      
      public function MonsterClientOpMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeMonsterId() : void
      {
         hasField$0 &= 4294967293;
         monsterId$field = new int();
      }
      
      public function get hasMonsterId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set monsterId(param1:int) : void
      {
         hasField$0 |= 2;
         monsterId$field = param1;
      }
      
      public function get monsterId() : int
      {
         return monsterId$field;
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967291;
         skillId$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 4;
         skillId$field = param1;
      }
      
      public function get skillId() : int
      {
         return skillId$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967287;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 8;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967279;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 16;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967263;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 32;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967231;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 64;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         param3$field = null;
      }
      
      public function get hasParam3() : Boolean
      {
         return param3$field != null;
      }
      
      public function set param3(param1:String) : void
      {
         param3$field = param1;
      }
      
      public function get param3() : String
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         param4$field = null;
      }
      
      public function get hasParam4() : Boolean
      {
         return param4$field != null;
      }
      
      public function set param4(param1:String) : void
      {
         param4$field = param1;
      }
      
      public function get param4() : String
      {
         return param4$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasMonsterId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,monsterId$field);
         }
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,skillId$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,items[_loc2_]);
            _loc2_++;
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,param4$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterClientOpMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterClientOpMsg.monsterId cannot be set twice.");
                  }
                  _loc11_++;
                  monsterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterClientOpMsg.skillId cannot be set twice.");
                  }
                  _loc8_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterClientOpMsg.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterClientOpMsg.payType cannot be set twice.");
                  }
                  _loc5_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if((_loc9_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,items);
                  }
                  else
                  {
                     items.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterClientOpMsg.param1 cannot be set twice.");
                  }
                  _loc6_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterClientOpMsg.param2 cannot be set twice.");
                  }
                  _loc12_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterClientOpMsg.param3 cannot be set twice.");
                  }
                  _loc7_++;
                  param3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterClientOpMsg.param4 cannot be set twice.");
                  }
                  _loc10_++;
                  param4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

