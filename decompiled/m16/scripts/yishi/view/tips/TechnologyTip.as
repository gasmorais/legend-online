package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.playerinfo.PlayerEffectInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   
   public class TechnologyTip extends BaseTip
   {
      
      private var _vBox:VBox;
      
      private var _line1:ScaleBitmapImage;
      
      private var _line2:ScaleBitmapImage;
      
      private var _name:FilterFrameText;
      
      private var _current:Sprite;
      
      private var _currentEffect:FilterFrameText;
      
      private var _currentEffectValue:FilterFrameText;
      
      private var _next:Sprite;
      
      private var _nextEffect:FilterFrameText;
      
      private var _nextEffectValue:FilterFrameText;
      
      private var _nextGrade:FilterFrameText;
      
      private var _gradeContain:Sprite;
      
      private var _grade:FilterFrameText;
      
      private var _gradeValue:FilterFrameText;
      
      private var _preContain:Sprite;
      
      private var _preBuild:FilterFrameText;
      
      private var _preBuildValue:FilterFrameText;
      
      private var _resource:Component;
      
      private var _needResource:FilterFrameText;
      
      private var _needResourceValue:FilterFrameText;
      
      public function TechnologyTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 280;
         _vBox = new VBox();
         _vBox.y = 10;
         _vBox.spacing = 5;
         _line1 = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         _line2 = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         _line1.width = _line2.width = _bg.width - 15;
         _name = ComponentFactory.Instance.creatComponentByStylename("tips.BuildNameText");
         _currentEffect = ComponentFactory.Instance.creatComponentByStylename("tips.BuildEffectText");
         _currentEffectValue = ComponentFactory.Instance.creatComponentByStylename("tips.BuildEffectValueText");
         _nextEffect = ComponentFactory.Instance.creatComponentByStylename("tips.BuildEffectText");
         _nextEffectValue = ComponentFactory.Instance.creatComponentByStylename("tips.BuildEffectValueText");
         _nextGrade = ComponentFactory.Instance.creatComponentByStylename("tips.BuildNextGradeText");
         _preBuild = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildText");
         _preBuildValue = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         _preBuildValue.x = 153;
         _grade = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildText");
         _gradeValue = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         _needResource = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildText");
         _needResource.y = 4;
         _needResourceValue = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildResourcesValueText");
         _needResourceValue.y = 4;
         _current = new Sprite();
         _current.addChild(_currentEffect);
         _current.addChild(_currentEffectValue);
         _next = new Sprite();
         _next.addChild(_nextEffect);
         _next.addChild(_nextEffectValue);
         _gradeContain = new Sprite();
         _gradeContain.addChild(_grade);
         _gradeContain.addChild(_gradeValue);
         _preContain = new Sprite();
         _preContain.addChild(_preBuild);
         _preContain.addChild(_preBuildValue);
         _resource = new Component();
         addChild(_vBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:BuildingTempInfo = null;
         var _loc2_:BuildingTempInfo = null;
         if(tipData)
         {
            _vBox.removeAllChild();
            _loc1_ = (tipData as BuildInfo).templeteInfo;
            _name.text = _loc1_.BuildingName + " " + LanguageMgr.GetTranslation("public.level2",_loc1_.BuildingGrade);
            _currentEffect.text = LanguageMgr.GetTranslation("yishi.view.tips.TechnologyTip.currentGrade");
            _currentEffectValue.text = _loc1_.Activity;
            _currentEffectValue.height = _currentEffectValue.textHeight + 4;
            _vBox.addChild(_name);
            _vBox.addChild(_line1);
            _vBox.addChild(_current);
            _loc2_ = getNextGrade(_loc1_);
            if(!_loc2_)
            {
               _nextGrade.text = LanguageMgr.GetTranslation("yishi.view.tips.TechnologyTip.topGrade");
               _vBox.addChild(_line2);
               _vBox.addChild(_nextGrade);
            }
            else
            {
               refreshNextTemp(_loc2_);
               refreshPlayerGrade(_loc2_);
               refreshPreBuild(_loc2_);
               refreshResource(_loc2_);
            }
            _vBox.refreshChildPos();
            _bg.height = _vBox.displayHeight + 20;
            _bg.width = _vBox.width + 20;
         }
      }
      
      private function refreshNextTemp(param1:BuildingTempInfo) : void
      {
         if(param1)
         {
            _nextEffect.text = LanguageMgr.GetTranslation("yishi.view.tips.TechnologyTip.nextEffect.text");
            _nextEffectValue.text = param1.Activity;
            _nextEffectValue.height = _nextEffectValue.textHeight + 4;
            _nextGrade.text = LanguageMgr.GetTranslation("yishi.view.tips.TechnologyTip.nextGrade.text");
            _vBox.addChild(_next);
            _vBox.addChild(_line2);
            _vBox.addChild(_nextGrade);
         }
      }
      
      private function refreshPlayerGrade(param1:BuildingTempInfo) : void
      {
         if(param1 && thane.grades < param1.PlayerGrades)
         {
            _grade.text = LanguageMgr.GetTranslation("yishi.view.tips.TechnologyTip.grade.text");
            _gradeValue.text = LanguageMgr.GetTranslation("yishi.view.tips.TechnologyTip.gradeValue.text") + " " + LanguageMgr.GetTranslation("public.level2",param1.PlayerGrades);
            _gradeValue.height = _gradeValue.textHeight + 4;
            _gradeValue.setFrame(2);
            _vBox.addChild(_gradeContain);
         }
      }
      
      private function refreshPreBuild(param1:BuildingTempInfo) : void
      {
         var _loc4_:BuildInfo = null;
         var _loc2_:Boolean = false;
         var _loc3_:Array = BuildingManager.instance.getPreBuildingList(param1);
         if(_loc3_.length == 0)
         {
            return;
         }
         for each(var _loc5_:BuildingTempInfo in _loc3_)
         {
            _loc4_ = BuildingManager.instance.getBuildingInfoBySonType(_loc5_.SonType);
            if(!_loc4_ || _loc4_.templeteInfo.BuildingGrade < _loc5_.BuildingGrade)
            {
               _preBuild.text = LanguageMgr.GetTranslation("yishi.view.tips.TechnologyTip.preBuild.text");
               _preBuildValue.text = _loc5_.BuildingName + " " + LanguageMgr.GetTranslation("public.level2",_loc5_.BuildingGrade);
               _preBuildValue.height = _preBuildValue.textHeight + 4;
               _preBuildValue.setFrame(2);
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            _vBox.addChild(_preContain);
         }
      }
      
      private function refreshResource(param1:BuildingTempInfo) : void
      {
         var _loc4_:Dictionary = null;
         var _loc3_:DisplayObject = null;
         while(_resource.numChildren > 0)
         {
            _resource.removeChildAt(0);
         }
         if(_data)
         {
            _loc4_ = (tipData as BuildInfo).getNextNeedResource(param1);
         }
         else
         {
            _loc4_ = new Dictionary();
            _loc4_["CrystalsConsume"] = param1.CrystalsConsume;
            _loc4_["GoldConsume"] = param1.GoldConsume;
            _loc4_["PopuliationConsume"] = param1.PopuliationConsume;
         }
         for(var _loc2_:String in _loc4_)
         {
            if(_loc4_[_loc2_] != 0)
            {
               _needResource.text = LanguageMgr.GetTranslation("yishi.view.tips.TechnologyTip.needResource.text");
               _needResourceValue.text = String(_loc4_[_loc2_]);
               switch(_loc2_)
               {
                  case "CrystalsConsume":
                     _loc3_ = ComponentFactory.Instance.creatComponentByStylename("tips.CrystalIcon");
                     if(_loc4_[_loc2_] > ResourceManager.instance.waterCrystal.count)
                     {
                        _needResourceValue.setFrame(2);
                     }
                     else
                     {
                        _needResourceValue.setFrame(1);
                     }
                     break;
                  case "GoldConsume":
                     if(_loc4_[_loc2_] > ResourceManager.instance.gold.count)
                     {
                        _needResourceValue.setFrame(2);
                     }
                     else
                     {
                        _needResourceValue.setFrame(1);
                     }
                     _loc3_ = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.GoldIcoImg");
                     break;
                  case "PopuliationConsume":
                     _loc3_ = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.PopulationIcoImg");
                     break;
                  default:
                     return;
               }
               _resource.addChild(_loc3_);
               _resource.addChild(_needResource);
               _resource.addChild(_needResourceValue);
               _vBox.addChild(_resource);
            }
         }
         _loc3_.x = 145;
         _needResourceValue.x = _loc3_.x + _loc3_.width;
      }
      
      private function get playerEffect() : PlayerEffectInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerEffect;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function getNextGrade(param1:BuildingTempInfo) : BuildingTempInfo
      {
         if(param1.NextGradeTemplateId != 0)
         {
            return TempleteManager.instance.buildTemplateCate.getTemplateByID(int(param1.NextGradeTemplateId));
         }
         return null;
      }
      
      override public function dispose() : void
      {
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
         }
         _line1 = null;
         if(_line2)
         {
            ObjectUtils.disposeObject(_line2);
         }
         _line2 = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_current)
         {
            ObjectUtils.disposeObject(_current);
         }
         _current = null;
         if(_currentEffect)
         {
            ObjectUtils.disposeObject(_currentEffect);
         }
         _currentEffect = null;
         if(_currentEffectValue)
         {
            ObjectUtils.disposeObject(_currentEffectValue);
         }
         _currentEffectValue = null;
         if(_next)
         {
            ObjectUtils.disposeObject(_next);
         }
         _next = null;
         if(_nextEffect)
         {
            ObjectUtils.disposeObject(_nextEffect);
         }
         _nextEffect = null;
         if(_nextEffectValue)
         {
            ObjectUtils.disposeObject(_nextEffectValue);
         }
         _nextEffectValue = null;
         if(_nextGrade)
         {
            ObjectUtils.disposeObject(_nextGrade);
         }
         _nextGrade = null;
         if(_preContain)
         {
            ObjectUtils.disposeObject(_preContain);
         }
         _preContain = null;
         if(_gradeContain)
         {
            ObjectUtils.disposeObject(_gradeContain);
         }
         _gradeContain = null;
         if(_grade)
         {
            ObjectUtils.disposeObject(_grade);
         }
         _grade = null;
         if(_gradeValue)
         {
            ObjectUtils.disposeObject(_gradeValue);
         }
         _gradeValue = null;
         if(_preBuild)
         {
            ObjectUtils.disposeObject(_preBuild);
         }
         _preBuild = null;
         if(_preBuildValue)
         {
            ObjectUtils.disposeObject(_preBuildValue);
         }
         _preBuildValue = null;
         if(_resource)
         {
            ObjectUtils.disposeObject(_resource);
         }
         _resource = null;
         if(_needResource)
         {
            ObjectUtils.disposeObject(_needResource);
         }
         _needResource = null;
         if(_needResourceValue)
         {
            ObjectUtils.disposeObject(_needResourceValue);
         }
         _needResourceValue = null;
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

