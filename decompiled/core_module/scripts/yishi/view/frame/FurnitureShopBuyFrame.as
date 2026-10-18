package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import managers.ShopManager;
   import yishi.datas.templates.FurnitureShopTemplateInfo;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FurnitureShopBuyFrame extends Frame
   {
      
      protected var _selfSelectBtn:SelectedIconButton;
      
      protected var _canTotalText:FilterFrameText;
      
      protected var _canTotalValueText:FilterFrameText;
      
      protected var _addBtn:BaseButton;
      
      protected var _deleteBtn:BaseButton;
      
      protected var _icon:*;
      
      protected var _buyNumTxt:FilterFrameText;
      
      protected var _buyImage:ScaleFrameImage;
      
      protected var _priceTxt:FilterFrameText;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _hasCountText:FilterFrameText;
      
      protected var _selfBack:MutipleImage;
      
      protected var _selfConfirmBtn:IconButton;
      
      protected var _buyNum:int = 1;
      
      protected var _data:FurnitureShopTemplateInfo;
      
      protected var furnitureTempInfo:FurnitureTempInfo;
      
      private var hasCount:int;
      
      private var maxCount:int;
      
      private var canBuyMaxCount:int;
      
      public function FurnitureShopBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _selfBack = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfBuyFrameBack");
         _selfSelectBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfSelectedBackBtn");
         _selfConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.selfConfirmBtn");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.AddButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.DeleteButton");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyNumTextStyle");
         _buyImage = ComponentFactory.Instance.creatComponentByStylename("FurnitureShopBuyFrame.ShopPayType");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyGoodsNameStyle");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.TotalPriceTextStyle");
         _canTotalText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanTotalTextStyle");
         _canTotalValueText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanTotalValueTextStyle");
         _hasCountText = ComponentFactory.Instance.creatComponentByStylename("FurnitureShopBuyFrame.hasCountText");
         if(DisplayLoader.Context.applicationDomain.getDefinition("map.campaign.view.house.FurnitureBagCell") as Class)
         {
            _icon = ComponentFactory.Instance.creatCustomObject("FurnitureShopBuyFrame.FurnitureBagCell");
            _icon.isCanClickItem = false;
         }
         addToContent(_selfBack);
         addToContent(_selfSelectBtn);
         _selfSelectBtn.x = 102;
         _selfSelectBtn.selected = true;
         addToContent(_selfConfirmBtn);
         _selfConfirmBtn.x = 80;
         addToContent(_icon);
         addToContent(_addBtn);
         addToContent(_deleteBtn);
         addToContent(_buyNumTxt);
         addToContent(_buyImage);
         _buyImage.setFrame(1);
         _buyImage.x = 145;
         _buyImage.y = 132;
         addToContent(_nameTxt);
         addToContent(_priceTxt);
         addToContent(_canTotalText);
         addToContent(_canTotalValueText);
         addToContent(_hasCountText);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selfConfirmBtn.addEventListener("click",__confirmHandler);
         _addBtn.addEventListener("click",__addHandler);
         _deleteBtn.addEventListener("click",__deleteHandler);
         _buyNumTxt.addEventListener("change",__buyNumChange);
         _buyNumTxt.addEventListener("keyDown",__onKeydownHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selfConfirmBtn.removeEventListener("click",__confirmHandler);
         _addBtn.removeEventListener("click",__addHandler);
         _deleteBtn.removeEventListener("click",__deleteHandler);
         _buyNumTxt.removeEventListener("change",__buyNumChange);
         _buyNumTxt.removeEventListener("keyDown",__onKeydownHandler);
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmHandler(null);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      public function set data(param1:FurnitureShopTemplateInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("campaign.TrailShop.BuyBtnTxt");
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _buyNumTxt;
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_data)
         {
            return;
         }
         if(canBuyMaxCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("FurnitureShopItem.FurnitureBagCell.buyFullAlert"));
            return;
         }
         ShopManager.Instance.buyFurnitureGoods(_data.Id,_buyNum);
         dispose();
      }
      
      protected function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         furnitureTempInfo = TempleteManager.instance.furnitureTemplateCate.getTempById(_data.SellFurnitureId);
         if(!furnitureTempInfo)
         {
            return;
         }
         maxCount = HomeManager.instance.model.getCanSetMaxCountByFurnitureType(furnitureTempInfo.FurnitureType);
         hasCount = HomeManager.instance.model.getCurHasCountByTempId(furnitureTempInfo.TemplateId);
         _nameTxt.text = furnitureTempInfo.TemplateName;
         _priceTxt.text = _data.CostItemCount * _buyNum + "";
         _icon.furniture = furnitureTempInfo;
         _icon.refreshTxt(_data.SellFurnitureCount);
         _icon.isCanClickItem = false;
         _icon.tipData = furnitureTempInfo.TemplateName + "\n" + LanguageMgr.GetTranslation("FurnitureShopItem.FurnitureBagCell.tipData",3,8);
         _hasCountText.text = LanguageMgr.GetTranslation("FurnitureShopItem.FurnitureBagCell.tipData",hasCount,maxCount);
         hasCount >= maxCount ? _hasCountText.setFrame(2) : _hasCountText.setFrame(1);
         canBuyMaxCount = (maxCount - hasCount) / _data.SellFurnitureCount;
         buyNumChangeHandler();
      }
      
      protected function buyNumChangeHandler() : void
      {
         _buyNum = _buyNum < 1 ? 1 : _buyNum;
         _buyNum = _buyNum > canBuyMaxCount ? canBuyMaxCount : _buyNum;
         _buyNum <= 1 ? (_deleteBtn.enable = false) : (_deleteBtn.enable = true);
         _buyNum >= canBuyMaxCount ? (_addBtn.enable = false) : (_addBtn.enable = true);
         if(canBuyMaxCount <= 0)
         {
            _buyNum = 1;
            _addBtn.enable = false;
            _deleteBtn.enable = false;
         }
         _buyNumTxt.text = _buyNum.toString();
         _priceTxt.text = _data.CostItemCount * _buyNum + "";
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum + 1;
         buyNumChangeHandler();
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum - 1;
         buyNumChangeHandler();
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         _buyNum = int(_buyNumTxt.text);
         buyNumChangeHandler();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _data = null;
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_canTotalText);
         _canTotalText = null;
         ObjectUtils.disposeObject(_canTotalValueText);
         _canTotalValueText = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         ObjectUtils.disposeObject(_buyNumTxt);
         _buyNumTxt = null;
         ObjectUtils.disposeObject(_buyImage);
         _buyImage = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_selfBack);
         _selfBack = null;
         ObjectUtils.disposeObject(_selfConfirmBtn);
         _selfConfirmBtn = null;
         ObjectUtils.disposeObject(_hasCountText);
         _hasCountText = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

