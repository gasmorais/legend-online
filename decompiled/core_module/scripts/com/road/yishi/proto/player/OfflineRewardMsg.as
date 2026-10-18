package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OfflineRewardMsg extends Message implements IExternalizable
   {
      
      private var offline_time$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gp_count$field:int;
      
      private var rate_count$field:int;
      
      private var pay_type$field:int;
      
      public function OfflineRewardMsg()
      {
         super();
      }
      
      public function removeOfflineTime() : void
      {
         hasField$0 &= 4294967294;
         offline_time$field = new int();
      }
      
      public function get hasOfflineTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set offlineTime(param1:int) : void
      {
         hasField$0 |= 1;
         offline_time$field = param1;
      }
      
      public function get offlineTime() : int
      {
         return offline_time$field;
      }
      
      public function removeGpCount() : void
      {
         hasField$0 &= 4294967293;
         gp_count$field = new int();
      }
      
      public function get hasGpCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set gpCount(param1:int) : void
      {
         hasField$0 |= 2;
         gp_count$field = param1;
      }
      
      public function get gpCount() : int
      {
         return gp_count$field;
      }
      
      public function removeRateCount() : void
      {
         hasField$0 &= 4294967291;
         rate_count$field = new int();
      }
      
      public function get hasRateCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rateCount(param1:int) : void
      {
         hasField$0 |= 4;
         rate_count$field = param1;
      }
      
      public function get rateCount() : int
      {
         return rate_count$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967287;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 8;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOfflineTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,offline_time$field);
         }
         if(hasGpCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,gp_count$field);
         }
         if(hasRateCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rate_count$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: OfflineRewardMsg.offlineTime cannot be set twice.");
                  }
                  _loc7_++;
                  offlineTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OfflineRewardMsg.gpCount cannot be set twice.");
                  }
                  _loc3_++;
                  gpCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OfflineRewardMsg.rateCount cannot be set twice.");
                  }
                  _loc4_++;
                  rateCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OfflineRewardMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

