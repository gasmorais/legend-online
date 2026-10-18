package com.road.yishi.proto.crisis
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrisisNodeInfo extends Message implements IExternalizable
   {
      
      private var nodeId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var eventId$field:int;
      
      private var isOpen$field:Boolean;
      
      private var isPick$field:Boolean;
      
      public function CrisisNodeInfo()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967293;
         eventId$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 2;
         eventId$field = param1;
      }
      
      public function get eventId() : int
      {
         return eventId$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967291;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeIsPick() : void
      {
         hasField$0 &= 4294967287;
         isPick$field = new Boolean();
      }
      
      public function get hasIsPick() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isPick(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isPick$field = param1;
      }
      
      public function get isPick() : Boolean
      {
         return isPick$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,eventId$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasIsPick)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isPick$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisNodeInfo.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisNodeInfo.eventId cannot be set twice.");
                  }
                  _loc6_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisNodeInfo.isOpen cannot be set twice.");
                  }
                  _loc4_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisNodeInfo.isPick cannot be set twice.");
                  }
                  _loc5_++;
                  isPick = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

