package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TimeJudgeMsg extends Message implements IExternalizable
   {
      
      private var is_add$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var second_count$field:int;
      
      private var stopTime$field:String;
      
      public function TimeJudgeMsg()
      {
         super();
      }
      
      public function removeIsAdd() : void
      {
         hasField$0 &= 4294967294;
         is_add$field = new Boolean();
      }
      
      public function get hasIsAdd() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isAdd(param1:Boolean) : void
      {
         hasField$0 |= 1;
         is_add$field = param1;
      }
      
      public function get isAdd() : Boolean
      {
         return is_add$field;
      }
      
      public function removeSecondCount() : void
      {
         hasField$0 &= 4294967293;
         second_count$field = new int();
      }
      
      public function get hasSecondCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set secondCount(param1:int) : void
      {
         hasField$0 |= 2;
         second_count$field = param1;
      }
      
      public function get secondCount() : int
      {
         return second_count$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsAdd)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,is_add$field);
         }
         if(hasSecondCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,second_count$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TimeJudgeMsg.isAdd cannot be set twice.");
                  }
                  _loc4_++;
                  isAdd = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TimeJudgeMsg.secondCount cannot be set twice.");
                  }
                  _loc5_++;
                  secondCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TimeJudgeMsg.stopTime cannot be set twice.");
                  }
                  _loc3_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

