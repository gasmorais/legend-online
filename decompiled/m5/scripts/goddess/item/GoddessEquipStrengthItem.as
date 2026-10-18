package goddess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import yishi.datas.templates.GoddessEquipTempInfo;
   
   public class GoddessEquipStrengthItem extends Component
   {
      
      public var _bag2:Bitmap;
      
      public var _eqStrengNameTxt:FilterFrameText;
      
      public var _eqStrengValueTxt:FilterFrameText;
      
      public var _eqStrengT1Txt:FilterFrameText;
      
      public var _eqStrengT2Txt:FilterFrameText;
      
      private var _equipTemp:GoddessEquipTempInfo;
      
      public function GoddessEquipStrengthItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bag2 = ComponentFactory.Instance.creatBitmap("asset.goddess.eq.property.bag2");
         _eqStrengNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStrengNameTxt");
         _eqStrengValueTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStrengValueTxt");
         _eqStrengT1Txt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStrengT1Txt");
         _eqStrengT2Txt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStrengT2Txt");
         addChild(_bag2);
         addChild(_eqStrengNameTxt);
         addChild(_eqStrengValueTxt);
         addChild(_eqStrengT1Txt);
         addChild(_eqStrengT2Txt);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bag2);
         _bag2 = null;
         ObjectUtils.disposeObject(_eqStrengNameTxt);
         _eqStrengNameTxt = null;
         ObjectUtils.disposeObject(_eqStrengValueTxt);
         _eqStrengValueTxt = null;
         ObjectUtils.disposeObject(_eqStrengT1Txt);
         _eqStrengT1Txt = null;
         ObjectUtils.disposeObject(_eqStrengT2Txt);
         _eqStrengT2Txt = null;
         super.dispose();
         _equipTemp = null;
      }
      
      public function get equipTemp() : GoddessEquipTempInfo
      {
         return _equipTemp;
      }
      
      public function set equipTemp(param1:GoddessEquipTempInfo) : void
      {
         var _loc2_:Array = null;
         _equipTemp = param1;
         if(_equipTemp)
         {
            _eqStrengT1Txt.text = GoddessEquipTempInfo.getEquipName(_equipTemp.EquipType);
            _eqStrengT2Txt.text = "+" + _equipTemp.Grade;
            _loc2_ = _equipTemp.getKeyValues();
            _eqStrengNameTxt.text = "" + _loc2_[0][1];
            _eqStrengValueTxt.text = "" + _loc2_[0][0];
         }
      }
      
      public function set nameProfile(param1:int) : void
      {
         _eqStrengT1Txt.setFrame(param1);
      }
   }
}

