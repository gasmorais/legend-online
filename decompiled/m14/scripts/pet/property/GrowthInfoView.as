package pet.property
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   
   public class GrowthInfoView extends Component
   {
      
      private var _growImg:Image;
      
      private var _strengthCoeImg:Image;
      
      private var _armorCoeImg:Image;
      
      private var _intellectCoeImg:Image;
      
      private var _staminaCoeImg:Image;
      
      private var _strengthImg:Image;
      
      private var _staminaImg:Image;
      
      private var _intellectImg:Image;
      
      private var _armorImg:Image;
      
      private var _growthTxt:FilterFrameText;
      
      private var _strengthMc:MovieClip;
      
      private var _armorMc:MovieClip;
      
      private var _intellectMc:MovieClip;
      
      private var _staminaMc:MovieClip;
      
      private var _strengthCoeTxt:FilterFrameText;
      
      private var _armorCoeTxt:FilterFrameText;
      
      private var _intellectCoeTxt:FilterFrameText;
      
      private var _staminaCoeTxt:FilterFrameText;
      
      private var _strengthTxt:FilterFrameText;
      
      private var _staminaTxt:FilterFrameText;
      
      private var _intellectTxt:FilterFrameText;
      
      private var _armorTxt:FilterFrameText;
      
      private var _growthStrip:StripView;
      
      private var _strengthCoeStrip:StripView;
      
      private var _armorCoeStrip:StripView;
      
      private var _intellectCoeStrip:StripView;
      
      private var _staminaCoeStrip:StripView;
      
      private var _strengthStrip:StripView;
      
      private var _staminaStrip:StripView;
      
      private var _intellectStrip:StripView;
      
      private var _armorStrip:StripView;
      
      private var _lineA:ScaleBitmapImage;
      
      private var _lineB:ScaleBitmapImage;
      
      private var _lineC:ScaleBitmapImage;
      
      private var _lineD:ScaleBitmapImage;
      
      private var _lineE:ScaleBitmapImage;
      
      private var _delayId:uint;
      
      private var _speed:int;
      
      private var _data:PetData;
      
      private var _remainPoint:int = 0;
      
      private var _allocation:Array = [0,0,0,0];
      
      public function GrowthInfoView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _growImg = ComponentFactory.Instance.creatComponentByStylename("pet.GrowthImg");
         _strengthCoeImg = ComponentFactory.Instance.creatComponentByStylename("pet.StrengthCoeImg");
         _armorCoeImg = ComponentFactory.Instance.creatComponentByStylename("pet.ArmorCoeImg");
         _intellectCoeImg = ComponentFactory.Instance.creatComponentByStylename("pet.IntellectCoeImg");
         _staminaCoeImg = ComponentFactory.Instance.creatComponentByStylename("pet.StaminaCoeImg");
         _strengthImg = ComponentFactory.Instance.creatComponentByStylename("pet.StrengthImg");
         _staminaImg = ComponentFactory.Instance.creatComponentByStylename("pet.StaminaImg");
         _intellectImg = ComponentFactory.Instance.creatComponentByStylename("pet.IntellectImg");
         _armorImg = ComponentFactory.Instance.creatComponentByStylename("pet.ArmorImg");
         _strengthMc = ComponentFactory.Instance.creatCustomObject("pet.StrengthMc");
         _armorMc = ComponentFactory.Instance.creatCustomObject("pet.ArmorMc");
         _intellectMc = ComponentFactory.Instance.creatCustomObject("pet.IntellectMc");
         _staminaMc = ComponentFactory.Instance.creatCustomObject("pet.StaminaMc");
         addChild(_growImg);
         addChild(_strengthCoeImg);
         addChild(_armorCoeImg);
         addChild(_intellectCoeImg);
         addChild(_staminaCoeImg);
         addChild(_strengthImg);
         addChild(_staminaImg);
         addChild(_intellectImg);
         addChild(_armorImg);
         addChild(_strengthMc);
         addChild(_armorMc);
         addChild(_intellectMc);
         addChild(_staminaMc);
         _lineA = ComponentFactory.Instance.creatComponentByStylename("pet.HLineA");
         _lineB = ComponentFactory.Instance.creatComponentByStylename("pet.HLineB");
         _lineC = ComponentFactory.Instance.creatComponentByStylename("pet.HLineC");
         _lineD = ComponentFactory.Instance.creatComponentByStylename("pet.HLineD");
         _lineE = ComponentFactory.Instance.creatComponentByStylename("pet.HLineE");
         addChild(_lineA);
         addChild(_lineB);
         addChild(_lineC);
         addChild(_lineD);
         addChild(_lineE);
         _growthTxt = ComponentFactory.Instance.creatComponentByStylename("pet.GrowthTxt");
         _strengthCoeTxt = ComponentFactory.Instance.creatComponentByStylename("pet.StrengthCoeTxt");
         _armorCoeTxt = ComponentFactory.Instance.creatComponentByStylename("pet.ArmorCoeTxt");
         _intellectCoeTxt = ComponentFactory.Instance.creatComponentByStylename("pet.IntellectCoeTxt");
         _staminaCoeTxt = ComponentFactory.Instance.creatComponentByStylename("pet.StaminaCoeTxt");
         _strengthTxt = ComponentFactory.Instance.creatComponentByStylename("pet.StrengthTxt");
         _staminaTxt = ComponentFactory.Instance.creatComponentByStylename("pet.StaminaTxt");
         _intellectTxt = ComponentFactory.Instance.creatComponentByStylename("pet.IntellectTxt");
         _armorTxt = ComponentFactory.Instance.creatComponentByStylename("pet.ArmorTxt");
         _growthStrip = ComponentFactory.Instance.creatCustomObject("pet.GrowthTxtStrip");
         _strengthCoeStrip = ComponentFactory.Instance.creatCustomObject("pet.StrengthCoeTxtStrip");
         _armorCoeStrip = ComponentFactory.Instance.creatCustomObject("pet.ArmorCoeTxtStrip");
         _intellectCoeStrip = ComponentFactory.Instance.creatCustomObject("pet.IntellectCoeTxtStrip");
         _staminaCoeStrip = ComponentFactory.Instance.creatCustomObject("pet.StaminaCoeTxtStrip");
         _strengthStrip = ComponentFactory.Instance.creatCustomObject("pet.StrengthTxtStrip");
         _staminaStrip = ComponentFactory.Instance.creatCustomObject("pet.StaminaTxtStrip");
         _intellectStrip = ComponentFactory.Instance.creatCustomObject("pet.IntellectTxtStrip");
         _armorStrip = ComponentFactory.Instance.creatCustomObject("pet.ArmorTxtStrip");
         _growthStrip.addChild(_growthTxt);
         _strengthCoeStrip.addChild(_strengthCoeTxt);
         _armorCoeStrip.addChild(_armorCoeTxt);
         _intellectCoeStrip.addChild(_intellectCoeTxt);
         _staminaCoeStrip.addChild(_staminaCoeTxt);
         _strengthStrip.addChild(_strengthTxt);
         _staminaStrip.addChild(_staminaTxt);
         _intellectStrip.addChild(_intellectTxt);
         _armorStrip.addChild(_armorTxt);
         addChild(_growthStrip);
         addChild(_strengthCoeStrip);
         addChild(_armorCoeStrip);
         addChild(_intellectCoeStrip);
         addChild(_staminaCoeStrip);
         addChild(_strengthStrip);
         addChild(_staminaStrip);
         addChild(_intellectStrip);
         addChild(_armorStrip);
         _strengthMc.gotoAndStop(1);
         _intellectMc.gotoAndStop(1);
         _staminaMc.gotoAndStop(1);
         _armorMc.gotoAndStop(1);
         fillStripView(_growthStrip);
         fillStripView(_strengthCoeStrip);
         fillStripView(_armorCoeStrip);
         fillStripView(_intellectCoeStrip);
         fillStripView(_staminaCoeStrip);
         fillStripView(_strengthStrip,-102,175);
         fillStripView(_staminaStrip,-102,175);
         fillStripView(_intellectStrip,-102,175);
         fillStripView(_armorStrip,-102,175);
         _growthStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.TipTxt01");
         _strengthCoeStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.TipTxt02");
         _armorCoeStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.TipTxt03");
         _intellectCoeStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.TipTxt04");
         _staminaCoeStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.TipTxt05");
         _strengthStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.TipTxt06");
         _staminaStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.TipTxt09");
         _intellectStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.TipTxt08");
         _armorStrip.tipData = LanguageMgr.GetTranslation("pet.property.GrowthInfoView.TipTxt07");
      }
      
      private function fillStripView(param1:StripView, param2:int = -85, param3:int = 250) : void
      {
         param1.graphics.beginFill(0,0);
         param1.graphics.drawRect(param2,0,param3,22);
         param1.graphics.endFill();
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_growImg);
         _growImg = null;
         ObjectUtils.disposeObject(_strengthCoeImg);
         _strengthCoeImg = null;
         ObjectUtils.disposeObject(_armorCoeImg);
         _armorCoeImg = null;
         ObjectUtils.disposeObject(_intellectCoeImg);
         _intellectCoeImg = null;
         ObjectUtils.disposeObject(_staminaCoeImg);
         _staminaCoeImg = null;
         ObjectUtils.disposeObject(_strengthImg);
         _strengthImg = null;
         ObjectUtils.disposeObject(_staminaImg);
         _staminaImg = null;
         ObjectUtils.disposeObject(_intellectImg);
         _intellectImg = null;
         ObjectUtils.disposeObject(_armorImg);
         _armorImg = null;
         ObjectUtils.disposeObject(_growthTxt);
         _growthTxt = null;
         ObjectUtils.disposeObject(_strengthMc);
         _strengthMc = null;
         ObjectUtils.disposeObject(_armorMc);
         _armorMc = null;
         ObjectUtils.disposeObject(_intellectMc);
         _intellectMc = null;
         ObjectUtils.disposeObject(_staminaMc);
         _staminaMc = null;
         ObjectUtils.disposeObject(_strengthCoeTxt);
         _strengthCoeTxt = null;
         ObjectUtils.disposeObject(_armorCoeTxt);
         _armorCoeTxt = null;
         ObjectUtils.disposeObject(_intellectCoeTxt);
         _intellectCoeTxt = null;
         ObjectUtils.disposeObject(_staminaCoeTxt);
         _staminaCoeTxt = null;
         ObjectUtils.disposeObject(_strengthTxt);
         _strengthTxt = null;
         ObjectUtils.disposeObject(_staminaTxt);
         _staminaTxt = null;
         ObjectUtils.disposeObject(_intellectTxt);
         _intellectTxt = null;
         ObjectUtils.disposeObject(_armorTxt);
         _armorTxt = null;
         ObjectUtils.disposeObject(_growthStrip);
         _growthStrip = null;
         ObjectUtils.disposeObject(_strengthCoeStrip);
         _strengthCoeStrip = null;
         ObjectUtils.disposeObject(_armorCoeStrip);
         _armorCoeStrip = null;
         ObjectUtils.disposeObject(_intellectCoeStrip);
         _intellectCoeStrip = null;
         ObjectUtils.disposeObject(_staminaCoeStrip);
         _staminaCoeStrip = null;
         ObjectUtils.disposeObject(_strengthStrip);
         _strengthStrip = null;
         ObjectUtils.disposeObject(_staminaStrip);
         _staminaStrip = null;
         ObjectUtils.disposeObject(_intellectStrip);
         _intellectStrip = null;
         ObjectUtils.disposeObject(_armorStrip);
         _armorStrip = null;
         ObjectUtils.disposeObject(_lineA);
         _lineA = null;
         ObjectUtils.disposeObject(_lineB);
         _lineB = null;
         ObjectUtils.disposeObject(_lineC);
         _lineC = null;
         ObjectUtils.disposeObject(_lineD);
         _lineD = null;
         ObjectUtils.disposeObject(_lineE);
         _lineE = null;
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
         _remainPoint = 0;
         _allocation = [0,0,0,0];
         if(_data)
         {
            _remainPoint = _data.remainPoint;
            refresh();
         }
         else
         {
            restore();
         }
      }
      
      private function refresh() : void
      {
         _growthTxt.text = _data.growthRate.toString();
         _growthTxt.setFrame(data.quality);
         var _loc1_:int = 1;
         _loc1_ = Math.floor(_data.coeStrength * 100 / _data.coeStrengthLimit);
         _strengthMc.gotoAndStop(_loc1_);
         _loc1_ = Math.floor(_data.coeIntellect * 100 / _data.coeIntellectLimit);
         _intellectMc.gotoAndStop(_loc1_);
         _loc1_ = Math.floor(_data.coeStamina * 100 / _data.coeStaminaLimit);
         _staminaMc.gotoAndStop(_loc1_);
         _loc1_ = Math.floor(_data.coeArmor * 100 / _data.coeArmorLimit);
         _armorMc.gotoAndStop(_loc1_);
         _strengthCoeTxt.text = _data.coeStrength + " / " + _data.coeStrengthLimit;
         _armorCoeTxt.text = _data.coeArmor + " / " + _data.coeArmorLimit;
         _intellectCoeTxt.text = _data.coeIntellect + " / " + _data.coeIntellectLimit;
         _staminaCoeTxt.text = _data.coeStamina + " / " + _data.coeStaminaLimit;
         if(_allocation[0] > 0)
         {
            _strengthTxt.setFrame(2);
         }
         else
         {
            _strengthTxt.setFrame(1);
         }
         if(_allocation[2] > 0)
         {
            _staminaTxt.setFrame(2);
         }
         else
         {
            _staminaTxt.setFrame(1);
         }
         if(_allocation[1] > 0)
         {
            _intellectTxt.setFrame(2);
         }
         else
         {
            _intellectTxt.setFrame(1);
         }
         if(_allocation[3] > 0)
         {
            _armorTxt.setFrame(2);
         }
         else
         {
            _armorTxt.setFrame(1);
         }
         _strengthTxt.text = (_data.strength + _allocation[0]).toString();
         _staminaTxt.text = (_data.stamina + _allocation[2]).toString();
         _intellectTxt.text = (_data.intellect + _allocation[1]).toString();
         _armorTxt.text = (_data.armor + _allocation[3]).toString();
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
         _growthTxt.text = "";
         _strengthMc.gotoAndStop(1);
         _intellectMc.gotoAndStop(1);
         _staminaMc.gotoAndStop(1);
         _armorMc.gotoAndStop(1);
         _strengthCoeTxt.text = "";
         _armorCoeTxt.text = "";
         _intellectCoeTxt.text = "";
         _staminaCoeTxt.text = "";
         _strengthTxt.text = "";
         _staminaTxt.text = "";
         _intellectTxt.text = "";
         _armorTxt.text = "";
         _growthStrip.tipData = "";
         _strengthCoeStrip.tipData = "";
         _armorCoeStrip.tipData = "";
         _intellectCoeStrip.tipData = "";
         _staminaCoeStrip.tipData = "";
         _strengthStrip.tipData = "";
         _staminaStrip.tipData = "";
         _intellectStrip.tipData = "";
         _armorStrip.tipData = "";
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

