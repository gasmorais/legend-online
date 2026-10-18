package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArmoryInfoMsg extends Message implements IExternalizable
   {
      
      private var armoryId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var profile$field:int;
      
      private var attacks$field:int;
      
      private var phyDefence$field:int;
      
      private var magicDefence$field:int;
      
      private var live$field:int;
      
      private var parry$field:int;
      
      private var penetrate$field:int;
      
      private var gp$field:int;
      
      private var grades$field:int;
      
      private var isEquip$field:Boolean;
      
      private var isExist$field:Boolean;
      
      public function ArmoryInfoMsg()
      {
         super();
      }
      
      public function removeArmoryId() : void
      {
         hasField$0 &= 4294967294;
         armoryId$field = new int();
      }
      
      public function get hasArmoryId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set armoryId(param1:int) : void
      {
         hasField$0 |= 1;
         armoryId$field = param1;
      }
      
      public function get armoryId() : int
      {
         return armoryId$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeProfile() : void
      {
         hasField$0 &= 4294967291;
         profile$field = new int();
      }
      
      public function get hasProfile() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set profile(param1:int) : void
      {
         hasField$0 |= 4;
         profile$field = param1;
      }
      
      public function get profile() : int
      {
         return profile$field;
      }
      
      public function removeAttacks() : void
      {
         hasField$0 &= 4294967287;
         attacks$field = new int();
      }
      
      public function get hasAttacks() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attacks(param1:int) : void
      {
         hasField$0 |= 8;
         attacks$field = param1;
      }
      
      public function get attacks() : int
      {
         return attacks$field;
      }
      
      public function removePhyDefence() : void
      {
         hasField$0 &= 4294967279;
         phyDefence$field = new int();
      }
      
      public function get hasPhyDefence() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set phyDefence(param1:int) : void
      {
         hasField$0 |= 16;
         phyDefence$field = param1;
      }
      
      public function get phyDefence() : int
      {
         return phyDefence$field;
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
      
      public function removeParry() : void
      {
         hasField$0 &= 4294967167;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 128;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4294967039;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 256;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294966783;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 512;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294966271;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 1024;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeIsEquip() : void
      {
         hasField$0 &= 4294965247;
         isEquip$field = new Boolean();
      }
      
      public function get hasIsEquip() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isEquip(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         isEquip$field = param1;
      }
      
      public function get isEquip() : Boolean
      {
         return isEquip$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294963199;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasArmoryId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,armoryId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasProfile)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,profile$field);
         }
         if(hasAttacks)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,attacks$field);
         }
         if(hasPhyDefence)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,phyDefence$field);
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
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasIsEquip)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,isEquip$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.armoryId cannot be set twice.");
                  }
                  _loc9_++;
                  armoryId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.profile cannot be set twice.");
                  }
                  _loc3_++;
                  profile = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.attacks cannot be set twice.");
                  }
                  _loc6_++;
                  attacks = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.phyDefence cannot be set twice.");
                  }
                  _loc10_++;
                  phyDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.magicDefence cannot be set twice.");
                  }
                  _loc14_++;
                  magicDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.live cannot be set twice.");
                  }
                  _loc8_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.parry cannot be set twice.");
                  }
                  _loc11_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.penetrate cannot be set twice.");
                  }
                  _loc7_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.gp cannot be set twice.");
                  }
                  _loc15_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.grades cannot be set twice.");
                  }
                  _loc16_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.isEquip cannot be set twice.");
                  }
                  _loc12_++;
                  isEquip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArmoryInfoMsg.isExist cannot be set twice.");
                  }
                  _loc4_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

