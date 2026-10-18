package ancientartifact
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.playerinfo.ArtifactThaneInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class AncientCheckPropertyView extends Component
   {
      
      private var _templateId:int;
      
      private var _template:ArtifactTemplateInfo;
      
      private var _data:*;
      
      private var _rightBg:MovieClip;
      
      private var _rareweaponProperText:FilterFrameText;
      
      private var _rareweaponSkillText:FilterFrameText;
      
      private var _valueVBox:VBox;
      
      private var _skillBaseItemView:BaseItemView;
      
      private var _skillNameText:FilterFrameText;
      
      private var _skilllLevelText:FilterFrameText;
      
      private var _skillDescText:FilterFrameText;
      
      private var _physicAttackTxt1:FilterFrameText;
      
      private var _physicDefenceTxt1:FilterFrameText;
      
      private var _magicAttackTxt1:FilterFrameText;
      
      private var _magicDefenceTxt1:FilterFrameText;
      
      private var _penetrateTxt1:FilterFrameText;
      
      private var _parryTxt1:FilterFrameText;
      
      private var _hpTxt1:FilterFrameText;
      
      private var _physicAttackTxt:FilterFrameText;
      
      private var _physicDefenceTxt:FilterFrameText;
      
      private var _magicAttackTxt:FilterFrameText;
      
      private var _magicDefenceTxt:FilterFrameText;
      
      private var _penetrateTxt:FilterFrameText;
      
      private var _parryTxt:FilterFrameText;
      
      private var _hpTxt:FilterFrameText;
      
      private var _selectedSkillTemp:SkillTempInfo;
      
      private var _needStr:String;
      
      private var _needValue:int;
      
      private var _hasValue:int;
      
      private var _filter:UIFilter;
      
      private var _needFilter:Boolean = false;
      
      private var _info:ArtifactThaneInfo;
      
      public function AncientCheckPropertyView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:ComponentFactory = ComponentFactory.Instance;
         _rightBg = _loc1_.creatCustomObject("asset.ancientartifact.propertyBg");
         _rareweaponProperText = _loc1_.creatComponentByStylename("ancientartifact.propertyView.rareweaponProperText");
         _rareweaponSkillText = _loc1_.creatComponentByStylename("ancientartifact.propertyView.rareweaponSkillText");
         _valueVBox = _loc1_.creatComponentByStylename("ancientartifact.propertyView.valueVBox");
         _skillBaseItemView = _loc1_.creatCustomObject("ancientartifact.propertyView.skillBaseItemView");
         _skillNameText = _loc1_.creatComponentByStylename("ancientartifact.propertyView.skillNameText");
         _skilllLevelText = _loc1_.creatComponentByStylename("ancientartifact.propertyView.skilllLevelText");
         _skillDescText = _loc1_.creatComponentByStylename("ancientartifact.propertyView.skillDescText");
         _physicAttackTxt1 = _loc1_.creatComponentByStylename("ancientartifact.propertyView.physicAttackTxt1");
         _physicDefenceTxt1 = _loc1_.creatComponentByStylename("ancientartifact.propertyView.physicDefenceTxt1");
         _magicAttackTxt1 = _loc1_.creatComponentByStylename("ancientartifact.propertyView.magicAttackTxt1");
         _magicDefenceTxt1 = _loc1_.creatComponentByStylename("ancientartifact.propertyView.magicDefenceTxt1");
         _penetrateTxt1 = _loc1_.creatComponentByStylename("ancientartifact.propertyView.penetrateTxt1");
         _parryTxt1 = _loc1_.creatComponentByStylename("ancientartifact.propertyView.parryTxt1");
         _hpTxt1 = _loc1_.creatComponentByStylename("ancientartifact.propertyView.hpTxt1");
         _physicAttackTxt1.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip40");
         _physicDefenceTxt1.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip41");
         _magicAttackTxt1.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip42");
         _magicDefenceTxt1.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip43");
         _penetrateTxt1.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip37");
         _parryTxt1.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip38");
         _hpTxt1.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip39");
         _physicAttackTxt = _loc1_.creatComponentByStylename("ancientartifact.propertyView.physicAttackTxt");
         _physicDefenceTxt = _loc1_.creatComponentByStylename("ancientartifact.propertyView.physicDefenceTxt");
         _magicAttackTxt = _loc1_.creatComponentByStylename("ancientartifact.propertyView.magicAttackTxt");
         _magicDefenceTxt = _loc1_.creatComponentByStylename("ancientartifact.propertyView.magicDefenceTxt");
         _penetrateTxt = _loc1_.creatComponentByStylename("ancientartifact.propertyView.penetrateTxt");
         _parryTxt = _loc1_.creatComponentByStylename("ancientartifact.propertyView.parryTxt");
         _hpTxt = _loc1_.creatComponentByStylename("ancientartifact.propertyView.hpTxt");
         _filter = new UIFilter();
         addChild(_rightBg);
         addChild(_physicAttackTxt1);
         addChild(_physicDefenceTxt1);
         addChild(_magicAttackTxt1);
         addChild(_magicDefenceTxt1);
         addChild(_penetrateTxt1);
         addChild(_parryTxt1);
         addChild(_hpTxt1);
         addChild(_physicAttackTxt);
         addChild(_physicDefenceTxt);
         addChild(_magicAttackTxt);
         addChild(_magicDefenceTxt);
         addChild(_penetrateTxt);
         addChild(_parryTxt);
         addChild(_hpTxt);
         addChild(_rareweaponProperText);
         addChild(_rareweaponSkillText);
         addChild(_valueVBox);
         addChild(_skillBaseItemView);
         addChild(_skillNameText);
         addChild(_skilllLevelText);
         addChild(_skillDescText);
         addChild(_skilllLevelText);
         addChild(_skillDescText);
         _rareweaponProperText.text = LanguageMgr.GetTranslation("rareweapon.story.contractView.rareAttri");
         _rareweaponSkillText.text = LanguageMgr.GetTranslation("rareweapon.story.contractView.rareName");
      }
      
      public function set info(param1:ArtifactThaneInfo) : void
      {
         _info = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:Number = NaN;
         _data = _info ? _info : model.getEquipArtifactInfo();
         _templateId = _data.templateId;
         _template = TempleteManager.instance.artifactTemplateCate.getTemplateById(_templateId);
         if(_data)
         {
            _selectedSkillTemp = TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(int(_template.Skills),_data.level);
            _loc1_ = _data.addPer / 100;
            _physicAttackTxt.text = (int(_data.attack * _loc1_)).toString();
            _physicDefenceTxt.text = (int(_data.defences * _loc1_)).toString();
            _magicAttackTxt.text = (int(_data.magicAttack * _loc1_)).toString();
            _magicDefenceTxt.text = (int(_data.magicDefences * _loc1_)).toString();
            _penetrateTxt.text = (int(_data.penetrate * _loc1_)).toString();
            _parryTxt.text = (int(_data.parry * _loc1_)).toString();
            _hpTxt.text = (int(_data.live * _loc1_)).toString();
            _filter.setNormalFilter(this);
         }
         else
         {
            _selectedSkillTemp = TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(int(_template.Skills),1);
            _physicAttackTxt.text = _template.AttackMin.toString();
            _physicDefenceTxt.text = _template.DefenceMin.toString();
            _magicAttackTxt.text = _template.MagicAttackMin.toString();
            _magicDefenceTxt.text = _template.MagicDefenceMin.toString();
            _penetrateTxt.text = _template.PenetrateMin.toString();
            _parryTxt.text = _template.ParryMin.toString();
            _hpTxt.text = _template.LiveMin.toString();
            _filter.setGrayFilter(this);
         }
         if(_selectedSkillTemp)
         {
            _skillNameText.text = _selectedSkillTemp.TemplateName;
            _skilllLevelText.text = "Lv." + _selectedSkillTemp.Grades;
            _skillDescText.text = _selectedSkillTemp.Description;
            _skillBaseItemView.icon.icon = IconFactory.getCommonIconPath(_selectedSkillTemp.Icons);
         }
         else
         {
            _skillNameText.text = "";
            _skilllLevelText.text = "";
            _skillDescText.text = "";
            _skillBaseItemView.data = null;
         }
      }
      
      private function clearData() : void
      {
         _physicAttackTxt.text = "0";
         _physicDefenceTxt.text = "0";
         _magicAttackTxt.text = "0";
         _magicDefenceTxt.text = "0";
         _penetrateTxt.text = "0";
         _parryTxt.text = "0";
         _hpTxt.text = "0";
         _skillNameText.text = "";
         _skilllLevelText.text = "";
         _skillDescText.text = "";
         _skillBaseItemView.data = null;
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_rareweaponProperText);
         _rareweaponProperText = null;
         ObjectUtils.disposeObject(_rareweaponSkillText);
         _rareweaponSkillText = null;
         ObjectUtils.disposeObject(_valueVBox);
         _valueVBox = null;
         ObjectUtils.disposeObject(_skillBaseItemView);
         _skillBaseItemView = null;
         ObjectUtils.disposeObject(_skillNameText);
         _skillNameText = null;
         ObjectUtils.disposeObject(_skilllLevelText);
         _skilllLevelText = null;
         ObjectUtils.disposeObject(_skillDescText);
         _skillDescText = null;
         ObjectUtils.disposeObject(_physicAttackTxt1);
         _physicAttackTxt1 = null;
         ObjectUtils.disposeObject(_physicDefenceTxt1);
         _physicDefenceTxt1 = null;
         ObjectUtils.disposeObject(_magicAttackTxt1);
         _magicAttackTxt1 = null;
         ObjectUtils.disposeObject(_magicDefenceTxt1);
         _magicDefenceTxt1 = null;
         ObjectUtils.disposeObject(_penetrateTxt1);
         _penetrateTxt1 = null;
         ObjectUtils.disposeObject(_parryTxt1);
         _parryTxt1 = null;
         ObjectUtils.disposeObject(_hpTxt1);
         _hpTxt1 = null;
         ObjectUtils.disposeObject(_physicAttackTxt);
         _physicAttackTxt = null;
         ObjectUtils.disposeObject(_physicDefenceTxt);
         _physicDefenceTxt = null;
         ObjectUtils.disposeObject(_magicAttackTxt);
         _magicAttackTxt = null;
         ObjectUtils.disposeObject(_magicDefenceTxt);
         _magicDefenceTxt = null;
         ObjectUtils.disposeObject(_penetrateTxt);
         _penetrateTxt = null;
         ObjectUtils.disposeObject(_parryTxt);
         _parryTxt = null;
         ObjectUtils.disposeObject(_hpTxt);
         _hpTxt = null;
         _filter = null;
         _template = null;
         _data = null;
         _selectedSkillTemp = null;
         super.dispose();
      }
   }
}

