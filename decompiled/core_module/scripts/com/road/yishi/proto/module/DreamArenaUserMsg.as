package com.road.yishi.proto.module
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DreamArenaUserMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var heroId$field:int;
      
      private var heroPetId$field:int;
      
      private var goddessId$field:int;
      
      private var mainChildId$field:int;
      
      private var mainChildPetId$field:int;
      
      private var salveChildId$field:int;
      
      private var salveChildPetId$field:int;
      
      private var artifactId$field:int;
      
      private var skillIndex1$field:int;
      
      private var skillIndex2$field:int;
      
      private var talismanTempId1$field:int;
      
      private var talismanTempId2$field:int;
      
      private var talismanSkillId1$field:int;
      
      private var talismanSkillId2$field:int;
      
      private var armoryId1$field:int;
      
      private var armoryId2$field:int;
      
      private var armoryId3$field:int;
      
      private var runeId1$field:int;
      
      private var runeId2$field:int;
      
      private var titanSkills$field:String;
      
      private var heroPos$field:int;
      
      private var dragonSkill$field:String;
      
      private var dragonPassiveSkill$field:String;
      
      public function DreamArenaUserMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeHeroId() : void
      {
         hasField$0 &= 4294967293;
         heroId$field = new int();
      }
      
      public function get hasHeroId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set heroId(param1:int) : void
      {
         hasField$0 |= 2;
         heroId$field = param1;
      }
      
      public function get heroId() : int
      {
         return heroId$field;
      }
      
      public function removeHeroPetId() : void
      {
         hasField$0 &= 4294967291;
         heroPetId$field = new int();
      }
      
      public function get hasHeroPetId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set heroPetId(param1:int) : void
      {
         hasField$0 |= 4;
         heroPetId$field = param1;
      }
      
      public function get heroPetId() : int
      {
         return heroPetId$field;
      }
      
      public function removeGoddessId() : void
      {
         hasField$0 &= 4294967287;
         goddessId$field = new int();
      }
      
      public function get hasGoddessId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set goddessId(param1:int) : void
      {
         hasField$0 |= 8;
         goddessId$field = param1;
      }
      
      public function get goddessId() : int
      {
         return goddessId$field;
      }
      
      public function removeMainChildId() : void
      {
         hasField$0 &= 4294967279;
         mainChildId$field = new int();
      }
      
      public function get hasMainChildId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set mainChildId(param1:int) : void
      {
         hasField$0 |= 16;
         mainChildId$field = param1;
      }
      
      public function get mainChildId() : int
      {
         return mainChildId$field;
      }
      
      public function removeMainChildPetId() : void
      {
         hasField$0 &= 4294967263;
         mainChildPetId$field = new int();
      }
      
      public function get hasMainChildPetId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set mainChildPetId(param1:int) : void
      {
         hasField$0 |= 32;
         mainChildPetId$field = param1;
      }
      
      public function get mainChildPetId() : int
      {
         return mainChildPetId$field;
      }
      
      public function removeSalveChildId() : void
      {
         hasField$0 &= 4294967231;
         salveChildId$field = new int();
      }
      
      public function get hasSalveChildId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set salveChildId(param1:int) : void
      {
         hasField$0 |= 64;
         salveChildId$field = param1;
      }
      
      public function get salveChildId() : int
      {
         return salveChildId$field;
      }
      
      public function removeSalveChildPetId() : void
      {
         hasField$0 &= 4294967167;
         salveChildPetId$field = new int();
      }
      
      public function get hasSalveChildPetId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set salveChildPetId(param1:int) : void
      {
         hasField$0 |= 128;
         salveChildPetId$field = param1;
      }
      
      public function get salveChildPetId() : int
      {
         return salveChildPetId$field;
      }
      
      public function removeArtifactId() : void
      {
         hasField$0 &= 4294967039;
         artifactId$field = new int();
      }
      
      public function get hasArtifactId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set artifactId(param1:int) : void
      {
         hasField$0 |= 256;
         artifactId$field = param1;
      }
      
      public function get artifactId() : int
      {
         return artifactId$field;
      }
      
      public function removeSkillIndex1() : void
      {
         hasField$0 &= 4294966783;
         skillIndex1$field = new int();
      }
      
      public function get hasSkillIndex1() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set skillIndex1(param1:int) : void
      {
         hasField$0 |= 512;
         skillIndex1$field = param1;
      }
      
      public function get skillIndex1() : int
      {
         return skillIndex1$field;
      }
      
      public function removeSkillIndex2() : void
      {
         hasField$0 &= 4294966271;
         skillIndex2$field = new int();
      }
      
      public function get hasSkillIndex2() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set skillIndex2(param1:int) : void
      {
         hasField$0 |= 1024;
         skillIndex2$field = param1;
      }
      
      public function get skillIndex2() : int
      {
         return skillIndex2$field;
      }
      
      public function removeTalismanTempId1() : void
      {
         hasField$0 &= 4294965247;
         talismanTempId1$field = new int();
      }
      
      public function get hasTalismanTempId1() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set talismanTempId1(param1:int) : void
      {
         hasField$0 |= 2048;
         talismanTempId1$field = param1;
      }
      
      public function get talismanTempId1() : int
      {
         return talismanTempId1$field;
      }
      
      public function removeTalismanTempId2() : void
      {
         hasField$0 &= 4294963199;
         talismanTempId2$field = new int();
      }
      
      public function get hasTalismanTempId2() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set talismanTempId2(param1:int) : void
      {
         hasField$0 |= 4096;
         talismanTempId2$field = param1;
      }
      
      public function get talismanTempId2() : int
      {
         return talismanTempId2$field;
      }
      
      public function removeTalismanSkillId1() : void
      {
         hasField$0 &= 4294959103;
         talismanSkillId1$field = new int();
      }
      
      public function get hasTalismanSkillId1() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set talismanSkillId1(param1:int) : void
      {
         hasField$0 |= 8192;
         talismanSkillId1$field = param1;
      }
      
      public function get talismanSkillId1() : int
      {
         return talismanSkillId1$field;
      }
      
      public function removeTalismanSkillId2() : void
      {
         hasField$0 &= 4294950911;
         talismanSkillId2$field = new int();
      }
      
      public function get hasTalismanSkillId2() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set talismanSkillId2(param1:int) : void
      {
         hasField$0 |= 16384;
         talismanSkillId2$field = param1;
      }
      
      public function get talismanSkillId2() : int
      {
         return talismanSkillId2$field;
      }
      
      public function removeArmoryId1() : void
      {
         hasField$0 &= 4294934527;
         armoryId1$field = new int();
      }
      
      public function get hasArmoryId1() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set armoryId1(param1:int) : void
      {
         hasField$0 |= 32768;
         armoryId1$field = param1;
      }
      
      public function get armoryId1() : int
      {
         return armoryId1$field;
      }
      
      public function removeArmoryId2() : void
      {
         hasField$0 &= 4294901759;
         armoryId2$field = new int();
      }
      
      public function get hasArmoryId2() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set armoryId2(param1:int) : void
      {
         hasField$0 |= 65536;
         armoryId2$field = param1;
      }
      
      public function get armoryId2() : int
      {
         return armoryId2$field;
      }
      
      public function removeArmoryId3() : void
      {
         hasField$0 &= 4294836223;
         armoryId3$field = new int();
      }
      
      public function get hasArmoryId3() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set armoryId3(param1:int) : void
      {
         hasField$0 |= 131072;
         armoryId3$field = param1;
      }
      
      public function get armoryId3() : int
      {
         return armoryId3$field;
      }
      
      public function removeRuneId1() : void
      {
         hasField$0 &= 4294705151;
         runeId1$field = new int();
      }
      
      public function get hasRuneId1() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set runeId1(param1:int) : void
      {
         hasField$0 |= 262144;
         runeId1$field = param1;
      }
      
      public function get runeId1() : int
      {
         return runeId1$field;
      }
      
      public function removeRuneId2() : void
      {
         hasField$0 &= 4294443007;
         runeId2$field = new int();
      }
      
      public function get hasRuneId2() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set runeId2(param1:int) : void
      {
         hasField$0 |= 524288;
         runeId2$field = param1;
      }
      
      public function get runeId2() : int
      {
         return runeId2$field;
      }
      
      public function removeTitanSkills() : void
      {
         titanSkills$field = null;
      }
      
      public function get hasTitanSkills() : Boolean
      {
         return titanSkills$field != null;
      }
      
      public function set titanSkills(param1:String) : void
      {
         titanSkills$field = param1;
      }
      
      public function get titanSkills() : String
      {
         return titanSkills$field;
      }
      
      public function removeHeroPos() : void
      {
         hasField$0 &= 4293918719;
         heroPos$field = new int();
      }
      
      public function get hasHeroPos() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set heroPos(param1:int) : void
      {
         hasField$0 |= 1048576;
         heroPos$field = param1;
      }
      
      public function get heroPos() : int
      {
         return heroPos$field;
      }
      
      public function removeDragonSkill() : void
      {
         dragonSkill$field = null;
      }
      
      public function get hasDragonSkill() : Boolean
      {
         return dragonSkill$field != null;
      }
      
      public function set dragonSkill(param1:String) : void
      {
         dragonSkill$field = param1;
      }
      
      public function get dragonSkill() : String
      {
         return dragonSkill$field;
      }
      
      public function removeDragonPassiveSkill() : void
      {
         dragonPassiveSkill$field = null;
      }
      
      public function get hasDragonPassiveSkill() : Boolean
      {
         return dragonPassiveSkill$field != null;
      }
      
      public function set dragonPassiveSkill(param1:String) : void
      {
         dragonPassiveSkill$field = param1;
      }
      
      public function get dragonPassiveSkill() : String
      {
         return dragonPassiveSkill$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasHeroId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,heroId$field);
         }
         if(hasHeroPetId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,heroPetId$field);
         }
         if(hasGoddessId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,goddessId$field);
         }
         if(hasMainChildId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,mainChildId$field);
         }
         if(hasMainChildPetId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,mainChildPetId$field);
         }
         if(hasSalveChildId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,salveChildId$field);
         }
         if(hasSalveChildPetId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,salveChildPetId$field);
         }
         if(hasArtifactId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,artifactId$field);
         }
         if(hasSkillIndex1)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,skillIndex1$field);
         }
         if(hasSkillIndex2)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,skillIndex2$field);
         }
         if(hasTalismanTempId1)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,talismanTempId1$field);
         }
         if(hasTalismanTempId2)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,talismanTempId2$field);
         }
         if(hasTalismanSkillId1)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,talismanSkillId1$field);
         }
         if(hasTalismanSkillId2)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,talismanSkillId2$field);
         }
         if(hasArmoryId1)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,armoryId1$field);
         }
         if(hasArmoryId2)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,armoryId2$field);
         }
         if(hasArmoryId3)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,armoryId3$field);
         }
         if(hasRuneId1)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,runeId1$field);
         }
         if(hasRuneId2)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,runeId2$field);
         }
         if(hasTitanSkills)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_STRING(param1,titanSkills$field);
         }
         if(hasHeroPos)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,heroPos$field);
         }
         if(hasDragonSkill)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_STRING(param1,dragonSkill$field);
         }
         if(hasDragonPassiveSkill)
         {
            WriteUtils.writeTag(param1,2,24);
            WriteUtils.write$TYPE_STRING(param1,dragonPassiveSkill$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc20_:uint = 0;
         var _loc15_:uint = 0;
         var _loc10_:uint = 0;
         var _loc26_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc23_:uint = 0;
         var _loc27_:uint = 0;
         var _loc24_:uint = 0;
         var _loc9_:uint = 0;
         var _loc19_:uint = 0;
         var _loc8_:uint = 0;
         var _loc25_:uint = 0;
         var _loc14_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc17_:uint = 0;
         var _loc12_:uint = 0;
         var _loc22_:uint = 0;
         var _loc4_:uint = 0;
         var _loc18_:uint = 0;
         var _loc21_:uint = 0;
         var _loc11_:uint = 0;
         var _loc16_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.userId cannot be set twice.");
                  }
                  _loc20_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.heroId cannot be set twice.");
                  }
                  _loc15_++;
                  heroId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.heroPetId cannot be set twice.");
                  }
                  _loc10_++;
                  heroPetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.goddessId cannot be set twice.");
                  }
                  _loc26_++;
                  goddessId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.mainChildId cannot be set twice.");
                  }
                  _loc7_++;
                  mainChildId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.mainChildPetId cannot be set twice.");
                  }
                  _loc6_++;
                  mainChildPetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.salveChildId cannot be set twice.");
                  }
                  _loc23_++;
                  salveChildId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.salveChildPetId cannot be set twice.");
                  }
                  _loc27_++;
                  salveChildPetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.artifactId cannot be set twice.");
                  }
                  _loc24_++;
                  artifactId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.skillIndex1 cannot be set twice.");
                  }
                  _loc9_++;
                  skillIndex1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.skillIndex2 cannot be set twice.");
                  }
                  _loc19_++;
                  skillIndex2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.talismanTempId1 cannot be set twice.");
                  }
                  _loc8_++;
                  talismanTempId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.talismanTempId2 cannot be set twice.");
                  }
                  _loc25_++;
                  talismanTempId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.talismanSkillId1 cannot be set twice.");
                  }
                  _loc14_++;
                  talismanSkillId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.talismanSkillId2 cannot be set twice.");
                  }
                  _loc5_++;
                  talismanSkillId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.armoryId1 cannot be set twice.");
                  }
                  _loc3_++;
                  armoryId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.armoryId2 cannot be set twice.");
                  }
                  _loc17_++;
                  armoryId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.armoryId3 cannot be set twice.");
                  }
                  _loc12_++;
                  armoryId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.runeId1 cannot be set twice.");
                  }
                  _loc22_++;
                  runeId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.runeId2 cannot be set twice.");
                  }
                  _loc4_++;
                  runeId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.titanSkills cannot be set twice.");
                  }
                  _loc18_++;
                  titanSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 22:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.heroPos cannot be set twice.");
                  }
                  _loc21_++;
                  heroPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.dragonSkill cannot be set twice.");
                  }
                  _loc11_++;
                  dragonSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 24:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: DreamArenaUserMsg.dragonPassiveSkill cannot be set twice.");
                  }
                  _loc16_++;
                  dragonPassiveSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

