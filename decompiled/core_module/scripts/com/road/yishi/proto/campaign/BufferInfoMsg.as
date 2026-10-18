package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BufferInfoMsg extends Message implements IExternalizable
   {
      
      private var buffer_tempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var left_time$field:int;
      
      private var add_count$field:int;
      
      public function BufferInfoMsg()
      {
         super();
      }
      
      public function removeBufferTempId() : void
      {
         hasField$0 &= 4294967294;
         buffer_tempId$field = new int();
      }
      
      public function get hasBufferTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bufferTempId(param1:int) : void
      {
         hasField$0 |= 1;
         buffer_tempId$field = param1;
      }
      
      public function get bufferTempId() : int
      {
         return buffer_tempId$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967293;
         left_time$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 2;
         left_time$field = param1;
      }
      
      public function get leftTime() : int
      {
         return left_time$field;
      }
      
      public function removeAddCount() : void
      {
         hasField$0 &= 4294967291;
         add_count$field = new int();
      }
      
      public function get hasAddCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set addCount(param1:int) : void
      {
         hasField$0 |= 4;
         add_count$field = param1;
      }
      
      public function get addCount() : int
      {
         return add_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBufferTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,buffer_tempId$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,left_time$field);
         }
         if(hasAddCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,add_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BufferInfoMsg.bufferTempId cannot be set twice.");
                  }
                  _loc5_++;
                  bufferTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BufferInfoMsg.leftTime cannot be set twice.");
                  }
                  _loc4_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BufferInfoMsg.addCount cannot be set twice.");
                  }
                  _loc3_++;
                  addCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

