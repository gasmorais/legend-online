package com.road.yishi.proto.collection
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RewardTask extends Message implements IExternalizable
   {
      
      private var taskId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var status$field:int;
      
      public function RewardTask()
      {
         super();
      }
      
      public function removeTaskId() : void
      {
         hasField$0 &= 4294967294;
         taskId$field = new int();
      }
      
      public function get hasTaskId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set taskId(param1:int) : void
      {
         hasField$0 |= 1;
         taskId$field = param1;
      }
      
      public function get taskId() : int
      {
         return taskId$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967293;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 2;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTaskId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,taskId$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RewardTask.taskId cannot be set twice.");
                  }
                  _loc3_++;
                  taskId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RewardTask.status cannot be set twice.");
                  }
                  _loc5_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

