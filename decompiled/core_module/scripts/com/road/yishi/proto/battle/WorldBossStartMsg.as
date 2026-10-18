package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WorldBossStartMsg extends Message implements IExternalizable
   {
      
      private var node_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaign_id$field:int;
      
      private var hero_msg$field:HeroMsg;
      
      private var boss_type$field:int;
      
      private var result$field:Boolean;
      
      private var is_gm$field:Boolean;
      
      private var ai_id$field:int;
      
      private var skill_id$field:int;
      
      public function WorldBossStartMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
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
      
      public function removeHeroMsg() : void
      {
         hero_msg$field = null;
      }
      
      public function get hasHeroMsg() : Boolean
      {
         return hero_msg$field != null;
      }
      
      public function set heroMsg(param1:HeroMsg) : void
      {
         hero_msg$field = param1;
      }
      
      public function get heroMsg() : HeroMsg
      {
         return hero_msg$field;
      }
      
      public function removeBossType() : void
      {
         hasField$0 &= 4294967291;
         boss_type$field = new int();
      }
      
      public function get hasBossType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set bossType(param1:int) : void
      {
         hasField$0 |= 4;
         boss_type$field = param1;
      }
      
      public function get bossType() : int
      {
         return boss_type$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967287;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 8;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeIsGm() : void
      {
         hasField$0 &= 4294967279;
         is_gm$field = new Boolean();
      }
      
      public function get hasIsGm() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isGm(param1:Boolean) : void
      {
         hasField$0 |= 16;
         is_gm$field = param1;
      }
      
      public function get isGm() : Boolean
      {
         return is_gm$field;
      }
      
      public function removeAiId() : void
      {
         hasField$0 &= 4294967263;
         ai_id$field = new int();
      }
      
      public function get hasAiId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set aiId(param1:int) : void
      {
         hasField$0 |= 32;
         ai_id$field = param1;
      }
      
      public function get aiId() : int
      {
         return ai_id$field;
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967231;
         skill_id$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 64;
         skill_id$field = param1;
      }
      
      public function get skillId() : int
      {
         return skill_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasHeroMsg)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,hero_msg$field);
         }
         if(hasBossType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,boss_type$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasIsGm)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,is_gm$field);
         }
         if(hasAiId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,ai_id$field);
         }
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,skill_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossStartMsg.nodeId cannot be set twice.");
                  }
                  _loc10_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossStartMsg.campaignId cannot be set twice.");
                  }
                  _loc4_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossStartMsg.heroMsg cannot be set twice.");
                  }
                  _loc6_++;
                  heroMsg = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,heroMsg);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossStartMsg.bossType cannot be set twice.");
                  }
                  _loc7_++;
                  bossType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossStartMsg.result cannot be set twice.");
                  }
                  _loc8_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossStartMsg.isGm cannot be set twice.");
                  }
                  _loc3_++;
                  isGm = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossStartMsg.aiId cannot be set twice.");
                  }
                  _loc5_++;
                  aiId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossStartMsg.skillId cannot be set twice.");
                  }
                  _loc9_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

