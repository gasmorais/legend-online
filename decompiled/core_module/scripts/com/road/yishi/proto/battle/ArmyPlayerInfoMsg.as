package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArmyPlayerInfoMsg extends Message implements IExternalizable
   {
      
      private var aas_factor$field:Number;
      
      private var hasField$0:uint = 0;
      
      private var is_vip$field:Boolean;
      
      private var vip_type$field:int;
      
      private var geste_dec_count$field:int;
      
      private var consortia_id$field:int;
      
      private var consortia_name$field:String;
      
      private var change_shapeId$field:int;
      
      private var arm$field:String;
      
      private var geste$field:int;
      
      private var mount_temp_id$field:int;
      
      private var mount_grade$field:int;
      
      private var wing$field:String;
      
      private var hat$field:String;
      
      private var fashion_arm$field:String;
      
      private var fashion_cloth$field:String;
      
      private var hide$field:Boolean;
      
      private var is_max_count$field:Boolean;
      
      private var vip_grade$field:int;
      
      private var fate_skills$field:String;
      
      private var pet_temp_id$field:int;
      
      private var pet_quality$field:int;
      
      private var pet_name$field:String;
      
      private var child_job$field:int;
      
      private var child_name$field:String;
      
      private var child_sex$field:int;
      
      private var growth_grade$field:int;
      
      private var growth_grade2$field:int;
      
      public function ArmyPlayerInfoMsg()
      {
         super();
      }
      
      public function removeAasFactor() : void
      {
         hasField$0 &= 4294967294;
         aas_factor$field = new Number();
      }
      
      public function get hasAasFactor() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set aasFactor(param1:Number) : void
      {
         hasField$0 |= 1;
         aas_factor$field = param1;
      }
      
      public function get aasFactor() : Number
      {
         return aas_factor$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294967293;
         is_vip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_vip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return is_vip$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294967291;
         vip_type$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 4;
         vip_type$field = param1;
      }
      
      public function get vipType() : int
      {
         return vip_type$field;
      }
      
      public function removeGesteDecCount() : void
      {
         hasField$0 &= 4294967287;
         geste_dec_count$field = new int();
      }
      
      public function get hasGesteDecCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set gesteDecCount(param1:int) : void
      {
         hasField$0 |= 8;
         geste_dec_count$field = param1;
      }
      
      public function get gesteDecCount() : int
      {
         return geste_dec_count$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967279;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 16;
         consortia_id$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortia_id$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortia_name$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortia_name$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortia_name$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortia_name$field;
      }
      
      public function removeChangeShapeId() : void
      {
         hasField$0 &= 4294967263;
         change_shapeId$field = new int();
      }
      
      public function get hasChangeShapeId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set changeShapeId(param1:int) : void
      {
         hasField$0 |= 32;
         change_shapeId$field = param1;
      }
      
      public function get changeShapeId() : int
      {
         return change_shapeId$field;
      }
      
      public function removeArm() : void
      {
         arm$field = null;
      }
      
      public function get hasArm() : Boolean
      {
         return arm$field != null;
      }
      
      public function set arm(param1:String) : void
      {
         arm$field = param1;
      }
      
      public function get arm() : String
      {
         return arm$field;
      }
      
      public function removeGeste() : void
      {
         hasField$0 &= 4294967231;
         geste$field = new int();
      }
      
      public function get hasGeste() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set geste(param1:int) : void
      {
         hasField$0 |= 64;
         geste$field = param1;
      }
      
      public function get geste() : int
      {
         return geste$field;
      }
      
      public function removeMountTempId() : void
      {
         hasField$0 &= 4294967167;
         mount_temp_id$field = new int();
      }
      
      public function get hasMountTempId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set mountTempId(param1:int) : void
      {
         hasField$0 |= 128;
         mount_temp_id$field = param1;
      }
      
      public function get mountTempId() : int
      {
         return mount_temp_id$field;
      }
      
      public function removeMountGrade() : void
      {
         hasField$0 &= 4294967039;
         mount_grade$field = new int();
      }
      
      public function get hasMountGrade() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set mountGrade(param1:int) : void
      {
         hasField$0 |= 256;
         mount_grade$field = param1;
      }
      
      public function get mountGrade() : int
      {
         return mount_grade$field;
      }
      
      public function removeWing() : void
      {
         wing$field = null;
      }
      
      public function get hasWing() : Boolean
      {
         return wing$field != null;
      }
      
      public function set wing(param1:String) : void
      {
         wing$field = param1;
      }
      
      public function get wing() : String
      {
         return wing$field;
      }
      
      public function removeHat() : void
      {
         hat$field = null;
      }
      
      public function get hasHat() : Boolean
      {
         return hat$field != null;
      }
      
      public function set hat(param1:String) : void
      {
         hat$field = param1;
      }
      
      public function get hat() : String
      {
         return hat$field;
      }
      
      public function removeFashionArm() : void
      {
         fashion_arm$field = null;
      }
      
      public function get hasFashionArm() : Boolean
      {
         return fashion_arm$field != null;
      }
      
      public function set fashionArm(param1:String) : void
      {
         fashion_arm$field = param1;
      }
      
      public function get fashionArm() : String
      {
         return fashion_arm$field;
      }
      
      public function removeFashionCloth() : void
      {
         fashion_cloth$field = null;
      }
      
      public function get hasFashionCloth() : Boolean
      {
         return fashion_cloth$field != null;
      }
      
      public function set fashionCloth(param1:String) : void
      {
         fashion_cloth$field = param1;
      }
      
      public function get fashionCloth() : String
      {
         return fashion_cloth$field;
      }
      
      public function removeHide() : void
      {
         hasField$0 &= 4294966783;
         hide$field = new Boolean();
      }
      
      public function get hasHide() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set hide(param1:Boolean) : void
      {
         hasField$0 |= 512;
         hide$field = param1;
      }
      
      public function get hide() : Boolean
      {
         return hide$field;
      }
      
      public function removeIsMaxCount() : void
      {
         hasField$0 &= 4294966271;
         is_max_count$field = new Boolean();
      }
      
      public function get hasIsMaxCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isMaxCount(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         is_max_count$field = param1;
      }
      
      public function get isMaxCount() : Boolean
      {
         return is_max_count$field;
      }
      
      public function removeVipGrade() : void
      {
         hasField$0 &= 4294965247;
         vip_grade$field = new int();
      }
      
      public function get hasVipGrade() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set vipGrade(param1:int) : void
      {
         hasField$0 |= 2048;
         vip_grade$field = param1;
      }
      
      public function get vipGrade() : int
      {
         return vip_grade$field;
      }
      
      public function removeFateSkills() : void
      {
         fate_skills$field = null;
      }
      
      public function get hasFateSkills() : Boolean
      {
         return fate_skills$field != null;
      }
      
      public function set fateSkills(param1:String) : void
      {
         fate_skills$field = param1;
      }
      
      public function get fateSkills() : String
      {
         return fate_skills$field;
      }
      
      public function removePetTempId() : void
      {
         hasField$0 &= 4294963199;
         pet_temp_id$field = new int();
      }
      
      public function get hasPetTempId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set petTempId(param1:int) : void
      {
         hasField$0 |= 4096;
         pet_temp_id$field = param1;
      }
      
      public function get petTempId() : int
      {
         return pet_temp_id$field;
      }
      
      public function removePetQuality() : void
      {
         hasField$0 &= 4294959103;
         pet_quality$field = new int();
      }
      
      public function get hasPetQuality() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set petQuality(param1:int) : void
      {
         hasField$0 |= 8192;
         pet_quality$field = param1;
      }
      
      public function get petQuality() : int
      {
         return pet_quality$field;
      }
      
      public function removePetName() : void
      {
         pet_name$field = null;
      }
      
      public function get hasPetName() : Boolean
      {
         return pet_name$field != null;
      }
      
      public function set petName(param1:String) : void
      {
         pet_name$field = param1;
      }
      
      public function get petName() : String
      {
         return pet_name$field;
      }
      
      public function removeChildJob() : void
      {
         hasField$0 &= 4294950911;
         child_job$field = new int();
      }
      
      public function get hasChildJob() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set childJob(param1:int) : void
      {
         hasField$0 |= 16384;
         child_job$field = param1;
      }
      
      public function get childJob() : int
      {
         return child_job$field;
      }
      
      public function removeChildName() : void
      {
         child_name$field = null;
      }
      
      public function get hasChildName() : Boolean
      {
         return child_name$field != null;
      }
      
      public function set childName(param1:String) : void
      {
         child_name$field = param1;
      }
      
      public function get childName() : String
      {
         return child_name$field;
      }
      
      public function removeChildSex() : void
      {
         hasField$0 &= 4294934527;
         child_sex$field = new int();
      }
      
      public function get hasChildSex() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set childSex(param1:int) : void
      {
         hasField$0 |= 32768;
         child_sex$field = param1;
      }
      
      public function get childSex() : int
      {
         return child_sex$field;
      }
      
      public function removeGrowthGrade() : void
      {
         hasField$0 &= 4294901759;
         growth_grade$field = new int();
      }
      
      public function get hasGrowthGrade() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set growthGrade(param1:int) : void
      {
         hasField$0 |= 65536;
         growth_grade$field = param1;
      }
      
      public function get growthGrade() : int
      {
         return growth_grade$field;
      }
      
      public function removeGrowthGrade2() : void
      {
         hasField$0 &= 4294836223;
         growth_grade2$field = new int();
      }
      
      public function get hasGrowthGrade2() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set growthGrade2(param1:int) : void
      {
         hasField$0 |= 131072;
         growth_grade2$field = param1;
      }
      
      public function get growthGrade2() : int
      {
         return growth_grade2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAasFactor)
         {
            WriteUtils.writeTag(param1,5,1);
            WriteUtils.write$TYPE_FLOAT(param1,aas_factor$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,is_vip$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,vip_type$field);
         }
         if(hasGesteDecCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,geste_dec_count$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasChangeShapeId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,change_shapeId$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasGeste)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,geste$field);
         }
         if(hasMountTempId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,mount_temp_id$field);
         }
         if(hasMountGrade)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,mount_grade$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,fashion_arm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,fashion_cloth$field);
         }
         if(hasHide)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,hide$field);
         }
         if(hasIsMaxCount)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,is_max_count$field);
         }
         if(hasVipGrade)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,vip_grade$field);
         }
         if(hasFateSkills)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,fate_skills$field);
         }
         if(hasPetTempId)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,pet_temp_id$field);
         }
         if(hasPetQuality)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,pet_quality$field);
         }
         if(hasPetName)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_STRING(param1,pet_name$field);
         }
         if(hasChildJob)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,child_job$field);
         }
         if(hasChildName)
         {
            WriteUtils.writeTag(param1,2,24);
            WriteUtils.write$TYPE_STRING(param1,child_name$field);
         }
         if(hasChildSex)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,child_sex$field);
         }
         if(hasGrowthGrade)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,growth_grade$field);
         }
         if(hasGrowthGrade2)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,growth_grade2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc23_:uint = 0;
         var _loc19_:uint = 0;
         var _loc15_:uint = 0;
         var _loc26_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc17_:uint = 0;
         var _loc27_:uint = 0;
         var _loc20_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc28_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc18_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc25_:uint = 0;
         var _loc24_:uint = 0;
         var _loc30_:uint = 0;
         var _loc10_:uint = 0;
         var _loc29_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.aasFactor cannot be set twice.");
                  }
                  _loc23_++;
                  aasFactor = ReadUtils.read$TYPE_FLOAT(param1);
                  break;
               case 2:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.isVip cannot be set twice.");
                  }
                  _loc19_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.vipType cannot be set twice.");
                  }
                  _loc15_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.gesteDecCount cannot be set twice.");
                  }
                  _loc26_++;
                  gesteDecCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.consortiaId cannot be set twice.");
                  }
                  _loc12_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.consortiaName cannot be set twice.");
                  }
                  _loc6_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.changeShapeId cannot be set twice.");
                  }
                  _loc11_++;
                  changeShapeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.arm cannot be set twice.");
                  }
                  _loc13_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.geste cannot be set twice.");
                  }
                  _loc17_++;
                  geste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.mountTempId cannot be set twice.");
                  }
                  _loc27_++;
                  mountTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.mountGrade cannot be set twice.");
                  }
                  _loc20_++;
                  mountGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.wing cannot be set twice.");
                  }
                  _loc14_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.hat cannot be set twice.");
                  }
                  _loc4_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.fashionArm cannot be set twice.");
                  }
                  _loc28_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 15:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.fashionCloth cannot be set twice.");
                  }
                  _loc21_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.hide cannot be set twice.");
                  }
                  _loc22_++;
                  hide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.isMaxCount cannot be set twice.");
                  }
                  _loc7_++;
                  isMaxCount = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.vipGrade cannot be set twice.");
                  }
                  _loc3_++;
                  vipGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.fateSkills cannot be set twice.");
                  }
                  _loc5_++;
                  fateSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 20:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.petTempId cannot be set twice.");
                  }
                  _loc18_++;
                  petTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.petQuality cannot be set twice.");
                  }
                  _loc9_++;
                  petQuality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.petName cannot be set twice.");
                  }
                  _loc8_++;
                  petName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 23:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.childJob cannot be set twice.");
                  }
                  _loc25_++;
                  childJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.childName cannot be set twice.");
                  }
                  _loc24_++;
                  childName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 25:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.childSex cannot be set twice.");
                  }
                  _loc30_++;
                  childSex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.growthGrade cannot be set twice.");
                  }
                  _loc10_++;
                  growthGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyPlayerInfoMsg.growthGrade2 cannot be set twice.");
                  }
                  _loc29_++;
                  growthGrade2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

