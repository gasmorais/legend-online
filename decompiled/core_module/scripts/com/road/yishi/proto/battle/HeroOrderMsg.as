package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroOrderMsg extends Message implements IExternalizable
   {
      
      private var battle_id$field:String;
      
      private var hero_index_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skill_id$field:int;
      
      private var result$field:int;
      
      private var cast_time$field:int;
      
      private var qte_time$field:int;
      
      [ArrayElementType("int")]
      public var targetIndexs:Array = [];
      
      public function HeroOrderMsg()
      {
         super();
      }
      
      public function removeBattleId() : void
      {
         battle_id$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battle_id$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battle_id$field = param1;
      }
      
      public function get battleId() : String
      {
         return battle_id$field;
      }
      
      public function removeHeroIndexId() : void
      {
         hasField$0 &= 4294967294;
         hero_index_id$field = new int();
      }
      
      public function get hasHeroIndexId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set heroIndexId(param1:int) : void
      {
         hasField$0 |= 1;
         hero_index_id$field = param1;
      }
      
      public function get heroIndexId() : int
      {
         return hero_index_id$field;
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967293;
         skill_id$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 2;
         skill_id$field = param1;
      }
      
      public function get skillId() : int
      {
         return skill_id$field;
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
      
      public function removeCastTime() : void
      {
         hasField$0 &= 4294967287;
         cast_time$field = new int();
      }
      
      public function get hasCastTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set castTime(param1:int) : void
      {
         hasField$0 |= 8;
         cast_time$field = param1;
      }
      
      public function get castTime() : int
      {
         return cast_time$field;
      }
      
      public function removeQteTime() : void
      {
         hasField$0 &= 4294967279;
         qte_time$field = new int();
      }
      
      public function get hasQteTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set qteTime(param1:int) : void
      {
         hasField$0 |= 16;
         qte_time$field = param1;
      }
      
      public function get qteTime() : int
      {
         return qte_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,battle_id$field);
         }
         if(hasHeroIndexId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,hero_index_id$field);
         }
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,skill_id$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasCastTime)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,cast_time$field);
         }
         if(hasQteTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,qte_time$field);
         }
         _loc2_ = 0;
         while(_loc2_ < targetIndexs.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,targetIndexs[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeroOrderMsg.battleId cannot be set twice.");
                  }
                  _loc9_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroOrderMsg.heroIndexId cannot be set twice.");
                  }
                  _loc3_++;
                  heroIndexId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroOrderMsg.skillId cannot be set twice.");
                  }
                  _loc6_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeroOrderMsg.result cannot be set twice.");
                  }
                  _loc7_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroOrderMsg.castTime cannot be set twice.");
                  }
                  _loc4_++;
                  castTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroOrderMsg.qteTime cannot be set twice.");
                  }
                  _loc5_++;
                  qteTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,targetIndexs);
                  }
                  else
                  {
                     targetIndexs.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

