package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SevenYearUserMsg extends Message implements IExternalizable
   {
      
      private var flagGrade$field:int;
      
      private var hasField$0:uint = 0;
      
      private var flagScore$field:int;
      
      private var rewardGrade$field:int;
      
      private var gameCount$field:int;
      
      private var answerTotalScore$field:int;
      
      private var achievementTotalScore$field:int;
      
      private var snowScore$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.anniversary.SevenYearAchievementMsg")]
      public var achievements:Array = [];
      
      private var rewardFreeGrade$field:int;
      
      private var hasBuy$field:Boolean;
      
      public function SevenYearUserMsg()
      {
         super();
      }
      
      public function removeFlagGrade() : void
      {
         hasField$0 &= 4294967294;
         flagGrade$field = new int();
      }
      
      public function get hasFlagGrade() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set flagGrade(param1:int) : void
      {
         hasField$0 |= 1;
         flagGrade$field = param1;
      }
      
      public function get flagGrade() : int
      {
         return flagGrade$field;
      }
      
      public function removeFlagScore() : void
      {
         hasField$0 &= 4294967293;
         flagScore$field = new int();
      }
      
      public function get hasFlagScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set flagScore(param1:int) : void
      {
         hasField$0 |= 2;
         flagScore$field = param1;
      }
      
      public function get flagScore() : int
      {
         return flagScore$field;
      }
      
      public function removeRewardGrade() : void
      {
         hasField$0 &= 4294967291;
         rewardGrade$field = new int();
      }
      
      public function get hasRewardGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rewardGrade(param1:int) : void
      {
         hasField$0 |= 4;
         rewardGrade$field = param1;
      }
      
      public function get rewardGrade() : int
      {
         return rewardGrade$field;
      }
      
      public function removeGameCount() : void
      {
         hasField$0 &= 4294967287;
         gameCount$field = new int();
      }
      
      public function get hasGameCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set gameCount(param1:int) : void
      {
         hasField$0 |= 8;
         gameCount$field = param1;
      }
      
      public function get gameCount() : int
      {
         return gameCount$field;
      }
      
      public function removeAnswerTotalScore() : void
      {
         hasField$0 &= 4294967279;
         answerTotalScore$field = new int();
      }
      
      public function get hasAnswerTotalScore() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set answerTotalScore(param1:int) : void
      {
         hasField$0 |= 16;
         answerTotalScore$field = param1;
      }
      
      public function get answerTotalScore() : int
      {
         return answerTotalScore$field;
      }
      
      public function removeAchievementTotalScore() : void
      {
         hasField$0 &= 4294967263;
         achievementTotalScore$field = new int();
      }
      
      public function get hasAchievementTotalScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set achievementTotalScore(param1:int) : void
      {
         hasField$0 |= 32;
         achievementTotalScore$field = param1;
      }
      
      public function get achievementTotalScore() : int
      {
         return achievementTotalScore$field;
      }
      
      public function removeSnowScore() : void
      {
         hasField$0 &= 4294967231;
         snowScore$field = new int();
      }
      
      public function get hasSnowScore() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set snowScore(param1:int) : void
      {
         hasField$0 |= 64;
         snowScore$field = param1;
      }
      
      public function get snowScore() : int
      {
         return snowScore$field;
      }
      
      public function removeRewardFreeGrade() : void
      {
         hasField$0 &= 4294967167;
         rewardFreeGrade$field = new int();
      }
      
      public function get hasRewardFreeGrade() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set rewardFreeGrade(param1:int) : void
      {
         hasField$0 |= 128;
         rewardFreeGrade$field = param1;
      }
      
      public function get rewardFreeGrade() : int
      {
         return rewardFreeGrade$field;
      }
      
      public function removeHasBuy() : void
      {
         hasField$0 &= 4294967039;
         hasBuy$field = new Boolean();
      }
      
      public function get hasHasBuy() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set hasBuy(param1:Boolean) : void
      {
         hasField$0 |= 256;
         hasBuy$field = param1;
      }
      
      public function get hasBuy() : Boolean
      {
         return hasBuy$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasFlagGrade)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,flagGrade$field);
         }
         if(hasFlagScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,flagScore$field);
         }
         if(hasRewardGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rewardGrade$field);
         }
         if(hasGameCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,gameCount$field);
         }
         if(hasAnswerTotalScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,answerTotalScore$field);
         }
         if(hasAchievementTotalScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,achievementTotalScore$field);
         }
         if(hasSnowScore)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,snowScore$field);
         }
         _loc2_ = 0;
         while(_loc2_ < achievements.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,achievements[_loc2_]);
            _loc2_++;
         }
         if(hasRewardFreeGrade)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,rewardFreeGrade$field);
         }
         if(hasHasBuy)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,hasBuy$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc7_:SevenYearAchievementMsg = null;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearUserMsg.flagGrade cannot be set twice.");
                  }
                  _loc11_++;
                  flagGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearUserMsg.flagScore cannot be set twice.");
                  }
                  _loc10_++;
                  flagScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearUserMsg.rewardGrade cannot be set twice.");
                  }
                  _loc8_++;
                  rewardGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearUserMsg.gameCount cannot be set twice.");
                  }
                  _loc13_++;
                  gameCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearUserMsg.answerTotalScore cannot be set twice.");
                  }
                  _loc3_++;
                  answerTotalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearUserMsg.achievementTotalScore cannot be set twice.");
                  }
                  _loc9_++;
                  achievementTotalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearUserMsg.snowScore cannot be set twice.");
                  }
                  _loc5_++;
                  snowScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc7_ = new SevenYearAchievementMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  achievements.push(_loc7_);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearUserMsg.rewardFreeGrade cannot be set twice.");
                  }
                  _loc4_++;
                  rewardFreeGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearUserMsg.hasBuy cannot be set twice.");
                  }
                  _loc6_++;
                  hasBuy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

