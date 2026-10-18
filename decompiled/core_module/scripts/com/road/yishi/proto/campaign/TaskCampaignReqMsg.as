package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TaskCampaignReqMsg extends Message implements IExternalizable
   {
      
      private var dungeon_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaign_id$field:int;
      
      public function TaskCampaignReqMsg()
      {
         super();
      }
      
      public function removeDungeonId() : void
      {
         hasField$0 &= 4294967294;
         dungeon_id$field = new int();
      }
      
      public function get hasDungeonId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dungeonId(param1:int) : void
      {
         hasField$0 |= 1;
         dungeon_id$field = param1;
      }
      
      public function get dungeonId() : int
      {
         return dungeon_id$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967293;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 2;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasDungeonId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,dungeon_id$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
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
                     throw new IOError("Bad data format: TaskCampaignReqMsg.dungeonId cannot be set twice.");
                  }
                  _loc3_++;
                  dungeonId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TaskCampaignReqMsg.campaignId cannot be set twice.");
                  }
                  _loc4_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

