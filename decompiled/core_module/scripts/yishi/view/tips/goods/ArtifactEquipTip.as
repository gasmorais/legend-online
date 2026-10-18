package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import mvc.module.ancientartifact.AncientResonateInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.BaseTip;
   
   public class ArtifactEquipTip extends BaseTip
   {
      
      public static const UPGRAD_TYPE:int = 136;
      
      protected var _whiteBg:Scale9CornerImage;
      
      protected var _totalBox:VBox;
      
      private var _equipIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _title:FilterFrameText;
      
      private var _type:FilterFrameText;
      
      private var _skillContain:Component;
      
      private var _skillBaseItemView:BaseItemView;
      
      private var _skillNameText:FilterFrameText;
      
      private var _skilllLevelText:FilterFrameText;
      
      private var _skillDescText:FilterFrameText;
      
      private var _physicAttackTxt1:ArtifactEquipItem;
      
      private var _physicDefenceTxt1:ArtifactEquipItem;
      
      private var _magicAttackTxt1:ArtifactEquipItem;
      
      private var _magicDefenceTxt1:ArtifactEquipItem;
      
      private var _penetrateTxt1:ArtifactEquipItem;
      
      private var _parryTxt1:ArtifactEquipItem;
      
      private var _hpTxt1:ArtifactEquipItem;
      
      private var _baseLine:Bitmap;
      
      private var _attributeLine:Bitmap;
      
      private var _gemLine:Bitmap;
      
      public function ArtifactEquipTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 237;
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _equipIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         _skillContain = new Component();
         _skillBaseItemView = ComponentFactory.Instance.creatCustomObject("ancientartifact.propertyView.skillBaseItemView");
         _skillNameText = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.propertyView.skillNameText");
         _skilllLevelText = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.propertyView.skilllLevelText");
         _skillDescText = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.propertyView.skillDescText");
         _physicAttackTxt1 = new ArtifactEquipItem();
         _physicDefenceTxt1 = new ArtifactEquipItem();
         _magicAttackTxt1 = new ArtifactEquipItem();
         _magicDefenceTxt1 = new ArtifactEquipItem();
         _penetrateTxt1 = new ArtifactEquipItem();
         _parryTxt1 = new ArtifactEquipItem();
         _hpTxt1 = new ArtifactEquipItem();
         _baseLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _attributeLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _gemLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         addChild(_whiteBg);
         addChild(_equipIcon);
         addChild(_profileImg);
         addChild(_title);
         addChild(_type);
         addChild(_totalBox);
         _skillContain.addChild(_skillBaseItemView);
         _skillContain.addChild(_skillNameText);
         _skillContain.addChild(_skilllLevelText);
         _title.x = 66;
         _type.x = 1;
         _type.y = 55;
         _whiteBg.x = -10;
         _totalBox.y = 82;
         _skillBaseItemView.x = 0;
         _skillBaseItemView.y = 0;
         _skillNameText.x = 150;
         _skillNameText.y = 0;
         _skilllLevelText.x = 150;
         _skilllLevelText.y = 42;
         _skillDescText.x = 0;
         _profileImg.setFrame(1);
         _type.text = LanguageMgr.GetTranslation("ancientartifact.AncientEquipFrame.titleText");
      }
      
      override protected function updateTransform() : void
      {
         var _loc7_:String = null;
         var _loc2_:ArtifactTemplateInfo = null;
         var _loc5_:SkillTempInfo = null;
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc17_:int = 0;
         var _loc16_:int = 0;
         var _loc15_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc14_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:AncientArtifactInfo = null;
         var _loc4_:Array = null;
         var _loc11_:SkillPropertyTempInfo = null;
         var _loc9_:String = null;
         if(tipData)
         {
            _totalBox.removeAllChild();
            _totalBox.beginChanges();
            _bg.visible = false;
            clean();
            _loc7_ = tipData.type as String;
            _loc2_ = tipData.tempInfo as ArtifactTemplateInfo;
            _equipIcon.icon = IconFactory.getCommonIconPath(_loc2_.Icon);
            _title.text = _loc2_.TemplateName;
            _title.setFrame(1);
            _totalBox.addChild(_baseLine);
            _loc3_ = upgradeTemplates[upgradeTemplates.length - 1];
            _loc12_ = _loc3_.ActiveObject / 100;
            _loc13_ = _loc3_.Grades;
            _loc1_ = model.getArtifactInfoById(_loc2_.TemplateId);
            if(_loc7_ == "max")
            {
               _loc5_ = TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(int(_loc2_.Skills),_loc13_);
               _loc17_ = _loc2_.AttackMax * _loc12_;
               _loc16_ = _loc2_.DefenceMax * _loc12_;
               _loc15_ = _loc2_.MagicAttackMax * _loc12_;
               _loc8_ = _loc2_.MagicDefenceMax * _loc12_;
               _loc10_ = _loc2_.PenetrateMax * _loc12_;
               _loc14_ = _loc2_.ParryMax * _loc12_;
               _loc6_ = _loc2_.LiveMax * _loc12_;
            }
            else if(_loc7_ == "current")
            {
               _loc5_ = TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(int(_loc2_.Skills),_loc13_);
               if(_loc1_)
               {
                  _loc4_ = getArmoryResonateAddValue(_loc1_);
                  _loc17_ = _loc1_.attack * _loc1_.addPer / 100 + _loc4_[0];
                  _loc16_ = _loc1_.defences * _loc1_.addPer / 100 + _loc4_[1];
                  _loc15_ = _loc1_.magicAttack * _loc1_.addPer / 100 + _loc4_[2];
                  _loc8_ = _loc1_.magicDefences * _loc1_.addPer / 100 + _loc4_[3];
                  _loc10_ = _loc1_.penetrate * _loc1_.addPer / 100 + _loc4_[4];
                  _loc14_ = _loc1_.parry * _loc1_.addPer / 100 + _loc4_[5];
                  _loc6_ = _loc1_.live * _loc1_.addPer / 100 + _loc4_[6];
               }
               else
               {
                  _loc17_ = _loc2_.AttackMin;
                  _loc16_ = _loc2_.DefenceMin;
                  _loc15_ = _loc2_.MagicAttackMin;
                  _loc8_ = _loc2_.MagicDefenceMin;
                  _loc10_ = _loc2_.PenetrateMin;
                  _loc14_ = _loc2_.ParryMin;
                  _loc6_ = _loc2_.LiveMin;
               }
            }
            else if(_loc7_ == "dreamArena")
            {
               _loc5_ = tipData.skillTemp as SkillTempInfo;
               _loc11_ = tipData.propTemp as SkillPropertyTempInfo;
               _loc17_ = _loc11_.Attack;
               _loc16_ = _loc11_.Defence;
               _loc15_ = _loc11_.MagicAttack;
               _loc8_ = _loc11_.MagicDefence;
               _loc10_ = _loc11_.Penetrate;
               _loc14_ = _loc11_.Parry;
               _loc6_ = _loc11_.Live;
            }
            _loc9_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip40");
            updateAttributeTxt(_physicAttackTxt1,_loc9_,_loc17_);
            _loc9_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip41");
            updateAttributeTxt(_physicDefenceTxt1,_loc9_,_loc16_);
            _loc9_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip42");
            updateAttributeTxt(_magicAttackTxt1,_loc9_,_loc15_);
            _loc9_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip43");
            updateAttributeTxt(_magicDefenceTxt1,_loc9_,_loc8_);
            _loc9_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip37");
            updateAttributeTxt(_penetrateTxt1,_loc9_,_loc10_);
            _loc9_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip38");
            updateAttributeTxt(_parryTxt1,_loc9_,_loc14_);
            _loc9_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip39");
            updateAttributeTxt(_hpTxt1,_loc9_,_loc6_);
            _skillBaseItemView.icon.icon = IconFactory.getCommonIconPath(_loc5_.Icons);
            _skillNameText.text = _loc5_.TemplateName;
            _skilllLevelText.text = "Nv." + _loc5_.Grades;
            _skillDescText.text = _loc5_.Description;
            _totalBox.addChild(_attributeLine);
            _totalBox.addChild(_skillContain);
            _totalBox.addChild(_gemLine);
            _totalBox.addChild(_skillDescText);
            _totalBox.commitChanges();
            _bg.height = int(-_bg.y + _totalBox.y + _totalBox.height + 10);
            _whiteBg.height = _bg.height;
         }
      }
      
      public function get upgradeTemplates() : Array
      {
         var _loc1_:Array = null;
         if(!_loc1_)
         {
            _loc1_ = TempleteManager.instance.getTemplatesByType(136);
            _loc1_.sortOn("Grades",16);
         }
         return _loc1_;
      }
      
      private function updateAttributeTxt(param1:ArtifactEquipItem, param2:String, param3:Number) : void
      {
         if(param3 != 0)
         {
            param1.updateText(param2,param3);
            _totalBox.addChild(param1);
         }
      }
      
      public function clean() : void
      {
         _totalBox.removeAllChild();
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      private function getArmoryResonateAddValue(param1:AncientArtifactInfo) : Array
      {
         var _loc9_:AncientArmoryInfo = null;
         var _loc5_:AncientArtifactInfo = null;
         var _loc3_:AncientResonateInfo = null;
         var _loc8_:UpgradeTemplateInfo = null;
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:Number = NaN;
         var _loc2_:Array = [0,0,0,0,0,0,0];
         _loc7_ = 0;
         while(_loc7_ < 6)
         {
            _loc10_ = int(param1 ? param1["armoryEquipPos" + (_loc7_ + 1)] : 0);
            _loc9_ = model.getArmoryInfoById(_loc10_);
            if(_loc10_ > 0 && _loc9_)
            {
               var _loc11_:* = 0;
               var _loc12_:* = _loc2_[_loc11_] + _loc9_.attacks;
               _loc2_[_loc11_] = _loc12_;
               _loc2_[1] += _loc9_.defences;
               _loc2_[2] += _loc9_.attacks;
               _loc2_[3] += _loc9_.magicDefences;
               _loc2_[4] += _loc9_.penetrate;
               _loc2_[5] += _loc9_.parry;
               _loc2_[6] += _loc9_.live;
            }
            if(_loc7_ < 5)
            {
               _loc6_ = int(param1 ? param1["slotedEquipPos" + (_loc7_ + 1)] : 0);
               _loc5_ = model.getArtifactInfoById(_loc6_);
               _loc3_ = model.getResonateInfoByPos(_loc7_ + 1);
               if(_loc6_ > 0 && _loc5_ && _loc3_)
               {
                  _loc8_ = TempleteManager.instance.getTemplateByLevelAndType(_loc3_.posGrades,137);
                  _loc4_ = _loc5_.addPer / 100;
                  if(_loc7_ == 0)
                  {
                     _loc12_ = 0;
                     _loc11_ = _loc2_[_loc12_] + Math.floor(_loc8_.ActiveObject * _loc5_.attack / 100 * _loc4_);
                     _loc2_[_loc12_] = _loc11_;
                     _loc2_[2] += Math.floor(_loc8_.ActiveObject * _loc5_.magicAttack / 100 * _loc4_);
                  }
                  else if(_loc7_ == 1)
                  {
                     _loc12_ = 1;
                     _loc11_ = _loc2_[_loc12_] + Math.floor(_loc8_.ActiveObject * _loc5_.defences / 100 * _loc4_);
                     _loc2_[_loc12_] = _loc11_;
                     _loc2_[3] += Math.floor(_loc8_.ActiveObject * _loc5_.magicDefences / 100 * _loc4_);
                  }
                  else if(_loc7_ == 2)
                  {
                     _loc12_ = 5;
                     _loc11_ = _loc2_[_loc12_] + Math.floor(_loc8_.ActiveObject * _loc5_.parry / 100 * _loc4_);
                     _loc2_[_loc12_] = _loc11_;
                  }
                  else if(_loc7_ == 3)
                  {
                     _loc11_ = 4;
                     _loc12_ = _loc2_[_loc11_] + Math.floor(_loc8_.ActiveObject * _loc5_.penetrate / 100 * _loc4_);
                     _loc2_[_loc11_] = _loc12_;
                  }
                  else if(_loc7_ == 4)
                  {
                     _loc12_ = 6;
                     _loc11_ = _loc2_[_loc12_] + Math.floor(_loc8_.ActiveObject * _loc5_.live / 100 * _loc4_);
                     _loc2_[_loc12_] = _loc11_;
                  }
               }
            }
            _loc7_ += 1;
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_whiteBg);
         _whiteBg = null;
         ObjectUtils.disposeObject(_totalBox);
         _totalBox = null;
         ObjectUtils.disposeObject(_equipIcon);
         _equipIcon = null;
         ObjectUtils.disposeObject(_profileImg);
         _profileImg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_type);
         _type = null;
         ObjectUtils.disposeObject(_skillContain);
         _skillContain = null;
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
         ObjectUtils.disposeObject(_baseLine);
         _baseLine = null;
         ObjectUtils.disposeObject(_attributeLine);
         _attributeLine = null;
         ObjectUtils.disposeObject(_gemLine);
         _gemLine = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

