package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WorldBossInfoLoadMsg extends Message implements IExternalizable
   {
      
      private var campaignId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var left_time$field:int;
      
      public function WorldBossInfoLoadMsg()
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
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967293;
         left_time$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 2;
         left_time$field = param1;
      }
      
      public function get leftTime() : int
      {
         return left_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,campaignId$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,left_time$field);
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
                     throw new IOError("Bad data format: WorldBossInfoLoadMsg.campaignId cannot be set twice.");
                  }
                  _loc5_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoLoadMsg.leftTime cannot be set twice.");
                  }
                  _loc3_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

