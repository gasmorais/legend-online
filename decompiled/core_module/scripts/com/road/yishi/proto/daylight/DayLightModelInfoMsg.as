package com.road.yishi.proto.daylight
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DayLightModelInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var x$field:int;
      
      private var y$field:int;
      
      private var type$field:int;
      
      private var count$field:int;
      
      private var speed$field:int;
      
      private var state$field:int;
      
      private var isFight$field:Boolean;
      
      public function DayLightModelInfoMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeX() : void
      {
         hasField$0 &= 4294967293;
         x$field = new int();
      }
      
      public function get hasX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set x(param1:int) : void
      {
         hasField$0 |= 2;
         x$field = param1;
      }
      
      public function get x() : int
      {
         return x$field;
      }
      
      public function removeY() : void
      {
         hasField$0 &= 4294967291;
         y$field = new int();
      }
      
      public function get hasY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set y(param1:int) : void
      {
         hasField$0 |= 4;
         y$field = param1;
      }
      
      public function get y() : int
      {
         return y$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967287;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 8;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeSpeed() : void
      {
         hasField$0 &= 4294967263;
         speed$field = new int();
      }
      
      public function get hasSpeed() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set speed(param1:int) : void
      {
         hasField$0 |= 32;
         speed$field = param1;
      }
      
      public function get speed() : int
      {
         return speed$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967231;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 64;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeIsFight() : void
      {
         hasField$0 &= 4294967167;
         isFight$field = new Boolean();
      }
      
      public function get hasIsFight() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isFight$field = param1;
      }
      
      public function get isFight() : Boolean
      {
         return isFight$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,x$field);
         }
         if(hasY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,y$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasSpeed)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,speed$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasIsFight)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isFight$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightModelInfoMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightModelInfoMsg.x cannot be set twice.");
                  }
                  _loc3_++;
                  x = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightModelInfoMsg.y cannot be set twice.");
                  }
                  _loc4_++;
                  y = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightModelInfoMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightModelInfoMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightModelInfoMsg.speed cannot be set twice.");
                  }
                  _loc9_++;
                  speed = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightModelInfoMsg.state cannot be set twice.");
                  }
                  _loc7_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightModelInfoMsg.isFight cannot be set twice.");
                  }
                  _loc11_++;
                  isFight = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

