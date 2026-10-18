package com.road.yishi.proto.sumpassion
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EggMsg extends Message implements IExternalizable
   {
      
      private var profile$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isFree$field:Boolean;
      
      private var buttonState$field:int;
      
      private var leftTime$field:int;
      
      private var needPoint$field:int;
      
      private var boxRewardState$field:int;
      
      [ArrayElementType("com.road.yishi.proto.sumpassion.EggItemMsg")]
      public var randomOpenTemps:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.sumpassion.EggItemMsg")]
      public var boxRewardsTemps:Array = [];
      
      private var needTime$field:int;
      
      public function EggMsg()
      {
         super();
      }
      
      public function removeProfile() : void
      {
         hasField$0 &= 4294967294;
         profile$field = new int();
      }
      
      public function get hasProfile() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set profile(param1:int) : void
      {
         hasField$0 |= 1;
         profile$field = param1;
      }
      
      public function get profile() : int
      {
         return profile$field;
      }
      
      public function removeIsFree() : void
      {
         hasField$0 &= 4294967293;
         isFree$field = new Boolean();
      }
      
      public function get hasIsFree() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isFree(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isFree$field = param1;
      }
      
      public function get isFree() : Boolean
      {
         return isFree$field;
      }
      
      public function removeButtonState() : void
      {
         hasField$0 &= 4294967291;
         buttonState$field = new int();
      }
      
      public function get hasButtonState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buttonState(param1:int) : void
      {
         hasField$0 |= 4;
         buttonState$field = param1;
      }
      
      public function get buttonState() : int
      {
         return buttonState$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967287;
         leftTime$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 8;
         leftTime$field = param1;
      }
      
      public function get leftTime() : int
      {
         return leftTime$field;
      }
      
      public function removeNeedPoint() : void
      {
         hasField$0 &= 4294967279;
         needPoint$field = new int();
      }
      
      public function get hasNeedPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set needPoint(param1:int) : void
      {
         hasField$0 |= 16;
         needPoint$field = param1;
      }
      
      public function get needPoint() : int
      {
         return needPoint$field;
      }
      
      public function removeBoxRewardState() : void
      {
         hasField$0 &= 4294967263;
         boxRewardState$field = new int();
      }
      
      public function get hasBoxRewardState() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set boxRewardState(param1:int) : void
      {
         hasField$0 |= 32;
         boxRewardState$field = param1;
      }
      
      public function get boxRewardState() : int
      {
         return boxRewardState$field;
      }
      
      public function removeNeedTime() : void
      {
         hasField$0 &= 4294967231;
         needTime$field = new int();
      }
      
      public function get hasNeedTime() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set needTime(param1:int) : void
      {
         hasField$0 |= 64;
         needTime$field = param1;
      }
      
      public function get needTime() : int
      {
         return needTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasProfile)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,profile$field);
         }
         if(hasIsFree)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isFree$field);
         }
         if(hasButtonState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buttonState$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,leftTime$field);
         }
         if(hasNeedPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,needPoint$field);
         }
         if(hasBoxRewardState)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,boxRewardState$field);
         }
         _loc3_ = 0;
         while(_loc3_ < randomOpenTemps.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,randomOpenTemps[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < boxRewardsTemps.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,boxRewardsTemps[_loc2_]);
            _loc2_++;
         }
         if(hasNeedTime)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,needTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:EggItemMsg = null;
         var _loc9_:EggItemMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EggMsg.profile cannot be set twice.");
                  }
                  _loc3_++;
                  profile = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EggMsg.isFree cannot be set twice.");
                  }
                  _loc6_++;
                  isFree = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EggMsg.buttonState cannot be set twice.");
                  }
                  _loc7_++;
                  buttonState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: EggMsg.leftTime cannot be set twice.");
                  }
                  _loc11_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: EggMsg.needPoint cannot be set twice.");
                  }
                  _loc10_++;
                  needPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EggMsg.boxRewardState cannot be set twice.");
                  }
                  _loc4_++;
                  boxRewardState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc5_ = new EggItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  randomOpenTemps.push(_loc5_);
                  break;
               case 7:
                  _loc9_ = new EggItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  boxRewardsTemps.push(_loc9_);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: EggMsg.needTime cannot be set twice.");
                  }
                  _loc12_++;
                  needTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

