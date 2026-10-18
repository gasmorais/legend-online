package com.road.yishi.proto.sumpassion
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SumGiftList extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      [ArrayElementType("com.road.yishi.proto.sumpassion.LevelMsg")]
      public var buyLevel:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.sumpassion.LevelMsg")]
      public var chargeLevel:Array = [];
      
      private var level$field:int;
      
      private var giftType$field:int;
      
      private var charge$field:int;
      
      public function SumGiftList()
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
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeGiftType() : void
      {
         hasField$0 &= 4294967291;
         giftType$field = new int();
      }
      
      public function get hasGiftType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set giftType(param1:int) : void
      {
         hasField$0 |= 4;
         giftType$field = param1;
      }
      
      public function get giftType() : int
      {
         return giftType$field;
      }
      
      public function removeCharge() : void
      {
         hasField$0 &= 4294967287;
         charge$field = new int();
      }
      
      public function get hasCharge() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set charge(param1:int) : void
      {
         hasField$0 |= 8;
         charge$field = param1;
      }
      
      public function get charge() : int
      {
         return charge$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
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
         _loc3_ = 0;
         while(_loc3_ < buyLevel.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,buyLevel[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < chargeLevel.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,chargeLevel[_loc2_]);
            _loc2_++;
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasGiftType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,giftType$field);
         }
         if(hasCharge)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,charge$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc8_:LevelMsg = null;
         var _loc7_:LevelMsg = null;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SumGiftList.op cannot be set twice.");
                  }
                  _loc11_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SumGiftList.openTime cannot be set twice.");
                  }
                  _loc10_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SumGiftList.stopTime cannot be set twice.");
                  }
                  _loc3_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  _loc8_ = new LevelMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  buyLevel.push(_loc8_);
                  break;
               case 4:
                  _loc7_ = new LevelMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  chargeLevel.push(_loc7_);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SumGiftList.level cannot be set twice.");
                  }
                  _loc4_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SumGiftList.giftType cannot be set twice.");
                  }
                  _loc6_++;
                  giftType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SumGiftList.charge cannot be set twice.");
                  }
                  _loc5_++;
                  charge = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

