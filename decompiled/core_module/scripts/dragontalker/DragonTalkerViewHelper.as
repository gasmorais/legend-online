package dragontalker
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class DragonTalkerViewHelper
   {
      
      public function DragonTalkerViewHelper()
      {
         super();
      }
      
      public static function SetPropTextView(param1:int, param2:VBox, param3:DragonTalkerTalismanInfo, param4:Boolean = false) : void
      {
         var _loc9_:DragonTalkerSymbioteInfo = null;
         var _loc8_:int = 0;
         var _loc12_:String = null;
         var _loc24_:int = 0;
         var _loc7_:FilterFrameText = null;
         var _loc25_:int = 0;
         var _loc23_:FilterFrameText = null;
         var _loc27_:SkillTempInfo = null;
         var _loc18_:SkillTempInfo = null;
         var _loc19_:SkillPropertyTempInfo = null;
         var _loc22_:Array = null;
         var _loc14_:int = 0;
         var _loc17_:int = 0;
         var _loc10_:String = null;
         var _loc15_:int = 0;
         if(!param3)
         {
            return;
         }
         if(param4)
         {
            _loc9_ = getSymbioteInfoByTalisman(param3);
         }
         var _loc16_:int = 0;
         var _loc13_:Array = param3.goodsTempInfo.hasValueAtt;
         var _loc5_:int = param3.specialPercent;
         var _loc28_:int = param3.specialColor;
         var _loc20_:int = int(_loc13_.length);
         var _loc26_:String = "";
         var _loc11_:String = "";
         _loc16_ = 0;
         while(_loc16_ < _loc20_)
         {
            _loc12_ = _loc13_[_loc16_];
            _loc24_ = int(param3.goodsTempInfo[_loc12_]);
            _loc24_ = _loc24_ + getAddMainValue(_loc24_,param3);
            if(param1 == 1 && _loc5_ != 0)
            {
               _loc8_ = Math.floor(_loc24_ * _loc5_ / 100);
               if(_loc8_ != 0)
               {
                  _loc26_ = GetTextColorByProfile(_loc28_,"+" + _loc8_);
               }
            }
            if(_loc9_ && _loc9_.addPercent != 0)
            {
               _loc24_ = Math.floor(_loc24_ * _loc9_.addPercent / 100);
               _loc8_ = Math.floor(_loc8_ * _loc9_.addPercent / 100);
               if(_loc8_ != 0)
               {
                  _loc26_ = GetTextColorByProfile(_loc28_,"+" + _loc8_);
               }
            }
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.mainAttText");
            _loc11_ = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc12_,_loc24_) + " " + _loc26_;
            _loc7_.setFrame(param3.goodsTempInfo.Profile);
            _loc7_.htmlText = _loc11_;
            param2.addChild(_loc7_);
            _loc16_++;
         }
         var _loc21_:Array = param3.randomSkillList;
         var _loc6_:int = int(_loc21_.length);
         _loc16_ = 0;
         while(_loc16_ < _loc6_)
         {
            _loc25_ = int(_loc21_[_loc16_]);
            _loc23_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.randomText");
            if(_loc16_ == _loc6_ - 1 && param1 != 1)
            {
               _loc23_.height = 36;
               _loc23_.width = 145;
               _loc23_.wordWrap = true;
            }
            else
            {
               _loc23_.height = 20;
               _loc23_.width = 240;
               _loc23_.wordWrap = false;
            }
            if(_loc25_ == 0)
            {
               _loc23_.htmlText = LanguageMgr.GetTranslation("DragonTalkerIntensifyView.randomText.typeText" + _loc16_);
               _loc23_.setFrame(7);
            }
            else if(_loc16_ == 2)
            {
               _loc27_ = TempleteManager.instance.skillTemplateDic[_loc25_];
               _loc23_.htmlText = _loc27_.TemplateName;
               _loc23_.setFrame(_loc27_.Grades);
            }
            else
            {
               _loc18_ = TempleteManager.instance.skillTemplateDic[_loc25_];
               _loc19_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc25_);
               _loc22_ = _loc19_.hasValueAtt;
               _loc14_ = int(_loc22_.length);
               _loc23_.setFrame(_loc18_.Grades);
               _loc17_ = 0;
               while(_loc17_ < _loc14_)
               {
                  _loc10_ = _loc22_[_loc17_];
                  _loc15_ = int(_loc19_[_loc10_]);
                  if(param1 == 1 && _loc5_ != 0)
                  {
                     _loc8_ = Math.floor(_loc15_ * _loc5_ / 100);
                     if(_loc8_ != 0)
                     {
                        _loc26_ = GetTextColorByProfile(_loc28_,"+" + _loc8_);
                     }
                  }
                  if(_loc9_ && _loc9_.addPercent != 0)
                  {
                     _loc15_ = Math.floor(_loc15_ * _loc9_.addPercent / 100);
                     _loc8_ = Math.floor(_loc8_ * _loc9_.addPercent / 100);
                     if(_loc8_ != 0)
                     {
                        _loc26_ = GetTextColorByProfile(_loc28_,"+" + _loc8_);
                     }
                  }
                  _loc23_.htmlText += LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc10_,_loc15_) + " " + _loc26_;
                  _loc17_++;
               }
            }
            param2.addChild(_loc23_);
            _loc16_++;
         }
      }
      
      public static function getAddMainValue(param1:int, param2:DragonTalkerTalismanInfo) : int
      {
         return int(param1 * param2.grade * 0.02);
      }
      
      public static function GetTextColorByProfile(param1:int, param2:String) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "<font color=\'#ffffff\'>" + param2 + "</font>";
            case 1:
               return "<font color=\'#59cd41\'>" + param2 + "</font>";
            case 2:
               return "<font color=\'#32a2f8\'>" + param2 + "</font>";
            case 3:
               return "<font color=\'#a838f7\'>" + param2 + "</font>";
            case 4:
               return "<font color=\'#ff8000\'>" + param2 + "</font>";
            case 5:
               return "<font color=\'#ce0f0f\'>" + param2 + "</font>";
            default:
               return "<font color=\'#ffffff\'>" + param2 + "</font>";
         }
      }
      
      public static function GetEquipPosBySontype(param1:int) : Array
      {
         var _loc2_:Array = [];
         switch(param1 - 401)
         {
            case 0:
               _loc2_.push(1);
               break;
            case 1:
               _loc2_.push(4);
               _loc2_.push(5);
               break;
            case 2:
               _loc2_.push(0);
               break;
            case 3:
               _loc2_.push(3);
               break;
            case 4:
               _loc2_.push(6);
               _loc2_.push(7);
               break;
            case 5:
               _loc2_.push(2);
         }
         return _loc2_;
      }
      
      public static function GetIndexByPos(param1:int) : int
      {
         var _loc2_:int = -1;
         switch(param1)
         {
            case 0:
               _loc2_ = 2;
               break;
            case 1:
               _loc2_ = 0;
               break;
            case 2:
               _loc2_ = 5;
               break;
            case 3:
               _loc2_ = 3;
               break;
            case 4:
            case 5:
               _loc2_ = 1;
               break;
            case 6:
            case 7:
               _loc2_ = 4;
         }
         return _loc2_;
      }
      
      public static function getSymbioteInfoByTalisman(param1:DragonTalkerTalismanInfo) : DragonTalkerSymbioteInfo
      {
         var _loc2_:int = -1;
         if(!param1)
         {
            return null;
         }
         switch(param1.equipPos - 401)
         {
            case 0:
               _loc2_ = 0;
               break;
            case 1:
               _loc2_ = 1;
               break;
            case 2:
               _loc2_ = 2;
               break;
            case 3:
               _loc2_ = 3;
               break;
            case 4:
               _loc2_ = 4;
               break;
            case 5:
               _loc2_ = 5;
               break;
            default:
               _loc2_ = -1;
         }
         return DragonTalkerManager.instance.model.getSymbioteInfoByIndex(_loc2_);
      }
   }
}

