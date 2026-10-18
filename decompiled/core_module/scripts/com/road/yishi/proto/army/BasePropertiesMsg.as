package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BasePropertiesMsg extends Message implements IExternalizable
   {
      
      private var power$field:int;
      
      private var hasField$0:uint = 0;
      
      private var agility$field:int;
      
      private var intel$field:int;
      
      private var physi$field:int;
      
      private var captain$field:int;
      
      private var attack$field:int;
      
      private var defence$field:int;
      
      private var magicattack$field:int;
      
      private var magicdefence$field:int;
      
      private var live$field:int;
      
      private var conat$field:int;
      
      private var forcehit$field:int;
      
      private var parry$field:int;
      
      public function BasePropertiesMsg()
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
      
      public function removeIntel() : void
      {
         hasField$0 &= 4294967291;
         intel$field = new int();
      }
      
      public function get hasIntel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set intel(param1:int) : void
      {
         hasField$0 |= 4;
         intel$field = param1;
      }
      
      public function get intel() : int
      {
         return intel$field;
      }
      
      public function removePhysi() : void
      {
         hasField$0 &= 4294967287;
         physi$field = new int();
      }
      
      public function get hasPhysi() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set physi(param1:int) : void
      {
         hasField$0 |= 8;
         physi$field = param1;
      }
      
      public function get physi() : int
      {
         return physi$field;
      }
      
      public function removeCaptain() : void
      {
         hasField$0 &= 4294967279;
         captain$field = new int();
      }
      
      public function get hasCaptain() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set captain(param1:int) : void
      {
         hasField$0 |= 16;
         captain$field = param1;
      }
      
      public function get captain() : int
      {
         return captain$field;
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
      
      public function removeMagicattack() : void
      {
         hasField$0 &= 4294967167;
         magicattack$field = new int();
      }
      
      public function get hasMagicattack() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set magicattack(param1:int) : void
      {
         hasField$0 |= 128;
         magicattack$field = param1;
      }
      
      public function get magicattack() : int
      {
         return magicattack$field;
      }
      
      public function removeMagicdefence() : void
      {
         hasField$0 &= 4294967039;
         magicdefence$field = new int();
      }
      
      public function get hasMagicdefence() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set magicdefence(param1:int) : void
      {
         hasField$0 |= 256;
         magicdefence$field = param1;
      }
      
      public function get magicdefence() : int
      {
         return magicdefence$field;
      }
      
      public function removeLive() : void
      {
         hasField$0 &= 4294966783;
         live$field = new int();
      }
      
      public function get hasLive() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set live(param1:int) : void
      {
         hasField$0 |= 512;
         live$field = param1;
      }
      
      public function get live() : int
      {
         return live$field;
      }
      
      public function removeConat() : void
      {
         hasField$0 &= 4294966271;
         conat$field = new int();
      }
      
      public function get hasConat() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set conat(param1:int) : void
      {
         hasField$0 |= 1024;
         conat$field = param1;
      }
      
      public function get conat() : int
      {
         return conat$field;
      }
      
      public function removeForcehit() : void
      {
         hasField$0 &= 4294965247;
         forcehit$field = new int();
      }
      
      public function get hasForcehit() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set forcehit(param1:int) : void
      {
         hasField$0 |= 2048;
         forcehit$field = param1;
      }
      
      public function get forcehit() : int
      {
         return forcehit$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294963199;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 4096;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
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
         if(hasIntel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,intel$field);
         }
         if(hasPhysi)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,physi$field);
         }
         if(hasCaptain)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,captain$field);
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
         if(hasMagicattack)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,magicattack$field);
         }
         if(hasMagicdefence)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,magicdefence$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
         if(hasConat)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,conat$field);
         }
         if(hasForcehit)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,forcehit$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc6_:uint = 0;
         var _loc15_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.power cannot be set twice.");
                  }
                  _loc10_++;
                  power = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.agility cannot be set twice.");
                  }
                  _loc11_++;
                  agility = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.intel cannot be set twice.");
                  }
                  _loc4_++;
                  intel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.physi cannot be set twice.");
                  }
                  _loc3_++;
                  physi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.captain cannot be set twice.");
                  }
                  _loc7_++;
                  captain = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.attack cannot be set twice.");
                  }
                  _loc12_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.defence cannot be set twice.");
                  }
                  _loc16_++;
                  defence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.magicattack cannot be set twice.");
                  }
                  _loc6_++;
                  magicattack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.magicdefence cannot be set twice.");
                  }
                  _loc15_++;
                  magicdefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.live cannot be set twice.");
                  }
                  _loc8_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.conat cannot be set twice.");
                  }
                  _loc5_++;
                  conat = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.forcehit cannot be set twice.");
                  }
                  _loc9_++;
                  forcehit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: BasePropertiesMsg.parry cannot be set twice.");
                  }
                  _loc13_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

