package com.road.yishi.proto.skytrial
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTrialSearchMsg extends Message implements IExternalizable
   {
      
      private var portal_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var event_id$field:int;
      
      [ArrayElementType("int")]
      public var rewardList:Array = [];
      
      public function SkyTrialSearchMsg()
      {
         super();
      }
      
      public function removePortalId() : void
      {
         hasField$0 &= 4294967294;
         portal_id$field = new int();
      }
      
      public function get hasPortalId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set portalId(param1:int) : void
      {
         hasField$0 |= 1;
         portal_id$field = param1;
      }
      
      public function get portalId() : int
      {
         return portal_id$field;
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967293;
         event_id$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 2;
         event_id$field = param1;
      }
      
      public function get eventId() : int
      {
         return event_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasPortalId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,portal_id$field);
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,event_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rewardList.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rewardList[_loc2_]);
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
                     throw new IOError("Bad data format: SkyTrialSearchMsg.portalId cannot be set twice.");
                  }
                  _loc3_++;
                  portalId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialSearchMsg.eventId cannot be set twice.");
                  }
                  _loc4_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,rewardList);
                  }
                  else
                  {
                     rewardList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

