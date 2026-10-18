package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignSweepReq extends Message implements IExternalizable
   {
      
      private var sweep_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var op_type$field:int;
      
      private var campaign_id$field:int;
      
      private var count$field:int;
      
      private var e_index$field:int;
      
      private var enter_type$field:int;
      
      private var open_silver_box$field:Boolean;
      
      private var open_secret_box$field:Boolean;
      
      private var pay_type$field:int;
      
      public function CampaignSweepReq()
      {
         super();
      }
      
      public function removeSweepType() : void
      {
         hasField$0 &= 4294967294;
         sweep_type$field = new int();
      }
      
      public function get hasSweepType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set sweepType(param1:int) : void
      {
         hasField$0 |= 1;
         sweep_type$field = param1;
      }
      
      public function get sweepType() : int
      {
         return sweep_type$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967293;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 2;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967291;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 4;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967287;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 8;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeEIndex() : void
      {
         hasField$0 &= 4294967279;
         e_index$field = new int();
      }
      
      public function get hasEIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set eIndex(param1:int) : void
      {
         hasField$0 |= 16;
         e_index$field = param1;
      }
      
      public function get eIndex() : int
      {
         return e_index$field;
      }
      
      public function removeEnterType() : void
      {
         hasField$0 &= 4294967263;
         enter_type$field = new int();
      }
      
      public function get hasEnterType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set enterType(param1:int) : void
      {
         hasField$0 |= 32;
         enter_type$field = param1;
      }
      
      public function get enterType() : int
      {
         return enter_type$field;
      }
      
      public function removeOpenSilverBox() : void
      {
         hasField$0 &= 4294967231;
         open_silver_box$field = new Boolean();
      }
      
      public function get hasOpenSilverBox() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set openSilverBox(param1:Boolean) : void
      {
         hasField$0 |= 64;
         open_silver_box$field = param1;
      }
      
      public function get openSilverBox() : Boolean
      {
         return open_silver_box$field;
      }
      
      public function removeOpenSecretBox() : void
      {
         hasField$0 &= 4294967167;
         open_secret_box$field = new Boolean();
      }
      
      public function get hasOpenSecretBox() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set openSecretBox(param1:Boolean) : void
      {
         hasField$0 |= 128;
         open_secret_box$field = param1;
      }
      
      public function get openSecretBox() : Boolean
      {
         return open_secret_box$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967039;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 256;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSweepType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,sweep_type$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasEIndex)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,e_index$field);
         }
         if(hasEnterType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,enter_type$field);
         }
         if(hasOpenSilverBox)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,open_silver_box$field);
         }
         if(hasOpenSecretBox)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,open_secret_box$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepReq.sweepType cannot be set twice.");
                  }
                  _loc6_++;
                  sweepType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepReq.opType cannot be set twice.");
                  }
                  _loc7_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepReq.campaignId cannot be set twice.");
                  }
                  _loc3_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepReq.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepReq.eIndex cannot be set twice.");
                  }
                  _loc12_++;
                  eIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepReq.enterType cannot be set twice.");
                  }
                  _loc4_++;
                  enterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepReq.openSilverBox cannot be set twice.");
                  }
                  _loc8_++;
                  openSilverBox = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepReq.openSecretBox cannot be set twice.");
                  }
                  _loc9_++;
                  openSecretBox = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignSweepReq.payType cannot be set twice.");
                  }
                  _loc11_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

