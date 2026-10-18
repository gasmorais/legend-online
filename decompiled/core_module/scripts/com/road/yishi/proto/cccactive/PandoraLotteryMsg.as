package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PandoraLotteryMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var currentLevel$field:int;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.LotteryRewardMsg")]
      public var reward:Array = [];
      
      private var resultPoint$field:int;
      
      private var leftLotteryCount$field:int;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      public function PandoraLotteryMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeCurrentLevel() : void
      {
         hasField$0 &= 4294967293;
         currentLevel$field = new int();
      }
      
      public function get hasCurrentLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currentLevel(param1:int) : void
      {
         hasField$0 |= 2;
         currentLevel$field = param1;
      }
      
      public function get currentLevel() : int
      {
         return currentLevel$field;
      }
      
      public function removeResultPoint() : void
      {
         hasField$0 &= 4294967291;
         resultPoint$field = new int();
      }
      
      public function get hasResultPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set resultPoint(param1:int) : void
      {
         hasField$0 |= 4;
         resultPoint$field = param1;
      }
      
      public function get resultPoint() : int
      {
         return resultPoint$field;
      }
      
      public function removeLeftLotteryCount() : void
      {
         hasField$0 &= 4294967287;
         leftLotteryCount$field = new int();
      }
      
      public function get hasLeftLotteryCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftLotteryCount(param1:int) : void
      {
         hasField$0 |= 8;
         leftLotteryCount$field = param1;
      }
      
      public function get leftLotteryCount() : int
      {
         return leftLotteryCount$field;
      }
      
      public function removeOpenTime() : void
      {
         openTime$field = null;
      }
      
      public function get hasOpenTime() : Boolean
      {
         return openTime$field != null;
      }
      
      public function set openTime(param1:String) : void
      {
         openTime$field = param1;
      }
      
      public function get openTime() : String
      {
         return openTime$field;
      }
      
      public function removeStopTime() : void
      {
         stopTime$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stopTime$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stopTime$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stopTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasCurrentLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,currentLevel$field);
         }
         _loc2_ = 0;
         while(_loc2_ < reward.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,reward[_loc2_]);
            _loc2_++;
         }
         if(hasResultPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,resultPoint$field);
         }
         if(hasLeftLotteryCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,leftLotteryCount$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:LotteryRewardMsg = null;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PandoraLotteryMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PandoraLotteryMsg.currentLevel cannot be set twice.");
                  }
                  _loc7_++;
                  currentLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc4_ = new LotteryRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  reward.push(_loc4_);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PandoraLotteryMsg.resultPoint cannot be set twice.");
                  }
                  _loc10_++;
                  resultPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PandoraLotteryMsg.leftLotteryCount cannot be set twice.");
                  }
                  _loc5_++;
                  leftLotteryCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PandoraLotteryMsg.openTime cannot be set twice.");
                  }
                  _loc8_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PandoraLotteryMsg.stopTime cannot be set twice.");
                  }
                  _loc3_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

