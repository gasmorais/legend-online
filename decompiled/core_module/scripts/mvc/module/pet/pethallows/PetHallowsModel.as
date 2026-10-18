package mvc.module.pet.pethallows
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.PetContracTemplateInfo;
   import yishi.datas.templates.PetHallowsTemplateInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class PetHallowsModel
   {
      
      private var _hallowsTempList:Array;
      
      private var _contracHallowTypeTempDic:Dictionary;
      
      private var _contracSonTypeAndGradeTempDic:Dictionary;
      
      private var _hallowsTypeAndGradeTempDic:Dictionary;
      
      private var _contracTypeAndIndexTempDic:Dictionary;
      
      private var _hallowSkillTempDic:Dictionary;
      
      public var hallowsInfoList:Array;
      
      public var contracInfoDic:Dictionary;
      
      private var upgradeArr:Array;
      
      private var _selectedHallowsTemp:PetHallowsTemplateInfo;
      
      public var inscriptionNeedValue:int = 100;
      
      public var hasLockCount:int;
      
      public function PetHallowsModel()
      {
         super();
         if(_hallowsTempList == null)
         {
            _hallowsTempList = [];
         }
         if(hallowsInfoList == null)
         {
            hallowsInfoList = [];
         }
         if(upgradeArr == null)
         {
            upgradeArr = [];
         }
         if(contracInfoDic == null)
         {
            contracInfoDic = new Dictionary(true);
         }
         if(_contracHallowTypeTempDic == null)
         {
            _contracHallowTypeTempDic = new Dictionary(true);
         }
         if(_contracSonTypeAndGradeTempDic == null)
         {
            _contracSonTypeAndGradeTempDic = new Dictionary(true);
         }
         if(_contracTypeAndIndexTempDic == null)
         {
            _contracTypeAndIndexTempDic = new Dictionary(true);
         }
         if(_hallowsTypeAndGradeTempDic == null)
         {
            _hallowsTypeAndGradeTempDic = new Dictionary(true);
         }
         if(_hallowSkillTempDic == null)
         {
            _hallowSkillTempDic = new Dictionary(true);
         }
         setTemplateData();
      }
      
      private function setTemplateData() : void
      {
         var _loc3_:* = null;
         var _loc4_:Dictionary = TempleteManager.instance.petHallowsTemplateCate.getTemplates();
         for each(var _loc5_:PetHallowsTemplateInfo in _loc4_)
         {
            _hallowsTypeAndGradeTempDic[_loc5_.HallowType + "_" + _loc5_.Grades] = _loc5_;
            if(_loc5_.Grades == 1)
            {
               _hallowsTempList.push(_loc5_);
            }
         }
         _hallowsTempList.sortOn("HallowType",16);
         for each(var _loc6_:PetHallowsTemplateInfo in _loc4_)
         {
            if(_hallowSkillTempDic[_loc6_.HallowType] == null)
            {
               _hallowSkillTempDic[_loc6_.HallowType] = new Dictionary(true);
            }
            if(_hallowSkillTempDic[_loc6_.HallowType][_loc6_.SkillTempId])
            {
               if(_hallowSkillTempDic[_loc6_.HallowType][_loc6_.SkillTempId].Grades < _loc6_.Grades)
               {
                  continue;
               }
            }
            _hallowSkillTempDic[_loc6_.HallowType][_loc6_.SkillTempId] = _loc6_;
         }
         var _loc1_:Dictionary = TempleteManager.instance.petContracTemplateCate.getTemplates();
         for each(var _loc2_:PetContracTemplateInfo in _loc1_)
         {
            _contracSonTypeAndGradeTempDic[_loc2_.PetSonType + "_" + _loc2_.Grades] = _loc2_;
            if(_contracTypeAndIndexTempDic[_loc2_.HallowType + "_" + _loc2_.LineIndex] == null)
            {
               _contracTypeAndIndexTempDic[_loc2_.HallowType + "_" + _loc2_.LineIndex] = [];
            }
            _contracTypeAndIndexTempDic[_loc2_.HallowType + "_" + _loc2_.LineIndex].push(_loc2_);
            if(_loc2_.Grades == 1)
            {
               if(_contracHallowTypeTempDic[_loc2_.HallowType] == null)
               {
                  _contracHallowTypeTempDic[_loc2_.HallowType] = [];
               }
               _contracHallowTypeTempDic[_loc2_.HallowType].push(_loc2_);
            }
         }
         upgradeArr = TempleteManager.instance.getTemplatesByType(127);
      }
      
      public function get hallowsTempList() : Array
      {
         return _hallowsTempList;
      }
      
      public function getContracTempListByHallowsType(param1:int) : Array
      {
         return _contracHallowTypeTempDic[param1];
      }
      
      public function getHallowSkillTempDicByHallowsType(param1:int) : Dictionary
      {
         return _hallowSkillTempDic[param1];
      }
      
      public function getContracTempInfoByPetSonTypeAndGrade(param1:int, param2:int) : PetContracTemplateInfo
      {
         return _contracSonTypeAndGradeTempDic[param1 + "_" + param2];
      }
      
      public function getHallowsTempInfoByTypeAndGrade(param1:int, param2:int) : PetHallowsTemplateInfo
      {
         return _hallowsTypeAndGradeTempDic[param1 + "_" + param2];
      }
      
      public function getContracTempInfoByTypeAndIndex(param1:int, param2:int) : Array
      {
         return _contracTypeAndIndexTempDic[param1 + "_" + param2];
      }
      
      public function getHallowsInfoByHallowsType(param1:int) : PetHallowsInfo
      {
         for each(var _loc2_:PetHallowsInfo in hallowsInfoList)
         {
            if(_loc2_.hallowType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getContracAddDicByHallowsType(param1:int) : Dictionary
      {
         var _loc2_:PetContracTemplateInfo = null;
         var _loc4_:Dictionary = null;
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc5_:int in contracInfoDic)
         {
            _loc2_ = TempleteManager.instance.petContracTemplateCate.getTemplateById(_loc5_);
            if(!(!_loc2_ || _loc2_.HallowType != param1))
            {
               _loc4_ = getContracAddDicByTempId(_loc5_);
               for(var _loc6_:String in _loc4_)
               {
                  if(!_loc3_[_loc6_])
                  {
                     _loc3_[_loc6_] = _loc4_[_loc6_];
                  }
                  else
                  {
                     var _loc7_:String = _loc6_;
                     var _loc8_:Number = _loc3_[_loc7_] + _loc4_[_loc6_];
                     _loc3_[_loc7_] = _loc8_;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function getContracAddDicByTempId(param1:int) : Dictionary
      {
         var _loc3_:int = 0;
         var _loc4_:PetContracTemplateInfo = null;
         var _loc5_:Dictionary = new Dictionary();
         var _loc2_:PetContracTemplateInfo = TempleteManager.instance.petContracTemplateCate.getTemplateById(param1);
         if(!_loc2_)
         {
            return _loc5_;
         }
         _loc3_ = 1;
         while(_loc3_ <= _loc2_.Grades)
         {
            _loc4_ = getContracTempInfoByPetSonTypeAndGrade(_loc2_.PetSonType,_loc3_);
            if(_loc4_)
            {
               if(!_loc5_[_loc4_.PropertyType])
               {
                  _loc5_[_loc4_.PropertyType] = _loc4_.PropertyData;
               }
               else
               {
                  var _loc6_:int = _loc4_.PropertyType;
                  var _loc7_:Number = _loc5_[_loc6_] + _loc4_.PropertyData;
                  _loc5_[_loc6_] = _loc7_;
               }
            }
            _loc3_++;
         }
         return _loc5_;
      }
      
      public function get selectedHallowsTemp() : PetHallowsTemplateInfo
      {
         return _selectedHallowsTemp;
      }
      
      public function set selectedHallowsTemp(param1:PetHallowsTemplateInfo) : void
      {
         if(_selectedHallowsTemp == param1)
         {
            return;
         }
         _selectedHallowsTemp = param1;
         MsgMan.notifyObserver("PET_HALLOWS_HEAD_SELECT");
      }
      
      public function checkIsCanContrac(param1:PetContracTemplateInfo) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:PetContracTemplateInfo = null;
         var _loc2_:PetContracTemplateInfo = null;
         var _loc9_:String = param1.PrePetSonTypes;
         var _loc7_:Array = _loc9_.split(",");
         var _loc4_:int = int(_loc7_.length);
         if(_loc9_ == "0")
         {
            return true;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            if(contracInfoDic[_loc7_[_loc6_]])
            {
               _loc8_ = int(contracInfoDic[_loc7_[_loc6_]]);
               _loc3_ = TempleteManager.instance.petContracTemplateCate.getTemplateById(_loc8_);
               if(_loc3_)
               {
                  _loc2_ = getContracTempInfoByPetSonTypeAndGrade(_loc3_.PetSonType,_loc3_.Grades + 1);
                  if(!_loc2_)
                  {
                     _loc5_++;
                  }
               }
            }
            _loc6_++;
         }
         return _loc5_ >= _loc4_;
      }
      
      public function getPetHasEquipHallows(param1:int) : Boolean
      {
         for each(var _loc2_:PetHallowsInfo in hallowsInfoList)
         {
            if(_loc2_.equipPetId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getLanguageType(param1:int, param2:PetHallowsTemplateInfo) : int
      {
         var _loc3_:int = int(param2.EquipPetSonTypes.split(",")[0]);
         var _loc4_:PetTemplate = TempleteManager.instance.petTemplateCate.getPetTemplatesBySonType(_loc3_)[0];
         switch(param1)
         {
            case 0:
               return 99;
            case 1:
               return 7;
            case 2:
               return 9;
            case 3:
               return 10;
            case 4:
               if(_loc4_.PetType == 117)
               {
                  return 22;
               }
               if(_loc4_.PetType == 118)
               {
                  return 20;
               }
               if(_loc4_.PetType == 119)
               {
                  return 17;
               }
            case 5:
               if(_loc4_.PetType == 117)
               {
                  return 21;
               }
               if(_loc4_.PetType == 118)
               {
                  return 18;
               }
               if(_loc4_.PetType == 119)
               {
                  return 19;
               }
         }
         return -1;
      }
      
      public function getLeftExpByTotalExp(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc3_:int = param1;
         _loc2_ = 0;
         while(_loc2_ < upgradeArr.length)
         {
            _loc4_ = upgradeArr[_loc2_];
            if(_loc3_ < _loc4_.Data)
            {
               return _loc3_;
            }
            _loc3_ -= _loc4_.Data;
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function getInscriptionAddDicByHallowsType(param1:int) : Dictionary
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:UpgradeTemplateInfo = null;
         var _loc8_:String = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:PetHallowsInfo = getHallowsInfoByHallowsType(param1);
         var _loc5_:Dictionary = new Dictionary();
         if(!_loc2_)
         {
            return _loc5_;
         }
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc3_ = int(_loc2_["propAddGrade" + _loc4_]);
            _loc6_ = TempleteManager.instance.getTemplateByLevelAndType(_loc3_,127);
            _loc8_ = getLanguageType(_loc4_,_loc2_.templateInfo) + "";
            _loc7_ = int(_loc2_["propAddValue" + _loc4_]);
            _loc9_ = _loc6_ ? Math.floor(_loc7_ * _loc6_.ActiveObject / 100) : 0;
            _loc5_[_loc8_] = _loc7_ + "_" + _loc9_;
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function get inscriptionUpgradeArr() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:UpgradeTemplateInfo in upgradeArr)
         {
            if(_loc1_.TemplateId != 0)
            {
               _loc2_.push(_loc1_);
            }
         }
         _loc2_.sortOn("Grades",0x10 | 2);
         return _loc2_;
      }
      
      public function getShowSkillTempId(param1:PetHallowsInfo) : int
      {
         var _loc4_:int = 0;
         var _loc3_:Array = inscriptionUpgradeArr;
         if(!param1)
         {
            return _loc3_[_loc3_.length - 1].TemplateId;
         }
         _loc4_ = Math.min(param1.propAddGrade0,param1.propAddGrade1,param1.propAddGrade2,param1.propAddGrade3,param1.propAddGrade4,param1.propAddGrade5);
         for each(var _loc2_:UpgradeTemplateInfo in _loc3_)
         {
            if(_loc4_ >= _loc2_.Grades)
            {
               return _loc2_.TemplateId;
            }
         }
         return _loc3_[_loc3_.length - 1].TemplateId;
      }
   }
}

