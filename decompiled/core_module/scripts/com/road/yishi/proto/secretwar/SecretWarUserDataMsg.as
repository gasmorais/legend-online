package com.road.yishi.proto.secretwar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretWarUserDataMsg extends Message implements IExternalizable
   {
      
      private var rewardCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rewardShow$field:String;
      
      public function SecretWarUserDataMsg()
      {
         super();
      }
      
      public function removeRewardCount() : void
      {
         hasField$0 &= 4294967294;
         rewardCount$field = new int();
      }
      
      public function get hasRewardCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rewardCount(param1:int) : void
      {
         hasField$0 |= 1;
         rewardCount$field = param1;
      }
      
      public function get rewardCount() : int
      {
         return rewardCount$field;
      }
      
      public function removeRewardShow() : void
      {
         rewardShow$field = null;
      }
      
      public function get hasRewardShow() : Boolean
      {
         return rewardShow$field != null;
      }
      
      public function set rewardShow(param1:String) : void
      {
         rewardShow$field = param1;
      }
      
      public function get rewardShow() : String
      {
         return rewardShow$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRewardCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rewardCount$field);
         }
         if(hasRewardShow)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,rewardShow$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarUserDataMsg.rewardCount cannot be set twice.");
                  }
                  _loc3_++;
                  rewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SecretWarUserDataMsg.rewardShow cannot be set twice.");
                  }
                  _loc4_++;
                  rewardShow = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

