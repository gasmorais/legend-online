package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaNewBossUserMsg extends Message implements IExternalizable
   {
      
      private var fight_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var fight_max_count$field:int;
      
      private var rank$field:int;
      
      private var damage$field:Int64;
      
      public function ConsortiaNewBossUserMsg()
      {
         super();
      }
      
      public function removeFightCount() : void
      {
         hasField$0 &= 4294967294;
         fight_count$field = new int();
      }
      
      public function get hasFightCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set fightCount(param1:int) : void
      {
         hasField$0 |= 1;
         fight_count$field = param1;
      }
      
      public function get fightCount() : int
      {
         return fight_count$field;
      }
      
      public function removeFightMaxCount() : void
      {
         hasField$0 &= 4294967293;
         fight_max_count$field = new int();
      }
      
      public function get hasFightMaxCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fightMaxCount(param1:int) : void
      {
         hasField$0 |= 2;
         fight_max_count$field = param1;
      }
      
      public function get fightMaxCount() : int
      {
         return fight_max_count$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967291;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 4;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeDamage() : void
      {
         damage$field = null;
      }
      
      public function get hasDamage() : Boolean
      {
         return damage$field != null;
      }
      
      public function set damage(param1:Int64) : void
      {
         damage$field = param1;
      }
      
      public function get damage() : Int64
      {
         return damage$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFightCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,fight_count$field);
         }
         if(hasFightMaxCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,fight_max_count$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasDamage)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,damage$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossUserMsg.fightCount cannot be set twice.");
                  }
                  _loc3_++;
                  fightCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossUserMsg.fightMaxCount cannot be set twice.");
                  }
                  _loc5_++;
                  fightMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossUserMsg.rank cannot be set twice.");
                  }
                  _loc4_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossUserMsg.damage cannot be set twice.");
                  }
                  _loc6_++;
                  damage = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

