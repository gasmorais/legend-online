package com.road.yishi.proto.leed
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimpleTaskMsg extends Message implements IExternalizable
   {
      
      private var taskId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isComplete$field:int;
      
      public function SimpleTaskMsg()
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
      
      public function removeIsComplete() : void
      {
         hasField$0 &= 4294967293;
         isComplete$field = new int();
      }
      
      public function get hasIsComplete() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isComplete(param1:int) : void
      {
         hasField$0 |= 2;
         isComplete$field = param1;
      }
      
      public function get isComplete() : int
      {
         return isComplete$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTaskId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,taskId$field);
         }
         if(hasIsComplete)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,isComplete$field);
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
                     throw new IOError("Bad data format: SimpleTaskMsg.taskId cannot be set twice.");
                  }
                  _loc3_++;
                  taskId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleTaskMsg.isComplete cannot be set twice.");
                  }
                  _loc5_++;
                  isComplete = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

