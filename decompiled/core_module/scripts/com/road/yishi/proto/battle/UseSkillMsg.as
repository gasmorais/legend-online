package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class UseSkillMsg extends Message implements IExternalizable
   {
      
      private var battle_id$field:String;
      
      private var hero_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skill_id$field:int;
      
      public function UseSkillMsg()
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
      
      public function removeHeroId() : void
      {
         hasField$0 &= 4294967294;
         hero_id$field = new int();
      }
      
      public function get hasHeroId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set heroId(param1:int) : void
      {
         hasField$0 |= 1;
         hero_id$field = param1;
      }
      
      public function get heroId() : int
      {
         return hero_id$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,battle_id$field);
         }
         if(hasHeroId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,hero_id$field);
         }
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,skill_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: UseSkillMsg.battleId cannot be set twice.");
                  }
                  _loc5_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: UseSkillMsg.heroId cannot be set twice.");
                  }
                  _loc6_++;
                  heroId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: UseSkillMsg.skillId cannot be set twice.");
                  }
                  _loc3_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

