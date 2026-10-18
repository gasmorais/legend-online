package com.road.yishi.proto.christmas
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsumptionRewardInfoMsg extends Message implements IExternalizable
   {
      
      private var itemId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var multiple$field:int;
      
      private var isGetReward$field:int;
      
      public function ConsumptionRewardInfoMsg()
      {
         super();
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967294;
         itemId$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 1;
         itemId$field = param1;
      }
      
      public function get itemId() : int
      {
         return itemId$field;
      }
      
      public function removeMultiple() : void
      {
         hasField$0 &= 4294967293;
         multiple$field = new int();
      }
      
      public function get hasMultiple() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set multiple(param1:int) : void
      {
         hasField$0 |= 2;
         multiple$field = param1;
      }
      
      public function get multiple() : int
      {
         return multiple$field;
      }
      
      public function removeIsGetReward() : void
      {
         hasField$0 &= 4294967291;
         isGetReward$field = new int();
      }
      
      public function get hasIsGetReward() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isGetReward(param1:int) : void
      {
         hasField$0 |= 4;
         isGetReward$field = param1;
      }
      
      public function get isGetReward() : int
      {
         return isGetReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,itemId$field);
         }
         if(hasMultiple)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,multiple$field);
         }
         if(hasIsGetReward)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,isGetReward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsumptionRewardInfoMsg.itemId cannot be set twice.");
                  }
                  _loc5_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsumptionRewardInfoMsg.multiple cannot be set twice.");
                  }
                  _loc3_++;
                  multiple = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsumptionRewardInfoMsg.isGetReward cannot be set twice.");
                  }
                  _loc6_++;
                  isGetReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

