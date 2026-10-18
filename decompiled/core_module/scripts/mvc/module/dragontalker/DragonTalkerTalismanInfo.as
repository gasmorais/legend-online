package mvc.module.dragontalker
{
   import managers.DragonTalkerManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.SuiteTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class DragonTalkerTalismanInfo
   {
      
      public var id:int;
      
      public var pos:int;
      
      public var equipPos:int;
      
      public var isExist:Boolean;
      
      public var grade:int;
      
      public var exp:int;
      
      public var randomSkillList:Array;
      
      public var newSkillId:int;
      
      public var oldSkillIndex:int;
      
      public var isNew:Boolean;
      
      public var isSelf:Boolean = true;
      
      private var _tempId:int;
      
      private var _count:int;
      
      private var _goodInfo:GoodsInfo;
      
      public function DragonTalkerTalismanInfo()
      {
         super();
      }
      
      public function get goodsTempInfo() : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(tempId);
      }
      
      public function get suitTempInfo() : SuiteTempInfo
      {
         if(!goodsTempInfo)
         {
            return null;
         }
         return TempleteManager.instance.suitTemplateCate.getTemplateByID(goodsTempInfo.SuiteId);
      }
      
      public function get isEquip() : Boolean
      {
         return equipPos != 0;
      }
      
      public function get isExpType() : Boolean
      {
         if(!goodsTempInfo)
         {
            return false;
         }
         return goodsTempInfo.SonType == 407;
      }
      
      public function get leftExp() : int
      {
         var _loc1_:UpgradeTemplateInfo = model.talismanUpgradeArr[grade];
         return exp - _loc1_.Data > 0 ? exp - _loc1_.Data : 0;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      public function get hasSkillCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:int in randomSkillList)
         {
            if(_loc1_ > 0)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function get specialPercent() : int
      {
         var _loc2_:int = int(randomSkillList.length);
         var _loc1_:int = int(randomSkillList[_loc2_ - 1]);
         var _loc3_:SkillTempInfo = TempleteManager.instance.skillTemplateDic[_loc1_];
         if(_loc3_ && _loc3_.SonType == 435)
         {
            return _loc3_.Parameter1;
         }
         return 0;
      }
      
      public function get specialColor() : int
      {
         var _loc2_:int = int(randomSkillList.length);
         var _loc1_:int = int(randomSkillList[_loc2_ - 1]);
         var _loc3_:SkillTempInfo = TempleteManager.instance.skillTemplateDic[_loc1_];
         if(_loc3_ && _loc3_.SonType == 435)
         {
            return _loc3_.Grades;
         }
         return 0;
      }
      
      public function get tempId() : int
      {
         return _tempId;
      }
      
      public function set tempId(param1:int) : void
      {
         if(_tempId == param1)
         {
            return;
         }
         _tempId = param1;
         _goodInfo = new GoodsInfo();
         _goodInfo.templateId = _tempId;
         _goodInfo.dragonTalkerEquipId = id;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
         if(_goodInfo)
         {
            _goodInfo.count = _count;
         }
      }
      
      public function get goodInfo() : GoodsInfo
      {
         return _goodInfo;
      }
   }
}

