package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class InfoReqMsg extends Message implements IExternalizable
   {
      
      private var other_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var from$field:int;
      
      public function InfoReqMsg()
      {
         super();
      }
      
      public function removeOtherId() : void
      {
         hasField$0 &= 4294967294;
         other_id$field = new int();
      }
      
      public function get hasOtherId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set otherId(param1:int) : void
      {
         hasField$0 |= 1;
         other_id$field = param1;
      }
      
      public function get otherId() : int
      {
         return other_id$field;
      }
      
      public function removeFrom() : void
      {
         hasField$0 &= 4294967293;
         from$field = new int();
      }
      
      public function get hasFrom() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set from(param1:int) : void
      {
         hasField$0 |= 2;
         from$field = param1;
      }
      
      public function get from() : int
      {
         return from$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOtherId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,other_id$field);
         }
         if(hasFrom)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,from$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: InfoReqMsg.otherId cannot be set twice.");
                  }
                  _loc4_++;
                  otherId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: InfoReqMsg.from cannot be set twice.");
                  }
                  _loc5_++;
                  from = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

