package com.road.yishi.proto.shuttle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShuttleRequestMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("int")]
      public var petList:Array = [];
      
      private var fight_pet$field:int;
      
      private var difficulty$field:int;
      
      private var area$field:int;
      
      private var reward_index$field:int;
      
      private var pay_type$field:int;
      
      public function ShuttleRequestMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeFightPet() : void
      {
         hasField$0 &= 4294967293;
         fight_pet$field = new int();
      }
      
      public function get hasFightPet() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fightPet(param1:int) : void
      {
         hasField$0 |= 2;
         fight_pet$field = param1;
      }
      
      public function get fightPet() : int
      {
         return fight_pet$field;
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967291;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 4;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      public function removeArea() : void
      {
         hasField$0 &= 4294967287;
         area$field = new int();
      }
      
      public function get hasArea() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set area(param1:int) : void
      {
         hasField$0 |= 8;
         area$field = param1;
      }
      
      public function get area() : int
      {
         return area$field;
      }
      
      public function removeRewardIndex() : void
      {
         hasField$0 &= 4294967279;
         reward_index$field = new int();
      }
      
      public function get hasRewardIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rewardIndex(param1:int) : void
      {
         hasField$0 |= 16;
         reward_index$field = param1;
      }
      
      public function get rewardIndex() : int
      {
         return reward_index$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967263;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 32;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         _loc2_ = 0;
         while(_loc2_ < petList.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,petList[_loc2_]);
            _loc2_++;
         }
         if(hasFightPet)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fight_pet$field);
         }
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         if(hasArea)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,area$field);
         }
         if(hasRewardIndex)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,reward_index$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleRequestMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,petList);
                  }
                  else
                  {
                     petList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleRequestMsg.fightPet cannot be set twice.");
                  }
                  _loc3_++;
                  fightPet = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleRequestMsg.difficulty cannot be set twice.");
                  }
                  _loc9_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleRequestMsg.area cannot be set twice.");
                  }
                  _loc8_++;
                  area = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleRequestMsg.rewardIndex cannot be set twice.");
                  }
                  _loc4_++;
                  rewardIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleRequestMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

