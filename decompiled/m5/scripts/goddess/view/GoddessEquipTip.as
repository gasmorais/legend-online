package goddess.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import goddess.item.GoddessEquipCell;
   import manager.LanguageMgr;
   import mvc.module.goddess.GoddessEquipInfo;
   import yishi.datas.templates.GoddessEquipTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.base.NumberBitmap;
   import yishi.view.tips.BaseTip;
   
   public class GoddessEquipTip extends BaseTip
   {
      
      public var _equipCell:GoddessEquipCell;
      
      public var _goddessEquipTipNameTxt:FilterFrameText;
      
      public var _goddessEquipStrengthTxt:FilterFrameText;
      
      public var _goddessEquipTipStrengthName:FilterFrameText;
      
      public var _goddessEquipTipStrengthValue:FilterFrameText;
      
      public var _goddessEquipTipStepValue:FilterFrameText;
      
      public var _goddessEquipTipStrengthMax:FilterFrameText;
      
      private var _baseLine:Bitmap;
      
      private var _blackKingBg:Scale9CornerImage;
      
      private var _redBg:Scale9CornerImage;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _stepNumBit:NumberBitmap;
      
      public function GoddessEquipTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _equipCell = ComponentFactory.Instance.creatCustomObject("ui.goddess.equipTipCell");
         _goddessEquipTipNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.goddessEquipTipNameTxt");
         _goddessEquipStrengthTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.goddessEquipStrengthTxt");
         _goddessEquipTipStrengthName = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.goddessEquipTipStrengthName");
         _goddessEquipTipStrengthValue = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.goddessEquipTipStrengthValue");
         _goddessEquipTipStepValue = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.goddessEquipTipStepValue");
         _goddessEquipTipStrengthMax = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.goddessEquipTipStrengthMax");
         _baseLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _blackKingBg = ComponentFactory.Instance.creatComponentByStylename("core.blackItemTipsBg");
         _redBg = ComponentFactory.Instance.creatComponentByStylename("core.redItemTipsBg");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _stepNumBit = new NumberBitmap();
         _stepNumBit.initParams("asset.tips.addImg","asset.tips.numImg",19,22,15,19,"0123456789",15,12);
         addChild(_blackKingBg);
         addChild(_redBg);
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         addChild(_equipCell);
         addChild(_goddessEquipTipNameTxt);
         addChild(_stepNumBit);
         addChild(_goddessEquipStrengthTxt);
         addChild(_goddessEquipTipStrengthName);
         addChild(_goddessEquipTipStrengthValue);
         addChild(_goddessEquipTipStepValue);
         addChild(_goddessEquipTipStrengthMax);
         addChild(_baseLine);
         _baseLine.x = 35;
         _baseLine.y = 115;
         _stepNumBit.x = 260;
         _stepNumBit.y = 28;
         _bg.width = 340;
         _bg.height = 175;
         _blackKingBg.width = _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = _bg.width;
         _blackKingBg.height = _redBg.height = _yellowBg.height = _purpleBg.height = _blueBg.height = _greenBg.height = _whiteBg.height = _bg.height;
         _blackKingBg.y = _redBg.y = _yellowBg.y = _purpleBg.y = _blueBg.y = _greenBg.y = _whiteBg.y = 0;
      }
      
      private function showProfile(param1:int) : void
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
      
      override protected function updateTransform() : void
      {
         var _loc5_:GoddessEquipTempInfo = null;
         var _loc4_:Array = null;
         var _loc2_:GoddessEquipTempInfo = null;
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:GoddessEquipInfo = tipData as GoddessEquipInfo;
         if(_loc6_)
         {
            _equipCell.data = _loc6_;
            _goddessEquipTipNameTxt.text = GoddessEquipTempInfo.getEquipName(_loc6_.equipType);
            _stepNumBit.num = _loc6_.equipStrengthenLevel;
            _loc5_ = TempleteManager.instance.goddessEquipTempCate.getEquipTempInfo(1,_loc6_.equipType,_loc6_.equipStrengthenLevel);
            _loc4_ = _loc5_.getKeyValues();
            _goddessEquipTipStrengthName.text = "" + _loc4_[0][1];
            _goddessEquipTipStrengthValue.text = "+" + _loc4_[0][0];
            _loc2_ = TempleteManager.instance.goddessEquipTempCate.getEquipTempInfo(2,_loc6_.equipType,_loc6_.equipAdvanceLevel);
            _loc1_ = _loc2_.getKeyValues();
            _loc3_ = int(_loc1_.length == 0 ? 0 : _loc1_[0][0]);
            _loc7_ = int(_loc4_[0][0]) * _loc3_ / 100;
            _goddessEquipTipStepValue.text = "+" + _loc7_;
            _goddessEquipTipStepValue.visible = _loc7_ > 0;
            _goddessEquipTipStrengthMax.text = LanguageMgr.GetTranslation("goddess.equip.tipMax",_loc2_.StrengthenLevelMax);
            showProfile(_loc2_.Grade + 1);
            _goddessEquipTipNameTxt.setFrame(_loc2_.Grade + 1);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_equipCell);
         _equipCell = null;
         ObjectUtils.disposeObject(_goddessEquipTipNameTxt);
         _goddessEquipTipNameTxt = null;
         ObjectUtils.disposeObject(_goddessEquipStrengthTxt);
         _goddessEquipStrengthTxt = null;
         ObjectUtils.disposeObject(_goddessEquipTipStrengthName);
         _goddessEquipTipStrengthName = null;
         ObjectUtils.disposeObject(_goddessEquipTipStrengthValue);
         _goddessEquipTipStrengthValue = null;
         ObjectUtils.disposeObject(_goddessEquipTipStepValue);
         _goddessEquipTipStepValue = null;
         ObjectUtils.disposeObject(_goddessEquipTipStrengthMax);
         _goddessEquipTipStrengthMax = null;
         ObjectUtils.disposeObject(_baseLine);
         _baseLine = null;
         ObjectUtils.disposeObject(_blackKingBg);
         _blackKingBg = null;
         ObjectUtils.disposeObject(_redBg);
         _redBg = null;
         ObjectUtils.disposeObject(_yellowBg);
         _yellowBg = null;
         ObjectUtils.disposeObject(_purpleBg);
         _purpleBg = null;
         ObjectUtils.disposeObject(_blueBg);
         _blueBg = null;
         ObjectUtils.disposeObject(_greenBg);
         _greenBg = null;
         ObjectUtils.disposeObject(_whiteBg);
         _whiteBg = null;
         ObjectUtils.disposeObject(_stepNumBit);
         _stepNumBit = null;
         super.dispose();
      }
   }
}

