package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.playerinfo.PlayerEffectInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class BuildTip extends BaseTip
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
      
      public function BuildTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 270;
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
         _grade = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildText");
         _gradeValue = ComponentFactory.Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         _current = new Sprite();
         _current.addChild(_currentEffect);
         _current.addChild(_currentEffectValue);
         _next = new Sprite();
         _next.addChild(_nextEffect);
         _next.addChild(_nextEffectValue);
         _gradeContain = new Sprite();
         _gradeContain.addChild(_grade);
         _gradeContain.addChild(_gradeValue);
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
            _currentEffect.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.current");
            _currentEffectValue.htmlText = _loc1_.Activity + getMsAddValue(_loc1_);
            _currentEffectValue.height = _currentEffectValue.textHeight + 4;
            _vBox.addChild(_name);
            _vBox.addChild(_line1);
            _vBox.addChild(_current);
            _loc2_ = getNextGrade(_loc1_);
            if(!_loc2_)
            {
               _nextGrade.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.maxGrade");
               _vBox.addChild(_line2);
               _vBox.addChild(_nextGrade);
            }
            else
            {
               refreshNextTemp(_loc2_);
               refreshPlayerGrade(_loc2_);
            }
            _vBox.refreshChildPos();
            _bg.height = _vBox.displayHeight + 20;
         }
      }
      
      private function refreshNextTemp(param1:BuildingTempInfo) : void
      {
         if(param1)
         {
            _nextEffect.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.next");
            _nextEffectValue.htmlText = param1.Activity + getMsAddValue(param1);
            _nextEffectValue.height = _nextEffectValue.textHeight + 4;
            _nextGrade.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.need");
            _vBox.addChild(_next);
            _vBox.addChild(_line2);
            _vBox.addChild(_nextGrade);
         }
      }
      
      public function getMsAddValue(param1:BuildingTempInfo) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = "";
         if(param1.SonType != 901)
         {
            return _loc2_;
         }
         var _loc3_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(1);
         if(_loc3_)
         {
            _loc4_ = Math.floor(_loc3_.tempInfo.AddValue * param1.Property1 / 100);
            _loc2_ = LanguageMgr.GetTranslation("MagicSpringFrame.buffer.addText",_loc4_);
         }
         return _loc2_;
      }
      
      private function refreshPlayerGrade(param1:BuildingTempInfo) : void
      {
         if(param1)
         {
            _grade.text = LanguageMgr.GetTranslation("SeminaryFrameRightView.command09");
            _gradeValue.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.gradeValue",thane.grades + 1);
            _gradeValue.height = _gradeValue.textHeight + 4;
            _gradeValue.setFrame(2);
            _vBox.addChild(_gradeContain);
         }
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
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

