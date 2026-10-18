package com.road.yishi.proto.children
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FightPetMsg extends Message implements IExternalizable
   {
      
      private var pet_phy_attack$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pet_phy_defence$field:int;
      
      private var pet_mag_attack$field:int;
      
      private var pet_mag_defence$field:int;
      
      private var pet_hp$field:Int64;
      
      private var pet_fireResi$field:int;
      
      private var pet_waterResi$field:int;
      
      private var pet_electResi$field:int;
      
      private var pet_windResi$field:int;
      
      private var pet_darkResi$field:int;
      
      private var pet_lightResi$field:int;
      
      public function FightPetMsg()
      {
         super();
      }
      
      public function removePetPhyAttack() : void
      {
         hasField$0 &= 4294967294;
         pet_phy_attack$field = new int();
      }
      
      public function get hasPetPhyAttack() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set petPhyAttack(param1:int) : void
      {
         hasField$0 |= 1;
         pet_phy_attack$field = param1;
      }
      
      public function get petPhyAttack() : int
      {
         return pet_phy_attack$field;
      }
      
      public function removePetPhyDefence() : void
      {
         hasField$0 &= 4294967293;
         pet_phy_defence$field = new int();
      }
      
      public function get hasPetPhyDefence() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set petPhyDefence(param1:int) : void
      {
         hasField$0 |= 2;
         pet_phy_defence$field = param1;
      }
      
      public function get petPhyDefence() : int
      {
         return pet_phy_defence$field;
      }
      
      public function removePetMagAttack() : void
      {
         hasField$0 &= 4294967291;
         pet_mag_attack$field = new int();
      }
      
      public function get hasPetMagAttack() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set petMagAttack(param1:int) : void
      {
         hasField$0 |= 4;
         pet_mag_attack$field = param1;
      }
      
      public function get petMagAttack() : int
      {
         return pet_mag_attack$field;
      }
      
      public function removePetMagDefence() : void
      {
         hasField$0 &= 4294967287;
         pet_mag_defence$field = new int();
      }
      
      public function get hasPetMagDefence() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set petMagDefence(param1:int) : void
      {
         hasField$0 |= 8;
         pet_mag_defence$field = param1;
      }
      
      public function get petMagDefence() : int
      {
         return pet_mag_defence$field;
      }
      
      public function removePetHp() : void
      {
         pet_hp$field = null;
      }
      
      public function get hasPetHp() : Boolean
      {
         return pet_hp$field != null;
      }
      
      public function set petHp(param1:Int64) : void
      {
         pet_hp$field = param1;
      }
      
      public function get petHp() : Int64
      {
         return pet_hp$field;
      }
      
      public function removePetFireResi() : void
      {
         hasField$0 &= 4294967279;
         pet_fireResi$field = new int();
      }
      
      public function get hasPetFireResi() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set petFireResi(param1:int) : void
      {
         hasField$0 |= 16;
         pet_fireResi$field = param1;
      }
      
      public function get petFireResi() : int
      {
         return pet_fireResi$field;
      }
      
      public function removePetWaterResi() : void
      {
         hasField$0 &= 4294967263;
         pet_waterResi$field = new int();
      }
      
      public function get hasPetWaterResi() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set petWaterResi(param1:int) : void
      {
         hasField$0 |= 32;
         pet_waterResi$field = param1;
      }
      
      public function get petWaterResi() : int
      {
         return pet_waterResi$field;
      }
      
      public function removePetElectResi() : void
      {
         hasField$0 &= 4294967231;
         pet_electResi$field = new int();
      }
      
      public function get hasPetElectResi() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set petElectResi(param1:int) : void
      {
         hasField$0 |= 64;
         pet_electResi$field = param1;
      }
      
      public function get petElectResi() : int
      {
         return pet_electResi$field;
      }
      
      public function removePetWindResi() : void
      {
         hasField$0 &= 4294967167;
         pet_windResi$field = new int();
      }
      
      public function get hasPetWindResi() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set petWindResi(param1:int) : void
      {
         hasField$0 |= 128;
         pet_windResi$field = param1;
      }
      
      public function get petWindResi() : int
      {
         return pet_windResi$field;
      }
      
      public function removePetDarkResi() : void
      {
         hasField$0 &= 4294967039;
         pet_darkResi$field = new int();
      }
      
      public function get hasPetDarkResi() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set petDarkResi(param1:int) : void
      {
         hasField$0 |= 256;
         pet_darkResi$field = param1;
      }
      
      public function get petDarkResi() : int
      {
         return pet_darkResi$field;
      }
      
      public function removePetLightResi() : void
      {
         hasField$0 &= 4294966783;
         pet_lightResi$field = new int();
      }
      
      public function get hasPetLightResi() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set petLightResi(param1:int) : void
      {
         hasField$0 |= 512;
         pet_lightResi$field = param1;
      }
      
      public function get petLightResi() : int
      {
         return pet_lightResi$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPetPhyAttack)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pet_phy_attack$field);
         }
         if(hasPetPhyDefence)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pet_phy_defence$field);
         }
         if(hasPetMagAttack)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pet_mag_attack$field);
         }
         if(hasPetMagDefence)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pet_mag_defence$field);
         }
         if(hasPetHp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,pet_hp$field);
         }
         if(hasPetFireResi)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,pet_fireResi$field);
         }
         if(hasPetWaterResi)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pet_waterResi$field);
         }
         if(hasPetElectResi)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,pet_electResi$field);
         }
         if(hasPetWindResi)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,pet_windResi$field);
         }
         if(hasPetDarkResi)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,pet_darkResi$field);
         }
         if(hasPetLightResi)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,pet_lightResi$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petPhyAttack cannot be set twice.");
                  }
                  _loc7_++;
                  petPhyAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petPhyDefence cannot be set twice.");
                  }
                  _loc6_++;
                  petPhyDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petMagAttack cannot be set twice.");
                  }
                  _loc8_++;
                  petMagAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petMagDefence cannot be set twice.");
                  }
                  _loc3_++;
                  petMagDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petHp cannot be set twice.");
                  }
                  _loc12_++;
                  petHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petFireResi cannot be set twice.");
                  }
                  _loc11_++;
                  petFireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petWaterResi cannot be set twice.");
                  }
                  _loc9_++;
                  petWaterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petElectResi cannot be set twice.");
                  }
                  _loc5_++;
                  petElectResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petWindResi cannot be set twice.");
                  }
                  _loc10_++;
                  petWindResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petDarkResi cannot be set twice.");
                  }
                  _loc4_++;
                  petDarkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FightPetMsg.petLightResi cannot be set twice.");
                  }
                  _loc13_++;
                  petLightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

