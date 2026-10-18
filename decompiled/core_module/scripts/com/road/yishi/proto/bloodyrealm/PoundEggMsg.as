package com.road.yishi.proto.bloodyrealm
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PoundEggMsg extends Message implements IExternalizable
   {
      
      private var campaign_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var current_ware$field:int;
      
      private var expire_time$field:Int64;
      
      [ArrayElementType("com.road.yishi.proto.bloodyrealm.EggStateMsg")]
      public var state:Array = [];
      
      public function PoundEggMsg()
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
      
      public function removeExpireTime() : void
      {
         expire_time$field = null;
      }
      
      public function get hasExpireTime() : Boolean
      {
         return expire_time$field != null;
      }
      
      public function set expireTime(param1:Int64) : void
      {
         expire_time$field = param1;
      }
      
      public function get expireTime() : Int64
      {
         return expire_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
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
         if(hasExpireTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,expire_time$field);
         }
         _loc2_ = 0;
         while(_loc2_ < state.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,state[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:EggStateMsg = null;
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
                     throw new IOError("Bad data format: PoundEggMsg.campaignId cannot be set twice.");
                  }
                  _loc3_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PoundEggMsg.currentWare cannot be set twice.");
                  }
                  _loc5_++;
                  currentWare = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PoundEggMsg.expireTime cannot be set twice.");
                  }
                  _loc4_++;
                  expireTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  _loc7_ = new EggStateMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  state.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

