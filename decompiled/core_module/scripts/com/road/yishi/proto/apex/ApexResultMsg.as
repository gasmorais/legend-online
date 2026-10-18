package com.road.yishi.proto.apex
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ApexResultMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.apex.ApexRewardMsg")]
      public var rewardList:Array = [];
      
      private var selfScore$field:int;
      
      private var hasField$0:uint = 0;
      
      private var selfRank$field:int;
      
      private var currentGroup$field:int;
      
      private var nextGroup$field:int;
      
      public function ApexResultMsg()
      {
         super();
      }
      
      public function removeSelfScore() : void
      {
         hasField$0 &= 4294967294;
         selfScore$field = new int();
      }
      
      public function get hasSelfScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set selfScore(param1:int) : void
      {
         hasField$0 |= 1;
         selfScore$field = param1;
      }
      
      public function get selfScore() : int
      {
         return selfScore$field;
      }
      
      public function removeSelfRank() : void
      {
         hasField$0 &= 4294967293;
         selfRank$field = new int();
      }
      
      public function get hasSelfRank() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set selfRank(param1:int) : void
      {
         hasField$0 |= 2;
         selfRank$field = param1;
      }
      
      public function get selfRank() : int
      {
         return selfRank$field;
      }
      
      public function removeCurrentGroup() : void
      {
         hasField$0 &= 4294967291;
         currentGroup$field = new int();
      }
      
      public function get hasCurrentGroup() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currentGroup(param1:int) : void
      {
         hasField$0 |= 4;
         currentGroup$field = param1;
      }
      
      public function get currentGroup() : int
      {
         return currentGroup$field;
      }
      
      public function removeNextGroup() : void
      {
         hasField$0 &= 4294967287;
         nextGroup$field = new int();
      }
      
      public function get hasNextGroup() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set nextGroup(param1:int) : void
      {
         hasField$0 |= 8;
         nextGroup$field = param1;
      }
      
      public function get nextGroup() : int
      {
         return nextGroup$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < rewardList.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardList[_loc2_]);
            _loc2_++;
         }
         if(hasSelfScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,selfScore$field);
         }
         if(hasSelfRank)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,selfRank$field);
         }
         if(hasCurrentGroup)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,currentGroup$field);
         }
         if(hasNextGroup)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,nextGroup$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:ApexRewardMsg = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new ApexRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  rewardList.push(_loc3_);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ApexResultMsg.selfScore cannot be set twice.");
                  }
                  _loc4_++;
                  selfScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ApexResultMsg.selfRank cannot be set twice.");
                  }
                  _loc5_++;
                  selfRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ApexResultMsg.currentGroup cannot be set twice.");
                  }
                  _loc6_++;
                  currentGroup = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ApexResultMsg.nextGroup cannot be set twice.");
                  }
                  _loc8_++;
                  nextGroup = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

