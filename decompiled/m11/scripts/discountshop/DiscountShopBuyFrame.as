package discountshop
{
   import com.pickgliss.events.FrameEvent;
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
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.discountshop.DiscountShopItemInfo;
   import mvc.module.discountshop.DiscountShopModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.DiscountShopManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.discount.DiscountUI;
   
   public class DiscountShopBuyFrame extends Frame
   {
      
      protected var _canOneText:FilterFrameText;
      
      protected var _canOneValueText:FilterFrameText;
      
      protected var _addBtn:BaseButton;
      
      protected var _deleteBtn:BaseButton;
      
      protected var _icon:BaseItemView;
      
      protected var _buyNumTxt:FilterFrameText;
      
      protected var _buyImage:ScaleFrameImage;
      
      protected var _priceTxt:FilterFrameText;
      
      protected var _nowCount:FilterFrameText;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _friendBack:MutipleImage;
      
      protected var _selfBack:MutipleImage;
      
      protected var _selfConfirmBtn:IconButton;
      
      protected var _selfSelectBtn:SelectedIconButton;
      
      protected var _data:DiscountShopItemInfo;
      
      protected var _buyNum:int = 1;
      
      protected var _isUseBindPoint:Boolean = false;
      
      protected var _remainCount:int;
      
      private var showPrompt:int = 0;
      
      protected var _discountUI:DiscountUI;
      
      private var _discountContainer:Sprite;
      
      public function DiscountShopBuyFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         ShopManager.Instance.isHandsel = 0;
         _selfBack = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfBuyFrameBack");
         _friendBack = ComponentFactory.Instance.creatComponentByStylename("quickbuy.FriendBuyFrameBack");
         _selfSelectBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfSelectedBackBtn");
         _selfConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.selfConfirmBtn");
         _icon = ComponentFactory.Instance.creatCustomObject("quickbuy.BuyBaseItemView");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.AddButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.DeleteButton");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyNumTextStyle");
         _buyImage = ComponentFactory.Instance.creatComponentByStylename("quickbuy.ShopPayType");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyGoodsNameStyle");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.TotalPriceTextStyle");
         _nowCount = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame.NowItemGoodsCount");
         _canOneText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanOneTextStyle");
         _canOneValueText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanOneValueTextStyle");
         _discountContainer = new Sprite();
         addToContent(_discountContainer);
         addToContent(_selfBack);
         addToContent(_friendBack);
         addToContent(_selfSelectBtn);
         _selfSelectBtn.selected = true;
         _selfSelectBtn.x = 104;
         _selfSelectBtn.mouseChildren = _selfSelectBtn.mouseEnabled = false;
         addToContent(_selfConfirmBtn);
         _selfConfirmBtn.x = 80;
         addToContent(_icon);
         addToContent(_addBtn);
         addToContent(_deleteBtn);
         addToContent(_buyNumTxt);
         _buyNumTxt.text = "1";
         addToContent(_buyImage);
         _buyImage.setFrame(1);
         _buyImage.x = 160;
         addToContent(_nameTxt);
         addToContent(_priceTxt);
         addToContent(_nowCount);
         addToContent(_canOneText);
         _canOneText.text = LanguageMgr.GetTranslation("discountshop.goodsitem.buyLimit");
         addToContent(_canOneValueText);
         _canOneValueText.y = 113;
         titleText = LanguageMgr.GetTranslation("campaign.TrailShop.BuyBtnTxt");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selfConfirmBtn.addEventListener("click",__confirmBuy);
         _addBtn.addEventListener("click",__addHandler);
         _deleteBtn.addEventListener("click",__deleteHandler);
         _buyNumTxt.addEventListener("change",__buyNumChange);
         _buyNumTxt.addEventListener("keyDown",__onKeydownHandler);
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum + 1;
         if(_buyNum > _remainCount)
         {
            _buyNum = _remainCount;
         }
         _buyNumTxt.text = _buyNum.toString();
         buyNumChange();
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum - 1;
         if(_buyNum <= 0)
         {
            _buyNum = 1;
         }
         _buyNumTxt.text = _buyNum.toString();
         buyNumChange();
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         if(int(_buyNumTxt.text) > _remainCount)
         {
            _buyNumTxt.text = _remainCount.toString();
         }
         _buyNum = int(_buyNumTxt.text);
         buyNumChange();
      }
      
      private function buyNumChange() : void
      {
         var _loc1_:int = _data.price * discountModel.myDiscount / 10 < 1 ? 1 : _data.price * discountModel.myDiscount / 10;
         _priceTxt.text = (int(_buyNum * _loc1_)).toString();
         if(int(_priceTxt.text) > playerInfo.point)
         {
            _priceTxt.setFrame(2);
         }
         else
         {
            _priceTxt.setFrame(1);
         }
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmBuy(null);
         }
      }
      
      private function __confirmBuy(param1:MouseEvent) : void
      {
         if(_buyNum <= 0)
         {
            return;
         }
         if(int(_priceTxt.text) > playerInfo.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         DiscountShopManager.instance.operationDiscountShop(3,_data.index,int(_buyNumTxt.text));
         dispose();
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_selfConfirmBtn)
         {
            _selfConfirmBtn.removeEventListener("click",__confirmBuy);
         }
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addHandler);
         }
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",__deleteHandler);
         }
         if(_buyNumTxt)
         {
            _buyNumTxt.removeEventListener("change",__buyNumChange);
         }
         if(_buyNumTxt)
         {
            _buyNumTxt.removeEventListener("keyDown",__onKeydownHandler);
         }
      }
      
      public function set data(param1:DiscountShopItemInfo) : void
      {
         _data = param1;
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = param1.itemId;
         _icon.data = _loc4_;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.itemId);
         _nameTxt.text = _loc2_.TemplateName;
         var _loc3_:int = param1.price * discountModel.myDiscount / 10 < 1 ? 1 : param1.price * discountModel.myDiscount / 10;
         _priceTxt.text = _loc3_.toString();
         _nowCount.text = param1.count.toString();
         _remainCount = param1.limit - param1.buycount >= 0 ? param1.limit - param1.buycount : 0;
         _canOneValueText.text = _remainCount + "/" + param1.limit;
         if(_remainCount <= 0)
         {
            _selfConfirmBtn.enable = false;
         }
         else if(!_selfConfirmBtn.enable)
         {
            _selfConfirmBtn.enable = true;
         }
         buyNumChange();
      }
      
      public function get discountModel() : DiscountShopModel
      {
         return DiscountShopManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _buyNumTxt;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmBuy(null);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_canOneText)
         {
            ObjectUtils.disposeObject(_canOneText);
         }
         _canOneText = null;
         if(_canOneValueText)
         {
            ObjectUtils.disposeObject(_canOneValueText);
         }
         _canOneValueText = null;
         if(_addBtn)
         {
            ObjectUtils.disposeObject(_addBtn);
         }
         _addBtn = null;
         if(_deleteBtn)
         {
            ObjectUtils.disposeObject(_deleteBtn);
         }
         _deleteBtn = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         if(_buyNumTxt)
         {
            ObjectUtils.disposeObject(_buyNumTxt);
         }
         _buyNumTxt = null;
         if(_buyImage)
         {
            ObjectUtils.disposeObject(_buyImage);
         }
         _buyImage = null;
         if(_priceTxt)
         {
            ObjectUtils.disposeObject(_priceTxt);
         }
         _priceTxt = null;
         if(_nowCount)
         {
            ObjectUtils.disposeObject(_nowCount);
         }
         _nowCount = null;
         if(_friendBack)
         {
            ObjectUtils.disposeObject(_friendBack);
         }
         _friendBack = null;
         if(_selfBack)
         {
            ObjectUtils.disposeObject(_selfBack);
         }
         _selfBack = null;
         if(_selfConfirmBtn)
         {
            ObjectUtils.disposeObject(_selfConfirmBtn);
         }
         _selfConfirmBtn = null;
         if(_selfSelectBtn)
         {
            ObjectUtils.disposeObject(_selfSelectBtn);
         }
         _selfSelectBtn = null;
         if(_discountContainer)
         {
            ObjectUtils.disposeObject(_discountContainer);
         }
         _discountContainer = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

