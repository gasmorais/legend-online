package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerOrderMsg extends Message implements IExternalizable
   {
      
      private var player_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var fight_capacity_order$field:int;
      
      private var geste_Order$field:int;
      
      private var charm_Order$field:int;
      
      private var soul_score_Order$field:int;
      
      public function PlayerOrderMsg()
      {
         super();
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967294;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 1;
         player_id$field = param1;
      }
      
      public function get playerId() : int
      {
         return player_id$field;
      }
      
      public function removeFightCapacityOrder() : void
      {
         hasField$0 &= 4294967293;
         fight_capacity_order$field = new int();
      }
      
      public function get hasFightCapacityOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fightCapacityOrder(param1:int) : void
      {
         hasField$0 |= 2;
         fight_capacity_order$field = param1;
      }
      
      public function get fightCapacityOrder() : int
      {
         return fight_capacity_order$field;
      }
      
      public function removeGeste_Order() : void
      {
         hasField$0 &= 4294967291;
         geste_Order$field = new int();
      }
      
      public function get hasGeste_Order() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set geste_Order(param1:int) : void
      {
         hasField$0 |= 4;
         geste_Order$field = param1;
      }
      
      public function get geste_Order() : int
      {
         return geste_Order$field;
      }
      
      public function removeCharm_Order() : void
      {
         hasField$0 &= 4294967287;
         charm_Order$field = new int();
      }
      
      public function get hasCharm_Order() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set charm_Order(param1:int) : void
      {
         hasField$0 |= 8;
         charm_Order$field = param1;
      }
      
      public function get charm_Order() : int
      {
         return charm_Order$field;
      }
      
      public function removeSoulScore_Order() : void
      {
         hasField$0 &= 4294967279;
         soul_score_Order$field = new int();
      }
      
      public function get hasSoulScore_Order() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set soulScore_Order(param1:int) : void
      {
         hasField$0 |= 16;
         soul_score_Order$field = param1;
      }
      
      public function get soulScore_Order() : int
      {
         return soul_score_Order$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasFightCapacityOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,fight_capacity_order$field);
         }
         if(hasGeste_Order)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,geste_Order$field);
         }
         if(hasCharm_Order)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,charm_Order$field);
         }
         if(hasSoulScore_Order)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,soul_score_Order$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOrderMsg.playerId cannot be set twice.");
                  }
                  _loc4_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOrderMsg.fightCapacityOrder cannot be set twice.");
                  }
                  _loc6_++;
                  fightCapacityOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOrderMsg.geste_Order cannot be set twice.");
                  }
                  _loc7_++;
                  geste_Order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOrderMsg.charm_Order cannot be set twice.");
                  }
                  _loc5_++;
                  charm_Order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOrderMsg.soulScore_Order cannot be set twice.");
                  }
                  _loc3_++;
                  soulScore_Order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

