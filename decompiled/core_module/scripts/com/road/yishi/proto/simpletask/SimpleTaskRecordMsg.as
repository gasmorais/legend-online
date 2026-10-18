package com.road.yishi.proto.simpletask
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimpleTaskRecordMsg extends Message implements IExternalizable
   {
      
      private var task_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var task_state$field:int;
      
      public function SimpleTaskRecordMsg()
      {
         super();
      }
      
      public function removeTaskId() : void
      {
         hasField$0 &= 4294967294;
         task_id$field = new int();
      }
      
      public function get hasTaskId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set taskId(param1:int) : void
      {
         hasField$0 |= 1;
         task_id$field = param1;
      }
      
      public function get taskId() : int
      {
         return task_id$field;
      }
      
      public function removeTaskState() : void
      {
         hasField$0 &= 4294967293;
         task_state$field = new int();
      }
      
      public function get hasTaskState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set taskState(param1:int) : void
      {
         hasField$0 |= 2;
         task_state$field = param1;
      }
      
      public function get taskState() : int
      {
         return task_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTaskId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,task_id$field);
         }
         if(hasTaskState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,task_state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskRecordMsg.taskId cannot be set twice.");
                  }
                  _loc4_++;
                  taskId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskRecordMsg.taskState cannot be set twice.");
                  }
                  _loc3_++;
                  taskState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

