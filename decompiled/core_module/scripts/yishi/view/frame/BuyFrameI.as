package yishi.view.frame
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shop.ShopCarListMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DungeonExploManager;
   import managers.MountsManager;
   import managers.PlayerCurrencyManager;
   import managers.PumpingJoyManager;
   import managers.ShopManager;
   import managers.VIPManager;
   import mvc.controler.ShopControler;
   import mvc.module.fashion.FashionModel;
   import mvc.module.mounts.WildSoulInfo;
   import mvc.module.shop.LimiteTimeDiscountInfo;
   import mvc.module.shop.MainShopInfo;
   import mvc.module.shop.ShopCartGoodsInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.discount.DiscountItem;
   import yishi.view.frame.discount.DiscountUI;
   import yishi.view.frame.discount.DiscountUtil;
   import yishi.view.frame.giftdonatio.GiftDonatioFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class BuyFrameI extends Frame
   {
      
      protected var _canTotalText:FilterFrameText;
      
      protected var _canTotalValueText:FilterFrameText;
      
      protected var _canOneText:FilterFrameText;
      
      protected var _canOneValueText:FilterFrameText;
      
      protected var _addBtn:BaseButton;
      
      protected var _deleteBtn:BaseButton;
      
      protected var _icon:BaseItemView;
      
      protected var _buyNumTxt:FilterFrameText;
      
      protected var _buyImage:ScaleFrameImage;
      
      protected var _buyIcon:Bitmap;
      
      protected var _priceTxt:FilterFrameText;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _friendBack:MutipleImage;
      
      protected var _selfBack:MutipleImage;
      
      protected var _friendConfirmBtn:BaseButton;
      
      protected var _selfConfirmBtn:IconButton;
      
      protected var _selfAddToShopCartBtn:IconButton;
      
      protected var _friendSelectBtn:SelectedIconButton;
      
      protected var _selfSelectBtn:SelectedIconButton;
      
      protected var _selectGroup:SelectedButtonGroup;
      
      protected var _callBack:Function;
      
      protected var _data:*;
      
      protected var _buyNum:int = 1;
      
      protected var _isuseBindPointBtn:SelectedCheckButton;
      
      protected var _isUseBindPoint:Boolean = false;
      
      protected var _notJoinActPrompt:FilterFrameText;
      
      private var showPrompt:int = 0;
      
      protected var _discountUI:DiscountUI;
      
      private var _discountContainer:Sprite;
      
      protected var _activeState:FilterFrameText;
      
      protected var _shopModel:ShopModel;
      
      private var _parm:Object;
      
      private var _goodsSonType:int;
      
      public function BuyFrameI()
      {
         super();
         _shopModel = ShopManager.Instance.model;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         ShopManager.Instance.isHandsel = 0;
         _selfBack = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfBuyFrameBack");
         _friendBack = ComponentFactory.Instance.creatComponentByStylename("quickbuy.FriendBuyFrameBack");
         _selfSelectBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfSelectedBackBtn");
         _friendSelectBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.FriendSelectedBackBtn");
         _friendConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.FriendConfirmBtn");
         _selfConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.selfConfirmBtn");
         _selfAddToShopCartBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.selfAddToShopCartBtn");
         _icon = ComponentFactory.Instance.creatCustomObject("quickbuy.BuyBaseItemView");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.AddButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.DeleteButton");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyNumTextStyle");
         _buyImage = ComponentFactory.Instance.creatComponentByStylename("quickbuy.ShopPayType");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyGoodsNameStyle");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.TotalPriceTextStyle");
         _canTotalText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanTotalTextStyle");
         _canTotalValueText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanTotalValueTextStyle");
         _canOneText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanOneTextStyle");
         _canOneValueText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanOneValueTextStyle");
         _isuseBindPointBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.useBindPointBtn");
         _notJoinActPrompt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.useBindPoint_notJoinActTxt");
         _activeState = ComponentFactory.Instance.creatComponentByStylename("quickbuy.ActiveStateTextStyle");
         _activeState.text = LanguageMgr.GetTranslation("view.GoodsItem3.ActiveState.text");
         _activeState.visible = true;
         _buyIcon = new Bitmap();
         _discountContainer = new Sprite();
         addToContent(_discountContainer);
         addToContent(_selfBack);
         addToContent(_friendBack);
         addToContent(_selfSelectBtn);
         addToContent(_friendSelectBtn);
         addToContent(_friendConfirmBtn);
         addToContent(_selfConfirmBtn);
         addToContent(_selfAddToShopCartBtn);
         addToContent(_icon);
         addToContent(_addBtn);
         addToContent(_deleteBtn);
         addToContent(_buyNumTxt);
         addToContent(_buyImage);
         addToContent(_buyIcon);
         addToContent(_nameTxt);
         addToContent(_priceTxt);
         addToContent(_canTotalText);
         addToContent(_canTotalValueText);
         addToContent(_canOneText);
         addToContent(_canOneValueText);
         addToContent(_activeState);
         addToContent(_isuseBindPointBtn);
         _isuseBindPointBtn.text = LanguageMgr.GetTranslation("yishi.view.frame.BuyFrameI.priorityUse");
         addToContent(_notJoinActPrompt);
         _notJoinActPrompt.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.promptTxt");
         titleText = LanguageMgr.GetTranslation("campaign.TrailShop.BuyBtnTxt");
         _selectGroup = new SelectedButtonGroup();
         _selectGroup.addSelectItem(_selfSelectBtn);
         _selectGroup.addSelectItem(_friendSelectBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_selfConfirmBtn)
         {
            _selfConfirmBtn.addEventListener("click",__confirmHandler);
         }
         if(_selfAddToShopCartBtn)
         {
            _selfAddToShopCartBtn.addEventListener("click",__addToShopCartHandler);
         }
         if(_friendConfirmBtn)
         {
            _friendConfirmBtn.addEventListener("click",__confirmHandler);
         }
         if(_selectGroup)
         {
            _selectGroup.addEventListener("change",__selectedeChangehandler);
         }
         if(_addBtn)
         {
            _addBtn.addEventListener("click",__addHandler);
         }
         if(_deleteBtn)
         {
            _deleteBtn.addEventListener("click",__deleteHandler);
         }
         if(_buyNumTxt)
         {
            _buyNumTxt.addEventListener("change",__buyNumChange);
         }
         if(_buyNumTxt)
         {
            _buyNumTxt.addEventListener("keyDown",__onKeydownHandler);
         }
         if(_isuseBindPointBtn)
         {
            _isuseBindPointBtn.addEventListener("select",__useBindPointHandler);
         }
         NotificationManager.instance.addEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
         NotificationManager.instance.addEventListener("SHOP_LIMITE_TIMEDISCOUNT_UPDATA",__updateDataHandler);
         MsgMan.addObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_SELECTED_QUAN",this,selectedQuan);
         NotificationManager.instance.addEventListener("SHOP_TIME_BUY_REFRESH",refreshShopLimitHandler);
      }
      
      private function refreshShopLimitHandler(param1:NotificationEvent) : void
      {
         refreshLimitView();
      }
      
      private function __addToShopCartHandler(param1:MouseEvent) : void
      {
         var _loc9_:int = 0;
         var _loc8_:GoodsTemplateInfo = null;
         var _loc2_:int = 0;
         var _loc10_:String = null;
         var _loc13_:Dictionary = null;
         var _loc12_:int = 0;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc11_:Vector.<ShopCartGoodsInfo> = _shopModel.shopCartList;
         if(_loc11_.length >= 20)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.addToShopCart.full"));
            dispose();
            return;
         }
         for each(var _loc3_:ShopCartGoodsInfo in _loc11_)
         {
            if(_data == _loc3_.goodsInfo)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.addToShopCart.same"));
               dispose();
               return;
            }
         }
         if(_data is ShopGoodsInfo)
         {
            _loc9_ = (_data as ShopGoodsInfo).ItemId;
            _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc9_);
            _loc2_ = _loc8_.SonType;
            if(_selfSelectBtn.selected)
            {
               if(_loc2_ == 218 && _loc8_.Property2 < 0)
               {
                  if(MountsManager.instance.avatarList.isLightTemplate(_loc8_.Property1) && _loc8_.Refresh == -1)
                  {
                     _loc10_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst2");
                     MessageTipManager.instance().show(_loc10_);
                     dispose();
                     return;
                  }
               }
               if(_loc2_ == 212 && _loc8_.TemplateId != 2120044)
               {
                  _loc13_ = TempleteManager.instance.getComposeTempleteList();
                  for each(var _loc4_:ComposeGoodsTemplete in _loc13_)
                  {
                     if(_loc8_.TemplateId == _loc4_.Material1)
                     {
                        _loc12_ = _loc4_.NewMaterial;
                        break;
                     }
                  }
                  _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_);
                  if(_loc6_)
                  {
                     if(MountsManager.instance.avatarList.isLightTemplate(_loc6_.Property1) && _loc6_.Property2 < 0 && _loc8_.Refresh == -1)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst2"));
                        dispose();
                        return;
                     }
                  }
               }
            }
         }
         if(_data.type == 2)
         {
            _loc5_ = _data.limitCount - _data.count;
            if(_loc5_ < _buyNum)
            {
               _buyNum = _loc5_;
            }
            _buyNum = _buyNum < 1 ? 1 : _buyNum;
            _buyNum = _buyNum > 9999 ? 9999 : _buyNum;
            _buyNumTxt.text = _buyNum.toString();
         }
         var _loc7_:ShopCartGoodsInfo = new ShopCartGoodsInfo();
         _loc7_.goodsInfo = _data;
         _loc7_.number = _buyNum;
         _loc7_.isBind = _isuseBindPointBtn.selected;
         _loc7_.isDiscount = _loc7_.goodsInfo is MainShopInfo;
         _shopModel.shopCartList.push(_loc7_);
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.ShopFrame.buyFrameI.addToShopCart.Success"));
         dispose();
      }
      
      private function selectedQuan(param1:String, param2:Object) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:ShopGoodsInfo = _data as ShopGoodsInfo;
         if(param2 == null)
         {
            if(_loc5_.ShopType == 1033)
            {
               _priceTxt.text = Math.floor(_data.price * getDiscountByLevel()) * _buyNum + "";
            }
            else
            {
               _priceTxt.text = _data.price * _buyNum + "";
            }
            _buyImage.x = _priceTxt.x + _priceTxt.textWidth + 5;
            _isuseBindPointBtn.enable = true;
            _selfAddToShopCartBtn.enable = true;
            return;
         }
         _loc4_ = DiscountUtil.getDiscountNumByIdAndPrice(DiscountItem(param2).itemId,_data.price * _buyNum);
         if(_loc4_ > 0)
         {
            _isuseBindPointBtn.enable = false;
            _isuseBindPointBtn.selected = false;
            _selfAddToShopCartBtn.enable = false;
            if(_loc5_.ShopType == 1033)
            {
               _priceTxt.text = Math.floor(_data.price * getDiscountByLevel()) * _buyNum + "";
            }
            else
            {
               _priceTxt.text = _data.price * _buyNum - _loc4_ + "";
            }
            _buyImage.x = _priceTxt.x + _priceTxt.textWidth + 5;
         }
         else
         {
            _isuseBindPointBtn.enable = true;
            _selfAddToShopCartBtn.enable = true;
         }
      }
      
      private function getDiscountByLevel() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getVipPrerogativeTypeTempList(208);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].grade == VIPManager.Instance.model.vipInfo.VipGrade)
            {
               _loc1_ = Number(_loc3_[_loc2_].para1);
            }
            _loc2_++;
         }
         return _loc1_ / 100;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_selfConfirmBtn)
         {
            _selfConfirmBtn.removeEventListener("click",__confirmHandler);
         }
         if(_selfAddToShopCartBtn)
         {
            _selfAddToShopCartBtn.removeEventListener("click",__addToShopCartHandler);
         }
         if(_friendConfirmBtn)
         {
            _friendConfirmBtn.removeEventListener("click",__confirmHandler);
         }
         if(_selectGroup)
         {
            _selectGroup.removeEventListener("change",__selectedeChangehandler);
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
         if(_isuseBindPointBtn)
         {
            _isuseBindPointBtn.removeEventListener("select",__useBindPointHandler);
         }
         NotificationManager.instance.removeEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
         NotificationManager.instance.removeEventListener("SHOP_LIMITE_TIMEDISCOUNT_UPDATA",__updateDataHandler);
         MsgMan.removeObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_SELECTED_QUAN",this,selectedQuan);
         NotificationManager.instance.removeEventListener("SHOP_TIME_BUY_REFRESH",refreshShopLimitHandler);
      }
      
      private function __updateHandler(param1:NotificationEvent) : void
      {
         _data = null;
         dispose();
      }
      
      private function __updateDataHandler(param1:NotificationEvent) : void
      {
         _data = null;
         dispose();
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
               ShopManager.Instance.count = 0;
               ShopManager.Instance.type = 1;
               if(_callBack != null)
               {
                  _callBack(false,_parm);
               }
               _callBack = null;
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      private function getSonType() : int
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:int = 0;
         if(_data is ShopGoodsInfo)
         {
            _loc3_ = (_data as ShopGoodsInfo).ItemId;
            _loc1_ = (_data as ShopGoodsInfo).Area;
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_);
            _loc2_ = _loc4_.SonType;
            if(_loc2_ == 111 || _loc2_ == 112 || _loc2_ == 110 || _loc2_ == 109)
            {
               return 3;
            }
            if(_loc1_ == 2)
            {
               return 1;
            }
            return 0;
         }
         return 0;
      }
      
      public function data(param1:*, param2:int = 1, param3:Object = null) : void
      {
         var _loc5_:int = 0;
         var _loc7_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc6_:ShopGoodsInfo = null;
         _data = param1;
         if(_data is ShopGoodsInfo)
         {
            _loc5_ = (_data as ShopGoodsInfo).ItemId;
            _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_);
            _loc4_ = _loc7_.SonType;
            if(_loc4_ == 218)
            {
               _addBtn.visible = false;
               _deleteBtn.visible = false;
               _buyNumTxt.type = "dynamic";
            }
            else
            {
               _addBtn.visible = true;
               _deleteBtn.visible = true;
               _buyNumTxt.type = "input";
            }
         }
         _parm = param3;
         _buyNum = param2;
         refreshView();
         _selectGroup.selectIndex = 0;
         buyNumChangeHandler();
         initDiscountUI();
         setActiveState();
         if(_data is ShopGoodsInfo)
         {
            _loc6_ = _data as ShopGoodsInfo;
            if(_loc6_.ShopType == 1)
            {
               if(_data.ItemId == 30000013)
               {
                  _selfAddToShopCartBtn.visible = false;
                  _selfConfirmBtn.x = 80;
               }
               else
               {
                  _selfAddToShopCartBtn.visible = true;
               }
            }
            else
            {
               _selfAddToShopCartBtn.visible = false;
               _selfConfirmBtn.x = 80;
            }
         }
         else if(_data is MainShopInfo)
         {
            _selfAddToShopCartBtn.visible = true;
         }
         else if(_data is LimiteTimeDiscountInfo)
         {
            _selfAddToShopCartBtn.visible = false;
            _selfConfirmBtn.x = 80;
         }
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function setActiveState() : void
      {
         if(_data && (_data is ShopGoodsInfo && fashionModel.isInBookList(_data.ItemId) || _data is MainShopInfo && fashionModel.isInBookList(_data.templateId) || _data is LimiteTimeDiscountInfo && fashionModel.isInBookList(_data.templateId)))
         {
            _activeState.visible = true;
         }
         else
         {
            _activeState.visible = false;
         }
      }
      
      private function initDiscountUI() : void
      {
         if(_data is ShopGoodsInfo)
         {
            if(_data.PayType != 1 && _data.PayType != 2)
            {
               return;
            }
         }
         else if(_data is MainShopInfo)
         {
            if(_data.type != 1 && _data.type != 2)
            {
               return;
            }
         }
         else if(data is LimiteTimeDiscountInfo)
         {
            if(_data.type != 1 && _data.type != 2)
            {
               return;
            }
         }
         _goodsSonType = getSonType();
         if(!DiscountUtil.isInitDiscountUI(_goodsSonType))
         {
            return;
         }
         _discountUI = ComponentFactory.Instance.creatComponentByStylename("yishi.view.frame.discount.discountui",[_goodsSonType,_data.price * _buyNum]);
         _discountContainer.addChild(_discountUI);
      }
      
      public function set callback(param1:Function) : void
      {
         _callBack = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _buyNumTxt;
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
      
      protected function __useBindPointHandler(param1:Event) : void
      {
         buyNumChangeHandler();
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc10_:int = 0;
         var _loc8_:GoodsTemplateInfo = null;
         var _loc2_:int = 0;
         var _loc11_:String = null;
         var _loc13_:Dictionary = null;
         var _loc12_:int = 0;
         var _loc7_:GoodsTemplateInfo = null;
         var _loc14_:ShopGoodsInfo = null;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc3_:String = null;
         var _loc4_:GiftDonatioFrame = null;
         var _loc9_:String = null;
         SoundManager.instance.play("022");
         if(_data)
         {
            _selfConfirmBtn.enable = false;
            _friendConfirmBtn.enable = false;
            if(_data is ShopGoodsInfo)
            {
               _loc10_ = (_data as ShopGoodsInfo).ItemId;
               _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc10_);
               _loc2_ = _loc8_.SonType;
               if(_selfSelectBtn.selected)
               {
                  if(_loc2_ == 218 && _loc8_.Property2 < 0)
                  {
                     if(MountsManager.instance.avatarList.isLightTemplate(_loc8_.Property1) && _loc8_.Refresh == -1)
                     {
                        _loc11_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst");
                        MessageTipManager.instance().show(_loc11_);
                        return;
                     }
                  }
                  if(_loc2_ == 212 && _loc8_.TemplateId != 2120044)
                  {
                     _loc13_ = TempleteManager.instance.getComposeTempleteList();
                     for each(var _loc5_:ComposeGoodsTemplete in _loc13_)
                     {
                        if(_loc8_.TemplateId == _loc5_.Material1)
                        {
                           _loc12_ = _loc5_.NewMaterial;
                           break;
                        }
                     }
                     _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_);
                     if(_loc7_)
                     {
                        if(MountsManager.instance.avatarList.isLightTemplate(_loc7_.Property1) && _loc7_.Property2 < 0 && _loc8_.Refresh == -1)
                        {
                           MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst"));
                           return;
                        }
                     }
                  }
               }
            }
            if(int(_priceTxt.text) > PayMoney)
            {
               if(_data.PayType == 1)
               {
                  RechargeAlertMannager.show();
               }
               else if(_data.PayType == 2)
               {
                  RechargeAlertMannager.show();
               }
               else if(_data.PayType == 3)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("star.view.MakeStarView.command02"));
               }
               else if(_data.PayType == 6)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.MazeCoinLack"));
               }
               else if(_data.PayType == 5)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.MedalLack"));
               }
               else if(_data.PayType == 4)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.SociatyContribLack"));
               }
               else if(_data.PayType == 15)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.chaosTip"));
               }
               else if(_data.PayType == 16)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.eternalCrystalTip"));
               }
               else if(_data.PayType == 8)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.NotEnoughBackPlayer"));
               }
               else if(_data.PayType == 9)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.fashionPieceTip"));
               }
               else if(_data.PayType == 10)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.sealOfKing"));
               }
               else if(_data.PayType == 11)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.LeagueMedalLack"));
               }
               else if(_data.PayType == 12)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.guildNotEnough"));
               }
               else if(_data.PayType == 17)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.pokerScoreNotEnough"));
               }
               else if(_data.PayType == 18)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.outyardNotEnough"));
               }
               else if(_data.PayType == 19)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.bingoNotEnough"));
               }
               else if(_data.PayType == 7)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.aresHeartTip"));
               }
               else if(_data.PayType == 13)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.athenaTearTip"));
               }
               else if(_data.PayType == 20)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.gloryBuyAlertTip"));
               }
               else if(_data.PayType == 21)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.yellowBuyAlertTip"));
               }
               else if(_data.PayType == 22)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.exploreShopBuyAlertTip"));
               }
               else if(_data.PayType == 28)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.assaultwarShopBuyAlertTip"));
               }
               else if(_data.PayType == 2001)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.pumpingJoyBuyAlertTip"));
               }
               else if(_data.PayType == 29)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.copyConsortiaShopBuyAlertTip"));
               }
               else if(_data.PayType == 31)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.crossGuild.buyAlertTip"));
               }
               else if(_data.PayType == 33)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.airgardenProp.buyAlertTip"));
               }
               else if(_data.PayType == 37)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noFlameTempleCoinAlert"));
               }
               else if(_data.PayType == 38)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noDuskAreaAlert"));
               }
               else if(_data.PayType == 39)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noDarkMazeCoinAlert"));
               }
               else if(_data.PayType == 40)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noConsortiaNewBossCoinAlert"));
               }
               else if(_data.PayType == 42)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noYearGoldCoinAlert"));
               }
               else if(_data.PayType == 43)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noYearBoxkeyCoinAlert"));
               }
               else if(_data.PayType == 44)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noMinosCoinAlert"));
               }
               else if(_data.PayType == 45)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noChesspvpCoinAlert"));
               }
               else if(_data.PayType == 46)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noChildNswarCoinAlert"));
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.MoneyLack"));
               }
               dispose();
               return;
            }
            if(_selfSelectBtn.selected)
            {
               if(_data.PayType == 6)
               {
                  _loc14_ = TempleteManager.instance.getMazeShopTempInfoByItemId(_data.ItemId);
                  _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
                  if(GoodsSonType.EQUIP_SONTYPE_LIST.indexOf(_loc6_.SonType) >= 0 && GoodsManager.instance.checkExistGoodsByTempIdInAllBag(_loc6_.TemplateId))
                  {
                     alert();
                     return;
                  }
               }
               _loc3_ = checkExist((_data as ShopGoodsInfo).ItemId);
               if(!StringHelper.isNullOrEmpty(_loc3_))
               {
                  MessageTipManager.instance().show(_loc3_);
                  dispose();
                  return;
               }
               if(_loc10_ == 30000013)
               {
                  DungeonExploManager.instance.sendDungeonOperate(5,0,0,_buyNum);
                  dispose();
                  return;
               }
               buy(_isuseBindPointBtn.selected);
               return;
            }
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("shop.GiftDonatioFrame");
            _loc4_.ShopId = (_data as ShopGoodsInfo).Id;
            _loc4_.number = _buyNum;
            _loc4_.show();
            dispose();
            return;
         }
         _loc9_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.buyFailed");
         MessageTipManager.instance().show(_loc9_);
         dispose();
      }
      
      private function alert() : void
      {
         var result:Function = function(param1:Boolean, param2:Boolean):void
         {
            if(param1)
            {
               buy();
            }
            else
            {
               dispose();
            }
         };
         SimpleAlertHelper.instance.data = [result];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("BuyFrameI.tip01"),LanguageMgr.GetTranslation("BuyFrameI.tip02"),LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel1"));
      }
      
      private function buy(param1:Boolean = true) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
         var _loc6_:int = 0;
         if(_discountUI && _discountUI.selectedItem && _discountUI.selectedItem.selectBtn.selected && _discountUI.selectedItem.itemId != 0)
         {
            _loc6_ = _discountUI.selectedItem.itemId;
         }
         if(_data is MainShopInfo)
         {
            _loc4_ = true;
            _loc5_ = (_data as MainShopInfo).id;
         }
         else
         {
            _loc5_ = (_data as ShopGoodsInfo).Id;
            _loc4_ = false;
         }
         if(param1)
         {
            _loc3_ = 2;
         }
         else
         {
            _loc3_ = 1;
         }
         ShopManager.Instance.buyOne(_loc5_,_buyNum,playerInfo.userId,_loc3_,_loc4_,_loc6_);
         if(_callBack != null)
         {
            SocketManager.instance.addEventListener("SLGSocketEvent" + 4783,__shopResult);
         }
         dispose();
      }
      
      private function isFashionGoods(param1:GoodsTemplateInfo) : Boolean
      {
         if(param1.SonType == 112 || param1.SonType == 110 || param1.SonType == 111 || param1.SonType == 109)
         {
            return true;
         }
         return false;
      }
      
      private function __selectedeChangehandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(_selectGroup.getSelectedItem() == _selfSelectBtn)
         {
            _selfBack.visible = true;
            _friendBack.visible = false;
            _selfConfirmBtn.visible = true;
            _friendConfirmBtn.visible = false;
            _friendSelectBtn.selected = false;
            _selfSelectBtn.selected = true;
            _selfAddToShopCartBtn.visible = true;
            if(_data is MainShopInfo)
            {
               _buyImage.setFrame(1);
            }
            else if(_data is LimiteTimeDiscountInfo)
            {
               _buyImage.setFrame(1);
            }
            else if(_data.PayType == 2)
            {
               _buyImage.setFrame(1);
            }
            else if(_data.PayType == 28)
            {
               _buyImage.setFrame(23);
            }
            else if(_data.PayType == 2001)
            {
               _buyImage.setFrame(24);
            }
            else if(_data.PayType == 1022)
            {
               _buyImage.setFrame(39);
            }
            else if(_data.PayType == 39)
            {
               _buyImage.setFrame(40);
            }
            else if(_data.PayType == 40)
            {
               _buyImage.setFrame(41);
            }
            else if(_data.PayType == 41)
            {
               _buyImage.setFrame(42);
               _buyImage.y = 129;
            }
            else if(_data.PayType == 42)
            {
               _buyImage.setFrame(43);
               _buyImage.y = 129;
            }
            else if(_data.PayType == 43)
            {
               _buyImage.setFrame(44);
               _buyImage.y = 129;
            }
            else if(_data.PayType == 44)
            {
               _buyImage.setFrame(45);
               _buyImage.y = 126;
            }
            else if(_data.PayType == 45)
            {
               _buyImage.setFrame(46);
               _buyImage.y = 126;
            }
            else if(_data.PayType == 46)
            {
               _buyImage.setFrame(47);
               _buyImage.y = 126;
            }
            else
            {
               _buyImage.setFrame(_data.PayType);
            }
            showPrompt = 0;
            ShopManager.Instance.isHandsel = 0;
            titleText = LanguageMgr.GetTranslation("campaign.TrailShop.BuyBtnTxt");
            _notJoinActPrompt.visible = _isuseBindPointBtn.visible = _isuseBindPointBtn.selected = _isUseBindPoint;
            if(_discountUI)
            {
               _discountUI.visible = true;
               if(_discountUI.selectedItem)
               {
                  _discountUI.selectedItem.selectBtn.selected = true;
               }
            }
         }
         else if(_selectGroup.getSelectedItem() == _friendSelectBtn)
         {
            _selfBack.visible = false;
            _friendBack.visible = true;
            _selfConfirmBtn.visible = false;
            _friendConfirmBtn.visible = true;
            _selfSelectBtn.selected = false;
            _friendSelectBtn.selected = true;
            _selfAddToShopCartBtn.visible = false;
            showPrompt = 1;
            ShopManager.Instance.isHandsel = 1;
            _isuseBindPointBtn.visible = false;
            _isuseBindPointBtn.selected = false;
            _notJoinActPrompt.visible = false;
            titleText = LanguageMgr.GetTranslation("yishi.view.frame.BuyFrameI.Presentation");
            if(_discountUI)
            {
               _discountUI.visible = false;
               if(_discountUI.selectedItem)
               {
                  _discountUI.selectedItem.selectBtn.selected = false;
               }
            }
         }
         updatePrompt();
         buyNumChangeHandler();
      }
      
      protected function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         var _loc1_:ShopGoodsInfo = _data as ShopGoodsInfo;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _loc1_.ItemId;
         _icon.data = _loc2_;
         _nameTxt.text = _loc2_.templateInfo.TemplateName;
         _nameTxt.numLines > 1 ? (_nameTxt.y = 40) : (_nameTxt.y = 45);
         if(_loc1_.PayType == 2)
         {
            _buyImage.setFrame(1);
            _isUseBindPoint = true;
         }
         else
         {
            _buyImage.setFrame(_loc1_.PayType);
            if(_loc1_.PayType == 8)
            {
               _selfAddToShopCartBtn.enable = false;
            }
            else if(_data.PayType == 28)
            {
               _buyImage.setFrame(23);
            }
            else if(_data.PayType == 2001)
            {
               _buyImage.setFrame(24);
            }
            _isUseBindPoint = false;
            _isuseBindPointBtn.visible = false;
            _isuseBindPointBtn.selected = false;
            _notJoinActPrompt.visible = false;
         }
         _selfSelectBtn.x = 102;
         _friendSelectBtn.visible = false;
         if(_nameTxt.text.length > 30)
         {
            _nameTxt.text = _nameTxt.text.substr(0,29) + "...";
         }
      }
      
      protected function buyNumChangeHandler() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:ShopGoodsInfo = _data as ShopGoodsInfo;
         if(_data.type == 2)
         {
            _loc3_ = _data.limitCount - _data.count;
            if(_data is LimiteTimeDiscountInfo)
            {
               if(limiteTimeDiscountCanCount < _buyNum)
               {
                  _buyNum = limiteTimeDiscountCanCount;
               }
               _buyNum = _buyNum < 1 ? 1 : _buyNum;
               _buyNum = _buyNum > 9999 ? 9999 : _buyNum;
               _buyNumTxt.text = _buyNum.toString();
            }
            else
            {
               if(_loc3_ < _buyNum)
               {
                  _buyNum = _loc3_;
               }
               _buyNum = _buyNum < 1 ? 1 : _buyNum;
               _buyNum = _buyNum > 9999 ? 9999 : _buyNum;
            }
            _buyNumTxt.text = _buyNum.toString();
            if(_discountUI && _discountUI.selectedItem && _discountUI.selectedItem.selectBtn.selected)
            {
               _loc1_ = DiscountUtil.getDiscountNumByIdAndPrice(_discountUI.selectedItem.itemId,_data.price * _buyNum);
               if(_loc2_.ShopType == 1033)
               {
                  _priceTxt.text = Math.floor(_data.price * getDiscountByLevel()) * _buyNum + "";
               }
               else
               {
                  _priceTxt.text = _data.price * _buyNum - _loc1_ + "";
               }
            }
            else if(_loc2_.ShopType == 1033)
            {
               _priceTxt.text = Math.floor(_data.price * getDiscountByLevel()) * _buyNum + "";
            }
            else
            {
               _priceTxt.text = _data.price * _buyNum + "";
            }
            if(int(_priceTxt.text) > PayMoney)
            {
               _priceTxt.setFrame(2);
            }
            else
            {
               _priceTxt.setFrame(1);
            }
            _buyNum <= 1 ? (_deleteBtn.enable = false) : (_deleteBtn.enable = true);
            _buyNum >= 9999 ? (_addBtn.enable = false) : (_addBtn.enable = true);
            if(_data is LimiteTimeDiscountInfo)
            {
               if(_buyNum >= limiteTimeDiscountCanCount)
               {
                  _addBtn.enable = false;
               }
            }
            else if(_buyNum >= _loc3_)
            {
               _addBtn.enable = false;
            }
            _buyImage.x = _priceTxt.x + _priceTxt.textWidth + 5;
            refreshLimitView();
         }
         else
         {
            if(_data is ShopGoodsInfo && (_loc2_.ShopType == 1033 || _loc2_.ShopType == 1034))
            {
               if(currentCanCount - ShopManager.Instance.count < _buyNum)
               {
                  _buyNum = currentCanCount - ShopManager.Instance.count;
               }
            }
            else if(currentCanCount < _buyNum)
            {
               _buyNum = currentCanCount;
            }
            _buyNum = _buyNum < 1 ? 1 : _buyNum;
            _buyNum = _buyNum > 9999 ? 9999 : _buyNum;
            _buyNumTxt.text = _buyNum.toString();
            if(_discountUI && _discountUI.selectedItem && _discountUI.selectedItem.selectBtn.selected)
            {
               _loc1_ = DiscountUtil.getDiscountNumByIdAndPrice(_discountUI.selectedItem.itemId,_data.price * _buyNum);
               if(_loc2_.ShopType == 1033)
               {
                  _priceTxt.text = Math.floor(_data.price * getDiscountByLevel()) * _buyNum + "";
               }
               else
               {
                  _priceTxt.text = _data.price * _buyNum - _loc1_ + "";
               }
            }
            else if(_loc2_ && _loc2_.ShopType == 1033)
            {
               _priceTxt.text = Math.floor(_data.price * getDiscountByLevel()) * _buyNum + "";
            }
            else
            {
               _priceTxt.text = _data.price * _buyNum + "";
            }
            if(int(_priceTxt.text) > PayMoney)
            {
               _priceTxt.setFrame(2);
            }
            else
            {
               _priceTxt.setFrame(1);
            }
            _buyNum <= 1 ? (_deleteBtn.enable = false) : (_deleteBtn.enable = true);
            _buyNum >= 9999 ? (_addBtn.enable = false) : (_addBtn.enable = true);
            if(_buyNum >= currentCanCount)
            {
               _addBtn.enable = false;
            }
            _buyImage.x = _priceTxt.x + _priceTxt.textWidth + 5;
            refreshLimitView();
         }
         MsgMan.notifyObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_NUM_CHANGED",_data.price * _buyNum);
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
      
      private function discountPayMoney() : int
      {
         if(_discountUI)
         {
            return _discountUI.getDiscountNum(_data.price * _buyNum);
         }
         return 0;
      }
      
      private function get currentCanCount() : int
      {
         var _loc1_:int = PayMoney / _data.price;
         if(_data.canBuyNum == -1)
         {
            return _loc1_;
         }
         if(_loc1_ < 1)
         {
            return 1;
         }
         return Math.min(_loc1_,_data.canBuyNum);
      }
      
      private function get limiteTimeDiscountCanCount() : int
      {
         var _loc1_:int = PayMoney / _data.price;
         if(_loc1_ < 1)
         {
            return 1;
         }
         return Math.min(_loc1_,_data.limitCount - _data.count);
      }
      
      public function get PayMoney() : int
      {
         var _loc1_:int = discountPayMoney();
         if(_data is LimiteTimeDiscountInfo)
         {
            if(_isuseBindPointBtn.selected)
            {
               return playerInfo.giftToken + playerInfo.point;
            }
            return _loc1_ + playerInfo.point;
         }
         if(_data.PayType == 1 || _data is MainShopInfo)
         {
            return _loc1_ + playerInfo.point;
         }
         if(_data.PayType == 2)
         {
            if(_friendSelectBtn.selected)
            {
               return playerInfo.point;
            }
            if(_isuseBindPointBtn.selected)
            {
               return playerInfo.giftToken + playerInfo.point;
            }
            return _loc1_ + playerInfo.point;
         }
         if(_data.PayType == 3)
         {
            return ResourceManager.instance.gold.count;
         }
         if(_data.PayType == 4)
         {
            return playerInfo.consortiaOffer;
         }
         if(_data.PayType == 5)
         {
            return PlayerCurrencyManager.instance.currencyInfo.arenaMedal.amount;
         }
         if(_data.PayType == 6)
         {
            return GoodsManager.instance.getGoodsNumByTempId(208009) + PlayerCurrencyManager.instance.mazeGoldNumber;
         }
         if(_data.PayType == 15)
         {
            return PlayerCurrencyManager.instance.currencyInfo.chaos.amount;
         }
         if(_data.PayType == 16)
         {
            return PlayerCurrencyManager.instance.currencyInfo.eternalCrystal.amount;
         }
         if(_data.PayType == 8)
         {
            return GoodsManager.instance.getGoodsNumByTempId(2125048);
         }
         if(_data.PayType == 9)
         {
            return GoodsManager.instance.getGoodsNumByTempId(_data.NeedItem);
         }
         if(_data.PayType == 11)
         {
            return PlayerManager.instance.currentPlayerModel.playerInfo.crossLeagueMedal;
         }
         if(_data.PayType == 12)
         {
            return PlayerCurrencyManager.instance.currencyInfo.guildSkill.amount;
         }
         if(_data.PayType == 17)
         {
            return PlayerManager.instance.currentPlayerModel.playerInfo.pokerScore;
         }
         if(_data.PayType == 18)
         {
            return PlayerCurrencyManager.instance.currencyInfo.outyardCoin.amount;
         }
         if(_data.PayType == 19)
         {
            return PlayerCurrencyManager.instance.currencyInfo.bingoCoin.amount;
         }
         if(_data.PayType == 7)
         {
            return PlayerCurrencyManager.instance.currencyInfo.aresHeart.amount;
         }
         if(_data.PayType == 10)
         {
            return PlayerCurrencyManager.instance.currencyInfo.yarramanCoin.amount;
         }
         if(_data.PayType == 13)
         {
            return PlayerCurrencyManager.instance.currencyInfo.athenaTear.amount;
         }
         if(_data.PayType == 20)
         {
            return PlayerCurrencyManager.instance.currencyInfo.gloryCoin.amount;
         }
         if(_data.PayType == 21)
         {
            return PlayerCurrencyManager.instance.currencyInfo.yellowCoin.amount;
         }
         if(_data.PayType == 22)
         {
            return PlayerCurrencyManager.instance.currencyInfo.exploreMedal.amount;
         }
         if(_data.PayType == 28)
         {
            return PlayerCurrencyManager.instance.currencyInfo.assaultwarMedal.amount;
         }
         if(_data.PayType == 2001)
         {
            return PumpingJoyManager.instance.model.totalScore;
         }
         if(_data.PayType == 25)
         {
            return PlayerCurrencyManager.instance.currencyInfo.godsMarking.amount;
         }
         if(_data.PayType == 29)
         {
            return PlayerCurrencyManager.instance.currencyInfo.copyConsortia.amount;
         }
         if(_data.PayType == 31)
         {
            return PlayerCurrencyManager.instance.currencyInfo.crossGuildCoin.amount;
         }
         if(_data.PayType == 30)
         {
            return PlayerCurrencyManager.instance.currencyInfo.apexCoin.amount;
         }
         if(_data.PayType == 33)
         {
            return PlayerCurrencyManager.instance.currencyInfo.airGardenPropCoin.amount;
         }
         if(_data.PayType == 37)
         {
            return PlayerCurrencyManager.instance.currencyInfo.flameTempleCoin.amount;
         }
         if(_data.PayType == 38)
         {
            return PlayerCurrencyManager.instance.currencyInfo.duskAreaCoin.amount;
         }
         if(_data.PayType == 1022)
         {
            return PlayerCurrencyManager.instance.currencyInfo.demonroadCoin.amount;
         }
         if(_data.PayType == 39)
         {
            return PlayerCurrencyManager.instance.currencyInfo.darkmazeSoulCoin.amount;
         }
         if(_data.PayType == 40)
         {
            return PlayerCurrencyManager.instance.currencyInfo.consortiaNewBossCoin.amount;
         }
         if(_data.PayType == 41)
         {
            return PlayerCurrencyManager.instance.currencyInfo.thesepvpMedal.amount;
         }
         if(_data.PayType == 42)
         {
            return PlayerCurrencyManager.instance.currencyInfo.yearGold.amount;
         }
         if(_data.PayType == 43)
         {
            return PlayerCurrencyManager.instance.currencyInfo.yearBoxKey.amount;
         }
         if(_data.PayType == 44)
         {
            return PlayerCurrencyManager.instance.currencyInfo.minosCoin.amount;
         }
         if(_data.PayType == 45)
         {
            return PlayerCurrencyManager.instance.currencyInfo.chessPvpCoin.amount;
         }
         if(_data.PayType == 46)
         {
            return PlayerCurrencyManager.instance.currencyInfo.childNsWarCoin.amount;
         }
         if(_data.PayType == 1033)
         {
            return PlayerCurrencyManager.instance.currencyInfo.gemDust.amount;
         }
         if(_data.PayType == 1034)
         {
            return PlayerCurrencyManager.instance.currencyInfo.theseusshuijing.amount;
         }
         return _loc1_ + playerInfo.point;
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      protected function get shopController() : ShopControler
      {
         return FrameControllerManager.instance.shopController;
      }
      
      protected function __shopResult(param1:SLGSocketEvent) : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4783,__shopResult);
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopCarListMsg = new ShopCarListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ShopCarListMsg;
         if(_callBack != null)
         {
            if(_loc2_.result == 1)
            {
               _callBack(true,_parm);
            }
            else
            {
               _callBack(false,_parm);
            }
         }
         _callBack = null;
      }
      
      protected function refreshLimitView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         var _loc4_:Boolean = false;
         if(_data is LimiteTimeDiscountInfo)
         {
            _loc3_ = _data.limitCount - _data.count;
            if(_loc3_ > 0)
            {
               _canOneText.setFrame(1);
               _canOneText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited08",_loc3_ + "/" + _data.limitCount);
               _loc4_ = true;
            }
            else
            {
               _canOneText.setFrame(2);
               _canOneText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited05");
               _loc4_ = true;
            }
         }
         else
         {
            if(_data.canTotalCount > 0)
            {
               _canTotalText.setFrame(1);
               _canTotalText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited03");
               _canTotalValueText.text = _data.canTotalCount + "";
               _loc1_ = true;
            }
            else if(_data.canTotalCount == -1)
            {
               _canTotalText.text = "";
               _canTotalValueText.text = "";
            }
            else if(_data.canTotalCount == 0)
            {
               _canTotalValueText.text = "";
               _canTotalText.setFrame(2);
               _canTotalText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited");
               _loc1_ = true;
            }
            if(_data.type == 2)
            {
               _loc3_ = _data.limitCount - ShopManager.Instance.count;
               if(_loc3_ > 0)
               {
                  _canOneText.setFrame(1);
                  _canOneText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited06",ShopManager.Instance._refreshTime,_loc3_ + "/" + _data.limitCount);
                  _loc4_ = true;
               }
               else
               {
                  _canOneText.setFrame(2);
                  _canOneText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited05");
                  _loc4_ = true;
               }
            }
            else
            {
               if(_data.canOneCount >= 0)
               {
                  _canOneText.setFrame(1);
                  if(isWeeklyLimit)
                  {
                     _canOneText.text = LanguageMgr.GetTranslation("buyFrame.weeklyLimit.text");
                     if(_data.ShopType == 1027 || _data.ShopType == 1031)
                     {
                        _canOneText.text = LanguageMgr.GetTranslation("ui.theseuspvp.seasonLimit");
                     }
                  }
                  else if(_data.PayType == 1034)
                  {
                     _canOneText.text = LanguageMgr.GetTranslation("TheseusDungeonEventInfo.message15");
                  }
                  else
                  {
                     _canOneText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited04");
                  }
                  if(isWeeklyLimit)
                  {
                     _loc2_ = int(_data.canOneCount);
                     _canOneValueText.text = _loc2_ + "/" + (_data as ShopGoodsInfo).OneDayCount;
                  }
                  else if(!(_data is ShopGoodsInfo))
                  {
                     _loc2_ = _data.oneDayCount - ShopManager.Instance.count;
                     _canOneValueText.text = _loc2_ + "/" + _data.oneDayCount;
                  }
                  else
                  {
                     _loc2_ = _data.canOneCount - ShopManager.Instance.count;
                     _canOneValueText.text = _loc2_ + "/" + _data.OneDayCount;
                  }
                  if(_loc2_ <= 0)
                  {
                     _canOneText.setFrame(2);
                     _canOneValueText.text = "";
                     _canOneText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited05");
                  }
                  _loc4_ = true;
               }
               else if(_data.canOneCount == -1)
               {
                  _canOneText.text = "";
                  _canOneValueText.text = "";
               }
               _notJoinActPrompt.visible = _isuseBindPointBtn.visible = _isUseBindPoint && _selfSelectBtn.selected;
               _isuseBindPointBtn.text = LanguageMgr.GetTranslation("yishi.view.frame.BuyFrameI.priorityUse");
            }
         }
         _canOneValueText.x = _canOneText.x + _canOneText.textWidth + 5;
         updatePrompt();
      }
      
      private function get isWeeklyLimit() : Boolean
      {
         if(_data.hasOwnProperty("ShopType"))
         {
            if(_data.ShopType == 1015 || _data.ShopType == 10 || _data.ShopType == 1008 || _data.ShopType == 1016 || _data.ShopType == 3 || _data.ShopType == 1020 || _data.ShopType == 1021 || _data.ShopType == 1030 || _data.ShopType == 1027 || _data.ShopType == 1031)
            {
               return true;
            }
         }
         return false;
      }
      
      private function updatePrompt() : void
      {
         if(showPrompt == 0)
         {
            _canOneText.visible = true;
            _canOneValueText.visible = true;
         }
         else if(showPrompt == 1)
         {
            _canOneText.visible = false;
            _canOneValueText.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_notJoinActPrompt);
         _notJoinActPrompt = null;
         ObjectUtils.disposeObject(_canTotalText);
         _canTotalText = null;
         ObjectUtils.disposeObject(_canTotalValueText);
         _canTotalValueText = null;
         ObjectUtils.disposeObject(_canOneText);
         _canOneText = null;
         ObjectUtils.disposeObject(_canOneValueText);
         _canOneValueText = null;
         ObjectUtils.disposeObject(_canOneValueText);
         _canOneValueText = null;
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
         ObjectUtils.disposeObject(_friendBack);
         _friendBack = null;
         ObjectUtils.disposeObject(_selfBack);
         _selfBack = null;
         ObjectUtils.disposeObject(_friendConfirmBtn);
         _friendConfirmBtn = null;
         ObjectUtils.disposeObject(_selfConfirmBtn);
         _selfConfirmBtn = null;
         ObjectUtils.disposeObject(_selfAddToShopCartBtn);
         _selfConfirmBtn = null;
         ObjectUtils.disposeObject(_friendSelectBtn);
         _friendSelectBtn = null;
         ObjectUtils.disposeObject(_selfSelectBtn);
         _selfSelectBtn = null;
         ObjectUtils.disposeObject(_selectGroup);
         _selectGroup = null;
         ObjectUtils.disposeObject(_isuseBindPointBtn);
         _isuseBindPointBtn = null;
         ObjectUtils.disposeObject(_activeState);
         _activeState = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         KeyBoardRegister.instance.keyEnable = true;
         if(_discountUI)
         {
            _discountUI.dispose();
            _discountUI = null;
         }
         if(_discountContainer)
         {
            _discountContainer = null;
         }
      }
   }
}

