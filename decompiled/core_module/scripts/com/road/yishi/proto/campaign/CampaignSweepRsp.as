package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignSweepRsp extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.campaign.SweepResult")]
      public var result:Array = [];
      
      private var status$field:int;
      
      private var hasField$0:uint = 0;
      
      private var sweep_type$field:int;
      
      private var total_gp$field:int;
      
      [ArrayElementType("com.road.yishi.proto.campaign.ItemTemplate")]
      public var dropItems:Array = [];
      
      private var campaign_id$field:int;
      
      public function CampaignSweepRsp()
      {
         super();
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967294;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 1;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      public function removeSweepType() : void
      {
         hasField$0 &= 4294967293;
         sweep_type$field = new int();
      }
      
      public function get hasSweepType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sweepType(param1:int) : void
      {
         hasField$0 |= 2;
         sweep_type$field = param1;
      }
      
      public function get sweepType() : int
      {
         return sweep_type$field;
      }
      
      public function removeTotalGp() : void
      {
         hasField$0 &= 4294967291;
         total_gp$field = new int();
      }
      
      public function get hasTotalGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalGp(param1:int) : void
      {
         hasField$0 |= 4;
         total_gp$field = param1;
      }
      
      public function get totalGp() : int
      {
         return total_gp$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < result.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,result[_loc2_]);
            _loc2_++;
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
         if(hasSweepType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,sweep_type$field);
         }
         if(hasTotalGp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,total_gp$field);
         }
         _loc3_ = 0;
         while(_loc3_ < dropItems.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,dropItems[_loc3_]);
            _loc3_++;
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:SweepResult = null;
         var _loc7_:ItemTemplate = null;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc6_ = new SweepResult();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  result.push(_loc6_);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepRsp.status cannot be set twice.");
                  }
                  _loc9_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepRsp.sweepType cannot be set twice.");
                  }
                  _loc5_++;
                  sweepType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepRsp.totalGp cannot be set twice.");
                  }
                  _loc3_++;
                  totalGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc7_ = new ItemTemplate();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  dropItems.push(_loc7_);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepRsp.campaignId cannot be set twice.");
                  }
                  _loc4_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

