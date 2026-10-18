package sevenyear.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SevenYearEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import yishi.datas.ConfigInfoManager;
   
   public class SevenYearBuyItem extends Component
   {
      
      private var _gradeTxt:FilterFrameText;
      
      private var _icon:Bitmap;
      
      private var _priceTxt:FilterFrameText;
      
      private var _numBg:Bitmap;
      
      private var _numTxt:FilterFrameText;
      
      private var _plusBtn:IconButton;
      
      private var _minusBtn:IconButton;
      
      private var _totalGradeTxt:FilterFrameText;
      
      private var _totalIcon:Bitmap;
      
      private var _totalPriceTxt:FilterFrameText;
      
      private var _index:int;
      
      private var _grade:int;
      
      private var _price:int;
      
      public var totalGrade:int;
      
      public var totalPrice:int;
      
      public var buyNum:int = 0;
      
      public function SevenYearBuyItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyItem.gradeTxt");
         _icon = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyItem.priceTxt");
         _numBg = ComponentFactory.Instance.creatBitmap("asset.SevenYearBattleFlagView.numBg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyItem.numTxt");
         _plusBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyItem.plusBtn");
         _minusBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyItem.minusBtn");
         _totalGradeTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyItem.totalGradeTxt");
         _totalIcon = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _totalPriceTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyItem.totalPriceTxt");
         addChild(_gradeTxt);
         addChild(_icon);
         addChild(_priceTxt);
         addChild(_numBg);
         addChild(_numTxt);
         addChild(_plusBtn);
         addChild(_minusBtn);
         addChild(_totalGradeTxt);
         addChild(_totalIcon);
         addChild(_totalPriceTxt);
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc3_:Array = ConfigInfoManager.instance.getSevenYearBuyGrade();
         var _loc1_:String = _loc3_[_index];
         var _loc2_:Array = _loc1_.split(",");
         _grade = _loc2_[0];
         _price = _loc2_[1];
         _icon.x = 90;
         _icon.y = 3;
         _gradeTxt.text = LanguageMgr.GetTranslation("SevenYearBuyItem.grade.text",_grade);
         _priceTxt.text = _price.toString();
         _numTxt.text = buyNum.toString();
         _totalGradeTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
         _totalPriceTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
         _totalIcon.x = 400;
         _totalIcon.y = 5;
         _totalIcon.visible = false;
      }
      
      private function initEvent() : void
      {
         _numTxt.addEventListener("change",__numTxtChangeHandler);
         _plusBtn.addEventListener("click",__plusBtnClickHandler);
         _minusBtn.addEventListener("click",__minusBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_numTxt)
         {
            _numTxt.removeEventListener("change",__numTxtChangeHandler);
         }
         if(_plusBtn)
         {
            _plusBtn.removeEventListener("click",__plusBtnClickHandler);
         }
         if(_minusBtn)
         {
            _minusBtn.removeEventListener("click",__minusBtnClickHandler);
         }
      }
      
      private function __numTxtChangeHandler(param1:Event) : void
      {
         buyNum = parseInt(_numTxt.text);
         buyNumChangeHandler();
      }
      
      private function __plusBtnClickHandler(param1:MouseEvent) : void
      {
         buyNum = buyNum + 1;
         buyNumChangeHandler();
      }
      
      private function __minusBtnClickHandler(param1:MouseEvent) : void
      {
         buyNum = buyNum - 1;
         buyNumChangeHandler();
      }
      
      private function buyNumChangeHandler() : void
      {
         buyNum = buyNum < 0 ? 0 : buyNum;
         buyNum = buyNum > 99 ? 99 : buyNum;
         _numTxt.text = buyNum.toString();
         totalGrade = _grade * buyNum;
         totalPrice = _price * buyNum;
         _totalGradeTxt.text = totalGrade == 0 ? LanguageMgr.GetTranslation("public.defaultnumber") : LanguageMgr.GetTranslation("SevenYearBuyItem.grade.text",totalGrade);
         if(totalPrice == 0)
         {
            _totalPriceTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _totalIcon.visible = false;
         }
         else
         {
            _totalPriceTxt.text = totalPrice.toString();
            _totalIcon.visible = true;
         }
         model.dispatchEvent(new SevenYearEvent("BUY_NUM_CHANGE",null));
      }
      
      public function clear() : void
      {
         buyNum = 0;
         buyNumChangeHandler();
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_plusBtn);
         _plusBtn = null;
         ObjectUtils.disposeObject(_minusBtn);
         _minusBtn = null;
         ObjectUtils.disposeObject(_totalGradeTxt);
         _totalGradeTxt = null;
         ObjectUtils.disposeObject(_totalIcon);
         _totalIcon = null;
         ObjectUtils.disposeObject(_totalPriceTxt);
         _totalPriceTxt = null;
         super.dispose();
      }
   }
}

