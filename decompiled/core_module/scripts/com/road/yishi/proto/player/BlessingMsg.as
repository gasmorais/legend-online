package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BlessingMsg extends Message implements IExternalizable
   {
      
      private var increase$field:int;
      
      private var hasField$0:uint = 0;
      
      private var used_count$field:int;
      
      private var max_count$field:int;
      
      public function BlessingMsg()
      {
         super();
      }
      
      public function removeIncrease() : void
      {
         hasField$0 &= 4294967294;
         increase$field = new int();
      }
      
      public function get hasIncrease() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set increase(param1:int) : void
      {
         hasField$0 |= 1;
         increase$field = param1;
      }
      
      public function get increase() : int
      {
         return increase$field;
      }
      
      public function removeUsedCount() : void
      {
         hasField$0 &= 4294967293;
         used_count$field = new int();
      }
      
      public function get hasUsedCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set usedCount(param1:int) : void
      {
         hasField$0 |= 2;
         used_count$field = param1;
      }
      
      public function get usedCount() : int
      {
         return used_count$field;
      }
      
      public function removeMaxCount() : void
      {
         hasField$0 &= 4294967291;
         max_count$field = new int();
      }
      
      public function get hasMaxCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set maxCount(param1:int) : void
      {
         hasField$0 |= 4;
         max_count$field = param1;
      }
      
      public function get maxCount() : int
      {
         return max_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIncrease)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,increase$field);
         }
         if(hasUsedCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,used_count$field);
         }
         if(hasMaxCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,max_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BlessingMsg.increase cannot be set twice.");
                  }
                  _loc3_++;
                  increase = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BlessingMsg.usedCount cannot be set twice.");
                  }
                  _loc4_++;
                  usedCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BlessingMsg.maxCount cannot be set twice.");
                  }
                  _loc5_++;
                  maxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

