package com.road.yishi.proto.childpatrol
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildPatrolTowerMsg extends Message implements IExternalizable
   {
      
      private var tower_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var level$field:int;
      
      private var exp$field:int;
      
      [ArrayElementType("int")]
      public var garrisonChildIdList:Array = [];
      
      private var garrison_start_time$field:Int64;
      
      private var garrison_end_time$field:Int64;
      
      [ArrayElementType("int")]
      public var patrolChildIdList:Array = [];
      
      private var patrol_start_time$field:Int64;
      
      private var patrol_end_time$field:Int64;
      
      private var normal_mission_id$field:int;
      
      private var normal_mission_reached$field:Boolean;
      
      private var hard_mission_id$field:int;
      
      private var hard_mission_reached$field:Boolean;
      
      private var nightmare_mission_id$field:int;
      
      private var nightmare_mission_reached$field:Boolean;
      
      private var garrison_exp_per_minute$field:int;
      
      private var on_garrison$field:Boolean;
      
      private var garrison_count_down$field:Int64;
      
      private var patrol_count_down$field:Int64;
      
      private var explore_child_id$field:int;
      
      private var explore_count_down$field:Int64;
      
      private var boss_id$field:int;
      
      private var boss_stats$field:int;
      
      public function ChildPatrolTowerMsg()
      {
         super();
      }
      
      public function removeTowerId() : void
      {
         hasField$0 &= 4294967294;
         tower_id$field = new int();
      }
      
      public function get hasTowerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set towerId(param1:int) : void
      {
         hasField$0 |= 1;
         tower_id$field = param1;
      }
      
      public function get towerId() : int
      {
         return tower_id$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967291;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 4;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967287;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 8;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      public function removeGarrisonStartTime() : void
      {
         garrison_start_time$field = null;
      }
      
      public function get hasGarrisonStartTime() : Boolean
      {
         return garrison_start_time$field != null;
      }
      
      public function set garrisonStartTime(param1:Int64) : void
      {
         garrison_start_time$field = param1;
      }
      
      public function get garrisonStartTime() : Int64
      {
         return garrison_start_time$field;
      }
      
      public function removeGarrisonEndTime() : void
      {
         garrison_end_time$field = null;
      }
      
      public function get hasGarrisonEndTime() : Boolean
      {
         return garrison_end_time$field != null;
      }
      
      public function set garrisonEndTime(param1:Int64) : void
      {
         garrison_end_time$field = param1;
      }
      
      public function get garrisonEndTime() : Int64
      {
         return garrison_end_time$field;
      }
      
      public function removePatrolStartTime() : void
      {
         patrol_start_time$field = null;
      }
      
      public function get hasPatrolStartTime() : Boolean
      {
         return patrol_start_time$field != null;
      }
      
      public function set patrolStartTime(param1:Int64) : void
      {
         patrol_start_time$field = param1;
      }
      
      public function get patrolStartTime() : Int64
      {
         return patrol_start_time$field;
      }
      
      public function removePatrolEndTime() : void
      {
         patrol_end_time$field = null;
      }
      
      public function get hasPatrolEndTime() : Boolean
      {
         return patrol_end_time$field != null;
      }
      
      public function set patrolEndTime(param1:Int64) : void
      {
         patrol_end_time$field = param1;
      }
      
      public function get patrolEndTime() : Int64
      {
         return patrol_end_time$field;
      }
      
      public function removeNormalMissionId() : void
      {
         hasField$0 &= 4294967279;
         normal_mission_id$field = new int();
      }
      
      public function get hasNormalMissionId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set normalMissionId(param1:int) : void
      {
         hasField$0 |= 16;
         normal_mission_id$field = param1;
      }
      
      public function get normalMissionId() : int
      {
         return normal_mission_id$field;
      }
      
      public function removeNormalMissionReached() : void
      {
         hasField$0 &= 4294967263;
         normal_mission_reached$field = new Boolean();
      }
      
      public function get hasNormalMissionReached() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set normalMissionReached(param1:Boolean) : void
      {
         hasField$0 |= 32;
         normal_mission_reached$field = param1;
      }
      
      public function get normalMissionReached() : Boolean
      {
         return normal_mission_reached$field;
      }
      
      public function removeHardMissionId() : void
      {
         hasField$0 &= 4294967231;
         hard_mission_id$field = new int();
      }
      
      public function get hasHardMissionId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set hardMissionId(param1:int) : void
      {
         hasField$0 |= 64;
         hard_mission_id$field = param1;
      }
      
      public function get hardMissionId() : int
      {
         return hard_mission_id$field;
      }
      
      public function removeHardMissionReached() : void
      {
         hasField$0 &= 4294967167;
         hard_mission_reached$field = new Boolean();
      }
      
      public function get hasHardMissionReached() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set hardMissionReached(param1:Boolean) : void
      {
         hasField$0 |= 128;
         hard_mission_reached$field = param1;
      }
      
      public function get hardMissionReached() : Boolean
      {
         return hard_mission_reached$field;
      }
      
      public function removeNightmareMissionId() : void
      {
         hasField$0 &= 4294967039;
         nightmare_mission_id$field = new int();
      }
      
      public function get hasNightmareMissionId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set nightmareMissionId(param1:int) : void
      {
         hasField$0 |= 256;
         nightmare_mission_id$field = param1;
      }
      
      public function get nightmareMissionId() : int
      {
         return nightmare_mission_id$field;
      }
      
      public function removeNightmareMissionReached() : void
      {
         hasField$0 &= 4294966783;
         nightmare_mission_reached$field = new Boolean();
      }
      
      public function get hasNightmareMissionReached() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set nightmareMissionReached(param1:Boolean) : void
      {
         hasField$0 |= 512;
         nightmare_mission_reached$field = param1;
      }
      
      public function get nightmareMissionReached() : Boolean
      {
         return nightmare_mission_reached$field;
      }
      
      public function removeGarrisonExpPerMinute() : void
      {
         hasField$0 &= 4294966271;
         garrison_exp_per_minute$field = new int();
      }
      
      public function get hasGarrisonExpPerMinute() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set garrisonExpPerMinute(param1:int) : void
      {
         hasField$0 |= 1024;
         garrison_exp_per_minute$field = param1;
      }
      
      public function get garrisonExpPerMinute() : int
      {
         return garrison_exp_per_minute$field;
      }
      
      public function removeOnGarrison() : void
      {
         hasField$0 &= 4294965247;
         on_garrison$field = new Boolean();
      }
      
      public function get hasOnGarrison() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set onGarrison(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         on_garrison$field = param1;
      }
      
      public function get onGarrison() : Boolean
      {
         return on_garrison$field;
      }
      
      public function removeGarrisonCountDown() : void
      {
         garrison_count_down$field = null;
      }
      
      public function get hasGarrisonCountDown() : Boolean
      {
         return garrison_count_down$field != null;
      }
      
      public function set garrisonCountDown(param1:Int64) : void
      {
         garrison_count_down$field = param1;
      }
      
      public function get garrisonCountDown() : Int64
      {
         return garrison_count_down$field;
      }
      
      public function removePatrolCountDown() : void
      {
         patrol_count_down$field = null;
      }
      
      public function get hasPatrolCountDown() : Boolean
      {
         return patrol_count_down$field != null;
      }
      
      public function set patrolCountDown(param1:Int64) : void
      {
         patrol_count_down$field = param1;
      }
      
      public function get patrolCountDown() : Int64
      {
         return patrol_count_down$field;
      }
      
      public function removeExploreChildId() : void
      {
         hasField$0 &= 4294963199;
         explore_child_id$field = new int();
      }
      
      public function get hasExploreChildId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set exploreChildId(param1:int) : void
      {
         hasField$0 |= 4096;
         explore_child_id$field = param1;
      }
      
      public function get exploreChildId() : int
      {
         return explore_child_id$field;
      }
      
      public function removeExploreCountDown() : void
      {
         explore_count_down$field = null;
      }
      
      public function get hasExploreCountDown() : Boolean
      {
         return explore_count_down$field != null;
      }
      
      public function set exploreCountDown(param1:Int64) : void
      {
         explore_count_down$field = param1;
      }
      
      public function get exploreCountDown() : Int64
      {
         return explore_count_down$field;
      }
      
      public function removeBossId() : void
      {
         hasField$0 &= 4294959103;
         boss_id$field = new int();
      }
      
      public function get hasBossId() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set bossId(param1:int) : void
      {
         hasField$0 |= 8192;
         boss_id$field = param1;
      }
      
      public function get bossId() : int
      {
         return boss_id$field;
      }
      
      public function removeBossStats() : void
      {
         hasField$0 &= 4294950911;
         boss_stats$field = new int();
      }
      
      public function get hasBossStats() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set bossStats(param1:int) : void
      {
         hasField$0 |= 16384;
         boss_stats$field = param1;
      }
      
      public function get bossStats() : int
      {
         return boss_stats$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasTowerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,tower_id$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasExp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,exp$field);
         }
         _loc3_ = 0;
         while(_loc3_ < garrisonChildIdList.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,garrisonChildIdList[_loc3_]);
            _loc3_++;
         }
         if(hasGarrisonStartTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,garrison_start_time$field);
         }
         if(hasGarrisonEndTime)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT64(param1,garrison_end_time$field);
         }
         _loc2_ = 0;
         while(_loc2_ < patrolChildIdList.length)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,patrolChildIdList[_loc2_]);
            _loc2_++;
         }
         if(hasPatrolStartTime)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT64(param1,patrol_start_time$field);
         }
         if(hasPatrolEndTime)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT64(param1,patrol_end_time$field);
         }
         if(hasNormalMissionId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,normal_mission_id$field);
         }
         if(hasNormalMissionReached)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,normal_mission_reached$field);
         }
         if(hasHardMissionId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,hard_mission_id$field);
         }
         if(hasHardMissionReached)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,hard_mission_reached$field);
         }
         if(hasNightmareMissionId)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,nightmare_mission_id$field);
         }
         if(hasNightmareMissionReached)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,nightmare_mission_reached$field);
         }
         if(hasGarrisonExpPerMinute)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,garrison_exp_per_minute$field);
         }
         if(hasOnGarrison)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_BOOL(param1,on_garrison$field);
         }
         if(hasGarrisonCountDown)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT64(param1,garrison_count_down$field);
         }
         if(hasPatrolCountDown)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT64(param1,patrol_count_down$field);
         }
         if(hasExploreChildId)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,explore_child_id$field);
         }
         if(hasExploreCountDown)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT64(param1,explore_count_down$field);
         }
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,boss_id$field);
         }
         if(hasBossStats)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,boss_stats$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc21_:uint = 0;
         var _loc14_:uint = 0;
         var _loc19_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc22_:uint = 0;
         var _loc9_:uint = 0;
         var _loc25_:uint = 0;
         var _loc11_:uint = 0;
         var _loc23_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc20_:uint = 0;
         var _loc6_:uint = 0;
         var _loc24_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.towerId cannot be set twice.");
                  }
                  _loc21_++;
                  towerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.state cannot be set twice.");
                  }
                  _loc14_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.level cannot be set twice.");
                  }
                  _loc19_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.exp cannot be set twice.");
                  }
                  _loc7_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if((_loc16_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,garrisonChildIdList);
                  }
                  else
                  {
                     garrisonChildIdList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.garrisonStartTime cannot be set twice.");
                  }
                  _loc15_++;
                  garrisonStartTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.garrisonEndTime cannot be set twice.");
                  }
                  _loc12_++;
                  garrisonEndTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 8:
                  if((_loc16_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,patrolChildIdList);
                  }
                  else
                  {
                     patrolChildIdList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.patrolStartTime cannot be set twice.");
                  }
                  _loc3_++;
                  patrolStartTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.patrolEndTime cannot be set twice.");
                  }
                  _loc8_++;
                  patrolEndTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.normalMissionId cannot be set twice.");
                  }
                  _loc10_++;
                  normalMissionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.normalMissionReached cannot be set twice.");
                  }
                  _loc17_++;
                  normalMissionReached = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.hardMissionId cannot be set twice.");
                  }
                  _loc18_++;
                  hardMissionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.hardMissionReached cannot be set twice.");
                  }
                  _loc22_++;
                  hardMissionReached = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.nightmareMissionId cannot be set twice.");
                  }
                  _loc9_++;
                  nightmareMissionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.nightmareMissionReached cannot be set twice.");
                  }
                  _loc25_++;
                  nightmareMissionReached = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.garrisonExpPerMinute cannot be set twice.");
                  }
                  _loc11_++;
                  garrisonExpPerMinute = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.onGarrison cannot be set twice.");
                  }
                  _loc23_++;
                  onGarrison = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 19:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.garrisonCountDown cannot be set twice.");
                  }
                  _loc5_++;
                  garrisonCountDown = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 20:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.patrolCountDown cannot be set twice.");
                  }
                  _loc4_++;
                  patrolCountDown = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 21:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.exploreChildId cannot be set twice.");
                  }
                  _loc20_++;
                  exploreChildId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.exploreCountDown cannot be set twice.");
                  }
                  _loc6_++;
                  exploreCountDown = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 23:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.bossId cannot be set twice.");
                  }
                  _loc24_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPatrolTowerMsg.bossStats cannot be set twice.");
                  }
                  _loc13_++;
                  bossStats = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

