package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadNodeBattleAreaMsg extends Message implements IExternalizable
   {
      
      private var pos$field:int;
      
      private var hasField$0:uint = 0;
      
      private var belong_force$field:int;
      
      private var attack_count$field:int;
      
      private var defence_count$field:int;
      
      public var posArr:Array = [];
      
      public var lineArr:Array = [];
      
      public function HugeHeadNodeBattleAreaMsg()
      {
         super();
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967294;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 1;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeBelongForce() : void
      {
         hasField$0 &= 4294967293;
         belong_force$field = new int();
      }
      
      public function get hasBelongForce() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set belongForce(param1:int) : void
      {
         hasField$0 |= 2;
         belong_force$field = param1;
      }
      
      public function get belongForce() : int
      {
         return belong_force$field;
      }
      
      public function removeAttackCount() : void
      {
         hasField$0 &= 4294967291;
         attack_count$field = new int();
      }
      
      public function get hasAttackCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set attackCount(param1:int) : void
      {
         hasField$0 |= 4;
         attack_count$field = param1;
      }
      
      public function get attackCount() : int
      {
         return attack_count$field;
      }
      
      public function removeDefenceCount() : void
      {
         hasField$0 &= 4294967287;
         defence_count$field = new int();
      }
      
      public function get hasDefenceCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set defenceCount(param1:int) : void
      {
         hasField$0 |= 8;
         defence_count$field = param1;
      }
      
      public function get defenceCount() : int
      {
         return defence_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasBelongForce)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,belong_force$field);
         }
         if(hasAttackCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,attack_count$field);
         }
         if(hasDefenceCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,defence_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleAreaMsg.pos cannot be set twice.");
                  }
                  _loc4_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleAreaMsg.belongForce cannot be set twice.");
                  }
                  _loc7_++;
                  belongForce = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleAreaMsg.attackCount cannot be set twice.");
                  }
                  _loc5_++;
                  attackCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleAreaMsg.defenceCount cannot be set twice.");
                  }
                  _loc3_++;
                  defenceCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

