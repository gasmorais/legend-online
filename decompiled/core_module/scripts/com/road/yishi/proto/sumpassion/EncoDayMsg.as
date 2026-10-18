package com.road.yishi.proto.sumpassion
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EncoDayMsg extends Message implements IExternalizable
   {
      
      private var dayStr$field:String;
      
      private var encoType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isDouble$field:Boolean;
      
      private var isTaked$field:Boolean;
      
      private var takePoint$field:int;
      
      private var ConsumPoint$field:int;
      
      public function EncoDayMsg()
      {
         super();
      }
      
      public function removeDayStr() : void
      {
         dayStr$field = null;
      }
      
      public function get hasDayStr() : Boolean
      {
         return dayStr$field != null;
      }
      
      public function set dayStr(param1:String) : void
      {
         dayStr$field = param1;
      }
      
      public function get dayStr() : String
      {
         return dayStr$field;
      }
      
      public function removeEncoType() : void
      {
         hasField$0 &= 4294967294;
         encoType$field = new int();
      }
      
      public function get hasEncoType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set encoType(param1:int) : void
      {
         hasField$0 |= 1;
         encoType$field = param1;
      }
      
      public function get encoType() : int
      {
         return encoType$field;
      }
      
      public function removeIsDouble() : void
      {
         hasField$0 &= 4294967293;
         isDouble$field = new Boolean();
      }
      
      public function get hasIsDouble() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isDouble(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isDouble$field = param1;
      }
      
      public function get isDouble() : Boolean
      {
         return isDouble$field;
      }
      
      public function removeIsTaked() : void
      {
         hasField$0 &= 4294967291;
         isTaked$field = new Boolean();
      }
      
      public function get hasIsTaked() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isTaked(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isTaked$field = param1;
      }
      
      public function get isTaked() : Boolean
      {
         return isTaked$field;
      }
      
      public function removeTakePoint() : void
      {
         hasField$0 &= 4294967287;
         takePoint$field = new int();
      }
      
      public function get hasTakePoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set takePoint(param1:int) : void
      {
         hasField$0 |= 8;
         takePoint$field = param1;
      }
      
      public function get takePoint() : int
      {
         return takePoint$field;
      }
      
      public function removeConsumPoint() : void
      {
         hasField$0 &= 4294967279;
         ConsumPoint$field = new int();
      }
      
      public function get hasConsumPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set consumPoint(param1:int) : void
      {
         hasField$0 |= 16;
         ConsumPoint$field = param1;
      }
      
      public function get consumPoint() : int
      {
         return ConsumPoint$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasDayStr)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,dayStr$field);
         }
         if(hasEncoType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,encoType$field);
         }
         if(hasIsDouble)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isDouble$field);
         }
         if(hasIsTaked)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isTaked$field);
         }
         if(hasTakePoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,takePoint$field);
         }
         if(hasConsumPoint)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,ConsumPoint$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EncoDayMsg.dayStr cannot be set twice.");
                  }
                  _loc5_++;
                  dayStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EncoDayMsg.encoType cannot be set twice.");
                  }
                  _loc3_++;
                  encoType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EncoDayMsg.isDouble cannot be set twice.");
                  }
                  _loc7_++;
                  isDouble = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EncoDayMsg.isTaked cannot be set twice.");
                  }
                  _loc4_++;
                  isTaked = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: EncoDayMsg.takePoint cannot be set twice.");
                  }
                  _loc9_++;
                  takePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EncoDayMsg.consumPoint cannot be set twice.");
                  }
                  _loc8_++;
                  consumPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

