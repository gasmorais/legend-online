package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
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
   
   public class PvPShopFrame extends Frame
   {
      
      private var _goodsBtn:SelectedButton;
      
      private var _scoreBtn:SelectedButton;
      
      private var _flameTempleBtn:SelectedButton;
      
      private var _duskAreaBtn:SelectedButton;
      
      private var _btGroup:SelectedButtonGroup;
      
      private var _data:ShopModel;
      
      private var _bg:Bitmap;
      
      private var _bg1:Bitmap;
      
      private var _back:ScaleBitmapImage;
      
      private var _signButton:IconButton;
      
      private var _coinImage:ScaleFrameImage;
      
      private var _pvpTipImg:Bitmap;
      
      private var _leagueTipImg:Bitmap;
      
      private var _displayShow:Bitmap;
      
      private var _resetTimeTxt:FilterFrameText;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _itemList:Vector.<GoodsItem>;
      
      private var _helpBtn:BaseButton;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      public function PvPShopFrame()
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
         titleText = LanguageMgr.GetTranslation("pvproomlist.view.AthleticsShopFrame.title");
         _goodsBtn = ComponentFactory.Instance.creatComponentByStylename("shop.pvp.GoodsBtn");
         _scoreBtn = ComponentFactory.Instance.creatComponentByStylename("shop.pvp.ScoreBtn");
         _flameTempleBtn = ComponentFactory.Instance.creatComponentByStylename("shop.pvp.flameTempleBtn");
         _duskAreaBtn = ComponentFactory.Instance.creatComponentByStylename("shop.pvp.duskAreaBtn");
         _bg = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _pvpTipImg = ComponentFactory.Instance.creatBitmap("asset.shop.pvpTipAsset");
         _leagueTipImg = ComponentFactory.Instance.creatBitmap("asset.shop.pvp.ScoreTips");
         _resetTimeTxt = ComponentFactory.Instance.creatComponentByStylename("shop.pvpShopResetTimeTextStyle");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("star.pvpShopHelpBtn");
         _coinImage = ComponentFactory.Instance.creatComponentByStylename("shop.pvp.coinImage");
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
         addToContent(_coinImage);
         addToContent(_resetTimeTxt);
         _resetTimeTxt.visible = false;
         addToContent(_signButton);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageNumTxt);
         addToContent(_pvpTipImg);
         _pvpTipImg.visible = false;
         addToContent(_leagueTipImg);
         _leagueTipImg.visible = false;
         addToContent(_contributeTxt);
         _contributeTxt.x = 115;
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
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         addToContent(_goodsBtn);
         addToContent(_flameTempleBtn);
         addToContent(_duskAreaBtn);
         addToContent(_scoreBtn);
         _btGroup = new SelectedButtonGroup();
         _btGroup.addSelectItem(_goodsBtn);
         _btGroup.addSelectItem(_flameTempleBtn);
         _btGroup.addSelectItem(_duskAreaBtn);
         _btGroup.addSelectItem(_scoreBtn);
         _btGroup.selectIndex = 0;
      }
      
      private function getOutTime() : String
      {
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         _loc1_.setMonth(_loc1_.getMonth() + 1,1);
         return DateFormatter.format(_loc1_,LanguageMgr.GetTranslation("public.dateType","YYYY","M","D"));
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initPVPShopFrame(_btGroup.selectIndex);
      }
      
      private function refreshView() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         _coinImage.setFrame(_btGroup.selectIndex + 1);
         if(_btGroup.selectIndex == 0)
         {
            _pvpTipImg.visible = true;
            _leagueTipImg.visible = false;
            _resetTimeTxt.visible = false;
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.arenaMedal.amount.toString();
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208001);
            _coinImage.tipData = _loc1_.Description;
         }
         else if(_btGroup.selectIndex == 1)
         {
            _pvpTipImg.visible = false;
            _leagueTipImg.visible = false;
            _resetTimeTxt.visible = false;
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.flameTempleCoin.amount.toString();
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208080);
            _coinImage.tipData = _loc1_.Description;
         }
         else if(_btGroup.selectIndex == 2)
         {
            _pvpTipImg.visible = false;
            _leagueTipImg.visible = false;
            _resetTimeTxt.visible = false;
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.duskAreaCoin.amount.toString();
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208081);
            _coinImage.tipData = _loc1_.Description;
         }
         else if(_btGroup.selectIndex == 3)
         {
            _pvpTipImg.visible = false;
            _leagueTipImg.visible = true;
            _resetTimeTxt.visible = true;
            _contributeTxt.text = _playerInfo.crossLeagueMedal.toString();
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-1100);
            _coinImage.tipData = _loc1_.Description;
         }
      }
      
      private function addEvent() : void
      {
         if(_btGroup)
         {
            _btGroup.addEventListener("change",__onTabBtnHandler);
         }
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _signButton.addEventListener("click",__onSignClick);
         _helpBtn.addEventListener("click",__helpHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__updateMedal);
         GoodsManager.instance.addEventListener("DELETE_BAG",__updateMedal);
         _playerInfo.addEventListener("CROSSLEAGUESCOREREFRESH",__leagueScoreRefreshHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateMedal);
      }
      
      private function removeEvent() : void
      {
         if(_btGroup)
         {
            _btGroup.removeEventListener("change",__onTabBtnHandler);
         }
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _signButton.removeEventListener("click",__onSignClick);
         _helpBtn.removeEventListener("click",__helpHandler);
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
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("core.PVPShopHelpFrame");
         _loc2_["show"]();
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
         if(param1 && _btGroup)
         {
            _btGroup.selectIndex = int(param1["type"]);
         }
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

