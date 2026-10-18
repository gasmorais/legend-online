package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LotoInfoMsg extends Message implements IExternalizable
   {
      
      private var bet_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var zoneA$field:int;
      
      private var zoneB$field:int;
      
      public function LotoInfoMsg()
      {
         super();
      }
      
      public function removeBetType() : void
      {
         hasField$0 &= 4294967294;
         bet_type$field = new int();
      }
      
      public function get hasBetType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set betType(param1:int) : void
      {
         hasField$0 |= 1;
         bet_type$field = param1;
      }
      
      public function get betType() : int
      {
         return bet_type$field;
      }
      
      public function removeZoneA() : void
      {
         hasField$0 &= 4294967293;
         zoneA$field = new int();
      }
      
      public function get hasZoneA() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set zoneA(param1:int) : void
      {
         hasField$0 |= 2;
         zoneA$field = param1;
      }
      
      public function get zoneA() : int
      {
         return zoneA$field;
      }
      
      public function removeZoneB() : void
      {
         hasField$0 &= 4294967291;
         zoneB$field = new int();
      }
      
      public function get hasZoneB() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set zoneB(param1:int) : void
      {
         hasField$0 |= 4;
         zoneB$field = param1;
      }
      
      public function get zoneB() : int
      {
         return zoneB$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBetType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,bet_type$field);
         }
         if(hasZoneA)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,zoneA$field);
         }
         if(hasZoneB)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,zoneB$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LotoInfoMsg.betType cannot be set twice.");
                  }
                  _loc4_++;
                  betType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LotoInfoMsg.zoneA cannot be set twice.");
                  }
                  _loc6_++;
                  zoneA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LotoInfoMsg.zoneB cannot be set twice.");
                  }
                  _loc3_++;
                  zoneB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

