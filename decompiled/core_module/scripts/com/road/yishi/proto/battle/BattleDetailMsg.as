package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BattleDetailMsg extends Message implements IExternalizable
   {
      
      private var battle_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var boss_id$field:int;
      
      private var boss_hp$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.FightPlayer")]
      public var fightPlayer:Array = [];
      
      public function BattleDetailMsg()
      {
         super();
      }
      
      public function removeBattleId() : void
      {
         hasField$0 &= 4294967294;
         battle_id$field = new int();
      }
      
      public function get hasBattleId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set battleId(param1:int) : void
      {
         hasField$0 |= 1;
         battle_id$field = param1;
      }
      
      public function get battleId() : int
      {
         return battle_id$field;
      }
      
      public function removeBossId() : void
      {
         hasField$0 &= 4294967293;
         boss_id$field = new int();
      }
      
      public function get hasBossId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bossId(param1:int) : void
      {
         hasField$0 |= 2;
         boss_id$field = param1;
      }
      
      public function get bossId() : int
      {
         return boss_id$field;
      }
      
      public function removeBossHp() : void
      {
         hasField$0 &= 4294967291;
         boss_hp$field = new int();
      }
      
      public function get hasBossHp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set bossHp(param1:int) : void
      {
         hasField$0 |= 4;
         boss_hp$field = param1;
      }
      
      public function get bossHp() : int
      {
         return boss_hp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,battle_id$field);
         }
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,boss_id$field);
         }
         if(hasBossHp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,boss_hp$field);
         }
         _loc2_ = 0;
         while(_loc2_ < fightPlayer.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,fightPlayer[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:FightPlayer = null;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BattleDetailMsg.battleId cannot be set twice.");
                  }
                  _loc6_++;
                  battleId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BattleDetailMsg.bossId cannot be set twice.");
                  }
                  _loc3_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BattleDetailMsg.bossHp cannot be set twice.");
                  }
                  _loc7_++;
                  bossHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc4_ = new FightPlayer();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  fightPlayer.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

