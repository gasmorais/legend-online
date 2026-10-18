package com.road.yishi.proto.bloodyrealm
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BloodyRealmCampaignInfoMsg extends Message implements IExternalizable
   {
      
      private var campaign_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var current_ware$field:int;
      
      public function BloodyRealmCampaignInfoMsg()
      {
         super();
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967294;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 1;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeCurrentWare() : void
      {
         hasField$0 &= 4294967293;
         current_ware$field = new int();
      }
      
      public function get hasCurrentWare() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currentWare(param1:int) : void
      {
         hasField$0 |= 2;
         current_ware$field = param1;
      }
      
      public function get currentWare() : int
      {
         return current_ware$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasCurrentWare)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,current_ware$field);
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
                     throw new IOError("Bad data format: BloodyRealmCampaignInfoMsg.campaignId cannot be set twice.");
                  }
                  _loc3_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BloodyRealmCampaignInfoMsg.currentWare cannot be set twice.");
                  }
                  _loc4_++;
                  currentWare = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

