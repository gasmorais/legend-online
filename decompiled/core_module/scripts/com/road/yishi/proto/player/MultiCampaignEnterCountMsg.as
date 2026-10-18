package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MultiCampaignEnterCountMsg extends Message implements IExternalizable
   {
      
      private var campaign_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaign_maxcount$field:int;
      
      public function MultiCampaignEnterCountMsg()
      {
         super();
      }
      
      public function removeCampaignCount() : void
      {
         hasField$0 &= 4294967294;
         campaign_count$field = new int();
      }
      
      public function get hasCampaignCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set campaignCount(param1:int) : void
      {
         hasField$0 |= 1;
         campaign_count$field = param1;
      }
      
      public function get campaignCount() : int
      {
         return campaign_count$field;
      }
      
      public function removeCampaignMaxcount() : void
      {
         hasField$0 &= 4294967293;
         campaign_maxcount$field = new int();
      }
      
      public function get hasCampaignMaxcount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set campaignMaxcount(param1:int) : void
      {
         hasField$0 |= 2;
         campaign_maxcount$field = param1;
      }
      
      public function get campaignMaxcount() : int
      {
         return campaign_maxcount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCampaignCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,campaign_count$field);
         }
         if(hasCampaignMaxcount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,campaign_maxcount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MultiCampaignEnterCountMsg.campaignCount cannot be set twice.");
                  }
                  _loc5_++;
                  campaignCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MultiCampaignEnterCountMsg.campaignMaxcount cannot be set twice.");
                  }
                  _loc3_++;
                  campaignMaxcount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

