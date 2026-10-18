package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TowerInfoMsg extends Message implements IExternalizable
   {
      
      private var enter_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var total_gp$field:int;
      
      private var tower_index$field:int;
      
      private var max_index$field:int;
      
      private var order$field:int;
      
      private var max_enterCount$field:int;
      
      private var item_tempIds$field:String;
      
      private var free_enterCount$field:int;
      
      private var campaign_id$field:int;
      
      private var index$field:int;
      
      private var first_hitId$field:int;
      
      private var first_hitName$field:String;
      
      public function TowerInfoMsg()
      {
         super();
      }
      
      public function removeEnterCount() : void
      {
         hasField$0 &= 4294967294;
         enter_count$field = new int();
      }
      
      public function get hasEnterCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set enterCount(param1:int) : void
      {
         hasField$0 |= 1;
         enter_count$field = param1;
      }
      
      public function get enterCount() : int
      {
         return enter_count$field;
      }
      
      public function removeTotalGp() : void
      {
         hasField$0 &= 4294967293;
         total_gp$field = new int();
      }
      
      public function get hasTotalGp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalGp(param1:int) : void
      {
         hasField$0 |= 2;
         total_gp$field = param1;
      }
      
      public function get totalGp() : int
      {
         return total_gp$field;
      }
      
      public function removeTowerIndex() : void
      {
         hasField$0 &= 4294967291;
         tower_index$field = new int();
      }
      
      public function get hasTowerIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set towerIndex(param1:int) : void
      {
         hasField$0 |= 4;
         tower_index$field = param1;
      }
      
      public function get towerIndex() : int
      {
         return tower_index$field;
      }
      
      public function removeMaxIndex() : void
      {
         hasField$0 &= 4294967287;
         max_index$field = new int();
      }
      
      public function get hasMaxIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set maxIndex(param1:int) : void
      {
         hasField$0 |= 8;
         max_index$field = param1;
      }
      
      public function get maxIndex() : int
      {
         return max_index$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967279;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 16;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeMaxEnterCount() : void
      {
         hasField$0 &= 4294967263;
         max_enterCount$field = new int();
      }
      
      public function get hasMaxEnterCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set maxEnterCount(param1:int) : void
      {
         hasField$0 |= 32;
         max_enterCount$field = param1;
      }
      
      public function get maxEnterCount() : int
      {
         return max_enterCount$field;
      }
      
      public function removeItemTempIds() : void
      {
         item_tempIds$field = null;
      }
      
      public function get hasItemTempIds() : Boolean
      {
         return item_tempIds$field != null;
      }
      
      public function set itemTempIds(param1:String) : void
      {
         item_tempIds$field = param1;
      }
      
      public function get itemTempIds() : String
      {
         return item_tempIds$field;
      }
      
      public function removeFreeEnterCount() : void
      {
         hasField$0 &= 4294967231;
         free_enterCount$field = new int();
      }
      
      public function get hasFreeEnterCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set freeEnterCount(param1:int) : void
      {
         hasField$0 |= 64;
         free_enterCount$field = param1;
      }
      
      public function get freeEnterCount() : int
      {
         return free_enterCount$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967167;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 128;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967039;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 256;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeFirstHitId() : void
      {
         hasField$0 &= 4294966783;
         first_hitId$field = new int();
      }
      
      public function get hasFirstHitId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set firstHitId(param1:int) : void
      {
         hasField$0 |= 512;
         first_hitId$field = param1;
      }
      
      public function get firstHitId() : int
      {
         return first_hitId$field;
      }
      
      public function removeFirstHitName() : void
      {
         first_hitName$field = null;
      }
      
      public function get hasFirstHitName() : Boolean
      {
         return first_hitName$field != null;
      }
      
      public function set firstHitName(param1:String) : void
      {
         first_hitName$field = param1;
      }
      
      public function get firstHitName() : String
      {
         return first_hitName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasEnterCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,enter_count$field);
         }
         if(hasTotalGp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,total_gp$field);
         }
         if(hasTowerIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,tower_index$field);
         }
         if(hasMaxIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,max_index$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasMaxEnterCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,max_enterCount$field);
         }
         if(hasItemTempIds)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,item_tempIds$field);
         }
         if(hasFreeEnterCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,free_enterCount$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasFirstHitId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,first_hitId$field);
         }
         if(hasFirstHitName)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,first_hitName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.enterCount cannot be set twice.");
                  }
                  _loc8_++;
                  enterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.totalGp cannot be set twice.");
                  }
                  _loc9_++;
                  totalGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.towerIndex cannot be set twice.");
                  }
                  _loc7_++;
                  towerIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.maxIndex cannot be set twice.");
                  }
                  _loc15_++;
                  maxIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.order cannot be set twice.");
                  }
                  _loc12_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.maxEnterCount cannot be set twice.");
                  }
                  _loc13_++;
                  maxEnterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.itemTempIds cannot be set twice.");
                  }
                  _loc5_++;
                  itemTempIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.freeEnterCount cannot be set twice.");
                  }
                  _loc3_++;
                  freeEnterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.campaignId cannot be set twice.");
                  }
                  _loc10_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.index cannot be set twice.");
                  }
                  _loc11_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.firstHitId cannot be set twice.");
                  }
                  _loc4_++;
                  firstHitId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TowerInfoMsg.firstHitName cannot be set twice.");
                  }
                  _loc6_++;
                  firstHitName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

