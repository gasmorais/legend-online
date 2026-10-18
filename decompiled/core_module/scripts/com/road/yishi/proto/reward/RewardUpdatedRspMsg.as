package com.road.yishi.proto.reward
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RewardUpdatedRspMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.reward.RewardInfo")]
      public var reward:Array = [];
      
      private var states_length$field:int;
      
      private var hasField$0:uint = 0;
      
      private var states$field:ByteArray;
      
      public function RewardUpdatedRspMsg()
      {
         super();
      }
      
      public function removeStatesLength() : void
      {
         hasField$0 &= 4294967294;
         states_length$field = new int();
      }
      
      public function get hasStatesLength() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set statesLength(param1:int) : void
      {
         hasField$0 |= 1;
         states_length$field = param1;
      }
      
      public function get statesLength() : int
      {
         return states_length$field;
      }
      
      public function removeStates() : void
      {
         states$field = null;
      }
      
      public function get hasStates() : Boolean
      {
         return states$field != null;
      }
      
      public function set states(param1:ByteArray) : void
      {
         states$field = param1;
      }
      
      public function get states() : ByteArray
      {
         return states$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < reward.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,reward[_loc2_]);
            _loc2_++;
         }
         if(hasStatesLength)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,states_length$field);
         }
         if(hasStates)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_BYTES(param1,states$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:RewardInfo = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new RewardInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  reward.push(_loc4_);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RewardUpdatedRspMsg.statesLength cannot be set twice.");
                  }
                  _loc5_++;
                  statesLength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RewardUpdatedRspMsg.states cannot be set twice.");
                  }
                  _loc3_++;
                  states = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

