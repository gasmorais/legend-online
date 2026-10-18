package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaMsg extends Message implements IExternalizable
   {
      
      private var consortia_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var apply_id$field:int;
      
      private var other_id$field:int;
      
      private var contribute_gold$field:int;
      
      private var upgrade_type$field:int;
      
      private var study_skill$field:int;
      
      private var position_id$field:int;
      
      private var bless_site$field:int;
      
      private var bless_temp_id$field:int;
      
      private var bless_count$field:int;
      
      private var placard$field:String;
      
      private var description$field:String;
      
      private var consortia_name$field:String;
      
      private var result$field:Boolean;
      
      private var bless_left_time$field:int;
      
      private var return_item$field:Boolean;
      
      private var is_pay$field:Boolean;
      
      private var group_placard$field:String;
      
      private var pay_type$field:int;
      
      private var skill_type$field:int;
      
      public function ConsortiaMsg()
      {
         super();
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967294;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 1;
         consortia_id$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortia_id$field;
      }
      
      public function removeApplyId() : void
      {
         hasField$0 &= 4294967293;
         apply_id$field = new int();
      }
      
      public function get hasApplyId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set applyId(param1:int) : void
      {
         hasField$0 |= 2;
         apply_id$field = param1;
      }
      
      public function get applyId() : int
      {
         return apply_id$field;
      }
      
      public function removeOtherId() : void
      {
         hasField$0 &= 4294967291;
         other_id$field = new int();
      }
      
      public function get hasOtherId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set otherId(param1:int) : void
      {
         hasField$0 |= 4;
         other_id$field = param1;
      }
      
      public function get otherId() : int
      {
         return other_id$field;
      }
      
      public function removeContributeGold() : void
      {
         hasField$0 &= 4294967287;
         contribute_gold$field = new int();
      }
      
      public function get hasContributeGold() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set contributeGold(param1:int) : void
      {
         hasField$0 |= 8;
         contribute_gold$field = param1;
      }
      
      public function get contributeGold() : int
      {
         return contribute_gold$field;
      }
      
      public function removeUpgradeType() : void
      {
         hasField$0 &= 4294967279;
         upgrade_type$field = new int();
      }
      
      public function get hasUpgradeType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set upgradeType(param1:int) : void
      {
         hasField$0 |= 16;
         upgrade_type$field = param1;
      }
      
      public function get upgradeType() : int
      {
         return upgrade_type$field;
      }
      
      public function removeStudySkill() : void
      {
         hasField$0 &= 4294967263;
         study_skill$field = new int();
      }
      
      public function get hasStudySkill() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set studySkill(param1:int) : void
      {
         hasField$0 |= 32;
         study_skill$field = param1;
      }
      
      public function get studySkill() : int
      {
         return study_skill$field;
      }
      
      public function removePositionId() : void
      {
         hasField$0 &= 4294967231;
         position_id$field = new int();
      }
      
      public function get hasPositionId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set positionId(param1:int) : void
      {
         hasField$0 |= 64;
         position_id$field = param1;
      }
      
      public function get positionId() : int
      {
         return position_id$field;
      }
      
      public function removeBlessSite() : void
      {
         hasField$0 &= 4294967167;
         bless_site$field = new int();
      }
      
      public function get hasBlessSite() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set blessSite(param1:int) : void
      {
         hasField$0 |= 128;
         bless_site$field = param1;
      }
      
      public function get blessSite() : int
      {
         return bless_site$field;
      }
      
      public function removeBlessTempId() : void
      {
         hasField$0 &= 4294967039;
         bless_temp_id$field = new int();
      }
      
      public function get hasBlessTempId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set blessTempId(param1:int) : void
      {
         hasField$0 |= 256;
         bless_temp_id$field = param1;
      }
      
      public function get blessTempId() : int
      {
         return bless_temp_id$field;
      }
      
      public function removeBlessCount() : void
      {
         hasField$0 &= 4294966783;
         bless_count$field = new int();
      }
      
      public function get hasBlessCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set blessCount(param1:int) : void
      {
         hasField$0 |= 512;
         bless_count$field = param1;
      }
      
      public function get blessCount() : int
      {
         return bless_count$field;
      }
      
      public function removePlacard() : void
      {
         placard$field = null;
      }
      
      public function get hasPlacard() : Boolean
      {
         return placard$field != null;
      }
      
      public function set placard(param1:String) : void
      {
         placard$field = param1;
      }
      
      public function get placard() : String
      {
         return placard$field;
      }
      
      public function removeDescription() : void
      {
         description$field = null;
      }
      
      public function get hasDescription() : Boolean
      {
         return description$field != null;
      }
      
      public function set description(param1:String) : void
      {
         description$field = param1;
      }
      
      public function get description() : String
      {
         return description$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortia_name$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortia_name$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortia_name$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortia_name$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294966271;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeBlessLeftTime() : void
      {
         hasField$0 &= 4294965247;
         bless_left_time$field = new int();
      }
      
      public function get hasBlessLeftTime() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set blessLeftTime(param1:int) : void
      {
         hasField$0 |= 2048;
         bless_left_time$field = param1;
      }
      
      public function get blessLeftTime() : int
      {
         return bless_left_time$field;
      }
      
      public function removeReturnItem() : void
      {
         hasField$0 &= 4294963199;
         return_item$field = new Boolean();
      }
      
      public function get hasReturnItem() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set returnItem(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         return_item$field = param1;
      }
      
      public function get returnItem() : Boolean
      {
         return return_item$field;
      }
      
      public function removeIsPay() : void
      {
         hasField$0 &= 4294959103;
         is_pay$field = new Boolean();
      }
      
      public function get hasIsPay() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set isPay(param1:Boolean) : void
      {
         hasField$0 |= 8192;
         is_pay$field = param1;
      }
      
      public function get isPay() : Boolean
      {
         return is_pay$field;
      }
      
      public function removeGroupPlacard() : void
      {
         group_placard$field = null;
      }
      
      public function get hasGroupPlacard() : Boolean
      {
         return group_placard$field != null;
      }
      
      public function set groupPlacard(param1:String) : void
      {
         group_placard$field = param1;
      }
      
      public function get groupPlacard() : String
      {
         return group_placard$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294950911;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 16384;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeSkillType() : void
      {
         hasField$0 &= 4294934527;
         skill_type$field = new int();
      }
      
      public function get hasSkillType() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set skillType(param1:int) : void
      {
         hasField$0 |= 32768;
         skill_type$field = param1;
      }
      
      public function get skillType() : int
      {
         return skill_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasApplyId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,apply_id$field);
         }
         if(hasOtherId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,other_id$field);
         }
         if(hasContributeGold)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,contribute_gold$field);
         }
         if(hasUpgradeType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,upgrade_type$field);
         }
         if(hasStudySkill)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,study_skill$field);
         }
         if(hasPositionId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,position_id$field);
         }
         if(hasBlessSite)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,bless_site$field);
         }
         if(hasBlessTempId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,bless_temp_id$field);
         }
         if(hasBlessCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,bless_count$field);
         }
         if(hasPlacard)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,placard$field);
         }
         if(hasDescription)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,description$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasBlessLeftTime)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,bless_left_time$field);
         }
         if(hasReturnItem)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,return_item$field);
         }
         if(hasIsPay)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,is_pay$field);
         }
         if(hasGroupPlacard)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,group_placard$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasSkillType)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,skill_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc16_:uint = 0;
         var _loc22_:uint = 0;
         var _loc23_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc10_:uint = 0;
         var _loc19_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc20_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.consortiaId cannot be set twice.");
                  }
                  _loc16_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.applyId cannot be set twice.");
                  }
                  _loc22_++;
                  applyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.otherId cannot be set twice.");
                  }
                  _loc23_++;
                  otherId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.contributeGold cannot be set twice.");
                  }
                  _loc17_++;
                  contributeGold = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.upgradeType cannot be set twice.");
                  }
                  _loc18_++;
                  upgradeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.studySkill cannot be set twice.");
                  }
                  _loc6_++;
                  studySkill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.positionId cannot be set twice.");
                  }
                  _loc12_++;
                  positionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.blessSite cannot be set twice.");
                  }
                  _loc4_++;
                  blessSite = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.blessTempId cannot be set twice.");
                  }
                  _loc7_++;
                  blessTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.blessCount cannot be set twice.");
                  }
                  _loc15_++;
                  blessCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.placard cannot be set twice.");
                  }
                  _loc10_++;
                  placard = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.description cannot be set twice.");
                  }
                  _loc19_++;
                  description = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.consortiaName cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.result cannot be set twice.");
                  }
                  _loc8_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.blessLeftTime cannot be set twice.");
                  }
                  _loc3_++;
                  blessLeftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.returnItem cannot be set twice.");
                  }
                  _loc14_++;
                  returnItem = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.isPay cannot be set twice.");
                  }
                  _loc20_++;
                  isPay = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.groupPlacard cannot be set twice.");
                  }
                  _loc13_++;
                  groupPlacard = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 19:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.payType cannot be set twice.");
                  }
                  _loc11_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMsg.skillType cannot be set twice.");
                  }
                  _loc9_++;
                  skillType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

