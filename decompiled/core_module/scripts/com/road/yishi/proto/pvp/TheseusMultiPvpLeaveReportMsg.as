package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusMultiPvpLeaveReportMsg extends Message implements IExternalizable
   {
      
      private var rank$field:int;
      
      private var hasField$0:uint = 0;
      
      private var integral$field:int;
      
      private var pvpId$field:int;
      
      private var lastRank$field:int;
      
      private var lastIntegral$field:int;
      
      private var lastPvpId$field:int;
      
      public function TheseusMultiPvpLeaveReportMsg()
      {
         super();
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967294;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 1;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeIntegral() : void
      {
         hasField$0 &= 4294967293;
         integral$field = new int();
      }
      
      public function get hasIntegral() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set integral(param1:int) : void
      {
         hasField$0 |= 2;
         integral$field = param1;
      }
      
      public function get integral() : int
      {
         return integral$field;
      }
      
      public function removePvpId() : void
      {
         hasField$0 &= 4294967291;
         pvpId$field = new int();
      }
      
      public function get hasPvpId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pvpId(param1:int) : void
      {
         hasField$0 |= 4;
         pvpId$field = param1;
      }
      
      public function get pvpId() : int
      {
         return pvpId$field;
      }
      
      public function removeLastRank() : void
      {
         hasField$0 &= 4294967287;
         lastRank$field = new int();
      }
      
      public function get hasLastRank() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set lastRank(param1:int) : void
      {
         hasField$0 |= 8;
         lastRank$field = param1;
      }
      
      public function get lastRank() : int
      {
         return lastRank$field;
      }
      
      public function removeLastIntegral() : void
      {
         hasField$0 &= 4294967279;
         lastIntegral$field = new int();
      }
      
      public function get hasLastIntegral() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set lastIntegral(param1:int) : void
      {
         hasField$0 |= 16;
         lastIntegral$field = param1;
      }
      
      public function get lastIntegral() : int
      {
         return lastIntegral$field;
      }
      
      public function removeLastPvpId() : void
      {
         hasField$0 &= 4294967263;
         lastPvpId$field = new int();
      }
      
      public function get hasLastPvpId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set lastPvpId(param1:int) : void
      {
         hasField$0 |= 32;
         lastPvpId$field = param1;
      }
      
      public function get lastPvpId() : int
      {
         return lastPvpId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasIntegral)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,integral$field);
         }
         if(hasPvpId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pvpId$field);
         }
         if(hasLastRank)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,lastRank$field);
         }
         if(hasLastIntegral)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,lastIntegral$field);
         }
         if(hasLastPvpId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,lastPvpId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpLeaveReportMsg.rank cannot be set twice.");
                  }
                  _loc3_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpLeaveReportMsg.integral cannot be set twice.");
                  }
                  _loc8_++;
                  integral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpLeaveReportMsg.pvpId cannot be set twice.");
                  }
                  _loc4_++;
                  pvpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpLeaveReportMsg.lastRank cannot be set twice.");
                  }
                  _loc6_++;
                  lastRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpLeaveReportMsg.lastIntegral cannot be set twice.");
                  }
                  _loc5_++;
                  lastIntegral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusMultiPvpLeaveReportMsg.lastPvpId cannot be set twice.");
                  }
                  _loc7_++;
                  lastPvpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

