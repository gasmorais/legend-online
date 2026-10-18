package pet.advanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class PetAttributeView extends Component
   {
      
      private var _growthRateTxt:FilterFrameText;
      
      private var _strengthCoeTxt:FilterFrameText;
      
      private var _armorCoeTxt:FilterFrameText;
      
      private var _intellectCoeTxt:FilterFrameText;
      
      private var _staminaCoeTxt:FilterFrameText;
      
      private var _growthRateValueTxt:FilterFrameText;
      
      private var _strengthCoeValueTxt:FilterFrameText;
      
      private var _armorCoeValueTxt:FilterFrameText;
      
      private var _intellectCoeValueTxt:FilterFrameText;
      
      private var _staminaCoeValueTxt:FilterFrameText;
      
      private var _cahce:Array;
      
      private var _frame:int = 1;
      
      private var _data:Array;
      
      public function PetAttributeView()
      {
         super();
      }
      
      override protected function init() : void
      {
         _growthRateTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewGrowthTxt");
         _strengthCoeTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewStrengthCoeTxt");
         _armorCoeTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewArmorCoeTxt");
         _intellectCoeTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewIntellectCoeTxt");
         _staminaCoeTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewStaminaCoeTxt");
         _growthRateValueTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewGrowthValueTxt");
         _strengthCoeValueTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewStrengthCoeValueTxt");
         _armorCoeValueTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewArmorCoeValueTxt");
         _intellectCoeValueTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewIntellectCoeValueTxt");
         _staminaCoeValueTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NewStaminaCoeValueTxt");
         addChild(_growthRateTxt);
         addChild(_strengthCoeTxt);
         addChild(_armorCoeTxt);
         addChild(_intellectCoeTxt);
         addChild(_staminaCoeTxt);
         addChild(_growthRateValueTxt);
         addChild(_strengthCoeValueTxt);
         addChild(_armorCoeValueTxt);
         addChild(_intellectCoeValueTxt);
         addChild(_staminaCoeValueTxt);
         _growthRateTxt.text = LanguageMgr.GetTranslation("pet.growth");
         _strengthCoeTxt.text = LanguageMgr.GetTranslation("pet.strengthCoe");
         _armorCoeTxt.text = LanguageMgr.GetTranslation("pet.armorCoe");
         _intellectCoeTxt.text = LanguageMgr.GetTranslation("pet.intellectCoe");
         _staminaCoeTxt.text = LanguageMgr.GetTranslation("pet.staminaCoe");
         _cahce = [_growthRateTxt,_strengthCoeTxt,_armorCoeTxt,_intellectCoeTxt,_staminaCoeTxt,_growthRateValueTxt,_strengthCoeValueTxt,_armorCoeValueTxt,_intellectCoeValueTxt,_staminaCoeValueTxt];
      }
      
      public function get frame() : int
      {
         return _frame;
      }
      
      public function set frame(param1:int) : void
      {
         _frame = param1;
         for each(var _loc2_:FilterFrameText in _cahce)
         {
            _loc2_.setFrame(param1);
         }
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function set data(param1:Array) : void
      {
         _data = param1;
         if(param1)
         {
            _growthRateValueTxt.text = param1[0] + "";
            _strengthCoeValueTxt.htmlText = param1[1] + "";
            _armorCoeValueTxt.htmlText = param1[2] + "";
            _intellectCoeValueTxt.htmlText = param1[3] + "";
            _staminaCoeValueTxt.htmlText = param1[4] + "";
         }
         else
         {
            _growthRateValueTxt.text = "";
            _strengthCoeValueTxt.htmlText = "";
            _armorCoeValueTxt.htmlText = "";
            _intellectCoeValueTxt.htmlText = "";
            _staminaCoeValueTxt.htmlText = "";
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_growthRateTxt);
         _growthRateTxt = null;
         ObjectUtils.disposeObject(_strengthCoeTxt);
         _strengthCoeTxt = null;
         ObjectUtils.disposeObject(_armorCoeTxt);
         _armorCoeTxt = null;
         ObjectUtils.disposeObject(_intellectCoeTxt);
         _intellectCoeTxt = null;
         ObjectUtils.disposeObject(_growthRateValueTxt);
         _growthRateValueTxt = null;
         ObjectUtils.disposeObject(_staminaCoeTxt);
         _staminaCoeTxt = null;
         ObjectUtils.disposeObject(_strengthCoeValueTxt);
         _strengthCoeValueTxt = null;
         ObjectUtils.disposeObject(_armorCoeValueTxt);
         _armorCoeValueTxt = null;
         ObjectUtils.disposeObject(_staminaCoeValueTxt);
         _staminaCoeValueTxt = null;
         ObjectUtils.disposeObject(_intellectCoeValueTxt);
         _intellectCoeValueTxt = null;
         super.dispose();
         _data = null;
      }
   }
}

