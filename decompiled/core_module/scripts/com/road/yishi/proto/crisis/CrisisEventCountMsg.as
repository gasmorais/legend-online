package com.road.yishi.proto.crisis
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrisisEventCountMsg extends Message implements IExternalizable
   {
      
      private var eventType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var eventMaxCount$field:int;
      
      public function CrisisEventCountMsg()
      {
         super();
      }
      
      public function removeEventType() : void
      {
         hasField$0 &= 4294967294;
         eventType$field = new int();
      }
      
      public function get hasEventType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set eventType(param1:int) : void
      {
         hasField$0 |= 1;
         eventType$field = param1;
      }
      
      public function get eventType() : int
      {
         return eventType$field;
      }
      
      public function removeEventMaxCount() : void
      {
         hasField$0 &= 4294967293;
         eventMaxCount$field = new int();
      }
      
      public function get hasEventMaxCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set eventMaxCount(param1:int) : void
      {
         hasField$0 |= 2;
         eventMaxCount$field = param1;
      }
      
      public function get eventMaxCount() : int
      {
         return eventMaxCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasEventType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,eventType$field);
         }
         if(hasEventMaxCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,eventMaxCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisEventCountMsg.eventType cannot be set twice.");
                  }
                  _loc5_++;
                  eventType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisEventCountMsg.eventMaxCount cannot be set twice.");
                  }
                  _loc3_++;
                  eventMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

