package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
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
   import utils.LogicUtils;
   import view.GoodsItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class AssaultwarShopFrame extends Frame
   {
      
      private var _data:ShopModel;
      
      private var _bg:MutipleImage;
      
      private var _back:ScaleBitmapImage;
      
      private var _signButton:IconButton;
      
      private var _displayShow:Bitmap;
      
      private var _pvpIcon:Bitmap;
      
      private var _displayShowTxt:Bitmap;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _stripView:StripView;
      
      private var _itemList:Vector.<GoodsItem>;
      
      private var _currencyInfo:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
      
      public function AssaultwarShopFrame()
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
         titleText = LanguageMgr.GetTranslation("view.subshop.assaultwarShopFrame.str01");
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBG");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _pvpIcon = ComponentFactory.Instance.creatBitmap("asset.core.assaultwarMedal");
         _displayShowTxt = ComponentFactory.Instance.creatBitmap("asset.shop.assaultwarMedalShowTxt");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.bravelegShopTip.StripView");
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4400);
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = _loc5_.Description;
         _pageNumTxt.text = "1/1";
         _contributeTxt.text = _currencyInfo.assaultwarMedal.amount.toString();
         addToContent(_back);
         addToContent(_bg);
         _bg.x = 7;
         _bg.y = 5;
         addToContent(_displayShow);
         _displayShow.x = 12;
         _displayShow.y = 434;
         addToContent(_pvpIcon);
         _pvpIcon.x = 16;
         _pvpIcon.y = 439;
         addToContent(_displayShowTxt);
         _displayShowTxt.x = 42;
         _displayShowTxt.y = 438;
         addToContent(_signButton);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageNumTxt);
         addToContent(_contributeTxt);
         _contributeTxt.x = 105;
         _contributeTxt.y = 439;
         addToContent(_stripView);
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
         FrameControllerManager.instance.shopController.initAssaultwarShopFrame();
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
         _contributeTxt.text = _currencyInfo.assaultwarMedal.amount.toString();
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
         KeyBoardRegister.instance.keyEnable = true;
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
         _stripView = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

