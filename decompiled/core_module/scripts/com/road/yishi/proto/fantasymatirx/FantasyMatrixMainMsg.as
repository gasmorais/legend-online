package com.road.yishi.proto.fantasymatirx
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FantasyMatrixMainMsg extends Message implements IExternalizable
   {
      
      private var left_time$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var box_count$field:int;
      
      private var skill_attack_up$field:int;
      
      private var skill_score_up$field:int;
      
      private var skill_add_score$field:int;
      
      private var count_down_start$field:Boolean;
      
      public function FantasyMatrixMainMsg()
      {
         super();
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967294;
         left_time$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 1;
         left_time$field = param1;
      }
      
      public function get leftTime() : int
      {
         return left_time$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeBoxCount() : void
      {
         hasField$0 &= 4294967291;
         box_count$field = new int();
      }
      
      public function get hasBoxCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set boxCount(param1:int) : void
      {
         hasField$0 |= 4;
         box_count$field = param1;
      }
      
      public function get boxCount() : int
      {
         return box_count$field;
      }
      
      public function removeSkillAttackUp() : void
      {
         hasField$0 &= 4294967287;
         skill_attack_up$field = new int();
      }
      
      public function get hasSkillAttackUp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set skillAttackUp(param1:int) : void
      {
         hasField$0 |= 8;
         skill_attack_up$field = param1;
      }
      
      public function get skillAttackUp() : int
      {
         return skill_attack_up$field;
      }
      
      public function removeSkillScoreUp() : void
      {
         hasField$0 &= 4294967279;
         skill_score_up$field = new int();
      }
      
      public function get hasSkillScoreUp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set skillScoreUp(param1:int) : void
      {
         hasField$0 |= 16;
         skill_score_up$field = param1;
      }
      
      public function get skillScoreUp() : int
      {
         return skill_score_up$field;
      }
      
      public function removeSkillAddScore() : void
      {
         hasField$0 &= 4294967263;
         skill_add_score$field = new int();
      }
      
      public function get hasSkillAddScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set skillAddScore(param1:int) : void
      {
         hasField$0 |= 32;
         skill_add_score$field = param1;
      }
      
      public function get skillAddScore() : int
      {
         return skill_add_score$field;
      }
      
      public function removeCountDownStart() : void
      {
         hasField$0 &= 4294967231;
         count_down_start$field = new Boolean();
      }
      
      public function get hasCountDownStart() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set countDownStart(param1:Boolean) : void
      {
         hasField$0 |= 64;
         count_down_start$field = param1;
      }
      
      public function get countDownStart() : Boolean
      {
         return count_down_start$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,left_time$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasBoxCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,box_count$field);
         }
         if(hasSkillAttackUp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,skill_attack_up$field);
         }
         if(hasSkillScoreUp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,skill_score_up$field);
         }
         if(hasSkillAddScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,skill_add_score$field);
         }
         if(hasCountDownStart)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,count_down_start$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixMainMsg.leftTime cannot be set twice.");
                  }
                  _loc5_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixMainMsg.score cannot be set twice.");
                  }
                  _loc10_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixMainMsg.boxCount cannot be set twice.");
                  }
                  _loc9_++;
                  boxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixMainMsg.skillAttackUp cannot be set twice.");
                  }
                  _loc6_++;
                  skillAttackUp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixMainMsg.skillScoreUp cannot be set twice.");
                  }
                  _loc3_++;
                  skillScoreUp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixMainMsg.skillAddScore cannot be set twice.");
                  }
                  _loc4_++;
                  skillAddScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FantasyMatrixMainMsg.countDownStart cannot be set twice.");
                  }
                  _loc7_++;
                  countDownStart = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

