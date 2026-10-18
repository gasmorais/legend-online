package com.road.yishi.proto.planes
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesWarGridMsg extends Message implements IExternalizable
   {
      
      private var x$field:int;
      
      private var hasField$0:uint = 0;
      
      private var y$field:int;
      
      private var opened$field:Boolean;
      
      private var event_id$field:int;
      
      private var occupied$field:Boolean;
      
      private var occupy_name$field:String;
      
      public function PlanesWarGridMsg()
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
      
      public function removeOccupied() : void
      {
         hasField$0 &= 4294967279;
         occupied$field = new Boolean();
      }
      
      public function get hasOccupied() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set occupied(param1:Boolean) : void
      {
         hasField$0 |= 16;
         occupied$field = param1;
      }
      
      public function get occupied() : Boolean
      {
         return occupied$field;
      }
      
      public function removeOccupyName() : void
      {
         occupy_name$field = null;
      }
      
      public function get hasOccupyName() : Boolean
      {
         return occupy_name$field != null;
      }
      
      public function set occupyName(param1:String) : void
      {
         occupy_name$field = param1;
      }
      
      public function get occupyName() : String
      {
         return occupy_name$field;
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
         if(hasOccupied)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,occupied$field);
         }
         if(hasOccupyName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,occupy_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarGridMsg.x cannot be set twice.");
                  }
                  _loc4_++;
                  x = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarGridMsg.y cannot be set twice.");
                  }
                  _loc5_++;
                  y = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarGridMsg.opened cannot be set twice.");
                  }
                  _loc7_++;
                  opened = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarGridMsg.eventId cannot be set twice.");
                  }
                  _loc8_++;
                  eventId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarGridMsg.occupied cannot be set twice.");
                  }
                  _loc6_++;
                  occupied = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarGridMsg.occupyName cannot be set twice.");
                  }
                  _loc3_++;
                  occupyName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

