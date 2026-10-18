package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OprateReplacemntMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaign_id$field:int;
      
      private var result$field:int;
      
      public function OprateReplacemntMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
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
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967291;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 4;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OprateReplacemntMsg.op cannot be set twice.");
                  }
                  _loc6_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OprateReplacemntMsg.campaignId cannot be set twice.");
                  }
                  _loc3_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OprateReplacemntMsg.result cannot be set twice.");
                  }
                  _loc4_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

