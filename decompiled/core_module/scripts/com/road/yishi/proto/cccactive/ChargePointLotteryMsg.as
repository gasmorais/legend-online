package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChargePointLotteryMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var chargePoint$field:int;
      
      private var oneNeedPoint$field:int;
      
      private var leftNeedPoint$field:int;
      
      private var leftCount$field:int;
      
      private var dayMaxCount$field:int;
      
      private var dayAddCount$field:int;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.LotteryItemMsg")]
      public var reward:Array = [];
      
      [ArrayElementType("String")]
      public var logs:Array = [];
      
      private var isOneKey$field:Boolean;
      
      private var isRare$field:Boolean;
      
      [ArrayElementType("int")]
      public var resultPos:Array = [];
      
      public function ChargePointLotteryMsg()
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
      
      public function removeChargePoint() : void
      {
         hasField$0 &= 4294967293;
         chargePoint$field = new int();
      }
      
      public function get hasChargePoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set chargePoint(param1:int) : void
      {
         hasField$0 |= 2;
         chargePoint$field = param1;
      }
      
      public function get chargePoint() : int
      {
         return chargePoint$field;
      }
      
      public function removeOneNeedPoint() : void
      {
         hasField$0 &= 4294967291;
         oneNeedPoint$field = new int();
      }
      
      public function get hasOneNeedPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set oneNeedPoint(param1:int) : void
      {
         hasField$0 |= 4;
         oneNeedPoint$field = param1;
      }
      
      public function get oneNeedPoint() : int
      {
         return oneNeedPoint$field;
      }
      
      public function removeLeftNeedPoint() : void
      {
         hasField$0 &= 4294967287;
         leftNeedPoint$field = new int();
      }
      
      public function get hasLeftNeedPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftNeedPoint(param1:int) : void
      {
         hasField$0 |= 8;
         leftNeedPoint$field = param1;
      }
      
      public function get leftNeedPoint() : int
      {
         return leftNeedPoint$field;
      }
      
      public function removeLeftCount() : void
      {
         hasField$0 &= 4294967279;
         leftCount$field = new int();
      }
      
      public function get hasLeftCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set leftCount(param1:int) : void
      {
         hasField$0 |= 16;
         leftCount$field = param1;
      }
      
      public function get leftCount() : int
      {
         return leftCount$field;
      }
      
      public function removeDayMaxCount() : void
      {
         hasField$0 &= 4294967263;
         dayMaxCount$field = new int();
      }
      
      public function get hasDayMaxCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set dayMaxCount(param1:int) : void
      {
         hasField$0 |= 32;
         dayMaxCount$field = param1;
      }
      
      public function get dayMaxCount() : int
      {
         return dayMaxCount$field;
      }
      
      public function removeDayAddCount() : void
      {
         hasField$0 &= 4294967231;
         dayAddCount$field = new int();
      }
      
      public function get hasDayAddCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set dayAddCount(param1:int) : void
      {
         hasField$0 |= 64;
         dayAddCount$field = param1;
      }
      
      public function get dayAddCount() : int
      {
         return dayAddCount$field;
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
      
      public function removeIsOneKey() : void
      {
         hasField$0 &= 4294967167;
         isOneKey$field = new Boolean();
      }
      
      public function get hasIsOneKey() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isOneKey(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isOneKey$field = param1;
      }
      
      public function get isOneKey() : Boolean
      {
         return isOneKey$field;
      }
      
      public function removeIsRare() : void
      {
         hasField$0 &= 4294967039;
         isRare$field = new Boolean();
      }
      
      public function get hasIsRare() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isRare(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isRare$field = param1;
      }
      
      public function get isRare() : Boolean
      {
         return isRare$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasChargePoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,chargePoint$field);
         }
         if(hasOneNeedPoint)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,oneNeedPoint$field);
         }
         if(hasLeftNeedPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,leftNeedPoint$field);
         }
         if(hasLeftCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,leftCount$field);
         }
         if(hasDayMaxCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,dayMaxCount$field);
         }
         if(hasDayAddCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,dayAddCount$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < reward.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,reward[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < logs.length)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,logs[_loc4_]);
            _loc4_++;
         }
         if(hasIsOneKey)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,isOneKey$field);
         }
         if(hasIsRare)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,isRare$field);
         }
         _loc3_ = 0;
         while(_loc3_ < resultPos.length)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,resultPos[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc5_:LotteryItemMsg = null;
         var _loc15_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.op cannot be set twice.");
                  }
                  _loc15_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.chargePoint cannot be set twice.");
                  }
                  _loc11_++;
                  chargePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.oneNeedPoint cannot be set twice.");
                  }
                  _loc12_++;
                  oneNeedPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.leftNeedPoint cannot be set twice.");
                  }
                  _loc7_++;
                  leftNeedPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.leftCount cannot be set twice.");
                  }
                  _loc13_++;
                  leftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.dayMaxCount cannot be set twice.");
                  }
                  _loc6_++;
                  dayMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.dayAddCount cannot be set twice.");
                  }
                  _loc9_++;
                  dayAddCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.openTime cannot be set twice.");
                  }
                  _loc8_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.stopTime cannot be set twice.");
                  }
                  _loc10_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  _loc5_ = new LotteryItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  reward.push(_loc5_);
                  break;
               case 10:
                  logs.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.isOneKey cannot be set twice.");
                  }
                  _loc3_++;
                  isOneKey = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChargePointLotteryMsg.isRare cannot be set twice.");
                  }
                  _loc4_++;
                  isRare = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if((_loc14_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,resultPos);
                  }
                  else
                  {
                     resultPos.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

