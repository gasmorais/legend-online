package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterAccessoryHammerMsg extends Message implements IExternalizable
   {
      
      private var skillIndex$field:int;
      
      private var hasField$0:uint = 0;
      
      private var hammerCount$field:int;
      
      private var aimSkillGrade$field:int;
      
      private var success$field:Boolean;
      
      private var isAuto$field:Boolean;
      
      private var autoStopResult$field:int;
      
      [ArrayElementType("int")]
      public var materialTempIdList:Array = [];
      
      public function MonsterAccessoryHammerMsg()
      {
         super();
      }
      
      public function removeSkillIndex() : void
      {
         hasField$0 &= 4294967294;
         skillIndex$field = new int();
      }
      
      public function get hasSkillIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillIndex(param1:int) : void
      {
         hasField$0 |= 1;
         skillIndex$field = param1;
      }
      
      public function get skillIndex() : int
      {
         return skillIndex$field;
      }
      
      public function removeHammerCount() : void
      {
         hasField$0 &= 4294967293;
         hammerCount$field = new int();
      }
      
      public function get hasHammerCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hammerCount(param1:int) : void
      {
         hasField$0 |= 2;
         hammerCount$field = param1;
      }
      
      public function get hammerCount() : int
      {
         return hammerCount$field;
      }
      
      public function removeAimSkillGrade() : void
      {
         hasField$0 &= 4294967291;
         aimSkillGrade$field = new int();
      }
      
      public function get hasAimSkillGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set aimSkillGrade(param1:int) : void
      {
         hasField$0 |= 4;
         aimSkillGrade$field = param1;
      }
      
      public function get aimSkillGrade() : int
      {
         return aimSkillGrade$field;
      }
      
      public function removeSuccess() : void
      {
         hasField$0 &= 4294967287;
         success$field = new Boolean();
      }
      
      public function get hasSuccess() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set success(param1:Boolean) : void
      {
         hasField$0 |= 8;
         success$field = param1;
      }
      
      public function get success() : Boolean
      {
         return success$field;
      }
      
      public function removeIsAuto() : void
      {
         hasField$0 &= 4294967279;
         isAuto$field = new Boolean();
      }
      
      public function get hasIsAuto() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isAuto(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isAuto$field = param1;
      }
      
      public function get isAuto() : Boolean
      {
         return isAuto$field;
      }
      
      public function removeAutoStopResult() : void
      {
         hasField$0 &= 4294967263;
         autoStopResult$field = new int();
      }
      
      public function get hasAutoStopResult() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set autoStopResult(param1:int) : void
      {
         hasField$0 |= 32;
         autoStopResult$field = param1;
      }
      
      public function get autoStopResult() : int
      {
         return autoStopResult$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasSkillIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skillIndex$field);
         }
         if(hasHammerCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,hammerCount$field);
         }
         if(hasAimSkillGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,aimSkillGrade$field);
         }
         if(hasSuccess)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,success$field);
         }
         if(hasIsAuto)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isAuto$field);
         }
         if(hasAutoStopResult)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,autoStopResult$field);
         }
         _loc2_ = 0;
         while(_loc2_ < materialTempIdList.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,materialTempIdList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterAccessoryHammerMsg.skillIndex cannot be set twice.");
                  }
                  _loc6_++;
                  skillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterAccessoryHammerMsg.hammerCount cannot be set twice.");
                  }
                  _loc5_++;
                  hammerCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterAccessoryHammerMsg.aimSkillGrade cannot be set twice.");
                  }
                  _loc9_++;
                  aimSkillGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterAccessoryHammerMsg.success cannot be set twice.");
                  }
                  _loc3_++;
                  success = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterAccessoryHammerMsg.isAuto cannot be set twice.");
                  }
                  _loc4_++;
                  isAuto = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterAccessoryHammerMsg.autoStopResult cannot be set twice.");
                  }
                  _loc8_++;
                  autoStopResult = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if((_loc7_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,materialTempIdList);
                  }
                  else
                  {
                     materialTempIdList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

