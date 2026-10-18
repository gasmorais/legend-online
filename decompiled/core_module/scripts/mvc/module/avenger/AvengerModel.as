package mvc.module.avenger
{
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerModel
   {
      
      public static const MAJOR_SKILL_SONTYPE:int = 500;
      
      public static const MINOR_SKILL_SONTYPE:int = 501;
      
      public static const POLISH_STONE_TEMPID:int = 6910001;
      
      public static const CARVE_STONE_TEMPID:int = 6920001;
      
      public static const ARMOR_BAG_TYPE:int = 3;
      
      public static const AVENGER_RESOLVE_TYPE:int = 1;
      
      public var skillDic:SimpleDictionary;
      
      public var bodyInfo:AvengerBodyInfo;
      
      public var devilArmorInfo:AvengerDevilArmorInfo;
      
      public var nsInfoDic:SimpleDictionary;
      
      public var armorBagDic:SimpleDictionary;
      
      public var resolveBagDic:SimpleDictionary;
      
      public var resolveBagDic1:SimpleDictionary;
      
      public var isAllResolve:Boolean = false;
      
      public var resolveLv:String;
      
      public var resolveType:String;
      
      public var color:String = "ffffff";
      
      public function AvengerModel()
      {
         super();
         skillDic = new SimpleDictionary(true);
         bodyInfo = new AvengerBodyInfo();
         devilArmorInfo = new AvengerDevilArmorInfo();
         armorBagDic = new SimpleDictionary();
         nsInfoDic = new SimpleDictionary();
         resolveBagDic = new SimpleDictionary();
         resolveBagDic1 = new SimpleDictionary();
      }
      
      public function get showSkillList() : Array
      {
         var _loc1_:Array = skillDic.getList();
         _loc1_.sort(sortSkill);
         return _loc1_;
      }
      
      public function sortSkill(param1:AvengerSkillInfo, param2:AvengerSkillInfo) : int
      {
         if(!param1 || !param2 || !param1.skillTemp || !param2.skillTemp)
         {
            return -1;
         }
         if(param1.skillTemp.MasterType < param2.skillTemp.MasterType)
         {
            return -1;
         }
         if(param1.skillTemp.MasterType > param2.skillTemp.MasterType)
         {
            return 1;
         }
         return param1.skillTemp.Index <= param2.skillTemp.Index ? -1 : 1;
      }
      
      public function get avengerBodyPropAry() : Array
      {
         if(!bodyInfo.tempInfo)
         {
            return [0,0,0,0];
         }
         return [bodyInfo.tempInfo.PhyAttack,bodyInfo.tempInfo.PhyDefence,bodyInfo.tempInfo.MagDefence,bodyInfo.tempInfo.Health];
      }
      
      public function getEmptyPos(param1:GoodsInfo, param2:Array) : int
      {
         param2.sortOn("pos",16);
         for each(var _loc3_:AvengerDevilArmorHoleInfo in param2)
         {
            if(_loc3_.grade > 0 && _loc3_.inlayItem == 0 && param1.templateInfo.Property1 <= _loc3_.grade)
            {
               return _loc3_.pos;
            }
         }
         return -1;
      }
      
      public function checkEquipByPos(param1:int, param2:GoodsInfo) : int
      {
         var _loc3_:int = 0;
         var _loc4_:AvengerDevilArmorHoleInfo = devilArmorInfo.holeDic[param1];
         if(_loc4_.grade < param2.templateInfo.Property1)
         {
            return -2;
         }
         _loc3_ = checkEquipResult(param2,devilArmorInfo.holeDic.getList());
         return _loc3_ == 0 ? param1 : _loc3_;
      }
      
      public function checkCanEquipPos(param1:GoodsInfo) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = getEmptyPos(param1,devilArmorInfo.holeDic.getList());
         if(_loc2_ < 0)
         {
            return -1;
         }
         _loc3_ = checkEquipResult(param1,devilArmorInfo.holeDic.getList());
         return _loc3_ == 0 ? _loc2_ : _loc3_;
      }
      
      public function checkCanExchangePos(param1:GoodsInfo, param2:int, param3:GoodsInfo, param4:int) : int
      {
         var _loc6_:SimpleDictionary = null;
         var _loc5_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:AvengerDevilArmorHoleInfo = devilArmorInfo.holeDic[param4];
         if(_loc8_.grade < param1.templateInfo.Property1)
         {
            return -2;
         }
         _loc6_ = dicCopy(devilArmorInfo.holeDic);
         _loc6_.del(param4);
         _loc5_ = _loc6_.getList();
         _loc7_ = checkEquipResult(param1,_loc5_);
         return _loc7_ == 0 ? param4 : _loc7_;
      }
      
      public function checkEquipResult(param1:GoodsInfo, param2:Array) : int
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         for each(var _loc6_:AvengerDevilArmorHoleInfo in param2)
         {
            if(_loc6_.grade > 0)
            {
               _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_.inlayItem);
               if(_loc4_)
               {
                  if(param1.templateInfo.Property2 == _loc4_.Property2)
                  {
                     _loc3_++;
                  }
                  if(param1.templateInfo.Property3 == _loc4_.Property3)
                  {
                     _loc5_++;
                  }
               }
            }
         }
         if(_loc3_ >= 2)
         {
            return -3;
         }
         if(_loc5_ >= 1)
         {
            return -4;
         }
         return 0;
      }
      
      public function dicCopy(param1:SimpleDictionary) : SimpleDictionary
      {
         var _loc2_:SimpleDictionary = new SimpleDictionary();
         for(var _loc3_:String in param1)
         {
            _loc2_.add(_loc3_,param1[_loc3_]);
         }
         return _loc2_;
      }
      
      public function moveBagToResolve(param1:GoodsInfo) : void
      {
         if(param1.isLock)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.name2"));
            return;
         }
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1.templateId;
         _loc2_.count = 1;
         resolveBagDic.add(param1.templateId,_loc2_);
      }
      
      public function allResolve(param1:GoodsInfo) : void
      {
         if(param1.isLock)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.name2"));
            return;
         }
         if(param1.count <= 0)
         {
            return;
         }
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1.templateId;
         _loc2_.count = param1.count;
         resolveBagDic1.add(param1.templateId,_loc2_);
      }
      
      public function allResolveToBag(param1:GoodsInfo) : void
      {
         if(resolveBagDic1[param1.templateId])
         {
            resolveBagDic1.del(param1.templateId);
         }
      }
      
      public function moveResolveToBag(param1:GoodsInfo) : void
      {
         if(resolveBagDic[param1.templateId])
         {
            resolveBagDic.del(param1.templateId);
         }
      }
      
      public function resetResolveBagList() : void
      {
         resolveBagDic.clear();
         resolveBagDic1.clear();
         isAllResolve = false;
      }
      
      public function getNsInfoByJob(param1:int) : AvengerChildNsInfo
      {
         for each(var _loc2_:AvengerChildNsInfo in nsInfoDic)
         {
            if(_loc2_.childData.job == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getNsSkillList(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:SkillTempInfo in TempleteManager.instance.skillTemplateDic)
         {
            if(_loc4_.Grades == 1)
            {
               if(_loc4_.MasterType == param1 && _loc4_.Index == param2)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         _loc3_.sortOn("Index",16);
         return _loc3_;
      }
      
      public function getStageSkill(param1:ChildTempInfo, param2:AvengerChildNsInfo) : SkillTempInfo
      {
         if(!param1 || !param2)
         {
            return null;
         }
         for each(var _loc3_:SkillTempInfo in TempleteManager.instance.skillTemplateDic)
         {
            if(_loc3_.Index == 30 && _loc3_.Grades == param2.profileGrade && _loc3_.MasterType == param1.SkillMasterType)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getOpenMinLevelAry(param1:int) : Array
      {
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc4_:Array = TempleteManager.instance.getTemplatesByType(156);
         _loc4_.sortOn("Grades",16);
         var _loc2_:Boolean = false;
         var _loc9_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc6_];
            _loc7_ = _loc5_.TemplateName.split(",");
            if(_loc7_[0] > param1 && !_loc2_)
            {
               _loc8_ = _loc5_.Grades;
               _loc2_ = true;
            }
            if(_loc7_[1] > param1 && !_loc9_)
            {
               _loc3_ = _loc5_.Grades;
               _loc9_ = true;
            }
            _loc6_++;
         }
         return [_loc8_,_loc3_];
      }
      
      public function getCanLearnMaxGrade(param1:int) : Array
      {
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(param1,156);
         if(!_loc2_)
         {
            return [0,0];
         }
         return _loc2_.TemplateName.split(",");
      }
      
      public function get upgradeDic() : SimpleDictionary
      {
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc4_:SimpleDictionary = new SimpleDictionary();
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(157);
         _loc1_.sortOn("Grades",16);
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            if(!_loc4_.hasOwnProperty(_loc2_.ActiveObject))
            {
               _loc4_.add(_loc2_.ActiveObject,_loc2_.Grades);
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function getLearnCount(param1:int, param2:int) : int
      {
         if(param1 == 31)
         {
            return 100 * Math.pow(param2,2) - 100 * param2 + 100;
         }
         if(param1 == 32)
         {
            return 75 * Math.pow(param2,2) - 75 * param2 + 150;
         }
         return 0;
      }
   }
}

