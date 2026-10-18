package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimpleItemInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var template_id$field:int;
      
      private var pos$field:int;
      
      private var exist$field:Boolean;
      
      private var object_id$field:int;
      
      private var bag_type$field:int;
      
      private var bind$field:Boolean;
      
      private var used$field:Boolean;
      
      private var valid_date$field:int;
      
      private var begin_date$field:String;
      
      private var count$field:int;
      
      private var attack$field:int;
      
      private var defence$field:int;
      
      private var agility$field:int;
      
      private var ability$field:int;
      
      private var captain$field:int;
      
      private var strengthen_grade$field:int;
      
      private var join_1$field:int;
      
      private var join_2$field:int;
      
      private var join_3$field:int;
      
      private var join_4$field:int;
      
      private var random_skill_1$field:int;
      
      private var random_skill_2$field:int;
      
      private var random_skill_3$field:int;
      
      private var random_skill_4$field:int;
      
      private var random_skill_5$field:int;
      
      private var is_new$field:Boolean;
      
      private var user_id$field:int;
      
      private var is_show$field:Boolean;
      
      private var is_new_items$field:Boolean;
      
      private var property1$field:String;
      
      private var strength$field:int;
      
      private var tenacity$field:int;
      
      private var mould_grade$field:int;
      
      private var appraisal_skill$field:int;
      
      private var hasField$1:uint = 0;
      
      private var is_locked$field:Boolean;
      
      private var desc_templateId$field:int;
      
      private var life_skill$field:int;
      
      public function SimpleItemInfoMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967291;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 4;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeExist() : void
      {
         hasField$0 &= 4294967287;
         exist$field = new Boolean();
      }
      
      public function get hasExist() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set exist(param1:Boolean) : void
      {
         hasField$0 |= 8;
         exist$field = param1;
      }
      
      public function get exist() : Boolean
      {
         return exist$field;
      }
      
      public function removeObjectId() : void
      {
         hasField$0 &= 4294967279;
         object_id$field = new int();
      }
      
      public function get hasObjectId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set objectId(param1:int) : void
      {
         hasField$0 |= 16;
         object_id$field = param1;
      }
      
      public function get objectId() : int
      {
         return object_id$field;
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967263;
         bag_type$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 32;
         bag_type$field = param1;
      }
      
      public function get bagType() : int
      {
         return bag_type$field;
      }
      
      public function removeBind() : void
      {
         hasField$0 &= 4294967231;
         bind$field = new Boolean();
      }
      
      public function get hasBind() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set bind(param1:Boolean) : void
      {
         hasField$0 |= 64;
         bind$field = param1;
      }
      
      public function get bind() : Boolean
      {
         return bind$field;
      }
      
      public function removeUsed() : void
      {
         hasField$0 &= 4294967167;
         used$field = new Boolean();
      }
      
      public function get hasUsed() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set used(param1:Boolean) : void
      {
         hasField$0 |= 128;
         used$field = param1;
      }
      
      public function get used() : Boolean
      {
         return used$field;
      }
      
      public function removeValidDate() : void
      {
         hasField$0 &= 4294967039;
         valid_date$field = new int();
      }
      
      public function get hasValidDate() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set validDate(param1:int) : void
      {
         hasField$0 |= 256;
         valid_date$field = param1;
      }
      
      public function get validDate() : int
      {
         return valid_date$field;
      }
      
      public function removeBeginDate() : void
      {
         begin_date$field = null;
      }
      
      public function get hasBeginDate() : Boolean
      {
         return begin_date$field != null;
      }
      
      public function set beginDate(param1:String) : void
      {
         begin_date$field = param1;
      }
      
      public function get beginDate() : String
      {
         return begin_date$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294966783;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 512;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294966271;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 1024;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeDefence() : void
      {
         hasField$0 &= 4294965247;
         defence$field = new int();
      }
      
      public function get hasDefence() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set defence(param1:int) : void
      {
         hasField$0 |= 2048;
         defence$field = param1;
      }
      
      public function get defence() : int
      {
         return defence$field;
      }
      
      public function removeAgility() : void
      {
         hasField$0 &= 4294963199;
         agility$field = new int();
      }
      
      public function get hasAgility() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set agility(param1:int) : void
      {
         hasField$0 |= 4096;
         agility$field = param1;
      }
      
      public function get agility() : int
      {
         return agility$field;
      }
      
      public function removeAbility() : void
      {
         hasField$0 &= 4294959103;
         ability$field = new int();
      }
      
      public function get hasAbility() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set ability(param1:int) : void
      {
         hasField$0 |= 8192;
         ability$field = param1;
      }
      
      public function get ability() : int
      {
         return ability$field;
      }
      
      public function removeCaptain() : void
      {
         hasField$0 &= 4294950911;
         captain$field = new int();
      }
      
      public function get hasCaptain() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set captain(param1:int) : void
      {
         hasField$0 |= 16384;
         captain$field = param1;
      }
      
      public function get captain() : int
      {
         return captain$field;
      }
      
      public function removeStrengthenGrade() : void
      {
         hasField$0 &= 4294934527;
         strengthen_grade$field = new int();
      }
      
      public function get hasStrengthenGrade() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set strengthenGrade(param1:int) : void
      {
         hasField$0 |= 32768;
         strengthen_grade$field = param1;
      }
      
      public function get strengthenGrade() : int
      {
         return strengthen_grade$field;
      }
      
      public function removeJoin_1() : void
      {
         hasField$0 &= 4294901759;
         join_1$field = new int();
      }
      
      public function get hasJoin_1() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set join_1(param1:int) : void
      {
         hasField$0 |= 65536;
         join_1$field = param1;
      }
      
      public function get join_1() : int
      {
         return join_1$field;
      }
      
      public function removeJoin_2() : void
      {
         hasField$0 &= 4294836223;
         join_2$field = new int();
      }
      
      public function get hasJoin_2() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set join_2(param1:int) : void
      {
         hasField$0 |= 131072;
         join_2$field = param1;
      }
      
      public function get join_2() : int
      {
         return join_2$field;
      }
      
      public function removeJoin_3() : void
      {
         hasField$0 &= 4294705151;
         join_3$field = new int();
      }
      
      public function get hasJoin_3() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set join_3(param1:int) : void
      {
         hasField$0 |= 262144;
         join_3$field = param1;
      }
      
      public function get join_3() : int
      {
         return join_3$field;
      }
      
      public function removeJoin_4() : void
      {
         hasField$0 &= 4294443007;
         join_4$field = new int();
      }
      
      public function get hasJoin_4() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set join_4(param1:int) : void
      {
         hasField$0 |= 524288;
         join_4$field = param1;
      }
      
      public function get join_4() : int
      {
         return join_4$field;
      }
      
      public function removeRandomSkill_1() : void
      {
         hasField$0 &= 4293918719;
         random_skill_1$field = new int();
      }
      
      public function get hasRandomSkill_1() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set randomSkill_1(param1:int) : void
      {
         hasField$0 |= 1048576;
         random_skill_1$field = param1;
      }
      
      public function get randomSkill_1() : int
      {
         return random_skill_1$field;
      }
      
      public function removeRandomSkill_2() : void
      {
         hasField$0 &= 4292870143;
         random_skill_2$field = new int();
      }
      
      public function get hasRandomSkill_2() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set randomSkill_2(param1:int) : void
      {
         hasField$0 |= 2097152;
         random_skill_2$field = param1;
      }
      
      public function get randomSkill_2() : int
      {
         return random_skill_2$field;
      }
      
      public function removeRandomSkill_3() : void
      {
         hasField$0 &= 4290772991;
         random_skill_3$field = new int();
      }
      
      public function get hasRandomSkill_3() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set randomSkill_3(param1:int) : void
      {
         hasField$0 |= 4194304;
         random_skill_3$field = param1;
      }
      
      public function get randomSkill_3() : int
      {
         return random_skill_3$field;
      }
      
      public function removeRandomSkill_4() : void
      {
         hasField$0 &= 4286578687;
         random_skill_4$field = new int();
      }
      
      public function get hasRandomSkill_4() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set randomSkill_4(param1:int) : void
      {
         hasField$0 |= 8388608;
         random_skill_4$field = param1;
      }
      
      public function get randomSkill_4() : int
      {
         return random_skill_4$field;
      }
      
      public function removeRandomSkill_5() : void
      {
         hasField$0 &= 4278190079;
         random_skill_5$field = new int();
      }
      
      public function get hasRandomSkill_5() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set randomSkill_5(param1:int) : void
      {
         hasField$0 |= 16777216;
         random_skill_5$field = param1;
      }
      
      public function get randomSkill_5() : int
      {
         return random_skill_5$field;
      }
      
      public function removeIsNew() : void
      {
         hasField$0 &= 4261412863;
         is_new$field = new Boolean();
      }
      
      public function get hasIsNew() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set isNew(param1:Boolean) : void
      {
         hasField$0 |= 33554432;
         is_new$field = param1;
      }
      
      public function get isNew() : Boolean
      {
         return is_new$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4227858431;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 67108864;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeIsShow() : void
      {
         hasField$0 &= 4160749567;
         is_show$field = new Boolean();
      }
      
      public function get hasIsShow() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         hasField$0 |= 134217728;
         is_show$field = param1;
      }
      
      public function get isShow() : Boolean
      {
         return is_show$field;
      }
      
      public function removeIsNewItems() : void
      {
         hasField$0 &= 4026531839;
         is_new_items$field = new Boolean();
      }
      
      public function get hasIsNewItems() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set isNewItems(param1:Boolean) : void
      {
         hasField$0 |= 268435456;
         is_new_items$field = param1;
      }
      
      public function get isNewItems() : Boolean
      {
         return is_new_items$field;
      }
      
      public function removeProperty1() : void
      {
         property1$field = null;
      }
      
      public function get hasProperty1() : Boolean
      {
         return property1$field != null;
      }
      
      public function set property1(param1:String) : void
      {
         property1$field = param1;
      }
      
      public function get property1() : String
      {
         return property1$field;
      }
      
      public function removeStrength() : void
      {
         hasField$0 &= 3758096383;
         strength$field = new int();
      }
      
      public function get hasStrength() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set strength(param1:int) : void
      {
         hasField$0 |= 536870912;
         strength$field = param1;
      }
      
      public function get strength() : int
      {
         return strength$field;
      }
      
      public function removeTenacity() : void
      {
         hasField$0 &= 3221225471;
         tenacity$field = new int();
      }
      
      public function get hasTenacity() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set tenacity(param1:int) : void
      {
         hasField$0 |= 1073741824;
         tenacity$field = param1;
      }
      
      public function get tenacity() : int
      {
         return tenacity$field;
      }
      
      public function removeMouldGrade() : void
      {
         hasField$0 &= 2147483647;
         mould_grade$field = new int();
      }
      
      public function get hasMouldGrade() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set mouldGrade(param1:int) : void
      {
         hasField$0 |= 2147483648;
         mould_grade$field = param1;
      }
      
      public function get mouldGrade() : int
      {
         return mould_grade$field;
      }
      
      public function removeAppraisalSkill() : void
      {
         hasField$1 &= 4294967294;
         appraisal_skill$field = new int();
      }
      
      public function get hasAppraisalSkill() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set appraisalSkill(param1:int) : void
      {
         hasField$1 |= 1;
         appraisal_skill$field = param1;
      }
      
      public function get appraisalSkill() : int
      {
         return appraisal_skill$field;
      }
      
      public function removeIsLocked() : void
      {
         hasField$1 &= 4294967293;
         is_locked$field = new Boolean();
      }
      
      public function get hasIsLocked() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         hasField$1 |= 2;
         is_locked$field = param1;
      }
      
      public function get isLocked() : Boolean
      {
         return is_locked$field;
      }
      
      public function removeDescTemplateId() : void
      {
         hasField$1 &= 4294967291;
         desc_templateId$field = new int();
      }
      
      public function get hasDescTemplateId() : Boolean
      {
         return (hasField$1 & 4) != 0;
      }
      
      public function set descTemplateId(param1:int) : void
      {
         hasField$1 |= 4;
         desc_templateId$field = param1;
      }
      
      public function get descTemplateId() : int
      {
         return desc_templateId$field;
      }
      
      public function removeLifeSkill() : void
      {
         hasField$1 &= 4294967287;
         life_skill$field = new int();
      }
      
      public function get hasLifeSkill() : Boolean
      {
         return (hasField$1 & 8) != 0;
      }
      
      public function set lifeSkill(param1:int) : void
      {
         hasField$1 |= 8;
         life_skill$field = param1;
      }
      
      public function get lifeSkill() : int
      {
         return life_skill$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasExist)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,exist$field);
         }
         if(hasObjectId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,object_id$field);
         }
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,bag_type$field);
         }
         if(hasBind)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,bind$field);
         }
         if(hasUsed)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,used$field);
         }
         if(hasValidDate)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,valid_date$field);
         }
         if(hasBeginDate)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,begin_date$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasDefence)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,defence$field);
         }
         if(hasAgility)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,agility$field);
         }
         if(hasAbility)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,ability$field);
         }
         if(hasCaptain)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,captain$field);
         }
         if(hasStrengthenGrade)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,strengthen_grade$field);
         }
         if(hasJoin_1)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,join_1$field);
         }
         if(hasJoin_2)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,join_2$field);
         }
         if(hasJoin_3)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,join_3$field);
         }
         if(hasJoin_4)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,join_4$field);
         }
         if(hasRandomSkill_1)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,random_skill_1$field);
         }
         if(hasRandomSkill_2)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,random_skill_2$field);
         }
         if(hasRandomSkill_3)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,random_skill_3$field);
         }
         if(hasRandomSkill_4)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,random_skill_4$field);
         }
         if(hasRandomSkill_5)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,random_skill_5$field);
         }
         if(hasIsNew)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_BOOL(param1,is_new$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasIsShow)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_BOOL(param1,is_show$field);
         }
         if(hasIsNewItems)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_BOOL(param1,is_new_items$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,31);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
         if(hasStrength)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_INT32(param1,strength$field);
         }
         if(hasTenacity)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_INT32(param1,tenacity$field);
         }
         if(hasMouldGrade)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_INT32(param1,mould_grade$field);
         }
         if(hasAppraisalSkill)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,appraisal_skill$field);
         }
         if(hasIsLocked)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_BOOL(param1,is_locked$field);
         }
         if(hasDescTemplateId)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_INT32(param1,desc_templateId$field);
         }
         if(hasLifeSkill)
         {
            WriteUtils.writeTag(param1,0,38);
            WriteUtils.write$TYPE_INT32(param1,life_skill$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc20_:* = 0;
         var _loc28_:uint = 0;
         var _loc19_:uint = 0;
         var _loc29_:uint = 0;
         var _loc30_:uint = 0;
         var _loc15_:uint = 0;
         var _loc11_:uint = 0;
         var _loc21_:uint = 0;
         var _loc4_:uint = 0;
         var _loc40_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc39_:uint = 0;
         var _loc41_:uint = 0;
         var _loc16_:uint = 0;
         var _loc26_:uint = 0;
         var _loc12_:uint = 0;
         var _loc22_:uint = 0;
         var _loc35_:uint = 0;
         var _loc14_:uint = 0;
         var _loc10_:uint = 0;
         var _loc25_:uint = 0;
         var _loc31_:uint = 0;
         var _loc36_:uint = 0;
         var _loc24_:uint = 0;
         var _loc27_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc17_:uint = 0;
         var _loc32_:uint = 0;
         var _loc34_:uint = 0;
         var _loc37_:uint = 0;
         var _loc38_:uint = 0;
         var _loc33_:uint = 0;
         var _loc6_:uint = 0;
         var _loc18_:uint = 0;
         var _loc23_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc20_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.id cannot be set twice.");
                  }
                  _loc28_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.templateId cannot be set twice.");
                  }
                  _loc19_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.pos cannot be set twice.");
                  }
                  _loc29_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.exist cannot be set twice.");
                  }
                  _loc30_++;
                  exist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.objectId cannot be set twice.");
                  }
                  _loc15_++;
                  objectId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.bagType cannot be set twice.");
                  }
                  _loc11_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.bind cannot be set twice.");
                  }
                  _loc21_++;
                  bind = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.used cannot be set twice.");
                  }
                  _loc4_++;
                  used = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc40_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.validDate cannot be set twice.");
                  }
                  _loc40_++;
                  validDate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.beginDate cannot be set twice.");
                  }
                  _loc9_++;
                  beginDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.attack cannot be set twice.");
                  }
                  _loc39_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc41_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.defence cannot be set twice.");
                  }
                  _loc41_++;
                  defence = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.agility cannot be set twice.");
                  }
                  _loc16_++;
                  agility = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.ability cannot be set twice.");
                  }
                  _loc26_++;
                  ability = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.captain cannot be set twice.");
                  }
                  _loc12_++;
                  captain = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.strengthenGrade cannot be set twice.");
                  }
                  _loc22_++;
                  strengthenGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.join_1 cannot be set twice.");
                  }
                  _loc35_++;
                  join_1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.join_2 cannot be set twice.");
                  }
                  _loc14_++;
                  join_2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.join_3 cannot be set twice.");
                  }
                  _loc10_++;
                  join_3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.join_4 cannot be set twice.");
                  }
                  _loc25_++;
                  join_4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.randomSkill_1 cannot be set twice.");
                  }
                  _loc31_++;
                  randomSkill_1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.randomSkill_2 cannot be set twice.");
                  }
                  _loc36_++;
                  randomSkill_2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.randomSkill_3 cannot be set twice.");
                  }
                  _loc24_++;
                  randomSkill_3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.randomSkill_4 cannot be set twice.");
                  }
                  _loc27_++;
                  randomSkill_4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.randomSkill_5 cannot be set twice.");
                  }
                  _loc3_++;
                  randomSkill_5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.isNew cannot be set twice.");
                  }
                  _loc8_++;
                  isNew = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 28:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.userId cannot be set twice.");
                  }
                  _loc17_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.isShow cannot be set twice.");
                  }
                  _loc32_++;
                  isShow = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 30:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.isNewItems cannot be set twice.");
                  }
                  _loc34_++;
                  isNewItems = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 31:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.property1 cannot be set twice.");
                  }
                  _loc37_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 32:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.strength cannot be set twice.");
                  }
                  _loc38_++;
                  strength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 33:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.tenacity cannot be set twice.");
                  }
                  _loc33_++;
                  tenacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 34:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.mouldGrade cannot be set twice.");
                  }
                  _loc6_++;
                  mouldGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 35:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.appraisalSkill cannot be set twice.");
                  }
                  _loc18_++;
                  appraisalSkill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 36:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.isLocked cannot be set twice.");
                  }
                  _loc23_++;
                  isLocked = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 37:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.descTemplateId cannot be set twice.");
                  }
                  _loc13_++;
                  descTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 38:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleItemInfoMsg.lifeSkill cannot be set twice.");
                  }
                  _loc7_++;
                  lifeSkill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc20_ & 7);
            }
         }
      }
   }
}

