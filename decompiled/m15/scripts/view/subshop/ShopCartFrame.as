package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shop.ShopCarListMsg;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.MainShopInfo;
   import mvc.module.shop.ShopCartGoodsInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import yishi.comm.PackageIn;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.giftdonatio.GiftDonatioFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ShopCartFrame extends Frame implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _bottomBg:Bitmap;
      
      private var _titleShineBg:Scale9CornerImage;
      
      private var _titleGap:MutipleImage;
      
      private var _nameText:FilterFrameText;
      
      private var _priceText:FilterFrameText;
      
      private var _numberText:FilterFrameText;
      
      private var _useBindText:FilterFrameText;
      
      private var _clearBtn:IconButton;
      
      private var _costTotal:Bitmap;
      
      private var _priceBg:Bitmap;
      
      private var _pointText:FilterFrameText;
      
      private var _bindPointText:FilterFrameText;
      
      private var _pointBmp:Bitmap;
      
      private var _bindPointBmp:Bitmap;
      
      private var _pointBg:MutipleImage;
      
      private var _userBindBg:MutipleImage;
      
      private var _playerPointText:FilterFrameText;
      
      private var _playerBindText:FilterFrameText;
      
      private var _allBuyBtn:IconButton;
      
      private var _chargeBtn:IconButton;
      
      private var _givingBtn:IconButton;
      
      private var _bagScrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _itemList:Vector.<ShopCartGoodsInfo>;
      
      private var _shopModel:ShopModel;
      
      public function ShopCartFrame()
      {
         super();
         _shopModel = ShopManager.Instance.model;
         initView();
         initEvent();
         initData();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,755,520);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.Title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("shopCart.Back1");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.shop.shopCartBottomBg");
         _titleShineBg = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.titleShineBg");
         _titleGap = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.titileGap");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.nameText");
         _priceText = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.priceText");
         _numberText = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.numberText");
         _useBindText = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.useBindTex");
         _nameText.text = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.nameText");
         _priceText.text = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.priceText");
         _numberText.text = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.numberText");
         _useBindText.text = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.useBindText");
         _clearBtn = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.clearBtn");
         _costTotal = ComponentFactory.Instance.creatBitmap("asset.shop.shopCart.costTotal");
         _priceBg = ComponentFactory.Instance.creatBitmap("asset.shop.shopCart.priceBg");
         _pointText = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.pointText");
         _bindPointText = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.bindPointText");
         _pointBmp = ComponentFactory.Instance.creatBitmap("asset.shop.shopCart.pointBmp");
         _bindPointBmp = ComponentFactory.Instance.creatBitmap("asset.shop.shopCart.bindPointBmp");
         _pointBg = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.pointImage");
         _userBindBg = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.bindDiamond");
         _playerPointText = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.playerPointText");
         _playerBindText = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.playerBindText");
         _allBuyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.allBuyBtn");
         _chargeBtn = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.chargeBtn");
         _givingBtn = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.givingBtn");
         _bagScrollPanel = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.vScollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("shop.shopCart.VBox");
         addToContent(_bg);
         addToContent(_bottomBg);
         addToContent(_titleShineBg);
         addToContent(_titleGap);
         addToContent(_nameText);
         addToContent(_priceText);
         addToContent(_numberText);
         addToContent(_useBindText);
         addToContent(_clearBtn);
         addToContent(_costTotal);
         addToContent(_priceBg);
         addToContent(_pointText);
         addToContent(_bindPointText);
         addToContent(_pointBmp);
         addToContent(_bindPointBmp);
         addToContent(_pointBg);
         addToContent(_userBindBg);
         addToContent(_playerPointText);
         addToContent(_playerBindText);
         addToContent(_allBuyBtn);
         addToContent(_chargeBtn);
         addToContent(_givingBtn);
         addToContent(_bagScrollPanel);
         _bagScrollPanel.setView(_vBox);
         _givingBtn.visible = false;
      }
      
      private function uninitView() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_titleShineBg);
         _titleShineBg = null;
         ObjectUtils.disposeObject(_titleGap);
         _titleGap = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_priceText);
         _priceText = null;
         ObjectUtils.disposeObject(_numberText);
         _numberText = null;
         ObjectUtils.disposeObject(_useBindText);
         _useBindText = null;
         ObjectUtils.disposeObject(_clearBtn);
         _clearBtn = null;
         ObjectUtils.disposeObject(_costTotal);
         _costTotal = null;
         ObjectUtils.disposeObject(_priceBg);
         _priceBg = null;
         ObjectUtils.disposeObject(_pointText);
         _pointText = null;
         ObjectUtils.disposeObject(_bindPointText);
         _bindPointText = null;
         ObjectUtils.disposeObject(_pointBmp);
         _pointBmp = null;
         ObjectUtils.disposeObject(_bindPointBmp);
         _bindPointBmp = null;
         ObjectUtils.disposeObject(_pointBg);
         _pointBg = null;
         ObjectUtils.disposeObject(_userBindBg);
         _userBindBg = null;
         ObjectUtils.disposeObject(_playerPointText);
         _playerPointText = null;
         ObjectUtils.disposeObject(_playerBindText);
         _playerBindText = null;
         ObjectUtils.disposeObject(_allBuyBtn);
         _allBuyBtn = null;
         ObjectUtils.disposeObject(_chargeBtn);
         _chargeBtn = null;
         ObjectUtils.disposeObject(_givingBtn);
         _givingBtn = null;
         ObjectUtils.disposeObject(_bagScrollPanel);
         _bagScrollPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         _itemList = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_allBuyBtn)
         {
            _allBuyBtn.addEventListener("click",__allBuyBtnHandler);
         }
         if(_chargeBtn)
         {
            _chargeBtn.addEventListener("click",__chargeBtnHandler);
         }
         if(_clearBtn)
         {
            _clearBtn.addEventListener("click",__clearBtnHandler);
         }
         if(_givingBtn)
         {
            _givingBtn.addEventListener("click",__givingBtnHandler);
         }
         if(_shopModel)
         {
            _shopModel.addEventListener("SHOPCART_DELETE_SUCCESS",__clearItemHandler);
         }
         if(_shopModel)
         {
            _shopModel.addEventListener("SHOPCART_UPDATE_SUCCESS",__updateItemHandler);
         }
         if(playerInfo)
         {
            playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         }
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4783,__shopCartHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_allBuyBtn)
         {
            _allBuyBtn.removeEventListener("click",__allBuyBtnHandler);
         }
         if(_chargeBtn)
         {
            _chargeBtn.removeEventListener("click",__chargeBtnHandler);
         }
         if(_clearBtn)
         {
            _clearBtn.removeEventListener("click",__clearBtnHandler);
         }
         if(_givingBtn)
         {
            _givingBtn.removeEventListener("click",__givingBtnHandler);
         }
         if(_shopModel)
         {
            _shopModel.removeEventListener("SHOPCART_DELETE_SUCCESS",__clearItemHandler);
         }
         if(_shopModel)
         {
            _shopModel.removeEventListener("SHOPCART_UPDATE_SUCCESS",__updateItemHandler);
         }
         if(playerInfo)
         {
            playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4783,__shopCartHandler);
      }
      
      private function __shopCartHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopCarListMsg = new ShopCarListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ShopCarListMsg;
         var _loc3_:int = int(_loc2_.result);
         if(_loc3_ == 1 || _loc3_ == 12)
         {
            _shopModel.shopCartList = new Vector.<ShopCartGoodsInfo>();
            _vBox.disposeAllChildren();
            _pointText.text = "0";
            _bindPointText.text = "0";
            _pointText.textFormatStyle = "shop.shopCart.costTotalStyle_t";
            _bindPointText.textFormatStyle = "shop.shopCart.costTotalStyle_t";
         }
      }
      
      private function __refreshPlayerInfoHandler(param1:PlayerEvent) : void
      {
         refreshResourceData();
      }
      
      private function __allBuyBtnHandler(param1:MouseEvent) : void
      {
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         if(_shopModel.shopCartList.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.shopCartItem.null"));
            return;
         }
         if(playerInfo.giftToken >= _shopModel.allCostBindPoint())
         {
            _loc4_ = int(_shopModel.allCostBindPoint());
         }
         else
         {
            _loc4_ = int(playerInfo.giftToken);
         }
         var _loc5_:int = _shopModel.allCostPoint() + _shopModel.allCostBindPoint() - _loc4_;
         if(_shopModel.allCostBindPoint() == 0)
         {
            if(playerInfo.point >= _loc5_)
            {
               _loc3_ = LanguageMgr.GetTranslation("public.fastCharge");
               _loc7_ = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.buyText4",_loc5_);
               SimpleAlertHelper.instance.data = [__confirmBuy];
               SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc2_,false,true);
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("public.fastCharge");
               _loc7_ = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.buyText3");
               SimpleAlertHelper.instance.data = [__charge];
               SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc2_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"FastChargeAlert");
            }
         }
         else if(playerInfo.point >= _loc5_)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.fastCharge");
            _loc7_ = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.buyText1",_loc5_,_loc4_);
            SimpleAlertHelper.instance.data = [__confirmBuy];
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc2_,false,true);
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("public.fastCharge");
            _loc7_ = LanguageMgr.GetTranslation("view.subshop.ShopCartFrame.buyText3");
            SimpleAlertHelper.instance.data = [__charge];
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc2_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"FastChargeAlert");
         }
      }
      
      private function __charge(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            __chargeBtnHandler(null);
            dispose();
         }
      }
      
      private function __confirmBuy(param1:Boolean, param2:Boolean) : void
      {
         var _loc5_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc6_:Object = null;
         if(param1)
         {
            _loc5_ = _shopModel.shopCartList;
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < _loc5_.length)
            {
               _loc6_ = {};
               if(_loc5_[_loc4_].goodsInfo is ShopGoodsInfo)
               {
                  _loc6_.shopId = (_loc5_[_loc4_].goodsInfo as ShopGoodsInfo).Id;
                  _loc6_.number = _loc5_[_loc4_].number;
                  _loc6_.type = _loc5_[_loc4_].isBind ? 2 : 1;
                  _loc6_.shopType = 0;
                  _loc6_.isDiscount = _loc5_[_loc4_].isDiscount;
                  _loc3_.push(_loc6_);
               }
               else if(_loc5_[_loc4_].goodsInfo is MainShopInfo)
               {
                  _loc6_.shopId = (_loc5_[_loc4_].goodsInfo as MainShopInfo).id;
                  _loc6_.number = _loc5_[_loc4_].number;
                  _loc6_.type = 1;
                  _loc6_.shopType = 0;
                  _loc6_.isDiscount = _loc5_[_loc4_].isDiscount;
                  _loc3_.push(_loc6_);
               }
               _loc4_++;
            }
            ShopManager.Instance.allBuy(_loc3_,playerInfo.userId);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __chargeBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __clearBtnHandler(param1:MouseEvent) : void
      {
         if(_shopModel.shopCartList.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.shopCartItem.null"));
            return;
         }
         _shopModel.shopCartList = new Vector.<ShopCartGoodsInfo>();
         _vBox.disposeAllChildren();
         _pointText.text = "0";
         _bindPointText.text = "0";
         _pointText.textFormatStyle = "shop.shopCart.costTotalStyle_t";
         _bindPointText.textFormatStyle = "shop.shopCart.costTotalStyle_t";
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.shopCartItem.deleteSuccess"));
      }
      
      private function __givingBtnHandler(param1:MouseEvent) : void
      {
         if(_shopModel.shopCartList.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.giving.add"));
            return;
         }
         var _loc4_:Vector.<ShopCartGoodsInfo> = _shopModel.shopCartList;
         for each(var _loc3_:ShopCartGoodsInfo in _loc4_)
         {
            if(_loc3_.isBind)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.giving.bind"));
               return;
            }
         }
         var _loc2_:GiftDonatioFrame = ComponentFactory.Instance.creatComponentByStylename("shop.GiftDonatioFrame");
         _loc2_.isShopCart = true;
         _loc2_.show();
      }
      
      private function __clearItemHandler(param1:ShopEvent) : void
      {
         refresh();
      }
      
      private function __updateItemHandler(param1:ShopEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _itemList = _shopModel.shopCartList;
         if(_itemList)
         {
            _loc2_ = int(_itemList.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_itemList[_loc3_].goodsInfo == (param1.data as ShopCartGoodsInfo).goodsInfo)
               {
                  (_vBox.getChildAt(_loc3_) as ShopCartItem).data = _itemList[_loc3_];
               }
               _loc3_++;
            }
         }
         refreshText();
      }
      
      private function initData() : void
      {
         refresh();
         refreshResourceData();
      }
      
      private function refreshResourceData() : void
      {
         if(playerInfo)
         {
            if(_playerPointText)
            {
               _playerPointText.text = playerInfo.point + "";
            }
            if(_playerBindText)
            {
               _playerBindText.text = playerInfo.giftToken1 + "";
            }
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ShopCartItem = null;
         _itemList = _shopModel.shopCartList;
         _vBox.disposeAllChildren();
         if(_itemList)
         {
            _loc1_ = int(_itemList.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = new ShopCartItem();
               _loc3_.height = 40;
               _loc3_.scaleY = _loc3_.scaleX = 1;
               _loc3_.data = _itemList[_loc2_];
               _loc3_.x = 23;
               _vBox.addChild(_loc3_);
               _loc2_++;
            }
         }
         refreshText();
      }
      
      private function refreshText() : void
      {
         if(playerInfo.point < _shopModel.allCostPoint())
         {
            _pointText.textFormatStyle = "shop.shopCart.costTotalStyle_tt";
         }
         else
         {
            _pointText.textFormatStyle = "shop.shopCart.costTotalStyle_t";
         }
         if(playerInfo.giftToken < _shopModel.allCostBindPoint())
         {
            _bindPointText.textFormatStyle = "shop.shopCart.costTotalStyle_tt";
         }
         else
         {
            _bindPointText.textFormatStyle = "shop.shopCart.costTotalStyle_t";
         }
         _bindPointText.text = _shopModel.allCostBindPoint().toString();
         _pointText.text = _shopModel.allCostPoint().toString();
         _bagScrollPanel.invalidateViewport();
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
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

