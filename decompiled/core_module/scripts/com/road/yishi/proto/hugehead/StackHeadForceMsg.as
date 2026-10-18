package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadForceMsg extends Message implements IExternalizable
   {
      
      private var force_index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var attack_buff_level$field:int;
      
      private var defence_buff_level$field:int;
      
      private var defence_alive_count$field:int;
      
      private var defence_total_count$field:int;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.StackHeadSeniorGeneralMsg")]
      public var defenceSeniorGeneral:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.hugehead.StackHeadUserMsg")]
      public var userList:Array = [];
      
      public function StackHeadForceMsg()
      {
         super();
      }
      
      public function removeForceIndex() : void
      {
         hasField$0 &= 4294967294;
         force_index$field = new int();
      }
      
      public function get hasForceIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set forceIndex(param1:int) : void
      {
         hasField$0 |= 1;
         force_index$field = param1;
      }
      
      public function get forceIndex() : int
      {
         return force_index$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeAttackBuffLevel() : void
      {
         hasField$0 &= 4294967291;
         attack_buff_level$field = new int();
      }
      
      public function get hasAttackBuffLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set attackBuffLevel(param1:int) : void
      {
         hasField$0 |= 4;
         attack_buff_level$field = param1;
      }
      
      public function get attackBuffLevel() : int
      {
         return attack_buff_level$field;
      }
      
      public function removeDefenceBuffLevel() : void
      {
         hasField$0 &= 4294967287;
         defence_buff_level$field = new int();
      }
      
      public function get hasDefenceBuffLevel() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set defenceBuffLevel(param1:int) : void
      {
         hasField$0 |= 8;
         defence_buff_level$field = param1;
      }
      
      public function get defenceBuffLevel() : int
      {
         return defence_buff_level$field;
      }
      
      public function removeDefenceAliveCount() : void
      {
         hasField$0 &= 4294967279;
         defence_alive_count$field = new int();
      }
      
      public function get hasDefenceAliveCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set defenceAliveCount(param1:int) : void
      {
         hasField$0 |= 16;
         defence_alive_count$field = param1;
      }
      
      public function get defenceAliveCount() : int
      {
         return defence_alive_count$field;
      }
      
      public function removeDefenceTotalCount() : void
      {
         hasField$0 &= 4294967263;
         defence_total_count$field = new int();
      }
      
      public function get hasDefenceTotalCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set defenceTotalCount(param1:int) : void
      {
         hasField$0 |= 32;
         defence_total_count$field = param1;
      }
      
      public function get defenceTotalCount() : int
      {
         return defence_total_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasForceIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,force_index$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasAttackBuffLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,attack_buff_level$field);
         }
         if(hasDefenceBuffLevel)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,defence_buff_level$field);
         }
         if(hasDefenceAliveCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,defence_alive_count$field);
         }
         if(hasDefenceTotalCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,defence_total_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < defenceSeniorGeneral.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,defenceSeniorGeneral[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < userList.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,userList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:StackHeadSeniorGeneralMsg = null;
         var _loc4_:StackHeadUserMsg = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceMsg.forceIndex cannot be set twice.");
                  }
                  _loc8_++;
                  forceIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceMsg.score cannot be set twice.");
                  }
                  _loc9_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceMsg.attackBuffLevel cannot be set twice.");
                  }
                  _loc10_++;
                  attackBuffLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceMsg.defenceBuffLevel cannot be set twice.");
                  }
                  _loc11_++;
                  defenceBuffLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceMsg.defenceAliveCount cannot be set twice.");
                  }
                  _loc6_++;
                  defenceAliveCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadForceMsg.defenceTotalCount cannot be set twice.");
                  }
                  _loc5_++;
                  defenceTotalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc3_ = new StackHeadSeniorGeneralMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  defenceSeniorGeneral.push(_loc3_);
                  break;
               case 7:
                  _loc4_ = new StackHeadUserMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  userList.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

