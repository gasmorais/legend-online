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
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.goods.FashionAttItem;
   
   public class DreamArenaPetTips extends BaseTip
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
      
      private var _hbox:HBox;
      
      private var _strengthCoeTxt:FashionAttItem;
      
      private var _armorCoeTxt:FashionAttItem;
      
      private var _intellectCoeTxt:FashionAttItem;
      
      private var _staminaCoeTxt:FashionAttItem;
      
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
      
      private var _strengthMc:MovieClip;
      
      private var _hBox:HBox;
      
      private var _expTxt:FilterFrameText;
      
      private var petData:PetData;
      
      public function DreamArenaPetTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 237;
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
         _strengthMc = ComponentFactory.Instance.creatCustomObject("tip.pet.PropertyCoeBar");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("pet.ExpTxt");
         _hBox = new HBox();
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine.x = -7;
         _splitLine.scaleX = 0.95;
         _splitLine2 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine2.x = -7;
         _splitLine2.scaleX = 0.95;
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _subBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox2 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _strengthCoeTxt = new FashionAttItem();
         _armorCoeTxt = new FashionAttItem();
         _intellectCoeTxt = new FashionAttItem();
         _staminaCoeTxt = new FashionAttItem();
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
         _title.x = 140;
         _title.y = 20;
         _con.addChild(_petSkillIcon);
         _petSkillIcon.x = 235;
         _petSkillIcon.y = 15;
         _con.addChild(_profileImg);
         _profileImg.x = 15;
         _profileImg.y = 10;
         _con.addChild(_type);
         _type.x = 6;
         _type.y = 65;
         _con.addChild(_vocation);
         _vocation.x = 45;
         _vocation.y = 65;
         _con.addChild(_hBox);
         _hBox.x = 150;
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
         petData = new PetData();
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:SkillPropertyTempInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         clean();
         if(tipData && tipData is DreamArenaTempInfo)
         {
            setPetTipData(tipData as DreamArenaTempInfo,petData);
            _loc1_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID((tipData as DreamArenaTempInfo).PropertyId);
            _equipIcon.icon = IconFactory.getPetHeadItemIcon(petData.templateId);
            _profileImg.setFrame(petData.quality);
            _bg.visible = false;
            hidenBg(petData.quality);
            showStar(petData);
            _title.setFrame(petData.quality);
            _title.text = petData.name;
            _type.text = LanguageMgr.GetTranslation("public.level2",petData.grade);
            _vocation.text = petData.getLevelString();
            if(petData.upgradeTemplte)
            {
               _expTxt.text = petData.curExp + " / " + petData.upgradeTemplte.Data;
               _loc3_ = Math.floor(petData.curExp * 100 / petData.upgradeTemplte.Data);
               _strengthMc.gotoAndStop(_loc3_);
            }
            else
            {
               _expTxt.text = "MAX";
               _strengthMc.gotoAndStop(100);
            }
            _loc2_ = petData.template.PetType - 100;
            if(_loc2_ < 7)
            {
               _petSkillIcon.setFrame(_loc2_);
            }
            else if(_loc2_ == 17)
            {
               _petSkillIcon.setFrame(7);
            }
            else if(_loc2_ == 18)
            {
               _petSkillIcon.setFrame(8);
            }
            else if(_loc2_ == 19)
            {
               _petSkillIcon.setFrame(9);
            }
            initAttribute(petData,_loc1_);
            addChild(_con);
            addChild(_totalBox);
            _totalBox.addChild(_splitLine);
            _totalBox.addChild(_subBox1);
            _totalBox.addChild(_splitLine2);
            _totalBox.addChild(_subBox2);
            _bg.height = int(_totalBox.y + _totalBox.height);
            _blackKingBg.width = _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = _bg.width = 280;
            _blackKingBg.height = _redBg.height = _yellowBg.height = _purpleBg.height = _blueBg.height = _greenBg.height = _whiteBg.height = _bg.height;
         }
      }
      
      private function setPetTipData(param1:DreamArenaTempInfo, param2:PetData) : void
      {
         param2.templateId = param1.TypeTemplateId;
         param2.quality = 6;
         param2.grade = 80;
         param2.name = param2.template.TemplateName;
         param2.temQuality = 31;
         param2.coeStrength = param2.coeStrengthLimit = int(param2.template.PowerApt.split(",")[1]);
         param2.coeArmor = param2.coeArmorLimit = int(param2.template.ArmorApt.split(",")[1]);
         param2.coeIntellect = param2.coeIntellectLimit = int(param2.template.IntelApt.split(",")[1]);
         param2.coeStamina = param2.coeStaminaLimit = int(param2.template.PhysiApt.split(",")[1]);
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
      
      private function initAttribute(param1:PetData, param2:SkillPropertyTempInfo) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("pet.strengthCoe");
         updateAttributeTxt(_strengthCoeTxt,_loc3_,_subBox1,param1.coeStrength + " / " + param1.coeStrengthLimit);
         _loc3_ = LanguageMgr.GetTranslation("pet.armorCoe");
         updateAttributeTxt(_armorCoeTxt,_loc3_,_subBox1,param1.coeArmor + " / " + param1.coeArmorLimit);
         _loc3_ = LanguageMgr.GetTranslation("pet.intellectCoe");
         updateAttributeTxt(_intellectCoeTxt,_loc3_,_subBox1,param1.coeIntellect + " / " + param1.coeIntellectLimit);
         _loc3_ = LanguageMgr.GetTranslation("pet.staminaCoe");
         updateAttributeTxt(_staminaCoeTxt,_loc3_,_subBox1,param1.coeStamina + " / " + param1.coeStaminaLimit);
         _loc3_ = LanguageMgr.GetTranslation("pet.hp");
         updateAttributeTxt(_hpTxt,_loc3_,_subBox2,param2.Live.toString());
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06");
         updateAttributeTxt(_physicsAttackTxt,_loc3_,_subBox2,param2.Attack.toString());
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip07");
         updateAttributeTxt(_physicsDefenseTxt,_loc3_,_subBox2,param2.Defence.toString());
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08");
         updateAttributeTxt(_magicAttackTxt,_loc3_,_subBox2,param2.MagicAttack.toString());
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip09");
         updateAttributeTxt(_magicDefenseTxt,_loc3_,_subBox2,param2.MagicDefence.toString());
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

