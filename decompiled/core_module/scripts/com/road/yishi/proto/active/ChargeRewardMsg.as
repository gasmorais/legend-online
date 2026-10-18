package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChargeRewardMsg extends Message implements IExternalizable
   {
      
      private var totalCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var topThreeCount$field:int;
      
      private var myTotalCount$field:int;
      
      private var dayTotalCount$field:int;
      
      public function ChargeRewardMsg()
      {
         super();
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967294;
         totalCount$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 1;
         totalCount$field = param1;
      }
      
      public function get totalCount() : int
      {
         return totalCount$field;
      }
      
      public function removeTopThreeCount() : void
      {
         hasField$0 &= 4294967293;
         topThreeCount$field = new int();
      }
      
      public function get hasTopThreeCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set topThreeCount(param1:int) : void
      {
         hasField$0 |= 2;
         topThreeCount$field = param1;
      }
      
      public function get topThreeCount() : int
      {
         return topThreeCount$field;
      }
      
      public function removeMyTotalCount() : void
      {
         hasField$0 &= 4294967291;
         myTotalCount$field = new int();
      }
      
      public function get hasMyTotalCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set myTotalCount(param1:int) : void
      {
         hasField$0 |= 4;
         myTotalCount$field = param1;
      }
      
      public function get myTotalCount() : int
      {
         return myTotalCount$field;
      }
      
      public function removeDayTotalCount() : void
      {
         hasField$0 &= 4294967287;
         dayTotalCount$field = new int();
      }
      
      public function get hasDayTotalCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set dayTotalCount(param1:int) : void
      {
         hasField$0 |= 8;
         dayTotalCount$field = param1;
      }
      
      public function get dayTotalCount() : int
      {
         return dayTotalCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,totalCount$field);
         }
         if(hasTopThreeCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,topThreeCount$field);
         }
         if(hasMyTotalCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,myTotalCount$field);
         }
         if(hasDayTotalCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,dayTotalCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeRewardMsg.totalCount cannot be set twice.");
                  }
                  _loc3_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeRewardMsg.topThreeCount cannot be set twice.");
                  }
                  _loc5_++;
                  topThreeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeRewardMsg.myTotalCount cannot be set twice.");
                  }
                  _loc4_++;
                  myTotalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeRewardMsg.dayTotalCount cannot be set twice.");
                  }
                  _loc6_++;
                  dayTotalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

