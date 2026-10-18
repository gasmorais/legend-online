package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ReturnCommonRewardMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var hasReward$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.active.RewardMsg")]
      public var rewards:Array = [];
      
      public function ReturnCommonRewardMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeHasReward() : void
      {
         hasField$0 &= 4294967293;
         hasReward$field = new Boolean();
      }
      
      public function get hasHasReward() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hasReward(param1:Boolean) : void
      {
         hasField$0 |= 2;
         hasReward$field = param1;
      }
      
      public function get hasReward() : Boolean
      {
         return hasReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasHasReward)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,hasReward$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rewards.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,rewards[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:RewardMsg = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ReturnCommonRewardMsg.type cannot be set twice.");
                  }
                  _loc4_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ReturnCommonRewardMsg.hasReward cannot be set twice.");
                  }
                  _loc3_++;
                  hasReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  _loc6_ = new RewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  rewards.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

