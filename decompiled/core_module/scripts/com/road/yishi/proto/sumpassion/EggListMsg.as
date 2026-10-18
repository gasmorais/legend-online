package com.road.yishi.proto.sumpassion
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EggListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.sumpassion.EggMsg")]
      public var egg:Array = [];
      
      private var scoreBoxState$field:String;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var profile$field:int;
      
      private var scoreBoxShow$field:String;
      
      [ArrayElementType("com.road.yishi.proto.sumpassion.EggItemMsg")]
      public var boxRewardsTemps:Array = [];
      
      private var canTake$field:Boolean;
      
      private var allTaked$field:Boolean;
      
      public function EggListMsg()
      {
         super();
      }
      
      public function removeScoreBoxState() : void
      {
         scoreBoxState$field = null;
      }
      
      public function get hasScoreBoxState() : Boolean
      {
         return scoreBoxState$field != null;
      }
      
      public function set scoreBoxState(param1:String) : void
      {
         scoreBoxState$field = param1;
      }
      
      public function get scoreBoxState() : String
      {
         return scoreBoxState$field;
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
      
      public function removeProfile() : void
      {
         hasField$0 &= 4294967293;
         profile$field = new int();
      }
      
      public function get hasProfile() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set profile(param1:int) : void
      {
         hasField$0 |= 2;
         profile$field = param1;
      }
      
      public function get profile() : int
      {
         return profile$field;
      }
      
      public function removeScoreBoxShow() : void
      {
         scoreBoxShow$field = null;
      }
      
      public function get hasScoreBoxShow() : Boolean
      {
         return scoreBoxShow$field != null;
      }
      
      public function set scoreBoxShow(param1:String) : void
      {
         scoreBoxShow$field = param1;
      }
      
      public function get scoreBoxShow() : String
      {
         return scoreBoxShow$field;
      }
      
      public function removeCanTake() : void
      {
         hasField$0 &= 4294967291;
         canTake$field = new Boolean();
      }
      
      public function get hasCanTake() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set canTake(param1:Boolean) : void
      {
         hasField$0 |= 4;
         canTake$field = param1;
      }
      
      public function get canTake() : Boolean
      {
         return canTake$field;
      }
      
      public function removeAllTaked() : void
      {
         hasField$0 &= 4294967287;
         allTaked$field = new Boolean();
      }
      
      public function get hasAllTaked() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set allTaked(param1:Boolean) : void
      {
         hasField$0 |= 8;
         allTaked$field = param1;
      }
      
      public function get allTaked() : Boolean
      {
         return allTaked$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < egg.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,egg[_loc3_]);
            _loc3_++;
         }
         if(hasScoreBoxState)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,scoreBoxState$field);
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
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasProfile)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,profile$field);
         }
         if(hasScoreBoxShow)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,scoreBoxShow$field);
         }
         _loc2_ = 0;
         while(_loc2_ < boxRewardsTemps.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,boxRewardsTemps[_loc2_]);
            _loc2_++;
         }
         if(hasCanTake)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,canTake$field);
         }
         if(hasAllTaked)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,allTaked$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc3_:EggMsg = null;
         var _loc6_:EggItemMsg = null;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new EggMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  egg.push(_loc3_);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EggListMsg.scoreBoxState cannot be set twice.");
                  }
                  _loc8_++;
                  scoreBoxState = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EggListMsg.openTime cannot be set twice.");
                  }
                  _loc7_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: EggListMsg.stopTime cannot be set twice.");
                  }
                  _loc9_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: EggListMsg.op cannot be set twice.");
                  }
                  _loc13_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EggListMsg.profile cannot be set twice.");
                  }
                  _loc4_++;
                  profile = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EggListMsg.scoreBoxShow cannot be set twice.");
                  }
                  _loc5_++;
                  scoreBoxShow = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  _loc6_ = new EggItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  boxRewardsTemps.push(_loc6_);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: EggListMsg.canTake cannot be set twice.");
                  }
                  _loc11_++;
                  canTake = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: EggListMsg.allTaked cannot be set twice.");
                  }
                  _loc10_++;
                  allTaked = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

