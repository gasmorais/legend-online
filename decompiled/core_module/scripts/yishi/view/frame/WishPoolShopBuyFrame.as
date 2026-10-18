package yishi.view.frame
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
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.WishPoolManager;
   import mvc.module.mounts.WildSoulInfo;
   import mvc.module.wishpool.WishPoolShopInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class WishPoolShopBuyFrame extends Frame
   {
      
      private var _selfSelectBtn:SelectedIconButton;
      
      private var _addBtn:BaseButton;
      
      private var _deleteBtn:BaseButton;
      
      private var _icon:*;
      
      private var _buyNumTxt:FilterFrameText;
      
      private var _buyImage:ScaleFrameImage;
      
      private var _priceTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _selfBack:MutipleImage;
      
      private var _selfConfirmBtn:IconButton;
      
      protected var _canOneText:FilterFrameText;
      
      protected var _canOneValueText:FilterFrameText;
      
      private var _buyNum:int = 1;
      
      private var _data:WishPoolShopInfo;
      
      private var _leftCanBuyCount:int;
      
      public function WishPoolShopBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _selfBack = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfBuyFrameBack2");
         _selfSelectBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfSelectedBackBtn");
         _selfConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.selfConfirmBtn");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.AddButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.DeleteButton");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyNumTextStyle");
         _buyImage = ComponentFactory.Instance.creatComponentByStylename("WishPoolShopFrame.ShopPayType");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyGoodsNameStyle");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.TotalPriceTextStyle");
         _canOneText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanOneTextStyle");
         _canOneValueText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanOneValueTextStyle");
         _icon = ComponentFactory.Instance.creatCustomObject("quickbuy.BuyBaseItemView");
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
         _buyImage.y = 130;
         addToContent(_nameTxt);
         addToContent(_priceTxt);
         addToContent(_canOneText);
         addToContent(_canOneValueText);
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
      
      public function set data(param1:WishPoolShopInfo) : void
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
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(_data)
         {
            _selfConfirmBtn.enable = false;
            _loc2_ = checkExist((_data as WishPoolShopInfo).tempalteId);
            if(!StringHelper.isNullOrEmpty(_loc2_))
            {
               MessageTipManager.instance().show(_loc2_);
               dispose();
               return;
            }
            WishPoolManager.instance.wishPoolShopBuy(_data.key,_buyNum);
         }
         dispose();
      }
      
      protected function checkExist(param1:int) : String
      {
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         if(_loc3_.SonType != 218)
         {
            return "";
         }
         var _loc2_:WildSoulInfo = MountsManager.instance.avatarList.getWildSoulInfo(_loc3_.Property1);
         if(_loc2_ && _loc2_.validity < 0 && _loc3_.Property2 < 0 && _loc3_.Refresh == -1)
         {
            return LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst");
         }
         return "";
      }
      
      private function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         var _loc1_:WishPoolShopInfo = _data as WishPoolShopInfo;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _loc1_.tempalteId;
         _icon.data = _loc2_;
         _nameTxt.text = _loc2_.templateInfo.TemplateName;
         _leftCanBuyCount = _data.limitBuyCount - _data.curHasBuyCount;
         if(_leftCanBuyCount > 0)
         {
            _canOneText.setFrame(1);
            _canOneText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem12.limited08",_leftCanBuyCount + "/" + _data.limitBuyCount);
            _selfConfirmBtn.enable = true;
         }
         else
         {
            _canOneText.setFrame(2);
            _canOneText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited05");
            _selfConfirmBtn.enable = false;
         }
         buyNumChangeHandler();
      }
      
      private function get currentCanCount() : int
      {
         var _loc1_:int = WishPoolManager.instance.model.leftScore / _data.price;
         return Math.min(_loc1_,_data.limitBuyCount - _data.curHasBuyCount);
      }
      
      private function buyNumChangeHandler() : void
      {
         if(currentCanCount < _buyNum)
         {
            _buyNum = currentCanCount;
         }
         if(_buyNum <= 1)
         {
            _buyNum = 1;
            _deleteBtn.enable = false;
         }
         else
         {
            _buyNum = _buyNum;
            _deleteBtn.enable = true;
         }
         if(_buyNum >= 9999)
         {
            _buyNum = 9999;
            _addBtn.enable = false;
         }
         else
         {
            _buyNum = _buyNum;
            _addBtn.enable = true;
         }
         if(_buyNum >= currentCanCount)
         {
            _addBtn.enable = false;
         }
         _buyNumTxt.text = _buyNum.toString();
         _priceTxt.text = _data.price * _buyNum + "";
         _buyImage.x = _priceTxt.x + _priceTxt.textWidth + 5;
         if(int(_priceTxt.text) > WishPoolManager.instance.model.leftScore)
         {
            _priceTxt.setFrame(2);
         }
         else
         {
            _priceTxt.setFrame(1);
         }
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
         SoundManager.instance.play("022");
         _buyNum = int(_buyNumTxt.text);
         buyNumChangeHandler();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _data = null;
         KeyBoardRegister.instance.keyEnable = true;
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
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

