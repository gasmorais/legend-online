package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BonfireEventMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userName$field:String;
      
      private var event_type$field:int;
      
      private var value$field:int;
      
      public function BonfireEventMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeUserName() : void
      {
         userName$field = null;
      }
      
      public function get hasUserName() : Boolean
      {
         return userName$field != null;
      }
      
      public function set userName(param1:String) : void
      {
         userName$field = param1;
      }
      
      public function get userName() : String
      {
         return userName$field;
      }
      
      public function removeEventType() : void
      {
         hasField$0 &= 4294967293;
         event_type$field = new int();
      }
      
      public function get hasEventType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set eventType(param1:int) : void
      {
         hasField$0 |= 2;
         event_type$field = param1;
      }
      
      public function get eventType() : int
      {
         return event_type$field;
      }
      
      public function removeValue() : void
      {
         hasField$0 &= 4294967291;
         value$field = new int();
      }
      
      public function get hasValue() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set value(param1:int) : void
      {
         hasField$0 |= 4;
         value$field = param1;
      }
      
      public function get value() : int
      {
         return value$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasUserName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,userName$field);
         }
         if(hasEventType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,event_type$field);
         }
         if(hasValue)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,value$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BonfireEventMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BonfireEventMsg.userName cannot be set twice.");
                  }
                  _loc3_++;
                  userName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BonfireEventMsg.eventType cannot be set twice.");
                  }
                  _loc4_++;
                  eventType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BonfireEventMsg.value cannot be set twice.");
                  }
                  _loc7_++;
                  value = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

