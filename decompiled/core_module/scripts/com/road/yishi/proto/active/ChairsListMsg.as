package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChairsListMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var totalChairsCount$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.ChairsRewardMsg")]
      public var reward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.ChairsChargeMsg")]
      public var charge:Array = [];
      
      private var userId$field:int;
      
      [ArrayElementType("String")]
      public var luckyNickName:Array = [];
      
      private var currentChairs$field:int;
      
      private var rewardCounts$field:int;
      
      private var rewardNeedChairs$field:int;
      
      private var chairsNeedPoints$field:int;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      private var chairsNum$field:String;
      
      [ArrayElementType("String")]
      public var luckyItems:Array = [];
      
      [ArrayElementType("String")]
      public var comfortItems:Array = [];
      
      private var leftPoint$field:int;
      
      public function ChairsListMsg()
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
      
      public function removeTotalChairsCount() : void
      {
         hasField$0 &= 4294967293;
         totalChairsCount$field = new int();
      }
      
      public function get hasTotalChairsCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalChairsCount(param1:int) : void
      {
         hasField$0 |= 2;
         totalChairsCount$field = param1;
      }
      
      public function get totalChairsCount() : int
      {
         return totalChairsCount$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeCurrentChairs() : void
      {
         hasField$0 &= 4294967287;
         currentChairs$field = new int();
      }
      
      public function get hasCurrentChairs() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set currentChairs(param1:int) : void
      {
         hasField$0 |= 8;
         currentChairs$field = param1;
      }
      
      public function get currentChairs() : int
      {
         return currentChairs$field;
      }
      
      public function removeRewardCounts() : void
      {
         hasField$0 &= 4294967279;
         rewardCounts$field = new int();
      }
      
      public function get hasRewardCounts() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rewardCounts(param1:int) : void
      {
         hasField$0 |= 16;
         rewardCounts$field = param1;
      }
      
      public function get rewardCounts() : int
      {
         return rewardCounts$field;
      }
      
      public function removeRewardNeedChairs() : void
      {
         hasField$0 &= 4294967263;
         rewardNeedChairs$field = new int();
      }
      
      public function get hasRewardNeedChairs() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set rewardNeedChairs(param1:int) : void
      {
         hasField$0 |= 32;
         rewardNeedChairs$field = param1;
      }
      
      public function get rewardNeedChairs() : int
      {
         return rewardNeedChairs$field;
      }
      
      public function removeChairsNeedPoints() : void
      {
         hasField$0 &= 4294967231;
         chairsNeedPoints$field = new int();
      }
      
      public function get hasChairsNeedPoints() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set chairsNeedPoints(param1:int) : void
      {
         hasField$0 |= 64;
         chairsNeedPoints$field = param1;
      }
      
      public function get chairsNeedPoints() : int
      {
         return chairsNeedPoints$field;
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
      
      public function removeChairsNum() : void
      {
         chairsNum$field = null;
      }
      
      public function get hasChairsNum() : Boolean
      {
         return chairsNum$field != null;
      }
      
      public function set chairsNum(param1:String) : void
      {
         chairsNum$field = param1;
      }
      
      public function get chairsNum() : String
      {
         return chairsNum$field;
      }
      
      public function removeLeftPoint() : void
      {
         hasField$0 &= 4294967167;
         leftPoint$field = new int();
      }
      
      public function get hasLeftPoint() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set leftPoint(param1:int) : void
      {
         hasField$0 |= 128;
         leftPoint$field = param1;
      }
      
      public function get leftPoint() : int
      {
         return leftPoint$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc5_:* = 0;
         var _loc2_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasTotalChairsCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,totalChairsCount$field);
         }
         _loc5_ = 0;
         while(_loc5_ < reward.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,reward[_loc5_]);
            _loc5_++;
         }
         _loc2_ = 0;
         while(_loc2_ < charge.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,charge[_loc2_]);
            _loc2_++;
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         _loc6_ = 0;
         while(_loc6_ < luckyNickName.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,luckyNickName[_loc6_]);
            _loc6_++;
         }
         if(hasCurrentChairs)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,currentChairs$field);
         }
         if(hasRewardCounts)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,rewardCounts$field);
         }
         if(hasRewardNeedChairs)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,rewardNeedChairs$field);
         }
         if(hasChairsNeedPoints)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,chairsNeedPoints$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         if(hasChairsNum)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,chairsNum$field);
         }
         _loc4_ = 0;
         while(_loc4_ < luckyItems.length)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,luckyItems[_loc4_]);
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < comfortItems.length)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,comfortItems[_loc3_]);
            _loc3_++;
         }
         if(hasLeftPoint)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,leftPoint$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc5_:ChairsRewardMsg = null;
         var _loc8_:ChairsChargeMsg = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.op cannot be set twice.");
                  }
                  _loc15_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.totalChairsCount cannot be set twice.");
                  }
                  _loc16_++;
                  totalChairsCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc5_ = new ChairsRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  reward.push(_loc5_);
                  break;
               case 3:
                  _loc8_ = new ChairsChargeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  charge.push(_loc8_);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  luckyNickName.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.currentChairs cannot be set twice.");
                  }
                  _loc4_++;
                  currentChairs = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.rewardCounts cannot be set twice.");
                  }
                  _loc11_++;
                  rewardCounts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.rewardNeedChairs cannot be set twice.");
                  }
                  _loc13_++;
                  rewardNeedChairs = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.chairsNeedPoints cannot be set twice.");
                  }
                  _loc12_++;
                  chairsNeedPoints = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.openTime cannot be set twice.");
                  }
                  _loc7_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.stopTime cannot be set twice.");
                  }
                  _loc10_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.chairsNum cannot be set twice.");
                  }
                  _loc9_++;
                  chairsNum = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  luckyItems.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 14:
                  comfortItems.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 15:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsListMsg.leftPoint cannot be set twice.");
                  }
                  _loc3_++;
                  leftPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

