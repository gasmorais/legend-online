package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BattleNoticeMsg extends Message implements IExternalizable
   {
      
      private var battle_id$field:String;
      
      private var count_down$field:int;
      
      private var hasField$0:uint = 0;
      
      private var damage_improve$field:int;
      
      private var damage_addition$field:int;
      
      public function BattleNoticeMsg()
      {
         super();
      }
      
      public function removeBattleId() : void
      {
         battle_id$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battle_id$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battle_id$field = param1;
      }
      
      public function get battleId() : String
      {
         return battle_id$field;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294967294;
         count_down$field = new int();
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set countDown(param1:int) : void
      {
         hasField$0 |= 1;
         count_down$field = param1;
      }
      
      public function get countDown() : int
      {
         return count_down$field;
      }
      
      public function removeDamageImprove() : void
      {
         hasField$0 &= 4294967293;
         damage_improve$field = new int();
      }
      
      public function get hasDamageImprove() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set damageImprove(param1:int) : void
      {
         hasField$0 |= 2;
         damage_improve$field = param1;
      }
      
      public function get damageImprove() : int
      {
         return damage_improve$field;
      }
      
      public function removeDamageAddition() : void
      {
         hasField$0 &= 4294967291;
         damage_addition$field = new int();
      }
      
      public function get hasDamageAddition() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set damageAddition(param1:int) : void
      {
         hasField$0 |= 4;
         damage_addition$field = param1;
      }
      
      public function get damageAddition() : int
      {
         return damage_addition$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,battle_id$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,count_down$field);
         }
         if(hasDamageImprove)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,damage_improve$field);
         }
         if(hasDamageAddition)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,damage_addition$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BattleNoticeMsg.battleId cannot be set twice.");
                  }
                  _loc7_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BattleNoticeMsg.countDown cannot be set twice.");
                  }
                  _loc3_++;
                  countDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BattleNoticeMsg.damageImprove cannot be set twice.");
                  }
                  _loc4_++;
                  damageImprove = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BattleNoticeMsg.damageAddition cannot be set twice.");
                  }
                  _loc5_++;
                  damageAddition = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

