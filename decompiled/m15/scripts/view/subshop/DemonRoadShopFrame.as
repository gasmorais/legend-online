package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import view.GoodsItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class DemonRoadShopFrame extends Frame
   {
      
      private var _data:ShopModel;
      
      private var _signButton:IconButton;
      
      private var _displayShow:Bitmap;
      
      private var _pvpIcon:Bitmap;
      
      private var _displayShowTxt:Bitmap;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _stripView:StripView;
      
      private var _itemList:Vector.<GoodsItem>;
      
      private var _bg:MutipleImage;
      
      private var _back:ScaleBitmapImage;
      
      private var _exchangeBtn:TextButton;
      
      private var _currencyInfo:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
      
      private var _helpBtn:BaseButton;
      
      public function DemonRoadShopFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:GoodsItem = null;
         _data = FrameControllerManager.instance.shopController.model;
         titleText = LanguageMgr.GetTranslation("demonroad.shop.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBG");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _pvpIcon = ComponentFactory.Instance.creatBitmap("asset.shop.demonroadIcon");
         _displayShowTxt = ComponentFactory.Instance.creatBitmap("asset.shop.demonroad.iconStr");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.areslordsShopTip.StripView");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("shop.demonroadShop.exchangeBtn");
         _exchangeBtn.text = LanguageMgr.GetTranslation("demonroad.shop.solveTitle");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("shop.demonroadShop.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("demonroad.shop.HelpBtn");
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-16000);
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = _loc5_.Description;
         _pageNumTxt.text = "1/1";
         _contributeTxt.text = _currencyInfo.demonroadCoin.amount.toString();
         addToContent(_back);
         addToContent(_bg);
         _bg.x = 7;
         _bg.y = 5;
         addToContent(_displayShow);
         _displayShow.x = 12;
         _displayShow.y = 434;
         addToContent(_pvpIcon);
         addToContent(_displayShowTxt);
         _displayShowTxt.x = 36;
         _displayShowTxt.y = 441;
         addToContent(_signButton);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageNumTxt);
         addToContent(_contributeTxt);
         _contributeTxt.x = 105;
         _contributeTxt.y = 439;
         addToContent(_stripView);
         addToContent(_exchangeBtn);
         addToContent(_helpBtn);
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _itemList = new Vector.<GoodsItem>();
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc1_ = new GoodsItem();
            _loc4_ = _loc3_ / 3;
            _loc2_ = _loc3_ % 3;
            _loc1_.x = _loc2_ * _loc1_.width + 7;
            _loc1_.y = _loc4_ * (_loc1_.height + 3) + 5;
            addToContent(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initdDemonShopFrame();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _signButton.addEventListener("click",__onSignClick);
         _exchangeBtn.addEventListener("click",exchangeHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updatePoint);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _signButton.removeEventListener("click",__onSignClick);
         _exchangeBtn.removeEventListener("click",exchangeHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updatePoint);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("shop.demonroadShop.helperFrame");
         _loc2_.show();
      }
      
      private function exchangeHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("demonroadshop");
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
         _data.showGoodsList.sortOn("Sort",16);
         _loc2_ = 0;
         while(_loc2_ < 9)
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
      
      private function __updatePoint(param1:NotificationEvent) : void
      {
         _contributeTxt.text = _currencyInfo.demonroadCoin.amount.toString();
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _data = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_displayShow);
         _displayShow = null;
         ObjectUtils.disposeObject(_signButton);
         _signButton = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_contributeTxt);
         _contributeTxt = null;
         ObjectUtils.disposeObject(_pvpIcon);
         _pvpIcon = null;
         ObjectUtils.disposeObject(_displayShowTxt);
         _displayShowTxt = null;
         ObjectUtils.disposeObject(_stripView);
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         _stripView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         if(_itemList)
         {
            while(_itemList.length)
            {
               ObjectUtils.disposeObject(_itemList.pop());
            }
            _itemList = null;
         }
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

