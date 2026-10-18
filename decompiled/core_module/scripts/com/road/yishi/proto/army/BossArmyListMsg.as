package com.road.yishi.proto.army
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BossArmyListMsg extends Message implements IExternalizable
   {
      
      private var left_fight_time$field:int;
      
      private var hasField$0:uint = 0;
      
      private var boss_name$field:String;
      
      private var level$field:int;
      
      private var boss_template_id$field:int;
      
      [ArrayElementType("com.road.yishi.proto.army.FightPlayerMsg")]
      public var fightPlayer:Array = [];
      
      public function BossArmyListMsg()
      {
         super();
      }
      
      public function removeLeftFightTime() : void
      {
         hasField$0 &= 4294967294;
         left_fight_time$field = new int();
      }
      
      public function get hasLeftFightTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leftFightTime(param1:int) : void
      {
         hasField$0 |= 1;
         left_fight_time$field = param1;
      }
      
      public function get leftFightTime() : int
      {
         return left_fight_time$field;
      }
      
      public function removeBossName() : void
      {
         boss_name$field = null;
      }
      
      public function get hasBossName() : Boolean
      {
         return boss_name$field != null;
      }
      
      public function set bossName(param1:String) : void
      {
         boss_name$field = param1;
      }
      
      public function get bossName() : String
      {
         return boss_name$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeBossTemplateId() : void
      {
         hasField$0 &= 4294967291;
         boss_template_id$field = new int();
      }
      
      public function get hasBossTemplateId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set bossTemplateId(param1:int) : void
      {
         hasField$0 |= 4;
         boss_template_id$field = param1;
      }
      
      public function get bossTemplateId() : int
      {
         return boss_template_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLeftFightTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,left_fight_time$field);
         }
         if(hasBossName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,boss_name$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasBossTemplateId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,boss_template_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < fightPlayer.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,fightPlayer[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:FightPlayerMsg = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BossArmyListMsg.leftFightTime cannot be set twice.");
                  }
                  _loc4_++;
                  leftFightTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BossArmyListMsg.bossName cannot be set twice.");
                  }
                  _loc3_++;
                  bossName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BossArmyListMsg.level cannot be set twice.");
                  }
                  _loc5_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BossArmyListMsg.bossTemplateId cannot be set twice.");
                  }
                  _loc8_++;
                  bossTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc6_ = new FightPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  fightPlayer.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

