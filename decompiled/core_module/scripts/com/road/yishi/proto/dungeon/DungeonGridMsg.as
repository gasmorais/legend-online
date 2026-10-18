package com.road.yishi.proto.dungeon
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DungeonGridMsg extends Message implements IExternalizable
   {
      
      private var x$field:int;
      
      private var hasField$0:uint = 0;
      
      private var y$field:int;
      
      private var opened$field:Boolean;
      
      private var event_id$field:int;
      
      public function DungeonGridMsg()
      {
         super();
      }
      
      public function removeX() : void
      {
         hasField$0 &= 4294967294;
         x$field = new int();
      }
      
      public function get hasX() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set x(param1:int) : void
      {
         hasField$0 |= 1;
         x$field = param1;
      }
      
      public function get x() : int
      {
         return x$field;
      }
      
      public function removeY() : void
      {
         hasField$0 &= 4294967293;
         y$field = new int();
      }
      
      public function get hasY() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set y(param1:int) : void
      {
         hasField$0 |= 2;
         y$field = param1;
      }
      
      public function get y() : int
      {
         return y$field;
      }
      
      public function removeOpened() : void
      {
         hasField$0 &= 4294967291;
         opened$field = new Boolean();
      }
      
      public function get hasOpened() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set opened(param1:Boolean) : void
      {
         hasField$0 |= 4;
         opened$field = param1;
      }
      
      public function get opened() : Boolean
      {
         return opened$field;
      }
      
      public function removeEventId() : void
      {
         hasField$0 &= 4294967287;
         event_id$field = new int();
      }
      
      public function get hasEventId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set eventId(param1:int) : void
      {
         hasField$0 |= 8;
         event_id$field = param1;
      }
      
      public function get eventId() : int
      {
         return event_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasX)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,x$field);
         }
         if(hasY)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,y$field);
         }
         if(hasOpened)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,opened$field);
         }
         if(hasEventId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,event_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonGridMsg.x cannot be set twice.");
                  }
                  _loc3_++;
                  x = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonGridMsg.y cannot be set twice.");
                  }
                  _loc4_++;
                  y = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonGridMsg.opened cannot be set twice.");
                  }
                  _loc5_++;
                  opened = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonGridMsg.eventId cannot be set twice.");
                  }
                  _loc6_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

