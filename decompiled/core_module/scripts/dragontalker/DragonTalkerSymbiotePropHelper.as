package dragontalker
{
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleDictionary;
   
   public class DragonTalkerSymbiotePropHelper
   {
      
      public function DragonTalkerSymbiotePropHelper()
      {
         super();
      }
      
      public static function get heroEquipPropDic() : SimpleDictionary
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc7_:int = 0;
         var _loc1_:DragonTalkerSymbioteInfo = null;
         var _loc4_:SimpleDictionary = new SimpleDictionary(true);
         var _loc10_:SimpleDictionary = GoodsManager.instance.getHeroGoodsListByTypeAndId(1,thane.id);
         var _loc8_:int = 4;
         var _loc9_:Array = [0,1,2,3,4,5,6,7];
         var _loc2_:int = int(_loc9_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = int(_loc9_[_loc5_]);
            if(_loc10_[_loc3_ + "_" + _loc8_])
            {
               _loc6_ = _loc10_[_loc3_ + "_" + _loc8_];
               _loc7_ = DragonTalkerViewHelper.GetIndexByPos(_loc3_);
               _loc1_ = dragonTalkerModel.getSymbioteInfoByIndex(_loc7_);
               getStrengthAndMould(_loc6_,_loc1_,_loc4_);
               getMountGemAdd(_loc6_,_loc1_,_loc4_);
               getRefreshSkillAdd(_loc6_,_loc1_,_loc4_);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private static function getStrengthAndMould(param1:GoodsInfo, param2:DragonTalkerSymbioteInfo, param3:SimpleDictionary) : void
      {
         var _loc8_:int = 0;
         var _loc12_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc6_:GoodsTemplateInfo = param1.templateInfo;
         var _loc9_:Array = _loc6_.hasValueAtt;
         var _loc7_:int = int(_loc9_.length);
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc12_ = _loc9_[_loc8_];
            _loc4_ = int(_loc6_[_loc12_]);
            _loc5_ = getAdd(_loc4_,param1);
            _loc10_ = getNewAdd(_loc4_,param1);
            _loc11_ = _loc4_ + _loc5_ + getConciseValue(_loc5_,param1) + _loc10_ + getConciseValue(_loc10_,param1);
            if(param2 && param2.addPercent != 0)
            {
               _loc11_ = Math.floor(_loc11_ * param2.addPercent / 100);
            }
            if(param3[_loc12_])
            {
               param3.add(_loc12_,_loc11_ + param3[_loc12_]);
            }
            else
            {
               param3.add(_loc12_,_loc11_);
            }
            _loc8_++;
         }
      }
      
      private static function getMountGemAdd(param1:GoodsInfo, param2:DragonTalkerSymbioteInfo, param3:SimpleDictionary) : void
      {
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         var _loc14_:int = 0;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc8_:Array = null;
         var _loc12_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc13_:int = 0;
         var _loc5_:GoodsTemplateInfo = param1.templateInfo;
         if(param1 && _loc5_ && _loc5_.StrengthenMax > 0)
         {
            _loc11_ = _loc5_.Profile >= 5 ? 4 : 3;
         }
         _loc6_ = 1;
         while(_loc6_ <= _loc11_)
         {
            _loc14_ = int(param1["join" + _loc6_]);
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc14_);
            if(_loc4_)
            {
               _loc8_ = _loc4_.hasValueAtt;
               _loc12_ = int(_loc8_.length);
               _loc7_ = 0;
               while(_loc7_ < _loc12_)
               {
                  _loc9_ = _loc8_[_loc7_];
                  _loc10_ = int(_loc4_[_loc9_]);
                  _loc13_ = getAddDiscription(_loc14_,param1.objectId,_loc10_);
                  if(param2 && param2.addPercent != 0)
                  {
                     _loc13_ = Math.floor(_loc13_ * param2.addPercent / 100);
                  }
                  if(param3[_loc9_])
                  {
                     param3.add(_loc9_,_loc13_ + param3[_loc9_]);
                  }
                  else
                  {
                     param3.add(_loc9_,_loc13_);
                  }
                  _loc7_++;
               }
            }
            _loc6_++;
         }
      }
      
      private static function getRefreshSkillAdd(param1:GoodsInfo, param2:DragonTalkerSymbioteInfo, param3:SimpleDictionary) : void
      {
         var _loc6_:int = 0;
         var _loc8_:SkillTempInfo = null;
         var _loc11_:SkillPropertyTempInfo = null;
         var _loc9_:Array = null;
         var _loc13_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:String = null;
         var _loc12_:int = 0;
         var _loc15_:int = 0;
         var _loc14_:String = "";
         var _loc4_:Boolean = false;
         _loc6_ = 1;
         while(_loc6_ < 6)
         {
            _loc14_ += param1["randomSkill" + _loc6_] + ",";
            if(param1["randomSkill" + _loc6_] != 0)
            {
               _loc4_ = true;
            }
            _loc6_++;
         }
         if(_loc4_ == false)
         {
            _loc14_ = param1.templateInfo.DefaultSkill;
         }
         var _loc5_:Array = TempleteManager.instance.getSkillTemplateInfoByIds(_loc14_);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc8_ = _loc5_[_loc6_] as SkillTempInfo;
            if(_loc8_)
            {
               _loc11_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc8_.TemplateId);
               if(_loc11_)
               {
                  _loc9_ = _loc11_.hasValueAtt;
                  _loc13_ = int(_loc9_.length);
                  _loc7_ = 0;
                  while(_loc7_ < _loc13_)
                  {
                     _loc10_ = _loc9_[_loc7_];
                     _loc12_ = int(_loc11_[_loc10_]);
                     _loc15_ = _loc12_ + GoodsHelp.getConciseValue(_loc12_,thane.conciseGrades);
                     if(param2 && param2.addPercent != 0)
                     {
                        _loc15_ = Math.floor(_loc15_ * param2.addPercent / 100);
                     }
                     if(param3[_loc10_])
                     {
                        param3.add(_loc10_,_loc15_ + param3[_loc10_]);
                     }
                     else
                     {
                        param3.add(_loc10_,_loc15_);
                     }
                     _loc7_++;
                  }
               }
            }
            _loc6_++;
         }
      }
      
      public static function get talismanPropDic() : SimpleDictionary
      {
         var _loc4_:int = 0;
         var _loc2_:DragonTalkerTalismanInfo = null;
         var _loc13_:DragonTalkerSymbioteInfo = null;
         var _loc21_:Array = null;
         var _loc1_:int = 0;
         var _loc11_:int = 0;
         var _loc5_:int = 0;
         var _loc20_:String = null;
         var _loc18_:int = 0;
         var _loc12_:Array = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc19_:int = 0;
         var _loc7_:SkillTempInfo = null;
         var _loc9_:SkillPropertyTempInfo = null;
         var _loc14_:Array = null;
         var _loc22_:int = 0;
         var _loc10_:int = 0;
         var _loc17_:String = null;
         var _loc23_:int = 0;
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         var _loc16_:Array = dragonTalkerModel.talismanEquipList;
         var _loc15_:int = int(_loc16_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc15_)
         {
            _loc2_ = _loc16_[_loc4_];
            _loc13_ = DragonTalkerViewHelper.getSymbioteInfoByTalisman(_loc2_);
            _loc21_ = _loc2_.goodsTempInfo.hasValueAtt;
            _loc1_ = _loc2_.specialPercent;
            _loc11_ = int(_loc21_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc11_)
            {
               _loc20_ = _loc21_[_loc5_];
               _loc18_ = int(_loc2_.goodsTempInfo[_loc20_]);
               _loc18_ = _loc18_ + DragonTalkerViewHelper.getAddMainValue(_loc18_,_loc2_);
               if(_loc1_ != 0)
               {
                  _loc18_ += Math.floor(_loc18_ * _loc1_ / 100);
               }
               if(_loc13_ && _loc13_.addPercent != 0)
               {
                  _loc18_ = Math.floor(_loc18_ * _loc13_.addPercent / 100);
               }
               if(_loc3_[_loc20_])
               {
                  _loc3_.add(_loc20_,_loc18_ + _loc3_[_loc20_]);
               }
               else
               {
                  _loc3_.add(_loc20_,_loc18_);
               }
               _loc5_++;
            }
            _loc12_ = _loc2_.randomSkillList;
            _loc8_ = int(_loc12_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc19_ = int(_loc12_[_loc6_]);
               if(_loc19_ != 0)
               {
                  _loc7_ = TempleteManager.instance.skillTemplateDic[_loc19_];
                  if(!(_loc7_ && _loc7_.SonType == 435))
                  {
                     _loc9_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc19_);
                     _loc14_ = _loc9_.hasValueAtt;
                     _loc22_ = int(_loc14_.length);
                     _loc10_ = 0;
                     while(_loc10_ < _loc22_)
                     {
                        _loc17_ = _loc14_[_loc10_];
                        _loc23_ = int(_loc9_[_loc17_]);
                        if(_loc1_ != 0)
                        {
                           _loc23_ += Math.floor(_loc23_ * _loc1_ / 100);
                        }
                        if(_loc13_ && _loc13_.addPercent != 0)
                        {
                           _loc23_ = Math.floor(_loc23_ * _loc13_.addPercent / 100);
                        }
                        if(_loc3_[_loc17_])
                        {
                           _loc3_.add(_loc17_,_loc23_ + _loc3_[_loc17_]);
                        }
                        else
                        {
                           _loc3_.add(_loc17_,_loc23_);
                        }
                        _loc10_++;
                     }
                  }
               }
               _loc6_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function getAdd(param1:int, param2:GoodsInfo) : int
      {
         return GoodsHelp.getStrengthenAddition(param1,param2.strengthenGrade);
      }
      
      private static function getNewAdd(param1:int, param2:GoodsInfo) : int
      {
         var _loc4_:int = 0;
         var _loc3_:GoodsTemplateInfo = param2.templateInfo;
         if(_loc3_.StrengthenMax > 0 && _loc3_.Profile >= 5 && _loc3_.NeedGrades >= 50)
         {
            if(param2.mouldGrade > 0)
            {
               return GoodsHelp.getMouldAddition(param1,getPropertyMouldGrade(param2));
            }
         }
         return 0;
      }
      
      private static function getConciseValue(param1:int, param2:GoodsInfo) : int
      {
         var _loc3_:int = 0;
         if(param2.objectId == thane.id)
         {
            _loc3_ = GoodsHelp.getConciseValue(param1,thane.conciseGrades);
         }
         return _loc3_;
      }
      
      private static function getPropertyMouldGrade(param1:GoodsInfo) : int
      {
         if(param1.mouldGrade < 1)
         {
            return 1;
         }
         if(param1.mouldGrade > param1.MOULD_MAX_GRADE)
         {
            return param1.MOULD_MAX_GRADE;
         }
         return param1.mouldGrade;
      }
      
      private static function getAddDiscription(param1:int, param2:int, param3:int = -1) : int
      {
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         if(param2 == thane.id)
         {
            _loc5_ = uint(param3 > 0 ? param3 : _loc4_.totalAttribute);
            _loc6_ = _loc5_ * GoodsHelp.getJewelEffecyByGrade(thane.jewelGrades) / 100;
            if(thane.jewelGrades >= 80 && thane.vocationGrades > 0)
            {
               _loc6_ = _loc5_ * GoodsHelp.getSeniorJewelEffecyByGrade(thane.seniorStoreGrade) / 100;
            }
            if(_loc6_ > 0)
            {
               _loc6_ += GoodsHelp.getConciseValue(_loc6_ + _loc5_,thane.conciseGrades);
            }
            return _loc5_ + _loc6_;
         }
         return 0;
      }
      
      private static function get dragonTalkerModel() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

