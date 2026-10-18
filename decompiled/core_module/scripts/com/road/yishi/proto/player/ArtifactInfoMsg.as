package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArtifactInfoMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var level$field:int;
      
      private var gp$field:int;
      
      private var attack$field:int;
      
      private var defences$field:int;
      
      private var magicAttack$field:int;
      
      private var magicDefences$field:int;
      
      private var penetrate$field:int;
      
      private var parry$field:int;
      
      private var live$field:int;
      
      private var skills$field:String;
      
      private var isEquip$field:Boolean;
      
      private var addPer$field:int;
      
      private var fightPower$field:int;
      
      private var slotedEquipPos1$field:int;
      
      private var slotedEquipPos2$field:int;
      
      private var slotedEquipPos3$field:int;
      
      private var slotedEquipPos4$field:int;
      
      private var slotedEquipPos5$field:int;
      
      private var armoryEquipPos1$field:int;
      
      private var armoryEquipPos2$field:int;
      
      private var armoryEquipPos3$field:int;
      
      private var armoryEquipPos4$field:int;
      
      private var armoryEquipPos5$field:int;
      
      private var armoryEquipPos6$field:int;
      
      private var suitSkill$field:String;
      
      public function ArtifactInfoMsg()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967291;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 4;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967287;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 8;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeDefences() : void
      {
         hasField$0 &= 4294967279;
         defences$field = new int();
      }
      
      public function get hasDefences() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set defences(param1:int) : void
      {
         hasField$0 |= 16;
         defences$field = param1;
      }
      
      public function get defences() : int
      {
         return defences$field;
      }
      
      public function removeMagicAttack() : void
      {
         hasField$0 &= 4294967263;
         magicAttack$field = new int();
      }
      
      public function get hasMagicAttack() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set magicAttack(param1:int) : void
      {
         hasField$0 |= 32;
         magicAttack$field = param1;
      }
      
      public function get magicAttack() : int
      {
         return magicAttack$field;
      }
      
      public function removeMagicDefences() : void
      {
         hasField$0 &= 4294967231;
         magicDefences$field = new int();
      }
      
      public function get hasMagicDefences() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set magicDefences(param1:int) : void
      {
         hasField$0 |= 64;
         magicDefences$field = param1;
      }
      
      public function get magicDefences() : int
      {
         return magicDefences$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4294967167;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 128;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
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
      
      public function removeSkills() : void
      {
         skills$field = null;
      }
      
      public function get hasSkills() : Boolean
      {
         return skills$field != null;
      }
      
      public function set skills(param1:String) : void
      {
         skills$field = param1;
      }
      
      public function get skills() : String
      {
         return skills$field;
      }
      
      public function removeIsEquip() : void
      {
         hasField$0 &= 4294966271;
         isEquip$field = new Boolean();
      }
      
      public function get hasIsEquip() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isEquip(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         isEquip$field = param1;
      }
      
      public function get isEquip() : Boolean
      {
         return isEquip$field;
      }
      
      public function removeAddPer() : void
      {
         hasField$0 &= 4294965247;
         addPer$field = new int();
      }
      
      public function get hasAddPer() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set addPer(param1:int) : void
      {
         hasField$0 |= 2048;
         addPer$field = param1;
      }
      
      public function get addPer() : int
      {
         return addPer$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294963199;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 4096;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeSlotedEquipPos1() : void
      {
         hasField$0 &= 4294959103;
         slotedEquipPos1$field = new int();
      }
      
      public function get hasSlotedEquipPos1() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set slotedEquipPos1(param1:int) : void
      {
         hasField$0 |= 8192;
         slotedEquipPos1$field = param1;
      }
      
      public function get slotedEquipPos1() : int
      {
         return slotedEquipPos1$field;
      }
      
      public function removeSlotedEquipPos2() : void
      {
         hasField$0 &= 4294950911;
         slotedEquipPos2$field = new int();
      }
      
      public function get hasSlotedEquipPos2() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set slotedEquipPos2(param1:int) : void
      {
         hasField$0 |= 16384;
         slotedEquipPos2$field = param1;
      }
      
      public function get slotedEquipPos2() : int
      {
         return slotedEquipPos2$field;
      }
      
      public function removeSlotedEquipPos3() : void
      {
         hasField$0 &= 4294934527;
         slotedEquipPos3$field = new int();
      }
      
      public function get hasSlotedEquipPos3() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set slotedEquipPos3(param1:int) : void
      {
         hasField$0 |= 32768;
         slotedEquipPos3$field = param1;
      }
      
      public function get slotedEquipPos3() : int
      {
         return slotedEquipPos3$field;
      }
      
      public function removeSlotedEquipPos4() : void
      {
         hasField$0 &= 4294901759;
         slotedEquipPos4$field = new int();
      }
      
      public function get hasSlotedEquipPos4() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set slotedEquipPos4(param1:int) : void
      {
         hasField$0 |= 65536;
         slotedEquipPos4$field = param1;
      }
      
      public function get slotedEquipPos4() : int
      {
         return slotedEquipPos4$field;
      }
      
      public function removeSlotedEquipPos5() : void
      {
         hasField$0 &= 4294836223;
         slotedEquipPos5$field = new int();
      }
      
      public function get hasSlotedEquipPos5() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set slotedEquipPos5(param1:int) : void
      {
         hasField$0 |= 131072;
         slotedEquipPos5$field = param1;
      }
      
      public function get slotedEquipPos5() : int
      {
         return slotedEquipPos5$field;
      }
      
      public function removeArmoryEquipPos1() : void
      {
         hasField$0 &= 4294705151;
         armoryEquipPos1$field = new int();
      }
      
      public function get hasArmoryEquipPos1() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set armoryEquipPos1(param1:int) : void
      {
         hasField$0 |= 262144;
         armoryEquipPos1$field = param1;
      }
      
      public function get armoryEquipPos1() : int
      {
         return armoryEquipPos1$field;
      }
      
      public function removeArmoryEquipPos2() : void
      {
         hasField$0 &= 4294443007;
         armoryEquipPos2$field = new int();
      }
      
      public function get hasArmoryEquipPos2() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set armoryEquipPos2(param1:int) : void
      {
         hasField$0 |= 524288;
         armoryEquipPos2$field = param1;
      }
      
      public function get armoryEquipPos2() : int
      {
         return armoryEquipPos2$field;
      }
      
      public function removeArmoryEquipPos3() : void
      {
         hasField$0 &= 4293918719;
         armoryEquipPos3$field = new int();
      }
      
      public function get hasArmoryEquipPos3() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set armoryEquipPos3(param1:int) : void
      {
         hasField$0 |= 1048576;
         armoryEquipPos3$field = param1;
      }
      
      public function get armoryEquipPos3() : int
      {
         return armoryEquipPos3$field;
      }
      
      public function removeArmoryEquipPos4() : void
      {
         hasField$0 &= 4292870143;
         armoryEquipPos4$field = new int();
      }
      
      public function get hasArmoryEquipPos4() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set armoryEquipPos4(param1:int) : void
      {
         hasField$0 |= 2097152;
         armoryEquipPos4$field = param1;
      }
      
      public function get armoryEquipPos4() : int
      {
         return armoryEquipPos4$field;
      }
      
      public function removeArmoryEquipPos5() : void
      {
         hasField$0 &= 4290772991;
         armoryEquipPos5$field = new int();
      }
      
      public function get hasArmoryEquipPos5() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set armoryEquipPos5(param1:int) : void
      {
         hasField$0 |= 4194304;
         armoryEquipPos5$field = param1;
      }
      
      public function get armoryEquipPos5() : int
      {
         return armoryEquipPos5$field;
      }
      
      public function removeArmoryEquipPos6() : void
      {
         hasField$0 &= 4286578687;
         armoryEquipPos6$field = new int();
      }
      
      public function get hasArmoryEquipPos6() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set armoryEquipPos6(param1:int) : void
      {
         hasField$0 |= 8388608;
         armoryEquipPos6$field = param1;
      }
      
      public function get armoryEquipPos6() : int
      {
         return armoryEquipPos6$field;
      }
      
      public function removeSuitSkill() : void
      {
         suitSkill$field = null;
      }
      
      public function get hasSuitSkill() : Boolean
      {
         return suitSkill$field != null;
      }
      
      public function set suitSkill(param1:String) : void
      {
         suitSkill$field = param1;
      }
      
      public function get suitSkill() : String
      {
         return suitSkill$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasDefences)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,defences$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,magicAttack$field);
         }
         if(hasMagicDefences)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,magicDefences$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
         if(hasIsEquip)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,isEquip$field);
         }
         if(hasAddPer)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,addPer$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasSlotedEquipPos1)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,slotedEquipPos1$field);
         }
         if(hasSlotedEquipPos2)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,slotedEquipPos2$field);
         }
         if(hasSlotedEquipPos3)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,slotedEquipPos3$field);
         }
         if(hasSlotedEquipPos4)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,slotedEquipPos4$field);
         }
         if(hasSlotedEquipPos5)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,slotedEquipPos5$field);
         }
         if(hasArmoryEquipPos1)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,armoryEquipPos1$field);
         }
         if(hasArmoryEquipPos2)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,armoryEquipPos2$field);
         }
         if(hasArmoryEquipPos3)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,armoryEquipPos3$field);
         }
         if(hasArmoryEquipPos4)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,armoryEquipPos4$field);
         }
         if(hasArmoryEquipPos5)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,armoryEquipPos5$field);
         }
         if(hasArmoryEquipPos6)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,armoryEquipPos6$field);
         }
         if(hasSuitSkill)
         {
            WriteUtils.writeTag(param1,2,26);
            WriteUtils.write$TYPE_STRING(param1,suitSkill$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc22_:uint = 0;
         var _loc19_:uint = 0;
         var _loc29_:uint = 0;
         var _loc26_:uint = 0;
         var _loc28_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc8_:uint = 0;
         var _loc15_:uint = 0;
         var _loc7_:uint = 0;
         var _loc20_:uint = 0;
         var _loc3_:uint = 0;
         var _loc18_:uint = 0;
         var _loc27_:uint = 0;
         var _loc11_:uint = 0;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc6_:uint = 0;
         var _loc16_:uint = 0;
         var _loc4_:uint = 0;
         var _loc21_:uint = 0;
         var _loc9_:uint = 0;
         var _loc23_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.templateId cannot be set twice.");
                  }
                  _loc22_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.level cannot be set twice.");
                  }
                  _loc19_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.gp cannot be set twice.");
                  }
                  _loc29_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.attack cannot be set twice.");
                  }
                  _loc26_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.defences cannot be set twice.");
                  }
                  _loc28_++;
                  defences = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.magicAttack cannot be set twice.");
                  }
                  _loc13_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.magicDefences cannot be set twice.");
                  }
                  _loc10_++;
                  magicDefences = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.penetrate cannot be set twice.");
                  }
                  _loc5_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.parry cannot be set twice.");
                  }
                  _loc14_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.live cannot be set twice.");
                  }
                  _loc12_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.skills cannot be set twice.");
                  }
                  _loc8_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.isEquip cannot be set twice.");
                  }
                  _loc15_++;
                  isEquip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.addPer cannot be set twice.");
                  }
                  _loc7_++;
                  addPer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc20_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.slotedEquipPos1 cannot be set twice.");
                  }
                  _loc3_++;
                  slotedEquipPos1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.slotedEquipPos2 cannot be set twice.");
                  }
                  _loc18_++;
                  slotedEquipPos2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.slotedEquipPos3 cannot be set twice.");
                  }
                  _loc27_++;
                  slotedEquipPos3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.slotedEquipPos4 cannot be set twice.");
                  }
                  _loc11_++;
                  slotedEquipPos4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.slotedEquipPos5 cannot be set twice.");
                  }
                  _loc24_++;
                  slotedEquipPos5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.armoryEquipPos1 cannot be set twice.");
                  }
                  _loc25_++;
                  armoryEquipPos1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.armoryEquipPos2 cannot be set twice.");
                  }
                  _loc6_++;
                  armoryEquipPos2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.armoryEquipPos3 cannot be set twice.");
                  }
                  _loc16_++;
                  armoryEquipPos3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.armoryEquipPos4 cannot be set twice.");
                  }
                  _loc4_++;
                  armoryEquipPos4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.armoryEquipPos5 cannot be set twice.");
                  }
                  _loc21_++;
                  armoryEquipPos5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.armoryEquipPos6 cannot be set twice.");
                  }
                  _loc9_++;
                  armoryEquipPos6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ArtifactInfoMsg.suitSkill cannot be set twice.");
                  }
                  _loc23_++;
                  suitSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

