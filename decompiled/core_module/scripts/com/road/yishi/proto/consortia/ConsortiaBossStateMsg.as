package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaBossStateMsg extends Message implements IExternalizable
   {
      
      private var mission_a_process$field:int;
      
      private var hasField$0:uint = 0;
      
      private var mission_b_process$field:int;
      
      private var mission_c_process$field:int;
      
      [ArrayElementType("com.road.yishi.proto.consortia.ConsortiaBossPlayerMsg")]
      public var playerList:Array = [];
      
      private var mission_a_skill_id$field:int;
      
      private var mission_b_skill_id$field:int;
      
      private var mission_c_skill_id$field:int;
      
      public function ConsortiaBossStateMsg()
      {
         super();
      }
      
      public function removeMissionAProcess() : void
      {
         hasField$0 &= 4294967294;
         mission_a_process$field = new int();
      }
      
      public function get hasMissionAProcess() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set missionAProcess(param1:int) : void
      {
         hasField$0 |= 1;
         mission_a_process$field = param1;
      }
      
      public function get missionAProcess() : int
      {
         return mission_a_process$field;
      }
      
      public function removeMissionBProcess() : void
      {
         hasField$0 &= 4294967293;
         mission_b_process$field = new int();
      }
      
      public function get hasMissionBProcess() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set missionBProcess(param1:int) : void
      {
         hasField$0 |= 2;
         mission_b_process$field = param1;
      }
      
      public function get missionBProcess() : int
      {
         return mission_b_process$field;
      }
      
      public function removeMissionCProcess() : void
      {
         hasField$0 &= 4294967291;
         mission_c_process$field = new int();
      }
      
      public function get hasMissionCProcess() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set missionCProcess(param1:int) : void
      {
         hasField$0 |= 4;
         mission_c_process$field = param1;
      }
      
      public function get missionCProcess() : int
      {
         return mission_c_process$field;
      }
      
      public function removeMissionASkillId() : void
      {
         hasField$0 &= 4294967287;
         mission_a_skill_id$field = new int();
      }
      
      public function get hasMissionASkillId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set missionASkillId(param1:int) : void
      {
         hasField$0 |= 8;
         mission_a_skill_id$field = param1;
      }
      
      public function get missionASkillId() : int
      {
         return mission_a_skill_id$field;
      }
      
      public function removeMissionBSkillId() : void
      {
         hasField$0 &= 4294967279;
         mission_b_skill_id$field = new int();
      }
      
      public function get hasMissionBSkillId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set missionBSkillId(param1:int) : void
      {
         hasField$0 |= 16;
         mission_b_skill_id$field = param1;
      }
      
      public function get missionBSkillId() : int
      {
         return mission_b_skill_id$field;
      }
      
      public function removeMissionCSkillId() : void
      {
         hasField$0 &= 4294967263;
         mission_c_skill_id$field = new int();
      }
      
      public function get hasMissionCSkillId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set missionCSkillId(param1:int) : void
      {
         hasField$0 |= 32;
         mission_c_skill_id$field = param1;
      }
      
      public function get missionCSkillId() : int
      {
         return mission_c_skill_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasMissionAProcess)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mission_a_process$field);
         }
         if(hasMissionBProcess)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,mission_b_process$field);
         }
         if(hasMissionCProcess)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,mission_c_process$field);
         }
         _loc2_ = 0;
         while(_loc2_ < playerList.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,playerList[_loc2_]);
            _loc2_++;
         }
         if(hasMissionASkillId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,mission_a_skill_id$field);
         }
         if(hasMissionBSkillId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,mission_b_skill_id$field);
         }
         if(hasMissionCSkillId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,mission_c_skill_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:ConsortiaBossPlayerMsg = null;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossStateMsg.missionAProcess cannot be set twice.");
                  }
                  _loc6_++;
                  missionAProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossStateMsg.missionBProcess cannot be set twice.");
                  }
                  _loc10_++;
                  missionBProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossStateMsg.missionCProcess cannot be set twice.");
                  }
                  _loc7_++;
                  missionCProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc4_ = new ConsortiaBossPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  playerList.push(_loc4_);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossStateMsg.missionASkillId cannot be set twice.");
                  }
                  _loc3_++;
                  missionASkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossStateMsg.missionBSkillId cannot be set twice.");
                  }
                  _loc5_++;
                  missionBSkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaBossStateMsg.missionCSkillId cannot be set twice.");
                  }
                  _loc8_++;
                  missionCSkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

