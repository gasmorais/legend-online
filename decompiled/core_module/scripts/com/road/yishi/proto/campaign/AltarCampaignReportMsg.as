package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AltarCampaignReportMsg extends Message implements IExternalizable
   {
      
      private var altar_durability$field:int;
      
      private var hasField$0:uint = 0;
      
      private var wave_num$field:int;
      
      private var monster_count$field:int;
      
      private var buff_type$field:int;
      
      [ArrayElementType("com.road.yishi.proto.campaign.HurtOrderMsg")]
      public var hurtOrder:Array = [];
      
      private var leftStartTime$field:int;
      
      private var user_buff_type$field:int;
      
      [ArrayElementType("com.road.yishi.proto.campaign.AltarCampaignSkillMsg")]
      public var skill:Array = [];
      
      public function AltarCampaignReportMsg()
      {
         super();
      }
      
      public function removeAltarDurability() : void
      {
         hasField$0 &= 4294967294;
         altar_durability$field = new int();
      }
      
      public function get hasAltarDurability() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set altarDurability(param1:int) : void
      {
         hasField$0 |= 1;
         altar_durability$field = param1;
      }
      
      public function get altarDurability() : int
      {
         return altar_durability$field;
      }
      
      public function removeWaveNum() : void
      {
         hasField$0 &= 4294967293;
         wave_num$field = new int();
      }
      
      public function get hasWaveNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set waveNum(param1:int) : void
      {
         hasField$0 |= 2;
         wave_num$field = param1;
      }
      
      public function get waveNum() : int
      {
         return wave_num$field;
      }
      
      public function removeMonsterCount() : void
      {
         hasField$0 &= 4294967291;
         monster_count$field = new int();
      }
      
      public function get hasMonsterCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set monsterCount(param1:int) : void
      {
         hasField$0 |= 4;
         monster_count$field = param1;
      }
      
      public function get monsterCount() : int
      {
         return monster_count$field;
      }
      
      public function removeBuffType() : void
      {
         hasField$0 &= 4294967287;
         buff_type$field = new int();
      }
      
      public function get hasBuffType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set buffType(param1:int) : void
      {
         hasField$0 |= 8;
         buff_type$field = param1;
      }
      
      public function get buffType() : int
      {
         return buff_type$field;
      }
      
      public function removeLeftStartTime() : void
      {
         hasField$0 &= 4294967279;
         leftStartTime$field = new int();
      }
      
      public function get hasLeftStartTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set leftStartTime(param1:int) : void
      {
         hasField$0 |= 16;
         leftStartTime$field = param1;
      }
      
      public function get leftStartTime() : int
      {
         return leftStartTime$field;
      }
      
      public function removeUserBuffType() : void
      {
         hasField$0 &= 4294967263;
         user_buff_type$field = new int();
      }
      
      public function get hasUserBuffType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set userBuffType(param1:int) : void
      {
         hasField$0 |= 32;
         user_buff_type$field = param1;
      }
      
      public function get userBuffType() : int
      {
         return user_buff_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasAltarDurability)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,altar_durability$field);
         }
         if(hasWaveNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,wave_num$field);
         }
         if(hasMonsterCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,monster_count$field);
         }
         if(hasBuffType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,buff_type$field);
         }
         _loc2_ = 0;
         while(_loc2_ < hurtOrder.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,hurtOrder[_loc2_]);
            _loc2_++;
         }
         if(hasLeftStartTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,leftStartTime$field);
         }
         if(hasUserBuffType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,user_buff_type$field);
         }
         _loc3_ = 0;
         while(_loc3_ < skill.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,skill[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc6_:HurtOrderMsg = null;
         var _loc9_:AltarCampaignSkillMsg = null;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignReportMsg.altarDurability cannot be set twice.");
                  }
                  _loc7_++;
                  altarDurability = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignReportMsg.waveNum cannot be set twice.");
                  }
                  _loc3_++;
                  waveNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignReportMsg.monsterCount cannot be set twice.");
                  }
                  _loc10_++;
                  monsterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignReportMsg.buffType cannot be set twice.");
                  }
                  _loc5_++;
                  buffType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc6_ = new HurtOrderMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  hurtOrder.push(_loc6_);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignReportMsg.leftStartTime cannot be set twice.");
                  }
                  _loc4_++;
                  leftStartTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignReportMsg.userBuffType cannot be set twice.");
                  }
                  _loc8_++;
                  userBuffType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc9_ = new AltarCampaignSkillMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  skill.push(_loc9_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

