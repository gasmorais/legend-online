package com.road.yishi.proto.culture
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConditionMsg extends Message implements IExternalizable
   {
      
      private var sonType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var cultureCount$field:int;
      
      private var myCultureCount$field:int;
      
      private var cultureGrade$field:int;
      
      private var scoreItem$field:int;
      
      private var scoreReward$field:int;
      
      private var rewardLevel$field:int;
      
      private var rewardType$field:int;
      
      private var rewardItems$field:String;
      
      private var rewardState$field:int;
      
      public function ConditionMsg()
      {
         super();
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967294;
         sonType$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 1;
         sonType$field = param1;
      }
      
      public function get sonType() : int
      {
         return sonType$field;
      }
      
      public function removeCultureCount() : void
      {
         hasField$0 &= 4294967293;
         cultureCount$field = new int();
      }
      
      public function get hasCultureCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set cultureCount(param1:int) : void
      {
         hasField$0 |= 2;
         cultureCount$field = param1;
      }
      
      public function get cultureCount() : int
      {
         return cultureCount$field;
      }
      
      public function removeMyCultureCount() : void
      {
         hasField$0 &= 4294967291;
         myCultureCount$field = new int();
      }
      
      public function get hasMyCultureCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set myCultureCount(param1:int) : void
      {
         hasField$0 |= 4;
         myCultureCount$field = param1;
      }
      
      public function get myCultureCount() : int
      {
         return myCultureCount$field;
      }
      
      public function removeCultureGrade() : void
      {
         hasField$0 &= 4294967287;
         cultureGrade$field = new int();
      }
      
      public function get hasCultureGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set cultureGrade(param1:int) : void
      {
         hasField$0 |= 8;
         cultureGrade$field = param1;
      }
      
      public function get cultureGrade() : int
      {
         return cultureGrade$field;
      }
      
      public function removeScoreItem() : void
      {
         hasField$0 &= 4294967279;
         scoreItem$field = new int();
      }
      
      public function get hasScoreItem() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set scoreItem(param1:int) : void
      {
         hasField$0 |= 16;
         scoreItem$field = param1;
      }
      
      public function get scoreItem() : int
      {
         return scoreItem$field;
      }
      
      public function removeScoreReward() : void
      {
         hasField$0 &= 4294967263;
         scoreReward$field = new int();
      }
      
      public function get hasScoreReward() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set scoreReward(param1:int) : void
      {
         hasField$0 |= 32;
         scoreReward$field = param1;
      }
      
      public function get scoreReward() : int
      {
         return scoreReward$field;
      }
      
      public function removeRewardLevel() : void
      {
         hasField$0 &= 4294967231;
         rewardLevel$field = new int();
      }
      
      public function get hasRewardLevel() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set rewardLevel(param1:int) : void
      {
         hasField$0 |= 64;
         rewardLevel$field = param1;
      }
      
      public function get rewardLevel() : int
      {
         return rewardLevel$field;
      }
      
      public function removeRewardType() : void
      {
         hasField$0 &= 4294967167;
         rewardType$field = new int();
      }
      
      public function get hasRewardType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set rewardType(param1:int) : void
      {
         hasField$0 |= 128;
         rewardType$field = param1;
      }
      
      public function get rewardType() : int
      {
         return rewardType$field;
      }
      
      public function removeRewardItems() : void
      {
         rewardItems$field = null;
      }
      
      public function get hasRewardItems() : Boolean
      {
         return rewardItems$field != null;
      }
      
      public function set rewardItems(param1:String) : void
      {
         rewardItems$field = param1;
      }
      
      public function get rewardItems() : String
      {
         return rewardItems$field;
      }
      
      public function removeRewardState() : void
      {
         hasField$0 &= 4294967039;
         rewardState$field = new int();
      }
      
      public function get hasRewardState() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set rewardState(param1:int) : void
      {
         hasField$0 |= 256;
         rewardState$field = param1;
      }
      
      public function get rewardState() : int
      {
         return rewardState$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,sonType$field);
         }
         if(hasCultureCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,cultureCount$field);
         }
         if(hasMyCultureCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,myCultureCount$field);
         }
         if(hasCultureGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cultureGrade$field);
         }
         if(hasScoreItem)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,scoreItem$field);
         }
         if(hasScoreReward)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,scoreReward$field);
         }
         if(hasRewardLevel)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,rewardLevel$field);
         }
         if(hasRewardType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,rewardType$field);
         }
         if(hasRewardItems)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,rewardItems$field);
         }
         if(hasRewardState)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,rewardState$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.sonType cannot be set twice.");
                  }
                  _loc9_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.cultureCount cannot be set twice.");
                  }
                  _loc12_++;
                  cultureCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.myCultureCount cannot be set twice.");
                  }
                  _loc13_++;
                  myCultureCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.cultureGrade cannot be set twice.");
                  }
                  _loc6_++;
                  cultureGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.scoreItem cannot be set twice.");
                  }
                  _loc10_++;
                  scoreItem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.scoreReward cannot be set twice.");
                  }
                  _loc3_++;
                  scoreReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.rewardLevel cannot be set twice.");
                  }
                  _loc8_++;
                  rewardLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.rewardType cannot be set twice.");
                  }
                  _loc4_++;
                  rewardType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.rewardItems cannot be set twice.");
                  }
                  _loc7_++;
                  rewardItems = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConditionMsg.rewardState cannot be set twice.");
                  }
                  _loc5_++;
                  rewardState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

