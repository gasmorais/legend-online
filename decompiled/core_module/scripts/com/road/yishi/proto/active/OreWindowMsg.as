package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OreWindowMsg extends Message implements IExternalizable
   {
      
      private var todayRemainTurns$field:int;
      
      private var hasField$0:uint = 0;
      
      private var curSeq$field:int;
      
      private var spRewardRemainTimes$field:int;
      
      private var countDown$field:int;
      
      private var mineCount$field:int;
      
      public function OreWindowMsg()
      {
         super();
      }
      
      public function removeTodayRemainTurns() : void
      {
         hasField$0 &= 4294967294;
         todayRemainTurns$field = new int();
      }
      
      public function get hasTodayRemainTurns() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set todayRemainTurns(param1:int) : void
      {
         hasField$0 |= 1;
         todayRemainTurns$field = param1;
      }
      
      public function get todayRemainTurns() : int
      {
         return todayRemainTurns$field;
      }
      
      public function removeCurSeq() : void
      {
         hasField$0 &= 4294967293;
         curSeq$field = new int();
      }
      
      public function get hasCurSeq() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curSeq(param1:int) : void
      {
         hasField$0 |= 2;
         curSeq$field = param1;
      }
      
      public function get curSeq() : int
      {
         return curSeq$field;
      }
      
      public function removeSpRewardRemainTimes() : void
      {
         hasField$0 &= 4294967291;
         spRewardRemainTimes$field = new int();
      }
      
      public function get hasSpRewardRemainTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set spRewardRemainTimes(param1:int) : void
      {
         hasField$0 |= 4;
         spRewardRemainTimes$field = param1;
      }
      
      public function get spRewardRemainTimes() : int
      {
         return spRewardRemainTimes$field;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294967287;
         countDown$field = new int();
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set countDown(param1:int) : void
      {
         hasField$0 |= 8;
         countDown$field = param1;
      }
      
      public function get countDown() : int
      {
         return countDown$field;
      }
      
      public function removeMineCount() : void
      {
         hasField$0 &= 4294967279;
         mineCount$field = new int();
      }
      
      public function get hasMineCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set mineCount(param1:int) : void
      {
         hasField$0 |= 16;
         mineCount$field = param1;
      }
      
      public function get mineCount() : int
      {
         return mineCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTodayRemainTurns)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,todayRemainTurns$field);
         }
         if(hasCurSeq)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,curSeq$field);
         }
         if(hasSpRewardRemainTimes)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,spRewardRemainTimes$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,countDown$field);
         }
         if(hasMineCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,mineCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: OreWindowMsg.todayRemainTurns cannot be set twice.");
                  }
                  _loc5_++;
                  todayRemainTurns = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OreWindowMsg.curSeq cannot be set twice.");
                  }
                  _loc3_++;
                  curSeq = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OreWindowMsg.spRewardRemainTimes cannot be set twice.");
                  }
                  _loc6_++;
                  spRewardRemainTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OreWindowMsg.countDown cannot be set twice.");
                  }
                  _loc4_++;
                  countDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: OreWindowMsg.mineCount cannot be set twice.");
                  }
                  _loc8_++;
                  mineCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

