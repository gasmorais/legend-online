package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.CurrencyInfo;
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
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class ApexShopFrame extends Frame
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
      
      private var _currencyInfo:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
      
      private var frameBg:MutipleImage;
      
      private var _hintTxt:FilterFrameText;
      
      public function ApexShopFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         var _loc7_:Date = null;
         var _loc4_:Object = null;
         var _loc10_:String = null;
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc2_:GoodsItem = null;
         _data = FrameControllerManager.instance.shopController.model;
         frameBg = ComponentFactory.Instance.creatComponentByStylename("shop.ApexShopFrame.bg");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _hintTxt = ComponentFactory.Instance.creatComponentByStylename("shop.apex.hint");
         _pvpIcon = ComponentFactory.Instance.creatBitmap("asset.core.apex.money");
         _displayShowTxt = ComponentFactory.Instance.creatBitmap("asset.shop.apex.moneyStr");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.areslordsShopTip.StripView");
         var _loc1_:CurrencyInfo = PlayerCurrencyManager.instance.currencyInfo.apexCoin;
         if(_loc1_.expiredDate != "2000-01-01 00:00:00")
         {
            _loc7_ = DateFormatter.parse(_loc1_.expiredDate,"YYYY-MM-DD hh:mm:ss");
            _loc4_ = DateFormatter.compareDate(_loc7_,PlayerManager.instance.currentPlayerModel.sysCurtime);
            _loc10_ = _loc7_.month + 1 >= 10 ? _loc7_.month + 1 + "" : "0" + (_loc7_.month + 1);
            _loc3_ = _loc7_.date >= 10 ? _loc7_.date + "" : "0" + _loc7_.date;
            _hintTxt.htmlText = LanguageMgr.GetTranslation("apex.shop.hint",_loc7_.fullYear + "-" + _loc10_ + "-" + _loc3_);
         }
         var _loc9_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4800);
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = _loc9_.Description;
         _pageNumTxt.text = "1/1";
         _contributeTxt.text = _currencyInfo.apexCoin.amount.toString();
         addToContent(frameBg);
         addToContent(_displayShow);
         _displayShow.x = 12;
         _displayShow.y = 434;
         addToContent(_pvpIcon);
         _pvpIcon.x = 14;
         _pvpIcon.y = 437;
         addToContent(_displayShowTxt);
         _displayShowTxt.x = 36;
         _displayShowTxt.y = 441;
         addToContent(_signButton);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageNumTxt);
         addToContent(_contributeTxt);
         addToContent(_hintTxt);
         _contributeTxt.x = 105;
         _contributeTxt.y = 439;
         addToContent(_stripView);
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         _itemList = new Vector.<GoodsItem>();
         _loc6_ = 0;
         while(_loc6_ < 9)
         {
            _loc2_ = new GoodsItem();
            _loc8_ = _loc6_ / 3;
            _loc5_ = _loc6_ % 3;
            _loc2_.x = _loc5_ * _loc2_.width + 7;
            _loc2_.y = _loc8_ * (_loc2_.height + 3) + 5;
            addToContent(_loc2_);
            _itemList.push(_loc2_);
            _loc6_++;
         }
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initApexShopFrame();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _signButton.addEventListener("click",__onSignClick);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _signButton.removeEventListener("click",__onSignClick);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
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
      
      private function __updateGodwinerPoint(param1:NotificationEvent) : void
      {
         _contributeTxt.text = _currencyInfo.apexCoin.amount.toString();
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
         _stripView = null;
         ObjectUtils.disposeObject(frameBg);
         frameBg = null;
         ObjectUtils.disposeObject(_hintTxt);
         _hintTxt = null;
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

