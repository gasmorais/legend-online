package com.road.yishi.proto.gloryroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MirrorInfoMsg extends Message implements IExternalizable
   {
      
      private var userid$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grade$field:int;
      
      private var job$field:int;
      
      private var sexs$field:int;
      
      private var fightCapacity$field:int;
      
      private var nickName$field:String;
      
      private var phyAttack$field:int;
      
      private var phyDefence$field:int;
      
      private var magAttack$field:int;
      
      private var magDefence$field:int;
      
      private var forceHit$field:int;
      
      private var penetrate$field:int;
      
      private var parry$field:int;
      
      private var hp$field:int;
      
      private var stunAttr$field:int;
      
      private var conat$field:int;
      
      private var reduceResi$field:int;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var lightResi$field:int;
      
      private var arm$field:String;
      
      private var cloth$field:String;
      
      private var wing$field:String;
      
      private var hat$field:String;
      
      private var hideFashion$field:Boolean;
      
      private var fashionArm$field:String;
      
      private var fashionCloth$field:String;
      
      private var isDragonTalker$field:Boolean;
      
      private var battleBeastId$field:int;
      
      public function MirrorInfoMsg()
      {
         super();
      }
      
      public function removeUserid() : void
      {
         hasField$0 &= 4294967294;
         userid$field = new int();
      }
      
      public function get hasUserid() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userid(param1:int) : void
      {
         hasField$0 |= 1;
         userid$field = param1;
      }
      
      public function get userid() : int
      {
         return userid$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967293;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 2;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967291;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 4;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeSexs() : void
      {
         hasField$0 &= 4294967287;
         sexs$field = new int();
      }
      
      public function get hasSexs() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set sexs(param1:int) : void
      {
         hasField$0 |= 8;
         sexs$field = param1;
      }
      
      public function get sexs() : int
      {
         return sexs$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967279;
         fightCapacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 16;
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fightCapacity$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removePhyAttack() : void
      {
         hasField$0 &= 4294967263;
         phyAttack$field = new int();
      }
      
      public function get hasPhyAttack() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set phyAttack(param1:int) : void
      {
         hasField$0 |= 32;
         phyAttack$field = param1;
      }
      
      public function get phyAttack() : int
      {
         return phyAttack$field;
      }
      
      public function removePhyDefence() : void
      {
         hasField$0 &= 4294967231;
         phyDefence$field = new int();
      }
      
      public function get hasPhyDefence() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set phyDefence(param1:int) : void
      {
         hasField$0 |= 64;
         phyDefence$field = param1;
      }
      
      public function get phyDefence() : int
      {
         return phyDefence$field;
      }
      
      public function removeMagAttack() : void
      {
         hasField$0 &= 4294967167;
         magAttack$field = new int();
      }
      
      public function get hasMagAttack() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set magAttack(param1:int) : void
      {
         hasField$0 |= 128;
         magAttack$field = param1;
      }
      
      public function get magAttack() : int
      {
         return magAttack$field;
      }
      
      public function removeMagDefence() : void
      {
         hasField$0 &= 4294967039;
         magDefence$field = new int();
      }
      
      public function get hasMagDefence() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set magDefence(param1:int) : void
      {
         hasField$0 |= 256;
         magDefence$field = param1;
      }
      
      public function get magDefence() : int
      {
         return magDefence$field;
      }
      
      public function removeForceHit() : void
      {
         hasField$0 &= 4294966783;
         forceHit$field = new int();
      }
      
      public function get hasForceHit() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set forceHit(param1:int) : void
      {
         hasField$0 |= 512;
         forceHit$field = param1;
      }
      
      public function get forceHit() : int
      {
         return forceHit$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4294966271;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 1024;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      public function removeParry() : void
      {
         hasField$0 &= 4294965247;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 2048;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294963199;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 4096;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      public function removeStunAttr() : void
      {
         hasField$0 &= 4294959103;
         stunAttr$field = new int();
      }
      
      public function get hasStunAttr() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set stunAttr(param1:int) : void
      {
         hasField$0 |= 8192;
         stunAttr$field = param1;
      }
      
      public function get stunAttr() : int
      {
         return stunAttr$field;
      }
      
      public function removeConat() : void
      {
         hasField$0 &= 4294950911;
         conat$field = new int();
      }
      
      public function get hasConat() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set conat(param1:int) : void
      {
         hasField$0 |= 16384;
         conat$field = param1;
      }
      
      public function get conat() : int
      {
         return conat$field;
      }
      
      public function removeReduceResi() : void
      {
         hasField$0 &= 4294934527;
         reduceResi$field = new int();
      }
      
      public function get hasReduceResi() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set reduceResi(param1:int) : void
      {
         hasField$0 |= 32768;
         reduceResi$field = param1;
      }
      
      public function get reduceResi() : int
      {
         return reduceResi$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$0 &= 4294901759;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$0 |= 65536;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$0 &= 4294836223;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$0 |= 131072;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$0 &= 4294705151;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$0 |= 262144;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$0 &= 4294443007;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$0 |= 524288;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$0 &= 4293918719;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$0 |= 1048576;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$0 &= 4292870143;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$0 |= 2097152;
         lightResi$field = param1;
      }
      
      public function get lightResi() : int
      {
         return lightResi$field;
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
      
      public function removeCloth() : void
      {
         cloth$field = null;
      }
      
      public function get hasCloth() : Boolean
      {
         return cloth$field != null;
      }
      
      public function set cloth(param1:String) : void
      {
         cloth$field = param1;
      }
      
      public function get cloth() : String
      {
         return cloth$field;
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
      
      public function removeHideFashion() : void
      {
         hasField$0 &= 4290772991;
         hideFashion$field = new Boolean();
      }
      
      public function get hasHideFashion() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set hideFashion(param1:Boolean) : void
      {
         hasField$0 |= 4194304;
         hideFashion$field = param1;
      }
      
      public function get hideFashion() : Boolean
      {
         return hideFashion$field;
      }
      
      public function removeFashionArm() : void
      {
         fashionArm$field = null;
      }
      
      public function get hasFashionArm() : Boolean
      {
         return fashionArm$field != null;
      }
      
      public function set fashionArm(param1:String) : void
      {
         fashionArm$field = param1;
      }
      
      public function get fashionArm() : String
      {
         return fashionArm$field;
      }
      
      public function removeFashionCloth() : void
      {
         fashionCloth$field = null;
      }
      
      public function get hasFashionCloth() : Boolean
      {
         return fashionCloth$field != null;
      }
      
      public function set fashionCloth(param1:String) : void
      {
         fashionCloth$field = param1;
      }
      
      public function get fashionCloth() : String
      {
         return fashionCloth$field;
      }
      
      public function removeIsDragonTalker() : void
      {
         hasField$0 &= 4286578687;
         isDragonTalker$field = new Boolean();
      }
      
      public function get hasIsDragonTalker() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set isDragonTalker(param1:Boolean) : void
      {
         hasField$0 |= 8388608;
         isDragonTalker$field = param1;
      }
      
      public function get isDragonTalker() : Boolean
      {
         return isDragonTalker$field;
      }
      
      public function removeBattleBeastId() : void
      {
         hasField$0 &= 4278190079;
         battleBeastId$field = new int();
      }
      
      public function get hasBattleBeastId() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set battleBeastId(param1:int) : void
      {
         hasField$0 |= 16777216;
         battleBeastId$field = param1;
      }
      
      public function get battleBeastId() : int
      {
         return battleBeastId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserid)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userid$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasSexs)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,sexs$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fightCapacity$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasPhyAttack)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,phyAttack$field);
         }
         if(hasPhyDefence)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,phyDefence$field);
         }
         if(hasMagAttack)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,magAttack$field);
         }
         if(hasMagDefence)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,magDefence$field);
         }
         if(hasForceHit)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,forceHit$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         if(hasStunAttr)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,stunAttr$field);
         }
         if(hasConat)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,conat$field);
         }
         if(hasReduceResi)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,reduceResi$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,24);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasCloth)
         {
            WriteUtils.writeTag(param1,2,25);
            WriteUtils.write$TYPE_STRING(param1,cloth$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,26);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,27);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasHideFashion)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_BOOL(param1,hideFashion$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,29);
            WriteUtils.write$TYPE_STRING(param1,fashionArm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,30);
            WriteUtils.write$TYPE_STRING(param1,fashionCloth$field);
         }
         if(hasIsDragonTalker)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_BOOL(param1,isDragonTalker$field);
         }
         if(hasBattleBeastId)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_INT32(param1,battleBeastId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc17_:uint = 0;
         var _loc30_:uint = 0;
         var _loc26_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         var _loc24_:uint = 0;
         var _loc31_:uint = 0;
         var _loc23_:uint = 0;
         var _loc7_:uint = 0;
         var _loc19_:uint = 0;
         var _loc33_:uint = 0;
         var _loc29_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc25_:uint = 0;
         var _loc27_:uint = 0;
         var _loc35_:uint = 0;
         var _loc28_:uint = 0;
         var _loc22_:uint = 0;
         var _loc16_:uint = 0;
         var _loc15_:uint = 0;
         var _loc34_:uint = 0;
         var _loc18_:uint = 0;
         var _loc3_:uint = 0;
         var _loc32_:uint = 0;
         var _loc20_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.userid cannot be set twice.");
                  }
                  _loc11_++;
                  userid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.grade cannot be set twice.");
                  }
                  _loc5_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.job cannot be set twice.");
                  }
                  _loc17_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.sexs cannot be set twice.");
                  }
                  _loc30_++;
                  sexs = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.fightCapacity cannot be set twice.");
                  }
                  _loc26_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.nickName cannot be set twice.");
                  }
                  _loc13_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.phyAttack cannot be set twice.");
                  }
                  _loc6_++;
                  phyAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.phyDefence cannot be set twice.");
                  }
                  _loc14_++;
                  phyDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.magAttack cannot be set twice.");
                  }
                  _loc24_++;
                  magAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.magDefence cannot be set twice.");
                  }
                  _loc31_++;
                  magDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.forceHit cannot be set twice.");
                  }
                  _loc23_++;
                  forceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.penetrate cannot be set twice.");
                  }
                  _loc7_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.parry cannot be set twice.");
                  }
                  _loc19_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.hp cannot be set twice.");
                  }
                  _loc33_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.stunAttr cannot be set twice.");
                  }
                  _loc29_++;
                  stunAttr = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.conat cannot be set twice.");
                  }
                  _loc8_++;
                  conat = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.reduceResi cannot be set twice.");
                  }
                  _loc12_++;
                  reduceResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.fireResi cannot be set twice.");
                  }
                  _loc25_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.waterResi cannot be set twice.");
                  }
                  _loc27_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.electResi cannot be set twice.");
                  }
                  _loc35_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.windResi cannot be set twice.");
                  }
                  _loc28_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.darkResi cannot be set twice.");
                  }
                  _loc22_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.lightResi cannot be set twice.");
                  }
                  _loc16_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.arm cannot be set twice.");
                  }
                  _loc15_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 25:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.cloth cannot be set twice.");
                  }
                  _loc34_++;
                  cloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 26:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.wing cannot be set twice.");
                  }
                  _loc18_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 27:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.hat cannot be set twice.");
                  }
                  _loc3_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 28:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.hideFashion cannot be set twice.");
                  }
                  _loc32_++;
                  hideFashion = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 29:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.fashionArm cannot be set twice.");
                  }
                  _loc20_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 30:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.fashionCloth cannot be set twice.");
                  }
                  _loc4_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 31:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.isDragonTalker cannot be set twice.");
                  }
                  _loc10_++;
                  isDragonTalker = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 32:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MirrorInfoMsg.battleBeastId cannot be set twice.");
                  }
                  _loc9_++;
                  battleBeastId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

