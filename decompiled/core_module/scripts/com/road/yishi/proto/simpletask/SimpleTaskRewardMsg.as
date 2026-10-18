package com.road.yishi.proto.simpletask
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimpleTaskRewardMsg extends Message implements IExternalizable
   {
      
      private var rewardItemID$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rewardItemCount$field:int;
      
      private var toJob$field:int;
      
      public function SimpleTaskRewardMsg()
      {
         super();
      }
      
      public function removeRewardItemID() : void
      {
         hasField$0 &= 4294967294;
         rewardItemID$field = new int();
      }
      
      public function get hasRewardItemID() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rewardItemID(param1:int) : void
      {
         hasField$0 |= 1;
         rewardItemID$field = param1;
      }
      
      public function get rewardItemID() : int
      {
         return rewardItemID$field;
      }
      
      public function removeRewardItemCount() : void
      {
         hasField$0 &= 4294967293;
         rewardItemCount$field = new int();
      }
      
      public function get hasRewardItemCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rewardItemCount(param1:int) : void
      {
         hasField$0 |= 2;
         rewardItemCount$field = param1;
      }
      
      public function get rewardItemCount() : int
      {
         return rewardItemCount$field;
      }
      
      public function removeToJob() : void
      {
         hasField$0 &= 4294967291;
         toJob$field = new int();
      }
      
      public function get hasToJob() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set toJob(param1:int) : void
      {
         hasField$0 |= 4;
         toJob$field = param1;
      }
      
      public function get toJob() : int
      {
         return toJob$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRewardItemID)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rewardItemID$field);
         }
         if(hasRewardItemCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,rewardItemCount$field);
         }
         if(hasToJob)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,toJob$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskRewardMsg.rewardItemID cannot be set twice.");
                  }
                  _loc3_++;
                  rewardItemID = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskRewardMsg.rewardItemCount cannot be set twice.");
                  }
                  _loc4_++;
                  rewardItemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskRewardMsg.toJob cannot be set twice.");
                  }
                  _loc5_++;
                  toJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

