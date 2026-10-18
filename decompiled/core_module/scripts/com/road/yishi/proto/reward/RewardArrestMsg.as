package com.road.yishi.proto.reward
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RewardArrestMsg extends Message implements IExternalizable
   {
      
      private var param1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var condiction_type$field:int;
      
      public function RewardArrestMsg()
      {
         super();
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967294;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 1;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeCondictionType() : void
      {
         hasField$0 &= 4294967293;
         condiction_type$field = new int();
      }
      
      public function get hasCondictionType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set condictionType(param1:int) : void
      {
         hasField$0 |= 2;
         condiction_type$field = param1;
      }
      
      public function get condictionType() : int
      {
         return condiction_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasCondictionType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,condiction_type$field);
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
                     throw new IOError("Bad data format: RewardArrestMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RewardArrestMsg.condictionType cannot be set twice.");
                  }
                  _loc4_++;
                  condictionType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

