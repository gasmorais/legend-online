package yishi.datas.goods
{
   import bag.BaseBagListManager;
   import mvc.module.pet.PetData;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public dynamic class GoodsInfo
   {
      
      public var id:int;
      
      public var templateId:int;
      
      public var userId:int;
      
      public var pos:int;
      
      public var isExist:Boolean;
      
      public var objectId:int;
      
      public var bagType:int;
      
      public var isBinds:Boolean;
      
      public var isUsed:Boolean;
      
      public var isNew:Boolean;
      
      public var validDate:int;
      
      public var beginDate:Date = new Date(2000,1,1,0,0,0,0);
      
      public var count:int;
      
      public var marketPrice:int;
      
      public var willSellCount:int;
      
      public var strengthenGrade:int;
      
      public var join1:int = -1;
      
      public var join2:int = -1;
      
      public var join3:int = -1;
      
      public var join4:int = -1;
      
      public var randomSkill1:int;
      
      public var randomSkill2:int;
      
      public var randomSkill3:int;
      
      public var randomSkill4:int;
      
      public var randomSkill5:int;
      
      public var blessValue:int;
      
      public var strBlessValue:int;
      
      public var descTemplateId:int;
      
      public var suitCount:int;
      
      public var jewelGrade:int;
      
      public var showCount:Boolean;
      
      public var appraisal_skill:int = 0;
      
      public var showHasGet:Boolean = false;
      
      private var _property1:String = null;
      
      public var usedTimes:int;
      
      public var isTodayUsed:Boolean;
      
      private var _mouldGrade:int;
      
      private var _mouldRank:int;
      
      private var _mouldStar:int;
      
      public var petData:PetData;
      
      public var isLock:Boolean;
      
      public function GoodsInfo()
      {
         super();
      }
      
      public function get property1() : String
      {
         return _property1;
      }
      
      public function set property1(param1:String) : void
      {
         if(_property1 == param1)
         {
            return;
         }
         _property1 = param1;
         if(param1 == "1")
         {
            return;
         }
         petData = PetData.createWidthString(param1);
      }
      
      public function set mouldGrade(param1:int) : void
      {
         _mouldGrade = param1;
         if(_mouldGrade > 0)
         {
            _mouldRank = (_mouldGrade - 1) / 10 + 1;
            _mouldStar = _mouldGrade % 10;
            if(_mouldStar == 0)
            {
               _mouldStar = 10;
            }
         }
         else
         {
            _mouldRank = 0;
            _mouldStar = 0;
         }
      }
      
      public function get mouldGrade() : int
      {
         return _mouldGrade;
      }
      
      public function get mouldRankShow() : int
      {
         if(_mouldRank > 8 && _mouldRank <= 16)
         {
            return _mouldRank - 8;
         }
         if(_mouldRank > 16)
         {
            return _mouldRank - 16;
         }
         return _mouldRank;
      }
      
      public function get mouldRank() : int
      {
         return _mouldRank;
      }
      
      public function set mouldRank(param1:int) : void
      {
         _mouldRank = param1;
      }
      
      public function get mouldStar() : int
      {
         return _mouldStar;
      }
      
      public function set mouldStar(param1:int) : void
      {
         _mouldStar = param1;
      }
      
      public function get MOULD_NEED_MATERIAL1() : int
      {
         if(mouldGrade < 80)
         {
            return 2120100;
         }
         if(mouldGrade >= 80 && mouldGrade < 160)
         {
            return 2120102;
         }
         if(mouldGrade >= 160)
         {
            return 2120106;
         }
         return 0;
      }
      
      public function get MOULD_NEED_MATERIAL2() : int
      {
         if(mouldGrade < 80)
         {
            return 2120101;
         }
         if(mouldGrade >= 80 && mouldGrade < 160)
         {
            return 2120103;
         }
         if(mouldGrade >= 160)
         {
            return 2120107;
         }
         return 0;
      }
      
      public function get templateInfo() : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(templateId);
      }
      
      public function get descTemplateInfo() : GoodsTemplateInfo
      {
         if(descTemplateId != 0)
         {
            return TempleteManager.instance.goodsTemplateCate.getTemplateByID(descTemplateId);
         }
         return templateInfo;
      }
      
      public function get refreshProfile() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            if(this["randomSkill" + _loc2_] > 0)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get isUnrestrictedEquip() : Boolean
      {
         if(templateInfo && templateInfo.isUnrestrictedEquip)
         {
            return true;
         }
         return false;
      }
      
      public function get isSeniorEquip() : Boolean
      {
         if(templateInfo && templateInfo.isSeniorEquip)
         {
            return true;
         }
         return false;
      }
      
      public function get isSeniorEquipMaterial() : Boolean
      {
         if(templateInfo && templateInfo.StrengthenMax > 0 && templateInfo.Profile >= 5 && templateInfo.NeedGrades == 80)
         {
            return true;
         }
         return false;
      }
      
      public function get MOULD_MAX_RANK() : int
      {
         if(isSeniorEquip)
         {
            return 16;
         }
         if(isThreeEquip)
         {
            return 24;
         }
         return 8;
      }
      
      public function get MOULD_MAX_GRADE() : int
      {
         if(isSeniorEquip)
         {
            return 160;
         }
         if(isThreeEquip)
         {
            if(VersionSwitch.AVENGER_CAST_SUN)
            {
               return 240;
            }
            return 160;
         }
         return 80;
      }
      
      public function getMouldNeedCount(param1:int) : int
      {
         if(mouldGrade < 160)
         {
            return param1 == 1 ? 5 : 15;
         }
         if(mouldGrade < 180)
         {
            return 15;
         }
         if(mouldGrade < 200)
         {
            return 25;
         }
         if(mouldGrade < 220)
         {
            return 40;
         }
         return 60;
      }
      
      public function get isThreeEquip() : Boolean
      {
         if(templateInfo && templateInfo.isThreeEquip)
         {
            return true;
         }
         return false;
      }
      
      public function get leftTime() : Number
      {
         if(validDate == 0)
         {
            return -1;
         }
         return (validDate * 60 * 1000 - serverTime + beginDate.getTime()) / 1000;
      }
      
      public function existLessGradeJewel(param1:String) : Boolean
      {
         var _loc2_:* = null;
         if(join1 == 0)
         {
            return true;
         }
         if(join2 == 0)
         {
            return true;
         }
         if(join3 == 0)
         {
            return true;
         }
         return false;
      }
      
      public function existLessGradeJewel2(param1:String) : Boolean
      {
         var _loc2_:String = null;
         _loc2_ = join1.toString();
         if(checkLessGradeByType(_loc2_,param1))
         {
            return true;
         }
         _loc2_ = join2.toString();
         if(checkLessGradeByType(_loc2_,param1))
         {
            return true;
         }
         _loc2_ = join3.toString();
         if(checkLessGradeByType(_loc2_,param1))
         {
            return true;
         }
         return false;
      }
      
      private function checkLessGradeByType(param1:String, param2:String) : Boolean
      {
         if(int(param1.substr(param1.length - 4,2)) == int(param2.substr(param2.length - 4,2)) && int(param1.substr(param1.length - 2,2)) < int(param2.substr(param2.length - 2,2)))
         {
            return true;
         }
         return false;
      }
      
      public function existJewel() : Boolean
      {
         return join1 > 0 || join2 > 0 || join3 > 0 || join4 > 0;
      }
      
      public function get totalAttribute() : Number
      {
         return templateInfo.MagicAttack + templateInfo.Attack + templateInfo.MagicDefence + templateInfo.Defence + templateInfo.Conat + templateInfo.Live;
      }
      
      private function get serverTime() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
      }
      
      public function getEquipBaseScore() : int
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:GoodsTemplateInfo = templateInfo;
         var _loc3_:int = _loc1_.Attack + _loc1_.Defence + _loc1_.MagicAttack + _loc1_.MagicDefence + _loc1_.ForceHit + int(_loc1_.Live / 5) + _loc1_.Conat + (_loc1_.Power + _loc1_.Agility + _loc1_.Intellect) * 4 + (_loc1_.Captain + _loc1_.Physique) * 2;
         _loc3_ += getById(int(_loc1_.DefaultSkill));
         _loc5_ = 1;
         while(_loc5_ < 6)
         {
            _loc7_ = int(this["randomSkill" + _loc5_]);
            _loc3_ += getById(_loc7_);
            _loc5_++;
         }
         var _loc4_:String = _loc1_.DefaultSkill + ",";
         _loc5_ = 1;
         while(_loc5_ < 6)
         {
            _loc4_ += this["randomSkill" + _loc5_] + ",";
            _loc5_++;
         }
         var _loc2_:Array = TempleteManager.instance.getSkillTemplateInfoByIds(_loc4_);
         for each(var _loc6_:SkillTempInfo in _loc2_)
         {
            if(_loc6_)
            {
               _loc3_ += getById(_loc6_.TemplateId);
            }
         }
         return _loc3_;
      }
      
      public function getEquipAdditionScore() : int
      {
         var _loc3_:int = 0;
         var _loc1_:GoodsInfo = null;
         var _loc2_:GoodsTemplateInfo = templateInfo;
         _loc3_ = getStrengthenAddition(_loc2_.Attack) + getStrengthenAddition(_loc2_.Defence) + getStrengthenAddition(_loc2_.MagicAttack) + getStrengthenAddition(_loc2_.MagicDefence) + getStrengthenAddition(_loc2_.ForceHit) + int(getStrengthenAddition(_loc2_.Live) / 5) + getStrengthenAddition(_loc2_.Conat) + (getStrengthenAddition(_loc2_.Power) + getStrengthenAddition(_loc2_.Agility) + getStrengthenAddition(_loc2_.Intellect)) * 4 + (getStrengthenAddition(_loc2_.Captain) + getStrengthenAddition(_loc2_.Physique)) * 2;
         _loc3_ += getMouldAddition(_loc2_.Attack) + getMouldAddition(_loc2_.Defence) + getMouldAddition(_loc2_.MagicAttack) + getMouldAddition(_loc2_.MagicDefence) + getMouldAddition(_loc2_.ForceHit) + int(getMouldAddition(_loc2_.Live) / 5) + getMouldAddition(_loc2_.Conat) + (getMouldAddition(_loc2_.Power) + getMouldAddition(_loc2_.Agility) + getMouldAddition(_loc2_.Intellect)) * 4 + (getMouldAddition(_loc2_.Captain) + getMouldAddition(_loc2_.Physique)) * 2;
         if(join1 > 0)
         {
            _loc1_ = new GoodsInfo();
            _loc1_.templateId = join1;
            _loc3_ += _loc1_.getJewelScore();
         }
         if(join2 > 0)
         {
            _loc1_ = new GoodsInfo();
            _loc1_.templateId = join2;
            _loc3_ += _loc1_.getJewelScore();
         }
         if(join3 > 0)
         {
            _loc1_ = new GoodsInfo();
            _loc1_.templateId = join3;
            _loc3_ += _loc1_.getJewelScore();
         }
         return _loc3_;
      }
      
      public function getEquipTotalScore() : int
      {
         return getEquipBaseScore() + getEquipAdditionScore();
      }
      
      private function getStrengthenAddition(param1:int) : int
      {
         if(param1 == 0)
         {
            return 0;
         }
         return GoodsHelp.getStrengthenAddition(param1,strengthenGrade);
      }
      
      private function getMouldAddition(param1:int) : int
      {
         if(param1 == 0)
         {
            return 0;
         }
         return GoodsHelp.getMouldAddition(param1,mouldGrade);
      }
      
      private function getJewelScore() : int
      {
         var _loc1_:GoodsTemplateInfo = templateInfo;
         return int(_loc1_.Attack + _loc1_.Defence + _loc1_.MagicAttack + _loc1_.MagicDefence + _loc1_.ForceHit + int(_loc1_.Live / 5) + _loc1_.Conat + (_loc1_.Power + _loc1_.Agility + _loc1_.Intellect) * 4 + (_loc1_.Captain + _loc1_.Physique) * 2);
      }
      
      private function getById(param1:int) : int
      {
         var _loc3_:SkillPropertyTempInfo = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(param1);
         if(!_loc3_)
         {
            return 0;
         }
         return int(_loc3_.Attack + _loc3_.Defence + _loc3_.MagicAttack + _loc3_.MagicDefence + _loc3_.ForceHit + int(_loc3_.Live / 5) + _loc3_.Conat + (_loc3_.Power + _loc3_.Agility + _loc3_.Intellect) * 4 + (_loc3_.Captain + _loc3_.Physique) * 2);
      }
      
      public function checkIsFilterGoods() : Boolean
      {
         if(bagType != 1 && bagType != 6)
         {
            return false;
         }
         if(!GoodsManager.instance.filterFlag)
         {
            return false;
         }
         if(BaseBagListManager.instance.model.lastBagSortType == 0)
         {
            return false;
         }
         if(GoodsManager.instance.isType(this,BaseBagListManager.instance.model.lastBagSortType))
         {
            return false;
         }
         if(FrameControllerManager.instance.armyController.model.currentOpenPanel == ArmyPanelEnum.TATTOO_PANEL)
         {
            return false;
         }
         if(FrameControllerManager.instance.armyController.model.currentOpenPanel == ArmyPanelEnum.DRAGON_SOUL_PANEL)
         {
            return false;
         }
         if(FrameControllerManager.instance.armyController.model.currentOpenPanel == ArmyPanelEnum.HOLY_DRAGON_SOUL_PANEL)
         {
            return false;
         }
         return true;
      }
   }
}

