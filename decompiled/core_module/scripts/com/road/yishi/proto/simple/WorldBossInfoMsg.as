package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WorldBossInfoMsg extends Message implements IExternalizable
   {
      
      private var cur_hp$field:Int64;
      
      private var total_num$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaign_id$field:int;
      
      [ArrayElementType("com.road.yishi.proto.simple.WoundInfoMsg")]
      public var woundInfo:Array = [];
      
      private var total_hp$field:Int64;
      
      private var my_wound$field:Int64;
      
      private var grades$field:int;
      
      private var current_millis$field:Int64;
      
      [ArrayElementType("com.road.yishi.proto.simple.WoundInfoMsg")]
      public var castleWound:Array = [];
      
      private var buffer_grade$field:int;
      
      private var boss_type$field:int;
      
      private var boss_state$field:int;
      
      public function WorldBossInfoMsg()
      {
         super();
      }
      
      public function removeCurHp() : void
      {
         cur_hp$field = null;
      }
      
      public function get hasCurHp() : Boolean
      {
         return cur_hp$field != null;
      }
      
      public function set curHp(param1:Int64) : void
      {
         cur_hp$field = param1;
      }
      
      public function get curHp() : Int64
      {
         return cur_hp$field;
      }
      
      public function removeTotalNum() : void
      {
         hasField$0 &= 4294967294;
         total_num$field = new int();
      }
      
      public function get hasTotalNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set totalNum(param1:int) : void
      {
         hasField$0 |= 1;
         total_num$field = param1;
      }
      
      public function get totalNum() : int
      {
         return total_num$field;
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
      
      public function removeTotalHp() : void
      {
         total_hp$field = null;
      }
      
      public function get hasTotalHp() : Boolean
      {
         return total_hp$field != null;
      }
      
      public function set totalHp(param1:Int64) : void
      {
         total_hp$field = param1;
      }
      
      public function get totalHp() : Int64
      {
         return total_hp$field;
      }
      
      public function removeMyWound() : void
      {
         my_wound$field = null;
      }
      
      public function get hasMyWound() : Boolean
      {
         return my_wound$field != null;
      }
      
      public function set myWound(param1:Int64) : void
      {
         my_wound$field = param1;
      }
      
      public function get myWound() : Int64
      {
         return my_wound$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967291;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 4;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeCurrentMillis() : void
      {
         current_millis$field = null;
      }
      
      public function get hasCurrentMillis() : Boolean
      {
         return current_millis$field != null;
      }
      
      public function set currentMillis(param1:Int64) : void
      {
         current_millis$field = param1;
      }
      
      public function get currentMillis() : Int64
      {
         return current_millis$field;
      }
      
      public function removeBufferGrade() : void
      {
         hasField$0 &= 4294967287;
         buffer_grade$field = new int();
      }
      
      public function get hasBufferGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set bufferGrade(param1:int) : void
      {
         hasField$0 |= 8;
         buffer_grade$field = param1;
      }
      
      public function get bufferGrade() : int
      {
         return buffer_grade$field;
      }
      
      public function removeBossType() : void
      {
         hasField$0 &= 4294967279;
         boss_type$field = new int();
      }
      
      public function get hasBossType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set bossType(param1:int) : void
      {
         hasField$0 |= 16;
         boss_type$field = param1;
      }
      
      public function get bossType() : int
      {
         return boss_type$field;
      }
      
      public function removeBossState() : void
      {
         hasField$0 &= 4294967263;
         boss_state$field = new int();
      }
      
      public function get hasBossState() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set bossState(param1:int) : void
      {
         hasField$0 |= 32;
         boss_state$field = param1;
      }
      
      public function get bossState() : int
      {
         return boss_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasCurHp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT64(param1,cur_hp$field);
         }
         if(hasTotalNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,total_num$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < woundInfo.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,woundInfo[_loc2_]);
            _loc2_++;
         }
         if(hasTotalHp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,total_hp$field);
         }
         if(hasMyWound)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,my_wound$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasCurrentMillis)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT64(param1,current_millis$field);
         }
         _loc3_ = 0;
         while(_loc3_ < castleWound.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,castleWound[_loc3_]);
            _loc3_++;
         }
         if(hasBufferGrade)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,buffer_grade$field);
         }
         if(hasBossType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,boss_type$field);
         }
         if(hasBossState)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,boss_state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc13_:WoundInfoMsg = null;
         var _loc15_:WoundInfoMsg = null;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.curHp cannot be set twice.");
                  }
                  _loc5_++;
                  curHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.totalNum cannot be set twice.");
                  }
                  _loc10_++;
                  totalNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.campaignId cannot be set twice.");
                  }
                  _loc7_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc13_ = new WoundInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  woundInfo.push(_loc13_);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.totalHp cannot be set twice.");
                  }
                  _loc6_++;
                  totalHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.myWound cannot be set twice.");
                  }
                  _loc9_++;
                  myWound = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.grades cannot be set twice.");
                  }
                  _loc14_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.currentMillis cannot be set twice.");
                  }
                  _loc11_++;
                  currentMillis = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 8:
                  _loc15_ = new WoundInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc15_);
                  castleWound.push(_loc15_);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.bufferGrade cannot be set twice.");
                  }
                  _loc8_++;
                  bufferGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.bossType cannot be set twice.");
                  }
                  _loc4_++;
                  bossType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossInfoMsg.bossState cannot be set twice.");
                  }
                  _loc3_++;
                  bossState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

