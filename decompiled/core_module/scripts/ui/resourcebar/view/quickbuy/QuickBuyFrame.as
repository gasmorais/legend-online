package ui.resourcebar.view.quickbuy
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.PumpingJoyManager;
   import managers.ShopManager;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class QuickBuyFrame extends Frame
   {
      
      public static const ITEM_NUM:int = 3;
      
      private var _bg:ScaleBitmapImage;
      
      private var _confirmBtn:IconButton;
      
      private var _vBox:VBox;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _selectedItem:BloodItem;
      
      public function QuickBuyFrame()
      {
         super();
         initView();
         addEvent();
         _buttonGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BloodItem = null;
         titleText = LanguageMgr.GetTranslation("mainBar.view.quickbuy.QuickBuyFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.QuickBuyFrameBg");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.confirmBtn");
         _buttonGroup = new SelectedButtonGroup();
         _vBox = new VBox();
         _vBox.x = -4;
         _vBox.y = 10;
         _vBox.spacing = -2;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new BloodItem();
            _loc1_.data = itemList.length > _loc2_ ? itemList[_loc2_] : null;
            _loc1_.buttonMode = true;
            _vBox.addChild(_loc1_);
            _buttonGroup.addSelectItem(_loc1_);
            _loc2_++;
         }
         addToContent(_bg);
         addToContent(_confirmBtn);
         addToContent(_vBox);
      }
      
      private function get itemList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getBloodShopTempInfoList())
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_confirmBtn);
         ObjectUtils.disposeObject(_vBox);
         _bg = null;
         _confirmBtn = null;
         _vBox = null;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buttonGroup.addEventListener("change",__onSelectedChangeHandler);
         _confirmBtn.addEventListener("click",__onConfirmHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_buttonGroup)
         {
            _buttonGroup.removeEventListener("change",__onSelectedChangeHandler);
         }
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__onConfirmHandler);
         }
      }
      
      private function __onConfirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("029",true);
         if(_selectedItem && _selectedItem.data)
         {
            if(payMoney(_selectedItem.data) < _selectedItem.data.price)
            {
               if(_selectedItem.data.PayType == 1)
               {
                  RechargeAlertMannager.show();
               }
               else if(_selectedItem.data.PayType == 3)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("star.view.MakeStarView.command02"));
               }
               else if(_selectedItem.data.PayType == 2)
               {
                  RechargeAlertMannager.show();
               }
               else if(_selectedItem.data.PayType == 6)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.MazeCoinLack"));
               }
               else if(_selectedItem.data.PayType == 5)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.MedalLack"));
               }
               else if(_selectedItem.data.PayType == 4)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.SociatyContribLack"));
               }
               else if(_selectedItem.data.PayType == 15)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.chaosTip"));
               }
               else if(_selectedItem.data.PayType == 16)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.eternalCrystalTip"));
               }
               else if(_selectedItem.data.PayType == 8)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.NotEnoughBackPlayer"));
               }
               else if(_selectedItem.data.PayType == 9)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.fashionPieceTip"));
               }
               else if(_selectedItem.data.PayType == 10)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.sealOfKing"));
               }
               else if(_selectedItem.data.PayType == 7)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.aresHeartTip"));
               }
               else if(_selectedItem.data.PayType == 13)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.athenaTearTip"));
               }
               else if(_selectedItem.data.PayType == 22)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.exploreShopBuyAlertTip"));
               }
               else if(_selectedItem.data.PayType == 28)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.assaultwarShopBuyAlertTip"));
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.MoneyLack"));
               }
               dispose();
               return;
            }
            ShopManager.Instance.sendShopingBloo(_selectedItem.data.Id);
            dispose();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function payMoney(param1:ShopGoodsInfo) : int
      {
         if(param1.PayType == 1)
         {
            return PlayerManager.instance.currentPlayerModel.playerInfo.point;
         }
         if(param1.PayType == 2)
         {
            return PlayerManager.instance.currentPlayerModel.playerInfo.giftToken + PlayerManager.instance.currentPlayerModel.playerInfo.point;
         }
         if(param1.PayType == 3)
         {
            return ResourceManager.instance.gold.count;
         }
         if(param1.PayType == 4)
         {
            return PlayerManager.instance.currentPlayerModel.playerInfo.consortiaOffer;
         }
         if(param1.PayType == 5)
         {
            return GoodsManager.instance.getGoodsNumByTempId(208001);
         }
         if(param1.PayType == 6)
         {
            return GoodsManager.instance.getGoodsNumByTempId(208009);
         }
         if(param1.PayType == 13)
         {
            return PlayerCurrencyManager.instance.currencyInfo.athenaTear.amount;
         }
         if(param1.PayType == 15)
         {
            return PlayerCurrencyManager.instance.currencyInfo.chaos.amount;
         }
         if(param1.PayType == 16)
         {
            return PlayerCurrencyManager.instance.currencyInfo.eternalCrystal.amount;
         }
         if(param1.PayType == 8)
         {
            return GoodsManager.instance.getGoodsNumByTempId(2125048);
         }
         if(param1.PayType == 9)
         {
            return GoodsManager.instance.getGoodsNumByTempId(param1.NeedItem);
         }
         if(param1.PayType == 7)
         {
            return PlayerCurrencyManager.instance.currencyInfo.aresHeart.amount;
         }
         if(param1.PayType == 22)
         {
            return PlayerCurrencyManager.instance.currencyInfo.exploreMedal.amount;
         }
         if(param1.PayType == 28)
         {
            return PlayerCurrencyManager.instance.currencyInfo.assaultwarMedal.amount;
         }
         if(param1.PayType == 2001)
         {
            return PumpingJoyManager.instance.model.totalScore;
         }
         return PlayerManager.instance.currentPlayerModel.playerInfo.point;
      }
      
      private function __onSelectedChangeHandler(param1:Event) : void
      {
         _selectedItem = _buttonGroup.getSelectedItem() as BloodItem;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

