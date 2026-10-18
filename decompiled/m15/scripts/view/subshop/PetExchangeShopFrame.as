package view.subshop
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.ShopManager;
   import map.campaign.CampaignManager;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import view.GoodsItem6;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.view.component.TileContainer;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class PetExchangeShopFrame extends Frame
   {
      
      public static const PETBOSS_GOODS_ID:int = 2100038;
      
      private var _data:ShopModel;
      
      private var _back:ScaleBitmapImage;
      
      private var _pageNumBack:Image;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _itemList:Vector.<GoodsItem6>;
      
      private var _tileContainer:TileContainer;
      
      private var _moneyImg:ScaleFrameImage;
      
      private var _numTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _crystalloidBtn:SelectedButton;
      
      private var _spiritBtn:SelectedButton;
      
      private var _essenceBtn:SelectedButton;
      
      private var _breathBtn:SelectedButton;
      
      private var _lastSelectedShopGoods:ShopGoodsInfo;
      
      public function PetExchangeShopFrame()
      {
         super();
         initView();
         addEvent();
         if(_group)
         {
            _group.selectIndex = 0;
         }
         else
         {
            initData();
         }
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GoodsItem6 = null;
         _data = FrameControllerManager.instance.shopController.model;
         titleText = LanguageMgr.GetTranslation("PetExchangeShopFrame.title");
         _tileContainer = ComponentFactory.Instance.creatCustomObject("PetExchangeShopFrame.TileContainer");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.helpBtn");
         _pageNumBack = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.TxtBg");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.ComShopFramePageTextStyle");
         _moneyImg = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.MoneyImg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.NumTxt");
         _back = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.Back");
         _crystalloidBtn = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.CrystalloidBtn");
         _spiritBtn = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.SpiritBtn");
         _essenceBtn = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.EssenceBtn");
         _breathBtn = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.BreathBtn");
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_crystalloidBtn);
         _group.addSelectItem(_spiritBtn);
         _group.addSelectItem(_essenceBtn);
         _group.addSelectItem(_breathBtn);
         _helpBtn.y = -78;
         _helpBtn.tipData = LanguageMgr.GetTranslation("PetExchangeShopFrame.HelpBtnTip");
         _itemList = new Vector.<GoodsItem6>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new GoodsItem6();
            _loc1_.clickCallBack = refreshBagCount;
            _tileContainer.appendItem(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         if(_back)
         {
            addToContent(_back);
         }
         addToContent(_tileContainer);
         if(_crystalloidBtn)
         {
            addToContent(_crystalloidBtn);
         }
         if(_spiritBtn)
         {
            addToContent(_spiritBtn);
         }
         if(_essenceBtn)
         {
            addToContent(_essenceBtn);
         }
         if(_breathBtn)
         {
            addToContent(_breathBtn);
         }
         addToContent(_pageNumBack);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageNumTxt);
         addToContent(_moneyImg);
         addToContent(_numTxt);
         _pageNumTxt.text = "1/1";
         _numTxt.text = "1000";
         _numTxt.visible = false;
         _moneyImg.visible = false;
      }
      
      override protected function updateContainerPos() : void
      {
         _container.x = _containerX;
         _container.y = _containerY = 87;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = 495;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         if(_group)
         {
            _group.addEventListener("change",__changeHandler);
         }
         GoodsManager.instance.addEventListener("BAG_FULL",__updateHandler);
         _helpBtn.addEventListener("click",__openHelperFrameHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_data)
         {
            _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         }
         if(_data)
         {
            _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         }
         if(_prePageBtn)
         {
            _prePageBtn.removeEventListener("click",__onPageHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__onPageHandler);
         }
         if(_group)
         {
            _group.removeEventListener("change",__changeHandler);
         }
         GoodsManager.instance.removeEventListener("BAG_FULL",__updateHandler);
         _helpBtn.removeEventListener("click",__openHelperFrameHandler);
      }
      
      private function __openHandler(param1:NotificationEvent) : void
      {
         if(_group)
         {
            _group.selectIndex = 1;
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         initData();
         refreshBagCount(null);
      }
      
      private function __openHelperFrameHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("PetExchangeShopFrame.HelpFrame");
         _loc2_.show();
      }
      
      private function initData() : void
      {
         var _loc1_:int = 0;
         if(_group)
         {
            switch(int(_group.selectIndex))
            {
               case 0:
                  FrameControllerManager.instance.shopController.initPetBossShopFrame();
                  break;
               case 1:
                  FrameControllerManager.instance.shopController.initSpiritShop();
                  break;
               case 2:
                  FrameControllerManager.instance.shopController.initEssenceShop();
                  break;
               case 3:
                  FrameControllerManager.instance.shopController.initBreathShop();
            }
         }
         else
         {
            _loc1_ = int(CampaignManager.instance.mapId);
            FrameControllerManager.instance.shopController.initPetExchangeShopFrame(_loc1_);
         }
      }
      
      private function refreshBagCount(param1:ShopGoodsInfo) : void
      {
         if(isDie)
         {
            return;
         }
         _lastSelectedShopGoods = param1;
         _moneyImg.visible = true;
         _numTxt.visible = true;
         switch(int(_group.selectIndex))
         {
            case 0:
               _moneyImg.setFrame(7);
               _moneyImg.tipData = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType7");
               _numTxt.text = PlayerCurrencyManager.instance.currencyInfo.petCrystal.amount + "";
               break;
            case 1:
               _moneyImg.setFrame(10);
               _moneyImg.tipData = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType8");
               _numTxt.text = PlayerCurrencyManager.instance.currencyInfo.petSpirit.amount + "";
               break;
            case 2:
               _moneyImg.setFrame(9);
               _moneyImg.tipData = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType9");
               _numTxt.text = PlayerCurrencyManager.instance.currencyInfo.petExchangeCoin.amount + "";
               break;
            case 3:
               _moneyImg.setFrame(11);
               _moneyImg.tipData = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType10");
               _numTxt.text = PlayerCurrencyManager.instance.currencyInfo.petBreath.amount + "";
         }
      }
      
      private function __refreshPage(param1:ShopEvent) : void
      {
         _pageNumTxt.text = _data.currentPage + "/" + _data.totalPage;
         _prePageBtn.enable = _data.currentPage != 1;
         _nextPageBtn.enable = _data.currentPage != _data.totalPage;
      }
      
      private function __refreshGoods(param1:ShopEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _itemList[_loc2_].data = _loc2_ < _data.showGoodsList.length ? ShopGoodsInfo(_data.showGoodsList[_loc2_]) : null;
            _loc2_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      private function __updateHandler(param1:BagEvent) : void
      {
         refreshBagCount(_lastSelectedShopGoods);
         for each(var _loc2_:GoodsItem6 in _itemList)
         {
            _loc2_.refreshBtnState();
         }
      }
      
      public function show(param1:Object = null) : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1 && _group)
         {
            _group.selectIndex = int(param1["type"]);
         }
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_pageNumBack);
         _pageNumBack = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_tileContainer);
         _tileContainer = null;
         ObjectUtils.disposeObject(_moneyImg);
         _moneyImg = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_crystalloidBtn);
         _crystalloidBtn = null;
         ObjectUtils.disposeObject(_spiritBtn);
         _spiritBtn = null;
         ObjectUtils.disposeObject(_essenceBtn);
         _essenceBtn = null;
         ObjectUtils.disposeObject(_breathBtn);
         _breathBtn = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         _data = null;
         if(_itemList)
         {
            while(_itemList.length > 0)
            {
               _itemList.pop().dispose();
            }
            _itemList = null;
         }
      }
      
      override public function dispose() : void
      {
         ShopManager.Instance.isPetLand = false;
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

