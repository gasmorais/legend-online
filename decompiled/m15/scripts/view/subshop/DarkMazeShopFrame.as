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
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import view.GoodsItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class DarkMazeShopFrame extends Frame
   {
      
      private var _data:ShopModel;
      
      private var _bg:MutipleImage;
      
      private var _back:ScaleBitmapImage;
      
      private var _displayShow:Bitmap;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _itemList:Vector.<GoodsItem>;
      
      private var _hasNum:FilterFrameText;
      
      private var _sealOfKingImg:MutipleImage;
      
      private var _stripView:StripView;
      
      private var _resetTimeTxt:FilterFrameText;
      
      public function DarkMazeShopFrame()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:GoodsItem = null;
         _data = FrameControllerManager.instance.shopController.model;
         _itemList = new Vector.<GoodsItem>();
         titleText = LanguageMgr.GetTranslation("view.subshop.DarkMazeShopFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBG03");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _hasNum = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _resetTimeTxt = ComponentFactory.Instance.creatComponentByStylename("shop.darkmazeShopResetTimeTextStyle");
         _sealOfKingImg = ComponentFactory.Instance.creatComponentByStylename("shop.darkmaze.darkMazeCoin");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.CrossPvPShopFrame.StripView");
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-17000);
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = _loc5_.Description;
         _pageNumTxt.text = "1/1";
         addToContent(_back);
         addToContent(_bg);
         _bg.x = 7;
         _bg.y = 5;
         addToContent(_displayShow);
         _displayShow.x = 12;
         _displayShow.y = 434;
         addToContent(_pageNumTxt);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_sealOfKingImg);
         addToContent(_hasNum);
         addToContent(_stripView);
         addToContent(_resetTimeTxt);
         _hasNum.text = PlayerCurrencyManager.instance.currencyInfo.darkmazeSoulCoin.amount + "";
         _hasNum.x = 101;
         _hasNum.y = 441;
         _resetTimeTxt.htmlText = LanguageMgr.GetTranslation("view.subshop.DarkMazeShopFrame",getOutTime());
         var _loc4_:int = 0;
         var _loc2_:int = 0;
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
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _prePageBtn.addEventListener("click",__prePageBtnHandler);
         _nextPageBtn.addEventListener("click",__nextPageBtnHandler);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("CROSSGUILDSCOREREFRESH",__refreshScore);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__refreshScore);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _prePageBtn.removeEventListener("click",__prePageBtnHandler);
         _nextPageBtn.removeEventListener("click",__nextPageBtnHandler);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("CROSSGUILDSCOREREFRESH",__refreshScore);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__refreshScore);
      }
      
      private function getOutTime() : String
      {
         var _loc2_:Date = DarkMazeManager.instance.model.endGameDate;
         var _loc1_:Date = new Date();
         _loc1_.time = _loc2_.time + 604800000;
         return DateFormatter.format(_loc1_,"YYYY-MM-DD hh:mm:ss");
      }
      
      private function __refreshScore(param1:Event) : void
      {
         _hasNum.text = PlayerCurrencyManager.instance.currencyInfo.darkmazeSoulCoin.amount + "";
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initDarkMazeShopFrame();
      }
      
      private function __prePageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      private function __nextPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
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
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_hasNum);
         _hasNum = null;
         ObjectUtils.disposeObject(_sealOfKingImg);
         _sealOfKingImg = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(_resetTimeTxt);
         _resetTimeTxt = null;
         ObjectUtils.disposeAllChildren(this);
         KeyBoardRegister.instance.keyEnable = true;
         super.dispose();
      }
   }
}

