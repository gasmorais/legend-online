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
   
   public final class JoinInfoMsg extends Message implements IExternalizable
   {
      
      private var attack$field:int;
      
      private var hasField$0:uint = 0;
      
      private var defence$field:int;
      
      private var magicAttack$field:int;
      
      private var magicDefence$field:int;
      
      private var hp$field:Int64;
      
      private var forceHit$field:int;
      
      private var parry$field:int;
      
      private var reduceResi$field:int;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var lightResi$field:int;
      
      private var penetrate$field:int;
      
      private var stunAttr$field:int;
      
      private var reduceResiAgainst$field:int;
      
      private var resiPenetrate$field:int;
      
      public function JoinInfoMsg()
      {
         super();
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967294;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 1;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeDefence() : void
      {
         hasField$0 &= 4294967293;
         defence$field = new int();
      }
      
      public function get hasDefence() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set defence(param1:int) : void
      {
         hasField$0 |= 2;
         defence$field = param1;
      }
      
      public function get defence() : int
      {
         return defence$field;
      }
      
      public function removeMagicAttack() : void
      {
         hasField$0 &= 4294967291;
         magicAttack$field = new int();
      }
      
      public function get hasMagicAttack() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set magicAttack(param1:int) : void
      {
         hasField$0 |= 4;
         magicAttack$field = param1;
      }
      
      public function get magicAttack() : int
      {
         return magicAttack$field;
      }
      
      public function removeMagicDefence() : void
      {
         hasField$0 &= 4294967287;
         magicDefence$field = new int();
      }
      
      public function get hasMagicDefence() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set magicDefence(param1:int) : void
      {
         hasField$0 |= 8;
         magicDefence$field = param1;
      }
      
      public function get magicDefence() : int
      {
         return magicDefence$field;
      }
      
      public function removeHp() : void
      {
         hp$field = null;
      }
      
      public function get hasHp() : Boolean
      {
         return hp$field != null;
      }
      
      public function set hp(param1:Int64) : void
      {
         hp$field = param1;
      }
      
      public function get hp() : Int64
      {
         return hp$field;
      }
      
      public function removeForceHit() : void
      {
         hasField$0 &= 4294967279;
         forceHit$field = new int();
      }
      
      public function get hasForceHit() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set forceHit(param1:int) : void
      {
         hasField$0 |= 16;
         forceHit$field = param1;
      }
      
      public function get forceHit() : int
      {
         return forceHit$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294967263;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 32;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removeReduceResi() : void
      {
         hasField$0 &= 4294967231;
         reduceResi$field = new int();
      }
      
      public function get hasReduceResi() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set reduceResi(param1:int) : void
      {
         hasField$0 |= 64;
         reduceResi$field = param1;
      }
      
      public function get reduceResi() : int
      {
         return reduceResi$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$0 &= 4294967167;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$0 |= 128;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$0 &= 4294967039;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$0 |= 256;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$0 &= 4294966783;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$0 |= 512;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$0 &= 4294966271;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$0 |= 1024;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$0 &= 4294965247;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$0 |= 2048;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$0 &= 4294963199;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$0 |= 4096;
         lightResi$field = param1;
      }
      
      public function get lightResi() : int
      {
         return lightResi$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4294959103;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 8192;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      public function removeStunAttr() : void
      {
         hasField$0 &= 4294950911;
         stunAttr$field = new int();
      }
      
      public function get hasStunAttr() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set stunAttr(param1:int) : void
      {
         hasField$0 |= 16384;
         stunAttr$field = param1;
      }
      
      public function get stunAttr() : int
      {
         return stunAttr$field;
      }
      
      public function removeReduceResiAgainst() : void
      {
         hasField$0 &= 4294934527;
         reduceResiAgainst$field = new int();
      }
      
      public function get hasReduceResiAgainst() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set reduceResiAgainst(param1:int) : void
      {
         hasField$0 |= 32768;
         reduceResiAgainst$field = param1;
      }
      
      public function get reduceResiAgainst() : int
      {
         return reduceResiAgainst$field;
      }
      
      public function removeResiPenetrate() : void
      {
         hasField$0 &= 4294901759;
         resiPenetrate$field = new int();
      }
      
      public function get hasResiPenetrate() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set resiPenetrate(param1:int) : void
      {
         hasField$0 |= 65536;
         resiPenetrate$field = param1;
      }
      
      public function get resiPenetrate() : int
      {
         return resiPenetrate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasDefence)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,defence$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,magicAttack$field);
         }
         if(hasMagicDefence)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,magicDefence$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,hp$field);
         }
         if(hasForceHit)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,forceHit$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasReduceResi)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,reduceResi$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasStunAttr)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,stunAttr$field);
         }
         if(hasReduceResiAgainst)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,reduceResiAgainst$field);
         }
         if(hasResiPenetrate)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,resiPenetrate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc14_:uint = 0;
         var _loc21_:uint = 0;
         var _loc15_:uint = 0;
         var _loc20_:uint = 0;
         var _loc16_:uint = 0;
         var _loc5_:uint = 0;
         var _loc17_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc18_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.attack cannot be set twice.");
                  }
                  _loc14_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.defence cannot be set twice.");
                  }
                  _loc21_++;
                  defence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.magicAttack cannot be set twice.");
                  }
                  _loc15_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.magicDefence cannot be set twice.");
                  }
                  _loc20_++;
                  magicDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.hp cannot be set twice.");
                  }
                  _loc16_++;
                  hp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.forceHit cannot be set twice.");
                  }
                  _loc5_++;
                  forceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.parry cannot be set twice.");
                  }
                  _loc17_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.reduceResi cannot be set twice.");
                  }
                  _loc10_++;
                  reduceResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.fireResi cannot be set twice.");
                  }
                  _loc6_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.waterResi cannot be set twice.");
                  }
                  _loc8_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.electResi cannot be set twice.");
                  }
                  _loc18_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.windResi cannot be set twice.");
                  }
                  _loc9_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.darkResi cannot be set twice.");
                  }
                  _loc3_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.lightResi cannot be set twice.");
                  }
                  _loc13_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.penetrate cannot be set twice.");
                  }
                  _loc7_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.stunAttr cannot be set twice.");
                  }
                  _loc11_++;
                  stunAttr = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.reduceResiAgainst cannot be set twice.");
                  }
                  _loc4_++;
                  reduceResiAgainst = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: JoinInfoMsg.resiPenetrate cannot be set twice.");
                  }
                  _loc12_++;
                  resiPenetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

