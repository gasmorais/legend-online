package mvc.module.children
{
   import flash.utils.Dictionary;
   import managers.ChildManager;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class ChildNursingSpiritModel
   {
      
      public static const SKILL_GRADE1:int = 5;
      
      public static const SKILL_GRADE2:int = 8;
      
      public static const NS_SKILL_MAXGRADE:int = 12;
      
      public static const NS_SKILL_COST:int = 2500;
      
      public static const NS_AWAKE_SKILL_INDEX:int = 20;
      
      public static const AVENGER_NS_SKILL_INDEX1:int = 30;
      
      public static const AVENGER_NS_SKILL_INDEX2:int = 31;
      
      public static const AVENGER_NS_SKILL_INDEX3:int = 32;
      
      public static const NS_CHARGE_NEED_TEMPLATEID:int = 208201;
      
      public static const NS_REFRESH_NEED_TEMPALTEID:int = 208202;
      
      public static const NS_RESI_REFRESH_NEED_TEMPLATEID:int = 208203;
      
      public static const NS_CHARGE_CALL_NEED_TEMPLATEID:int = 208525;
      
      public static const NS_TALENT_ITEM_MAXGRADE:int = 80;
      
      public static const ADVANCED_COST_LIST:Vector.<uint> = new <uint>[1000,2000,4000];
      
      public var nsTempList:Array;
      
      private var nsTempDic:Dictionary;
      
      private var _selectedNsChildTemp:ChildTempInfo;
      
      private var _selectedNsChild:ChildData;
      
      public var isSuccess:Boolean;
      
      public var gpIndex:int;
      
      public var resiIndex:int;
      
      public var results:String;
      
      public var expLockCount:int;
      
      public var isKeySelected:Boolean;
      
      public var enchantRefreshSuccess:Boolean;
      
      public var enchantIndex:int;
      
      public function ChildNursingSpiritModel()
      {
         super();
         if(nsTempList == null)
         {
            nsTempList = [];
         }
         if(nsTempDic == null)
         {
            nsTempDic = new Dictionary(true);
         }
         var _loc2_:Dictionary = TempleteManager.instance.childTemplateCate.getTemplates();
         for each(var _loc1_:ChildTempInfo in _loc2_)
         {
            if(_loc1_.MasterType == 1)
            {
               if(_loc1_.Grades == 1)
               {
                  nsTempList.push(_loc1_);
                  nsTempDic[_loc1_.JobType + "_" + _loc1_.Grades] = _loc1_;
               }
            }
         }
      }
      
      public function sortNsTempList(param1:ChildTempInfo, param2:ChildTempInfo) : int
      {
         var _loc3_:ChildData = getNsChildDataByJob(param1.JobType);
         var _loc4_:ChildData = getNsChildDataByJob(param2.JobType);
         if(_loc3_ && !_loc4_)
         {
            return -1;
         }
         if(!_loc3_ && _loc4_)
         {
            return 1;
         }
         if(param1.JobType < param2.JobType)
         {
            return -1;
         }
         return 1;
      }
      
      public function getChildTempInfoByJobAndGrade(param1:int, param2:int) : ChildTempInfo
      {
         return nsTempDic[param1 + "_" + param2];
      }
      
      public function get nsList() : Array
      {
         var _loc1_:ChildTempInfo = null;
         var _loc3_:Array = [];
         for each(var _loc2_:ChildData in childModel.childList)
         {
            _loc1_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc2_.job,_loc2_.growthGrade);
            if(_loc1_.MasterType != 0)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sortOn("job",16);
         return _loc3_;
      }
      
      public function hasChildNursing() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:ChildTempInfo = null;
         var _loc4_:Array = [];
         for each(var _loc3_:ChildData in ChildManager.instance.model.childList)
         {
            _loc2_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc3_.job,_loc3_.growthGrade);
            if(_loc2_.MasterType == 1)
            {
               _loc4_.push(_loc3_);
            }
         }
         if(_loc4_.length > 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get selectedNsChildTemp() : ChildTempInfo
      {
         return _selectedNsChildTemp;
      }
      
      public function set selectedNsChildTemp(param1:ChildTempInfo) : void
      {
         if(_selectedNsChildTemp == param1)
         {
            return;
         }
         _selectedNsChildTemp = param1;
         MsgMan.notifyObserver("ChildEvent.CHILD_NS_TEMP_SELECT");
      }
      
      public function getNsChildDataByJob(param1:int) : ChildData
      {
         for each(var _loc2_:ChildData in nsList)
         {
            if(_loc2_.job == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      public function get selectedNsChild() : ChildData
      {
         return _selectedNsChild;
      }
      
      public function set selectedNsChild(param1:ChildData) : void
      {
         if(_selectedNsChild == param1)
         {
            return;
         }
         _selectedNsChild = param1;
         MsgMan.notifyObserver("ChildEvent.CHILD_NS_INFO_SELECT");
      }
      
      public function getIsLearnSkillTempInfo(param1:SkillTempInfo, param2:String) : SkillTempInfo
      {
         var _loc5_:int = 0;
         var _loc4_:SkillTempInfo = null;
         var _loc3_:Array = [];
         if(param2)
         {
            _loc3_ = param2.split(",");
         }
         var _loc6_:SkillTempInfo = null;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_ && _loc3_[_loc5_] != "-1" && _loc3_[_loc5_] != "")
            {
               _loc4_ = TempleteManager.instance.getSkillById(parseInt(_loc3_[_loc5_]));
               if(_loc4_.SonType == param1.SonType)
               {
                  _loc6_ = _loc4_;
                  break;
               }
            }
            _loc5_++;
         }
         return _loc6_;
      }
      
      public function getNsSkillShowList(param1:int, param2:int) : Array
      {
         var _loc5_:Array = [];
         var _loc4_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1,1);
         if(!_loc4_)
         {
            return _loc5_;
         }
         for each(var _loc3_:SkillTempInfo in TempleteManager.instance.skillTemplateDic)
         {
            if(_loc3_.Grades == 1)
            {
               if(param2 == 4)
               {
                  if(_loc3_.MasterType == 44)
                  {
                     _loc5_.push(_loc3_);
                  }
               }
               else if(_loc3_.MasterType == _loc4_.SkillMasterType)
               {
                  if(param2 == 1 && _loc3_.UseWay == 1 && _loc3_.Priority != 3)
                  {
                     _loc5_.push(_loc3_);
                  }
                  else if(param2 == 2 && _loc3_.UseWay == 2)
                  {
                     _loc5_.push(_loc3_);
                  }
                  else if(param2 == 3 && _loc3_.UseWay == 1 && _loc3_.Priority == 3)
                  {
                     _loc5_.push(_loc3_);
                  }
               }
            }
         }
         _loc5_.sortOn(["Index","TemplateId"],[16,16]);
         return _loc5_;
      }
      
      public function needMaterialTempIdBySkillTemp(param1:SkillTempInfo, param2:int) : int
      {
         var _loc3_:Boolean = param2 <= 3 ? true : false;
         if(param1.Grades < 5)
         {
            if(param1.UseWay == 1)
            {
               return 2269000;
            }
            if(param1.UseWay == 2 && param1.MasterType != 44)
            {
               return 2269001;
            }
            if(param1.UseWay == 2 && param1.MasterType == 44)
            {
               return 2269002;
            }
            return 0;
         }
         if(param1.Grades >= 5 && param1.Grades < 8)
         {
            return 2260001;
         }
         if(param1.Grades >= 8 && _loc3_)
         {
            return 2260001;
         }
         if(param1.Grades >= 8 && !_loc3_)
         {
            if(param1.UseWay == 1 && param1.Priority != 3)
            {
               return 212005;
            }
            if(param1.UseWay == 2 && param1.MasterType != 44)
            {
               return 212007;
            }
            if(param1.UseWay == 2 && param1.MasterType == 44)
            {
               return 212008;
            }
            if(param1.UseWay == 1 && param1.Priority == 3)
            {
               return 212006;
            }
            return 0;
         }
         return 0;
      }
      
      public function getSkillUpgradeCostByGrade(param1:uint) : uint
      {
         var _loc2_:* = 0;
         if(param1 < 5)
         {
            _loc2_ = uint(Math.pow(4,param1 - 1) * 10);
         }
         else
         {
            if(!(param1 >= 5 && param1 < 8))
            {
               return 2500;
            }
            _loc2_ = ADVANCED_COST_LIST[param1 - 5];
         }
         return _loc2_;
      }
      
      public function getHasSkillBooksByType(param1:int) : String
      {
         if(param1 == 1)
         {
            return selectedNsChild.nursingSpiritInfo.skillBookA;
         }
         if(param1 == 2)
         {
            return selectedNsChild.nursingSpiritInfo.skillBookB;
         }
         return selectedNsChild.skillBooks;
      }
      
      public function getHasLearnSkillStrByType(param1:int) : String
      {
         if(param1 == 1)
         {
            return selectedNsChild.nursingSpiritInfo.skillA;
         }
         if(param1 == 2)
         {
            return selectedNsChild.nursingSpiritInfo.skillB;
         }
         return selectedNsChild.skill;
      }
      
      public function get lifeWheelUpgradeArr() : Array
      {
         var _loc3_:Array = [];
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(133);
         for each(var _loc1_:UpgradeTemplateInfo in _loc2_)
         {
            if(_loc1_.TemplateId != 0)
            {
               _loc3_.push(_loc1_);
            }
         }
         _loc3_.sortOn("Grades",0x10 | 2);
         return _loc3_;
      }
      
      public function getShowSkillTempId(param1:NsLifeWheelInfo) : int
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return lifeWheelUpgradeArr[lifeWheelUpgradeArr.length - 1].TemplateId;
         }
         _loc3_ = Math.min(param1.reduceResiGrade,param1.fireResiGrade,param1.waterResiGrade,param1.elcResiGrade,param1.windResiGrade,param1.darkResiGrade,param1.lightResiGrade);
         for each(var _loc2_:UpgradeTemplateInfo in lifeWheelUpgradeArr)
         {
            if(_loc3_ >= _loc2_.Grades)
            {
               return _loc2_.TemplateId;
            }
         }
         return lifeWheelUpgradeArr[lifeWheelUpgradeArr.length - 1].TemplateId;
      }
      
      public function getChildSkillIsMaxByIndex(param1:int) : Boolean
      {
         var _loc4_:SkillTempInfo = null;
         if(!selectedNsChild)
         {
            return false;
         }
         var _loc5_:int = 0;
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         if(!StringHelper.isNullOrEmpty(selectedNsChild.nursingSpiritInfo.skillA))
         {
            _loc6_ = selectedNsChild.nursingSpiritInfo.skillA.split(",");
         }
         if(!StringHelper.isNullOrEmpty(selectedNsChild.nursingSpiritInfo.skillB))
         {
            _loc7_ = selectedNsChild.nursingSpiritInfo.skillB.split(",");
         }
         for each(var _loc2_:String in _loc6_)
         {
            _loc4_ = TempleteManager.instance.skillTemplateDic[int(_loc2_)];
            if(_loc4_ && _loc4_.Index == param1 && _loc4_.Grades >= 8)
            {
               _loc5_++;
               break;
            }
         }
         for each(var _loc3_:String in _loc7_)
         {
            _loc4_ = TempleteManager.instance.skillTemplateDic[int(_loc3_)];
            if(_loc4_ && _loc4_.Index == param1 && _loc4_.Grades >= 8)
            {
               _loc5_++;
               break;
            }
         }
         return _loc5_ >= 2;
      }
      
      public function getAwakeSkillTempByGrade(param1:ChildData, param2:Boolean = false) : SkillTempInfo
      {
         if(!param1 || !param1.nursingSpiritInfo)
         {
            return null;
         }
         var _loc4_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1.job,param1.growthGrade);
         for each(var _loc3_:SkillTempInfo in TempleteManager.instance.skillTemplateDic)
         {
            if(_loc3_.MasterType == _loc4_.SkillMasterType)
            {
               if(_loc3_.Index == 20)
               {
                  if(param2)
                  {
                     if(_loc3_.Grades == param1.nursingSpiritInfo.awakeGrade + 1)
                     {
                        return _loc3_;
                     }
                  }
                  else if(_loc3_.Grades == param1.nursingSpiritInfo.awakeGrade)
                  {
                     return _loc3_;
                  }
               }
            }
         }
         return null;
      }
   }
}

