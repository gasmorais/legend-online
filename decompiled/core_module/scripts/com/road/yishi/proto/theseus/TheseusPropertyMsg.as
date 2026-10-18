package com.road.yishi.proto.theseus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusPropertyMsg extends Message implements IExternalizable
   {
      
      private var power$field:int;
      
      private var hasField$0:uint = 0;
      
      private var agility$field:int;
      
      private var intellect$field:int;
      
      private var captain$field:int;
      
      private var physique$field:int;
      
      private var attack$field:int;
      
      private var defence$field:int;
      
      private var magicAttack$field:int;
      
      private var magicDefence$field:int;
      
      private var forceHit$field:int;
      
      private var parry$field:int;
      
      private var live$field:int;
      
      private var conat$field:int;
      
      private var reduceResi$field:int;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var lightResi$field:int;
      
      private var strength$field:int;
      
      private var tenacity$field:int;
      
      private var penetrate$field:int;
      
      private var stunAttr$field:int;
      
      private var reduceResiAgainst$field:int;
      
      private var resiPenetrate$field:int;
      
      private var armour$field:int;
      
      public function TheseusPropertyMsg()
      {
         super();
      }
      
      public function removePower() : void
      {
         hasField$0 &= 4294967294;
         power$field = new int();
      }
      
      public function get hasPower() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set power(param1:int) : void
      {
         hasField$0 |= 1;
         power$field = param1;
      }
      
      public function get power() : int
      {
         return power$field;
      }
      
      public function removeAgility() : void
      {
         hasField$0 &= 4294967293;
         agility$field = new int();
      }
      
      public function get hasAgility() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set agility(param1:int) : void
      {
         hasField$0 |= 2;
         agility$field = param1;
      }
      
      public function get agility() : int
      {
         return agility$field;
      }
      
      public function removeIntellect() : void
      {
         hasField$0 &= 4294967291;
         intellect$field = new int();
      }
      
      public function get hasIntellect() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set intellect(param1:int) : void
      {
         hasField$0 |= 4;
         intellect$field = param1;
      }
      
      public function get intellect() : int
      {
         return intellect$field;
      }
      
      public function removeCaptain() : void
      {
         hasField$0 &= 4294967287;
         captain$field = new int();
      }
      
      public function get hasCaptain() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set captain(param1:int) : void
      {
         hasField$0 |= 8;
         captain$field = param1;
      }
      
      public function get captain() : int
      {
         return captain$field;
      }
      
      public function removePhysique() : void
      {
         hasField$0 &= 4294967279;
         physique$field = new int();
      }
      
      public function get hasPhysique() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set physique(param1:int) : void
      {
         hasField$0 |= 16;
         physique$field = param1;
      }
      
      public function get physique() : int
      {
         return physique$field;
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967263;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 32;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeDefence() : void
      {
         hasField$0 &= 4294967231;
         defence$field = new int();
      }
      
      public function get hasDefence() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set defence(param1:int) : void
      {
         hasField$0 |= 64;
         defence$field = param1;
      }
      
      public function get defence() : int
      {
         return defence$field;
      }
      
      public function removeMagicAttack() : void
      {
         hasField$0 &= 4294967167;
         magicAttack$field = new int();
      }
      
      public function get hasMagicAttack() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set magicAttack(param1:int) : void
      {
         hasField$0 |= 128;
         magicAttack$field = param1;
      }
      
      public function get magicAttack() : int
      {
         return magicAttack$field;
      }
      
      public function removeMagicDefence() : void
      {
         hasField$0 &= 4294967039;
         magicDefence$field = new int();
      }
      
      public function get hasMagicDefence() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set magicDefence(param1:int) : void
      {
         hasField$0 |= 256;
         magicDefence$field = param1;
      }
      
      public function get magicDefence() : int
      {
         return magicDefence$field;
      }
      
      public function removeForceHit() : void
      {
         hasField$0 &= 4294966783;
         forceHit$field = new int();
      }
      
      public function get hasForceHit() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set forceHit(param1:int) : void
      {
         hasField$0 |= 512;
         forceHit$field = param1;
      }
      
      public function get forceHit() : int
      {
         return forceHit$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294966271;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 1024;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removeLive() : void
      {
         hasField$0 &= 4294965247;
         live$field = new int();
      }
      
      public function get hasLive() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set live(param1:int) : void
      {
         hasField$0 |= 2048;
         live$field = param1;
      }
      
      public function get live() : int
      {
         return live$field;
      }
      
      public function removeConat() : void
      {
         hasField$0 &= 4294963199;
         conat$field = new int();
      }
      
      public function get hasConat() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set conat(param1:int) : void
      {
         hasField$0 |= 4096;
         conat$field = param1;
      }
      
      public function get conat() : int
      {
         return conat$field;
      }
      
      public function removeReduceResi() : void
      {
         hasField$0 &= 4294959103;
         reduceResi$field = new int();
      }
      
      public function get hasReduceResi() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set reduceResi(param1:int) : void
      {
         hasField$0 |= 8192;
         reduceResi$field = param1;
      }
      
      public function get reduceResi() : int
      {
         return reduceResi$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$0 &= 4294950911;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$0 |= 16384;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$0 &= 4294934527;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$0 |= 32768;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$0 &= 4294901759;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$0 |= 65536;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$0 &= 4294836223;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$0 |= 131072;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$0 &= 4294705151;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$0 |= 262144;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$0 &= 4294443007;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$0 |= 524288;
         lightResi$field = param1;
      }
      
      public function get lightResi() : int
      {
         return lightResi$field;
      }
      
      public function removeStrength() : void
      {
         hasField$0 &= 4293918719;
         strength$field = new int();
      }
      
      public function get hasStrength() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set strength(param1:int) : void
      {
         hasField$0 |= 1048576;
         strength$field = param1;
      }
      
      public function get strength() : int
      {
         return strength$field;
      }
      
      public function removeTenacity() : void
      {
         hasField$0 &= 4292870143;
         tenacity$field = new int();
      }
      
      public function get hasTenacity() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set tenacity(param1:int) : void
      {
         hasField$0 |= 2097152;
         tenacity$field = param1;
      }
      
      public function get tenacity() : int
      {
         return tenacity$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4290772991;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 4194304;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      public function removeStunAttr() : void
      {
         hasField$0 &= 4286578687;
         stunAttr$field = new int();
      }
      
      public function get hasStunAttr() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set stunAttr(param1:int) : void
      {
         hasField$0 |= 8388608;
         stunAttr$field = param1;
      }
      
      public function get stunAttr() : int
      {
         return stunAttr$field;
      }
      
      public function removeReduceResiAgainst() : void
      {
         hasField$0 &= 4278190079;
         reduceResiAgainst$field = new int();
      }
      
      public function get hasReduceResiAgainst() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set reduceResiAgainst(param1:int) : void
      {
         hasField$0 |= 16777216;
         reduceResiAgainst$field = param1;
      }
      
      public function get reduceResiAgainst() : int
      {
         return reduceResiAgainst$field;
      }
      
      public function removeResiPenetrate() : void
      {
         hasField$0 &= 4261412863;
         resiPenetrate$field = new int();
      }
      
      public function get hasResiPenetrate() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set resiPenetrate(param1:int) : void
      {
         hasField$0 |= 33554432;
         resiPenetrate$field = param1;
      }
      
      public function get resiPenetrate() : int
      {
         return resiPenetrate$field;
      }
      
      public function removeArmour() : void
      {
         hasField$0 &= 4227858431;
         armour$field = new int();
      }
      
      public function get hasArmour() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set armour(param1:int) : void
      {
         hasField$0 |= 67108864;
         armour$field = param1;
      }
      
      public function get armour() : int
      {
         return armour$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPower)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,power$field);
         }
         if(hasAgility)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,agility$field);
         }
         if(hasIntellect)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,intellect$field);
         }
         if(hasCaptain)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,captain$field);
         }
         if(hasPhysique)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,physique$field);
         }
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasDefence)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,defence$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,magicAttack$field);
         }
         if(hasMagicDefence)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,magicDefence$field);
         }
         if(hasForceHit)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,forceHit$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
         if(hasConat)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,conat$field);
         }
         if(hasReduceResi)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,reduceResi$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
         if(hasStrength)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,strength$field);
         }
         if(hasTenacity)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,tenacity$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasStunAttr)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,stunAttr$field);
         }
         if(hasReduceResiAgainst)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,reduceResiAgainst$field);
         }
         if(hasResiPenetrate)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,resiPenetrate$field);
         }
         if(hasArmour)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,armour$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc16_:uint = 0;
         var _loc6_:uint = 0;
         var _loc21_:uint = 0;
         var _loc28_:uint = 0;
         var _loc30_:uint = 0;
         var _loc12_:uint = 0;
         var _loc15_:uint = 0;
         var _loc19_:uint = 0;
         var _loc13_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc20_:uint = 0;
         var _loc23_:uint = 0;
         var _loc29_:uint = 0;
         var _loc24_:uint = 0;
         var _loc17_:uint = 0;
         var _loc9_:uint = 0;
         var _loc27_:uint = 0;
         var _loc22_:uint = 0;
         var _loc5_:uint = 0;
         var _loc25_:uint = 0;
         var _loc18_:uint = 0;
         var _loc26_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.power cannot be set twice.");
                  }
                  _loc10_++;
                  power = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.agility cannot be set twice.");
                  }
                  _loc11_++;
                  agility = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.intellect cannot be set twice.");
                  }
                  _loc16_++;
                  intellect = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.captain cannot be set twice.");
                  }
                  _loc6_++;
                  captain = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.physique cannot be set twice.");
                  }
                  _loc21_++;
                  physique = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.attack cannot be set twice.");
                  }
                  _loc28_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.defence cannot be set twice.");
                  }
                  _loc30_++;
                  defence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.magicAttack cannot be set twice.");
                  }
                  _loc12_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.magicDefence cannot be set twice.");
                  }
                  _loc15_++;
                  magicDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.forceHit cannot be set twice.");
                  }
                  _loc19_++;
                  forceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.parry cannot be set twice.");
                  }
                  _loc13_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.live cannot be set twice.");
                  }
                  _loc8_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.conat cannot be set twice.");
                  }
                  _loc4_++;
                  conat = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.reduceResi cannot be set twice.");
                  }
                  _loc7_++;
                  reduceResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.fireResi cannot be set twice.");
                  }
                  _loc20_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.waterResi cannot be set twice.");
                  }
                  _loc23_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.electResi cannot be set twice.");
                  }
                  _loc29_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.windResi cannot be set twice.");
                  }
                  _loc24_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.darkResi cannot be set twice.");
                  }
                  _loc17_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.lightResi cannot be set twice.");
                  }
                  _loc9_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.strength cannot be set twice.");
                  }
                  _loc27_++;
                  strength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.tenacity cannot be set twice.");
                  }
                  _loc22_++;
                  tenacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.penetrate cannot be set twice.");
                  }
                  _loc5_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.stunAttr cannot be set twice.");
                  }
                  _loc25_++;
                  stunAttr = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.reduceResiAgainst cannot be set twice.");
                  }
                  _loc18_++;
                  reduceResiAgainst = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.resiPenetrate cannot be set twice.");
                  }
                  _loc26_++;
                  resiPenetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPropertyMsg.armour cannot be set twice.");
                  }
                  _loc3_++;
                  armour = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

