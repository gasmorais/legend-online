package com.road.yishi.proto.olderreflux
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OlderRefluxMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      [ArrayElementType("com.road.yishi.proto.olderreflux.OlderRefluxInfoMsg")]
      public var info:Array = [];
      
      private var openState$field:int;
      
      private var chargeTotalCount$field:int;
      
      private var templateId$field:int;
      
      public function OlderRefluxMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeOpenTime() : void
      {
         openTime$field = null;
      }
      
      public function get hasOpenTime() : Boolean
      {
         return openTime$field != null;
      }
      
      public function set openTime(param1:String) : void
      {
         openTime$field = param1;
      }
      
      public function get openTime() : String
      {
         return openTime$field;
      }
      
      public function removeStopTime() : void
      {
         stopTime$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stopTime$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stopTime$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stopTime$field;
      }
      
      public function removeOpenState() : void
      {
         hasField$0 &= 4294967293;
         openState$field = new int();
      }
      
      public function get hasOpenState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set openState(param1:int) : void
      {
         hasField$0 |= 2;
         openState$field = param1;
      }
      
      public function get openState() : int
      {
         return openState$field;
      }
      
      public function removeChargeTotalCount() : void
      {
         hasField$0 &= 4294967291;
         chargeTotalCount$field = new int();
      }
      
      public function get hasChargeTotalCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set chargeTotalCount(param1:int) : void
      {
         hasField$0 |= 4;
         chargeTotalCount$field = param1;
      }
      
      public function get chargeTotalCount() : int
      {
         return chargeTotalCount$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967287;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 8;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         if(hasOpenState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,openState$field);
         }
         if(hasChargeTotalCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,chargeTotalCount$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:OlderRefluxInfoMsg = null;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: OlderRefluxMsg.op cannot be set twice.");
                  }
                  _loc10_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: OlderRefluxMsg.openTime cannot be set twice.");
                  }
                  _loc9_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OlderRefluxMsg.stopTime cannot be set twice.");
                  }
                  _loc3_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  _loc7_ = new OlderRefluxInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  info.push(_loc7_);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OlderRefluxMsg.openState cannot be set twice.");
                  }
                  _loc4_++;
                  openState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OlderRefluxMsg.chargeTotalCount cannot be set twice.");
                  }
                  _loc6_++;
                  chargeTotalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: OlderRefluxMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

