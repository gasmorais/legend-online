package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SweepResult extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gold$field:int;
      
      private var gp$field:int;
      
      private var campaign_id$field:int;
      
      private var time$field:int;
      
      [ArrayElementType("com.road.yishi.proto.campaign.ItemTemplate")]
      public var items:Array = [];
      
      private var cIndex$field:int;
      
      private var eIndex$field:int;
      
      private var finishCount$field:int;
      
      private var count$field:int;
      
      private var mailIn$field:int;
      
      public function SweepResult()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeGold() : void
      {
         hasField$0 &= 4294967293;
         gold$field = new int();
      }
      
      public function get hasGold() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set gold(param1:int) : void
      {
         hasField$0 |= 2;
         gold$field = param1;
      }
      
      public function get gold() : int
      {
         return gold$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967291;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 4;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
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
      
      public function removeTime() : void
      {
         hasField$0 &= 4294967279;
         time$field = new int();
      }
      
      public function get hasTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set time(param1:int) : void
      {
         hasField$0 |= 16;
         time$field = param1;
      }
      
      public function get time() : int
      {
         return time$field;
      }
      
      public function removeCIndex() : void
      {
         hasField$0 &= 4294967263;
         cIndex$field = new int();
      }
      
      public function get hasCIndex() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set cIndex(param1:int) : void
      {
         hasField$0 |= 32;
         cIndex$field = param1;
      }
      
      public function get cIndex() : int
      {
         return cIndex$field;
      }
      
      public function removeEIndex() : void
      {
         hasField$0 &= 4294967231;
         eIndex$field = new int();
      }
      
      public function get hasEIndex() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set eIndex(param1:int) : void
      {
         hasField$0 |= 64;
         eIndex$field = param1;
      }
      
      public function get eIndex() : int
      {
         return eIndex$field;
      }
      
      public function removeFinishCount() : void
      {
         hasField$0 &= 4294967167;
         finishCount$field = new int();
      }
      
      public function get hasFinishCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set finishCount(param1:int) : void
      {
         hasField$0 |= 128;
         finishCount$field = param1;
      }
      
      public function get finishCount() : int
      {
         return finishCount$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967039;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 256;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeMailIn() : void
      {
         hasField$0 &= 4294966783;
         mailIn$field = new int();
      }
      
      public function get hasMailIn() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set mailIn(param1:int) : void
      {
         hasField$0 |= 512;
         mailIn$field = param1;
      }
      
      public function get mailIn() : int
      {
         return mailIn$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasGold)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gold$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,time$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc2_]);
            _loc2_++;
         }
         if(hasCIndex)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,cIndex$field);
         }
         if(hasEIndex)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,eIndex$field);
         }
         if(hasFinishCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,finishCount$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasMailIn)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,mailIn$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc14_:ItemTemplate = null;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.gold cannot be set twice.");
                  }
                  _loc9_++;
                  gold = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.gp cannot be set twice.");
                  }
                  _loc12_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.campaignId cannot be set twice.");
                  }
                  _loc7_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.time cannot be set twice.");
                  }
                  _loc13_++;
                  time = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc14_ = new ItemTemplate();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  items.push(_loc14_);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.cIndex cannot be set twice.");
                  }
                  _loc8_++;
                  cIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.eIndex cannot be set twice.");
                  }
                  _loc10_++;
                  eIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.finishCount cannot be set twice.");
                  }
                  _loc6_++;
                  finishCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SweepResult.mailIn cannot be set twice.");
                  }
                  _loc4_++;
                  mailIn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

