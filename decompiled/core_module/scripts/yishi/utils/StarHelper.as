package yishi.utils
{
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.datas.templates.StarTemplate;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   
   public class StarHelper
   {
      
      public static var profileColors:Array;
      
      public function StarHelper()
      {
         super();
      }
      
      public static function getProfileNameByProfile(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName01");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName02");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName03");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName04");
               break;
            case 4:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName05");
               break;
            case 5:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName06");
               break;
            case 6:
               _loc2_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName07");
         }
         return _loc2_;
      }
      
      public static function getStarUpgradeListByProfile(param1:int) : Array
      {
         var _loc2_:int = 0;
         switch(param1 - 2)
         {
            case 0:
               _loc2_ = 9;
               break;
            case 1:
               _loc2_ = 10;
               break;
            case 2:
               _loc2_ = 11;
               break;
            case 3:
               _loc2_ = 12;
               break;
            case 4:
               _loc2_ = 13;
               break;
            case 5:
               _loc2_ = 22;
         }
         return TempleteManager.instance.getTemplatesByType(_loc2_);
      }
      
      public static function getStarMaxGradeByProfile(param1:int) : int
      {
         var _loc2_:Array = getStarUpgradeListByProfile(param1);
         var _loc3_:int = -1;
         for each(var _loc4_:UpgradeTemplateInfo in _loc2_)
         {
            if(_loc4_.Grades > _loc3_)
            {
               _loc3_ = _loc4_.Grades;
            }
         }
         return _loc3_;
      }
      
      public static function checkCanUpGrade(param1:int, param2:StarInfo) : int
      {
         var _loc5_:int = param2.grade;
         var _loc3_:Array = getStarUpgradeListByProfile(param2.template.Profile);
         _loc3_.sortOn("Grades",16);
         for each(var _loc4_:UpgradeTemplateInfo in _loc3_)
         {
            if(_loc4_.Grades == param2.grade + 1)
            {
               param1 -= _loc4_.Data - param2.gp;
            }
            if(_loc4_.Grades > param2.grade + 1)
            {
               param1 -= _loc4_.Data;
            }
            if(param1 < 0)
            {
               break;
            }
            _loc5_ = _loc4_.Grades;
         }
         return _loc5_;
      }
      
      public static function getStarTotalExp(param1:StarInfo) : int
      {
         var _loc6_:int = 0;
         var _loc4_:int = param1.grade;
         var _loc7_:int = param1.template.Profile;
         var _loc2_:int = param1.gp + param1.template.SellGp;
         if(param1.template.Profile == 8)
         {
            _loc4_ = 10;
            _loc7_ = 7;
            _loc2_ = 91;
         }
         var _loc3_:Array = getStarUpgradeListByProfile(_loc7_);
         for each(var _loc5_:UpgradeTemplateInfo in _loc3_)
         {
            if(_loc4_ >= _loc5_.Grades)
            {
               _loc6_ += _loc5_.Data;
            }
         }
         return int(_loc6_ + _loc2_);
      }
      
      public static function getStarExp(param1:int, param2:int) : int
      {
         var _loc3_:Array = getStarUpgradeListByProfile(param2);
         for each(var _loc4_:UpgradeTemplateInfo in _loc3_)
         {
            if(param1 == _loc4_.Grades)
            {
               return _loc4_.Data;
            }
         }
         return 0;
      }
      
      public static function getStarAttributeAdd(param1:StarInfo) : String
      {
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
         if(param1.template.Power * param1.grade > 0)
         {
            _loc2_ = _loc2_ + "+" + param1.template.Power * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.Agility * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
            _loc2_ = _loc2_ + "+" + param1.template.Agility * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.Intellect * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
            _loc2_ = _loc2_ + "+" + param1.template.Intellect * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.Physique * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
            _loc2_ = _loc2_ + "+" + param1.template.Physique * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.Captain * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
            _loc2_ = _loc2_ + "+" + param1.template.Captain * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.Attack * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
            _loc2_ = _loc2_ + "+" + param1.template.Attack * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.Defence * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
            _loc2_ = _loc2_ + "+" + param1.template.Defence * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.MagicAttack * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
            _loc2_ = _loc2_ + "+" + param1.template.MagicAttack * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.MagicDefence * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
            _loc2_ = _loc2_ + "+" + param1.template.MagicDefence * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.ForceHit * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
            _loc2_ = _loc2_ + "+" + param1.template.ForceHit * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.Live * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
            _loc2_ = _loc2_ + "+" + param1.template.Live * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.Conat * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
            _loc2_ = _loc2_ + "+" + param1.template.Conat * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(param1.template.Parry * param1.grade > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
            _loc2_ = _loc2_ + "+" + param1.template.Parry * param1.grade;
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc2_ += " " + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc2_ = _loc2_ + "+" + param1.template.Penetrate * param1.grade + " ";
            }
            return _loc2_;
         }
         if(!StringHelper.isNullOrEmpty(param1.template.DefaultSkill))
         {
            return getStarBufferName(param1);
         }
         return "";
      }
      
      public static function getStarBufferName(param1:StarInfo, param2:int = 0) : String
      {
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:BufferTemplateInfo = TempleteManager.instance.bufferTemplateCate.getTemplateByID(int(param1.template.DefaultSkill));
         if(_loc5_)
         {
            _loc4_ = StringHelper.getSubStrBetweenTwoChar("{","}",_loc5_.BufferName);
            if(StringHelper.isNullOrEmpty(_loc4_))
            {
               return _loc5_.BufferName;
            }
            _loc6_ = Math.abs(_loc5_[_loc4_]) * param1.grade + param2;
            if(_loc5_.ValuePercent == 0)
            {
               _loc6_ = Math.abs(_loc5_[_loc4_]) * param1.grade * (1 + param2 * 0.01);
            }
            _loc3_ = int(_loc5_.hasOwnProperty(_loc4_) ? _loc6_ : 0);
            return StringHelper.replaceStr(_loc5_.BufferName,"{" + _loc4_ + "}",String(_loc3_));
         }
         return "";
      }
      
      public static function getStarHtmlName(param1:StarTemplate) : String
      {
         if(!param1)
         {
            return "";
         }
         if(!profileColors)
         {
            profileColors = ["#ffffff","#999999","#59cd41","#32a2f8","#a838f7","#ff8000","#ce0f0f","#ce0f0f"];
         }
         var _loc2_:String = profileColors[param1.Profile];
         if(_loc2_)
         {
            return LanguageMgr.GetTranslation("StarHelper.tempTxt",_loc2_,param1.TemplateName);
         }
         return param1.TemplateName;
      }
      
      public static function getStarPowerByList(param1:SimpleDictionary, param2:Number = 0) : int
      {
         var _loc3_:int = 0;
         for each(var _loc4_:Object in param1)
         {
            if(_loc4_ is StarInfo)
            {
               _loc3_ += StarHelper.getStarTotalExp(_loc4_ as StarInfo);
            }
         }
         _loc3_ /= 10;
         return _loc3_ * (1 + param2 / 100);
      }
      
      public static function checkExistStarInfoInDic(param1:SimpleDictionary) : Boolean
      {
         for each(var _loc2_:Object in param1)
         {
            if(_loc2_ is StarInfo)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getThirdJobStr() : String
      {
         var _loc1_:int = ArmyManager.instance.thane.job;
         switch(_loc1_ - 1)
         {
            case 0:
            case 3:
               return LanguageMgr.GetTranslation("yishi.utils.StarHelper.getThirdJobStr01");
            case 1:
            case 4:
               return LanguageMgr.GetTranslation("yishi.utils.StarHelper.getThirdJobStr02");
            case 2:
            case 5:
               return LanguageMgr.GetTranslation("yishi.utils.StarHelper.getThirdJobStr03");
            default:
               return "";
         }
      }
   }
}

