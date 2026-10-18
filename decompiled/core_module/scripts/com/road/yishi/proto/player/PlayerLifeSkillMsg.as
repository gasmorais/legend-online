package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerLifeSkillMsg extends Message implements IExternalizable
   {
      
      private var skillId$field:String;
      
      private var skillGrade$field:String;
      
      private var skillProficiency$field:String;
      
      private var collectCampaignId$field:String;
      
      private var skillComposeTimes$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skillCollectTimes$field:int;
      
      private var composeId$field:String;
      
      public function PlayerLifeSkillMsg()
      {
         super();
      }
      
      public function removeSkillId() : void
      {
         skillId$field = null;
      }
      
      public function get hasSkillId() : Boolean
      {
         return skillId$field != null;
      }
      
      public function set skillId(param1:String) : void
      {
         skillId$field = param1;
      }
      
      public function get skillId() : String
      {
         return skillId$field;
      }
      
      public function removeSkillGrade() : void
      {
         skillGrade$field = null;
      }
      
      public function get hasSkillGrade() : Boolean
      {
         return skillGrade$field != null;
      }
      
      public function set skillGrade(param1:String) : void
      {
         skillGrade$field = param1;
      }
      
      public function get skillGrade() : String
      {
         return skillGrade$field;
      }
      
      public function removeSkillProficiency() : void
      {
         skillProficiency$field = null;
      }
      
      public function get hasSkillProficiency() : Boolean
      {
         return skillProficiency$field != null;
      }
      
      public function set skillProficiency(param1:String) : void
      {
         skillProficiency$field = param1;
      }
      
      public function get skillProficiency() : String
      {
         return skillProficiency$field;
      }
      
      public function removeCollectCampaignId() : void
      {
         collectCampaignId$field = null;
      }
      
      public function get hasCollectCampaignId() : Boolean
      {
         return collectCampaignId$field != null;
      }
      
      public function set collectCampaignId(param1:String) : void
      {
         collectCampaignId$field = param1;
      }
      
      public function get collectCampaignId() : String
      {
         return collectCampaignId$field;
      }
      
      public function removeSkillComposeTimes() : void
      {
         hasField$0 &= 4294967294;
         skillComposeTimes$field = new int();
      }
      
      public function get hasSkillComposeTimes() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillComposeTimes(param1:int) : void
      {
         hasField$0 |= 1;
         skillComposeTimes$field = param1;
      }
      
      public function get skillComposeTimes() : int
      {
         return skillComposeTimes$field;
      }
      
      public function removeSkillCollectTimes() : void
      {
         hasField$0 &= 4294967293;
         skillCollectTimes$field = new int();
      }
      
      public function get hasSkillCollectTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set skillCollectTimes(param1:int) : void
      {
         hasField$0 |= 2;
         skillCollectTimes$field = param1;
      }
      
      public function get skillCollectTimes() : int
      {
         return skillCollectTimes$field;
      }
      
      public function removeComposeId() : void
      {
         composeId$field = null;
      }
      
      public function get hasComposeId() : Boolean
      {
         return composeId$field != null;
      }
      
      public function set composeId(param1:String) : void
      {
         composeId$field = param1;
      }
      
      public function get composeId() : String
      {
         return composeId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,skillId$field);
         }
         if(hasSkillGrade)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,skillGrade$field);
         }
         if(hasSkillProficiency)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,skillProficiency$field);
         }
         if(hasCollectCampaignId)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,collectCampaignId$field);
         }
         if(hasSkillComposeTimes)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,skillComposeTimes$field);
         }
         if(hasSkillCollectTimes)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,skillCollectTimes$field);
         }
         if(hasComposeId)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,composeId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLifeSkillMsg.skillId cannot be set twice.");
                  }
                  _loc6_++;
                  skillId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLifeSkillMsg.skillGrade cannot be set twice.");
                  }
                  _loc10_++;
                  skillGrade = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLifeSkillMsg.skillProficiency cannot be set twice.");
                  }
                  _loc7_++;
                  skillProficiency = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLifeSkillMsg.collectCampaignId cannot be set twice.");
                  }
                  _loc4_++;
                  collectCampaignId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLifeSkillMsg.skillComposeTimes cannot be set twice.");
                  }
                  _loc5_++;
                  skillComposeTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLifeSkillMsg.skillCollectTimes cannot be set twice.");
                  }
                  _loc8_++;
                  skillCollectTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLifeSkillMsg.composeId cannot be set twice.");
                  }
                  _loc3_++;
                  composeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

