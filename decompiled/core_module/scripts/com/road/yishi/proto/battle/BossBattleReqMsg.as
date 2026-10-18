package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BossBattleReqMsg extends Message implements IExternalizable
   {
      
      private var server_name$field:String;
      
      private var hero_job$field:int;
      
      private var hasField$0:uint = 0;
      
      private var sex$field:int;
      
      private var army_id$field:int;
      
      private var templated_id_1$field:int;
      
      private var templated_id_2$field:int;
      
      private var boss_id$field:int;
      
      public function BossBattleReqMsg()
      {
         super();
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeHeroJob() : void
      {
         hasField$0 &= 4294967294;
         hero_job$field = new int();
      }
      
      public function get hasHeroJob() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set heroJob(param1:int) : void
      {
         hasField$0 |= 1;
         hero_job$field = param1;
      }
      
      public function get heroJob() : int
      {
         return hero_job$field;
      }
      
      public function removeSex() : void
      {
         hasField$0 &= 4294967293;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 2;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967291;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 4;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removeTemplatedId_1() : void
      {
         hasField$0 &= 4294967287;
         templated_id_1$field = new int();
      }
      
      public function get hasTemplatedId_1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set templatedId_1(param1:int) : void
      {
         hasField$0 |= 8;
         templated_id_1$field = param1;
      }
      
      public function get templatedId_1() : int
      {
         return templated_id_1$field;
      }
      
      public function removeTemplatedId_2() : void
      {
         hasField$0 &= 4294967279;
         templated_id_2$field = new int();
      }
      
      public function get hasTemplatedId_2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set templatedId_2(param1:int) : void
      {
         hasField$0 |= 16;
         templated_id_2$field = param1;
      }
      
      public function get templatedId_2() : int
      {
         return templated_id_2$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasHeroJob)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,hero_job$field);
         }
         if(hasSex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,sex$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasTemplatedId_1)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,templated_id_1$field);
         }
         if(hasTemplatedId_2)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,templated_id_2$field);
         }
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,boss_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BossBattleReqMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BossBattleReqMsg.heroJob cannot be set twice.");
                  }
                  _loc3_++;
                  heroJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BossBattleReqMsg.sex cannot be set twice.");
                  }
                  _loc7_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BossBattleReqMsg.armyId cannot be set twice.");
                  }
                  _loc5_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BossBattleReqMsg.templatedId_1 cannot be set twice.");
                  }
                  _loc4_++;
                  templatedId_1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BossBattleReqMsg.templatedId_2 cannot be set twice.");
                  }
                  _loc8_++;
                  templatedId_2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BossBattleReqMsg.bossId cannot be set twice.");
                  }
                  _loc6_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

