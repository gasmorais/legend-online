package dragontitan.charge
{
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontitan.BasePanelComponent;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanChargeCellInfo;
   import yishi.view.base.ProgressCommon;
   
   public class DragonTitanChargeCell extends BasePanelComponent implements ISelectable
   {
      
      private var _bg:Bitmap;
      
      private var _progress:ProgressCommon;
      
      private var _selectBtn:SelectedIconButton;
      
      private var _txt:FilterFrameText;
      
      private var _nowSelected:Boolean = false;
      
      private var _info:DragonTitanChargeCellInfo;
      
      private var _valueTxt:FilterFrameText;
      
      public function DragonTitanChargeCell(param1:DragonTitanChargeCellInfo)
      {
         this._info = param1;
         super();
      }
      
      public function get info() : DragonTitanChargeCellInfo
      {
         return _info;
      }
      
      override protected function initView() : void
      {
         _bg = addCreatBitmap("asset.dragontitan.chargeCellBg");
         _valueTxt = addCreatComponentByStylename("DragonTitan.AdditionText");
         _selectBtn = addCreatComponentByStylename("DragonTitan.chargeCellSelectBtn");
         _selectBtn.y = _bg.height - _selectBtn.height >> 1;
         _progress = addCreatComponentByStylename("dragontitan.chargeBar");
         _selectBtn.y = _bg.height - _progress.height >> 1;
         _txt = addCreatComponentByStylename("DragonTitan.chargeCellAttText");
         _txt.text = _info.attName + ":";
         _txt.y = _bg.height - _txt.height >> 1;
      }
      
      public function update() : void
      {
         var _loc2_:String = _info.attName + ":";
         _txt.htmlText = _info.isRedTxt ? "<font color=\'#ff0b2d\'>" + _loc2_ + "</font>" : _loc2_;
         var _loc1_:String = "+" + info.attValue.toString();
         _valueTxt.htmlText = _info.isRedTxt ? "<font color=\'#ff0b2d\'>" + _loc1_ + "</font>" : _loc1_;
         _progress.value = _info.progressValue;
         _progress.text = _info.progressTxt;
         setTipData();
      }
      
      private function setTipData() : void
      {
         var _loc1_:Object = {"tipType":"titan_reduce_tip_type"};
         _loc1_.nameValue = info.attName;
         _loc1_.attValue = info.attValue;
         _loc1_.grade = info.attName + LanguageMgr.GetTranslation("DragonTitanChargeCell.tipsLevel") + _info.grade;
         _loc1_.upperLimit = LanguageMgr.GetTranslation("DragonTitanChargeCell.tipsLimitLevel") + DragonTitanManager.instance.model.chargeGrade;
         this.tipData = _loc1_;
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
         _selectBtn.autoSelect = param1;
      }
      
      public function get selected() : Boolean
      {
         return _selectBtn.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selectBtn.selected = param1;
      }
      
      override public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_progress)
         {
            ObjectUtils.disposeObject(_progress);
         }
         _progress = null;
         if(_selectBtn)
         {
            ObjectUtils.disposeObject(_selectBtn);
         }
         _selectBtn = null;
         if(_txt)
         {
            ObjectUtils.disposeObject(_txt);
         }
         _txt = null;
         if(_valueTxt)
         {
            ObjectUtils.disposeObject(_valueTxt);
         }
         _valueTxt = null;
         _info = null;
         super.dispose();
      }
   }
}

