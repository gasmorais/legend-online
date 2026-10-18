package com.road.yishi.proto.planes
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesWarEventMsg extends Message implements IExternalizable
   {
      
      private var event_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var respond_type$field:int;
      
      [ArrayElementType("int")]
      public var paramInt:Array = [];
      
      public function PlanesWarEventMsg()
      {
         super();
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967294;
         event_id$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 1;
         event_id$field = param1;
      }
      
      public function get eventId() : int
      {
         return event_id$field;
      }
      
      public function removeRespondType() : void
      {
         hasField$0 &= 4294967293;
         respond_type$field = new int();
      }
      
      public function get hasRespondType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set respondType(param1:int) : void
      {
         hasField$0 |= 2;
         respond_type$field = param1;
      }
      
      public function get respondType() : int
      {
         return respond_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,event_id$field);
         }
         if(hasRespondType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,respond_type$field);
         }
         _loc2_ = 0;
         while(_loc2_ < paramInt.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,paramInt[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarEventMsg.eventId cannot be set twice.");
                  }
                  _loc3_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarEventMsg.respondType cannot be set twice.");
                  }
                  _loc4_++;
                  respondType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,paramInt);
                  }
                  else
                  {
                     paramInt.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

