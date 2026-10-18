package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrossPetInfoMsg extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var petId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId$field:int;
      
      private var serverName$field:String;
      
      private var name$field:String;
      
      private var quality$field:int;
      
      private var templateId$field:int;
      
      private var hp$field:int;
      
      private var grade$field:int;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var lightResi$field:int;
      
      private var phyAttack$field:int;
      
      private var PhyDefence$field:int;
      
      private var magAttack$field:int;
      
      private var magDefence$field:int;
      
      private var defaultSkill$field:String;
      
      private var challengeSkill$field:String;
      
      private var fightPos$field:int;
      
      private var fightCapacity$field:int;
      
      public function CrossPetInfoMsg()
      {
         super();
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967294;
         petId$field = new int();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set petId(param1:int) : void
      {
         hasField$0 |= 1;
         petId$field = param1;
      }
      
      public function get petId() : int
      {
         return petId$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeQuality() : void
      {
         hasField$0 &= 4294967291;
         quality$field = new int();
      }
      
      public function get hasQuality() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set quality(param1:int) : void
      {
         hasField$0 |= 4;
         quality$field = param1;
      }
      
      public function get quality() : int
      {
         return quality$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967287;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 8;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967279;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 16;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967263;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 32;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$0 &= 4294967231;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$0 |= 64;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$0 &= 4294967167;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$0 |= 128;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$0 &= 4294967039;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$0 |= 256;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$0 &= 4294966783;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$0 |= 512;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$0 &= 4294966271;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$0 |= 1024;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$0 &= 4294965247;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$0 |= 2048;
         lightResi$field = param1;
      }
      
      public function get lightResi() : int
      {
         return lightResi$field;
      }
      
      public function removePhyAttack() : void
      {
         hasField$0 &= 4294963199;
         phyAttack$field = new int();
      }
      
      public function get hasPhyAttack() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set phyAttack(param1:int) : void
      {
         hasField$0 |= 4096;
         phyAttack$field = param1;
      }
      
      public function get phyAttack() : int
      {
         return phyAttack$field;
      }
      
      public function removePhyDefence() : void
      {
         hasField$0 &= 4294959103;
         PhyDefence$field = new int();
      }
      
      public function get hasPhyDefence() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set phyDefence(param1:int) : void
      {
         hasField$0 |= 8192;
         PhyDefence$field = param1;
      }
      
      public function get phyDefence() : int
      {
         return PhyDefence$field;
      }
      
      public function removeMagAttack() : void
      {
         hasField$0 &= 4294950911;
         magAttack$field = new int();
      }
      
      public function get hasMagAttack() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set magAttack(param1:int) : void
      {
         hasField$0 |= 16384;
         magAttack$field = param1;
      }
      
      public function get magAttack() : int
      {
         return magAttack$field;
      }
      
      public function removeMagDefence() : void
      {
         hasField$0 &= 4294934527;
         magDefence$field = new int();
      }
      
      public function get hasMagDefence() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set magDefence(param1:int) : void
      {
         hasField$0 |= 32768;
         magDefence$field = param1;
      }
      
      public function get magDefence() : int
      {
         return magDefence$field;
      }
      
      public function removeDefaultSkill() : void
      {
         defaultSkill$field = null;
      }
      
      public function get hasDefaultSkill() : Boolean
      {
         return defaultSkill$field != null;
      }
      
      public function set defaultSkill(param1:String) : void
      {
         defaultSkill$field = param1;
      }
      
      public function get defaultSkill() : String
      {
         return defaultSkill$field;
      }
      
      public function removeChallengeSkill() : void
      {
         challengeSkill$field = null;
      }
      
      public function get hasChallengeSkill() : Boolean
      {
         return challengeSkill$field != null;
      }
      
      public function set challengeSkill(param1:String) : void
      {
         challengeSkill$field = param1;
      }
      
      public function get challengeSkill() : String
      {
         return challengeSkill$field;
      }
      
      public function removeFightPos() : void
      {
         hasField$0 &= 4294901759;
         fightPos$field = new int();
      }
      
      public function get hasFightPos() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set fightPos(param1:int) : void
      {
         hasField$0 |= 65536;
         fightPos$field = param1;
      }
      
      public function get fightPos() : int
      {
         return fightPos$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294836223;
         fightCapacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 131072;
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fightCapacity$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,petId$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasQuality)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,quality$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
         if(hasPhyAttack)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,phyAttack$field);
         }
         if(hasPhyDefence)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,PhyDefence$field);
         }
         if(hasMagAttack)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,magAttack$field);
         }
         if(hasMagDefence)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,magDefence$field);
         }
         if(hasDefaultSkill)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_STRING(param1,defaultSkill$field);
         }
         if(hasChallengeSkill)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_STRING(param1,challengeSkill$field);
         }
         if(hasFightPos)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,fightPos$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,fightCapacity$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc18_:uint = 0;
         var _loc10_:uint = 0;
         var _loc22_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc24_:uint = 0;
         var _loc6_:uint = 0;
         var _loc16_:uint = 0;
         var _loc20_:uint = 0;
         var _loc25_:uint = 0;
         var _loc21_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc17_:uint = 0;
         var _loc14_:uint = 0;
         var _loc23_:uint = 0;
         var _loc26_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc19_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.uuid cannot be set twice.");
                  }
                  _loc9_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.petId cannot be set twice.");
                  }
                  _loc3_++;
                  petId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.userId cannot be set twice.");
                  }
                  _loc18_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.name cannot be set twice.");
                  }
                  _loc22_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.quality cannot be set twice.");
                  }
                  _loc4_++;
                  quality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.templateId cannot be set twice.");
                  }
                  _loc15_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.hp cannot be set twice.");
                  }
                  _loc24_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.grade cannot be set twice.");
                  }
                  _loc6_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.fireResi cannot be set twice.");
                  }
                  _loc16_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.waterResi cannot be set twice.");
                  }
                  _loc20_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.electResi cannot be set twice.");
                  }
                  _loc25_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.windResi cannot be set twice.");
                  }
                  _loc21_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.darkResi cannot be set twice.");
                  }
                  _loc13_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.lightResi cannot be set twice.");
                  }
                  _loc11_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.phyAttack cannot be set twice.");
                  }
                  _loc7_++;
                  phyAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.phyDefence cannot be set twice.");
                  }
                  _loc17_++;
                  phyDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.magAttack cannot be set twice.");
                  }
                  _loc14_++;
                  magAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.magDefence cannot be set twice.");
                  }
                  _loc23_++;
                  magDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.defaultSkill cannot be set twice.");
                  }
                  _loc26_++;
                  defaultSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 21:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.challengeSkill cannot be set twice.");
                  }
                  _loc8_++;
                  challengeSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 22:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.fightPos cannot be set twice.");
                  }
                  _loc5_++;
                  fightPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: CrossPetInfoMsg.fightCapacity cannot be set twice.");
                  }
                  _loc19_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

