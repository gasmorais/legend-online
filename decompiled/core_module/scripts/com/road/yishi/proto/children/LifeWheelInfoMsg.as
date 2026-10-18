package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LifeWheelInfoMsg extends Message implements IExternalizable
   {
      
      private var grade$field:int;
      
      private var hasField$0:uint = 0;
      
      private var reduceResiGrade$field:int;
      
      private var reduceResiGp$field:int;
      
      private var fireResiGrade$field:int;
      
      private var fireResiGp$field:int;
      
      private var waterResiGrade$field:int;
      
      private var waterResiGp$field:int;
      
      private var elcResiGrade$field:int;
      
      private var elcResiGp$field:int;
      
      private var windResiGrade$field:int;
      
      private var windResiGp$field:int;
      
      private var darkResiGrade$field:int;
      
      private var darkResiGp$field:int;
      
      private var lightResiGrade$field:int;
      
      private var lightResiGp$field:int;
      
      private var skillId$field:int;
      
      public function LifeWheelInfoMsg()
      {
         super();
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967294;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 1;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeReduceResiGrade() : void
      {
         hasField$0 &= 4294967293;
         reduceResiGrade$field = new int();
      }
      
      public function get hasReduceResiGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set reduceResiGrade(param1:int) : void
      {
         hasField$0 |= 2;
         reduceResiGrade$field = param1;
      }
      
      public function get reduceResiGrade() : int
      {
         return reduceResiGrade$field;
      }
      
      public function removeReduceResiGp() : void
      {
         hasField$0 &= 4294967291;
         reduceResiGp$field = new int();
      }
      
      public function get hasReduceResiGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set reduceResiGp(param1:int) : void
      {
         hasField$0 |= 4;
         reduceResiGp$field = param1;
      }
      
      public function get reduceResiGp() : int
      {
         return reduceResiGp$field;
      }
      
      public function removeFireResiGrade() : void
      {
         hasField$0 &= 4294967287;
         fireResiGrade$field = new int();
      }
      
      public function get hasFireResiGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fireResiGrade(param1:int) : void
      {
         hasField$0 |= 8;
         fireResiGrade$field = param1;
      }
      
      public function get fireResiGrade() : int
      {
         return fireResiGrade$field;
      }
      
      public function removeFireResiGp() : void
      {
         hasField$0 &= 4294967279;
         fireResiGp$field = new int();
      }
      
      public function get hasFireResiGp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fireResiGp(param1:int) : void
      {
         hasField$0 |= 16;
         fireResiGp$field = param1;
      }
      
      public function get fireResiGp() : int
      {
         return fireResiGp$field;
      }
      
      public function removeWaterResiGrade() : void
      {
         hasField$0 &= 4294967263;
         waterResiGrade$field = new int();
      }
      
      public function get hasWaterResiGrade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set waterResiGrade(param1:int) : void
      {
         hasField$0 |= 32;
         waterResiGrade$field = param1;
      }
      
      public function get waterResiGrade() : int
      {
         return waterResiGrade$field;
      }
      
      public function removeWaterResiGp() : void
      {
         hasField$0 &= 4294967231;
         waterResiGp$field = new int();
      }
      
      public function get hasWaterResiGp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set waterResiGp(param1:int) : void
      {
         hasField$0 |= 64;
         waterResiGp$field = param1;
      }
      
      public function get waterResiGp() : int
      {
         return waterResiGp$field;
      }
      
      public function removeElcResiGrade() : void
      {
         hasField$0 &= 4294967167;
         elcResiGrade$field = new int();
      }
      
      public function get hasElcResiGrade() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set elcResiGrade(param1:int) : void
      {
         hasField$0 |= 128;
         elcResiGrade$field = param1;
      }
      
      public function get elcResiGrade() : int
      {
         return elcResiGrade$field;
      }
      
      public function removeElcResiGp() : void
      {
         hasField$0 &= 4294967039;
         elcResiGp$field = new int();
      }
      
      public function get hasElcResiGp() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set elcResiGp(param1:int) : void
      {
         hasField$0 |= 256;
         elcResiGp$field = param1;
      }
      
      public function get elcResiGp() : int
      {
         return elcResiGp$field;
      }
      
      public function removeWindResiGrade() : void
      {
         hasField$0 &= 4294966783;
         windResiGrade$field = new int();
      }
      
      public function get hasWindResiGrade() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set windResiGrade(param1:int) : void
      {
         hasField$0 |= 512;
         windResiGrade$field = param1;
      }
      
      public function get windResiGrade() : int
      {
         return windResiGrade$field;
      }
      
      public function removeWindResiGp() : void
      {
         hasField$0 &= 4294966271;
         windResiGp$field = new int();
      }
      
      public function get hasWindResiGp() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set windResiGp(param1:int) : void
      {
         hasField$0 |= 1024;
         windResiGp$field = param1;
      }
      
      public function get windResiGp() : int
      {
         return windResiGp$field;
      }
      
      public function removeDarkResiGrade() : void
      {
         hasField$0 &= 4294965247;
         darkResiGrade$field = new int();
      }
      
      public function get hasDarkResiGrade() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set darkResiGrade(param1:int) : void
      {
         hasField$0 |= 2048;
         darkResiGrade$field = param1;
      }
      
      public function get darkResiGrade() : int
      {
         return darkResiGrade$field;
      }
      
      public function removeDarkResiGp() : void
      {
         hasField$0 &= 4294963199;
         darkResiGp$field = new int();
      }
      
      public function get hasDarkResiGp() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set darkResiGp(param1:int) : void
      {
         hasField$0 |= 4096;
         darkResiGp$field = param1;
      }
      
      public function get darkResiGp() : int
      {
         return darkResiGp$field;
      }
      
      public function removeLightResiGrade() : void
      {
         hasField$0 &= 4294959103;
         lightResiGrade$field = new int();
      }
      
      public function get hasLightResiGrade() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set lightResiGrade(param1:int) : void
      {
         hasField$0 |= 8192;
         lightResiGrade$field = param1;
      }
      
      public function get lightResiGrade() : int
      {
         return lightResiGrade$field;
      }
      
      public function removeLightResiGp() : void
      {
         hasField$0 &= 4294950911;
         lightResiGp$field = new int();
      }
      
      public function get hasLightResiGp() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set lightResiGp(param1:int) : void
      {
         hasField$0 |= 16384;
         lightResiGp$field = param1;
      }
      
      public function get lightResiGp() : int
      {
         return lightResiGp$field;
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294934527;
         skillId$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 32768;
         skillId$field = param1;
      }
      
      public function get skillId() : int
      {
         return skillId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasReduceResiGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,reduceResiGrade$field);
         }
         if(hasReduceResiGp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,reduceResiGp$field);
         }
         if(hasFireResiGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fireResiGrade$field);
         }
         if(hasFireResiGp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fireResiGp$field);
         }
         if(hasWaterResiGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,waterResiGrade$field);
         }
         if(hasWaterResiGp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,waterResiGp$field);
         }
         if(hasElcResiGrade)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,elcResiGrade$field);
         }
         if(hasElcResiGp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,elcResiGp$field);
         }
         if(hasWindResiGrade)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,windResiGrade$field);
         }
         if(hasWindResiGp)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,windResiGp$field);
         }
         if(hasDarkResiGrade)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,darkResiGrade$field);
         }
         if(hasDarkResiGp)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,darkResiGp$field);
         }
         if(hasLightResiGrade)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,lightResiGrade$field);
         }
         if(hasLightResiGp)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,lightResiGp$field);
         }
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,skillId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         var _loc19_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc16_:uint = 0;
         var _loc6_:uint = 0;
         var _loc18_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.grade cannot be set twice.");
                  }
                  _loc8_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.reduceResiGrade cannot be set twice.");
                  }
                  _loc14_++;
                  reduceResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.reduceResiGp cannot be set twice.");
                  }
                  _loc11_++;
                  reduceResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.fireResiGrade cannot be set twice.");
                  }
                  _loc19_++;
                  fireResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.fireResiGp cannot be set twice.");
                  }
                  _loc15_++;
                  fireResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.waterResiGrade cannot be set twice.");
                  }
                  _loc12_++;
                  waterResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.waterResiGp cannot be set twice.");
                  }
                  _loc3_++;
                  waterResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.elcResiGrade cannot be set twice.");
                  }
                  _loc13_++;
                  elcResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.elcResiGp cannot be set twice.");
                  }
                  _loc16_++;
                  elcResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.windResiGrade cannot be set twice.");
                  }
                  _loc6_++;
                  windResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.windResiGp cannot be set twice.");
                  }
                  _loc18_++;
                  windResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.darkResiGrade cannot be set twice.");
                  }
                  _loc4_++;
                  darkResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.darkResiGp cannot be set twice.");
                  }
                  _loc10_++;
                  darkResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.lightResiGrade cannot be set twice.");
                  }
                  _loc7_++;
                  lightResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.lightResiGp cannot be set twice.");
                  }
                  _loc5_++;
                  lightResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LifeWheelInfoMsg.skillId cannot be set twice.");
                  }
                  _loc9_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

