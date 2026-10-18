package com.road.yishi.proto.leed
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SingleDayMsg extends Message implements IExternalizable
   {
      
      private var day$field:int;
      
      private var hasField$0:uint = 0;
      
      private var getReward$field:int;
      
      [ArrayElementType("com.road.yishi.proto.leed.SimpleTaskMsg")]
      public var simpleTask:Array = [];
      
      public function SingleDayMsg()
      {
         super();
      }
      
      public function removeDay() : void
      {
         hasField$0 &= 4294967294;
         day$field = new int();
      }
      
      public function get hasDay() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set day(param1:int) : void
      {
         hasField$0 |= 1;
         day$field = param1;
      }
      
      public function get day() : int
      {
         return day$field;
      }
      
      public function removeGetReward() : void
      {
         hasField$0 &= 4294967293;
         getReward$field = new int();
      }
      
      public function get hasGetReward() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set getReward(param1:int) : void
      {
         hasField$0 |= 2;
         getReward$field = param1;
      }
      
      public function get getReward() : int
      {
         return getReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasDay)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,day$field);
         }
         if(hasGetReward)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,getReward$field);
         }
         _loc2_ = 0;
         while(_loc2_ < simpleTask.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,simpleTask[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:SimpleTaskMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SingleDayMsg.day cannot be set twice.");
                  }
                  _loc3_++;
                  day = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SingleDayMsg.getReward cannot be set twice.");
                  }
                  _loc4_++;
                  getReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc5_ = new SimpleTaskMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  simpleTask.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

