package fundVein
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FundVeinManager;
   import mvc.module.fundVein.GradeRewardInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   
   public class FundVeinItemCell extends Component
   {
      
      private var _timeTxtBg:Bitmap;
      
      private var _getTime:FilterFrameText;
      
      private var _valueImg:Bitmap;
      
      private var _rewardBg:Bitmap;
      
      private var _spliteLine:Bitmap;
      
      private var _getBtn:BaseButton;
      
      private var _diamondIcon:ScaleFrameImage;
      
      private var _shape:Shape;
      
      private var _dimondCells:Vector.<FundVeinDiamondCell>;
      
      private var _levelIndex:int;
      
      private var _cellIndex:int;
      
      private var _grayBp:Bitmap;
      
      public function FundVeinItemCell(param1:int)
      {
         super();
         this._levelIndex = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _shape = new Shape();
         var _loc1_:Graphics = _shape.graphics;
         _loc1_.beginFill(4095);
         _loc1_.drawRect(0,0,10,8);
         _loc1_.endFill();
         _shape.visible = false;
         addChild(_shape);
         _timeTxtBg = creatBitmap("asset.fund.acceptDatePic");
         addChild(_timeTxtBg);
         _valueImg = creatBitmap("asset.fund.rewardPic");
         addChild(_valueImg);
         _getTime = creatComponentByStylename("fund.totalgetTxt_2");
         addChild(_getTime);
         _rewardBg = creatBitmap("asset.fund.acceptedPic");
         addChild(_rewardBg);
         _spliteLine = creatBitmap("asset.fund.cutLine");
         addChild(_spliteLine);
         _getBtn = creatComponentByStylename("fundVeinGiftItem.getBtn");
         addChild(_getBtn);
         _diamondIcon = creatComponentByStylename("fund.diamondIcon");
         addChild(_diamondIcon);
         _dimondCells = new Vector.<FundVeinDiamondCell>();
      }
      
      private function creatBitmap(param1:String) : Bitmap
      {
         return ComponentFactory.Instance.creatBitmap(param1);
      }
      
      private function creatComponentByStylename(param1:String) : *
      {
         return ComponentFactory.Instance.creatComponentByStylename(param1);
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",onBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",onBtnClickHandler);
      }
      
      protected function onBtnClickHandler(param1:MouseEvent) : void
      {
         if(_grayBp && _grayBp.parent)
         {
            return;
         }
         FundVeinManager.instance.fundOperate(2,this._levelIndex,this._cellIndex);
      }
      
      private function __getBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
      }
      
      public function udpateView(param1:GradeRewardInfo, param2:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc4_:FundVeinDiamondCell = null;
         var _loc5_:int = 0;
         var _loc7_:BitmapData = null;
         _getTime.text = LanguageMgr.GetTranslation("fund.FundRewardView.getTime.NewbieText",param1.needGrade);
         _getBtn.visible = !param1.isTaked;
         _rewardBg.visible = param1.isTaked;
         _getBtn.enable = param2;
         _getBtn.alpha = 1;
         this._cellIndex = param1.index;
         _diamondIcon.setFrame(this._cellIndex);
         var _loc3_:int = int(_dimondCells.length);
         _loc6_ = 0;
         while(_loc6_ < _dimondCells.length)
         {
            if(_dimondCells[_loc6_].parent)
            {
               _dimondCells[_loc6_].parent.removeChild(_dimondCells[_loc6_]);
            }
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.itemInfo.length)
         {
            if(_dimondCells.length > _loc5_)
            {
               _loc4_ = _dimondCells[_loc5_];
            }
            else
            {
               _loc4_ = this.getDiamondCell();
            }
            addChild(_loc4_);
            _dimondCells[_loc5_].updateView(param1.itemInfo[_loc5_]);
            _loc5_++;
         }
         if(_grayBp && _grayBp.parent)
         {
            _grayBp.parent.removeChild(_grayBp);
         }
         if(ArmyManager.instance.thane.grades < param1.needGrade)
         {
            if(!_grayBp)
            {
               _loc7_ = new BitmapData(_getBtn.width,_getBtn.height,true,0);
               _loc7_.draw(_getBtn);
               _grayBp = new Bitmap(_loc7_);
            }
            _grayBp.x = _getBtn.x;
            _grayBp.y = _getBtn.y;
            _getBtn.alpha = 0;
            _grayBp.filters = [UIFilter.getGrayFilter()];
            this.addChild(_grayBp);
            _getBtn.tipData = "<font color=\'#fff6ca\'>" + LanguageMgr.GetTranslation("fund.fundRewardView.NewbieTip") + "</font>";
         }
      }
      
      private function getDiamondCell() : FundVeinDiamondCell
      {
         var _loc1_:FundVeinDiamondCell = new FundVeinDiamondCell(186,false,1);
         _loc1_.y = _dimondCells.length * 22 + 38;
         _dimondCells[_dimondCells.length] = _loc1_;
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_timeTxtBg);
         _timeTxtBg = null;
         ObjectUtils.disposeObject(_getTime);
         _getTime = null;
         ObjectUtils.disposeObject(_valueImg);
         _valueImg = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_spliteLine);
         _spliteLine = null;
         ObjectUtils.disposeAllGrandson(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeAllGrandson(_diamondIcon);
         _diamondIcon = null;
         ObjectUtils.disposeObject(_shape);
         _shape = null;
         ObjectUtils.disposeObject(_grayBp);
         _grayBp = null;
         super.dispose();
         ObjectUtils.disposeSelf(this);
      }
   }
}

