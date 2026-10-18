package com.road.yishi.proto.sumpassion
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EncoGoldListMsg extends Message implements IExternalizable
   {
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      private var totalTakePoint$field:int;
      
      private var hasField$0:uint = 0;
      
      private var totalBackPoint$field:int;
      
      private var limitConsumePoint$field:int;
      
      private var limitBackPer$field:int;
      
      private var maxBackPer$field:int;
      
      private var maxBackPoint$field:int;
      
      [ArrayElementType("com.road.yishi.proto.sumpassion.EncoDayMsg")]
      public var dayMsg:Array = [];
      
      public function EncoGoldListMsg()
      {
         super();
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
      
      public function removeTotalTakePoint() : void
      {
         hasField$0 &= 4294967294;
         totalTakePoint$field = new int();
      }
      
      public function get hasTotalTakePoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set totalTakePoint(param1:int) : void
      {
         hasField$0 |= 1;
         totalTakePoint$field = param1;
      }
      
      public function get totalTakePoint() : int
      {
         return totalTakePoint$field;
      }
      
      public function removeTotalBackPoint() : void
      {
         hasField$0 &= 4294967293;
         totalBackPoint$field = new int();
      }
      
      public function get hasTotalBackPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalBackPoint(param1:int) : void
      {
         hasField$0 |= 2;
         totalBackPoint$field = param1;
      }
      
      public function get totalBackPoint() : int
      {
         return totalBackPoint$field;
      }
      
      public function removeLimitConsumePoint() : void
      {
         hasField$0 &= 4294967291;
         limitConsumePoint$field = new int();
      }
      
      public function get hasLimitConsumePoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set limitConsumePoint(param1:int) : void
      {
         hasField$0 |= 4;
         limitConsumePoint$field = param1;
      }
      
      public function get limitConsumePoint() : int
      {
         return limitConsumePoint$field;
      }
      
      public function removeLimitBackPer() : void
      {
         hasField$0 &= 4294967287;
         limitBackPer$field = new int();
      }
      
      public function get hasLimitBackPer() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set limitBackPer(param1:int) : void
      {
         hasField$0 |= 8;
         limitBackPer$field = param1;
      }
      
      public function get limitBackPer() : int
      {
         return limitBackPer$field;
      }
      
      public function removeMaxBackPer() : void
      {
         hasField$0 &= 4294967279;
         maxBackPer$field = new int();
      }
      
      public function get hasMaxBackPer() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set maxBackPer(param1:int) : void
      {
         hasField$0 |= 16;
         maxBackPer$field = param1;
      }
      
      public function get maxBackPer() : int
      {
         return maxBackPer$field;
      }
      
      public function removeMaxBackPoint() : void
      {
         hasField$0 &= 4294967263;
         maxBackPoint$field = new int();
      }
      
      public function get hasMaxBackPoint() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set maxBackPoint(param1:int) : void
      {
         hasField$0 |= 32;
         maxBackPoint$field = param1;
      }
      
      public function get maxBackPoint() : int
      {
         return maxBackPoint$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         if(hasTotalTakePoint)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,totalTakePoint$field);
         }
         if(hasTotalBackPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,totalBackPoint$field);
         }
         if(hasLimitConsumePoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,limitConsumePoint$field);
         }
         if(hasLimitBackPer)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,limitBackPer$field);
         }
         if(hasMaxBackPer)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,maxBackPer$field);
         }
         if(hasMaxBackPoint)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,maxBackPoint$field);
         }
         _loc2_ = 0;
         while(_loc2_ < dayMsg.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,dayMsg[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc3_:EncoDayMsg = null;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: EncoGoldListMsg.openTime cannot be set twice.");
                  }
                  _loc10_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EncoGoldListMsg.stopTime cannot be set twice.");
                  }
                  _loc4_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EncoGoldListMsg.totalTakePoint cannot be set twice.");
                  }
                  _loc5_++;
                  totalTakePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EncoGoldListMsg.totalBackPoint cannot be set twice.");
                  }
                  _loc7_++;
                  totalBackPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: EncoGoldListMsg.limitConsumePoint cannot be set twice.");
                  }
                  _loc12_++;
                  limitConsumePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EncoGoldListMsg.limitBackPer cannot be set twice.");
                  }
                  _loc6_++;
                  limitBackPer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EncoGoldListMsg.maxBackPer cannot be set twice.");
                  }
                  _loc8_++;
                  maxBackPer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: EncoGoldListMsg.maxBackPoint cannot be set twice.");
                  }
                  _loc11_++;
                  maxBackPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc3_ = new EncoDayMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  dayMsg.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

