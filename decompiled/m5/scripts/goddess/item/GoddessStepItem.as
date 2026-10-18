package goddess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.goddess.GoddessEquipInfo;
   import yishi.datas.templates.GoddessEquipTempInfo;
   
   public class GoddessStepItem extends Component
   {
      
      public var _bag1:Bitmap;
      
      public var _eqCurrStepTitle:FilterFrameText;
      
      public var _eqNextStepTitle:FilterFrameText;
      
      public var _eqStepCurrPro:FilterFrameText;
      
      public var _eqStepNextPro:FilterFrameText;
      
      public var _stepBack:Bitmap;
      
      public var _eqStepTitle:FilterFrameText;
      
      public var _equipCell:GoddessEquipCell;
      
      private var _equipTemp:GoddessEquipTempInfo;
      
      private var _data:GoddessEquipInfo;
      
      private var _type:int;
      
      public function GoddessStepItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bag1 = ComponentFactory.Instance.creatBitmap("asset.goddess.eq.property.bag1");
         _eqCurrStepTitle = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqCurrStepTitle");
         _eqNextStepTitle = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqNextStepTitle");
         _eqStepCurrPro = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStepCurrPro");
         _eqStepNextPro = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStepNextPro");
         _stepBack = ComponentFactory.Instance.creatBitmap("asset.goddess.eq.stepBack");
         _eqStepTitle = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStepTitle");
         _equipCell = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.stepCell");
         addChild(_bag1);
         addChild(_equipCell);
         addChild(_eqCurrStepTitle);
         addChild(_eqNextStepTitle);
         addChild(_eqStepCurrPro);
         addChild(_eqStepNextPro);
         addChild(_stepBack);
         addChild(_eqStepTitle);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bag1);
         _bag1 = null;
         ObjectUtils.disposeObject(_eqCurrStepTitle);
         _eqCurrStepTitle = null;
         ObjectUtils.disposeObject(_eqNextStepTitle);
         _eqNextStepTitle = null;
         ObjectUtils.disposeObject(_eqStepCurrPro);
         _eqStepCurrPro = null;
         ObjectUtils.disposeObject(_eqStepNextPro);
         _eqStepNextPro = null;
         ObjectUtils.disposeObject(_stepBack);
         _stepBack = null;
         ObjectUtils.disposeObject(_eqStepTitle);
         _eqStepTitle = null;
         ObjectUtils.disposeObject(_equipCell);
         _equipCell = null;
         super.dispose();
         _equipTemp = null;
      }
      
      public function get equipTemp() : GoddessEquipTempInfo
      {
         return _equipTemp;
      }
      
      public function set equipTemp(param1:GoddessEquipTempInfo) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         _equipTemp = param1;
         if(_equipTemp)
         {
            _loc3_ = _type == 1 ? LanguageMgr.GetTranslation("goddess.equip.currBefore") : LanguageMgr.GetTranslation("goddess.equip.nextBefore");
            _loc4_ = _equipTemp.getKeyValues();
            _loc2_ = int(_loc4_.length == 0 ? 0 : _loc4_[0][0]);
            _eqStepTitle.text = LanguageMgr.GetTranslation("goddess.equip.stepT1",_equipTemp.Grade);
            _eqCurrStepTitle.text = LanguageMgr.GetTranslation("goddess.equip.currTitle",_loc3_);
            _eqNextStepTitle.text = LanguageMgr.GetTranslation("goddess.equip.nextTitle",_loc3_);
            _eqStepCurrPro.text = "" + _loc2_ + "%";
            _eqStepNextPro.text = "" + equipTemp.StrengthenLevelMax;
         }
      }
      
      public function set stepProfile(param1:int) : void
      {
         _eqStepTitle.setFrame(param1);
         _eqStepCurrPro.setFrame(param1);
         _eqStepNextPro.setFrame(param1);
      }
      
      public function get data() : GoddessEquipInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessEquipInfo) : void
      {
         _data = param1;
         _equipCell.data = _data;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         _equipCell.nextAdd = _type == 1 ? 0 : 1;
      }
   }
}

