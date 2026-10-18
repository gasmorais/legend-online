package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.PlayerCurrencyManager;
   import managers.ShopManager;
   import managers.VIPManager;
   import mvc.module.mounts.WildSoulInfo;
   import mvc.module.shop.MainShopInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.StarTemplate;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.StarManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class NumBuyFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _icon:BaseItemView;
      
      private var _starIcon:BaseIconView;
      
      private var _itemName:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _deleteBtn:BaseButton;
      
      private var _buyNumTxt:FilterFrameText;
      
      private var _isuseBindPointBtn:SelectedCheckButton;
      
      private var _buyBtn:IconButton;
      
      private var _hbox:HBox;
      
      private var _data:*;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      private var _goodsInfo:GoodsInfo;
      
      private var _buyNum:int = 1;
      
      private var _pointTxt:PriceItem;
      
      private var _scoreTxt:PriceItem;
      
      private var _canBuyMaxNum:int;
      
      private var _notJoinActTxt:FilterFrameText;
      
      private var _vipShopDiscountScore:int;
      
      public function NumBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("numbuy.BuyFrameBg");
         _itemName = ComponentFactory.Instance.creatComponentByStylename("numbuy.BuyGoodsNameStyle");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("numbuy.AddButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("numbuy.DeleteButton");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("numbuy.BuyNumTextStyle");
         _isuseBindPointBtn = ComponentFactory.Instance.creatComponentByStylename("numbuy.useBindPointBtn");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("numbuy.buyBtn");
         _notJoinActTxt = ComponentFactory.Instance.creatComponentByStylename("numbuy.useBindPoint_notJoinActTxt");
         _hbox = new HBox();
         _hbox.spacing = 10;
         _hbox.x = 96;
         _hbox.y = 98;
         addToContent(_bg);
         _bg.setChildVisible(2,false);
         addToContent(_addBtn);
         addToContent(_deleteBtn);
         addToContent(_isuseBindPointBtn);
         addToContent(_itemName);
         addToContent(_buyNumTxt);
         _buyNumTxt.text = _buyNum + "";
         addToContent(_buyBtn);
         addToContent(_hbox);
         addToContent(_notJoinActTxt);
         _notJoinActTxt.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.promptTxt");
         titleText = LanguageMgr.GetTranslation("yishi.view.frame.NumBuyFrame.title");
         _isuseBindPointBtn.text = LanguageMgr.GetTranslation("yishi.view.frame.BuyFrameI.priorityUse");
         _deleteBtn.enable = false;
         _isuseBindPointBtn.selected = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buyBtn.addEventListener("click",__buyBtnHandler);
         _addBtn.addEventListener("click",__addBtnHandler);
         _deleteBtn.addEventListener("click",__deleteBtnHandler);
         _buyNumTxt.addEventListener("change",__buyNumChange);
         _buyNumTxt.addEventListener("keyDown",__onKeydownHandler);
         _isuseBindPointBtn.addEventListener("select",__useBindPointBtnChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _buyBtn.removeEventListener("click",__buyBtnHandler);
         _addBtn.removeEventListener("click",__addBtnHandler);
         _deleteBtn.removeEventListener("click",__deleteBtnHandler);
         _buyNumTxt.removeEventListener("change",__buyNumChange);
         _buyNumTxt.removeEventListener("keyDown",__onKeydownHandler);
         _isuseBindPointBtn.removeEventListener("select",__useBindPointBtnChange);
      }
      
      private function __buyBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:WildSoulInfo = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(_pointTxt)
         {
            if(_pointTxt.getFrame() == 2)
            {
               RechargeAlertMannager.show();
               dispose();
               return;
            }
         }
         if(_scoreTxt)
         {
            if(_scoreTxt.getFrame() == 2)
            {
               if(_data.ShopType == 1033)
               {
                  _loc2_ = LanguageMgr.GetTranslation("vip.vipShop.item.tip02");
               }
               else
               {
                  _loc2_ = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData2");
               }
               MessageTipManager.instance().show(_loc2_);
               dispose();
               return;
            }
         }
         if(_data is ShopGoodsInfo)
         {
            if(_goodsTempInfo.SonType == 218)
            {
               _loc3_ = MountsManager.instance.avatarList.getWildSoulInfo(_goodsTempInfo.Property1);
               if(_loc3_ && _loc3_.validity < 0 && _goodsTempInfo.Property2 < 0)
               {
                  _loc4_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst");
                  MessageTipManager.instance().show(_loc4_);
                  _buyBtn.enable = false;
                  return;
               }
            }
            if(_data is MainShopInfo)
            {
               ShopManager.Instance.buyOne((_data as MainShopInfo).id,_buyNum,playerInfo.userId,_data.PayType,false);
            }
            else
            {
               ShopManager.Instance.buyOne((_data as ShopGoodsInfo).Id,_buyNum,playerInfo.userId,_data.PayType,false);
            }
         }
         else if(_data is StarTemplate)
         {
            _loc5_ = 0;
            while(_loc5_ < _buyNum)
            {
               StarManager.instance.sendExchangeStar(_data.TemplateId);
               _loc5_++;
            }
         }
         dispose();
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __addBtnHandler(param1:MouseEvent) : void
      {
         _buyNum = _buyNum + 1;
         refreshView();
      }
      
      private function getMaxBuynum() : int
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         if(_data is ShopGoodsInfo)
         {
            switch(_data.ShopType)
            {
               case 8:
               case 15:
                  switch(_data.NeedItem)
                  {
                     case 3101011:
                        _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petFireCream.amount / _data.Score;
                        break;
                     case 3101021:
                        _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petWaterCream.amount / _data.Score;
                        break;
                     case 3101031:
                        _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petElectricCream.amount / _data.Score;
                        break;
                     case 3101041:
                        _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petWindCream.amount / _data.Score;
                        break;
                     case 3101071:
                        _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petExchangeCoin.amount / _data.Score;
                        break;
                     case 2100038:
                        _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petCrystal.amount / _data.Score;
                        break;
                     case 3101081:
                        _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petSpirit.amount / _data.Score;
                        break;
                     case 3101091:
                        _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petBreath.amount / _data.Score;
                        break;
                     default:
                        _loc2_ = GoodsManager.instance.getGoodsNumByTempId(_data.NeedItem);
                  }
                  break;
               case 1033:
                  _loc2_ = PlayerCurrencyManager.instance.currencyInfo.gemDust.amount / _vipShopDiscountScore;
                  break;
               default:
                  _loc5_ = FrameControllerManager.instance.mysteryShopController.model.consumePoints / _data.Score;
                  if(_data.GiftToken > 0)
                  {
                     _loc1_ = PlayerManager.instance.currentPlayerModel.playerInfo.point;
                     if(_isuseBindPointBtn.selected)
                     {
                        _loc1_ = PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
                     }
                     _loc4_ = _loc1_ / _data.GiftToken;
                     _loc2_ = Math.min(_loc5_,_loc4_);
                  }
                  else
                  {
                     _loc2_ = _loc5_;
                     _isuseBindPointBtn.visible = false;
                     _notJoinActTxt.visible = false;
                  }
            }
         }
         else if(_data is StarTemplate)
         {
            _loc3_ = PlayerManager.instance.currentPlayerModel.playerInfo.starPoint / _data.StarPoint;
            _loc6_ = StarManager.instance.getStarPlayerBagCellNum();
            _loc2_ = Math.min(_loc6_,_loc3_);
            _isuseBindPointBtn.visible = false;
            _notJoinActTxt.visible = false;
         }
         return Math.max(1,_loc2_);
      }
      
      private function __deleteBtnHandler(param1:MouseEvent) : void
      {
         _buyNum = _buyNum - 1;
         refreshView();
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         _buyNum = int(_buyNumTxt.text);
         refreshView();
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __buyBtnHandler(null);
         }
      }
      
      private function __useBindPointBtnChange(param1:Event) : void
      {
         refreshView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _buyNumTxt;
      }
      
      private function get vipShopDiscount() : Number
      {
         var _loc2_:Number = NaN;
         var _loc1_:int = VIPManager.Instance.model.vipInfo.VipShopLevel;
         _loc2_ = Number(_data["VIP" + _loc1_ + "Count"]);
         if(_loc2_ == -1)
         {
            _loc2_ = 100;
         }
         return _loc2_;
      }
      
      public function set data(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc3_:StarInfo = null;
         _data = param1;
         if(_data is ShopGoodsInfo)
         {
            if(_data.ShopType == 1033)
            {
               _vipShopDiscountScore = _data.Score * vipShopDiscount / 100;
            }
            _icon = ComponentFactory.Instance.creatCustomObject("numbuy.BuyBaseItemView");
            addToContent(_icon);
            if(_data.Point != 0)
            {
               _pointTxt = new PriceItem();
               _pointTxt.show(_data.Point);
               _hbox.addChild(_pointTxt);
            }
            else if(_data.GiftToken != 0)
            {
               _pointTxt = new PriceItem();
               _pointTxt.show(_data.GiftToken);
               _hbox.addChild(_pointTxt);
            }
            if(_data.Score > 0)
            {
               _scoreTxt = new PriceItem();
               switch(_data.ShopType)
               {
                  case 8:
                     _loc2_ = _data.PayType - 1001 + 1;
                     _scoreTxt.show(_data.Score,2,_loc2_);
                     break;
                  case 15:
                     _scoreTxt.show(_data.Score,2,7);
                     break;
                  case 1033:
                     _scoreTxt.show(_vipShopDiscountScore,7);
                     break;
                  default:
                     _scoreTxt.show(_data.Score,1);
               }
               _hbox.addChild(_scoreTxt);
            }
            _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
            if(_goodsTempInfo.SonType == 218)
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
            _goodsInfo = new GoodsInfo();
            _goodsInfo.templateId = _goodsTempInfo.TemplateId;
            _goodsInfo.validDate = _data.ValidDate;
            _icon.data = _goodsInfo;
            _itemName.text = _goodsTempInfo.TemplateName;
         }
         else if(_data is StarTemplate)
         {
            _starIcon = ComponentFactory.Instance.creatCustomObject("numbuy.StarShopItemIcon");
            addToContent(_starIcon);
            if(_data.StarPoint > 0)
            {
               _scoreTxt = new PriceItem();
               _scoreTxt.show(_data.StarPoint,1);
               _hbox.addChild(_scoreTxt);
            }
            _loc3_ = new StarInfo();
            _loc3_.template = _data;
            _loc3_.bagType = 0;
            _loc3_.grade = 1;
            _starIcon.icon = IconFactory.getCommonIconPath(_data.Icon);
            _starIcon.tipData = _loc3_;
            _itemName.text = _data.TemplateName;
         }
         if(_data is ShopGoodsInfo && (_data.ShopType == 8 || _data.ShopType == 15))
         {
            _bg.setChildVisible(1,false);
            _bg.setChildVisible(2,true);
         }
         else
         {
            _bg.setChildVisible(1,true);
            _bg.setChildVisible(2,false);
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         _canBuyMaxNum = getMaxBuynum();
         _addBtn.enable = true;
         _deleteBtn.enable = true;
         if(_buyNum >= _canBuyMaxNum)
         {
            _buyNum = _canBuyMaxNum;
            _addBtn.enable = false;
         }
         if(_buyNum <= 1)
         {
            _buyNum = 1;
            _deleteBtn.enable = false;
         }
         _buyNumTxt.text = _buyNum + "";
         if(_data is ShopGoodsInfo)
         {
            if(_data.Point != 0)
            {
               _pointTxt.setPrice(_buyNum * _data.Point);
            }
            else if(_data.GiftToken != 0)
            {
               _pointTxt.setPrice(_buyNum * _data.GiftToken);
            }
            else
            {
               _isuseBindPointBtn.visible = false;
               _notJoinActTxt.visible = false;
            }
            if(_data.Score > 0)
            {
               if(_data.ShopType == 1033)
               {
                  _scoreTxt.setPrice(_buyNum * _vipShopDiscountScore);
               }
               else
               {
                  _scoreTxt.setPrice(_buyNum * _data.Score);
               }
            }
         }
         else if(_data is StarTemplate)
         {
            if(_data.StarPoint)
            {
               _scoreTxt.setPrice(_buyNum * _data.StarPoint);
            }
         }
         numChange();
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
         }
      }
      
      private function numChange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_pointTxt)
         {
            _loc1_ = PlayerManager.instance.currentPlayerModel.playerInfo.point;
            if(_isuseBindPointBtn.selected)
            {
               _loc1_ = PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
            }
            if(_pointTxt.price > _loc1_)
            {
               _pointTxt.setFrame(2);
            }
            else
            {
               _pointTxt.setFrame(1);
            }
         }
         if(_scoreTxt)
         {
            if(_data is ShopGoodsInfo)
            {
               switch(_data.ShopType)
               {
                  case 8:
                     switch(_data.NeedItem)
                     {
                        case 3101011:
                           _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petFireCream.amount;
                           break;
                        case 3101021:
                           _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petWaterCream.amount;
                           break;
                        case 3101031:
                           _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petElectricCream.amount;
                           break;
                        case 3101041:
                           _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petWindCream.amount;
                           break;
                        case 3101071:
                           _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petExchangeCoin.amount;
                           break;
                        case 3101081:
                           _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petSpirit.amount;
                           break;
                        case 3101091:
                           _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petBreath.amount;
                     }
                     break;
                  case 15:
                     _loc2_ = PlayerCurrencyManager.instance.currencyInfo.petCrystal.amount;
                     break;
                  case 1033:
                     _loc2_ = PlayerCurrencyManager.instance.currencyInfo.gemDust.amount;
                     break;
                  default:
                     _loc2_ = FrameControllerManager.instance.mysteryShopController.model.consumePoints;
               }
            }
            else if(_data is StarTemplate)
            {
               _loc2_ = PlayerManager.instance.currentPlayerModel.playerInfo.starPoint;
            }
            if(_scoreTxt.price > _loc2_)
            {
               _scoreTxt.setFrame(2);
            }
            else
            {
               _scoreTxt.setFrame(1);
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _buyNum = 1;
         _goodsTempInfo = null;
         _goodsInfo = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_itemName);
         _itemName = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         ObjectUtils.disposeObject(_buyNumTxt);
         _buyNumTxt = null;
         ObjectUtils.disposeObject(_isuseBindPointBtn);
         _isuseBindPointBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_notJoinActTxt);
         _notJoinActTxt = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

