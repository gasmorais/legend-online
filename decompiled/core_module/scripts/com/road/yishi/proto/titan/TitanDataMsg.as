package com.road.yishi.proto.titan
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TitanDataMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var starExp$field:int;
      
      private var starLevel$field:int;
      
      [ArrayElementType("int")]
      public var devourTitan:Array = [];
      
      private var attack$field:int;
      
      private var defence$field:int;
      
      private var magicAttack$field:int;
      
      private var magicDefence$field:int;
      
      private var live$field:int;
      
      private var forceHit$field:int;
      
      private var parry$field:int;
      
      private var strength$field:int;
      
      private var tenacity$field:int;
      
      private var reduceResi$field:int;
      
      private var fireResi$field:int;
      
      private var waterResi$field:int;
      
      private var electResi$field:int;
      
      private var windResi$field:int;
      
      private var darkResi$field:int;
      
      private var lightResi$field:int;
      
      private var penetrate$field:int;
      
      private var stunAttr$field:int;
      
      private var useSkillIndex$field:int;
      
      [ArrayElementType("int")]
      public var skillId0:Array = [];
      
      [ArrayElementType("int")]
      public var skillId1:Array = [];
      
      [ArrayElementType("int")]
      public var skillId2:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.titan.TitanInjectMsg")]
      public var injectData:Array = [];
      
      private var injectGrade$field:int;
      
      private var injectCount$field:int;
      
      private var chargeGrade$field:int;
      
      private var reduceResiGp$field:int;
      
      private var fireResiGp$field:int;
      
      private var waterResiGp$field:int;
      
      private var electResiGp$field:int;
      
      private var windResiGp$field:int;
      
      private var darkResiGp$field:int;
      
      private var lightResiGp$field:int;
      
      private var hasField$1:uint = 0;
      
      public function TitanDataMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
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
      
      public function removeStarExp() : void
      {
         hasField$0 &= 4294967291;
         starExp$field = new int();
      }
      
      public function get hasStarExp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set starExp(param1:int) : void
      {
         hasField$0 |= 4;
         starExp$field = param1;
      }
      
      public function get starExp() : int
      {
         return starExp$field;
      }
      
      public function removeStarLevel() : void
      {
         hasField$0 &= 4294967287;
         starLevel$field = new int();
      }
      
      public function get hasStarLevel() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set starLevel(param1:int) : void
      {
         hasField$0 |= 8;
         starLevel$field = param1;
      }
      
      public function get starLevel() : int
      {
         return starLevel$field;
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967279;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 16;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeDefence() : void
      {
         hasField$0 &= 4294967263;
         defence$field = new int();
      }
      
      public function get hasDefence() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set defence(param1:int) : void
      {
         hasField$0 |= 32;
         defence$field = param1;
      }
      
      public function get defence() : int
      {
         return defence$field;
      }
      
      public function removeMagicAttack() : void
      {
         hasField$0 &= 4294967231;
         magicAttack$field = new int();
      }
      
      public function get hasMagicAttack() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set magicAttack(param1:int) : void
      {
         hasField$0 |= 64;
         magicAttack$field = param1;
      }
      
      public function get magicAttack() : int
      {
         return magicAttack$field;
      }
      
      public function removeMagicDefence() : void
      {
         hasField$0 &= 4294967167;
         magicDefence$field = new int();
      }
      
      public function get hasMagicDefence() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set magicDefence(param1:int) : void
      {
         hasField$0 |= 128;
         magicDefence$field = param1;
      }
      
      public function get magicDefence() : int
      {
         return magicDefence$field;
      }
      
      public function removeLive() : void
      {
         hasField$0 &= 4294967039;
         live$field = new int();
      }
      
      public function get hasLive() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set live(param1:int) : void
      {
         hasField$0 |= 256;
         live$field = param1;
      }
      
      public function get live() : int
      {
         return live$field;
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
      
      public function removeParry() : void
      {
         hasField$0 &= 4294966271;
         parry$field = new int();
      }
      
      public function get hasParry() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set parry(param1:int) : void
      {
         hasField$0 |= 1024;
         parry$field = param1;
      }
      
      public function get parry() : int
      {
         return parry$field;
      }
      
      public function removeStrength() : void
      {
         hasField$0 &= 4294965247;
         strength$field = new int();
      }
      
      public function get hasStrength() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set strength(param1:int) : void
      {
         hasField$0 |= 2048;
         strength$field = param1;
      }
      
      public function get strength() : int
      {
         return strength$field;
      }
      
      public function removeTenacity() : void
      {
         hasField$0 &= 4294963199;
         tenacity$field = new int();
      }
      
      public function get hasTenacity() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set tenacity(param1:int) : void
      {
         hasField$0 |= 4096;
         tenacity$field = param1;
      }
      
      public function get tenacity() : int
      {
         return tenacity$field;
      }
      
      public function removeReduceResi() : void
      {
         hasField$0 &= 4294959103;
         reduceResi$field = new int();
      }
      
      public function get hasReduceResi() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set reduceResi(param1:int) : void
      {
         hasField$0 |= 8192;
         reduceResi$field = param1;
      }
      
      public function get reduceResi() : int
      {
         return reduceResi$field;
      }
      
      public function removeFireResi() : void
      {
         hasField$0 &= 4294950911;
         fireResi$field = new int();
      }
      
      public function get hasFireResi() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set fireResi(param1:int) : void
      {
         hasField$0 |= 16384;
         fireResi$field = param1;
      }
      
      public function get fireResi() : int
      {
         return fireResi$field;
      }
      
      public function removeWaterResi() : void
      {
         hasField$0 &= 4294934527;
         waterResi$field = new int();
      }
      
      public function get hasWaterResi() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set waterResi(param1:int) : void
      {
         hasField$0 |= 32768;
         waterResi$field = param1;
      }
      
      public function get waterResi() : int
      {
         return waterResi$field;
      }
      
      public function removeElectResi() : void
      {
         hasField$0 &= 4294901759;
         electResi$field = new int();
      }
      
      public function get hasElectResi() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set electResi(param1:int) : void
      {
         hasField$0 |= 65536;
         electResi$field = param1;
      }
      
      public function get electResi() : int
      {
         return electResi$field;
      }
      
      public function removeWindResi() : void
      {
         hasField$0 &= 4294836223;
         windResi$field = new int();
      }
      
      public function get hasWindResi() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set windResi(param1:int) : void
      {
         hasField$0 |= 131072;
         windResi$field = param1;
      }
      
      public function get windResi() : int
      {
         return windResi$field;
      }
      
      public function removeDarkResi() : void
      {
         hasField$0 &= 4294705151;
         darkResi$field = new int();
      }
      
      public function get hasDarkResi() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set darkResi(param1:int) : void
      {
         hasField$0 |= 262144;
         darkResi$field = param1;
      }
      
      public function get darkResi() : int
      {
         return darkResi$field;
      }
      
      public function removeLightResi() : void
      {
         hasField$0 &= 4294443007;
         lightResi$field = new int();
      }
      
      public function get hasLightResi() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set lightResi(param1:int) : void
      {
         hasField$0 |= 524288;
         lightResi$field = param1;
      }
      
      public function get lightResi() : int
      {
         return lightResi$field;
      }
      
      public function removePenetrate() : void
      {
         hasField$0 &= 4293918719;
         penetrate$field = new int();
      }
      
      public function get hasPenetrate() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set penetrate(param1:int) : void
      {
         hasField$0 |= 1048576;
         penetrate$field = param1;
      }
      
      public function get penetrate() : int
      {
         return penetrate$field;
      }
      
      public function removeStunAttr() : void
      {
         hasField$0 &= 4292870143;
         stunAttr$field = new int();
      }
      
      public function get hasStunAttr() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set stunAttr(param1:int) : void
      {
         hasField$0 |= 2097152;
         stunAttr$field = param1;
      }
      
      public function get stunAttr() : int
      {
         return stunAttr$field;
      }
      
      public function removeUseSkillIndex() : void
      {
         hasField$0 &= 4290772991;
         useSkillIndex$field = new int();
      }
      
      public function get hasUseSkillIndex() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set useSkillIndex(param1:int) : void
      {
         hasField$0 |= 4194304;
         useSkillIndex$field = param1;
      }
      
      public function get useSkillIndex() : int
      {
         return useSkillIndex$field;
      }
      
      public function removeInjectGrade() : void
      {
         hasField$0 &= 4286578687;
         injectGrade$field = new int();
      }
      
      public function get hasInjectGrade() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set injectGrade(param1:int) : void
      {
         hasField$0 |= 8388608;
         injectGrade$field = param1;
      }
      
      public function get injectGrade() : int
      {
         return injectGrade$field;
      }
      
      public function removeInjectCount() : void
      {
         hasField$0 &= 4278190079;
         injectCount$field = new int();
      }
      
      public function get hasInjectCount() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set injectCount(param1:int) : void
      {
         hasField$0 |= 16777216;
         injectCount$field = param1;
      }
      
      public function get injectCount() : int
      {
         return injectCount$field;
      }
      
      public function removeChargeGrade() : void
      {
         hasField$0 &= 4261412863;
         chargeGrade$field = new int();
      }
      
      public function get hasChargeGrade() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set chargeGrade(param1:int) : void
      {
         hasField$0 |= 33554432;
         chargeGrade$field = param1;
      }
      
      public function get chargeGrade() : int
      {
         return chargeGrade$field;
      }
      
      public function removeReduceResiGp() : void
      {
         hasField$0 &= 4227858431;
         reduceResiGp$field = new int();
      }
      
      public function get hasReduceResiGp() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set reduceResiGp(param1:int) : void
      {
         hasField$0 |= 67108864;
         reduceResiGp$field = param1;
      }
      
      public function get reduceResiGp() : int
      {
         return reduceResiGp$field;
      }
      
      public function removeFireResiGp() : void
      {
         hasField$0 &= 4160749567;
         fireResiGp$field = new int();
      }
      
      public function get hasFireResiGp() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set fireResiGp(param1:int) : void
      {
         hasField$0 |= 134217728;
         fireResiGp$field = param1;
      }
      
      public function get fireResiGp() : int
      {
         return fireResiGp$field;
      }
      
      public function removeWaterResiGp() : void
      {
         hasField$0 &= 4026531839;
         waterResiGp$field = new int();
      }
      
      public function get hasWaterResiGp() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set waterResiGp(param1:int) : void
      {
         hasField$0 |= 268435456;
         waterResiGp$field = param1;
      }
      
      public function get waterResiGp() : int
      {
         return waterResiGp$field;
      }
      
      public function removeElectResiGp() : void
      {
         hasField$0 &= 3758096383;
         electResiGp$field = new int();
      }
      
      public function get hasElectResiGp() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set electResiGp(param1:int) : void
      {
         hasField$0 |= 536870912;
         electResiGp$field = param1;
      }
      
      public function get electResiGp() : int
      {
         return electResiGp$field;
      }
      
      public function removeWindResiGp() : void
      {
         hasField$0 &= 3221225471;
         windResiGp$field = new int();
      }
      
      public function get hasWindResiGp() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set windResiGp(param1:int) : void
      {
         hasField$0 |= 1073741824;
         windResiGp$field = param1;
      }
      
      public function get windResiGp() : int
      {
         return windResiGp$field;
      }
      
      public function removeDarkResiGp() : void
      {
         hasField$0 &= 2147483647;
         darkResiGp$field = new int();
      }
      
      public function get hasDarkResiGp() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set darkResiGp(param1:int) : void
      {
         hasField$0 |= 2147483648;
         darkResiGp$field = param1;
      }
      
      public function get darkResiGp() : int
      {
         return darkResiGp$field;
      }
      
      public function removeLightResiGp() : void
      {
         hasField$1 &= 4294967294;
         lightResiGp$field = new int();
      }
      
      public function get hasLightResiGp() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set lightResiGp(param1:int) : void
      {
         hasField$1 |= 1;
         lightResiGp$field = param1;
      }
      
      public function get lightResiGp() : int
      {
         return lightResiGp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasStarExp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,starExp$field);
         }
         if(hasStarLevel)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,starLevel$field);
         }
         _loc3_ = 0;
         while(_loc3_ < devourTitan.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,devourTitan[_loc3_]);
            _loc3_++;
         }
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasDefence)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,defence$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,magicAttack$field);
         }
         if(hasMagicDefence)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,magicDefence$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
         if(hasForceHit)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,forceHit$field);
         }
         if(hasParry)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,parry$field);
         }
         if(hasStrength)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,strength$field);
         }
         if(hasTenacity)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,tenacity$field);
         }
         if(hasReduceResi)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,reduceResi$field);
         }
         if(hasFireResi)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,fireResi$field);
         }
         if(hasWaterResi)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,waterResi$field);
         }
         if(hasElectResi)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,electResi$field);
         }
         if(hasWindResi)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,windResi$field);
         }
         if(hasDarkResi)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,darkResi$field);
         }
         if(hasLightResi)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,lightResi$field);
         }
         if(hasPenetrate)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,penetrate$field);
         }
         if(hasStunAttr)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,stunAttr$field);
         }
         if(hasUseSkillIndex)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,useSkillIndex$field);
         }
         _loc4_ = 0;
         while(_loc4_ < skillId0.length)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,skillId0[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < skillId1.length)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,skillId1[_loc2_]);
            _loc2_++;
         }
         _loc6_ = 0;
         while(_loc6_ < skillId2.length)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,skillId2[_loc6_]);
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ < injectData.length)
         {
            WriteUtils.writeTag(param1,2,28);
            WriteUtils.write$TYPE_MESSAGE(param1,injectData[_loc5_]);
            _loc5_++;
         }
         if(hasInjectGrade)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,injectGrade$field);
         }
         if(hasInjectCount)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,injectCount$field);
         }
         if(hasChargeGrade)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,chargeGrade$field);
         }
         if(hasReduceResiGp)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_INT32(param1,reduceResiGp$field);
         }
         if(hasFireResiGp)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_INT32(param1,fireResiGp$field);
         }
         if(hasWaterResiGp)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_INT32(param1,waterResiGp$field);
         }
         if(hasElectResiGp)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,electResiGp$field);
         }
         if(hasWindResiGp)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,windResiGp$field);
         }
         if(hasDarkResiGp)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_INT32(param1,darkResiGp$field);
         }
         if(hasLightResiGp)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_INT32(param1,lightResiGp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc35_:TitanInjectMsg = null;
         var _loc24_:uint = 0;
         var _loc20_:uint = 0;
         var _loc7_:uint = 0;
         var _loc30_:uint = 0;
         var _loc33_:uint = 0;
         var _loc37_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc9_:uint = 0;
         var _loc19_:uint = 0;
         var _loc13_:uint = 0;
         var _loc32_:uint = 0;
         var _loc26_:uint = 0;
         var _loc8_:uint = 0;
         var _loc23_:uint = 0;
         var _loc27_:uint = 0;
         var _loc34_:uint = 0;
         var _loc28_:uint = 0;
         var _loc18_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc29_:uint = 0;
         var _loc21_:uint = 0;
         var _loc36_:uint = 0;
         var _loc22_:uint = 0;
         var _loc31_:uint = 0;
         var _loc25_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc17_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.userId cannot be set twice.");
                  }
                  _loc24_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.templateId cannot be set twice.");
                  }
                  _loc20_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.starExp cannot be set twice.");
                  }
                  _loc7_++;
                  starExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.starLevel cannot be set twice.");
                  }
                  _loc30_++;
                  starLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if((_loc15_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,devourTitan);
                  }
                  else
                  {
                     devourTitan.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.attack cannot be set twice.");
                  }
                  _loc33_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.defence cannot be set twice.");
                  }
                  _loc37_++;
                  defence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.magicAttack cannot be set twice.");
                  }
                  _loc12_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.magicDefence cannot be set twice.");
                  }
                  _loc16_++;
                  magicDefence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.live cannot be set twice.");
                  }
                  _loc9_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.forceHit cannot be set twice.");
                  }
                  _loc19_++;
                  forceHit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.parry cannot be set twice.");
                  }
                  _loc13_++;
                  parry = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.strength cannot be set twice.");
                  }
                  _loc32_++;
                  strength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.tenacity cannot be set twice.");
                  }
                  _loc26_++;
                  tenacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.reduceResi cannot be set twice.");
                  }
                  _loc8_++;
                  reduceResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.fireResi cannot be set twice.");
                  }
                  _loc23_++;
                  fireResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.waterResi cannot be set twice.");
                  }
                  _loc27_++;
                  waterResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.electResi cannot be set twice.");
                  }
                  _loc34_++;
                  electResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.windResi cannot be set twice.");
                  }
                  _loc28_++;
                  windResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.darkResi cannot be set twice.");
                  }
                  _loc18_++;
                  darkResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.lightResi cannot be set twice.");
                  }
                  _loc11_++;
                  lightResi = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.penetrate cannot be set twice.");
                  }
                  _loc6_++;
                  penetrate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.stunAttr cannot be set twice.");
                  }
                  _loc29_++;
                  stunAttr = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.useSkillIndex cannot be set twice.");
                  }
                  _loc21_++;
                  useSkillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if((_loc15_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,skillId0);
                  }
                  else
                  {
                     skillId0.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 26:
                  if((_loc15_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,skillId1);
                  }
                  else
                  {
                     skillId1.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 27:
                  if((_loc15_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,skillId2);
                  }
                  else
                  {
                     skillId2.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 28:
                  _loc35_ = new TitanInjectMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc35_);
                  injectData.push(_loc35_);
                  break;
               case 29:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.injectGrade cannot be set twice.");
                  }
                  _loc36_++;
                  injectGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.injectCount cannot be set twice.");
                  }
                  _loc22_++;
                  injectCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.chargeGrade cannot be set twice.");
                  }
                  _loc31_++;
                  chargeGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 32:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.reduceResiGp cannot be set twice.");
                  }
                  _loc25_++;
                  reduceResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 33:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.fireResiGp cannot be set twice.");
                  }
                  _loc10_++;
                  fireResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 34:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.waterResiGp cannot be set twice.");
                  }
                  _loc3_++;
                  waterResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 35:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.electResiGp cannot be set twice.");
                  }
                  _loc14_++;
                  electResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 36:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.windResiGp cannot be set twice.");
                  }
                  _loc17_++;
                  windResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 37:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.darkResiGp cannot be set twice.");
                  }
                  _loc5_++;
                  darkResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 38:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TitanDataMsg.lightResiGp cannot be set twice.");
                  }
                  _loc4_++;
                  lightResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

