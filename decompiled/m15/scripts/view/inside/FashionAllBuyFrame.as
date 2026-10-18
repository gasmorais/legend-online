package view.inside
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.shop.ShopCarListMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.fashion.FashionModel;
   import mvc.module.shop.ShopCartGoodsInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import yishi.comm.PackageIn;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.view.frame.discount.DiscountItem;
   import yishi.view.frame.discount.DiscountUI;
   import yishi.view.frame.discount.DiscountUtil;
   import yishi.view.tips.MessageTipManager;
   
   public class FashionAllBuyFrame extends Frame implements IManualSize
   {
      
      private var _buyArr:Array;
      
      private var _itemList:Vector.<AllBuyItem>;
      
      private var _back:ScaleBitmapImage;
      
      private var _buyBtn:IconButton;
      
      private var _valueBack:Bitmap;
      
      private var _valueImage:Bitmap;
      
      private var _valueText:FilterFrameText;
      
      private var _pointIcon:ScaleFrameImage;
      
      private var _notJoinActPrompt:FilterFrameText;
      
      private var _useBindBtn:SelectedCheckButton;
      
      private var _discountUI:DiscountUI;
      
      private var _discountContainer:Sprite;
      
      private var _addToShopCartBtn:IconButton;
      
      private var _shopModel:ShopModel;
      
      private var _totalPrice:int;
      
      private var _index:int = 0;
      
      public function FashionAllBuyFrame()
      {
         super();
         _shopModel = ShopManager.Instance.model;
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,width,height);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("view.inside.FashionAllBuyFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("shop.AllBuyFrameBack");
         _valueBack = ComponentFactory.Instance.creatBitmap("asset.shop.totalValueBack");
         _valueImage = ComponentFactory.Instance.creatBitmap("asset.shop.totalValueImage");
         _valueText = ComponentFactory.Instance.creatComponentByStylename("shop.totalValue");
         _pointIcon = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.allBuyBtn");
         _useBindBtn = ComponentFactory.Instance.creatComponentByStylename("shop.buyFashionUseBindBtn");
         _notJoinActPrompt = ComponentFactory.Instance.creatComponentByStylename("FashionAllBuyFrame.notJoinActTxt");
         _addToShopCartBtn = ComponentFactory.Instance.creatComponentByStylename("shop.addToShopCartBtn");
         _discountContainer = new Sprite();
         addToContent(_discountContainer);
         addToContent(_back);
         addToContent(_valueBack);
         addToContent(_valueImage);
         addToContent(_valueText);
         addToContent(_pointIcon);
         _pointIcon.setFrame(1);
         _pointIcon.x = 173;
         _pointIcon.y = 97;
         addToContent(_useBindBtn);
         _useBindBtn.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useBind");
         _useBindBtn.selected = true;
         addToContent(_buyBtn);
         addToContent(_notJoinActPrompt);
         _notJoinActPrompt.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.promptTxt");
         addToContent(_addToShopCartBtn);
      }
      
      private function initDiscountUI() : void
      {
         if(!DiscountUtil.isInitDiscountUI(3))
         {
            return;
         }
         _discountUI = ComponentFactory.Instance.creatComponentByStylename("yishi.view.frame.discount.discountui",[3,_totalPrice]);
         _discountContainer.addChild(_discountUI);
      }
      
      public function show(param1:Array) : void
      {
         if(!param1)
         {
            return;
         }
         _buyArr = param1;
         setUI();
         setTotalPrice();
         initDiscountUI();
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      private function setUI() : void
      {
         var _loc3_:int = 0;
         var _loc1_:AllBuyItem = null;
         _itemList = new Vector.<AllBuyItem>();
         _loc3_ = 0;
         while(_loc3_ < _buyArr.length)
         {
            _loc1_ = new AllBuyItem();
            _loc1_.x = 7;
            _loc1_.y = _loc3_ * (_loc1_.height + 3) + 11;
            _loc1_.data = _buyArr[_loc3_] as ShopGoodsInfo;
            if(_loc1_)
            {
               addToContent(_loc1_);
               _itemList.push(_loc1_);
            }
            _loc3_++;
         }
         var _loc2_:int = _itemList.length * 70 + (_itemList.length - 1) * 3;
         _back.height = _loc2_ + 159;
         _valueBack.y = _loc2_ + 18;
         _valueImage.y = _loc2_ + 29;
         _valueText.y = _loc2_ + 27;
         _pointIcon.y = _loc2_ + 27;
         _useBindBtn.y = _loc2_ + 58;
         _notJoinActPrompt.y = _loc2_ + 81;
         _buyBtn.y = _loc2_ + 103;
         _addToShopCartBtn.y = _loc2_ + 102;
         height = _loc2_ + 230;
      }
      
      private function setTotalPrice() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            if(_itemList[_loc4_].selected)
            {
               _loc2_ += _itemList[_loc4_].data.price;
               _loc3_++;
            }
            _loc4_++;
         }
         ShopManager.Instance.totalFashionCount = _loc3_;
         _totalPrice = _loc2_;
         _valueText.text = _totalPrice + "";
         var _loc1_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(_useBindBtn.selected)
         {
            _loc1_ = PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
         }
         if(_totalPrice > _loc1_)
         {
            _valueText.setFrame(2);
         }
         else
         {
            _valueText.setFrame(1);
         }
         MsgMan.notifyObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_NUM_CHANGED",_totalPrice);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         addEventListener("BUY_ITEM_SELECTED",__itemSelected);
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__allBuyHandler);
         }
         if(_addToShopCartBtn)
         {
            _addToShopCartBtn.addEventListener("click",__addToShopCartHandler);
         }
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4783,__succeedHandler);
         _useBindBtn.addEventListener("select",__useBindBtnSelectedHandler);
         MsgMan.addObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_SELECTED_QUAN",this,selectedQuan);
      }
      
      private function selectedQuan(param1:String, param2:Object) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         if(param2 == null)
         {
            _valueText.text = _totalPrice + "";
            _useBindBtn.enable = true;
            return;
         }
         _loc4_ = int(DiscountUtil.getDiscountNumByIdAndPrice(DiscountItem(param2).itemId,_totalPrice));
         if(_loc4_ > 0)
         {
            _useBindBtn.enable = false;
            _useBindBtn.selected = false;
            _valueText.text = _totalPrice - _loc4_ + "";
         }
         else
         {
            _useBindBtn.enable = true;
         }
      }
      
      private function __succeedHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopCarListMsg = new ShopCarListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ShopCarListMsg;
         var _loc3_:int = int(_loc2_.result);
         if(_loc3_ == 1 || _loc3_ == 12)
         {
            dispose();
         }
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      protected function __allBuyHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc7_:Object = null;
         var _loc3_:int = 0;
         var _loc5_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            if(_itemList[_loc4_].selected)
            {
               _loc7_ = {};
               _loc7_.count = 1;
               _loc7_.Id = _itemList[_loc4_].data.Id;
               _loc5_.push(_loc7_);
               _loc3_ += _itemList[_loc4_].data.price;
            }
            _loc4_++;
         }
         if(_loc5_.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.inside.FashionAllBuyFrame.oneFashionLess"));
            return;
         }
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(_useBindBtn.selected)
         {
            _loc2_ = PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
         }
         if(_loc3_ > _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         if(_buyBtn)
         {
            _buyBtn.enable = false;
         }
         var _loc6_:int = -1;
         if(_discountUI && _discountUI.selectedItem && _discountUI.selectedItem.selectBtn.selected && _discountUI.selectedItem.itemId != 0)
         {
            _loc6_ = int(_discountUI.selectedItem.itemId);
         }
         ShopManager.Instance.allFashion(_loc5_,playerInfo.userId,_useBindBtn.selected,_loc6_);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __addToShopCartHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:* = undefined;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:ShopCartGoodsInfo = null;
         var _loc6_:Vector.<ShopCartGoodsInfo> = _shopModel.shopCartList;
         if(_loc6_.length >= 20)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.addToShopCart.full"));
            dispose();
            return;
         }
         var _loc3_:Vector.<AllBuyItem> = new Vector.<AllBuyItem>();
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            if(_itemList[_loc4_].selected)
            {
               _loc3_.push(_itemList[_loc4_]);
            }
            _loc4_++;
         }
         if(_loc3_.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.ShopFrame.buyFrameI.addToShopCart.faltList"));
            return;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length)
            {
               if(_loc3_[_loc7_].data == _loc6_[_loc8_].goodsInfo)
               {
                  _loc3_[_loc7_].selected = false;
               }
               _loc8_++;
            }
            _loc7_++;
         }
         _loc5_ = new Vector.<AllBuyItem>();
         _loc9_ = 0;
         while(_loc9_ < _loc3_.length)
         {
            if(_loc3_[_loc9_].selected)
            {
               _loc5_.push(_loc3_[_loc9_]);
            }
            _loc9_++;
         }
         if(_loc5_.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.addToShopCart.same"));
            dispose();
            return;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc5_.length)
         {
            _loc2_ = new ShopCartGoodsInfo();
            _loc2_.goodsInfo = _loc5_[_loc10_].data;
            _loc2_.number = 1;
            _loc2_.isBind = _useBindBtn.selected;
            _shopModel.shopCartList.push(_loc2_);
            _loc10_++;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.ShopFrame.buyFrameI.addToShopCart.Success"));
         dispose();
      }
      
      protected function __itemSelected(param1:Event) : void
      {
         param1.stopPropagation();
         setTotalPrice();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         removeEventListener("BUY_ITEM_SELECTED",__itemSelected);
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__allBuyHandler);
         }
         if(_addToShopCartBtn)
         {
            _addToShopCartBtn.removeEventListener("click",__addToShopCartHandler);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4783,__succeedHandler);
         _useBindBtn.removeEventListener("select",__useBindBtnSelectedHandler);
         MsgMan.removeObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_SELECTED_QUAN",this,selectedQuan);
      }
      
      private function __useBindBtnSelectedHandler(param1:Event) : void
      {
         setTotalPrice();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _buyArr = null;
         if(_itemList)
         {
            cleanItemList();
         }
         _itemList = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_addToShopCartBtn);
         _addToShopCartBtn = null;
         ObjectUtils.disposeObject(_valueImage);
         _valueImage = null;
         ObjectUtils.disposeObject(_valueText);
         _valueText = null;
         ObjectUtils.disposeObject(_pointIcon);
         _pointIcon = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_valueBack);
         _valueBack = null;
         ObjectUtils.disposeObject(_notJoinActPrompt);
         _notJoinActPrompt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function cleanItemList() : void
      {
         while(_itemList.length > 0)
         {
            _itemList.pop().dispose();
         }
      }
   }
}

