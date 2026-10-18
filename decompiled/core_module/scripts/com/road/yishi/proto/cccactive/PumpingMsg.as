package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PumpingMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      private var lotteryType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.EggTempMsg")]
      public var eggTempList:Array = [];
      
      [ArrayElementType("int")]
      public var resultEggIds:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.cccactive.LuckyRewardMsg")]
      public var luckyRewards:Array = [];
      
      private var totalScore$field:int;
      
      private var oneNeedPoint$field:int;
      
      private var tenNeedPoint$field:int;
      
      private var floorNeedPumps$field:int;
      
      private var luckyLeftCount$field:int;
      
      public function PumpingMsg()
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
      
      public function removeLotteryType() : void
      {
         hasField$0 &= 4294967293;
         lotteryType$field = new int();
      }
      
      public function get hasLotteryType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set lotteryType(param1:int) : void
      {
         hasField$0 |= 2;
         lotteryType$field = param1;
      }
      
      public function get lotteryType() : int
      {
         return lotteryType$field;
      }
      
      public function removeTotalScore() : void
      {
         hasField$0 &= 4294967291;
         totalScore$field = new int();
      }
      
      public function get hasTotalScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalScore(param1:int) : void
      {
         hasField$0 |= 4;
         totalScore$field = param1;
      }
      
      public function get totalScore() : int
      {
         return totalScore$field;
      }
      
      public function removeOneNeedPoint() : void
      {
         hasField$0 &= 4294967287;
         oneNeedPoint$field = new int();
      }
      
      public function get hasOneNeedPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set oneNeedPoint(param1:int) : void
      {
         hasField$0 |= 8;
         oneNeedPoint$field = param1;
      }
      
      public function get oneNeedPoint() : int
      {
         return oneNeedPoint$field;
      }
      
      public function removeTenNeedPoint() : void
      {
         hasField$0 &= 4294967279;
         tenNeedPoint$field = new int();
      }
      
      public function get hasTenNeedPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set tenNeedPoint(param1:int) : void
      {
         hasField$0 |= 16;
         tenNeedPoint$field = param1;
      }
      
      public function get tenNeedPoint() : int
      {
         return tenNeedPoint$field;
      }
      
      public function removeFloorNeedPumps() : void
      {
         hasField$0 &= 4294967263;
         floorNeedPumps$field = new int();
      }
      
      public function get hasFloorNeedPumps() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set floorNeedPumps(param1:int) : void
      {
         hasField$0 |= 32;
         floorNeedPumps$field = param1;
      }
      
      public function get floorNeedPumps() : int
      {
         return floorNeedPumps$field;
      }
      
      public function removeLuckyLeftCount() : void
      {
         hasField$0 &= 4294967231;
         luckyLeftCount$field = new int();
      }
      
      public function get hasLuckyLeftCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set luckyLeftCount(param1:int) : void
      {
         hasField$0 |= 64;
         luckyLeftCount$field = param1;
      }
      
      public function get luckyLeftCount() : int
      {
         return luckyLeftCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         if(hasLotteryType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,lotteryType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < eggTempList.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,eggTempList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < resultEggIds.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,resultEggIds[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < luckyRewards.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,luckyRewards[_loc4_]);
            _loc4_++;
         }
         if(hasTotalScore)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,totalScore$field);
         }
         if(hasOneNeedPoint)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,oneNeedPoint$field);
         }
         if(hasTenNeedPoint)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,tenNeedPoint$field);
         }
         if(hasFloorNeedPumps)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,floorNeedPumps$field);
         }
         if(hasLuckyLeftCount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,luckyLeftCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc6_:EggTempMsg = null;
         var _loc4_:LuckyRewardMsg = null;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PumpingMsg.op cannot be set twice.");
                  }
                  _loc14_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PumpingMsg.openTime cannot be set twice.");
                  }
                  _loc8_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PumpingMsg.stopTime cannot be set twice.");
                  }
                  _loc9_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PumpingMsg.lotteryType cannot be set twice.");
                  }
                  _loc10_++;
                  lotteryType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc6_ = new EggTempMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  eggTempList.push(_loc6_);
                  break;
               case 5:
                  if((_loc13_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,resultEggIds);
                  }
                  else
                  {
                     resultEggIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  _loc4_ = new LuckyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  luckyRewards.push(_loc4_);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PumpingMsg.totalScore cannot be set twice.");
                  }
                  _loc5_++;
                  totalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PumpingMsg.oneNeedPoint cannot be set twice.");
                  }
                  _loc12_++;
                  oneNeedPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PumpingMsg.tenNeedPoint cannot be set twice.");
                  }
                  _loc3_++;
                  tenNeedPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PumpingMsg.floorNeedPumps cannot be set twice.");
                  }
                  _loc7_++;
                  floorNeedPumps = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PumpingMsg.luckyLeftCount cannot be set twice.");
                  }
                  _loc11_++;
                  luckyLeftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

