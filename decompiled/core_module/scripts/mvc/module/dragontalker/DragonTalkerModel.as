package mvc.module.dragontalker
{
   import flash.utils.Dictionary;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.templates.DragonTalkerFightMountTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class DragonTalkerModel
   {
      
      public static const TALIMANS_EXP_SONTYPE:int = 407;
      
      public static const DRAGONTALKER_SKILL_MASTERTYPE:int = 4;
      
      public static const DRAGONTALKER_SPECIAL_SKILL_SONTYPE:int = 435;
      
      public static const DRAGONTALKER_PROFICIENCY_SKILL_SONTYPE:int = 436;
      
      public static const BAG_VIEW_MAIN:int = 1;
      
      public static const BAG_VIEW_INTENSIFY:int = 2;
      
      public static const BAG_VIEW_SWALLOW:int = 3;
      
      public static const SINGLE_SONTYPE_MAX_BAG_COUNT:int = 91;
      
      public static const STRENGTH_PERCENT:Number = 0.02;
      
      public var isOpen:Boolean;
      
      public var isDragonTalker:Boolean;
      
      public var talismanList:Array;
      
      public var symbioteList:Array;
      
      public var proficiencyList:Array;
      
      public var skillCount:int = 1;
      
      public var selectBattleBeastId:int;
      
      public var battleBeastGrade:int;
      
      public var battleBeastExp:int;
      
      public var battleBesatCurMaxExp:int;
      
      public var skillActiveIndex:int;
      
      public var dragonSkillList:Array;
      
      public var allSkillDic:SimpleDictionary;
      
      private var _skillTabIndex:int;
      
      public var battleBeastTempArr:Array;
      
      public var battleBesatUpgradeArr:Array;
      
      public var talismanUpgradeArr:Array;
      
      public var symbioteUpgradeArr:Array;
      
      public var bagViewType:int = -1;
      
      public var hideCellDic:SimpleDictionary;
      
      public var intensifyTalismanInfo:DragonTalkerTalismanInfo;
      
      private var _isOpenMutiIntensify:Boolean = false;
      
      private var _mutiIntensifyList:Array;
      
      public var profiencySkillTempDic:SimpleDictionary;
      
      public var allSkillInfoDic:SimpleDictionary;
      
      public var skillLineDic:Dictionary;
      
      public var skillItemDic:Dictionary;
      
      public var opPoolDic:Dictionary;
      
      public var learnDic:Dictionary;
      
      public var realLearnPointDic:Dictionary;
      
      public function DragonTalkerModel()
      {
         super();
         if(talismanList == null)
         {
            talismanList = [];
         }
         if(symbioteList == null)
         {
            symbioteList = [];
         }
         if(dragonSkillList == null)
         {
            dragonSkillList = [];
         }
         if(battleBeastTempArr == null)
         {
            battleBeastTempArr = [];
         }
         if(proficiencyList == null)
         {
            proficiencyList = [];
         }
         if(allSkillInfoDic == null)
         {
            allSkillInfoDic = new SimpleDictionary(true);
         }
         if(hideCellDic == null)
         {
            hideCellDic = new SimpleDictionary(true);
         }
         if(profiencySkillTempDic == null)
         {
            profiencySkillTempDic = new SimpleDictionary(true);
         }
         if(opPoolDic == null)
         {
            opPoolDic = new Dictionary();
         }
         if(learnDic == null)
         {
            learnDic = new Dictionary();
         }
         if(realLearnPointDic == null)
         {
            realLearnPointDic = new Dictionary();
         }
         allSkillDic = TempleteManager.instance.getAllSkillsByMasterType(4);
         initOtherTempDic();
         initDragonTalkerSkill();
      }
      
      private function initOtherTempDic() : void
      {
         var _loc5_:String = null;
         battleBesatUpgradeArr = TempleteManager.instance.getTemplatesByType(140);
         talismanUpgradeArr = TempleteManager.instance.getTemplatesByType(141);
         symbioteUpgradeArr = TempleteManager.instance.getTemplatesByType(142);
         var _loc3_:Dictionary = TempleteManager.instance.dragonTalkerFightMountTempcate.getTemplates();
         for each(var _loc2_:DragonTalkerFightMountTempInfo in _loc3_)
         {
            battleBeastTempArr.push(_loc2_);
         }
         battleBeastTempArr.sortOn("Grade",16);
         var _loc1_:Dictionary = TempleteManager.instance.skillTemplateDic;
         for each(var _loc4_:SkillTempInfo in _loc1_)
         {
            if(_loc4_.SonType == 436)
            {
               _loc5_ = _loc4_.Index + "_" + _loc4_.Grades;
               profiencySkillTempDic.add(_loc5_,_loc4_);
            }
         }
      }
      
      public function getProfiencySkillTempListByGrade(param1:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_:SkillTempInfo in profiencySkillTempDic)
         {
            if(_loc2_.Grades == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sortOn("index",16);
         return _loc3_;
      }
      
      public function getIsFullByType(param1:int, param2:int) : Boolean
      {
         if(param1 == 140)
         {
            return param2 >= battleBesatUpgradeArr.length;
         }
         if(param1 == 141)
         {
            return param2 >= talismanUpgradeArr.length;
         }
         if(param1 == 142)
         {
            return param2 >= symbioteUpgradeArr.length;
         }
         return false;
      }
      
      private function getSkillTempsBySontypeRule(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc4_:SkillTempInfo in allSkillDic)
         {
            _loc3_ = _loc4_.SonType / 100;
            if(_loc3_ == param1)
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public function getSkillInfosBySontypeRule(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc3_:SkillInfo in allSkillInfoDic)
         {
            _loc4_ = _loc3_.templateInfo.SonType / 100;
            if(_loc4_ == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function initDragonTalkerSkill() : void
      {
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:SkillInfo = null;
         _loc3_ = 131;
         while(_loc3_ <= 145)
         {
            _loc1_ = getSkillTempsBySontypeRule(_loc3_);
            for each(var _loc4_:SkillTempInfo in _loc1_)
            {
               _loc2_ = new SkillInfo();
               _loc2_.templateId = _loc4_.TemplateId;
               _loc2_.grade = 0;
               allSkillInfoDic.add(_loc2_.templateId,_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function initSuitSkill(param1:int) : void
      {
         var _loc5_:* = null;
         var _loc4_:SkillTempInfo = null;
         for each(_loc5_ in allSkillInfoDic)
         {
            if(_loc5_.templateInfo.Index == 11)
            {
               _loc5_.grade = 2;
            }
            else
            {
               _loc5_.grade = 0;
            }
         }
         var _loc2_:DragonTalkerSkillInfo = getSkillInfoByIndex(param1);
         var _loc3_:Array = _loc2_.learnSkills;
         for each(var _loc6_:int in _loc3_)
         {
            if(_loc6_ != 0)
            {
               _loc4_ = allSkillDic[_loc6_];
               if(_loc4_)
               {
                  updateSkillInfoByLearn(_loc4_);
               }
            }
         }
      }
      
      private function updateSkillInfoByLearn(param1:SkillTempInfo, param2:Boolean = true) : void
      {
         var _loc5_:SkillInfo = null;
         var _loc3_:int = 0;
         _loc5_ = allSkillInfoDic[param1.TemplateId];
         if(_loc5_)
         {
            _loc5_.grade = 1;
         }
         if(param2)
         {
            for each(var _loc6_:SkillTempInfo in allSkillDic)
            {
               _loc3_ = _loc6_.PreTemplateId.indexOf("" + param1.TemplateId);
               if(_loc3_ != -1)
               {
                  _loc5_ = allSkillInfoDic[_loc6_.TemplateId];
                  if(_loc5_)
                  {
                     _loc5_.grade = 2;
                  }
               }
            }
         }
         var _loc4_:Array = param1.preTempList;
         for each(var _loc7_:SkillTempInfo in _loc4_)
         {
            _loc5_ = allSkillInfoDic[_loc7_.TemplateId];
            if(_loc5_)
            {
               _loc5_.grade = 1;
            }
            if(_loc7_.Index != 11)
            {
               updateSkillInfoByLearn(_loc7_,false);
            }
         }
      }
      
      private function existSkill(param1:SkillTempInfo, param2:int) : int
      {
         var _loc4_:SkillTempInfo = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:DragonTalkerSkillInfo = getSkillInfoByIndex(param2);
         if(!_loc7_)
         {
            return 0;
         }
         var _loc6_:Array = _loc7_.learnSkills;
         for each(var _loc3_:int in _loc6_)
         {
            if(_loc3_ != 0)
            {
               _loc4_ = allSkillDic[_loc3_];
               if(_loc4_)
               {
                  if(_loc4_.TemplateId == param1.TemplateId)
                  {
                     return _loc3_;
                  }
                  _loc9_ = param1.SonType / 100;
                  _loc10_ = _loc4_.SonType / 100;
                  if(_loc9_ == _loc10_)
                  {
                     _loc5_ = param1.Index / 10;
                     _loc8_ = _loc4_.Index / 10;
                     if(_loc5_ == _loc8_ && _loc4_.TemplateId > param1.TemplateId)
                     {
                        return _loc4_.TemplateId;
                     }
                  }
               }
            }
         }
         return 0;
      }
      
      public function getSkillMaxGrade(param1:SkillInfo) : int
      {
         var _loc3_:int = 0;
         for each(var _loc2_:SkillTempInfo in allSkillDic)
         {
            if(_loc2_.SonType == param1.templateInfo.SonType)
            {
               if(_loc3_ < _loc2_.Grades)
               {
                  _loc3_ = _loc2_.Grades;
               }
            }
         }
         return _loc3_;
      }
      
      public function get talismanEquipList() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:DragonTalkerTalismanInfo in talismanList)
         {
            if(_loc1_.isEquip)
            {
               _loc2_.push(_loc1_);
            }
         }
         _loc2_.sortOn("equipPos",16);
         return _loc2_;
      }
      
      public function getEquipTalismanInfoBySontype(param1:int) : DragonTalkerTalismanInfo
      {
         for each(var _loc2_:DragonTalkerTalismanInfo in talismanList)
         {
            if(_loc2_.isEquip && _loc2_.equipPos == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getIsEquipByTempId(param1:int) : Boolean
      {
         var _loc2_:Array = talismanEquipList;
         for each(var _loc3_:DragonTalkerTalismanInfo in _loc2_)
         {
            if(_loc3_.tempId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function removeNoExistTalismanInfo(param1:DragonTalkerTalismanInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(talismanList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(talismanList[_loc3_].id == param1.id)
            {
               talismanList.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function getTalismanInfoById(param1:int) : DragonTalkerTalismanInfo
      {
         for each(var _loc2_:DragonTalkerTalismanInfo in talismanList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getSkillInfoByIndex(param1:int) : DragonTalkerSkillInfo
      {
         for each(var _loc2_:DragonTalkerSkillInfo in dragonSkillList)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get skillTabIndex() : int
      {
         return _skillTabIndex;
      }
      
      public function set skillTabIndex(param1:int) : void
      {
         if(_skillTabIndex == param1)
         {
            return;
         }
         _skillTabIndex = param1;
      }
      
      public function getTalismanListBySontype(param1:int, param2:Boolean = true) : Array
      {
         var _loc4_:Array = [];
         for each(var _loc3_:DragonTalkerTalismanInfo in talismanList)
         {
            if(_loc3_.goodsTempInfo)
            {
               if(!isInHideDic(_loc3_))
               {
                  if(!(_loc3_.isEquip && bagViewType == 1))
                  {
                     if(_loc3_.goodsTempInfo.SonType == param1)
                     {
                        _loc4_.push(_loc3_);
                     }
                  }
               }
            }
         }
         if(param2)
         {
            _loc4_.sort(sortTalismanInfo);
         }
         return _loc4_;
      }
      
      public function sortTalismanInfo(param1:DragonTalkerTalismanInfo, param2:DragonTalkerTalismanInfo) : int
      {
         var _loc4_:GoodsTemplateInfo = param1.goodsTempInfo;
         var _loc3_:GoodsTemplateInfo = param2.goodsTempInfo;
         if(param1.equipPos != 0 && param2.equipPos == 0)
         {
            return -1;
         }
         if(param1.equipPos == 0 && param2.equipPos != 0)
         {
            return 1;
         }
         if(_loc4_.Profile > _loc3_.Profile)
         {
            return -1;
         }
         if(_loc4_.Profile < _loc3_.Profile)
         {
            return 1;
         }
         if(param1.grade > param2.grade)
         {
            return -1;
         }
         if(param1.grade < param2.grade)
         {
            return 1;
         }
         return param1.tempId > param2.tempId ? -1 : 1;
      }
      
      public function getIsFullBySontype(param1:int) : Boolean
      {
         var _loc2_:Array = getTalismanListBySontype(param1,false);
         return _loc2_.length >= 91;
      }
      
      public function isInHideDic(param1:DragonTalkerTalismanInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         for each(var _loc2_:DragonTalkerTalismanInfo in hideCellDic)
         {
            if(_loc2_.id == param1.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function clearHideDic() : void
      {
         hideCellDic.clear();
         MsgMan.notifyObserver("HIDE_DIC_CHANGE");
      }
      
      public function get needAlertSkillInfo() : DragonTalkerTalismanInfo
      {
         for each(var _loc1_:DragonTalkerTalismanInfo in hideCellDic)
         {
            if(_loc1_.oldSkillIndex >= 0)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getSymbioteInfoByIndex(param1:int) : DragonTalkerSymbioteInfo
      {
         for each(var _loc2_:DragonTalkerSymbioteInfo in symbioteList)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function setMutipleIntensifyList(param1:DragonTalkerTalismanInfo, param2:Boolean, param3:Boolean = false) : void
      {
         if(_mutiIntensifyList == null)
         {
            _mutiIntensifyList = [];
         }
         if(param3)
         {
            while(_mutiIntensifyList.length > 0)
            {
               _mutiIntensifyList.pop();
            }
            return;
         }
         if(param2)
         {
            _mutiIntensifyList.push(param1);
         }
         else if(isInMutiInstensifyList(param1))
         {
            _mutiIntensifyList.splice(_mutiIntensifyList.indexOf(param1),1);
         }
      }
      
      public function hasMutiIntensifyList() : Boolean
      {
         if(_mutiIntensifyList == null || _mutiIntensifyList.length <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function get firstNoExpTalismanInfo() : DragonTalkerTalismanInfo
      {
         if(_mutiIntensifyList == null || _mutiIntensifyList.length <= 0)
         {
            return null;
         }
         for each(var _loc1_:DragonTalkerTalismanInfo in _mutiIntensifyList)
         {
            if(!_loc1_.isExpType)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function isInMutiInstensifyList(param1:DragonTalkerTalismanInfo) : Boolean
      {
         if(_mutiIntensifyList == null)
         {
            return false;
         }
         for each(var _loc2_:DragonTalkerTalismanInfo in _mutiIntensifyList)
         {
            if(_loc2_.id == param1.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isOpenMutiIntensify() : Boolean
      {
         return _isOpenMutiIntensify;
      }
      
      public function set isOpenMutiIntensify(param1:Boolean) : void
      {
         if(_isOpenMutiIntensify == param1)
         {
            return;
         }
         _isOpenMutiIntensify = param1;
         MsgMan.notifyObserver("MUTI_INTENSIFY_FRAME_CHANGE");
      }
      
      public function getProficiencyInfoByIndex(param1:int) : DragonTalkerProficiencyInfo
      {
         for each(var _loc2_:DragonTalkerProficiencyInfo in proficiencyList)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function clearSkillLineAndItem() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in skillLineDic)
         {
            delete skillLineDic[_loc1_];
         }
         skillLineDic = null;
         for(_loc1_ in skillItemDic)
         {
            delete skillItemDic[_loc1_];
         }
         skillItemDic = null;
      }
      
      public function addSkillLine(param1:int, param2:Object) : void
      {
         if(skillLineDic == null)
         {
            skillLineDic = new Dictionary();
         }
         skillLineDic[param1] = param2;
      }
      
      public function addSkillItem(param1:int, param2:Object) : void
      {
         if(skillItemDic == null)
         {
            skillItemDic = new Dictionary();
         }
         skillItemDic[param1] = param2;
      }
      
      public function addDragonSkillLearn(param1:int, param2:String) : void
      {
         learnDic[param1] = param2;
      }
      
      public function addLearnPoint(param1:int, param2:int) : void
      {
         realLearnPointDic[param1] = param2;
      }
      
      public function clientLearn(param1:int, param2:int) : void
      {
         var _loc8_:Array = null;
         var _loc3_:SkillTempInfo = null;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc14_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:String = null;
         var _loc7_:SkillTempInfo = allSkillDic[param2];
         if(!_loc7_)
         {
            return;
         }
         var _loc12_:int = _loc7_.SonType / 100;
         var _loc13_:DragonTalkerSkillInfo = getSkillInfoByIndex(param1);
         if(_loc13_)
         {
            _loc8_ = _loc13_.learnSkills;
            _loc6_ = 0;
            while(_loc6_ < _loc8_.length)
            {
               _loc4_ = int(_loc8_[_loc6_]);
               _loc3_ = allSkillDic[_loc4_];
               if(_loc3_)
               {
                  _loc9_ = _loc3_.SonType / 100;
                  if(_loc9_ == _loc12_)
                  {
                     _loc10_ = true;
                     break;
                  }
               }
               _loc6_++;
            }
            if(!_loc10_)
            {
               _loc8_.push(param2);
            }
            _loc5_ = 0;
            while(_loc5_ < _loc8_.length)
            {
               _loc4_ = int(_loc8_[_loc5_]);
               _loc3_ = allSkillDic[_loc4_];
               if(_loc3_)
               {
                  _loc9_ = _loc3_.SonType / 100;
                  if(_loc9_ == _loc12_)
                  {
                     _loc8_[_loc5_] = _loc7_.TemplateId;
                     _loc14_ = true;
                     opPoolDic[_loc9_] = _loc7_.TemplateId;
                     break;
                  }
               }
               _loc5_++;
            }
            if(_loc14_)
            {
               _loc11_ = _loc8_.join(",");
               _loc13_.hasLearnSkill = _loc11_;
               initSuitSkill(param1);
               MsgMan.notifyObserver("DRAGON_TALKER_INFO_UPDATE");
            }
         }
      }
      
      public function isClientLearn() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:Dictionary = opPoolDic;
         for each(var _loc2_:Object in _loc3_)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function clearLearnDic() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in learnDic)
         {
            delete learnDic[_loc1_];
         }
      }
      
      public function clearPointDic() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in realLearnPointDic)
         {
            delete realLearnPointDic[_loc1_];
         }
      }
      
      public function clearSkillPool(param1:Boolean) : void
      {
         var _loc3_:Object = null;
         var _loc2_:String = null;
         var _loc4_:DragonTalkerSkillInfo = null;
         for(_loc3_ in opPoolDic)
         {
            delete opPoolDic[_loc3_];
         }
         for(_loc2_ in learnDic)
         {
            _loc4_ = getSkillInfoByIndex(int(_loc2_));
            if(_loc4_)
            {
               _loc4_.hasLearnSkill = learnDic[_loc2_];
            }
         }
         for(_loc2_ in realLearnPointDic)
         {
            _loc4_ = getSkillInfoByIndex(int(_loc2_));
            if(_loc4_)
            {
               _loc4_.skillPoint = realLearnPointDic[_loc2_];
            }
         }
         if(param1)
         {
            initSuitSkill(skillTabIndex);
            MsgMan.notifyObserver("DRAGON_TALKER_INFO_UPDATE");
         }
      }
   }
}

