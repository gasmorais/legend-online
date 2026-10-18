package auction.view.mysteryshop
{
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MysteryShopEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import manager.LanguageMgr;
   import managers.MysteryShopManager;
   import mvc.controler.MysteryShopControler;
   import mvc.module.auction.BuyGoodsInfo;
   import mvc.module.auction.MysteryShopEventInfo;
   import mvc.module.auction.MysteryShopModel;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MysteryShopFrame extends Frame implements IManualSize
   {
      
      private var _helpBtn:BaseButton;
      
      private var _canBuyCount:int;
      
      private var _buttongroup:SelectedButtonGroup;
      
      private var _page1:SelectedIconButton;
      
      private var _page2:SelectedIconButton;
      
      private var _frameLeftBackBg:Scale9CornerImage;
      
      private var _frameRightBackBg:Scale9CornerImage;
      
      private var _leftBack:MutipleImage;
      
      private var _rightBack:Scale9CornerImage;
      
      private var _projectRareItem:MutipleImage;
      
      private var _projectLuckyPlayer:MutipleImage;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _bottomBg:MutipleImage;
      
      private var _dailyCountTxt:FilterFrameText;
      
      private var _countTimeTxt:Bitmap;
      
      private var _countTime:TimeDownView;
      
      private var _quickRefreshBtn:IconButton;
      
      private var _consumePointsBg:MutipleImage;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _goodsListContainer:Sprite;
      
      private var _rareGoodsListContainer:Sprite;
      
      private var _exchangeGoodsListContainer:Sprite;
      
      private var _buyGoodsList:Vector.<BuyGoodsItem>;
      
      private var _rareGoodsList:Vector.<BaseItemView>;
      
      private var _exchangeGoodsList:Vector.<ExchangeGoodsItem>;
      
      private var _consumePointsTxt:FilterFrameText;
      
      private var _buyTipTxt:Bitmap;
      
      public function MysteryShopFrame()
      {
         super();
         initView();
         initData();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,774,500);
      }
      
      private function initView() : void
      {
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopHelpBtn");
         _buyGoodsList = new Vector.<BuyGoodsItem>();
         _rareGoodsList = new Vector.<BaseItemView>();
         _exchangeGoodsList = new Vector.<ExchangeGoodsItem>();
         _buttongroup = new SelectedButtonGroup();
         _page1 = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.SelectBuyItemBtn");
         _page2 = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.SelectExchangeItemBtn");
         _buttongroup.addSelectItem(_page1);
         _buttongroup.addSelectItem(_page2);
         _buttongroup.selectIndex = 0;
         _frameLeftBackBg = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrameLeftBackBg");
         _frameRightBackBg = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrameRightBackBg");
         _leftBack = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.LeftBack");
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.RightBack");
         _projectRareItem = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.ProjectRareItem");
         _projectLuckyPlayer = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.ProjectLuckyPlayer");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.Vbox");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.BottomBg");
         _dailyCountTxt = ComponentFactory.Instance.creatComponentByStylename("auction.DailyCountTxt");
         _countTimeTxt = ComponentFactory.Instance.creatBitmap("asset.auction.LeftTimeTxt");
         _countTime = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopBuyUpdateTime");
         _quickRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopQuickRefreshBtn");
         _quickRefreshBtn.tipData = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyTimeView.quickRefreshTip",mysteryShopModel.refreshRewardNeedPay);
         _consumePointsBg = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.ConsumePointsBg");
         _consumePointsTxt = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.PageTextStyle");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.PageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.LastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopFrame.NextPageBtn");
         _buyTipTxt = ComponentFactory.Instance.creatBitmap("asset.auction.BuyTipTxt");
         _goodsListContainer = new Sprite();
         _goodsListContainer.x = 230;
         _goodsListContainer.y = 37;
         _rareGoodsListContainer = new Sprite();
         _rareGoodsListContainer.x = 0;
         _rareGoodsListContainer.y = 30;
         _exchangeGoodsListContainer = new Sprite();
         _exchangeGoodsListContainer.x = 230;
         _exchangeGoodsListContainer.y = 37;
         addToContent(_frameLeftBackBg);
         addToContent(_frameRightBackBg);
         addToContent(_leftBack);
         addToContent(_rightBack);
         addToContent(_projectRareItem);
         addToContent(_projectLuckyPlayer);
         addToContent(_scrolPanel);
         addToContent(_page1);
         addToContent(_page2);
         addToContent(_bottomBg);
         addToContent(_consumePointsBg);
         addToContent(_consumePointsTxt);
         _consumePointsTxt.x = 320;
         _consumePointsTxt.y = 358;
         addToContent(_dailyCountTxt);
         addToContent(_countTimeTxt);
         addToContent(_countTime);
         addToContent(_buyTipTxt);
         addToContent(_quickRefreshBtn);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_lastPageBtn);
         addToContent(_nextPageBtn);
         addToContent(_goodsListContainer);
         addToContent(_rareGoodsListContainer);
         addToContent(_exchangeGoodsListContainer);
         addToContent(_helpBtn);
         _helpBtn.tipData = LanguageMgr.GetTranslation("auction.view.mysteryshop.MysteryShopFrame.HelpBtn.Tipdata");
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox,true);
         _scrolPanel.invalidateViewport();
         createGoodsList();
         createRareGoodsList();
         createExchangeGoodsList();
         showCaseBagTip();
      }
      
      private function initData() : void
      {
         if(!mysteryShopModel.remainTime || mysteryShopModel.remainTime == 0)
         {
            mysteryShopManager.sendRefreshGoodsList(false);
         }
         _countTime.timeCount = mysteryShopModel.remainTime;
         mysteryShopControler.initRareGoodsData();
         mysteryShopControler.initExchangeGoodsData();
         updateGoodsListData();
         updateRareGoodsListData();
         __refreshCountView(null);
         __refreshPointsView(null);
         __refreshLuckyPlayerListHandler(null);
         __refreshPageView(null);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _page1.addEventListener("click",__pageIClick);
         _page2.addEventListener("click",__pageIIClick);
         _lastPageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         mysteryShopModel.addEventListener("MYSTERY_GOODS_LIST_REFRESH",__refreshFrameView);
         mysteryShopModel.addEventListener("BUY_COUNTS_REFRESH",__refreshCountView);
         mysteryShopModel.addEventListener("CONSUME_POINTS_REFRESH",__refreshPointsView);
         mysteryShopModel.addEventListener("EXCHANGE_GOODS_LIST_UPDATE",__refreshExchangeGoodsView);
         mysteryShopModel.addEventListener("EXCHANGE_PAGE_UPDATE",__refreshPageView);
         _quickRefreshBtn.addEventListener("click",__onQuickRefreshClick);
         _countTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         _helpBtn.addEventListener("click",__onHelpClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _page1.removeEventListener("click",__pageIClick);
         _page2.removeEventListener("click",__pageIIClick);
         _lastPageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         mysteryShopModel.removeEventListener("MYSTERY_GOODS_LIST_REFRESH",__refreshFrameView);
         mysteryShopModel.removeEventListener("BUY_COUNTS_REFRESH",__refreshCountView);
         mysteryShopModel.removeEventListener("CONSUME_POINTS_REFRESH",__refreshPointsView);
         mysteryShopModel.removeEventListener("EXCHANGE_GOODS_LIST_UPDATE",__refreshExchangeGoodsView);
         mysteryShopModel.removeEventListener("EXCHANGE_PAGE_UPDATE",__refreshPageView);
         _quickRefreshBtn.removeEventListener("click",__onQuickRefreshClick);
         _countTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         _helpBtn.removeEventListener("click",__onHelpClick);
      }
      
      private function __pageIClick(param1:MouseEvent) : void
      {
         showCaseBagTip();
         updateGoodsListData();
         refreshTimeView();
      }
      
      private function __pageIIClick(param1:MouseEvent) : void
      {
         showCaseBagTip(false);
         updateExchangeGoodsListData();
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         mysteryShopControler.pageBtnHandler(param1.currentTarget == _lastPageBtn);
      }
      
      private function __refreshPageView(param1:MysteryShopEvent) : void
      {
         var _loc3_:int = 1;
         var _loc2_:int = 1;
         _pageTxt.text = mysteryShopModel.currentPage + " / " + mysteryShopModel.totalPage;
         _lastPageBtn.enable = mysteryShopModel.currentPage != 1;
         _nextPageBtn.enable = mysteryShopModel.currentPage != mysteryShopModel.totalPage;
      }
      
      private function __refreshExchangeGoodsView(param1:MysteryShopEvent) : void
      {
         updateExchangeGoodsListData();
      }
      
      private function showCaseBagTip(param1:Boolean = true) : void
      {
         _countTimeTxt.visible = param1;
         _countTime.visible = param1;
         _quickRefreshBtn.visible = param1;
         _goodsListContainer.visible = param1;
         _pageBg.visible = !param1;
         _pageTxt.visible = !param1;
         _lastPageBtn.visible = !param1;
         _nextPageBtn.visible = !param1;
         _exchangeGoodsListContainer.visible = !param1;
      }
      
      private function __refreshLuckyPlayerListHandler(param1:NotificationEvent) : void
      {
         var _loc3_:MysteryShopEventItem = null;
         var _loc2_:MysteryShopEventInfo = null;
         var _loc4_:ChatData = null;
         var _loc5_:int = 0;
         _vBox.removeAllChild();
         _scrolPanel.beginChanges();
         var _loc6_:Array = mysteryShopModel.luckyPlayerList;
         if(_loc6_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc3_ = new MysteryShopEventItem();
               _loc2_ = _loc6_[_loc5_] as MysteryShopEventInfo;
               _loc4_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc4_.channel = 103;
               _loc4_.msg = _loc2_.msg;
               _loc4_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc4_);
               _loc3_.data = _loc4_;
               _vBox.addChildAt(_loc3_,0);
               _loc5_++;
            }
         }
         _vBox.refreshChildPos();
         _scrolPanel.invalidateViewport();
         _scrolPanel.commitChanges();
      }
      
      private function __refreshCountView(param1:MysteryShopEvent) : void
      {
         _canBuyCount = mysteryShopModel.maxBuyCount - mysteryShopModel.buyCount;
         var _loc2_:String = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyCountView.tipText");
         _dailyCountTxt.text = _loc2_ + " " + String(_canBuyCount) + " / " + String(mysteryShopModel.maxBuyCount);
      }
      
      private function __refreshPointsView(param1:MysteryShopEvent) : void
      {
         _consumePointsTxt.text = mysteryShopModel.consumePoints.toString();
      }
      
      private function createGoodsList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:BuyGoodsItem = null;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new BuyGoodsItem();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = 3 + _loc2_ * (_loc1_.width - 3);
            _loc1_.y = 3 + _loc4_ * 98;
            _buyGoodsList.push(_loc1_);
            _goodsListContainer.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function createRareGoodsList() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("auction.MysteryShopFrame.BaseItemView");
            _loc4_ = _loc3_ / 4;
            _loc1_ = _loc3_ % 4;
            _loc2_.x = 9 + _loc1_ * 55;
            _loc2_.y = 9 + _loc4_ * 55;
            _rareGoodsList.push(_loc2_);
            _rareGoodsListContainer.addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function createExchangeGoodsList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:ExchangeGoodsItem = null;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new ExchangeGoodsItem();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = 3 + _loc2_ * (_loc1_.width - 3);
            _loc1_.y = 3 + _loc4_ * 98;
            _exchangeGoodsList.push(_loc1_);
            _exchangeGoodsListContainer.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function updateGoodsListData() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _buyGoodsList.length)
         {
            if(mysteryShopModel.goodsList && mysteryShopModel.goodsList[_loc1_])
            {
               _buyGoodsList[_loc1_].data = mysteryShopModel.goodsList[_loc1_] as BuyGoodsInfo;
            }
            else
            {
               _buyGoodsList[_loc1_].data = null;
            }
            _loc1_++;
         }
      }
      
      private function updateRareGoodsListData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:ShopGoodsInfo = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc4_:GoodsInfo = null;
         if(mysteryShopModel.rareGoodsList)
         {
            _loc3_ = 0;
            while(_loc3_ < _rareGoodsList.length)
            {
               if(mysteryShopModel.rareGoodsList[_loc3_])
               {
                  _loc1_ = mysteryShopModel.rareGoodsList[_loc3_] as ShopGoodsInfo;
                  _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_.ItemId);
                  _loc4_ = new GoodsInfo();
                  _loc4_.templateId = _loc2_.TemplateId;
                  _loc4_.validDate = _loc1_.ValidDate;
                  _rareGoodsList[_loc3_].data = _loc4_;
               }
               _loc3_++;
            }
         }
      }
      
      private function updateExchangeGoodsListData() : void
      {
         var _loc1_:int = 0;
         if(mysteryShopModel.showGoodsList)
         {
            _loc1_ = 0;
            while(_loc1_ < _exchangeGoodsList.length)
            {
               if(mysteryShopModel.showGoodsList[_loc1_])
               {
                  _exchangeGoodsList[_loc1_].data = mysteryShopModel.showGoodsList[_loc1_] as ShopGoodsInfo;
               }
               else
               {
                  _exchangeGoodsList[_loc1_].data = null;
               }
               _loc1_++;
            }
         }
      }
      
      private function __refreshFrameView(param1:MysteryShopEvent) : void
      {
         __refreshCountView(null);
         updateGoodsListData();
         refreshTimeView();
      }
      
      private function refreshTimeView() : void
      {
         _countTime.timeCount = mysteryShopModel.remainTime;
         if(_countTime.timeCount == 0)
         {
            MysteryShopManager.instance.sendRefreshGoodsList(false);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("core.mysteryShopHelpFrame");
         _loc2_.show();
      }
      
      private function __onQuickRefreshClick(param1:MouseEvent) : void
      {
         var _loc3_:Date = null;
         var _loc5_:Boolean = false;
         var _loc4_:Date = null;
         SoundManager.instance.play("022");
         if(quickRefreshAlert(startRefreshAlertBack))
         {
            return;
         }
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(SharedManager.instance.mysteryShopRefreshUseBind)
         {
            _loc2_ = PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
         }
         if(_loc2_ < mysteryShopModel.refreshRewardNeedPay)
         {
            RechargeAlertMannager.show();
            return;
         }
         if(_canBuyCount > 0)
         {
            _loc3_ = SharedManager.instance.mysteryShopRefreshUseBindDate;
            _loc5_ = Boolean(SharedManager.instance.mysteryShopRefreshUseBind);
            _loc4_ = new Date();
            if(_loc3_.month <= _loc3_.month && _loc3_.date <= _loc4_.date)
            {
               checkRareAndQuickRefresh(SharedManager.instance.mysteryShopRefreshUseBind);
            }
            else
            {
               checkRareAndQuickRefresh(SharedManager.instance.mysteryShopRefreshUseBind);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData"));
         }
      }
      
      private function checkRareAndQuickRefresh(param1:Boolean = true) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(MysteryShopManager.instance.model.hasRareGoods)
         {
            SimpleAlertHelper.instance.data = [quickRefreshCallBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("auction.view.mysteryshop.MysteryShopFrame.quickRefreshTipTxt");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
         }
         else
         {
            MysteryShopManager.instance.sendRefreshGoodsList(true,param1);
         }
      }
      
      private function quickRefreshCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MysteryShopManager.instance.sendRefreshGoodsList(true,param2);
         }
      }
      
      private function quickRefreshAlert(param1:Function = null) : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:Date = SharedManager.instance.mysteryShopRefreshCheckDate;
         var _loc6_:Boolean = Boolean(SharedManager.instance.mysteryShopRefresh);
         var _loc5_:Date = new Date();
         var _loc2_:Boolean = false;
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopRefreshAlertFrame");
            _loc7_ = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyTimeView.quickRefreshTip",mysteryShopModel.refreshRewardNeedPay);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc3_,startRefreshAlertBack,null,"left",1,false,mysteryShopModel.refreshRewardNeedPay);
         }
         return _loc2_;
      }
      
      private function startRefreshAlertBack(param1:Boolean, param2:Boolean) : void
      {
         SharedManager.instance.mysteryShopRefresh = param1;
         SharedManager.instance.mysteryShopRefreshCheckDate = new Date();
         SharedManager.instance.saveMysteryShopRefreshCheck();
         if(param1)
         {
            SharedManager.instance.mysteryShopRefreshUseBind = param2;
            SharedManager.instance.mysteryShopRefreshUseBindDate = new Date();
            SharedManager.instance.saveMysteryShopRefreshUseBind();
         }
         refreshGoodsListPayCall(param2);
      }
      
      private function refreshGoodsListPayCall(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = playerInfo.point + playerInfo.giftToken;
         }
         else
         {
            _loc2_ = int(playerInfo.point);
         }
         if(_loc2_ < mysteryShopModel.refreshRewardNeedPay)
         {
            RechargeAlertMannager.show();
            return;
         }
         checkRareAndQuickRefresh(param1);
         if(mysteryShopControler.frame)
         {
            StageReferance.stage.focus = mysteryShopControler.frame;
         }
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         MysteryShopManager.instance.sendRefreshGoodsList(false);
         _countTime.timeCount = mysteryShopModel.remainTime;
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("auction.view.mysteryshop.MysteryShopFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get mysteryShopManager() : MysteryShopManager
      {
         return MysteryShopManager.instance;
      }
      
      private function get mysteryShopModel() : MysteryShopModel
      {
         return MysteryShopManager.instance.model;
      }
      
      private function get mysteryShopControler() : MysteryShopControler
      {
         return FrameControllerManager.instance.mysteryShopController;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function cleanList() : void
      {
         var _loc1_:BuyGoodsItem = null;
         var _loc2_:BaseItemView = null;
         var _loc3_:ExchangeGoodsItem = null;
         while(_buyGoodsList.length > 0)
         {
            _loc1_ = _buyGoodsList.pop();
            if(_loc1_)
            {
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
         while(_rareGoodsList.length > 0)
         {
            _loc2_ = _rareGoodsList.pop();
            if(_loc2_)
            {
               if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
         while(_exchangeGoodsList.length > 0)
         {
            _loc3_ = _exchangeGoodsList.pop();
            if(_loc3_)
            {
               if(_loc3_.parent)
               {
                  _loc3_.parent.removeChild(_loc3_);
               }
               _loc3_.dispose();
               _loc3_ = null;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         cleanList();
         Mouse.cursor = "auto";
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_buttongroup);
         _buttongroup = null;
         ObjectUtils.disposeObject(_page1);
         _page1 = null;
         ObjectUtils.disposeObject(_page2);
         _page2 = null;
         ObjectUtils.disposeObject(_frameLeftBackBg);
         _frameLeftBackBg = null;
         ObjectUtils.disposeObject(_frameRightBackBg);
         _frameRightBackBg = null;
         ObjectUtils.disposeObject(_leftBack);
         _leftBack = null;
         ObjectUtils.disposeObject(_rightBack);
         _rightBack = null;
         ObjectUtils.disposeObject(_projectRareItem);
         _projectRareItem = null;
         ObjectUtils.disposeObject(_projectLuckyPlayer);
         _projectLuckyPlayer = null;
         ObjectUtils.disposeObject(_scrolPanel);
         _scrolPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_dailyCountTxt);
         _dailyCountTxt = null;
         ObjectUtils.disposeObject(_countTimeTxt);
         _countTimeTxt = null;
         ObjectUtils.disposeObject(_countTime);
         _countTime = null;
         ObjectUtils.disposeObject(_buyTipTxt);
         _buyTipTxt = null;
         ObjectUtils.disposeObject(_quickRefreshBtn);
         _quickRefreshBtn = null;
         ObjectUtils.disposeObject(_consumePointsBg);
         _consumePointsBg = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_goodsListContainer);
         _goodsListContainer = null;
         ObjectUtils.disposeObject(_rareGoodsListContainer);
         _rareGoodsListContainer = null;
         ObjectUtils.disposeObject(_exchangeGoodsListContainer);
         _exchangeGoodsListContainer = null;
         ObjectUtils.disposeObject(_consumePointsTxt);
         _consumePointsTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
         FrameControllerManager.instance.openControllerByInfo("shop");
      }
   }
}

