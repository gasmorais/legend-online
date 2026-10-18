package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OreRewardTempMsg extends Message implements IExternalizable
   {
      
      private var rewardType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var specialFloorNum$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.OreItemInfoMsg")]
      public var rewards:Array = [];
      
      public function OreRewardTempMsg()
      {
         super();
      }
      
      public function removeRewardType() : void
      {
         hasField$0 &= 4294967294;
         rewardType$field = new int();
      }
      
      public function get hasRewardType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rewardType(param1:int) : void
      {
         hasField$0 |= 1;
         rewardType$field = param1;
      }
      
      public function get rewardType() : int
      {
         return rewardType$field;
      }
      
      public function removeSpecialFloorNum() : void
      {
         hasField$0 &= 4294967293;
         specialFloorNum$field = new int();
      }
      
      public function get hasSpecialFloorNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set specialFloorNum(param1:int) : void
      {
         hasField$0 |= 2;
         specialFloorNum$field = param1;
      }
      
      public function get specialFloorNum() : int
      {
         return specialFloorNum$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasRewardType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rewardType$field);
         }
         if(hasSpecialFloorNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,specialFloorNum$field);
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
         var _loc6_:OreItemInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OreRewardTempMsg.rewardType cannot be set twice.");
                  }
                  _loc3_++;
                  rewardType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OreRewardTempMsg.specialFloorNum cannot be set twice.");
                  }
                  _loc4_++;
                  specialFloorNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc6_ = new OreItemInfoMsg();
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

