package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RoomBossInfoMsg extends Message implements IExternalizable
   {
      
      private var boss_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var boss_type$field:int;
      
      private var cur_hp$field:Int64;
      
      private var total_hp$field:Int64;
      
      private var current_millis$field:Int64;
      
      [ArrayElementType("com.road.yishi.proto.simple.WoundInfoMsg")]
      public var woundInfo:Array = [];
      
      public function RoomBossInfoMsg()
      {
         super();
      }
      
      public function removeBossId() : void
      {
         hasField$0 &= 4294967294;
         boss_id$field = new int();
      }
      
      public function get hasBossId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bossId(param1:int) : void
      {
         hasField$0 |= 1;
         boss_id$field = param1;
      }
      
      public function get bossId() : int
      {
         return boss_id$field;
      }
      
      public function removeBossType() : void
      {
         hasField$0 &= 4294967293;
         boss_type$field = new int();
      }
      
      public function get hasBossType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bossType(param1:int) : void
      {
         hasField$0 |= 2;
         boss_type$field = param1;
      }
      
      public function get bossType() : int
      {
         return boss_type$field;
      }
      
      public function removeCurHp() : void
      {
         cur_hp$field = null;
      }
      
      public function get hasCurHp() : Boolean
      {
         return cur_hp$field != null;
      }
      
      public function set curHp(param1:Int64) : void
      {
         cur_hp$field = param1;
      }
      
      public function get curHp() : Int64
      {
         return cur_hp$field;
      }
      
      public function removeTotalHp() : void
      {
         total_hp$field = null;
      }
      
      public function get hasTotalHp() : Boolean
      {
         return total_hp$field != null;
      }
      
      public function set totalHp(param1:Int64) : void
      {
         total_hp$field = param1;
      }
      
      public function get totalHp() : Int64
      {
         return total_hp$field;
      }
      
      public function removeCurrentMillis() : void
      {
         current_millis$field = null;
      }
      
      public function get hasCurrentMillis() : Boolean
      {
         return current_millis$field != null;
      }
      
      public function set currentMillis(param1:Int64) : void
      {
         current_millis$field = param1;
      }
      
      public function get currentMillis() : Int64
      {
         return current_millis$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,boss_id$field);
         }
         if(hasBossType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,boss_type$field);
         }
         if(hasCurHp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,cur_hp$field);
         }
         if(hasTotalHp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,total_hp$field);
         }
         if(hasCurrentMillis)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,current_millis$field);
         }
         _loc2_ = 0;
         while(_loc2_ < woundInfo.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,woundInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:WoundInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RoomBossInfoMsg.bossId cannot be set twice.");
                  }
                  _loc3_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RoomBossInfoMsg.bossType cannot be set twice.");
                  }
                  _loc4_++;
                  bossType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RoomBossInfoMsg.curHp cannot be set twice.");
                  }
                  _loc8_++;
                  curHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RoomBossInfoMsg.totalHp cannot be set twice.");
                  }
                  _loc9_++;
                  totalHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RoomBossInfoMsg.currentMillis cannot be set twice.");
                  }
                  _loc5_++;
                  currentMillis = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  _loc7_ = new WoundInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  woundInfo.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

