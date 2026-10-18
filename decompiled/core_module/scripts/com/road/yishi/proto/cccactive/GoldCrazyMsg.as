package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoldCrazyMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      private var currentPoint$field:int;
      
      private var activeLinePoint$field:int;
      
      private var activeRewardPoint$field:int;
      
      private var joinTotalPoint$field:int;
      
      private var joinOnePoint$field:int;
      
      private var onePointPer$field:int;
      
      private var luckMaxCount$field:int;
      
      private var currentLuckCount$field:int;
      
      private var isLuckReward$field:int;
      
      private var myConsumPoint$field:int;
      
      private var myOrder$field:int;
      
      private var myRewardPoint$field:int;
      
      private var myRewardGift$field:int;
      
      private var myRewardType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.GoldCrazyRewardMsg")]
      public var reward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.cccactive.GoldCrazyInfoMsg")]
      public var goldInfo:Array = [];
      
      private var myLuckNum$field:int;
      
      private var activeUuid$field:String;
      
      private var lottery$field:GoldLotteryMsg;
      
      private var state$field:int;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.CrazyOrderInfoMsg")]
      public var orderInfo:Array = [];
      
      private var activeLuckMaxCount$field:int;
      
      public function GoldCrazyMsg()
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
      
      public function removeCurrentPoint() : void
      {
         hasField$0 &= 4294967293;
         currentPoint$field = new int();
      }
      
      public function get hasCurrentPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currentPoint(param1:int) : void
      {
         hasField$0 |= 2;
         currentPoint$field = param1;
      }
      
      public function get currentPoint() : int
      {
         return currentPoint$field;
      }
      
      public function removeActiveLinePoint() : void
      {
         hasField$0 &= 4294967291;
         activeLinePoint$field = new int();
      }
      
      public function get hasActiveLinePoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set activeLinePoint(param1:int) : void
      {
         hasField$0 |= 4;
         activeLinePoint$field = param1;
      }
      
      public function get activeLinePoint() : int
      {
         return activeLinePoint$field;
      }
      
      public function removeActiveRewardPoint() : void
      {
         hasField$0 &= 4294967287;
         activeRewardPoint$field = new int();
      }
      
      public function get hasActiveRewardPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set activeRewardPoint(param1:int) : void
      {
         hasField$0 |= 8;
         activeRewardPoint$field = param1;
      }
      
      public function get activeRewardPoint() : int
      {
         return activeRewardPoint$field;
      }
      
      public function removeJoinTotalPoint() : void
      {
         hasField$0 &= 4294967279;
         joinTotalPoint$field = new int();
      }
      
      public function get hasJoinTotalPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set joinTotalPoint(param1:int) : void
      {
         hasField$0 |= 16;
         joinTotalPoint$field = param1;
      }
      
      public function get joinTotalPoint() : int
      {
         return joinTotalPoint$field;
      }
      
      public function removeJoinOnePoint() : void
      {
         hasField$0 &= 4294967263;
         joinOnePoint$field = new int();
      }
      
      public function get hasJoinOnePoint() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set joinOnePoint(param1:int) : void
      {
         hasField$0 |= 32;
         joinOnePoint$field = param1;
      }
      
      public function get joinOnePoint() : int
      {
         return joinOnePoint$field;
      }
      
      public function removeOnePointPer() : void
      {
         hasField$0 &= 4294967231;
         onePointPer$field = new int();
      }
      
      public function get hasOnePointPer() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set onePointPer(param1:int) : void
      {
         hasField$0 |= 64;
         onePointPer$field = param1;
      }
      
      public function get onePointPer() : int
      {
         return onePointPer$field;
      }
      
      public function removeLuckMaxCount() : void
      {
         hasField$0 &= 4294967167;
         luckMaxCount$field = new int();
      }
      
      public function get hasLuckMaxCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set luckMaxCount(param1:int) : void
      {
         hasField$0 |= 128;
         luckMaxCount$field = param1;
      }
      
      public function get luckMaxCount() : int
      {
         return luckMaxCount$field;
      }
      
      public function removeCurrentLuckCount() : void
      {
         hasField$0 &= 4294967039;
         currentLuckCount$field = new int();
      }
      
      public function get hasCurrentLuckCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set currentLuckCount(param1:int) : void
      {
         hasField$0 |= 256;
         currentLuckCount$field = param1;
      }
      
      public function get currentLuckCount() : int
      {
         return currentLuckCount$field;
      }
      
      public function removeIsLuckReward() : void
      {
         hasField$0 &= 4294966783;
         isLuckReward$field = new int();
      }
      
      public function get hasIsLuckReward() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isLuckReward(param1:int) : void
      {
         hasField$0 |= 512;
         isLuckReward$field = param1;
      }
      
      public function get isLuckReward() : int
      {
         return isLuckReward$field;
      }
      
      public function removeMyConsumPoint() : void
      {
         hasField$0 &= 4294966271;
         myConsumPoint$field = new int();
      }
      
      public function get hasMyConsumPoint() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set myConsumPoint(param1:int) : void
      {
         hasField$0 |= 1024;
         myConsumPoint$field = param1;
      }
      
      public function get myConsumPoint() : int
      {
         return myConsumPoint$field;
      }
      
      public function removeMyOrder() : void
      {
         hasField$0 &= 4294965247;
         myOrder$field = new int();
      }
      
      public function get hasMyOrder() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set myOrder(param1:int) : void
      {
         hasField$0 |= 2048;
         myOrder$field = param1;
      }
      
      public function get myOrder() : int
      {
         return myOrder$field;
      }
      
      public function removeMyRewardPoint() : void
      {
         hasField$0 &= 4294963199;
         myRewardPoint$field = new int();
      }
      
      public function get hasMyRewardPoint() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set myRewardPoint(param1:int) : void
      {
         hasField$0 |= 4096;
         myRewardPoint$field = param1;
      }
      
      public function get myRewardPoint() : int
      {
         return myRewardPoint$field;
      }
      
      public function removeMyRewardGift() : void
      {
         hasField$0 &= 4294959103;
         myRewardGift$field = new int();
      }
      
      public function get hasMyRewardGift() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set myRewardGift(param1:int) : void
      {
         hasField$0 |= 8192;
         myRewardGift$field = param1;
      }
      
      public function get myRewardGift() : int
      {
         return myRewardGift$field;
      }
      
      public function removeMyRewardType() : void
      {
         hasField$0 &= 4294950911;
         myRewardType$field = new int();
      }
      
      public function get hasMyRewardType() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set myRewardType(param1:int) : void
      {
         hasField$0 |= 16384;
         myRewardType$field = param1;
      }
      
      public function get myRewardType() : int
      {
         return myRewardType$field;
      }
      
      public function removeMyLuckNum() : void
      {
         hasField$0 &= 4294934527;
         myLuckNum$field = new int();
      }
      
      public function get hasMyLuckNum() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set myLuckNum(param1:int) : void
      {
         hasField$0 |= 32768;
         myLuckNum$field = param1;
      }
      
      public function get myLuckNum() : int
      {
         return myLuckNum$field;
      }
      
      public function removeActiveUuid() : void
      {
         activeUuid$field = null;
      }
      
      public function get hasActiveUuid() : Boolean
      {
         return activeUuid$field != null;
      }
      
      public function set activeUuid(param1:String) : void
      {
         activeUuid$field = param1;
      }
      
      public function get activeUuid() : String
      {
         return activeUuid$field;
      }
      
      public function removeLottery() : void
      {
         lottery$field = null;
      }
      
      public function get hasLottery() : Boolean
      {
         return lottery$field != null;
      }
      
      public function set lottery(param1:GoldLotteryMsg) : void
      {
         lottery$field = param1;
      }
      
      public function get lottery() : GoldLotteryMsg
      {
         return lottery$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294901759;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 65536;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeActiveLuckMaxCount() : void
      {
         hasField$0 &= 4294836223;
         activeLuckMaxCount$field = new int();
      }
      
      public function get hasActiveLuckMaxCount() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set activeLuckMaxCount(param1:int) : void
      {
         hasField$0 |= 131072;
         activeLuckMaxCount$field = param1;
      }
      
      public function get activeLuckMaxCount() : int
      {
         return activeLuckMaxCount$field;
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
         if(hasCurrentPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,currentPoint$field);
         }
         if(hasActiveLinePoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,activeLinePoint$field);
         }
         if(hasActiveRewardPoint)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,activeRewardPoint$field);
         }
         if(hasJoinTotalPoint)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,joinTotalPoint$field);
         }
         if(hasJoinOnePoint)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,joinOnePoint$field);
         }
         if(hasOnePointPer)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,onePointPer$field);
         }
         if(hasLuckMaxCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,luckMaxCount$field);
         }
         if(hasCurrentLuckCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,currentLuckCount$field);
         }
         if(hasIsLuckReward)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,isLuckReward$field);
         }
         if(hasMyConsumPoint)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,myConsumPoint$field);
         }
         if(hasMyOrder)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,myOrder$field);
         }
         if(hasMyRewardPoint)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,myRewardPoint$field);
         }
         if(hasMyRewardGift)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,myRewardGift$field);
         }
         if(hasMyRewardType)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,myRewardType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < reward.length)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_MESSAGE(param1,reward[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < goldInfo.length)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,goldInfo[_loc3_]);
            _loc3_++;
         }
         if(hasMyLuckNum)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,myLuckNum$field);
         }
         if(hasActiveUuid)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_STRING(param1,activeUuid$field);
         }
         if(hasLottery)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_MESSAGE(param1,lottery$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         _loc4_ = 0;
         while(_loc4_ < orderInfo.length)
         {
            WriteUtils.writeTag(param1,2,24);
            WriteUtils.write$TYPE_MESSAGE(param1,orderInfo[_loc4_]);
            _loc4_++;
         }
         if(hasActiveLuckMaxCount)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,activeLuckMaxCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc20_:GoldCrazyRewardMsg = null;
         var _loc27_:GoldCrazyInfoMsg = null;
         var _loc18_:CrazyOrderInfoMsg = null;
         var _loc28_:uint = 0;
         var _loc21_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc25_:uint = 0;
         var _loc19_:uint = 0;
         var _loc26_:uint = 0;
         var _loc23_:uint = 0;
         var _loc17_:uint = 0;
         var _loc12_:uint = 0;
         var _loc11_:uint = 0;
         var _loc24_:uint = 0;
         var _loc6_:uint = 0;
         var _loc15_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc22_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.op cannot be set twice.");
                  }
                  _loc28_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.openTime cannot be set twice.");
                  }
                  _loc21_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.stopTime cannot be set twice.");
                  }
                  _loc9_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.currentPoint cannot be set twice.");
                  }
                  _loc7_++;
                  currentPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.activeLinePoint cannot be set twice.");
                  }
                  _loc25_++;
                  activeLinePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.activeRewardPoint cannot be set twice.");
                  }
                  _loc19_++;
                  activeRewardPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.joinTotalPoint cannot be set twice.");
                  }
                  _loc26_++;
                  joinTotalPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.joinOnePoint cannot be set twice.");
                  }
                  _loc23_++;
                  joinOnePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.onePointPer cannot be set twice.");
                  }
                  _loc17_++;
                  onePointPer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.luckMaxCount cannot be set twice.");
                  }
                  _loc12_++;
                  luckMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.currentLuckCount cannot be set twice.");
                  }
                  _loc11_++;
                  currentLuckCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.isLuckReward cannot be set twice.");
                  }
                  _loc24_++;
                  isLuckReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.myConsumPoint cannot be set twice.");
                  }
                  _loc6_++;
                  myConsumPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.myOrder cannot be set twice.");
                  }
                  _loc15_++;
                  myOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.myRewardPoint cannot be set twice.");
                  }
                  _loc4_++;
                  myRewardPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.myRewardGift cannot be set twice.");
                  }
                  _loc5_++;
                  myRewardGift = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.myRewardType cannot be set twice.");
                  }
                  _loc3_++;
                  myRewardType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  _loc20_ = new GoldCrazyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc20_);
                  reward.push(_loc20_);
                  break;
               case 19:
                  _loc27_ = new GoldCrazyInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc27_);
                  goldInfo.push(_loc27_);
                  break;
               case 20:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.myLuckNum cannot be set twice.");
                  }
                  _loc22_++;
                  myLuckNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.activeUuid cannot be set twice.");
                  }
                  _loc8_++;
                  activeUuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 22:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.lottery cannot be set twice.");
                  }
                  _loc13_++;
                  lottery = new GoldLotteryMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,lottery);
                  break;
               case 23:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.state cannot be set twice.");
                  }
                  _loc14_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  _loc18_ = new CrazyOrderInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc18_);
                  orderInfo.push(_loc18_);
                  break;
               case 25:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyMsg.activeLuckMaxCount cannot be set twice.");
                  }
                  _loc10_++;
                  activeLuckMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

