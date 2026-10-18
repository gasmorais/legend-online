package com.road.yishi.proto.theseusdungeon
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusDungeonBlockInfo extends Message implements IExternalizable
   {
      
      private var position$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var eventId$field:int;
      
      public function TheseusDungeonBlockInfo()
      {
         super();
      }
      
      public function removePosition() : void
      {
         hasField$0 &= 4294967294;
         position$field = new int();
      }
      
      public function get hasPosition() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set position(param1:int) : void
      {
         hasField$0 |= 1;
         position$field = param1;
      }
      
      public function get position() : int
      {
         return position$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967291;
         eventId$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 4;
         eventId$field = param1;
      }
      
      public function get eventId() : int
      {
         return eventId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPosition)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,position$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,eventId$field);
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
                     throw new IOError("Bad data format: TheseusDungeonBlockInfo.position cannot be set twice.");
                  }
                  _loc3_++;
                  position = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusDungeonBlockInfo.state cannot be set twice.");
                  }
                  _loc4_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusDungeonBlockInfo.eventId cannot be set twice.");
                  }
                  _loc5_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

