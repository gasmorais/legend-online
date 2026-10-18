package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WorldBossWoundRewardMsg extends Message implements IExternalizable
   {
      
      private var campaignId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rewardid$field:int;
      
      private var woundmsg$field:String;
      
      private var rewardmsg$field:String;
      
      private var state$field:int;
      
      public function WorldBossWoundRewardMsg()
      {
         super();
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967294;
         campaignId$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 1;
         campaignId$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaignId$field;
      }
      
      public function removeRewardid() : void
      {
         hasField$0 &= 4294967293;
         rewardid$field = new int();
      }
      
      public function get hasRewardid() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rewardid(param1:int) : void
      {
         hasField$0 |= 2;
         rewardid$field = param1;
      }
      
      public function get rewardid() : int
      {
         return rewardid$field;
      }
      
      public function removeWoundmsg() : void
      {
         woundmsg$field = null;
      }
      
      public function get hasWoundmsg() : Boolean
      {
         return woundmsg$field != null;
      }
      
      public function set woundmsg(param1:String) : void
      {
         woundmsg$field = param1;
      }
      
      public function get woundmsg() : String
      {
         return woundmsg$field;
      }
      
      public function removeRewardmsg() : void
      {
         rewardmsg$field = null;
      }
      
      public function get hasRewardmsg() : Boolean
      {
         return rewardmsg$field != null;
      }
      
      public function set rewardmsg(param1:String) : void
      {
         rewardmsg$field = param1;
      }
      
      public function get rewardmsg() : String
      {
         return rewardmsg$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967291;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 4;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,campaignId$field);
         }
         if(hasRewardid)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,rewardid$field);
         }
         if(hasWoundmsg)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,woundmsg$field);
         }
         if(hasRewardmsg)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,rewardmsg$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossWoundRewardMsg.campaignId cannot be set twice.");
                  }
                  _loc8_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossWoundRewardMsg.rewardid cannot be set twice.");
                  }
                  _loc3_++;
                  rewardid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossWoundRewardMsg.woundmsg cannot be set twice.");
                  }
                  _loc4_++;
                  woundmsg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossWoundRewardMsg.rewardmsg cannot be set twice.");
                  }
                  _loc6_++;
                  rewardmsg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossWoundRewardMsg.state cannot be set twice.");
                  }
                  _loc5_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

