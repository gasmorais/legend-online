package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetTipContent extends Sprite
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _bandTxt:FilterFrameText;
      
      private var _gradeLabel:FilterFrameText;
      
      private var _carrryGradeLabel:FilterFrameText;
      
      private var _typeIcon:ScaleFrameImage;
      
      private var _headIcon:BaseIconView;
      
      private var _line01:Bitmap;
      
      private var _line02:Bitmap;
      
      private var _line03:Bitmap;
      
      private var _vBox01:VBox;
      
      private var _growTxt:PetAttributeItemView;
      
      private var _strengthTxt:PetAttributeItemView;
      
      private var _armorTxt:PetAttributeItemView;
      
      private var _intellectTxt:PetAttributeItemView;
      
      private var _staminaTxt:PetAttributeItemView;
      
      private var _awakenTxt:FilterFrameText;
      
      private var _vBox03:VBox;
      
      private var _equipSprite:Sprite;
      
      private var _equip0:PetEquipIcon;
      
      private var _equip1:PetEquipIcon;
      
      private var _equip2:PetEquipIcon;
      
      private var _equip3:PetEquipIcon;
      
      private var _equip4:PetEquipIcon;
      
      private var _equip5:PetEquipIcon;
      
      private var _fightingCapacityLabel:FilterFrameText;
      
      private var _fightingCapacityTxt:FilterFrameText;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _hBox:HBox;
      
      private var _petTypeList:Array;
      
      private var _data:PetData;
      
      public function PetTipContent()
      {
         super();
         var _loc1_:String = LanguageMgr.GetTranslation("pet.petTypeList");
         _petTypeList = _loc1_.split("|");
         init();
      }
      
      private function init() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("petTip.nameTxt");
         _bandTxt = ComponentFactory.Instance.creatComponentByStylename("petTip.bandTxt");
         _bandTxt.x = 170;
         _gradeLabel = ComponentFactory.Instance.creatComponentByStylename("petTip.gradeLabel");
         _carrryGradeLabel = ComponentFactory.Instance.creatComponentByStylename("petTip.carryGradeLabel");
         _typeIcon = ComponentFactory.Instance.creatComponentByStylename("petTip.PetTypeImage");
         _typeIcon.x = 240;
         _headIcon = ComponentFactory.Instance.creatCustomObject("petTip.headIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _profileImg.x = 10;
         _profileImg.y = 10;
         _line01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line03 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line01.width = 280;
         _line02.width = 280;
         _line03.width = 280;
         addChild(_nameTxt);
         addChild(_bandTxt);
         addChild(_gradeLabel);
         addChild(_carrryGradeLabel);
         addChild(_typeIcon);
         addChild(_headIcon);
         addChild(_profileImg);
         addChild(_line01);
         _line01.y = 108;
         addChild(_line02);
         _line02.y = 230;
         addChild(_line03);
         _vBox01 = ComponentFactory.Instance.creatComponentByStylename("petTip.vbox01");
         _growTxt = new PetAttributeItemView();
         _strengthTxt = new PetAttributeItemView();
         _armorTxt = new PetAttributeItemView();
         _intellectTxt = new PetAttributeItemView();
         _staminaTxt = new PetAttributeItemView();
         _vBox01.addChild(_growTxt);
         _vBox01.addChild(_strengthTxt);
         _vBox01.addChild(_armorTxt);
         _vBox01.addChild(_intellectTxt);
         _vBox01.addChild(_staminaTxt);
         addChild(_vBox01);
         _awakenTxt = ComponentFactory.Instance.creatComponentByStylename("petTip.awakenSkillTxt");
         _awakenTxt.y = 239;
         _vBox03 = ComponentFactory.Instance.creatComponentByStylename("petTip.vbox03");
         _equipSprite = new Sprite();
         _equipSprite.x = 10;
         _equipSprite.y = 260;
         addChild(_awakenTxt);
         addChild(_equipSprite);
         _equip0 = ComponentFactory.Instance.creatCustomObject("tips.petEquip0");
         _equip1 = ComponentFactory.Instance.creatCustomObject("tips.petEquip1");
         _equip2 = ComponentFactory.Instance.creatCustomObject("tips.petEquip2");
         _equip3 = ComponentFactory.Instance.creatCustomObject("tips.petEquip3");
         _equip4 = ComponentFactory.Instance.creatCustomObject("tips.petEquip4");
         _equip5 = ComponentFactory.Instance.creatCustomObject("tips.petEquip5");
         _equipSprite.addChild(_equip0);
         _equipSprite.addChild(_equip1);
         _equipSprite.addChild(_equip2);
         _equipSprite.addChild(_equip3);
         _equipSprite.addChild(_equip4);
         _equipSprite.addChild(_equip5);
         _fightingCapacityLabel = ComponentFactory.Instance.creatComponentByStylename("petTip.fightingLabel");
         _fightingCapacityTxt = ComponentFactory.Instance.creatComponentByStylename("petTip.fightingTxt");
         addChild(_fightingCapacityLabel);
         addChild(_fightingCapacityTxt);
         _hBox = new HBox();
         _hBox.spacing = 1;
         addChild(_hBox);
         _hBox.x = 185;
         _hBox.y = 60;
         _nameTxt.text = "";
         _bandTxt.text = "";
         _fightingCapacityLabel.text = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _awakenTxt.text = LanguageMgr.GetTranslation("PetTip.awakenSkill");
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         var _loc11_:PetData = null;
         var _loc2_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:Array = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc3_:Array = null;
         var _loc10_:int = 0;
         _data = param1;
         if(!_vBox03)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_vBox03);
         if(param1 is PetData)
         {
            _loc11_ = param1 as PetData;
            _nameTxt.text = _loc11_.name;
            _nameTxt.setFrame(_loc11_.quality);
            if(_hBox)
            {
               _hBox.removeAllChild();
            }
            showStar();
            if(_loc11_.isBind)
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
            _gradeLabel.text = LanguageMgr.GetTranslation("PetTip.grade",_loc11_.grade.toString());
            _carrryGradeLabel.text = LanguageMgr.GetTranslation("pet.PetFrame.carryGrade02",55);
            if(_loc11_.template)
            {
               _loc6_ = int(_data.template.PetType.toString().charAt(2));
               _carrryGradeLabel.text = LanguageMgr.GetTranslation("pet.needGradeTxt" + _data.template.NeedGrade,_petTypeList[_loc6_ - 1]);
            }
            _loc7_ = _data.template.PetType - 100;
            if(_loc7_ < 7)
            {
               _typeIcon.setFrame(_loc7_);
            }
            else if(_loc7_ == 17)
            {
               _typeIcon.setFrame(7);
            }
            else if(_loc7_ == 18)
            {
               _typeIcon.setFrame(8);
            }
            else if(_loc7_ == 19)
            {
               _typeIcon.setFrame(9);
            }
            _headIcon.icon = IconFactory.getPetHeadItemIcon(_loc11_.templateId);
            _profileImg.setFrame(_loc11_.quality);
            if(_loc11_.initQuality < _loc11_.quality)
            {
               _growTxt.setData(LanguageMgr.GetTranslation("PetTip.grow") + " " + _loc11_.growthRate.toString(),2);
            }
            else
            {
               _growTxt.setData(LanguageMgr.GetTranslation("PetTip.grow") + " " + _loc11_.growthRate.toString(),6);
            }
            if(_loc11_.coeStrengthAdd > 0)
            {
               _strengthTxt.setData(LanguageMgr.GetTranslation("pet.strengthCoe") + " " + _loc11_.coeStrength + " / " + _loc11_.coeStrengthLimit,2);
            }
            else
            {
               _strengthTxt.setData(LanguageMgr.GetTranslation("pet.strengthCoe") + " " + _loc11_.coeStrength + " / " + _loc11_.coeStrengthLimit,6);
            }
            if(_loc11_.coeArmorAdd > 0)
            {
               _armorTxt.setData(LanguageMgr.GetTranslation("pet.armorCoe") + " " + _loc11_.coeArmor + " / " + _loc11_.coeArmorLimit,2);
            }
            else
            {
               _armorTxt.setData(LanguageMgr.GetTranslation("pet.armorCoe") + " " + _loc11_.coeArmor + " / " + _loc11_.coeArmorLimit,6);
            }
            if(_loc11_.coeIntellectAdd)
            {
               _intellectTxt.setData(LanguageMgr.GetTranslation("pet.intellectCoe") + " " + _loc11_.coeIntellect + " / " + _loc11_.coeIntellectLimit,2);
            }
            else
            {
               _intellectTxt.setData(LanguageMgr.GetTranslation("pet.intellectCoe") + " " + _loc11_.coeIntellect + " / " + _loc11_.coeIntellectLimit,6);
            }
            if(_loc11_.coeStaminaAdd)
            {
               _staminaTxt.setData(LanguageMgr.GetTranslation("pet.staminaCoe") + " " + _loc11_.coeStamina + " / " + _loc11_.coeStaminaLimit,2);
            }
            else
            {
               _staminaTxt.setData(LanguageMgr.GetTranslation("pet.staminaCoe") + " " + _loc11_.coeStamina + " / " + _loc11_.coeStaminaLimit,6);
            }
            _loc4_ = false;
            _loc5_ = playerInfo.petList;
            _loc9_ = 0;
            while(_loc9_ < _loc5_.length)
            {
               if((_loc5_[_loc9_] as PetData).petId == _loc11_.petId)
               {
                  _loc4_ = true;
                  break;
               }
               _loc9_++;
            }
            if(_loc4_)
            {
               _loc3_ = GoodsManager.instance.getPetEquipListById(_loc11_.petId);
               for each(_loc8_ in _loc3_)
               {
                  _loc11_.equipList.push(_loc8_);
               }
            }
            _equip3.y = 80;
            _equip4.y = 80;
            _equip5.y = 80;
            _loc9_ = 0;
            while(_loc9_ < 6)
            {
               this["_equip" + _loc9_].data = null;
               this["_equip" + _loc9_].openState = true;
               _loc9_++;
            }
            for each(_loc8_ in _loc11_.equipList)
            {
               this["_equip" + _loc8_.pos].data = _loc8_;
            }
            _loc10_ = _equipSprite.y + _equipSprite.height;
            _line03.y = _loc10_ + 5;
            _fightingCapacityLabel.y = _loc10_ + 15;
            _fightingCapacityTxt.y = _loc10_ + 14;
            _fightingCapacityTxt.text = _loc11_.fightPower.toString();
            _fightingCapacityTxt.x = 270 - _fightingCapacityTxt.textWidth + 10;
            _fightingCapacityLabel.x = _fightingCapacityTxt.x - _fightingCapacityLabel.textWidth - 6;
         }
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
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
         ObjectUtils.disposeObject(_vBox01);
         _vBox01 = null;
         ObjectUtils.disposeObject(_line03);
         _line03 = null;
         ObjectUtils.disposeObject(_growTxt);
         _growTxt = null;
         ObjectUtils.disposeObject(_strengthTxt);
         _strengthTxt = null;
         ObjectUtils.disposeObject(_armorTxt);
         _armorTxt = null;
         ObjectUtils.disposeObject(_intellectTxt);
         _intellectTxt = null;
         ObjectUtils.disposeObject(_staminaTxt);
         _staminaTxt = null;
         ObjectUtils.disposeAllChildren(_vBox03);
         ObjectUtils.disposeObject(_vBox03);
         _vBox03 = null;
         ObjectUtils.disposeObject(_awakenTxt);
         _awakenTxt = null;
         ObjectUtils.disposeObject(_profileImg);
         _profileImg = null;
         ObjectUtils.disposeObject(_fightingCapacityLabel);
         _fightingCapacityLabel = null;
         ObjectUtils.disposeObject(_fightingCapacityTxt);
         _fightingCapacityTxt = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

