package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GuildTotemUpdateBufferMsg extends Message implements IExternalizable
   {
      
      private var campaign_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var node_id$field:int;
      
      private var vice_count$field:int;
      
      public function GuildTotemUpdateBufferMsg()
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
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967293;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 2;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeViceCount() : void
      {
         hasField$0 &= 4294967291;
         vice_count$field = new int();
      }
      
      public function get hasViceCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set viceCount(param1:int) : void
      {
         hasField$0 |= 4;
         vice_count$field = param1;
      }
      
      public function get viceCount() : int
      {
         return vice_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasViceCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,vice_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GuildTotemUpdateBufferMsg.campaignId cannot be set twice.");
                  }
                  _loc3_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GuildTotemUpdateBufferMsg.nodeId cannot be set twice.");
                  }
                  _loc5_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GuildTotemUpdateBufferMsg.viceCount cannot be set twice.");
                  }
                  _loc4_++;
                  viceCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

