package com.road.yishi.proto.party
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PartyMsg extends Message implements IExternalizable
   {
      
      private var uUid$field:String;
      
      private var serverUid$field:String;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      private var chargeScoreSet$field:String;
      
      private var consumScoreSet$field:String;
      
      private var myTotalScore$field:int;
      
      private var hasField$0:uint = 0;
      
      private var myChargePoint$field:int;
      
      private var myConsumPoint$field:int;
      
      private var myLeedScore$field:int;
      
      private var myConsortiaScore$field:int;
      
      private var myServerScore$field:int;
      
      [ArrayElementType("com.road.yishi.proto.party.PartyRewardMsg")]
      public var chargeReward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.party.PartyRewardMsg")]
      public var comsumReward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.party.PartyRewardMsg")]
      public var leedsReward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.party.PartyRewardMsg")]
      public var playerScoreReward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.party.PartyRewardMsg")]
      public var consortiaScoreReward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.party.PartyRewardMsg")]
      public var serverScoreReward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.party.PartyRewardMsg")]
      public var consortiaCrossOrderReward:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.party.PartyRewardMsg")]
      public var serverCrossOrderReward:Array = [];
      
      public function PartyMsg()
      {
         super();
      }
      
      public function removeUUid() : void
      {
         uUid$field = null;
      }
      
      public function get hasUUid() : Boolean
      {
         return uUid$field != null;
      }
      
      public function set uUid(param1:String) : void
      {
         uUid$field = param1;
      }
      
      public function get uUid() : String
      {
         return uUid$field;
      }
      
      public function removeServerUid() : void
      {
         serverUid$field = null;
      }
      
      public function get hasServerUid() : Boolean
      {
         return serverUid$field != null;
      }
      
      public function set serverUid(param1:String) : void
      {
         serverUid$field = param1;
      }
      
      public function get serverUid() : String
      {
         return serverUid$field;
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
      
      public function removeChargeScoreSet() : void
      {
         chargeScoreSet$field = null;
      }
      
      public function get hasChargeScoreSet() : Boolean
      {
         return chargeScoreSet$field != null;
      }
      
      public function set chargeScoreSet(param1:String) : void
      {
         chargeScoreSet$field = param1;
      }
      
      public function get chargeScoreSet() : String
      {
         return chargeScoreSet$field;
      }
      
      public function removeConsumScoreSet() : void
      {
         consumScoreSet$field = null;
      }
      
      public function get hasConsumScoreSet() : Boolean
      {
         return consumScoreSet$field != null;
      }
      
      public function set consumScoreSet(param1:String) : void
      {
         consumScoreSet$field = param1;
      }
      
      public function get consumScoreSet() : String
      {
         return consumScoreSet$field;
      }
      
      public function removeMyTotalScore() : void
      {
         hasField$0 &= 4294967294;
         myTotalScore$field = new int();
      }
      
      public function get hasMyTotalScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set myTotalScore(param1:int) : void
      {
         hasField$0 |= 1;
         myTotalScore$field = param1;
      }
      
      public function get myTotalScore() : int
      {
         return myTotalScore$field;
      }
      
      public function removeMyChargePoint() : void
      {
         hasField$0 &= 4294967293;
         myChargePoint$field = new int();
      }
      
      public function get hasMyChargePoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set myChargePoint(param1:int) : void
      {
         hasField$0 |= 2;
         myChargePoint$field = param1;
      }
      
      public function get myChargePoint() : int
      {
         return myChargePoint$field;
      }
      
      public function removeMyConsumPoint() : void
      {
         hasField$0 &= 4294967291;
         myConsumPoint$field = new int();
      }
      
      public function get hasMyConsumPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set myConsumPoint(param1:int) : void
      {
         hasField$0 |= 4;
         myConsumPoint$field = param1;
      }
      
      public function get myConsumPoint() : int
      {
         return myConsumPoint$field;
      }
      
      public function removeMyLeedScore() : void
      {
         hasField$0 &= 4294967287;
         myLeedScore$field = new int();
      }
      
      public function get hasMyLeedScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set myLeedScore(param1:int) : void
      {
         hasField$0 |= 8;
         myLeedScore$field = param1;
      }
      
      public function get myLeedScore() : int
      {
         return myLeedScore$field;
      }
      
      public function removeMyConsortiaScore() : void
      {
         hasField$0 &= 4294967279;
         myConsortiaScore$field = new int();
      }
      
      public function get hasMyConsortiaScore() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set myConsortiaScore(param1:int) : void
      {
         hasField$0 |= 16;
         myConsortiaScore$field = param1;
      }
      
      public function get myConsortiaScore() : int
      {
         return myConsortiaScore$field;
      }
      
      public function removeMyServerScore() : void
      {
         hasField$0 &= 4294967263;
         myServerScore$field = new int();
      }
      
      public function get hasMyServerScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set myServerScore(param1:int) : void
      {
         hasField$0 |= 32;
         myServerScore$field = param1;
      }
      
      public function get myServerScore() : int
      {
         return myServerScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc3_:* = 0;
         var _loc9_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         if(hasUUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uUid$field);
         }
         if(hasServerUid)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,serverUid$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         if(hasChargeScoreSet)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,chargeScoreSet$field);
         }
         if(hasConsumScoreSet)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,consumScoreSet$field);
         }
         if(hasMyTotalScore)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,myTotalScore$field);
         }
         if(hasMyChargePoint)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,myChargePoint$field);
         }
         if(hasMyConsumPoint)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,myConsumPoint$field);
         }
         if(hasMyLeedScore)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,myLeedScore$field);
         }
         if(hasMyConsortiaScore)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,myConsortiaScore$field);
         }
         if(hasMyServerScore)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,myServerScore$field);
         }
         _loc4_ = 0;
         while(_loc4_ < chargeReward.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,chargeReward[_loc4_]);
            _loc4_++;
         }
         _loc7_ = 0;
         while(_loc7_ < comsumReward.length)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,comsumReward[_loc7_]);
            _loc7_++;
         }
         _loc8_ = 0;
         while(_loc8_ < leedsReward.length)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_MESSAGE(param1,leedsReward[_loc8_]);
            _loc8_++;
         }
         _loc3_ = 0;
         while(_loc3_ < playerScoreReward.length)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_MESSAGE(param1,playerScoreReward[_loc3_]);
            _loc3_++;
         }
         _loc9_ = 0;
         while(_loc9_ < consortiaScoreReward.length)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_MESSAGE(param1,consortiaScoreReward[_loc9_]);
            _loc9_++;
         }
         _loc2_ = 0;
         while(_loc2_ < serverScoreReward.length)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_MESSAGE(param1,serverScoreReward[_loc2_]);
            _loc2_++;
         }
         _loc5_ = 0;
         while(_loc5_ < consortiaCrossOrderReward.length)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,consortiaCrossOrderReward[_loc5_]);
            _loc5_++;
         }
         _loc6_ = 0;
         while(_loc6_ < serverCrossOrderReward.length)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_MESSAGE(param1,serverCrossOrderReward[_loc6_]);
            _loc6_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc18_:PartyRewardMsg = null;
         var _loc23_:PartyRewardMsg = null;
         var _loc19_:PartyRewardMsg = null;
         var _loc6_:PartyRewardMsg = null;
         var _loc5_:PartyRewardMsg = null;
         var _loc8_:PartyRewardMsg = null;
         var _loc22_:PartyRewardMsg = null;
         var _loc17_:PartyRewardMsg = null;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc16_:uint = 0;
         var _loc20_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.uUid cannot be set twice.");
                  }
                  _loc13_++;
                  uUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.serverUid cannot be set twice.");
                  }
                  _loc10_++;
                  serverUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.openTime cannot be set twice.");
                  }
                  _loc11_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.stopTime cannot be set twice.");
                  }
                  _loc16_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.chargeScoreSet cannot be set twice.");
                  }
                  _loc20_++;
                  chargeScoreSet = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.consumScoreSet cannot be set twice.");
                  }
                  _loc3_++;
                  consumScoreSet = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.myTotalScore cannot be set twice.");
                  }
                  _loc4_++;
                  myTotalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.myChargePoint cannot be set twice.");
                  }
                  _loc12_++;
                  myChargePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.myConsumPoint cannot be set twice.");
                  }
                  _loc9_++;
                  myConsumPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.myLeedScore cannot be set twice.");
                  }
                  _loc14_++;
                  myLeedScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.myConsortiaScore cannot be set twice.");
                  }
                  _loc15_++;
                  myConsortiaScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PartyMsg.myServerScore cannot be set twice.");
                  }
                  _loc7_++;
                  myServerScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  _loc18_ = new PartyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc18_);
                  chargeReward.push(_loc18_);
                  break;
               case 14:
                  _loc23_ = new PartyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc23_);
                  comsumReward.push(_loc23_);
                  break;
               case 15:
                  _loc19_ = new PartyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc19_);
                  leedsReward.push(_loc19_);
                  break;
               case 16:
                  _loc6_ = new PartyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  playerScoreReward.push(_loc6_);
                  break;
               case 17:
                  _loc5_ = new PartyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  consortiaScoreReward.push(_loc5_);
                  break;
               case 18:
                  _loc8_ = new PartyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  serverScoreReward.push(_loc8_);
                  break;
               case 19:
                  _loc22_ = new PartyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc22_);
                  consortiaCrossOrderReward.push(_loc22_);
                  break;
               case 20:
                  _loc17_ = new PartyRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc17_);
                  serverCrossOrderReward.push(_loc17_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

