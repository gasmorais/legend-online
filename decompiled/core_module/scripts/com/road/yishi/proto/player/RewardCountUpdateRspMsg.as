package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RewardCountUpdateRspMsg extends Message implements IExternalizable
   {
      
      private var reward_count$field:int;
      
      private var hasField$0:uint = 0;
      
      public function RewardCountUpdateRspMsg()
      {
         super();
      }
      
      public function removeRewardCount() : void
      {
         hasField$0 &= 4294967294;
         reward_count$field = new int();
      }
      
      public function get hasRewardCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rewardCount(param1:int) : void
      {
         hasField$0 |= 1;
         reward_count$field = param1;
      }
      
      public function get rewardCount() : int
      {
         return reward_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRewardCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,reward_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RewardCountUpdateRspMsg.rewardCount cannot be set twice.");
                  }
                  _loc4_++;
                  rewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

