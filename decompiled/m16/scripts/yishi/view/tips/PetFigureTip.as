package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.goods.FashionAttItem;
   
   public class PetFigureTip extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _subBox1:VBox;
      
      private var _subBox2:VBox;
      
      private var _blackKingBg:Scale9CornerImage;
      
      private var _redBg:Scale9CornerImage;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _splitLine:Bitmap;
      
      private var _splitLine2:Bitmap;
      
      private var _splitLine3:Bitmap;
      
      private var _hbox:HBox;
      
      private var _growthTxt:FashionAttItem;
      
      private var _strengthCoeTxt:FashionAttItem;
      
      private var _armorCoeTxt:FashionAttItem;
      
      private var _intellectCoeTxt:FashionAttItem;
      
      private var _staminaCoeTxt:FashionAttItem;
      
      private var _propertyPointTxt:FashionAttItem;
      
      private var _hpTxt:FashionAttItem;
      
      private var _physicsAttackTxt:FashionAttItem;
      
      private var _physicsDefenseTxt:FashionAttItem;
      
      private var _magicAttackTxt:FashionAttItem;
      
      private var _magicDefenseTxt:FashionAttItem;
      
      private var _con:Sprite;
      
      private var _equipIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _title:FilterFrameText;
      
      private var _petSkillIcon:ScaleFrameImage;
      
      private var _type:FilterFrameText;
      
      private var _vocation:FilterFrameText;
      
      private var _powerTxt:FilterFrameText;
      
      private var _strengthMc:MovieClip;
      
      private var _hBox:HBox;
      
      private var _expTxt:FilterFrameText;
      
      public function PetFigureTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 247;
         _blackKingBg = ComponentFactory.Instance.creatComponentByStylename("core.blackItemTipsBg");
         _redBg = ComponentFactory.Instance.creatComponentByStylename("core.redItemTipsBg");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _con = new Sprite();
         _equipIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _petSkillIcon = ComponentFactory.Instance.creatComponentByStylename("petTip.PetTypeImage");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         _vocation = ComponentFactory.Instance.creatComponentByStylename("tips.GoodVocationText");
         _powerTxt = ComponentFactory.Instance.creatComponentByStylename("tips.pet.PowerTxt");
         _strengthMc = ComponentFactory.Instance.creatCustomObject("tip.pet.PropertyCoeBar");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("pet.ExpTxt");
         _hBox = new HBox();
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine.x = -7;
         _splitLine.scaleX = 0.95;
         _splitLine2 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine2.x = -7;
         _splitLine2.scaleX = 0.95;
         _splitLine3 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine3.x = -7;
         _splitLine3.scaleX = 0.95;
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _subBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox2 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _growthTxt = new FashionAttItem();
         _strengthCoeTxt = new FashionAttItem();
         _armorCoeTxt = new FashionAttItem();
         _intellectCoeTxt = new FashionAttItem();
         _staminaCoeTxt = new FashionAttItem();
         _propertyPointTxt = new FashionAttItem();
         _hpTxt = new FashionAttItem();
         _physicsAttackTxt = new FashionAttItem();
         _physicsDefenseTxt = new FashionAttItem();
         _magicAttackTxt = new FashionAttItem();
         _magicDefenseTxt = new FashionAttItem();
         addChild(_blackKingBg);
         addChild(_redBg);
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         _profileImg.setFrame(1);
         _con.addChild(_equipIcon);
         _equipIcon.x = 15;
         _equipIcon.y = 1;
         _con.addChild(_title);
         _title.width = 114;
         _title.x = 80;
         _title.y = 20;
         _con.addChild(_petSkillIcon);
         _petSkillIcon.x = 195;
         _petSkillIcon.y = 15;
         _con.addChild(_profileImg);
         _profileImg.x = 15;
         _profileImg.y = 10;
         _con.addChild(_type);
         _type.x = 2;
         _type.y = 65;
         _con.addChild(_vocation);
         _vocation.width = 180;
         _vocation.x = 43;
         _vocation.y = 65;
         _con.addChild(_hBox);
         _hBox.x = 140;
         _hBox.y = 45;
         _con.addChild(_strengthMc);
         _strengthMc.x = 18;
         _strengthMc.y = 87;
         _con.addChild(_expTxt);
         _expTxt.x = 52;
         _expTxt.y = 87;
         _expTxt.width = 140;
         _totalBox.x = 10;
         _totalBox.y = 110;
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         clean();
         if(tipData is PetData)
         {
            _equipIcon.icon = IconFactory.getPetHeadItemIcon(_data.templateId);
            _profileImg.setFrame(_data.quality);
            _bg.visible = false;
            hidenBg(_data.quality);
            showStar(tipData as PetData);
            _title.setFrame(_data.quality);
            _title.text = _data.name;
            _type.text = LanguageMgr.GetTranslation("public.level2",_data.grade);
            _vocation.text = (tipData as PetData).getLevelString();
            _powerTxt.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.ap") + String(_data.fightPower);
            if(_data.upgradeTemplte)
            {
               _expTxt.text = _data.curExp + " / " + _data.upgradeTemplte.Data;
               _loc2_ = Math.floor(_data.curExp * 100 / _data.upgradeTemplte.Data);
               _strengthMc.gotoAndStop(_loc2_);
            }
            else
            {
               _expTxt.text = "MAX";
               _strengthMc.gotoAndStop(100);
            }
            _loc1_ = _data.template.PetType - 100;
            if(_loc1_ < 7)
            {
               _petSkillIcon.setFrame(_loc1_);
            }
            else if(_loc1_ == 17)
            {
               _petSkillIcon.setFrame(7);
            }
            else if(_loc1_ == 18)
            {
               _petSkillIcon.setFrame(8);
            }
            else if(_loc1_ == 19)
            {
               _petSkillIcon.setFrame(9);
            }
            initAttribute(tipData as PetData);
            addChild(_con);
            addChild(_totalBox);
            _totalBox.addChild(_splitLine);
            _totalBox.addChild(_subBox1);
            _totalBox.addChild(_splitLine2);
            _totalBox.addChild(_subBox2);
            _totalBox.addChild(_splitLine3);
            _totalBox.addChild(_powerTxt);
            _bg.height = int(_totalBox.y + _totalBox.height);
            _blackKingBg.width = _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = _bg.width;
            _blackKingBg.height = _redBg.height = _yellowBg.height = _purpleBg.height = _blueBg.height = _greenBg.height = _whiteBg.height = _bg.height;
         }
         else if(tipData is String)
         {
         }
      }
      
      private function showStar(param1:PetData) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Bitmap = null;
         var _loc2_:UpgradeTemplateInfo = param1.qualityUpgradeTemplateInfo;
         if(_loc2_ == null)
         {
            return;
         }
         _loc3_ = param1.temQuality % 5 == 0 ? 5 : param1.temQuality % 5;
         if(param1.temQuality > 25)
         {
            _loc4_ = "asset.pet.bigMoonLightLevelImg";
         }
         else
         {
            _loc4_ = "asset.pet.StarLevelLightImg";
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap(_loc4_);
            _hBox.addChild(_loc5_);
            _loc6_++;
         }
      }
      
      private function initAttribute(param1:PetData) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("pet.growthRate");
         updateAttributeTxt(_growthTxt,_loc2_,_subBox1,param1.growthRate.toString());
         _loc2_ = LanguageMgr.GetTranslation("pet.strengthCoe");
         updateAttributeTxt(_strengthCoeTxt,_loc2_,_subBox1,param1.coeStrength + " / " + param1.coeStrengthLimit);
         _loc2_ = LanguageMgr.GetTranslation("pet.armorCoe");
         updateAttributeTxt(_armorCoeTxt,_loc2_,_subBox1,param1.coeArmor + " / " + param1.coeArmorLimit);
         _loc2_ = LanguageMgr.GetTranslation("pet.intellectCoe");
         updateAttributeTxt(_intellectCoeTxt,_loc2_,_subBox1,param1.coeIntellect + " / " + param1.coeIntellectLimit);
         _loc2_ = LanguageMgr.GetTranslation("pet.staminaCoe");
         updateAttributeTxt(_staminaCoeTxt,_loc2_,_subBox1,param1.coeStamina + " / " + param1.coeStaminaLimit);
         _loc2_ = LanguageMgr.GetTranslation("PetTip.remainPoint");
         updateAttributeTxt(_propertyPointTxt,_loc2_,_subBox1,param1.remainPoint.toString());
         _loc2_ = LanguageMgr.GetTranslation("pet.hp");
         updateAttributeTxt(_hpTxt,_loc2_,_subBox2,param1.Live.toString());
         _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06");
         updateAttributeTxt(_physicsAttackTxt,_loc2_,_subBox2,param1.Attack.toString());
         _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip07");
         updateAttributeTxt(_physicsDefenseTxt,_loc2_,_subBox2,param1.Defence.toString());
         _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08");
         updateAttributeTxt(_magicAttackTxt,_loc2_,_subBox2,param1.MagicAttack.toString());
         _loc2_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip09");
         updateAttributeTxt(_magicDefenseTxt,_loc2_,_subBox2,param1.MagicDefence.toString());
      }
      
      private function updateAttributeTxt(param1:FashionAttItem, param2:String, param3:VBox, param4:String) : void
      {
         if(param4 != "0")
         {
            param1.setData(param2 + " " + param4);
            param3.addChild(param1);
         }
      }
      
      protected function clean() : void
      {
         _hBox.removeAllChild();
         _subBox1.removeAllChild();
         _subBox2.removeAllChild();
         _totalBox.removeAllChild();
         if(_con.parent)
         {
            _con.parent.removeChild(_con);
         }
         if(_totalBox.parent)
         {
            _totalBox.parent.removeChild(_totalBox);
         }
      }
      
      private function hidenBg(param1:int) : void
      {
         _blackKingBg.visible = false;
         _redBg.visible = false;
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               break;
            case 1:
               _greenBg.visible = true;
               break;
            case 2:
               _blueBg.visible = true;
               break;
            case 3:
               _purpleBg.visible = true;
               break;
            case 4:
               _yellowBg.visible = true;
               break;
            case 5:
               _redBg.visible = true;
               break;
            case 6:
               _blackKingBg.visible = true;
         }
      }
   }
}

