package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class KingTowerInfoMsg extends Message implements IExternalizable
   {
      
      private var enter_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var current_index$field:int;
      
      private var max_index$field:int;
      
      private var campaign_id$field:int;
      
      private var current_step$field:int;
      
      private var reward_count$field:int;
      
      public function KingTowerInfoMsg()
      {
         super();
      }
      
      public function removeEnterCount() : void
      {
         hasField$0 &= 4294967294;
         enter_count$field = new int();
      }
      
      public function get hasEnterCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set enterCount(param1:int) : void
      {
         hasField$0 |= 1;
         enter_count$field = param1;
      }
      
      public function get enterCount() : int
      {
         return enter_count$field;
      }
      
      public function removeCurrentIndex() : void
      {
         hasField$0 &= 4294967293;
         current_index$field = new int();
      }
      
      public function get hasCurrentIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currentIndex(param1:int) : void
      {
         hasField$0 |= 2;
         current_index$field = param1;
      }
      
      public function get currentIndex() : int
      {
         return current_index$field;
      }
      
      public function removeMaxIndex() : void
      {
         hasField$0 &= 4294967291;
         max_index$field = new int();
      }
      
      public function get hasMaxIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set maxIndex(param1:int) : void
      {
         hasField$0 |= 4;
         max_index$field = param1;
      }
      
      public function get maxIndex() : int
      {
         return max_index$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967287;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 8;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeCurrentStep() : void
      {
         hasField$0 &= 4294967279;
         current_step$field = new int();
      }
      
      public function get hasCurrentStep() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set currentStep(param1:int) : void
      {
         hasField$0 |= 16;
         current_step$field = param1;
      }
      
      public function get currentStep() : int
      {
         return current_step$field;
      }
      
      public function removeRewardCount() : void
      {
         hasField$0 &= 4294967263;
         reward_count$field = new int();
      }
      
      public function get hasRewardCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set rewardCount(param1:int) : void
      {
         hasField$0 |= 32;
         reward_count$field = param1;
      }
      
      public function get rewardCount() : int
      {
         return reward_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasEnterCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,enter_count$field);
         }
         if(hasCurrentIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,current_index$field);
         }
         if(hasMaxIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,max_index$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasCurrentStep)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,current_step$field);
         }
         if(hasRewardCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,reward_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: KingTowerInfoMsg.enterCount cannot be set twice.");
                  }
                  _loc7_++;
                  enterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: KingTowerInfoMsg.currentIndex cannot be set twice.");
                  }
                  _loc4_++;
                  currentIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: KingTowerInfoMsg.maxIndex cannot be set twice.");
                  }
                  _loc8_++;
                  maxIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: KingTowerInfoMsg.campaignId cannot be set twice.");
                  }
                  _loc3_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: KingTowerInfoMsg.currentStep cannot be set twice.");
                  }
                  _loc5_++;
                  currentStep = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: KingTowerInfoMsg.rewardCount cannot be set twice.");
                  }
                  _loc9_++;
                  rewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

