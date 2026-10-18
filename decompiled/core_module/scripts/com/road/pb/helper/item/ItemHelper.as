package com.road.pb.helper.item
{
   import com.road.yishi.proto.chat.ChatItemInfoMsg;
   import com.road.yishi.proto.item.ItemInfoMsg;
   import com.road.yishi.proto.simple.SimpleItemInfoMsg;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.DateFormatter;
   
   public class ItemHelper
   {
      
      public function ItemHelper()
      {
         super();
      }
      
      public static function readGoodsInfo(param1:ItemInfoMsg, param2:GoodsInfo) : GoodsInfo
      {
         if(!param1)
         {
            return param2;
         }
         param2.userId = param1.userId;
         param2.id = param1.id;
         param2.templateId = param1.templateId;
         param2.pos = param1.pos;
         param2.isExist = param1.exist;
         param2.objectId = param1.objectId;
         param2.bagType = param1.bagType;
         param2.isBinds = param1.bind;
         param2.isUsed = param1.used;
         param2.validDate = param1.validDate;
         param2.beginDate = DateFormatter.parse(param1.beginDate,"YYYY-MM-DD hh:mm:ss");
         param2.count = param1.count;
         param2.strengthenGrade = param1.strengthenGrade;
         param2.attack = param1.attack;
         param2.defence = param1.defence;
         param2.agility = param1.agility;
         param2.intellect = param1.ability;
         param2.captain = param1.captain;
         param2.join1 = param1.join_1;
         param2.join2 = param1.join_2;
         param2.join3 = param1.join_3;
         param2.join4 = param1.join_4;
         param2.randomSkill1 = param1.randomSkill_1;
         param2.randomSkill2 = param1.randomSkill_2;
         param2.randomSkill3 = param1.randomSkill_3;
         param2.randomSkill4 = param1.randomSkill_4;
         param2.randomSkill5 = param1.randomSkill_5;
         param2.mouldGrade = param1.mouldGrade;
         param2.blessValue = param1.blessValue;
         param2.strBlessValue = param1.strBlessValue;
         param2.isNew = param1.isNew;
         param2.property1 = param1.property1;
         param2.appraisal_skill = param1.appraisalSkill;
         param2.isLock = param1.isLocked;
         param2.descTemplateId = param1.descTemplateId;
         if(param1.hasUsedTimes)
         {
            param2.usedTimes = param1.usedTimes;
         }
         if(param1.hasIsTodayUsed)
         {
            param2.isTodayUsed = param1.isTodayUsed;
         }
         return param2;
      }
      
      public static function readGoodsInfo2(param1:SimpleItemInfoMsg, param2:GoodsInfo) : GoodsInfo
      {
         if(!param1)
         {
            return param2;
         }
         param2.id = param1.id;
         param2.userId = param1.userId;
         param2.bagType = param1.bagType;
         param2.objectId = param1.objectId;
         param2.pos = param1.pos;
         param2.templateId = param1.templateId;
         param2.isBinds = param1.bind;
         param2.count = param1.count;
         param2.strengthenGrade = param1.strengthenGrade;
         param2.join1 = param1.join_1;
         param2.join2 = param1.join_2;
         param2.join3 = param1.join_3;
         param2.join4 = param1.join_4;
         param2.randomSkill1 = param1.randomSkill_1;
         param2.randomSkill2 = param1.randomSkill_2;
         param2.randomSkill3 = param1.randomSkill_3;
         param2.randomSkill4 = param1.randomSkill_4;
         param2.randomSkill5 = param1.randomSkill_5;
         param2.mouldGrade = param1.mouldGrade;
         param2.property1 = param1.property1;
         param2.appraisal_skill = param1.appraisalSkill;
         param2.isLock = param1.isLocked;
         param2.descTemplateId = param1.descTemplateId;
         if(param1.hasLifeSkill)
         {
            param2.enchantSkillId = param1.lifeSkill;
         }
         return param2;
      }
      
      public static function createChatItemInfoMsg(param1:GoodsInfo, param2:String) : ChatItemInfoMsg
      {
         var _loc3_:ChatItemInfoMsg = new ChatItemInfoMsg();
         _loc3_.id = param1.id;
         _loc3_.templateId = param1.templateId;
         _loc3_.itemName = param2;
         _loc3_.strengthenGrade = param1.strengthenGrade;
         _loc3_.bind = param1.isBinds;
         _loc3_.join_1 = param1.join1;
         _loc3_.join_2 = param1.join2;
         _loc3_.join_3 = param1.join3;
         _loc3_.join_4 = param1.join4;
         _loc3_.randomSkill_1 = param1.randomSkill1;
         _loc3_.randomSkill_2 = param1.randomSkill2;
         _loc3_.randomSkill_3 = param1.randomSkill3;
         _loc3_.randomSkill_4 = param1.randomSkill4;
         _loc3_.randomSkill_5 = param1.randomSkill5;
         _loc3_.mouldGrade = param1.mouldGrade;
         _loc3_.property1 = param1.property1;
         _loc3_.appraisalSkill = param1.appraisalSkill;
         return _loc3_;
      }
   }
}

