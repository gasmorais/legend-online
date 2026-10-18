package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EnterTowerInfoMsg extends Message implements IExternalizable
   {
      
      private var choose_index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaign_id$field:int;
      
      private var is_double$field:int;
      
      public function EnterTowerInfoMsg()
      {
         super();
      }
      
      public function removeChooseIndex() : void
      {
         hasField$0 &= 4294967294;
         choose_index$field = new int();
      }
      
      public function get hasChooseIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set chooseIndex(param1:int) : void
      {
         hasField$0 |= 1;
         choose_index$field = param1;
      }
      
      public function get chooseIndex() : int
      {
         return choose_index$field;
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
      
      public function removeIsDouble() : void
      {
         hasField$0 &= 4294967291;
         is_double$field = new int();
      }
      
      public function get hasIsDouble() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isDouble(param1:int) : void
      {
         hasField$0 |= 4;
         is_double$field = param1;
      }
      
      public function get isDouble() : int
      {
         return is_double$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChooseIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,choose_index$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasIsDouble)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,is_double$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EnterTowerInfoMsg.chooseIndex cannot be set twice.");
                  }
                  _loc4_++;
                  chooseIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EnterTowerInfoMsg.campaignId cannot be set twice.");
                  }
                  _loc3_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EnterTowerInfoMsg.isDouble cannot be set twice.");
                  }
                  _loc5_++;
                  isDouble = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

