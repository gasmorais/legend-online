package com.road.yishi.proto.party
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PartyConsortiaMsgList extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.party.PartyConsortiaMsg")]
      public var info:Array = [];
      
      private var eventId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var op$field:int;
      
      public function PartyConsortiaMsgList()
      {
         super();
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967294;
         eventId$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 1;
         eventId$field = param1;
      }
      
      public function get eventId() : int
      {
         return eventId$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967293;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 2;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,eventId$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:PartyConsortiaMsg = null;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new PartyConsortiaMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  info.push(_loc3_);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsgList.eventId cannot be set twice.");
                  }
                  _loc4_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PartyConsortiaMsgList.op cannot be set twice.");
                  }
                  _loc6_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

