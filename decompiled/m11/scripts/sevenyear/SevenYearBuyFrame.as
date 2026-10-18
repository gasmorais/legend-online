package sevenyear
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SevenYearEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import sevenyear.view.item.SevenYearBuyItem;
   import sevenyear.view.item.SevenYearFlagItem;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.SimpleAlertHelper;
   
   public class SevenYearBuyFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _curLvImg:Image;
      
      private var _nextLvImg:Image;
      
      private var _curIcon:SevenYearFlagItem;
      
      private var _arrow:Image;
      
      private var _nextIcon:SevenYearFlagItem;
      
      private var _buyBtn:IconButton;
      
      private var _priceTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _totalGradeTxt:FilterFrameText;
      
      private var _totalPriceTxt:FilterFrameText;
      
      private var _allGradeTxt:FilterFrameText;
      
      private var _allIcon:Bitmap;
      
      private var _allPriceTxt:FilterFrameText;
      
      private var _itemList:Vector.<SevenYearBuyItem>;
      
      private var _allGrade:int;
      
      private var _allPrice:int;
      
      public function SevenYearBuyFrame()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.bg");
         _curLvImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.curLvImg");
         _nextLvImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.nextLvImg");
         _curIcon = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.curIcon.new");
         _arrow = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.arrow");
         _nextIcon = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.nextIcon.new");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.buyBtn");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.priceTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.numTxt");
         _totalGradeTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.totalGradeTxt");
         _totalPriceTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.totalPriceTxt");
         _allGradeTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.allGradeTxt");
         _allIcon = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _allPriceTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyFrame.allPriceTxt");
         addToContent(_bg);
         addToContent(_curLvImg);
         addToContent(_nextLvImg);
         _nextLvImg.visible = false;
         addToContent(_curIcon);
         addToContent(_arrow);
         _arrow.visible = false;
         addToContent(_nextIcon);
         _nextIcon.visible = false;
         addToContent(_buyBtn);
         addToContent(_priceTxt);
         addToContent(_numTxt);
         addToContent(_totalGradeTxt);
         addToContent(_totalPriceTxt);
         addToContent(_allGradeTxt);
         addToContent(_allIcon);
         addToContent(_allPriceTxt);
         _allIcon.x = 400;
         _allIcon.y = 313;
         _allIcon.visible = false;
         _priceTxt.text = LanguageMgr.GetTranslation("SevenYearBuyFrame.priceTxt.text");
         _numTxt.text = LanguageMgr.GetTranslation("SevenYearBuyFrame.numTxt.text");
         _totalGradeTxt.text = LanguageMgr.GetTranslation("SevenYearBuyFrame.totalGradeTxt.text");
         _totalPriceTxt.text = LanguageMgr.GetTranslation("SevenYearBuyFrame.totalPriceTxt.text");
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc1_:SevenYearBuyItem = null;
         var _loc2_:int = 0;
         _itemList = new Vector.<SevenYearBuyItem>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new SevenYearBuyItem(_loc2_);
            _loc1_.x = 0;
            _loc1_.y = 188 + 40 * _loc2_;
            _itemList.push(_loc1_);
            addToContent(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         model.addEventListener("BUY_NUM_CHANGE",__buyNumChangeHandler);
         model.addEventListener("UPDATE_USER_INFO",__updateUserInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         }
         model.removeEventListener("BUY_NUM_CHANGE",__buyNumChangeHandler);
         model.removeEventListener("UPDATE_USER_INFO",__updateUserInfoHandler);
      }
      
      private function __updateUserInfoHandler(param1:SevenYearEvent) : void
      {
         var _loc2_:SevenYearBuyItem = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = _itemList[_loc3_];
            _loc2_.clear();
            _loc3_++;
         }
      }
      
      private function __buyNumChangeHandler(param1:SevenYearEvent) : void
      {
         refreshView();
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [buyCallBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("SevenYearBuyFrame.buyBtnClick.text",_allPrice,_allGrade);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function buyCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:SevenYearBuyItem = null;
         var _loc3_:String = null;
         var _loc5_:int = 0;
         if(param1)
         {
            if(!LogicUtils.judgePointEnoughToShowPay(_allPrice,false))
            {
               return;
            }
            _loc3_ = "";
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               _loc4_ = _itemList[_loc5_];
               _loc3_ += _loc4_.buyNum + ",";
               _loc5_++;
            }
            _loc3_ = _loc3_.substr(0,_loc3_.length - 1);
            SevenYearManager.instance.sendOp(3,_loc3_);
         }
      }
      
      public function refreshView() : void
      {
         _allGrade = 0;
         _allPrice = 0;
         for each(var _loc2_:SevenYearBuyItem in _itemList)
         {
            _allGrade += _loc2_.totalGrade;
            _allPrice += _loc2_.totalPrice;
         }
         _allGradeTxt.text = _allGrade == 0 ? LanguageMgr.GetTranslation("public.defaultnumber") : LanguageMgr.GetTranslation("SevenYearBuyItem.grade.text",_allGrade);
         if(_allPrice == 0)
         {
            _allPriceTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _allIcon.visible = false;
         }
         else
         {
            _allPriceTxt.text = _allPrice.toString();
            _allIcon.visible = true;
         }
         _curIcon.grade = model.flagGrade;
         _nextIcon.grade = model.flagGrade + _allGrade;
         var _loc1_:Boolean = _allGrade > 0;
         _curLvImg.x = _loc1_ ? 90 : 215;
         _curIcon.x = _loc1_ ? 80 : 205;
         _nextLvImg.visible = _nextIcon.visible = _arrow.visible = _loc1_;
         _buyBtn.enable = _loc1_;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_curLvImg);
         _curLvImg = null;
         ObjectUtils.disposeObject(_nextLvImg);
         _nextLvImg = null;
         ObjectUtils.disposeObject(_curIcon);
         _curIcon = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_nextIcon);
         _nextIcon = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_totalGradeTxt);
         _totalGradeTxt = null;
         ObjectUtils.disposeObject(_totalPriceTxt);
         _totalPriceTxt = null;
         ObjectUtils.disposeObject(_allGradeTxt);
         _allGradeTxt = null;
         ObjectUtils.disposeObject(_allIcon);
         _allIcon = null;
         ObjectUtils.disposeObject(_allPriceTxt);
         _allPriceTxt = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

