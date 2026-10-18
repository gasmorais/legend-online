package com.road.yishi.proto.stackhead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadExploreNodeMsg extends Message implements IExternalizable
   {
      
      private var name$field:String;
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var event_id$field:int;
      
      private var event_type$field:int;
      
      private var triggered$field:Boolean;
      
      public function StackHeadExploreNodeMsg()
      {
         super();
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
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
      
      public function removeEventType() : void
      {
         hasField$0 &= 4294967291;
         event_type$field = new int();
      }
      
      public function get hasEventType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set eventType(param1:int) : void
      {
         hasField$0 |= 4;
         event_type$field = param1;
      }
      
      public function get eventType() : int
      {
         return event_type$field;
      }
      
      public function removeTriggered() : void
      {
         hasField$0 &= 4294967287;
         triggered$field = new Boolean();
      }
      
      public function get hasTriggered() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set triggered(param1:Boolean) : void
      {
         hasField$0 |= 8;
         triggered$field = param1;
      }
      
      public function get triggered() : Boolean
      {
         return triggered$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,event_id$field);
         }
         if(hasEventType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,event_type$field);
         }
         if(hasTriggered)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,triggered$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreNodeMsg.name cannot be set twice.");
                  }
                  _loc3_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreNodeMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreNodeMsg.eventId cannot be set twice.");
                  }
                  _loc5_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreNodeMsg.eventType cannot be set twice.");
                  }
                  _loc4_++;
                  eventType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreNodeMsg.triggered cannot be set twice.");
                  }
                  _loc7_++;
                  triggered = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

