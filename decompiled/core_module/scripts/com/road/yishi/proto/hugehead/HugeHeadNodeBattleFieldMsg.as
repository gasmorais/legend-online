package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadNodeBattleFieldMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var battle_field_uid$field:String;
      
      private var node_id$field:int;
      
      private var attack_force$field:int;
      
      private var attack_score$field:int;
      
      private var attack_count$field:int;
      
      private var defence_force$field:int;
      
      private var defence_score$field:int;
      
      private var defence_count$field:int;
      
      private var battle_start_time$field:Int64;
      
      private var battle_end_time$field:Int64;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadNodeBattleAreaMsg")]
      public var areaList:Array = [];
      
      private var node_state$field:int;
      
      public function HugeHeadNodeBattleFieldMsg()
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
      
      public function removeBattleFieldUid() : void
      {
         battle_field_uid$field = null;
      }
      
      public function get hasBattleFieldUid() : Boolean
      {
         return battle_field_uid$field != null;
      }
      
      public function set battleFieldUid(param1:String) : void
      {
         battle_field_uid$field = param1;
      }
      
      public function get battleFieldUid() : String
      {
         return battle_field_uid$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967293;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 2;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeAttackForce() : void
      {
         hasField$0 &= 4294967291;
         attack_force$field = new int();
      }
      
      public function get hasAttackForce() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set attackForce(param1:int) : void
      {
         hasField$0 |= 4;
         attack_force$field = param1;
      }
      
      public function get attackForce() : int
      {
         return attack_force$field;
      }
      
      public function removeAttackScore() : void
      {
         hasField$0 &= 4294967287;
         attack_score$field = new int();
      }
      
      public function get hasAttackScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attackScore(param1:int) : void
      {
         hasField$0 |= 8;
         attack_score$field = param1;
      }
      
      public function get attackScore() : int
      {
         return attack_score$field;
      }
      
      public function removeAttackCount() : void
      {
         hasField$0 &= 4294967279;
         attack_count$field = new int();
      }
      
      public function get hasAttackCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set attackCount(param1:int) : void
      {
         hasField$0 |= 16;
         attack_count$field = param1;
      }
      
      public function get attackCount() : int
      {
         return attack_count$field;
      }
      
      public function removeDefenceForce() : void
      {
         hasField$0 &= 4294967263;
         defence_force$field = new int();
      }
      
      public function get hasDefenceForce() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set defenceForce(param1:int) : void
      {
         hasField$0 |= 32;
         defence_force$field = param1;
      }
      
      public function get defenceForce() : int
      {
         return defence_force$field;
      }
      
      public function removeDefenceScore() : void
      {
         hasField$0 &= 4294967231;
         defence_score$field = new int();
      }
      
      public function get hasDefenceScore() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set defenceScore(param1:int) : void
      {
         hasField$0 |= 64;
         defence_score$field = param1;
      }
      
      public function get defenceScore() : int
      {
         return defence_score$field;
      }
      
      public function removeDefenceCount() : void
      {
         hasField$0 &= 4294967167;
         defence_count$field = new int();
      }
      
      public function get hasDefenceCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set defenceCount(param1:int) : void
      {
         hasField$0 |= 128;
         defence_count$field = param1;
      }
      
      public function get defenceCount() : int
      {
         return defence_count$field;
      }
      
      public function removeBattleStartTime() : void
      {
         battle_start_time$field = null;
      }
      
      public function get hasBattleStartTime() : Boolean
      {
         return battle_start_time$field != null;
      }
      
      public function set battleStartTime(param1:Int64) : void
      {
         battle_start_time$field = param1;
      }
      
      public function get battleStartTime() : Int64
      {
         return battle_start_time$field;
      }
      
      public function removeBattleEndTime() : void
      {
         battle_end_time$field = null;
      }
      
      public function get hasBattleEndTime() : Boolean
      {
         return battle_end_time$field != null;
      }
      
      public function set battleEndTime(param1:Int64) : void
      {
         battle_end_time$field = param1;
      }
      
      public function get battleEndTime() : Int64
      {
         return battle_end_time$field;
      }
      
      public function removeNodeState() : void
      {
         hasField$0 &= 4294967039;
         node_state$field = new int();
      }
      
      public function get hasNodeState() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set nodeState(param1:int) : void
      {
         hasField$0 |= 256;
         node_state$field = param1;
      }
      
      public function get nodeState() : int
      {
         return node_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasBattleFieldUid)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,battle_field_uid$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasAttackForce)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,attack_force$field);
         }
         if(hasAttackScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,attack_score$field);
         }
         if(hasAttackCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,attack_count$field);
         }
         if(hasDefenceForce)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,defence_force$field);
         }
         if(hasDefenceScore)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,defence_score$field);
         }
         if(hasDefenceCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,defence_count$field);
         }
         if(hasBattleStartTime)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT64(param1,battle_start_time$field);
         }
         if(hasBattleEndTime)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT64(param1,battle_end_time$field);
         }
         _loc2_ = 0;
         while(_loc2_ < areaList.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,areaList[_loc2_]);
            _loc2_++;
         }
         if(hasNodeState)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,node_state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc11_:HugeHeadNodeBattleAreaMsg = null;
         var _loc15_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc16_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.op cannot be set twice.");
                  }
                  _loc15_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.battleFieldUid cannot be set twice.");
                  }
                  _loc5_++;
                  battleFieldUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.nodeId cannot be set twice.");
                  }
                  _loc8_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.attackForce cannot be set twice.");
                  }
                  _loc16_++;
                  attackForce = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.attackScore cannot be set twice.");
                  }
                  _loc13_++;
                  attackScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.attackCount cannot be set twice.");
                  }
                  _loc7_++;
                  attackCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.defenceForce cannot be set twice.");
                  }
                  _loc12_++;
                  defenceForce = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.defenceScore cannot be set twice.");
                  }
                  _loc9_++;
                  defenceScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.defenceCount cannot be set twice.");
                  }
                  _loc10_++;
                  defenceCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.battleStartTime cannot be set twice.");
                  }
                  _loc3_++;
                  battleStartTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.battleEndTime cannot be set twice.");
                  }
                  _loc4_++;
                  battleEndTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 11:
                  _loc11_ = new HugeHeadNodeBattleAreaMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  areaList.push(_loc11_);
                  break;
               case 12:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleFieldMsg.nodeState cannot be set twice.");
                  }
                  _loc6_++;
                  nodeState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

