package com.road.yishi.proto.stackhead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadExploreNodeEventStateMsg extends Message implements IExternalizable
   {
      
      private var name$field:String;
      
      private var event_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:Boolean;
      
      public function StackHeadExploreNodeEventStateMsg()
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
      
      public function removeEventType() : void
      {
         hasField$0 &= 4294967294;
         event_type$field = new int();
      }
      
      public function get hasEventType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set eventType(param1:int) : void
      {
         hasField$0 |= 1;
         event_type$field = param1;
      }
      
      public function get eventType() : int
      {
         return event_type$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new Boolean();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:Boolean) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : Boolean
      {
         return state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasEventType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,event_type$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,state$field);
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
                     throw new IOError("Bad data format: StackHeadExploreNodeEventStateMsg.name cannot be set twice.");
                  }
                  _loc3_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreNodeEventStateMsg.state cannot be set twice.");
                  }
                  _loc5_++;
                  state = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreNodeEventStateMsg.eventType cannot be set twice.");
                  }
                  _loc4_++;
                  eventType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

