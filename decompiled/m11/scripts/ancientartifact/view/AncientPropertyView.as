package ancientartifact.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import mvc.module.ancientartifact.AncientResonateInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class AncientPropertyView extends Component
   {
      
      private var _templateId:int;
      
      private var _template:ArtifactTemplateInfo;
      
      private var _data:AncientArtifactInfo;
      
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
      
      public function AncientPropertyView()
      {
         super();
         initView();
         initEvent();
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
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("ARTIFACT_ITEM_CLICK",__itemClickHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("ARTIFACT_ITEM_CLICK",__itemClickHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function __itemClickHandler(param1:NotificationEvent) : void
      {
         __updateViewHandler(null);
      }
      
      private function __updateViewHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         _templateId = AncientArtifactManager.instance.selectTempId;
         _template = TempleteManager.instance.artifactTemplateCate.getTemplateById(_templateId);
         _data = model.getArtifactInfoById(_templateId);
         if(_data)
         {
            _loc2_ = armoryResonateAddValue;
            _selectedSkillTemp = TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(int(_template.Skills),_data.level);
            _loc3_ = _data.addPer / 100;
            _physicAttackTxt.text = (int(_data.attack * _loc3_ + _loc2_[0])).toString();
            _physicDefenceTxt.text = (int(_data.defences * _loc3_ + _loc2_[1])).toString();
            _magicAttackTxt.text = (int(_data.magicAttack * _loc3_ + _loc2_[2])).toString();
            _magicDefenceTxt.text = (int(_data.magicDefences * _loc3_ + _loc2_[3])).toString();
            _penetrateTxt.text = (int(_data.penetrate * _loc3_ + _loc2_[4])).toString();
            _parryTxt.text = (int(_data.parry * _loc3_ + _loc2_[5])).toString();
            _hpTxt.text = (int(_data.live * _loc3_ + _loc2_[6])).toString();
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
            _skilllLevelText.text = "Nv." + _selectedSkillTemp.Grades;
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
      
      private function get armoryResonateAddValue() : Array
      {
         var _loc8_:AncientArmoryInfo = null;
         var _loc4_:AncientArtifactInfo = null;
         var _loc2_:AncientResonateInfo = null;
         var _loc7_:UpgradeTemplateInfo = null;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Number = NaN;
         var _loc1_:Array = [0,0,0,0,0,0,0];
         _loc6_ = 0;
         while(_loc6_ < 6)
         {
            _loc9_ = int(_data ? _data["armoryEquipPos" + (_loc6_ + 1)] : 0);
            _loc8_ = model.getArmoryInfoById(_loc9_);
            if(_loc9_ > 0 && _loc8_)
            {
               var _loc10_:* = 0;
               var _loc11_:* = _loc1_[_loc10_] + _loc8_.attacks;
               _loc1_[_loc10_] = _loc11_;
               _loc1_[1] += _loc8_.defences;
               _loc1_[2] += _loc8_.attacks;
               _loc1_[3] += _loc8_.magicDefences;
               _loc1_[4] += _loc8_.penetrate;
               _loc1_[5] += _loc8_.parry;
               _loc1_[6] += _loc8_.live;
            }
            if(_loc6_ < 5)
            {
               _loc5_ = int(_data ? _data["slotedEquipPos" + (_loc6_ + 1)] : 0);
               _loc4_ = model.getArtifactInfoById(_loc5_);
               _loc2_ = model.getResonateInfoByPos(_loc6_ + 1);
               if(_loc5_ > 0 && _loc4_ && _loc2_)
               {
                  _loc7_ = TempleteManager.instance.getTemplateByLevelAndType(_loc2_.posGrades,137);
                  _loc3_ = _loc4_.addPer / 100;
                  if(_loc6_ == 0)
                  {
                     _loc11_ = 0;
                     _loc10_ = _loc1_[_loc11_] + Math.floor(_loc7_.ActiveObject * _loc4_.attack / 100 * _loc3_);
                     _loc1_[_loc11_] = _loc10_;
                     _loc1_[2] += Math.floor(_loc7_.ActiveObject * _loc4_.magicAttack / 100 * _loc3_);
                  }
                  else if(_loc6_ == 1)
                  {
                     _loc11_ = 1;
                     _loc10_ = _loc1_[_loc11_] + Math.floor(_loc7_.ActiveObject * _loc4_.defences / 100 * _loc3_);
                     _loc1_[_loc11_] = _loc10_;
                     _loc1_[3] += Math.floor(_loc7_.ActiveObject * _loc4_.magicDefences / 100 * _loc3_);
                  }
                  else if(_loc6_ == 2)
                  {
                     _loc11_ = 5;
                     _loc10_ = _loc1_[_loc11_] + Math.floor(_loc7_.ActiveObject * _loc4_.parry / 100 * _loc3_);
                     _loc1_[_loc11_] = _loc10_;
                  }
                  else if(_loc6_ == 3)
                  {
                     _loc10_ = 4;
                     _loc11_ = _loc1_[_loc10_] + Math.floor(_loc7_.ActiveObject * _loc4_.penetrate / 100 * _loc3_);
                     _loc1_[_loc10_] = _loc11_;
                  }
                  else if(_loc6_ == 4)
                  {
                     _loc11_ = 6;
                     _loc10_ = _loc1_[_loc11_] + Math.floor(_loc7_.ActiveObject * _loc4_.live / 100 * _loc3_);
                     _loc1_[_loc11_] = _loc10_;
                  }
               }
            }
            _loc6_ += 1;
         }
         return _loc1_;
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
         removeEvent();
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

