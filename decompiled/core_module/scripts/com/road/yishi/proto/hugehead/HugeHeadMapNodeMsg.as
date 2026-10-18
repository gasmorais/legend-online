package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadMapNodeMsg extends Message implements IExternalizable
   {
      
      private var node_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var force_index$field:int;
      
      private var node_state$field:int;
      
      private var battle_start_time$field:Int64;
      
      private var battle_end_time$field:Int64;
      
      private var attack_force$field:int;
      
      private var defence_force$field:int;
      
      private var attack_count$field:int;
      
      private var defence_count$field:int;
      
      public function HugeHeadMapNodeMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeForceIndex() : void
      {
         hasField$0 &= 4294967293;
         force_index$field = new int();
      }
      
      public function get hasForceIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set forceIndex(param1:int) : void
      {
         hasField$0 |= 2;
         force_index$field = param1;
      }
      
      public function get forceIndex() : int
      {
         return force_index$field;
      }
      
      public function removeNodeState() : void
      {
         hasField$0 &= 4294967291;
         node_state$field = new int();
      }
      
      public function get hasNodeState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set nodeState(param1:int) : void
      {
         hasField$0 |= 4;
         node_state$field = param1;
      }
      
      public function get nodeState() : int
      {
         return node_state$field;
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
      
      public function removeAttackForce() : void
      {
         hasField$0 &= 4294967287;
         attack_force$field = new int();
      }
      
      public function get hasAttackForce() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attackForce(param1:int) : void
      {
         hasField$0 |= 8;
         attack_force$field = param1;
      }
      
      public function get attackForce() : int
      {
         return attack_force$field;
      }
      
      public function removeDefenceForce() : void
      {
         hasField$0 &= 4294967279;
         defence_force$field = new int();
      }
      
      public function get hasDefenceForce() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set defenceForce(param1:int) : void
      {
         hasField$0 |= 16;
         defence_force$field = param1;
      }
      
      public function get defenceForce() : int
      {
         return defence_force$field;
      }
      
      public function removeAttackCount() : void
      {
         hasField$0 &= 4294967263;
         attack_count$field = new int();
      }
      
      public function get hasAttackCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set attackCount(param1:int) : void
      {
         hasField$0 |= 32;
         attack_count$field = param1;
      }
      
      public function get attackCount() : int
      {
         return attack_count$field;
      }
      
      public function removeDefenceCount() : void
      {
         hasField$0 &= 4294967231;
         defence_count$field = new int();
      }
      
      public function get hasDefenceCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set defenceCount(param1:int) : void
      {
         hasField$0 |= 64;
         defence_count$field = param1;
      }
      
      public function get defenceCount() : int
      {
         return defence_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasForceIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,force_index$field);
         }
         if(hasNodeState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,node_state$field);
         }
         if(hasBattleStartTime)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,battle_start_time$field);
         }
         if(hasBattleEndTime)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,battle_end_time$field);
         }
         if(hasAttackForce)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,attack_force$field);
         }
         if(hasDefenceForce)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,defence_force$field);
         }
         if(hasAttackCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,attack_count$field);
         }
         if(hasDefenceCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,defence_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMapNodeMsg.nodeId cannot be set twice.");
                  }
                  _loc9_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMapNodeMsg.forceIndex cannot be set twice.");
                  }
                  _loc11_++;
                  forceIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMapNodeMsg.nodeState cannot be set twice.");
                  }
                  _loc7_++;
                  nodeState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMapNodeMsg.battleStartTime cannot be set twice.");
                  }
                  _loc3_++;
                  battleStartTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMapNodeMsg.battleEndTime cannot be set twice.");
                  }
                  _loc6_++;
                  battleEndTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMapNodeMsg.attackForce cannot be set twice.");
                  }
                  _loc12_++;
                  attackForce = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMapNodeMsg.defenceForce cannot be set twice.");
                  }
                  _loc5_++;
                  defenceForce = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMapNodeMsg.attackCount cannot be set twice.");
                  }
                  _loc8_++;
                  attackCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMapNodeMsg.defenceCount cannot be set twice.");
                  }
                  _loc4_++;
                  defenceCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

