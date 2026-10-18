package pet.property
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   
   public class DetailInfoView extends Component
   {
      
      private var _line1:ScaleBitmapImage;
      
      private var _line2:ScaleBitmapImage;
      
      private var _line3:ScaleBitmapImage;
      
      private var _line4:ScaleBitmapImage;
      
      private var _line5:ScaleBitmapImage;
      
      private var _line6:ScaleBitmapImage;
      
      private var _line7:ScaleBitmapImage;
      
      private var _line8:ScaleBitmapImage;
      
      private var _physicsAttackImg:Image;
      
      private var _physicsDefenseImg:Image;
      
      private var _magicAttackImg:Image;
      
      private var _magicDefenseImg:Image;
      
      private var _hpImg:Image;
      
      private var _fireResImg:Image;
      
      private var _windResImg:Image;
      
      private var _waterResImg:Image;
      
      private var _electResImg:Image;
      
      private var _darkResImg:Image;
      
      private var _lightResImg:Image;
      
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
      
      private var _physicsAttackStrip:StripView;
      
      private var _physicsDefenseStrip:StripView;
      
      private var _magicAttackStrip:StripView;
      
      private var _magicDefenseStrip:StripView;
      
      private var _hpStrip:StripView;
      
      private var _fireResStrip:StripView;
      
      private var _windResStrip:StripView;
      
      private var _waterResStrip:StripView;
      
      private var _electResStrip:StripView;
      
      private var _darkResStrip:StripView;
      
      private var _lightResStrip:StripView;
      
      private var _data:PetData;
      
      public function DetailInfoView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _line1 = ComponentFactory.Instance.creatComponentByStylename("pet.HLine1");
         _line2 = ComponentFactory.Instance.creatComponentByStylename("pet.HLine2");
         _line3 = ComponentFactory.Instance.creatComponentByStylename("pet.HLine3");
         _line4 = ComponentFactory.Instance.creatComponentByStylename("pet.HLine4");
         _line5 = ComponentFactory.Instance.creatComponentByStylename("pet.HLine5");
         _line6 = ComponentFactory.Instance.creatComponentByStylename("pet.HLine6");
         _line7 = ComponentFactory.Instance.creatComponentByStylename("pet.HLine7");
         _line8 = ComponentFactory.Instance.creatComponentByStylename("pet.HLine8");
         addChild(_line1);
         addChild(_line2);
         addChild(_line3);
         addChild(_line4);
         addChild(_line5);
         addChild(_line6);
         addChild(_line7);
         addChild(_line8);
         _physicsAttackImg = ComponentFactory.Instance.creatComponentByStylename("pet.PhysicsAttackImg");
         _physicsDefenseImg = ComponentFactory.Instance.creatComponentByStylename("pet.PhysicsDefenseImg");
         _magicAttackImg = ComponentFactory.Instance.creatComponentByStylename("pet.MagicAttackImg");
         _magicDefenseImg = ComponentFactory.Instance.creatComponentByStylename("pet.MagicDefenseImg");
         _hpImg = ComponentFactory.Instance.creatComponentByStylename("pet.HpImg");
         _fireResImg = ComponentFactory.Instance.creatComponentByStylename("pet.FireResImg");
         _windResImg = ComponentFactory.Instance.creatComponentByStylename("pet.WindResImg");
         _waterResImg = ComponentFactory.Instance.creatComponentByStylename("pet.WaterResImg");
         _electResImg = ComponentFactory.Instance.creatComponentByStylename("pet.ElectResImg");
         _darkResImg = ComponentFactory.Instance.creatComponentByStylename("pet.DarkResImg");
         _lightResImg = ComponentFactory.Instance.creatComponentByStylename("pet.LightResImg");
         addChild(_physicsAttackImg);
         addChild(_physicsDefenseImg);
         addChild(_magicAttackImg);
         addChild(_magicDefenseImg);
         addChild(_hpImg);
         addChild(_fireResImg);
         addChild(_windResImg);
         addChild(_waterResImg);
         addChild(_electResImg);
         addChild(_darkResImg);
         addChild(_lightResImg);
         _physicsAttackTxt = ComponentFactory.Instance.creatComponentByStylename("pet.PhyAttackText");
         _physicsDefenseTxt = ComponentFactory.Instance.creatComponentByStylename("pet.PhyDenfenseText");
         _magicAttackTxt = ComponentFactory.Instance.creatComponentByStylename("pet.MagicAttackText");
         _magicDefenseTxt = ComponentFactory.Instance.creatComponentByStylename("pet.MagicDenfenseText");
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("pet.HpText");
         _fireResTxt = ComponentFactory.Instance.creatComponentByStylename("pet.FireResText");
         _windResTxt = ComponentFactory.Instance.creatComponentByStylename("pet.WindResText");
         _waterResTxt = ComponentFactory.Instance.creatComponentByStylename("pet.WaterResText");
         _electResTxt = ComponentFactory.Instance.creatComponentByStylename("pet.ElectResText");
         _darkResTxt = ComponentFactory.Instance.creatComponentByStylename("pet.DarkResText");
         _lightResTxt = ComponentFactory.Instance.creatComponentByStylename("pet.LightResText");
         _physicsAttackStrip = ComponentFactory.Instance.creatCustomObject("pet.PhyAttackTextStrip");
         _physicsDefenseStrip = ComponentFactory.Instance.creatCustomObject("pet.PhyDenfenseTextStrip");
         _magicAttackStrip = ComponentFactory.Instance.creatCustomObject("pet.MagicAttackTextStrip");
         _magicDefenseStrip = ComponentFactory.Instance.creatCustomObject("pet.MagicDenfenseTextStrip");
         _hpStrip = ComponentFactory.Instance.creatCustomObject("pet.HpTextStrip");
         _fireResStrip = ComponentFactory.Instance.creatCustomObject("pet.FireResTextStrip");
         _windResStrip = ComponentFactory.Instance.creatCustomObject("pet.WindResTextStrip");
         _waterResStrip = ComponentFactory.Instance.creatCustomObject("pet.WaterResTextStrip");
         _electResStrip = ComponentFactory.Instance.creatCustomObject("pet.ElectResTextStrip");
         _darkResStrip = ComponentFactory.Instance.creatCustomObject("pet.DarkResTextStrip");
         _lightResStrip = ComponentFactory.Instance.creatCustomObject("pet.LightResTextStrip");
         _physicsAttackStrip.addChild(_physicsAttackTxt);
         _physicsDefenseStrip.addChild(_physicsDefenseTxt);
         _magicAttackStrip.addChild(_magicAttackTxt);
         _magicDefenseStrip.addChild(_magicDefenseTxt);
         _hpStrip.addChild(_hpTxt);
         _fireResStrip.addChild(_fireResTxt);
         _windResStrip.addChild(_windResTxt);
         _waterResStrip.addChild(_waterResTxt);
         _electResStrip.addChild(_electResTxt);
         _darkResStrip.addChild(_darkResTxt);
         _lightResStrip.addChild(_lightResTxt);
         addChild(_physicsAttackStrip);
         addChild(_physicsDefenseStrip);
         addChild(_magicAttackStrip);
         addChild(_magicDefenseStrip);
         addChild(_hpStrip);
         addChild(_fireResStrip);
         addChild(_windResStrip);
         addChild(_waterResStrip);
         addChild(_electResStrip);
         addChild(_darkResStrip);
         addChild(_lightResStrip);
         fillStripView(_fireResStrip);
         fillStripView(_windResStrip);
         fillStripView(_waterResStrip);
         fillStripView(_electResStrip);
         fillStripView(_darkResStrip);
         fillStripView(_lightResStrip);
         _fireResStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.fireResStrip");
         _windResStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.windResStrip");
         _waterResStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.waterResStrip");
         _electResStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.electResStrip");
         _darkResStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.darkResStrip");
         _lightResStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.lightResStrip");
      }
      
      private function fillStripView(param1:StripView, param2:int = 0, param3:int = 100) : void
      {
         param1.graphics.beginFill(0,0);
         param1.graphics.drawRect(param2,0,param3,22);
         param1.graphics.endFill();
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_line1);
         _line1 = null;
         ObjectUtils.disposeObject(_line2);
         _line2 = null;
         ObjectUtils.disposeObject(_line3);
         _line3 = null;
         ObjectUtils.disposeObject(_line4);
         _line4 = null;
         ObjectUtils.disposeObject(_line5);
         _line5 = null;
         ObjectUtils.disposeObject(_line6);
         _line6 = null;
         ObjectUtils.disposeObject(_line7);
         _line7 = null;
         ObjectUtils.disposeObject(_line8);
         _line8 = null;
         ObjectUtils.disposeObject(_physicsAttackImg);
         _physicsAttackImg = null;
         ObjectUtils.disposeObject(_physicsDefenseImg);
         _physicsDefenseImg = null;
         ObjectUtils.disposeObject(_magicAttackImg);
         _magicAttackImg = null;
         ObjectUtils.disposeObject(_magicDefenseImg);
         _magicDefenseImg = null;
         ObjectUtils.disposeObject(_hpImg);
         _hpImg = null;
         ObjectUtils.disposeObject(_fireResImg);
         _fireResImg = null;
         ObjectUtils.disposeObject(_windResImg);
         _windResImg = null;
         ObjectUtils.disposeObject(_waterResImg);
         _waterResImg = null;
         ObjectUtils.disposeObject(_electResImg);
         _electResImg = null;
         ObjectUtils.disposeObject(_darkResImg);
         _darkResImg = null;
         ObjectUtils.disposeObject(_lightResImg);
         _lightResImg = null;
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
         ObjectUtils.disposeObject(_physicsAttackStrip);
         _physicsAttackStrip = null;
         ObjectUtils.disposeObject(_physicsDefenseStrip);
         _physicsDefenseStrip = null;
         ObjectUtils.disposeObject(_magicAttackStrip);
         _magicAttackStrip = null;
         ObjectUtils.disposeObject(_magicDefenseStrip);
         _magicDefenseStrip = null;
         ObjectUtils.disposeObject(_hpStrip);
         _hpStrip = null;
         ObjectUtils.disposeObject(_fireResStrip);
         _fireResStrip = null;
         ObjectUtils.disposeObject(_windResStrip);
         _windResStrip = null;
         ObjectUtils.disposeObject(_waterResStrip);
         _waterResStrip = null;
         ObjectUtils.disposeObject(_electResStrip);
         _electResStrip = null;
         ObjectUtils.disposeObject(_darkResStrip);
         _darkResStrip = null;
         ObjectUtils.disposeObject(_lightResStrip);
         _lightResStrip = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         if(_data)
         {
            refresh();
         }
         else
         {
            restore();
         }
      }
      
      private function refresh() : void
      {
         _physicsAttackTxt.text = data.Attack.toString();
         _physicsDefenseTxt.text = data.Defence.toString();
         _magicAttackTxt.text = data.MagicAttack.toString();
         _magicDefenseTxt.text = data.MagicDefence.toString();
         _hpTxt.text = data.Live.toString();
         _fireResTxt.text = data.resFire.toString();
         _windResTxt.text = data.resWind.toString();
         _waterResTxt.text = data.resWater.toString();
         _electResTxt.text = data.resElect.toString();
         _darkResTxt.text = data.resDark.toString();
         _lightResTxt.text = data.resLight.toString();
         _physicsAttackStrip.tipData = createTipString(LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06"),data.physicalAttackBase,data.physicalAttackAdd);
         _physicsDefenseStrip.tipData = createTipString(LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip07"),data.physicalDefenseBase,data.physicalDefenseAdd);
         _magicAttackStrip.tipData = createTipString(LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08"),data.magicAttackBase,data.magicAttackAdd);
         _magicDefenseStrip.tipData = createTipString(LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip09"),data.magicDefenseBase,data.magicDefenseAdd);
         _hpStrip.tipData = createTipString(LanguageMgr.GetTranslation("pet.hp"),data.hpBase,data.hpAdd);
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
         if(data.physicalAttackAdd > 0)
         {
            _physicsAttackTxt.setFrame(2);
         }
         if(data.physicalDefenseAdd > 0)
         {
            _physicsDefenseTxt.setFrame(2);
         }
         if(data.magicAttackAdd > 0)
         {
            _magicAttackTxt.setFrame(2);
         }
         if(data.magicDefenseAdd > 0)
         {
            _magicDefenseTxt.setFrame(2);
         }
         if(data.hpAdd > 0)
         {
            _hpTxt.setFrame(2);
         }
         if(data.resFireAdd > 0)
         {
            _fireResTxt.setFrame(2);
         }
         if(data.resWindAdd > 0)
         {
            _windResTxt.setFrame(2);
         }
         if(data.resWaterAdd > 0)
         {
            _waterResTxt.setFrame(2);
         }
         if(data.resElectAdd > 0)
         {
            _electResTxt.setFrame(2);
         }
         if(data.resDarkAdd > 0)
         {
            _darkResTxt.setFrame(2);
         }
         if(data.resLightAdd > 0)
         {
            _lightResTxt.setFrame(2);
         }
      }
      
      private function createTipString(param1:String, param2:int, param3:int) : String
      {
         var _loc4_:String = param1 + ":" + param2;
         if(param3 != 0)
         {
            _loc4_ += "<font color=\'#59cd41\'>+" + param3 + "</font>";
         }
         return _loc4_;
      }
      
      private function restore() : void
      {
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
         _physicsAttackTxt.text = "";
         _physicsDefenseTxt.text = "";
         _magicAttackTxt.text = "";
         _magicDefenseTxt.text = "";
         _hpTxt.text = "";
         _fireResTxt.text = "";
         _windResTxt.text = "";
         _waterResTxt.text = "";
         _electResTxt.text = "";
         _darkResTxt.text = "";
         _lightResTxt.text = "";
         _physicsAttackStrip.tipData = "";
         _physicsDefenseStrip.tipData = "";
         _magicAttackStrip.tipData = "";
         _magicDefenseStrip.tipData = "";
         _hpStrip.tipData = "";
         _fireResStrip.tipData = "";
         _windResStrip.tipData = "";
         _waterResStrip.tipData = "";
         _electResStrip.tipData = "";
         _darkResStrip.tipData = "";
         _lightResStrip.tipData = "";
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

