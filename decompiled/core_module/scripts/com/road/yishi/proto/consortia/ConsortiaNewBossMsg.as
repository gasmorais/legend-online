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
   
   public final class ConsortiaNewBossMsg extends Message implements IExternalizable
   {
      
      private var pass_level$field:int;
      
      private var hasField$0:uint = 0;
      
      private var max_level$field:int;
      
      private var call_level$field:int;
      
      private var call_count$field:int;
      
      private var call_max_count$field:int;
      
      private var boss_id$field:int;
      
      private var buff$field:int;
      
      private var buff_start_time$field:String;
      
      private var buff_stop_time$field:String;
      
      private var start_time$field:String;
      
      private var stop_time$field:String;
      
      private var buff_buy_count$field:int;
      
      private var best_count$field:int;
      
      private var hp$field:Int64;
      
      private var max_hp$field:Int64;
      
      public function ConsortiaNewBossMsg()
      {
         super();
      }
      
      public function removePassLevel() : void
      {
         hasField$0 &= 4294967294;
         pass_level$field = new int();
      }
      
      public function get hasPassLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set passLevel(param1:int) : void
      {
         hasField$0 |= 1;
         pass_level$field = param1;
      }
      
      public function get passLevel() : int
      {
         return pass_level$field;
      }
      
      public function removeMaxLevel() : void
      {
         hasField$0 &= 4294967293;
         max_level$field = new int();
      }
      
      public function get hasMaxLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxLevel(param1:int) : void
      {
         hasField$0 |= 2;
         max_level$field = param1;
      }
      
      public function get maxLevel() : int
      {
         return max_level$field;
      }
      
      public function removeCallLevel() : void
      {
         hasField$0 &= 4294967291;
         call_level$field = new int();
      }
      
      public function get hasCallLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set callLevel(param1:int) : void
      {
         hasField$0 |= 4;
         call_level$field = param1;
      }
      
      public function get callLevel() : int
      {
         return call_level$field;
      }
      
      public function removeCallCount() : void
      {
         hasField$0 &= 4294967287;
         call_count$field = new int();
      }
      
      public function get hasCallCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set callCount(param1:int) : void
      {
         hasField$0 |= 8;
         call_count$field = param1;
      }
      
      public function get callCount() : int
      {
         return call_count$field;
      }
      
      public function removeCallMaxCount() : void
      {
         hasField$0 &= 4294967279;
         call_max_count$field = new int();
      }
      
      public function get hasCallMaxCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set callMaxCount(param1:int) : void
      {
         hasField$0 |= 16;
         call_max_count$field = param1;
      }
      
      public function get callMaxCount() : int
      {
         return call_max_count$field;
      }
      
      public function removeBossId() : void
      {
         hasField$0 &= 4294967263;
         boss_id$field = new int();
      }
      
      public function get hasBossId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set bossId(param1:int) : void
      {
         hasField$0 |= 32;
         boss_id$field = param1;
      }
      
      public function get bossId() : int
      {
         return boss_id$field;
      }
      
      public function removeBuff() : void
      {
         hasField$0 &= 4294967231;
         buff$field = new int();
      }
      
      public function get hasBuff() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set buff(param1:int) : void
      {
         hasField$0 |= 64;
         buff$field = param1;
      }
      
      public function get buff() : int
      {
         return buff$field;
      }
      
      public function removeBuffStartTime() : void
      {
         buff_start_time$field = null;
      }
      
      public function get hasBuffStartTime() : Boolean
      {
         return buff_start_time$field != null;
      }
      
      public function set buffStartTime(param1:String) : void
      {
         buff_start_time$field = param1;
      }
      
      public function get buffStartTime() : String
      {
         return buff_start_time$field;
      }
      
      public function removeBuffStopTime() : void
      {
         buff_stop_time$field = null;
      }
      
      public function get hasBuffStopTime() : Boolean
      {
         return buff_stop_time$field != null;
      }
      
      public function set buffStopTime(param1:String) : void
      {
         buff_stop_time$field = param1;
      }
      
      public function get buffStopTime() : String
      {
         return buff_stop_time$field;
      }
      
      public function removeStartTime() : void
      {
         start_time$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return start_time$field != null;
      }
      
      public function set startTime(param1:String) : void
      {
         start_time$field = param1;
      }
      
      public function get startTime() : String
      {
         return start_time$field;
      }
      
      public function removeStopTime() : void
      {
         stop_time$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stop_time$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stop_time$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stop_time$field;
      }
      
      public function removeBuffBuyCount() : void
      {
         hasField$0 &= 4294967167;
         buff_buy_count$field = new int();
      }
      
      public function get hasBuffBuyCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set buffBuyCount(param1:int) : void
      {
         hasField$0 |= 128;
         buff_buy_count$field = param1;
      }
      
      public function get buffBuyCount() : int
      {
         return buff_buy_count$field;
      }
      
      public function removeBestCount() : void
      {
         hasField$0 &= 4294967039;
         best_count$field = new int();
      }
      
      public function get hasBestCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set bestCount(param1:int) : void
      {
         hasField$0 |= 256;
         best_count$field = param1;
      }
      
      public function get bestCount() : int
      {
         return best_count$field;
      }
      
      public function removeHp() : void
      {
         hp$field = null;
      }
      
      public function get hasHp() : Boolean
      {
         return hp$field != null;
      }
      
      public function set hp(param1:Int64) : void
      {
         hp$field = param1;
      }
      
      public function get hp() : Int64
      {
         return hp$field;
      }
      
      public function removeMaxHp() : void
      {
         max_hp$field = null;
      }
      
      public function get hasMaxHp() : Boolean
      {
         return max_hp$field != null;
      }
      
      public function set maxHp(param1:Int64) : void
      {
         max_hp$field = param1;
      }
      
      public function get maxHp() : Int64
      {
         return max_hp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPassLevel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pass_level$field);
         }
         if(hasMaxLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,max_level$field);
         }
         if(hasCallLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,call_level$field);
         }
         if(hasCallCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,call_count$field);
         }
         if(hasCallMaxCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,call_max_count$field);
         }
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,boss_id$field);
         }
         if(hasBuff)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,buff$field);
         }
         if(hasBuffStartTime)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,buff_start_time$field);
         }
         if(hasBuffStopTime)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,buff_stop_time$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,start_time$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,stop_time$field);
         }
         if(hasBuffBuyCount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,buff_buy_count$field);
         }
         if(hasBestCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,best_count$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT64(param1,hp$field);
         }
         if(hasMaxHp)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT64(param1,max_hp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc18_:uint = 0;
         var _loc15_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc16_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.passLevel cannot be set twice.");
                  }
                  _loc7_++;
                  passLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.maxLevel cannot be set twice.");
                  }
                  _loc8_++;
                  maxLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.callLevel cannot be set twice.");
                  }
                  _loc11_++;
                  callLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.callCount cannot be set twice.");
                  }
                  _loc12_++;
                  callCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.callMaxCount cannot be set twice.");
                  }
                  _loc18_++;
                  callMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.bossId cannot be set twice.");
                  }
                  _loc15_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.buff cannot be set twice.");
                  }
                  _loc13_++;
                  buff = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.buffStartTime cannot be set twice.");
                  }
                  _loc4_++;
                  buffStartTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.buffStopTime cannot be set twice.");
                  }
                  _loc14_++;
                  buffStopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.startTime cannot be set twice.");
                  }
                  _loc3_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.stopTime cannot be set twice.");
                  }
                  _loc9_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.buffBuyCount cannot be set twice.");
                  }
                  _loc5_++;
                  buffBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.bestCount cannot be set twice.");
                  }
                  _loc10_++;
                  bestCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.hp cannot be set twice.");
                  }
                  _loc16_++;
                  hp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 14:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaNewBossMsg.maxHp cannot be set twice.");
                  }
                  _loc6_++;
                  maxHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

