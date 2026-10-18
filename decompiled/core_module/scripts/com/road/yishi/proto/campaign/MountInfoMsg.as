package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MountInfoMsg extends Message implements IExternalizable
   {
      
      private var mount_tempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var power$field:int;
      
      private var intellect$field:int;
      
      private var physique$field:int;
      
      private var agility$field:int;
      
      private var speed$field:int;
      
      private var power_gp$field:int;
      
      private var intellect_gp$field:int;
      
      private var physique_gp$field:int;
      
      private var agility_gp$field:int;
      
      private var mount_totalGp$field:int;
      
      private var level_max$field:int;
      
      private var discount$field:int;
      
      private var mount_starLv$field:int;
      
      private var addPointCount$field:int;
      
      private var refining_soul_power_grade$field:int;
      
      private var refining_soul_intellect_grade$field:int;
      
      private var refining_soul_physique_grade$field:int;
      
      private var refining_soul_agility_grade$field:int;
      
      private var refining_soul_exp$field:int;
      
      public function MountInfoMsg()
      {
         super();
      }
      
      public function removeMountTempId() : void
      {
         hasField$0 &= 4294967294;
         mount_tempId$field = new int();
      }
      
      public function get hasMountTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mountTempId(param1:int) : void
      {
         hasField$0 |= 1;
         mount_tempId$field = param1;
      }
      
      public function get mountTempId() : int
      {
         return mount_tempId$field;
      }
      
      public function removePower() : void
      {
         hasField$0 &= 4294967293;
         power$field = new int();
      }
      
      public function get hasPower() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set power(param1:int) : void
      {
         hasField$0 |= 2;
         power$field = param1;
      }
      
      public function get power() : int
      {
         return power$field;
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
      
      public function removePhysique() : void
      {
         hasField$0 &= 4294967287;
         physique$field = new int();
      }
      
      public function get hasPhysique() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set physique(param1:int) : void
      {
         hasField$0 |= 8;
         physique$field = param1;
      }
      
      public function get physique() : int
      {
         return physique$field;
      }
      
      public function removeAgility() : void
      {
         hasField$0 &= 4294967279;
         agility$field = new int();
      }
      
      public function get hasAgility() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set agility(param1:int) : void
      {
         hasField$0 |= 16;
         agility$field = param1;
      }
      
      public function get agility() : int
      {
         return agility$field;
      }
      
      public function removeSpeed() : void
      {
         hasField$0 &= 4294967263;
         speed$field = new int();
      }
      
      public function get hasSpeed() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set speed(param1:int) : void
      {
         hasField$0 |= 32;
         speed$field = param1;
      }
      
      public function get speed() : int
      {
         return speed$field;
      }
      
      public function removePowerGp() : void
      {
         hasField$0 &= 4294967231;
         power_gp$field = new int();
      }
      
      public function get hasPowerGp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set powerGp(param1:int) : void
      {
         hasField$0 |= 64;
         power_gp$field = param1;
      }
      
      public function get powerGp() : int
      {
         return power_gp$field;
      }
      
      public function removeIntellectGp() : void
      {
         hasField$0 &= 4294967167;
         intellect_gp$field = new int();
      }
      
      public function get hasIntellectGp() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set intellectGp(param1:int) : void
      {
         hasField$0 |= 128;
         intellect_gp$field = param1;
      }
      
      public function get intellectGp() : int
      {
         return intellect_gp$field;
      }
      
      public function removePhysiqueGp() : void
      {
         hasField$0 &= 4294967039;
         physique_gp$field = new int();
      }
      
      public function get hasPhysiqueGp() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set physiqueGp(param1:int) : void
      {
         hasField$0 |= 256;
         physique_gp$field = param1;
      }
      
      public function get physiqueGp() : int
      {
         return physique_gp$field;
      }
      
      public function removeAgilityGp() : void
      {
         hasField$0 &= 4294966783;
         agility_gp$field = new int();
      }
      
      public function get hasAgilityGp() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set agilityGp(param1:int) : void
      {
         hasField$0 |= 512;
         agility_gp$field = param1;
      }
      
      public function get agilityGp() : int
      {
         return agility_gp$field;
      }
      
      public function removeMountTotalGp() : void
      {
         hasField$0 &= 4294966271;
         mount_totalGp$field = new int();
      }
      
      public function get hasMountTotalGp() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set mountTotalGp(param1:int) : void
      {
         hasField$0 |= 1024;
         mount_totalGp$field = param1;
      }
      
      public function get mountTotalGp() : int
      {
         return mount_totalGp$field;
      }
      
      public function removeLevelMax() : void
      {
         hasField$0 &= 4294965247;
         level_max$field = new int();
      }
      
      public function get hasLevelMax() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set levelMax(param1:int) : void
      {
         hasField$0 |= 2048;
         level_max$field = param1;
      }
      
      public function get levelMax() : int
      {
         return level_max$field;
      }
      
      public function removeDiscount() : void
      {
         hasField$0 &= 4294963199;
         discount$field = new int();
      }
      
      public function get hasDiscount() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set discount(param1:int) : void
      {
         hasField$0 |= 4096;
         discount$field = param1;
      }
      
      public function get discount() : int
      {
         return discount$field;
      }
      
      public function removeMountStarLv() : void
      {
         hasField$0 &= 4294959103;
         mount_starLv$field = new int();
      }
      
      public function get hasMountStarLv() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set mountStarLv(param1:int) : void
      {
         hasField$0 |= 8192;
         mount_starLv$field = param1;
      }
      
      public function get mountStarLv() : int
      {
         return mount_starLv$field;
      }
      
      public function removeAddPointCount() : void
      {
         hasField$0 &= 4294950911;
         addPointCount$field = new int();
      }
      
      public function get hasAddPointCount() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set addPointCount(param1:int) : void
      {
         hasField$0 |= 16384;
         addPointCount$field = param1;
      }
      
      public function get addPointCount() : int
      {
         return addPointCount$field;
      }
      
      public function removeRefiningSoulPowerGrade() : void
      {
         hasField$0 &= 4294934527;
         refining_soul_power_grade$field = new int();
      }
      
      public function get hasRefiningSoulPowerGrade() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set refiningSoulPowerGrade(param1:int) : void
      {
         hasField$0 |= 32768;
         refining_soul_power_grade$field = param1;
      }
      
      public function get refiningSoulPowerGrade() : int
      {
         return refining_soul_power_grade$field;
      }
      
      public function removeRefiningSoulIntellectGrade() : void
      {
         hasField$0 &= 4294901759;
         refining_soul_intellect_grade$field = new int();
      }
      
      public function get hasRefiningSoulIntellectGrade() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set refiningSoulIntellectGrade(param1:int) : void
      {
         hasField$0 |= 65536;
         refining_soul_intellect_grade$field = param1;
      }
      
      public function get refiningSoulIntellectGrade() : int
      {
         return refining_soul_intellect_grade$field;
      }
      
      public function removeRefiningSoulPhysiqueGrade() : void
      {
         hasField$0 &= 4294836223;
         refining_soul_physique_grade$field = new int();
      }
      
      public function get hasRefiningSoulPhysiqueGrade() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set refiningSoulPhysiqueGrade(param1:int) : void
      {
         hasField$0 |= 131072;
         refining_soul_physique_grade$field = param1;
      }
      
      public function get refiningSoulPhysiqueGrade() : int
      {
         return refining_soul_physique_grade$field;
      }
      
      public function removeRefiningSoulAgilityGrade() : void
      {
         hasField$0 &= 4294705151;
         refining_soul_agility_grade$field = new int();
      }
      
      public function get hasRefiningSoulAgilityGrade() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set refiningSoulAgilityGrade(param1:int) : void
      {
         hasField$0 |= 262144;
         refining_soul_agility_grade$field = param1;
      }
      
      public function get refiningSoulAgilityGrade() : int
      {
         return refining_soul_agility_grade$field;
      }
      
      public function removeRefiningSoulExp() : void
      {
         hasField$0 &= 4294443007;
         refining_soul_exp$field = new int();
      }
      
      public function get hasRefiningSoulExp() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set refiningSoulExp(param1:int) : void
      {
         hasField$0 |= 524288;
         refining_soul_exp$field = param1;
      }
      
      public function get refiningSoulExp() : int
      {
         return refining_soul_exp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMountTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mount_tempId$field);
         }
         if(hasPower)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,power$field);
         }
         if(hasIntellect)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,intellect$field);
         }
         if(hasPhysique)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,physique$field);
         }
         if(hasAgility)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,agility$field);
         }
         if(hasSpeed)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,speed$field);
         }
         if(hasPowerGp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,power_gp$field);
         }
         if(hasIntellectGp)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,intellect_gp$field);
         }
         if(hasPhysiqueGp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,physique_gp$field);
         }
         if(hasAgilityGp)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,agility_gp$field);
         }
         if(hasMountTotalGp)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,mount_totalGp$field);
         }
         if(hasLevelMax)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,level_max$field);
         }
         if(hasDiscount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,discount$field);
         }
         if(hasMountStarLv)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,mount_starLv$field);
         }
         if(hasAddPointCount)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,addPointCount$field);
         }
         if(hasRefiningSoulPowerGrade)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,refining_soul_power_grade$field);
         }
         if(hasRefiningSoulIntellectGrade)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,refining_soul_intellect_grade$field);
         }
         if(hasRefiningSoulPhysiqueGrade)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,refining_soul_physique_grade$field);
         }
         if(hasRefiningSoulAgilityGrade)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,refining_soul_agility_grade$field);
         }
         if(hasRefiningSoulExp)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,refining_soul_exp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc21_:uint = 0;
         var _loc17_:uint = 0;
         var _loc22_:uint = 0;
         var _loc8_:uint = 0;
         var _loc18_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc16_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc15_:uint = 0;
         var _loc23_:uint = 0;
         var _loc20_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.mountTempId cannot be set twice.");
                  }
                  _loc21_++;
                  mountTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.power cannot be set twice.");
                  }
                  _loc17_++;
                  power = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.intellect cannot be set twice.");
                  }
                  _loc22_++;
                  intellect = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.physique cannot be set twice.");
                  }
                  _loc8_++;
                  physique = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.agility cannot be set twice.");
                  }
                  _loc18_++;
                  agility = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.speed cannot be set twice.");
                  }
                  _loc9_++;
                  speed = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.powerGp cannot be set twice.");
                  }
                  _loc6_++;
                  powerGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.intellectGp cannot be set twice.");
                  }
                  _loc4_++;
                  intellectGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.physiqueGp cannot be set twice.");
                  }
                  _loc16_++;
                  physiqueGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.agilityGp cannot be set twice.");
                  }
                  _loc5_++;
                  agilityGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.mountTotalGp cannot be set twice.");
                  }
                  _loc3_++;
                  mountTotalGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.levelMax cannot be set twice.");
                  }
                  _loc10_++;
                  levelMax = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.discount cannot be set twice.");
                  }
                  _loc11_++;
                  discount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.mountStarLv cannot be set twice.");
                  }
                  _loc14_++;
                  mountStarLv = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.addPointCount cannot be set twice.");
                  }
                  _loc12_++;
                  addPointCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.refiningSoulPowerGrade cannot be set twice.");
                  }
                  _loc7_++;
                  refiningSoulPowerGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.refiningSoulIntellectGrade cannot be set twice.");
                  }
                  _loc13_++;
                  refiningSoulIntellectGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.refiningSoulPhysiqueGrade cannot be set twice.");
                  }
                  _loc15_++;
                  refiningSoulPhysiqueGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.refiningSoulAgilityGrade cannot be set twice.");
                  }
                  _loc23_++;
                  refiningSoulAgilityGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: MountInfoMsg.refiningSoulExp cannot be set twice.");
                  }
                  _loc20_++;
                  refiningSoulExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

