package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.data.FarmInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class LandUpTip extends BaseTip
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
      
      private var _needResourceValueII:FilterFrameText;
      
      private var _time:Component;
      
      private var _needTime:FilterFrameText;
      
      private var _timeIcon:Bitmap;
      
      private var _needTimeValue:FilterFrameText;
      
      private var _outputUpPercent:int;
      
      private var _timeDownPercent:int;
      
      public function LandUpTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 245;
         _vBox = new VBox();
         _vBox.y = 10;
         _vBox.spacing = 5;
         _timeDownPercent = int(TempleteManager.instance.getConfigInfoByConfigName("FarmCrop_Mature_Percent").ConfigValue);
         _outputUpPercent = int(TempleteManager.instance.getConfigInfoByConfigName("FarmCrop_Gains_Percent").ConfigValue);
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
         _grade = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildText");
         _gradeValue = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         _needResource = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildText");
         _needResource.y = 4;
         _needResourceValue = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildResourcesValueText");
         _needResourceValue.autoSize = "left";
         _needResourceValue.x = 175;
         _needResourceValue.y = 5;
         _needResourceValueII = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildResourcesValueText");
         _needResourceValueII.autoSize = "left";
         _needResourceValueII.y = 6;
         _needTime = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildText");
         _needTimeValue = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         _needTimeValue.x += 15;
         _timeIcon = ComponentFactory.Instance.creatBitmap("asset.tips.TimeIcon");
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
         _time = new Component();
         _time.addChild(_needTime);
         _time.addChild(_timeIcon);
         _time.addChild(_needTimeValue);
         addChild(_vBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:FarmInfo = null;
         if(tipData)
         {
            _vBox.removeAllChild();
            _loc1_ = tipData as FarmInfo;
            _name.text = LanguageMgr.GetTranslation("farm.view.FarmBuildLayer.landLevelTip",_loc1_.landGrade);
            _currentEffect.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.current");
            if(_loc1_.landGrade - 1 > 0)
            {
               _currentEffectValue.text = LanguageMgr.GetTranslation("yishi.view.tips.LandUpTip.buff",(_loc1_.landGrade - 1) * _outputUpPercent,(_loc1_.landGrade - 1) * _timeDownPercent);
            }
            else
            {
               _currentEffectValue.text = LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
            }
            _currentEffectValue.height = _currentEffectValue.textHeight + 4;
            _vBox.addChild(_name);
            _vBox.addChild(_line1);
            _vBox.addChild(_current);
            if(_loc1_.landGrade >= 10)
            {
               _nextGrade.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.maxGrade");
               _vBox.addChild(_line2);
               _vBox.addChild(_nextGrade);
            }
            else
            {
               refreshNextGrade(_loc1_);
               refreshFarmGrade(_loc1_);
               refreshResource(_loc1_);
            }
            _vBox.refreshChildPos();
            _bg.height = _vBox.displayHeight + 20;
         }
      }
      
      private function refreshNextGrade(param1:FarmInfo) : void
      {
         if(param1)
         {
            _nextEffect.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.next");
            if(param1.landGrade > 0)
            {
               _nextEffectValue.text = LanguageMgr.GetTranslation("yishi.view.tips.LandUpTip.buff",param1.landGrade * _outputUpPercent,param1.landGrade * _timeDownPercent);
            }
            else
            {
               _nextEffectValue.text = LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
            }
            _nextEffectValue.height = _nextEffectValue.textHeight + 4;
            _nextGrade.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.need");
            _vBox.addChild(_next);
            _vBox.addChild(_line2);
            _vBox.addChild(_nextGrade);
         }
      }
      
      private function refreshFarmGrade(param1:FarmInfo) : void
      {
         if(param1 && param1.grade < 30)
         {
            _grade.text = LanguageMgr.GetTranslation("yishi.view.tips.LandUpTip.farmGrade");
            _gradeValue.text = LanguageMgr.GetTranslation("public.level2",30);
            _gradeValue.height = _gradeValue.textHeight + 4;
            _gradeValue.setFrame(2);
            _gradeValue.x = 140;
            _vBox.addChild(_gradeContain);
         }
      }
      
      private function refreshResource(param1:FarmInfo) : void
      {
         var _loc2_:int = 0;
         while(_resource.numChildren > 0)
         {
            _resource.removeChildAt(0);
         }
         _needResource.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.needResource");
         var _loc3_:Array = TempleteManager.instance.getConfigInfoByConfigName("FarmLand_Points").ConfigValue.split(",");
         if(param1.landGrade - 1 > _loc3_.length)
         {
            _loc2_ = int(_loc3_[_loc3_.length - 1]);
         }
         else
         {
            _loc2_ = int(_loc3_[param1.landGrade - 1]);
         }
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _loc4_.x = 157;
         _loc4_.y = 4;
         _needResourceValue.text = _loc2_ + "  ";
         playerInfo.point + playerInfo.giftToken < _loc2_ ? _needResourceValue.setFrame(2) : _needResourceValue.setFrame(1);
         _resource.addChild(_needResource);
         _resource.addChild(_loc4_);
         _resource.addChild(_needResourceValue);
         _vBox.addChild(_resource);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
         if(_needResourceValueII)
         {
            ObjectUtils.disposeObject(_needResourceValueII);
         }
         _needResourceValueII = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(_needTime)
         {
            ObjectUtils.disposeObject(_needTime);
         }
         _needTime = null;
         if(_timeIcon)
         {
            ObjectUtils.disposeObject(_timeIcon);
         }
         _timeIcon = null;
         if(_needTimeValue)
         {
            ObjectUtils.disposeObject(_needTimeValue);
         }
         _needTimeValue = null;
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

