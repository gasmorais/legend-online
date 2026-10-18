package com.road.yishi.proto.avenger
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AvengerSkillMsg extends Message implements IExternalizable
   {
      
      private var skillId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skillSonType$field:int;
      
      private var attack$field:int;
      
      private var magicAttack$field:int;
      
      private var defence$field:int;
      
      private var magicDefence$field:int;
      
      private var live$field:int;
      
      private var forcehit$field:int;
      
      private var parry$field:int;
      
      private var penetrate$field:int;
      
      private var reduceResi$field:int;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var lightResi$field:int;
      
      private var isUse$field:Boolean;
      
      private var itemInfo$field:String;
      
      public function AvengerSkillMsg()
      {
         super();
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967294;
         skillId$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 1;
         skillId$field = param1;
      }
      
      public function get skillId() : int
      {
         return skillId$field;
      }
      
      public function removeSkillSonType() : void
      {
         hasField$0 &= 4294967293;
         skillSonType$field = new int();
      }
      
      public function get hasSkillSonType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set skillSonType(param1:int) : void
      {
         hasField$0 |= 2;
         skillSonType$field = param1;
      }
      
      public function get skillSonType() : int
      {
         return skillSonType$field;
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967291;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 4;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeMagicAttack() : void
      {
         hasField$0 &= 4294967287;
         magicAttack$field = new int();
      }
      
      public function get hasMagicAttack() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set magicAttack(param1:int) : void
      {
         hasField$0 |= 8;
         magicAttack$field = param1;
      }
      
      public function get magicAttack() : int
      {
         return magicAttack$field;
      }
      
      public function removeDefence() : void
      {
         hasField$0 &= 4294967279;
         defence$field = new int();
      }
      
      public function get hasDefence() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set defence(param1:int) : void
      {
         hasField$0 |= 16;
         defence$field = param1;
      }
      
      public function get defence() : int
      {
         return defence$field;
      }
      
      public function removeMagicDefence() : void
      {
         hasField$0 &= 4294967263;
         magicDefence$field = new int();
      }
      
      public function get hasMagicDefence() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set magicDefence(param1:int) : void
      {
         hasField$0 |= 32;
         magicDefence$field = param1;
      }
      
      public function get magicDefence() : int
      {
         return magicDefence$field;
      }
      
      public function removeLive() : void
      {
         hasField$0 &= 4294967231;
         live$field = new int();
      }
      
      public function get hasLive() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set live(param1:int) : void
      {
         hasField$0 |= 64;
         live$field = param1;
      }
      
      public function get live() : int
      {
         return live$field;
      }
      
      public function removeForcehit() : void
      {
         hasField$0 &= 4294967167;
         forcehit$field = new int();
      }
      
      public function get hasForcehit() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set forcehit(param1:int) : void
      {
         hasField$0 |= 128;
         forcehit$field = param1;
      }
      
      public function get forcehit() : int
      {
         return forcehit$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294967039;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 256;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4294966783;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 512;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      public function removeReduceResi() : void
      {
         hasField$0 &= 4294966271;
         reduceResi$field = new int();
      }
      
      public function get hasReduceResi() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set reduceResi(param1:int) : void
      {
         hasField$0 |= 1024;
         reduceResi$field = param1;
      }
      
      public function get reduceResi() : int
      {
         return reduceResi$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$0 &= 4294965247;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$0 |= 2048;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$0 &= 4294963199;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$0 |= 4096;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$0 &= 4294959103;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$0 |= 8192;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$0 &= 4294950911;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$0 |= 16384;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$0 &= 4294934527;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$0 |= 32768;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$0 &= 4294901759;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$0 |= 65536;
         lightResi$field = param1;
      }
      
      public function get lightResi() : int
      {
         return lightResi$field;
      }
      
      public function removeIsUse() : void
      {
         hasField$0 &= 4294836223;
         isUse$field = new Boolean();
      }
      
      public function get hasIsUse() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set isUse(param1:Boolean) : void
      {
         hasField$0 |= 131072;
         isUse$field = param1;
      }
      
      public function get isUse() : Boolean
      {
         return isUse$field;
      }
      
      public function removeItemInfo() : void
      {
         itemInfo$field = null;
      }
      
      public function get hasItemInfo() : Boolean
      {
         return itemInfo$field != null;
      }
      
      public function set itemInfo(param1:String) : void
      {
         itemInfo$field = param1;
      }
      
      public function get itemInfo() : String
      {
         return itemInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skillId$field);
         }
         if(hasSkillSonType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,skillSonType$field);
         }
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,magicAttack$field);
         }
         if(hasDefence)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,defence$field);
         }
         if(hasMagicDefence)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,magicDefence$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
         if(hasForcehit)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,forcehit$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasReduceResi)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,reduceResi$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
         if(hasIsUse)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_BOOL(param1,isUse$field);
         }
         if(hasItemInfo)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,itemInfo$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc22_:uint = 0;
         var _loc20_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc17_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc18_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc21_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.skillId cannot be set twice.");
                  }
                  _loc5_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.skillSonType cannot be set twice.");
                  }
                  _loc4_++;
                  skillSonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.attack cannot be set twice.");
                  }
                  _loc15_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.magicAttack cannot be set twice.");
                  }
                  _loc16_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.defence cannot be set twice.");
                  }
                  _loc22_++;
                  defence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.magicDefence cannot be set twice.");
                  }
                  _loc20_++;
                  magicDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.live cannot be set twice.");
                  }
                  _loc12_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.forcehit cannot be set twice.");
                  }
                  _loc13_++;
                  forcehit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.parry cannot be set twice.");
                  }
                  _loc17_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.penetrate cannot be set twice.");
                  }
                  _loc7_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.reduceResi cannot be set twice.");
                  }
                  _loc11_++;
                  reduceResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.fireResi cannot be set twice.");
                  }
                  _loc6_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.waterResi cannot be set twice.");
                  }
                  _loc9_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.electResi cannot be set twice.");
                  }
                  _loc18_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.windResi cannot be set twice.");
                  }
                  _loc10_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.darkResi cannot be set twice.");
                  }
                  _loc3_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.lightResi cannot be set twice.");
                  }
                  _loc14_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.isUse cannot be set twice.");
                  }
                  _loc21_++;
                  isUse = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerSkillMsg.itemInfo cannot be set twice.");
                  }
                  _loc8_++;
                  itemInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

