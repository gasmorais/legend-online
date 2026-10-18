package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DaySignInfoMsg extends Message implements IExternalizable
   {
      
      private var signTimes$field:String;
      
      private var signCycle$field:int;
      
      private var hasField$0:uint = 0;
      
      private var resetDate$field:String;
      
      private var rewardTag$field:int;
      
      private var op$field:int;
      
      private var todayIndex$field:int;
      
      public function DaySignInfoMsg()
      {
         super();
      }
      
      public function removeSignTimes() : void
      {
         signTimes$field = null;
      }
      
      public function get hasSignTimes() : Boolean
      {
         return signTimes$field != null;
      }
      
      public function set signTimes(param1:String) : void
      {
         signTimes$field = param1;
      }
      
      public function get signTimes() : String
      {
         return signTimes$field;
      }
      
      public function removeSignCycle() : void
      {
         hasField$0 &= 4294967294;
         signCycle$field = new int();
      }
      
      public function get hasSignCycle() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set signCycle(param1:int) : void
      {
         hasField$0 |= 1;
         signCycle$field = param1;
      }
      
      public function get signCycle() : int
      {
         return signCycle$field;
      }
      
      public function removeResetDate() : void
      {
         resetDate$field = null;
      }
      
      public function get hasResetDate() : Boolean
      {
         return resetDate$field != null;
      }
      
      public function set resetDate(param1:String) : void
      {
         resetDate$field = param1;
      }
      
      public function get resetDate() : String
      {
         return resetDate$field;
      }
      
      public function removeRewardTag() : void
      {
         hasField$0 &= 4294967293;
         rewardTag$field = new int();
      }
      
      public function get hasRewardTag() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rewardTag(param1:int) : void
      {
         hasField$0 |= 2;
         rewardTag$field = param1;
      }
      
      public function get rewardTag() : int
      {
         return rewardTag$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967291;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 4;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeTodayIndex() : void
      {
         hasField$0 &= 4294967287;
         todayIndex$field = new int();
      }
      
      public function get hasTodayIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set todayIndex(param1:int) : void
      {
         hasField$0 |= 8;
         todayIndex$field = param1;
      }
      
      public function get todayIndex() : int
      {
         return todayIndex$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSignTimes)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,signTimes$field);
         }
         if(hasSignCycle)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,signCycle$field);
         }
         if(hasResetDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,resetDate$field);
         }
         if(hasRewardTag)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,rewardTag$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasTodayIndex)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,todayIndex$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DaySignInfoMsg.signTimes cannot be set twice.");
                  }
                  _loc9_++;
                  signTimes = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DaySignInfoMsg.signCycle cannot be set twice.");
                  }
                  _loc3_++;
                  signCycle = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DaySignInfoMsg.resetDate cannot be set twice.");
                  }
                  _loc4_++;
                  resetDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DaySignInfoMsg.rewardTag cannot be set twice.");
                  }
                  _loc5_++;
                  rewardTag = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DaySignInfoMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DaySignInfoMsg.todayIndex cannot be set twice.");
                  }
                  _loc6_++;
                  todayIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

