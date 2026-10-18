package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
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
   import managers.PlayerCurrencyManager;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import view.GoodsItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class OutyardShopFrame extends Frame
   {
      
      private var _data:ShopModel;
      
      private var _bg:Bitmap;
      
      private var _bg1:Bitmap;
      
      private var _back:ScaleBitmapImage;
      
      private var _signButton:IconButton;
      
      private var _pvpTipImg:Bitmap;
      
      private var _leagueTipImg:Bitmap;
      
      private var _displayShow:Bitmap;
      
      private var _pvpIcon:Bitmap;
      
      private var _leagueMedalIcon:Bitmap;
      
      private var pokerScoreTxt:Bitmap;
      
      private var _leagueShowTxt:Bitmap;
      
      private var _resetTimeTxt:FilterFrameText;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _itemList:Vector.<GoodsItem>;
      
      private var _stripView:StripView;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      public function OutyardShopFrame()
      {
         super();
         initView();
         addEvent();
         initData();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:GoodsItem = null;
         _data = FrameControllerManager.instance.shopController.model;
         titleText = LanguageMgr.GetTranslation("view.subshop.OutyardShopFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _pvpIcon = ComponentFactory.Instance.creatBitmap("asset.core.outyardImg");
         _leagueMedalIcon = ComponentFactory.Instance.creatBitmap("asset.core.LeagueMedalIcon");
         pokerScoreTxt = ComponentFactory.Instance.creatBitmap("asset.core.outyardImgIcon");
         _leagueShowTxt = ComponentFactory.Instance.creatBitmap("asset.shop.pvp.ScoreName");
         _pvpTipImg = ComponentFactory.Instance.creatBitmap("asset.shop.pvpTipAsset");
         _leagueTipImg = ComponentFactory.Instance.creatBitmap("asset.shop.pvp.ScoreTips");
         _resetTimeTxt = ComponentFactory.Instance.creatComponentByStylename("shop.pvpShopResetTimeTextStyle");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.outyardScoreTip.StripView");
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-3400);
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = _loc5_.Description;
         _pageNumTxt.text = "1/1";
         _resetTimeTxt.text = getOutTime();
         addToContent(_bg1);
         _bg1.x = 10;
         _bg.y = 0;
         _bg1.y = 0;
         addToContent(_bg);
         _bg.scaleX = -1;
         _bg.x = 2 * _bg1.width + 10;
         addToContent(_back);
         addToContent(_displayShow);
         _displayShow.x = 11;
         _displayShow.y = 426;
         addToContent(_pvpIcon);
         _pvpIcon.x = 16;
         _pvpIcon.y = 433;
         _pvpIcon.visible = false;
         addToContent(_leagueMedalIcon);
         _leagueMedalIcon.x = -15;
         _leagueMedalIcon.y = 430;
         _leagueMedalIcon.visible = false;
         addToContent(pokerScoreTxt);
         pokerScoreTxt.x = 39;
         pokerScoreTxt.y = 429;
         pokerScoreTxt.visible = false;
         addToContent(_leagueShowTxt);
         _leagueShowTxt.visible = false;
         addToContent(_resetTimeTxt);
         _resetTimeTxt.visible = false;
         addToContent(_signButton);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageNumTxt);
         addToContent(_leagueTipImg);
         _leagueTipImg.visible = false;
         addToContent(_contributeTxt);
         _contributeTxt.x = 115;
         addToContent(_stripView);
         _stripView.x = 11;
         _stripView.y = 431;
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
      
      private function getOutTime() : String
      {
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         _loc1_.month += 1;
         _loc1_.date = 1;
         return DateFormatter.format(_loc1_,LanguageMgr.GetTranslation("public.dateType","YYYY","M","D"));
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initOutyardFrame();
      }
      
      private function refreshView() : void
      {
         _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.outyardCoin.amount + "";
         _pvpIcon.visible = true;
         pokerScoreTxt.visible = true;
         _pvpTipImg.visible = true;
         _leagueMedalIcon.visible = false;
         _leagueShowTxt.visible = false;
         _leagueTipImg.visible = false;
         _resetTimeTxt.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _signButton.addEventListener("click",__onSignClick);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__updateMedal);
         GoodsManager.instance.addEventListener("DELETE_BAG",__updateMedal);
         _playerInfo.addEventListener("CROSSLEAGUESCOREREFRESH",__leagueScoreRefreshHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateMedal);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _signButton.removeEventListener("click",__onSignClick);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__updateMedal);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__updateMedal);
         _playerInfo.removeEventListener("CROSSLEAGUESCOREREFRESH",__leagueScoreRefreshHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateMedal);
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         initData();
         refreshView();
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
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __leagueScoreRefreshHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function __updateMedal(param1:Event) : void
      {
         refreshView();
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      public function show(param1:Object = null) : void
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
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

