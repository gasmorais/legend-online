package playerinfo.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyModel;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   
   public class ThaneAttributeFrame extends Frame
   {
      
      private var _mutiBg02:MutipleImage;
      
      private var _mutiBg03:MutipleImage;
      
      private var _physicAttackTxt:FilterFrameText;
      
      private var _physicDefenceTxt:FilterFrameText;
      
      private var _magicAttackTxt:FilterFrameText;
      
      private var _magicDefence:FilterFrameText;
      
      private var _critTxt:FilterFrameText;
      
      private var _penetrateTxt:FilterFrameText;
      
      private var _parryTxt:FilterFrameText;
      
      private var _hpTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _dingliTxt:FilterFrameText;
      
      private var _physicAttackTip1:Component;
      
      private var _physicAttackTip2:StripView;
      
      private var _physicDefenceTip1:Component;
      
      private var _physicDefenceTip2:StripView;
      
      private var _magicAttackTip1:Component;
      
      private var _magicAttackTip2:StripView;
      
      private var _magicDefenceTip1:Component;
      
      private var _magicDefenceTip2:StripView;
      
      private var _critTip1:Component;
      
      private var _critTip2:StripView;
      
      private var _parryTip1:Component;
      
      private var _parryTip2:StripView;
      
      private var _hpTip1:Component;
      
      private var _hpTip2:StripView;
      
      private var _countTip1:Component;
      
      private var _countTip2:StripView;
      
      private var _dingliTip1:Component;
      
      private var _dingliTip2:StripView;
      
      private var _penetrateTip1:Component;
      
      private var _penetrateTip2:StripView;
      
      private var _strengthTxt:FilterFrameText;
      
      private var _agilityTxt:FilterFrameText;
      
      private var _abilityTxt:FilterFrameText;
      
      private var _physiqueTxt:FilterFrameText;
      
      private var _captainTxt:FilterFrameText;
      
      private var _baseAttributeTip1:StripView;
      
      private var _baseAttributeTip2:StripView;
      
      private var _baseAttributeTip3:StripView;
      
      private var _baseAttributeTip4:StripView;
      
      private var _baseAttributeTip5:StripView;
      
      private var _baseAttributeTip6:StripView;
      
      private var _baseAttributeTip7:StripView;
      
      private var _gappellTxt:GradientText;
      
      private var _playerAttribute:PlayerAttributeView;
      
      private var _thane:ThaneInfo;
      
      private var _normalBtn:SelectedIconButton;
      
      private var _guardBtn:SelectedIconButton;
      
      private var _lineImg:Image;
      
      private var _normalPanel:Sprite;
      
      private var _guardPanel:Sprite;
      
      private var _intensityTxt:FilterFrameText;
      
      private var _tenacityTxt:FilterFrameText;
      
      private var _battleWillTxt:FilterFrameText;
      
      private var _fireTxt:FilterFrameText;
      
      private var _waterTxt:FilterFrameText;
      
      private var _windTxt:FilterFrameText;
      
      private var _eleTxt:FilterFrameText;
      
      private var _lightTxt:FilterFrameText;
      
      private var _darkTxt:FilterFrameText;
      
      private var _resistStrikeTxt:FilterFrameText;
      
      private var _resResistTxt:FilterFrameText;
      
      private var _battleWillTipRight:StripView;
      
      private var _fireTipRight:StripView;
      
      private var _waterTipRight:StripView;
      
      private var _windTipRight:StripView;
      
      private var _eleTipRight:StripView;
      
      private var _lightTipRight:StripView;
      
      private var _darkTipRight:StripView;
      
      private var _resistStrikeTipRight:StripView;
      
      private var _resResistTipRight:StripView;
      
      private var _vbox01:VBox;
      
      private var _txtVbox01:VBox;
      
      private var _vbox02:VBox;
      
      private var _txtVbox02:VBox;
      
      private var _vbox03:VBox;
      
      private var _txtVbox03:VBox;
      
      private var _isHideAppell:Boolean = false;
      
      private var _curSelectedBtn:BaseButton;
      
      public function ThaneAttributeFrame()
      {
         super();
         initView();
         initEvent();
         __mouseClickHandler(null);
      }
      
      public function set isHideAppell(param1:Boolean) : void
      {
         _isHideAppell = param1;
      }
      
      private function initView() : void
      {
         var _loc2_:Image = null;
         var _loc6_:int = 0;
         var _loc1_:FilterFrameText = null;
         var _loc8_:StripView = null;
         var _loc4_:FilterFrameText = null;
         _normalBtn = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.NormalButton");
         _guardBtn = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.BattleGuardButton");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.lineImg");
         _normalPanel = new Sprite();
         _guardPanel = new Sprite();
         titleText = LanguageMgr.GetTranslation("playerinfo.view.ThaneAttributeFrame.titleText");
         _vbox01 = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.vbox01");
         var _loc9_:String = "asset.playerinfo.attributeImage02,asset.playerinfo.attributeImage03,asset.playerinfo.attributeImage04,asset.playerinfo.attributeImage05,asset.playerinfo.attributeImage06,asset.playerinfo.QiangduImg,asset.playerinfo.RenxingImg";
         var _loc7_:Array = _loc9_.split(",");
         for each(var _loc5_:String in _loc7_)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.vbox01.Item") as Image;
            _loc2_.resourceLink = _loc5_;
            _vbox01.addChild(_loc2_);
         }
         _strengthTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _agilityTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _abilityTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _physiqueTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _captainTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _intensityTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _tenacityTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         var _loc3_:Array = [_strengthTxt,_agilityTxt,_abilityTxt,_physiqueTxt,_captainTxt,_intensityTxt,_tenacityTxt];
         _txtVbox01 = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.txtVbox01");
         var _loc10_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc6_] as FilterFrameText;
            _loc8_ = ComponentFactory.Instance.creatCustomObject("army.attribute.BaseAttributeTip1");
            _loc8_.addChild(_loc1_);
            _txtVbox01.addChild(_loc8_);
            _loc10_[_loc6_] = _loc8_;
            _loc6_++;
         }
         _baseAttributeTip1 = _loc10_[0] as StripView;
         _baseAttributeTip2 = _loc10_[1] as StripView;
         _baseAttributeTip3 = _loc10_[2] as StripView;
         _baseAttributeTip4 = _loc10_[3] as StripView;
         _baseAttributeTip5 = _loc10_[4] as StripView;
         _baseAttributeTip6 = _loc10_[5] as StripView;
         _baseAttributeTip7 = _loc10_[6] as StripView;
         _vbox02 = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.vbox02");
         _battleWillTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _fireTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _waterTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _windTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _eleTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _lightTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _darkTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _resistStrikeTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _resResistTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _txtVbox02 = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.txtVbox02");
         _loc3_ = [_battleWillTxt,_fireTxt,_waterTxt,_windTxt,_eleTxt,_lightTxt,_darkTxt,_resistStrikeTxt,_resResistTxt];
         _loc10_ = [];
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc6_] as FilterFrameText;
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("army.attribute.battleTxt");
            _loc8_ = ComponentFactory.Instance.creatCustomObject("army.attribute.BaseAttributeTip1");
            _loc8_.addChild(_loc1_);
            _txtVbox02.addChild(_loc8_);
            _loc4_.text = LanguageMgr.GetTranslation("playerinfo.view.ThaneAttributeFrame.txt" + _loc6_);
            _vbox02.addChild(_loc4_);
            _loc10_[_loc6_] = _loc8_;
            _loc6_++;
         }
         _battleWillTipRight = _loc10_[0] as StripView;
         _fireTipRight = _loc10_[1] as StripView;
         _waterTipRight = _loc10_[2] as StripView;
         _windTipRight = _loc10_[3] as StripView;
         _eleTipRight = _loc10_[4] as StripView;
         _lightTipRight = _loc10_[5] as StripView;
         _darkTipRight = _loc10_[6] as StripView;
         _resistStrikeTipRight = _loc10_[7] as StripView;
         _resResistTipRight = _loc10_[8] as StripView;
         _mutiBg02 = ComponentFactory.Instance.creatComponentByStylename("army.attribute.mutiBg02");
         _vbox03 = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.vbox03");
         _loc9_ = "asset.playerinfo.attributeImage08,asset.playerinfo.attributeImage09,asset.playerinfo.attributeImage10,asset.playerinfo.attributeImage11,asset.playerinfo.attributeImage12,asset.playerinfo.attributeImage16,asset.playerinfo.attributeImage13,asset.playerinfo.attributeImage14,asset.playerinfo.attributeImage15,asset.playerinfo.attributeImage17";
         _loc7_ = _loc9_.split(",");
         _loc10_ = [];
         for each(_loc5_ in _loc7_)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.vbox01.Item") as Image;
            _loc2_.resourceLink = _loc5_;
            _vbox03.addChild(_loc2_);
            _loc10_.push(_loc2_);
         }
         _physicAttackTip1 = _loc10_[0];
         _physicDefenceTip1 = _loc10_[1];
         _magicAttackTip1 = _loc10_[2];
         _magicDefenceTip1 = _loc10_[3];
         _critTip1 = _loc10_[4];
         _penetrateTip1 = _loc10_[5];
         _parryTip1 = _loc10_[6];
         _hpTip1 = _loc10_[7];
         _countTip1 = _loc10_[8];
         _dingliTip1 = _loc10_[9];
         _physicAttackTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _physicDefenceTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _magicAttackTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _magicDefence = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _critTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _penetrateTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _parryTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _dingliTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.StrengthTxt");
         _txtVbox03 = ComponentFactory.Instance.creatComponentByStylename("ThaneAttributeFrame.txtVbox03");
         _loc3_ = [_physicAttackTxt,_physicDefenceTxt,_magicAttackTxt,_magicDefence,_critTxt,_penetrateTxt,_parryTxt,_hpTxt,_countTxt,_dingliTxt];
         _loc10_ = [];
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc6_] as FilterFrameText;
            _loc8_ = ComponentFactory.Instance.creatCustomObject("army.attribute.BaseAttributeTip1");
            _loc8_.addChild(_loc1_);
            _txtVbox03.addChild(_loc8_);
            _loc10_[_loc6_] = _loc8_;
            _loc6_++;
         }
         _physicAttackTip2 = _loc10_[0];
         _physicDefenceTip2 = _loc10_[1];
         _magicAttackTip2 = _loc10_[2];
         _magicDefenceTip2 = _loc10_[3];
         _critTip2 = _loc10_[4];
         _penetrateTip2 = _loc10_[5];
         _parryTip2 = _loc10_[6];
         _hpTip2 = _loc10_[7];
         _countTip2 = _loc10_[8];
         _dingliTip2 = _loc10_[9];
         addToContent(_mutiBg02);
         addToContent(_normalBtn);
         addToContent(_guardBtn);
         addToContent(_lineImg);
         addToContent(_normalPanel);
         addToContent(_guardPanel);
         _normalPanel.addChild(_vbox01);
         _normalPanel.addChild(_txtVbox01);
         _guardPanel.addChild(_vbox02);
         _guardPanel.addChild(_txtVbox02);
         addToContent(_vbox03);
         addToContent(_txtVbox03);
         _playerAttribute = ComponentFactory.Instance.creatCustomObject("army.PlayerAttribute");
         _normalPanel.addChild(_playerAttribute);
         _intensityTxt.text = "0";
         _tenacityTxt.text = "0";
         _battleWillTxt.text = "0";
         _fireTxt.text = "0";
         _waterTxt.text = "0";
         _windTxt.text = "0";
         _eleTxt.text = "0";
         _lightTxt.text = "0";
         _darkTxt.text = "0";
         _resistStrikeTxt.text = "0";
         _resResistTxt.text = "0";
      }
      
      private function createShape1() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16711680,0);
         _loc1_.graphics.drawRect(0,0,71,19);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function createShape2() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16711680,0);
         _loc1_.graphics.drawRect(0,0,48,20);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function initEvent() : void
      {
         army.baseHero.addEventListener("THANE_INFO_UPDATE",__thaneInfoChangeHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemUpdateHandler);
         _normalBtn.addEventListener("click",__mouseClickHandler);
         _guardBtn.addEventListener("click",__mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         army.baseHero.removeEventListener("THANE_INFO_UPDATE",__thaneInfoChangeHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemUpdateHandler);
         if(_normalBtn)
         {
            _normalBtn.removeEventListener("click",__mouseClickHandler);
         }
         if(_guardBtn)
         {
            _guardBtn.removeEventListener("click",__mouseClickHandler);
         }
      }
      
      public function switchPanel(param1:int) : void
      {
         if(param1 == 1)
         {
            _normalBtn.dispatchEvent(new MouseEvent("click"));
         }
         else if(param1 == 2)
         {
            _guardBtn.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         _normalPanel.visible = false;
         _guardPanel.visible = false;
         _guardBtn.selected = false;
         _normalBtn.selected = false;
         if(param1 && param1.currentTarget == _guardBtn)
         {
            _guardPanel.visible = true;
            _guardBtn.selected = true;
            _curSelectedBtn = _guardBtn;
            _gappellTxt.visible = false;
         }
         else
         {
            _normalPanel.visible = true;
            _normalBtn.selected = true;
            _curSelectedBtn = _normalBtn;
            if(_thane && _thane.userId != playerInfo.userId)
            {
               _gappellTxt.visible = true;
            }
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.objectId == thane.id && _loc2_.templateInfo.MasterType == 1)
         {
            refresh();
         }
         else if(_loc2_.userId == thane.userId && _loc2_.templateInfo.SonType == 312)
         {
            refresh();
         }
      }
      
      private function __thaneInfoChangeHandler(param1:PlayerEvent) : void
      {
         if(!_thane)
         {
            return;
         }
         if(_thane.id == thane.id)
         {
            refresh();
         }
      }
      
      public function set thane(param1:ThaneInfo) : void
      {
         _thane = param1;
         if(!_thane)
         {
            return;
         }
         refresh();
      }
      
      public function get thane() : ThaneInfo
      {
         return _thane;
      }
      
      public function refresh() : void
      {
         var _loc12_:FilterFrameText = null;
         var _loc4_:Array = null;
         var _loc1_:Array = null;
         var _loc10_:Array = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Component = null;
         var _loc9_:Array = null;
         _physicAttackTxt.text = _thane.attackProrerty.totalPhyAttack.toString();
         _physicDefenceTxt.text = _thane.attackProrerty.totalPhyDefence.toString();
         _magicAttackTxt.text = _thane.attackProrerty.totalMagicAttack.toString();
         _magicDefence.text = _thane.attackProrerty.totalMagicDefence.toString();
         _critTxt.text = _thane.attackProrerty.totalForceHit.toString();
         _penetrateTxt.text = _thane.attackProrerty.totalPenetrate.toString();
         _parryTxt.text = _thane.attackProrerty.totalParry.toString();
         _hpTxt.text = _thane.attackProrerty.totalLive.toString();
         _countTxt.text = _thane.attackProrerty.totalConatArmy.toString();
         _dingliTxt.text = _thane.attackProrerty.totalDingli.toString();
         _strengthTxt.text = (thane.baseProperty.totalPower + model.addStrength).toString();
         _agilityTxt.text = (thane.baseProperty.totalAgility + model.addAgility).toString();
         _abilityTxt.text = (thane.baseProperty.totalIntellect + model.addAbility).toString();
         _captainTxt.text = (thane.baseProperty.totalCaptain + model.addCaptain).toString();
         _physiqueTxt.text = (thane.baseProperty.totalPhysique + model.addPhysique).toString();
         _intensityTxt.text = _thane.attackProrerty.totalIntensity.toString();
         _tenacityTxt.text = _thane.attackProrerty.totalTenacity.toString();
         var _loc13_:Array = [_battleWillTxt,_fireTxt,_waterTxt,_windTxt,_eleTxt,_lightTxt,_darkTxt,_resistStrikeTxt,_resResistTxt];
         if(thane.battleGuardInfo)
         {
            _loc4_ = thane.battleGuardInfo.getAllPoint();
         }
         if(thane.enterWarPet)
         {
            _loc1_ = [];
            _loc1_[0] = 0;
            _loc1_[1] = thane.enterWarPet.resFire;
            _loc1_[2] = thane.enterWarPet.resWater;
            _loc1_[3] = thane.enterWarPet.resWind;
            _loc1_[4] = thane.enterWarPet.resElect;
            _loc1_[5] = thane.enterWarPet.resLight;
            _loc1_[6] = thane.enterWarPet.resDark;
         }
         var _loc7_:Array = [thane.baseProperty.totalBattleWill,thane.baseProperty.totalFireResi,thane.baseProperty.totalWaterResi,thane.baseProperty.totalWindResi,thane.baseProperty.totalElecResi,thane.baseProperty.totalLightResi,thane.baseProperty.totalDarkResi,thane.baseProperty.totalStrikeResi,thane.baseProperty.totalResistResi];
         var _loc2_:Dictionary = planesModel.getTotalRewards();
         _loc8_ = 0;
         while(_loc8_ < 8)
         {
            if(!_loc2_[_loc8_])
            {
               _loc2_[1] = 0;
            }
            _loc8_++;
         }
         _loc10_ = [_loc2_[1],_loc2_[2],_loc2_[3],_loc2_[5],_loc2_[4],_loc2_[7],_loc2_[6]];
         _loc6_ = 0;
         while(_loc6_ < _loc13_.length)
         {
            _loc12_ = _loc13_[_loc6_] as FilterFrameText;
            _loc12_.text = _loc7_[_loc6_] + "";
            _loc12_.setFrame(1);
            _loc6_++;
         }
         if(_thane.userId == playerInfo.userId)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc13_.length)
            {
               _loc12_ = _loc13_[_loc6_] as FilterFrameText;
               if(_loc7_[_loc6_] < 0)
               {
                  _loc12_.setFrame(3);
               }
               else if(_loc7_[_loc6_] > 0)
               {
                  _loc12_.setFrame(2);
               }
               else
               {
                  _loc12_.setFrame(1);
               }
               _loc6_++;
            }
         }
         _loc6_ = 0;
         var _loc11_:String = getHonerName(_thane);
         var _loc5_:String = getHonerStyle(_thane);
         setGradientAppell(_loc5_,_loc11_);
         if(_thane.userId == playerInfo.userId)
         {
            _playerAttribute.visible = true;
            _gappellTxt.visible = false;
            _loc9_ = [LanguageMgr.GetTranslation("armyII.ThaneAttributeView.strength"),LanguageMgr.GetTranslation("armyII.ThaneAttributeView.agility"),LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ability"),LanguageMgr.GetTranslation("armyII.ThaneAttributeView.physique"),LanguageMgr.GetTranslation("armyII.ThaneAttributeView.captain"),LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip20") + thane.attackProrerty.totalIntensityEffect + "%",LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip21") + thane.attackProrerty.totalTenacityEffect + "%"];
            _loc6_ = 0;
            while(_loc6_ < _loc9_.length)
            {
               _loc3_ = _vbox01.getChildAt(_loc6_) as Component;
               if(_loc3_)
               {
                  _loc3_.tipData = _loc9_[_loc6_];
               }
               _loc6_++;
            }
            _strengthTxt.setFrame(thane.hasEffectBaseProperty("powerPoint"));
            _agilityTxt.setFrame(thane.hasEffectBaseProperty("agilityPoint"));
            _abilityTxt.setFrame(thane.hasEffectBaseProperty("intellectPoint"));
            _captainTxt.setFrame(thane.hasEffectBaseProperty("captainPoint"));
            _physiqueTxt.setFrame(thane.hasEffectBaseProperty("physiquePoint"));
            _physicAttackTxt.setFrame(_thane.hasEffectAttackProperty("basePhyAttack"));
            _physicDefenceTxt.setFrame(_thane.hasEffectAttackProperty("basePhyDefence"));
            _magicAttackTxt.setFrame(_thane.hasEffectAttackProperty("baseMagicAttack"));
            _magicDefence.setFrame(_thane.hasEffectAttackProperty("baseMagicDefence"));
            _critTxt.setFrame(_thane.hasEffectAttackProperty("baseForceHit"));
            _parryTxt.setFrame(_thane.hasEffectAttackProperty("baseParry"));
            _hpTxt.setFrame(_thane.hasEffectAttackProperty("baseLive"));
            _countTxt.setFrame(_thane.hasEffectAttackProperty("baseConatArmy"));
            _dingliTxt.setFrame(1);
            refreshTip();
         }
         else
         {
            _playerAttribute.visible = false;
            _gappellTxt.visible = true;
            _loc6_ = 0;
            while(_loc6_ < _vbox01.numChildren)
            {
               _loc3_ = _vbox01.getChildAt(_loc6_) as Component;
               if(_loc3_)
               {
                  _loc3_.tipData = null;
               }
               _loc6_++;
            }
            _strengthTxt.setFrame(1);
            _agilityTxt.setFrame(1);
            _abilityTxt.setFrame(1);
            _captainTxt.setFrame(1);
            _physiqueTxt.setFrame(1);
            _physicAttackTxt.setFrame(1);
            _physicDefenceTxt.setFrame(1);
            _magicAttackTxt.setFrame(1);
            _magicDefence.setFrame(1);
            _critTxt.setFrame(1);
            _parryTxt.setFrame(1);
            _hpTxt.setFrame(1);
            _countTxt.setFrame(1);
            _dingliTxt.setFrame(1);
         }
         _guardBtn.visible = thane.grades >= 55;
      }
      
      private function setGradientAppell(param1:String, param2:String) : void
      {
         ObjectUtils.disposeObject(_gappellTxt);
         _gappellTxt = null;
         _gappellTxt = ComponentFactory.Instance.creatComponentByStylename(param1);
         _gappellTxt.text = param2;
         _gappellTxt.x = (width - _gappellTxt.width - 34) / 2;
         _gappellTxt.y = 32;
         _gappellTxt.mouseEnabled = false;
         _gappellTxt.mouseChildren = false;
         if(!_isHideAppell)
         {
            addToContent(_gappellTxt);
         }
      }
      
      private function getHonerStyle(param1:ThaneInfo) : String
      {
         var _loc2_:String = "army.HonerText";
         if(VersionSwitch.APPELL && param1.appellId != 0 && param1.appellInfo)
         {
            _loc2_ += param1.appellInfo.Quality;
         }
         return _loc2_;
      }
      
      private function getHonerName(param1:ThaneInfo) : String
      {
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
         if(VersionSwitch.APPELL && param1.appellId != 0 && param1.appellInfo)
         {
            _loc2_ = param1.appellInfo.Title;
         }
         return _loc2_;
      }
      
      private function refreshTip() : void
      {
         var _loc2_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc3_:Array = null;
         var _loc5_:Array = null;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:Array = null;
         var _loc6_:Component = null;
         var _loc1_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01") + ":";
         _baseAttributeTip1.tipData = getTipData(_loc1_,thane.baseProperty.basePowerPoint + model.addStrength,thane.baseProperty.totalPower);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02") + ":";
         _baseAttributeTip2.tipData = getTipData(_loc1_,thane.baseProperty.baseAgilityPoint + model.addAgility,thane.baseProperty.totalAgility);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03") + ":";
         _baseAttributeTip3.tipData = getTipData(_loc1_,thane.baseProperty.baseIntellectPoint + model.addAbility,thane.baseProperty.totalIntellect);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04") + ":";
         _baseAttributeTip4.tipData = getTipData(_loc1_,thane.baseProperty.basePhysiquePoint + model.addPhysique,thane.baseProperty.totalPhysique);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05") + ":";
         _baseAttributeTip5.tipData = getTipData(_loc1_,thane.baseProperty.baseCaptainPoint + model.addCaptain,thane.baseProperty.totalCaptain);
         _baseAttributeTip6.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip20") + thane.attackProrerty.totalIntensityEffect + "%";
         _baseAttributeTip7.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip21") + thane.attackProrerty.totalTenacityEffect + "%";
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06") + ":";
         _physicAttackTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainTip06");
         _physicAttackTip2.tipData = getTipData(_loc1_,thane.attackProrerty.basePhyAttack,thane.attackProrerty.totalPhyAttack);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip07") + ":";
         _physicDefenceTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainTip07");
         _physicDefenceTip2.tipData = getTipData(_loc1_,thane.attackProrerty.basePhyDefence,thane.attackProrerty.totalPhyDefence);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08") + ":";
         _magicAttackTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainTip08");
         _magicAttackTip2.tipData = getTipData(_loc1_,thane.attackProrerty.baseMagicAttack,thane.attackProrerty.totalMagicAttack);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip09") + ":";
         _magicDefenceTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainTip09");
         _magicDefenceTip2.tipData = getTipData(_loc1_,thane.attackProrerty.baseMagicDefence,thane.attackProrerty.totalMagicDefence);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10") + ":";
         _critTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainTip10");
         _critTip2.tipData = getTipData(_loc1_,thane.attackProrerty.baseForceHit,thane.attackProrerty.totalForceHit);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19") + ":";
         _parryTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainTip19");
         _parryTip2.tipData = getTipData(_loc1_,thane.attackProrerty.baseParry,thane.attackProrerty.totalParry);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11") + ":";
         _hpTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainTip11");
         _hpTip2.tipData = getTipData(_loc1_,thane.attackProrerty.baseLive,thane.attackProrerty.totalLive);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip12") + ":";
         _countTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainTip12");
         _countTip2.tipData = getTipData(_loc1_,thane.attackProrerty.baseConatArmy,thane.attackProrerty.totalConatArmy);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25") + ":";
         _penetrateTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainTip25");
         _penetrateTip2.tipData = getTipData(_loc1_,thane.attackProrerty.basePenetrate,thane.attackProrerty.totalPenetrate);
         _dingliTip1.tipData = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.ExplainDingli");
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Dingli") + ":";
         _dingliTip2.tipData = getTipData(_loc1_,thane.attackProrerty.baseDingli,thane.attackProrerty.totalDingli);
         if(thane.battleGuardInfo)
         {
            _loc2_ = thane.battleGuardInfo.getAllPoint();
            _loc9_ = [0,0,0,0,0,0,0];
            if(thane.enterWarPet)
            {
               _loc9_[1] = thane.enterWarPet.resFire;
               _loc9_[2] = thane.enterWarPet.resWater;
               _loc9_[3] = thane.enterWarPet.resWind;
               _loc9_[4] = thane.enterWarPet.resElect;
               _loc9_[5] = thane.enterWarPet.resLight;
               _loc9_[6] = thane.enterWarPet.resDark;
            }
            _loc10_ = LanguageMgr.GetTranslation("ThaneAttributeTip.tip2").split(",");
            _loc3_ = LanguageMgr.GetTranslation("ThaneAttributeTip.tip3").split(",");
            _loc5_ = [_battleWillTxt,_fireTxt,_waterTxt,_windTxt,_eleTxt,_lightTxt,_darkTxt,_resistStrikeTxt,_resResistTxt];
            _loc7_ = 0;
            while(_loc7_ < _loc10_.length)
            {
               if(_loc7_ != 0)
               {
                  _loc4_ = Math.floor(int(_loc5_[_loc7_].text) * 0.12);
                  if(_loc4_ > 90)
                  {
                     _loc4_ = 90;
                  }
                  _loc3_[_loc7_] = "";
               }
               else
               {
                  _loc3_[_loc7_] = "";
               }
               _loc7_++;
            }
            _loc8_ = [_battleWillTipRight,_fireTipRight,_waterTipRight,_windTipRight,_eleTipRight,_lightTipRight,_darkTipRight,_resistStrikeTipRight,_resResistTipRight];
            _loc7_ = 0;
            while(_loc7_ < _loc10_.length)
            {
               _loc6_ = _vbox02.getChildAt(_loc7_) as Component;
               if(_loc6_)
               {
                  _loc6_.tipData = _loc3_[_loc7_] as String;
               }
               _loc6_ = _loc8_[_loc7_] as Component;
               if(_loc6_)
               {
                  _loc6_.tipData = _loc3_[_loc7_] as String;
               }
               _loc7_++;
            }
         }
      }
      
      private function getTipData(param1:String, param2:Number, param3:Number) : String
      {
         return getTipString(param1,param2,param3 - param2);
      }
      
      private function getTipString(param1:String, param2:int, param3:int) : String
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(param3 > 0)
         {
            _loc4_ = "#59cd41";
            _loc5_ = "+" + param3;
         }
         else if(param3 < 0)
         {
            _loc4_ = "#FF0000";
            _loc5_ = "" + param3;
         }
         else
         {
            _loc4_ = "#FFFFFF";
            _loc5_ = "";
         }
         _loc5_ = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc4_,_loc5_);
         if(param2 < 0)
         {
            _loc4_ = "#FF0000";
         }
         else
         {
            _loc4_ = "#FFFFFF";
         }
         var _loc6_:String = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc4_,param2);
         return param1 + _loc6_ + _loc5_;
      }
      
      private function getAddBy(param1:int) : String
      {
         if(param1 > 0)
         {
            return "+" + param1;
         }
         if(param1 == 0)
         {
            return "";
         }
         return "" + param1;
      }
      
      private function get army() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : ArmyModel
      {
         return control.model;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get planesModel() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_physicAttackTxt);
         _physicAttackTxt = null;
         ObjectUtils.disposeObject(_physicDefenceTxt);
         _physicDefenceTxt = null;
         ObjectUtils.disposeObject(_magicDefence);
         _magicDefence = null;
         ObjectUtils.disposeObject(_critTxt);
         _critTxt = null;
         ObjectUtils.disposeObject(_penetrateTxt);
         _penetrateTxt = null;
         ObjectUtils.disposeObject(_parryTxt);
         _parryTxt = null;
         ObjectUtils.disposeObject(_hpTxt);
         _hpTxt = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_dingliTxt);
         _dingliTxt = null;
         ObjectUtils.disposeObject(_physicAttackTip1);
         _physicAttackTip1 = null;
         ObjectUtils.disposeObject(_physicDefenceTip1);
         _physicDefenceTip1 = null;
         ObjectUtils.disposeObject(_magicAttackTip1);
         _magicAttackTip1 = null;
         ObjectUtils.disposeObject(_magicDefenceTip1);
         _magicDefenceTip1 = null;
         ObjectUtils.disposeObject(_critTip1);
         _critTip1 = null;
         ObjectUtils.disposeObject(_hpTip1);
         _hpTip1 = null;
         ObjectUtils.disposeObject(_countTip1);
         _countTip1 = null;
         ObjectUtils.disposeObject(_physicAttackTip2);
         _physicAttackTip2 = null;
         ObjectUtils.disposeObject(_physicDefenceTip2);
         _physicDefenceTip2 = null;
         ObjectUtils.disposeObject(_magicAttackTip2);
         _magicAttackTip2 = null;
         ObjectUtils.disposeObject(_magicDefenceTip2);
         _magicDefenceTip2 = null;
         ObjectUtils.disposeObject(_critTip2);
         _critTip2 = null;
         ObjectUtils.disposeObject(_hpTip2);
         _hpTip2 = null;
         ObjectUtils.disposeObject(_countTip2);
         _countTip2 = null;
         ObjectUtils.disposeObject(_penetrateTip2);
         _penetrateTip2 = null;
         ObjectUtils.disposeObject(_strengthTxt);
         _strengthTxt = null;
         ObjectUtils.disposeObject(_agilityTxt);
         _agilityTxt = null;
         ObjectUtils.disposeObject(_abilityTxt);
         _abilityTxt = null;
         ObjectUtils.disposeObject(_physiqueTxt);
         _physiqueTxt = null;
         ObjectUtils.disposeObject(_captainTxt);
         _captainTxt = null;
         ObjectUtils.disposeObject(_baseAttributeTip1);
         _baseAttributeTip1 = null;
         ObjectUtils.disposeObject(_baseAttributeTip1);
         _baseAttributeTip1 = null;
         ObjectUtils.disposeObject(_baseAttributeTip2);
         _baseAttributeTip2 = null;
         ObjectUtils.disposeObject(_baseAttributeTip3);
         _baseAttributeTip3 = null;
         ObjectUtils.disposeObject(_baseAttributeTip4);
         _baseAttributeTip4 = null;
         ObjectUtils.disposeObject(_baseAttributeTip5);
         _baseAttributeTip5 = null;
         ObjectUtils.disposeObject(_baseAttributeTip6);
         _baseAttributeTip6 = null;
         ObjectUtils.disposeObject(_baseAttributeTip7);
         _baseAttributeTip7 = null;
         ObjectUtils.disposeObject(_normalBtn);
         _normalBtn = null;
         ObjectUtils.disposeObject(_guardBtn);
         _guardBtn = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         ObjectUtils.disposeObject(_vbox01);
         _vbox01 = null;
         ObjectUtils.disposeObject(_vbox02);
         _vbox02 = null;
         ObjectUtils.disposeObject(_vbox03);
         _vbox03 = null;
         ObjectUtils.disposeObject(_mutiBg02);
         _mutiBg02 = null;
         ObjectUtils.disposeObject(_mutiBg03);
         _mutiBg03 = null;
         ObjectUtils.disposeObject(_playerAttribute);
         _playerAttribute = null;
         ObjectUtils.disposeObject(_gappellTxt);
         _gappellTxt = null;
         ObjectUtils.disposeObject(_txtVbox01);
         _txtVbox01 = null;
         ObjectUtils.disposeObject(_txtVbox02);
         _txtVbox02 = null;
         ObjectUtils.disposeObject(_txtVbox03);
         _txtVbox03 = null;
         ObjectUtils.disposeAllChildren(_battleWillTipRight);
         _battleWillTipRight = null;
         ObjectUtils.disposeAllChildren(_fireTipRight);
         _fireTipRight = null;
         ObjectUtils.disposeAllChildren(_waterTipRight);
         _waterTipRight = null;
         ObjectUtils.disposeAllChildren(_windTipRight);
         _windTipRight = null;
         ObjectUtils.disposeAllChildren(_eleTipRight);
         _eleTipRight = null;
         ObjectUtils.disposeAllChildren(_lightTipRight);
         _lightTipRight = null;
         ObjectUtils.disposeAllChildren(_darkTipRight);
         _darkTipRight = null;
         ObjectUtils.disposeObject(_battleWillTxt);
         _battleWillTxt = null;
         ObjectUtils.disposeObject(_fireTxt);
         _fireTxt = null;
         ObjectUtils.disposeObject(_waterTxt);
         _waterTxt = null;
         ObjectUtils.disposeObject(_windTxt);
         _windTxt = null;
         ObjectUtils.disposeObject(_eleTxt);
         _eleTxt = null;
         ObjectUtils.disposeObject(_lightTxt);
         _lightTxt = null;
         ObjectUtils.disposeObject(_darkTxt);
         _darkTxt = null;
         ObjectUtils.disposeObject(_intensityTxt);
         _intensityTxt = null;
         ObjectUtils.disposeObject(_tenacityTxt);
         _tenacityTxt = null;
         ObjectUtils.disposeObject(_dingliTip1);
         _dingliTip1 = null;
         ObjectUtils.disposeObject(_dingliTip2);
         _dingliTip2 = null;
         ObjectUtils.disposeObject(_resistStrikeTxt);
         _resistStrikeTxt = null;
         ObjectUtils.disposeObject(_resResistTxt);
         _resResistTxt = null;
         ObjectUtils.disposeObject(_resistStrikeTipRight);
         _resistStrikeTipRight = null;
         ObjectUtils.disposeObject(_resResistTipRight);
         _resResistTipRight = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

