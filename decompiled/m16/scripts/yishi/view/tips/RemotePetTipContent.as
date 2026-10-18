package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class RemotePetTipContent extends Sprite
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _bandTxt:FilterFrameText;
      
      private var _gradeLabel:FilterFrameText;
      
      private var _carrryGradeLabel:FilterFrameText;
      
      private var _typeIcon:ScaleFrameImage;
      
      private var _headIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _hBox:HBox;
      
      private var _line01:Bitmap;
      
      private var _line02:Bitmap;
      
      private var _physicsAttackTxt:FilterFrameText;
      
      private var _physicsDefenseTxt:FilterFrameText;
      
      private var _magicAttackTxt:FilterFrameText;
      
      private var _magicDefenseTxt:FilterFrameText;
      
      private var _hpTxt:FilterFrameText;
      
      private var _fireResTxt:FilterFrameText;
      
      private var _windResTxt:FilterFrameText;
      
      private var _waterResTxt:FilterFrameText;
      
      private var _electResTxt:FilterFrameText;
      
      private var _darkResTxt:FilterFrameText;
      
      private var _lightResTxt:FilterFrameText;
      
      private var _fightingCapacityLabel:FilterFrameText;
      
      private var _fightingCapacityTxt:FilterFrameText;
      
      private var _data:PetData;
      
      public function RemotePetTipContent()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("petTip.nameTxt");
         _bandTxt = ComponentFactory.Instance.creatComponentByStylename("petTip.bandTxt");
         _gradeLabel = ComponentFactory.Instance.creatComponentByStylename("petTip.gradeLabel");
         _carrryGradeLabel = ComponentFactory.Instance.creatComponentByStylename("petTip.carryGradeLabel");
         _typeIcon = ComponentFactory.Instance.creatComponentByStylename("petTip.PetTypeImage");
         _headIcon = ComponentFactory.Instance.creatCustomObject("petTip.headIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _profileImg.x = 10;
         _profileImg.y = 10;
         _line01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line01.width = 280;
         _line02.width = 280;
         _physicsAttackTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.physicsAttackTxt");
         _physicsDefenseTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.physicsDefenseTxt");
         _magicAttackTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.magicAttackTxt");
         _magicDefenseTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.magicDefenseTxt");
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.hpTxt");
         _fireResTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.fireResTxt");
         _windResTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.windResTxt");
         _waterResTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.waterResTxt");
         _electResTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.electResTxt");
         _darkResTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.darkResTxt");
         _lightResTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTip.lightResTxt");
         addChild(_nameTxt);
         addChild(_bandTxt);
         addChild(_gradeLabel);
         addChild(_carrryGradeLabel);
         addChild(_typeIcon);
         _typeIcon.x = 265;
         _typeIcon.y = 13;
         addChild(_headIcon);
         addChild(_profileImg);
         addChild(_line01);
         _line01.y = 108;
         addChild(_line02);
         _line02.y = 285;
         addChild(_physicsAttackTxt);
         addChild(_physicsDefenseTxt);
         addChild(_magicAttackTxt);
         addChild(_magicDefenseTxt);
         addChild(_hpTxt);
         addChild(_fireResTxt);
         addChild(_windResTxt);
         addChild(_waterResTxt);
         addChild(_electResTxt);
         addChild(_darkResTxt);
         addChild(_lightResTxt);
         _fightingCapacityLabel = ComponentFactory.Instance.creatComponentByStylename("petTip.fightingLabel");
         _fightingCapacityTxt = ComponentFactory.Instance.creatComponentByStylename("petTip.fightingTxt");
         addChild(_fightingCapacityLabel);
         addChild(_fightingCapacityTxt);
         _hBox = new HBox();
         _hBox.spacing = 1;
         addChild(_hBox);
         _hBox.x = 195;
         _hBox.y = 60;
         _nameTxt.text = "";
         _bandTxt.text = "";
         _fightingCapacityLabel.text = LanguageMgr.GetTranslation("public.playerInfo.ap");
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         var _loc4_:PetData = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         _data = param1;
         if(param1 is PetData)
         {
            _loc4_ = param1 as PetData;
            _nameTxt.text = _loc4_.name;
            _nameTxt.setFrame(_loc4_.quality);
            if(_hBox)
            {
               _hBox.removeAllChild();
            }
            showStar();
            if(_loc4_.isBind)
            {
               _loc2_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
               _bandTxt.setFrame(1);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
               _bandTxt.setFrame(2);
            }
            _bandTxt.text = _loc2_;
            _gradeLabel.text = LanguageMgr.GetTranslation("PetTip.grade",_loc4_.grade.toString());
            _carrryGradeLabel.text = LanguageMgr.GetTranslation("pet.PetFrame.carryGrade02",55);
            if(_loc4_.template)
            {
               _carrryGradeLabel.text = _loc4_.getLevelString();
            }
            _loc3_ = _data.template.PetType - 100;
            if(_loc3_ < 7)
            {
               _typeIcon.setFrame(_loc3_);
            }
            else if(_loc3_ == 17)
            {
               _typeIcon.setFrame(7);
            }
            else if(_loc3_ == 18)
            {
               _typeIcon.setFrame(8);
            }
            else if(_loc3_ == 19)
            {
               _typeIcon.setFrame(9);
            }
            _headIcon.icon = IconFactory.getPetHeadItemIcon(_loc4_.templateId);
            _profileImg.setFrame(_loc4_.quality);
            _physicsAttackTxt.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06") + ": " + _loc4_.Attack;
            _physicsDefenseTxt.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip07") + ": " + _loc4_.Defence;
            _magicAttackTxt.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08") + ": " + _loc4_.MagicAttack;
            _magicDefenseTxt.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip09") + ": " + _loc4_.MagicDefence;
            _hpTxt.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11") + ": " + _loc4_.Live;
            _fireResTxt.text = LanguageMgr.GetTranslation("pet.fireRes") + ": " + _loc4_.resFire;
            _windResTxt.text = LanguageMgr.GetTranslation("pet.windRes") + ": " + _loc4_.resWind;
            _waterResTxt.text = LanguageMgr.GetTranslation("pet.waterRes") + ": " + _loc4_.resWater;
            _electResTxt.text = LanguageMgr.GetTranslation("pet.electRes") + ": " + _loc4_.resElect;
            _darkResTxt.text = LanguageMgr.GetTranslation("pet.darkRes") + ": " + _loc4_.resDark;
            _lightResTxt.text = LanguageMgr.GetTranslation("pet.lightRes") + ": " + _loc4_.resLight;
            _physicsAttackTxt.setFrame(1);
            _physicsDefenseTxt.setFrame(1);
            _magicAttackTxt.setFrame(1);
            _magicDefenseTxt.setFrame(1);
            _hpTxt.setFrame(1);
            _fireResTxt.setFrame(1);
            _windResTxt.setFrame(1);
            _waterResTxt.setFrame(1);
            _electResTxt.setFrame(1);
            _darkResTxt.setFrame(1);
            _lightResTxt.setFrame(1);
            _fightingCapacityLabel.y = _line02.y + 5;
            _fightingCapacityTxt.y = _line02.y + 5;
            _fightingCapacityTxt.text = _loc4_.fightPower.toString();
            _fightingCapacityTxt.x = 210;
            _fightingCapacityLabel.x = 150;
         }
      }
      
      private function showStar() : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc1_:UpgradeTemplateInfo = data.qualityUpgradeTemplateInfo;
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = data.temQuality % 5 == 0 ? 5 : data.temQuality % 5;
         if(data.temQuality > 25)
         {
            _loc3_ = "asset.pet.bigMoonLightLevelImg";
         }
         else
         {
            _loc3_ = "asset.pet.StarLevelLightImg";
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap(_loc3_);
            _hBox.addChild(_loc4_);
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_bandTxt);
         _bandTxt = null;
         ObjectUtils.disposeObject(_gradeLabel);
         _gradeLabel = null;
         ObjectUtils.disposeObject(_carrryGradeLabel);
         _carrryGradeLabel = null;
         ObjectUtils.disposeObject(_typeIcon);
         _typeIcon = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_line01);
         _line01 = null;
         ObjectUtils.disposeObject(_line02);
         _line02 = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_physicsAttackTxt);
         _physicsAttackTxt = null;
         ObjectUtils.disposeObject(_physicsDefenseTxt);
         _physicsDefenseTxt = null;
         ObjectUtils.disposeObject(_magicAttackTxt);
         _magicAttackTxt = null;
         ObjectUtils.disposeObject(_magicDefenseTxt);
         _magicDefenseTxt = null;
         ObjectUtils.disposeObject(_hpTxt);
         _hpTxt = null;
         ObjectUtils.disposeObject(_fireResTxt);
         _fireResTxt = null;
         ObjectUtils.disposeObject(_windResTxt);
         _windResTxt = null;
         ObjectUtils.disposeObject(_waterResTxt);
         _waterResTxt = null;
         ObjectUtils.disposeObject(_electResTxt);
         _electResTxt = null;
         ObjectUtils.disposeObject(_darkResTxt);
         _darkResTxt = null;
         ObjectUtils.disposeObject(_lightResTxt);
         _lightResTxt = null;
         ObjectUtils.disposeObject(_fightingCapacityLabel);
         _fightingCapacityLabel = null;
         ObjectUtils.disposeObject(_fightingCapacityTxt);
         _fightingCapacityTxt = null;
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}

