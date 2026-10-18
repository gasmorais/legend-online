package com.road.yishi.proto.artifactgiftactivity
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArtifactGiftActivityMsg extends Message implements IExternalizable
   {
      
      private var UserId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var Score$field:int;
      
      private var ScoreStep$field:int;
      
      private var LotteryNum$field:int;
      
      [ArrayElementType("int")]
      public var lotteryItems:Array = [];
      
      private var ResetNum$field:int;
      
      private var rewarded$field:Boolean;
      
      public function ArtifactGiftActivityMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         UserId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         UserId$field = param1;
      }
      
      public function get userId() : int
      {
         return UserId$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         Score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         Score$field = param1;
      }
      
      public function get score() : int
      {
         return Score$field;
      }
      
      public function removeScoreStep() : void
      {
         hasField$0 &= 4294967291;
         ScoreStep$field = new int();
      }
      
      public function get hasScoreStep() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set scoreStep(param1:int) : void
      {
         hasField$0 |= 4;
         ScoreStep$field = param1;
      }
      
      public function get scoreStep() : int
      {
         return ScoreStep$field;
      }
      
      public function removeLotteryNum() : void
      {
         hasField$0 &= 4294967287;
         LotteryNum$field = new int();
      }
      
      public function get hasLotteryNum() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set lotteryNum(param1:int) : void
      {
         hasField$0 |= 8;
         LotteryNum$field = param1;
      }
      
      public function get lotteryNum() : int
      {
         return LotteryNum$field;
      }
      
      public function removeResetNum() : void
      {
         hasField$0 &= 4294967279;
         ResetNum$field = new int();
      }
      
      public function get hasResetNum() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set resetNum(param1:int) : void
      {
         hasField$0 |= 16;
         ResetNum$field = param1;
      }
      
      public function get resetNum() : int
      {
         return ResetNum$field;
      }
      
      public function removeRewarded() : void
      {
         hasField$0 &= 4294967263;
         rewarded$field = new Boolean();
      }
      
      public function get hasRewarded() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set rewarded(param1:Boolean) : void
      {
         hasField$0 |= 32;
         rewarded$field = param1;
      }
      
      public function get rewarded() : Boolean
      {
         return rewarded$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,UserId$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,Score$field);
         }
         if(hasScoreStep)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,ScoreStep$field);
         }
         if(hasLotteryNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,LotteryNum$field);
         }
         _loc2_ = 0;
         while(_loc2_ < lotteryItems.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,lotteryItems[_loc2_]);
            _loc2_++;
         }
         if(hasResetNum)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,ResetNum$field);
         }
         if(hasRewarded)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,rewarded$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactGiftActivityMsg.userId cannot be set twice.");
                  }
                  _loc3_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactGiftActivityMsg.score cannot be set twice.");
                  }
                  _loc4_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactGiftActivityMsg.scoreStep cannot be set twice.");
                  }
                  _loc9_++;
                  scoreStep = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactGiftActivityMsg.lotteryNum cannot be set twice.");
                  }
                  _loc7_++;
                  lotteryNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,lotteryItems);
                  }
                  else
                  {
                     lotteryItems.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactGiftActivityMsg.resetNum cannot be set twice.");
                  }
                  _loc6_++;
                  resetNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactGiftActivityMsg.rewarded cannot be set twice.");
                  }
                  _loc5_++;
                  rewarded = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

