package com.road.yishi.proto.fashion
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FashionInfoMsg extends Message implements IExternalizable
   {
      
      private var gp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grades$field:int;
      
      private var wingAvata$field:int;
      
      private var hatAvata$field:int;
      
      private var armAvata$field:int;
      
      private var clothAvata$field:int;
      
      private var isHidenWingAvata$field:Boolean;
      
      private var isHidenHatAvat$field:Boolean;
      
      private var isHidenArmAvata$field:Boolean;
      
      private var isHidenClothAvata$field:Boolean;
      
      private var dragonWingAvata$field:int;
      
      private var dragonHatAvata$field:int;
      
      private var dragonArmAvata$field:int;
      
      private var dragonClothAvata$field:int;
      
      private var isHidendDragonWingAvata$field:Boolean;
      
      private var isHidenDragonHatAvat$field:Boolean;
      
      private var isHidenDragonArmAvata$field:Boolean;
      
      private var isHidenDragonClothAvata$field:Boolean;
      
      private var defaultFashion$field:int;
      
      public function FashionInfoMsg()
      {
         super();
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967294;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 1;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967293;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 2;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeWingAvata() : void
      {
         hasField$0 &= 4294967291;
         wingAvata$field = new int();
      }
      
      public function get hasWingAvata() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set wingAvata(param1:int) : void
      {
         hasField$0 |= 4;
         wingAvata$field = param1;
      }
      
      public function get wingAvata() : int
      {
         return wingAvata$field;
      }
      
      public function removeHatAvata() : void
      {
         hasField$0 &= 4294967287;
         hatAvata$field = new int();
      }
      
      public function get hasHatAvata() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set hatAvata(param1:int) : void
      {
         hasField$0 |= 8;
         hatAvata$field = param1;
      }
      
      public function get hatAvata() : int
      {
         return hatAvata$field;
      }
      
      public function removeArmAvata() : void
      {
         hasField$0 &= 4294967279;
         armAvata$field = new int();
      }
      
      public function get hasArmAvata() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set armAvata(param1:int) : void
      {
         hasField$0 |= 16;
         armAvata$field = param1;
      }
      
      public function get armAvata() : int
      {
         return armAvata$field;
      }
      
      public function removeClothAvata() : void
      {
         hasField$0 &= 4294967263;
         clothAvata$field = new int();
      }
      
      public function get hasClothAvata() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set clothAvata(param1:int) : void
      {
         hasField$0 |= 32;
         clothAvata$field = param1;
      }
      
      public function get clothAvata() : int
      {
         return clothAvata$field;
      }
      
      public function removeIsHidenWingAvata() : void
      {
         hasField$0 &= 4294967231;
         isHidenWingAvata$field = new Boolean();
      }
      
      public function get hasIsHidenWingAvata() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isHidenWingAvata(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isHidenWingAvata$field = param1;
      }
      
      public function get isHidenWingAvata() : Boolean
      {
         return isHidenWingAvata$field;
      }
      
      public function removeIsHidenHatAvat() : void
      {
         hasField$0 &= 4294967167;
         isHidenHatAvat$field = new Boolean();
      }
      
      public function get hasIsHidenHatAvat() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isHidenHatAvat(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isHidenHatAvat$field = param1;
      }
      
      public function get isHidenHatAvat() : Boolean
      {
         return isHidenHatAvat$field;
      }
      
      public function removeIsHidenArmAvata() : void
      {
         hasField$0 &= 4294967039;
         isHidenArmAvata$field = new Boolean();
      }
      
      public function get hasIsHidenArmAvata() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isHidenArmAvata(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isHidenArmAvata$field = param1;
      }
      
      public function get isHidenArmAvata() : Boolean
      {
         return isHidenArmAvata$field;
      }
      
      public function removeIsHidenClothAvata() : void
      {
         hasField$0 &= 4294966783;
         isHidenClothAvata$field = new Boolean();
      }
      
      public function get hasIsHidenClothAvata() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isHidenClothAvata(param1:Boolean) : void
      {
         hasField$0 |= 512;
         isHidenClothAvata$field = param1;
      }
      
      public function get isHidenClothAvata() : Boolean
      {
         return isHidenClothAvata$field;
      }
      
      public function removeDragonWingAvata() : void
      {
         hasField$0 &= 4294966271;
         dragonWingAvata$field = new int();
      }
      
      public function get hasDragonWingAvata() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set dragonWingAvata(param1:int) : void
      {
         hasField$0 |= 1024;
         dragonWingAvata$field = param1;
      }
      
      public function get dragonWingAvata() : int
      {
         return dragonWingAvata$field;
      }
      
      public function removeDragonHatAvata() : void
      {
         hasField$0 &= 4294965247;
         dragonHatAvata$field = new int();
      }
      
      public function get hasDragonHatAvata() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set dragonHatAvata(param1:int) : void
      {
         hasField$0 |= 2048;
         dragonHatAvata$field = param1;
      }
      
      public function get dragonHatAvata() : int
      {
         return dragonHatAvata$field;
      }
      
      public function removeDragonArmAvata() : void
      {
         hasField$0 &= 4294963199;
         dragonArmAvata$field = new int();
      }
      
      public function get hasDragonArmAvata() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set dragonArmAvata(param1:int) : void
      {
         hasField$0 |= 4096;
         dragonArmAvata$field = param1;
      }
      
      public function get dragonArmAvata() : int
      {
         return dragonArmAvata$field;
      }
      
      public function removeDragonClothAvata() : void
      {
         hasField$0 &= 4294959103;
         dragonClothAvata$field = new int();
      }
      
      public function get hasDragonClothAvata() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set dragonClothAvata(param1:int) : void
      {
         hasField$0 |= 8192;
         dragonClothAvata$field = param1;
      }
      
      public function get dragonClothAvata() : int
      {
         return dragonClothAvata$field;
      }
      
      public function removeIsHidendDragonWingAvata() : void
      {
         hasField$0 &= 4294950911;
         isHidendDragonWingAvata$field = new Boolean();
      }
      
      public function get hasIsHidendDragonWingAvata() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set isHidendDragonWingAvata(param1:Boolean) : void
      {
         hasField$0 |= 16384;
         isHidendDragonWingAvata$field = param1;
      }
      
      public function get isHidendDragonWingAvata() : Boolean
      {
         return isHidendDragonWingAvata$field;
      }
      
      public function removeIsHidenDragonHatAvat() : void
      {
         hasField$0 &= 4294934527;
         isHidenDragonHatAvat$field = new Boolean();
      }
      
      public function get hasIsHidenDragonHatAvat() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set isHidenDragonHatAvat(param1:Boolean) : void
      {
         hasField$0 |= 32768;
         isHidenDragonHatAvat$field = param1;
      }
      
      public function get isHidenDragonHatAvat() : Boolean
      {
         return isHidenDragonHatAvat$field;
      }
      
      public function removeIsHidenDragonArmAvata() : void
      {
         hasField$0 &= 4294901759;
         isHidenDragonArmAvata$field = new Boolean();
      }
      
      public function get hasIsHidenDragonArmAvata() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set isHidenDragonArmAvata(param1:Boolean) : void
      {
         hasField$0 |= 65536;
         isHidenDragonArmAvata$field = param1;
      }
      
      public function get isHidenDragonArmAvata() : Boolean
      {
         return isHidenDragonArmAvata$field;
      }
      
      public function removeIsHidenDragonClothAvata() : void
      {
         hasField$0 &= 4294836223;
         isHidenDragonClothAvata$field = new Boolean();
      }
      
      public function get hasIsHidenDragonClothAvata() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set isHidenDragonClothAvata(param1:Boolean) : void
      {
         hasField$0 |= 131072;
         isHidenDragonClothAvata$field = param1;
      }
      
      public function get isHidenDragonClothAvata() : Boolean
      {
         return isHidenDragonClothAvata$field;
      }
      
      public function removeDefaultFashion() : void
      {
         hasField$0 &= 4294705151;
         defaultFashion$field = new int();
      }
      
      public function get hasDefaultFashion() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set defaultFashion(param1:int) : void
      {
         hasField$0 |= 262144;
         defaultFashion$field = param1;
      }
      
      public function get defaultFashion() : int
      {
         return defaultFashion$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasWingAvata)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,wingAvata$field);
         }
         if(hasHatAvata)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,hatAvata$field);
         }
         if(hasArmAvata)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,armAvata$field);
         }
         if(hasClothAvata)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,clothAvata$field);
         }
         if(hasIsHidenWingAvata)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isHidenWingAvata$field);
         }
         if(hasIsHidenHatAvat)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isHidenHatAvat$field);
         }
         if(hasIsHidenArmAvata)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isHidenArmAvata$field);
         }
         if(hasIsHidenClothAvata)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,isHidenClothAvata$field);
         }
         if(hasDragonWingAvata)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,dragonWingAvata$field);
         }
         if(hasDragonHatAvata)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,dragonHatAvata$field);
         }
         if(hasDragonArmAvata)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,dragonArmAvata$field);
         }
         if(hasDragonClothAvata)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,dragonClothAvata$field);
         }
         if(hasIsHidendDragonWingAvata)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,isHidendDragonWingAvata$field);
         }
         if(hasIsHidenDragonHatAvat)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,isHidenDragonHatAvat$field);
         }
         if(hasIsHidenDragonArmAvata)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,isHidenDragonArmAvata$field);
         }
         if(hasIsHidenDragonClothAvata)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_BOOL(param1,isHidenDragonClothAvata$field);
         }
         if(hasDefaultFashion)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,defaultFashion$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc20_:uint = 0;
         var _loc22_:uint = 0;
         var _loc8_:uint = 0;
         var _loc18_:uint = 0;
         var _loc15_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc21_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc5_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.gp cannot be set twice.");
                  }
                  _loc20_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.grades cannot be set twice.");
                  }
                  _loc22_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.wingAvata cannot be set twice.");
                  }
                  _loc8_++;
                  wingAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.hatAvata cannot be set twice.");
                  }
                  _loc18_++;
                  hatAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.armAvata cannot be set twice.");
                  }
                  _loc15_++;
                  armAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.clothAvata cannot be set twice.");
                  }
                  _loc7_++;
                  clothAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.isHidenWingAvata cannot be set twice.");
                  }
                  _loc13_++;
                  isHidenWingAvata = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.isHidenHatAvat cannot be set twice.");
                  }
                  _loc3_++;
                  isHidenHatAvat = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.isHidenArmAvata cannot be set twice.");
                  }
                  _loc9_++;
                  isHidenArmAvata = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.isHidenClothAvata cannot be set twice.");
                  }
                  _loc21_++;
                  isHidenClothAvata = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.dragonWingAvata cannot be set twice.");
                  }
                  _loc12_++;
                  dragonWingAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.dragonHatAvata cannot be set twice.");
                  }
                  _loc10_++;
                  dragonHatAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.dragonArmAvata cannot be set twice.");
                  }
                  _loc6_++;
                  dragonArmAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.dragonClothAvata cannot be set twice.");
                  }
                  _loc4_++;
                  dragonClothAvata = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.isHidendDragonWingAvata cannot be set twice.");
                  }
                  _loc11_++;
                  isHidendDragonWingAvata = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.isHidenDragonHatAvat cannot be set twice.");
                  }
                  _loc14_++;
                  isHidenDragonHatAvat = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 16:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.isHidenDragonArmAvata cannot be set twice.");
                  }
                  _loc5_++;
                  isHidenDragonArmAvata = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.isHidenDragonClothAvata cannot be set twice.");
                  }
                  _loc16_++;
                  isHidenDragonClothAvata = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: FashionInfoMsg.defaultFashion cannot be set twice.");
                  }
                  _loc17_++;
                  defaultFashion = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

