package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetHallowInfoMsg extends Message implements IExternalizable
   {
      
      private var hallowSonType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var hallowTempId$field:int;
      
      private var infuseIndex$field:int;
      
      private var attackData$field:int;
      
      private var defenceData$field:int;
      
      private var magicDefenceData$field:int;
      
      private var liveData$field:int;
      
      private var reduceResiData$field:int;
      
      private var otherResiData$field:int;
      
      private var equipPetId$field:int;
      
      private var attackGp$field:int;
      
      private var defenceGp$field:int;
      
      private var magicDefenceGp$field:int;
      
      private var liveGp$field:int;
      
      private var reduceResiGp$field:int;
      
      private var otherResiGp$field:int;
      
      private var attackGrade$field:int;
      
      private var defenceGrade$field:int;
      
      private var magicDefenceGrade$field:int;
      
      private var liveGrade$field:int;
      
      private var reduceResiGrade$field:int;
      
      private var otherResiGrade$field:int;
      
      private var activeSkillTempId$field:int;
      
      public function PetHallowInfoMsg()
      {
         super();
      }
      
      public function removeHallowSonType() : void
      {
         hasField$0 &= 4294967294;
         hallowSonType$field = new int();
      }
      
      public function get hasHallowSonType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set hallowSonType(param1:int) : void
      {
         hasField$0 |= 1;
         hallowSonType$field = param1;
      }
      
      public function get hallowSonType() : int
      {
         return hallowSonType$field;
      }
      
      public function removeHallowTempId() : void
      {
         hasField$0 &= 4294967293;
         hallowTempId$field = new int();
      }
      
      public function get hasHallowTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hallowTempId(param1:int) : void
      {
         hasField$0 |= 2;
         hallowTempId$field = param1;
      }
      
      public function get hallowTempId() : int
      {
         return hallowTempId$field;
      }
      
      public function removeInfuseIndex() : void
      {
         hasField$0 &= 4294967291;
         infuseIndex$field = new int();
      }
      
      public function get hasInfuseIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set infuseIndex(param1:int) : void
      {
         hasField$0 |= 4;
         infuseIndex$field = param1;
      }
      
      public function get infuseIndex() : int
      {
         return infuseIndex$field;
      }
      
      public function removeAttackData() : void
      {
         hasField$0 &= 4294967287;
         attackData$field = new int();
      }
      
      public function get hasAttackData() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attackData(param1:int) : void
      {
         hasField$0 |= 8;
         attackData$field = param1;
      }
      
      public function get attackData() : int
      {
         return attackData$field;
      }
      
      public function removeDefenceData() : void
      {
         hasField$0 &= 4294967279;
         defenceData$field = new int();
      }
      
      public function get hasDefenceData() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set defenceData(param1:int) : void
      {
         hasField$0 |= 16;
         defenceData$field = param1;
      }
      
      public function get defenceData() : int
      {
         return defenceData$field;
      }
      
      public function removeMagicDefenceData() : void
      {
         hasField$0 &= 4294967263;
         magicDefenceData$field = new int();
      }
      
      public function get hasMagicDefenceData() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set magicDefenceData(param1:int) : void
      {
         hasField$0 |= 32;
         magicDefenceData$field = param1;
      }
      
      public function get magicDefenceData() : int
      {
         return magicDefenceData$field;
      }
      
      public function removeLiveData() : void
      {
         hasField$0 &= 4294967231;
         liveData$field = new int();
      }
      
      public function get hasLiveData() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set liveData(param1:int) : void
      {
         hasField$0 |= 64;
         liveData$field = param1;
      }
      
      public function get liveData() : int
      {
         return liveData$field;
      }
      
      public function removeReduceResiData() : void
      {
         hasField$0 &= 4294967167;
         reduceResiData$field = new int();
      }
      
      public function get hasReduceResiData() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set reduceResiData(param1:int) : void
      {
         hasField$0 |= 128;
         reduceResiData$field = param1;
      }
      
      public function get reduceResiData() : int
      {
         return reduceResiData$field;
      }
      
      public function removeOtherResiData() : void
      {
         hasField$0 &= 4294967039;
         otherResiData$field = new int();
      }
      
      public function get hasOtherResiData() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set otherResiData(param1:int) : void
      {
         hasField$0 |= 256;
         otherResiData$field = param1;
      }
      
      public function get otherResiData() : int
      {
         return otherResiData$field;
      }
      
      public function removeEquipPetId() : void
      {
         hasField$0 &= 4294966783;
         equipPetId$field = new int();
      }
      
      public function get hasEquipPetId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set equipPetId(param1:int) : void
      {
         hasField$0 |= 512;
         equipPetId$field = param1;
      }
      
      public function get equipPetId() : int
      {
         return equipPetId$field;
      }
      
      public function removeAttackGp() : void
      {
         hasField$0 &= 4294966271;
         attackGp$field = new int();
      }
      
      public function get hasAttackGp() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set attackGp(param1:int) : void
      {
         hasField$0 |= 1024;
         attackGp$field = param1;
      }
      
      public function get attackGp() : int
      {
         return attackGp$field;
      }
      
      public function removeDefenceGp() : void
      {
         hasField$0 &= 4294965247;
         defenceGp$field = new int();
      }
      
      public function get hasDefenceGp() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set defenceGp(param1:int) : void
      {
         hasField$0 |= 2048;
         defenceGp$field = param1;
      }
      
      public function get defenceGp() : int
      {
         return defenceGp$field;
      }
      
      public function removeMagicDefenceGp() : void
      {
         hasField$0 &= 4294963199;
         magicDefenceGp$field = new int();
      }
      
      public function get hasMagicDefenceGp() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set magicDefenceGp(param1:int) : void
      {
         hasField$0 |= 4096;
         magicDefenceGp$field = param1;
      }
      
      public function get magicDefenceGp() : int
      {
         return magicDefenceGp$field;
      }
      
      public function removeLiveGp() : void
      {
         hasField$0 &= 4294959103;
         liveGp$field = new int();
      }
      
      public function get hasLiveGp() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set liveGp(param1:int) : void
      {
         hasField$0 |= 8192;
         liveGp$field = param1;
      }
      
      public function get liveGp() : int
      {
         return liveGp$field;
      }
      
      public function removeReduceResiGp() : void
      {
         hasField$0 &= 4294950911;
         reduceResiGp$field = new int();
      }
      
      public function get hasReduceResiGp() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set reduceResiGp(param1:int) : void
      {
         hasField$0 |= 16384;
         reduceResiGp$field = param1;
      }
      
      public function get reduceResiGp() : int
      {
         return reduceResiGp$field;
      }
      
      public function removeOtherResiGp() : void
      {
         hasField$0 &= 4294934527;
         otherResiGp$field = new int();
      }
      
      public function get hasOtherResiGp() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set otherResiGp(param1:int) : void
      {
         hasField$0 |= 32768;
         otherResiGp$field = param1;
      }
      
      public function get otherResiGp() : int
      {
         return otherResiGp$field;
      }
      
      public function removeAttackGrade() : void
      {
         hasField$0 &= 4294901759;
         attackGrade$field = new int();
      }
      
      public function get hasAttackGrade() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set attackGrade(param1:int) : void
      {
         hasField$0 |= 65536;
         attackGrade$field = param1;
      }
      
      public function get attackGrade() : int
      {
         return attackGrade$field;
      }
      
      public function removeDefenceGrade() : void
      {
         hasField$0 &= 4294836223;
         defenceGrade$field = new int();
      }
      
      public function get hasDefenceGrade() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set defenceGrade(param1:int) : void
      {
         hasField$0 |= 131072;
         defenceGrade$field = param1;
      }
      
      public function get defenceGrade() : int
      {
         return defenceGrade$field;
      }
      
      public function removeMagicDefenceGrade() : void
      {
         hasField$0 &= 4294705151;
         magicDefenceGrade$field = new int();
      }
      
      public function get hasMagicDefenceGrade() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set magicDefenceGrade(param1:int) : void
      {
         hasField$0 |= 262144;
         magicDefenceGrade$field = param1;
      }
      
      public function get magicDefenceGrade() : int
      {
         return magicDefenceGrade$field;
      }
      
      public function removeLiveGrade() : void
      {
         hasField$0 &= 4294443007;
         liveGrade$field = new int();
      }
      
      public function get hasLiveGrade() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set liveGrade(param1:int) : void
      {
         hasField$0 |= 524288;
         liveGrade$field = param1;
      }
      
      public function get liveGrade() : int
      {
         return liveGrade$field;
      }
      
      public function removeReduceResiGrade() : void
      {
         hasField$0 &= 4293918719;
         reduceResiGrade$field = new int();
      }
      
      public function get hasReduceResiGrade() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set reduceResiGrade(param1:int) : void
      {
         hasField$0 |= 1048576;
         reduceResiGrade$field = param1;
      }
      
      public function get reduceResiGrade() : int
      {
         return reduceResiGrade$field;
      }
      
      public function removeOtherResiGrade() : void
      {
         hasField$0 &= 4292870143;
         otherResiGrade$field = new int();
      }
      
      public function get hasOtherResiGrade() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set otherResiGrade(param1:int) : void
      {
         hasField$0 |= 2097152;
         otherResiGrade$field = param1;
      }
      
      public function get otherResiGrade() : int
      {
         return otherResiGrade$field;
      }
      
      public function removeActiveSkillTempId() : void
      {
         hasField$0 &= 4290772991;
         activeSkillTempId$field = new int();
      }
      
      public function get hasActiveSkillTempId() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set activeSkillTempId(param1:int) : void
      {
         hasField$0 |= 4194304;
         activeSkillTempId$field = param1;
      }
      
      public function get activeSkillTempId() : int
      {
         return activeSkillTempId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasHallowSonType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,hallowSonType$field);
         }
         if(hasHallowTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,hallowTempId$field);
         }
         if(hasInfuseIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,infuseIndex$field);
         }
         if(hasAttackData)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,attackData$field);
         }
         if(hasDefenceData)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,defenceData$field);
         }
         if(hasMagicDefenceData)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,magicDefenceData$field);
         }
         if(hasLiveData)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,liveData$field);
         }
         if(hasReduceResiData)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,reduceResiData$field);
         }
         if(hasOtherResiData)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,otherResiData$field);
         }
         if(hasEquipPetId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,equipPetId$field);
         }
         if(hasAttackGp)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,attackGp$field);
         }
         if(hasDefenceGp)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,defenceGp$field);
         }
         if(hasMagicDefenceGp)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,magicDefenceGp$field);
         }
         if(hasLiveGp)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,liveGp$field);
         }
         if(hasReduceResiGp)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,reduceResiGp$field);
         }
         if(hasOtherResiGp)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,otherResiGp$field);
         }
         if(hasAttackGrade)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,attackGrade$field);
         }
         if(hasDefenceGrade)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,defenceGrade$field);
         }
         if(hasMagicDefenceGrade)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,magicDefenceGrade$field);
         }
         if(hasLiveGrade)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,liveGrade$field);
         }
         if(hasReduceResiGrade)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,reduceResiGrade$field);
         }
         if(hasOtherResiGrade)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,otherResiGrade$field);
         }
         if(hasActiveSkillTempId)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,activeSkillTempId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc17_:uint = 0;
         var _loc23_:uint = 0;
         var _loc24_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc22_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         var _loc21_:uint = 0;
         var _loc19_:uint = 0;
         var _loc11_:uint = 0;
         var _loc25_:uint = 0;
         var _loc20_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc26_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc18_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.hallowSonType cannot be set twice.");
                  }
                  _loc17_++;
                  hallowSonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.hallowTempId cannot be set twice.");
                  }
                  _loc23_++;
                  hallowTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.infuseIndex cannot be set twice.");
                  }
                  _loc24_++;
                  infuseIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.attackData cannot be set twice.");
                  }
                  _loc9_++;
                  attackData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.defenceData cannot be set twice.");
                  }
                  _loc13_++;
                  defenceData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.magicDefenceData cannot be set twice.");
                  }
                  _loc22_++;
                  magicDefenceData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.liveData cannot be set twice.");
                  }
                  _loc10_++;
                  liveData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.reduceResiData cannot be set twice.");
                  }
                  _loc5_++;
                  reduceResiData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.otherResiData cannot be set twice.");
                  }
                  _loc6_++;
                  otherResiData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.equipPetId cannot be set twice.");
                  }
                  _loc14_++;
                  equipPetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.attackGp cannot be set twice.");
                  }
                  _loc21_++;
                  attackGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.defenceGp cannot be set twice.");
                  }
                  _loc19_++;
                  defenceGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.magicDefenceGp cannot be set twice.");
                  }
                  _loc11_++;
                  magicDefenceGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.liveGp cannot be set twice.");
                  }
                  _loc25_++;
                  liveGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.reduceResiGp cannot be set twice.");
                  }
                  _loc20_++;
                  reduceResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.otherResiGp cannot be set twice.");
                  }
                  _loc15_++;
                  otherResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.attackGrade cannot be set twice.");
                  }
                  _loc16_++;
                  attackGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.defenceGrade cannot be set twice.");
                  }
                  _loc26_++;
                  defenceGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.magicDefenceGrade cannot be set twice.");
                  }
                  _loc7_++;
                  magicDefenceGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.liveGrade cannot be set twice.");
                  }
                  _loc3_++;
                  liveGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.reduceResiGrade cannot be set twice.");
                  }
                  _loc8_++;
                  reduceResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.otherResiGrade cannot be set twice.");
                  }
                  _loc4_++;
                  otherResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: PetHallowInfoMsg.activeSkillTempId cannot be set twice.");
                  }
                  _loc18_++;
                  activeSkillTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

