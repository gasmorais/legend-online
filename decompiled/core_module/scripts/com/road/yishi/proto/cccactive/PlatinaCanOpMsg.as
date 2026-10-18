package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlatinaCanOpMsg extends Message implements IExternalizable
   {
      
      private var drawCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var canType$field:int;
      
      private var hasChance$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.PlatinaItemInfoMsg")]
      public var goldItems:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.cccactive.PlatinaItemInfoMsg")]
      public var platinaItems:Array = [];
      
      public function PlatinaCanOpMsg()
      {
         super();
      }
      
      public function removeDrawCount() : void
      {
         hasField$0 &= 4294967294;
         drawCount$field = new int();
      }
      
      public function get hasDrawCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set drawCount(param1:int) : void
      {
         hasField$0 |= 1;
         drawCount$field = param1;
      }
      
      public function get drawCount() : int
      {
         return drawCount$field;
      }
      
      public function removeCanType() : void
      {
         hasField$0 &= 4294967293;
         canType$field = new int();
      }
      
      public function get hasCanType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set canType(param1:int) : void
      {
         hasField$0 |= 2;
         canType$field = param1;
      }
      
      public function get canType() : int
      {
         return canType$field;
      }
      
      public function removeHasChance() : void
      {
         hasField$0 &= 4294967291;
         hasChance$field = new Boolean();
      }
      
      public function get hasHasChance() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set hasChance(param1:Boolean) : void
      {
         hasField$0 |= 4;
         hasChance$field = param1;
      }
      
      public function get hasChance() : Boolean
      {
         return hasChance$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasDrawCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,drawCount$field);
         }
         if(hasCanType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,canType$field);
         }
         if(hasHasChance)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,hasChance$field);
         }
         _loc3_ = 0;
         while(_loc3_ < goldItems.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,goldItems[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < platinaItems.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,platinaItems[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:PlatinaItemInfoMsg = null;
         var _loc4_:PlatinaItemInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlatinaCanOpMsg.drawCount cannot be set twice.");
                  }
                  _loc3_++;
                  drawCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlatinaCanOpMsg.canType cannot be set twice.");
                  }
                  _loc6_++;
                  canType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlatinaCanOpMsg.hasChance cannot be set twice.");
                  }
                  _loc5_++;
                  hasChance = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  _loc7_ = new PlatinaItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  goldItems.push(_loc7_);
                  break;
               case 4:
                  _loc4_ = new PlatinaItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  platinaItems.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

