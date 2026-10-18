package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PvpMsg extends Message implements IExternalizable
   {
      
      private var eventType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.pvp.PvpInfoMsg")]
      public var pvpInfo:Array = [];
      
      public function PvpMsg()
      {
         super();
      }
      
      public function removeEventType() : void
      {
         hasField$0 &= 4294967294;
         eventType$field = new int();
      }
      
      public function get hasEventType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set eventType(param1:int) : void
      {
         hasField$0 |= 1;
         eventType$field = param1;
      }
      
      public function get eventType() : int
      {
         return eventType$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967293;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 2;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967291;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 4;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294967287;
         param3$field = new Boolean();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param3(param1:Boolean) : void
      {
         hasField$0 |= 8;
         param3$field = param1;
      }
      
      public function get param3() : Boolean
      {
         return param3$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasEventType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,eventType$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,param3$field);
         }
         _loc2_ = 0;
         while(_loc2_ < pvpInfo.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,pvpInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:PvpInfoMsg = null;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PvpMsg.eventType cannot be set twice.");
                  }
                  _loc7_++;
                  eventType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PvpMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PvpMsg.param2 cannot be set twice.");
                  }
                  _loc8_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PvpMsg.param3 cannot be set twice.");
                  }
                  _loc5_++;
                  param3 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  _loc3_ = new PvpInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  pvpInfo.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

