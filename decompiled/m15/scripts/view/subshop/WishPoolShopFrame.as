package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.WishPoolManager;
   import mvc.module.wishpool.WishPoolModel;
   import mvc.module.wishpool.WishPoolShopInfo;
   import view.GoodsItem12;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.NotificationManager;
   import yishi.utils.DateFormatter;
   
   public class WishPoolShopFrame extends Frame
   {
      
      private var _wishPoolBtn:SelectedButton;
      
      private var _bg:Bitmap;
      
      private var _bg1:Bitmap;
      
      private var _back:ScaleBitmapImage;
      
      private var _displayShow:Bitmap;
      
      private var _pvpIcon:Bitmap;
      
      private var _leagueShowTxt:Bitmap;
      
      private var _signButton:IconButton;
      
      private var _resetTimeTxt:FilterFrameText;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _itemList:Vector.<GoodsItem12>;
      
      private var _stripView:StripView;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      public function WishPoolShopFrame()
      {
         super();
         initView();
         addEvent();
         initData();
         WishPoolManager.instance.frameOperation(WishPoolManager.OPEN_SHOP_FRAME,[]);
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:GoodsItem12 = null;
         _wishPoolBtn = ComponentFactory.Instance.creatComponentByStylename("shop.wishpool.GoodsBtn");
         _bg = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _pvpIcon = ComponentFactory.Instance.creatBitmap("asset.core.wishpoolScoreIconImage");
         _leagueShowTxt = ComponentFactory.Instance.creatBitmap("asset.shop.pokerScoreTxt");
         _resetTimeTxt = ComponentFactory.Instance.creatComponentByStylename("wishPoolShopFrame.pvpShopResetTimeTextStyle");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.pokerScoreTip.StripView");
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = LanguageMgr.GetTranslation("tips.WishPoolShopFrame.StripView");
         _resetTimeTxt.htmlText = LanguageMgr.GetTranslation("WishPoolShopFrame.resetTimeTxt",getOutTime());
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
         _pvpIcon.x = 28;
         _pvpIcon.y = 430;
         addToContent(_leagueShowTxt);
         _leagueShowTxt.x = 58;
         _leagueShowTxt.y = 435;
         addToContent(_resetTimeTxt);
         addToContent(_signButton);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageNumTxt);
         addToContent(_contributeTxt);
         _contributeTxt.x = 105;
         addToContent(_wishPoolBtn);
         addToContent(_stripView);
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _itemList = new Vector.<GoodsItem12>();
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc1_ = new GoodsItem12();
            _loc4_ = _loc3_ / 3;
            _loc2_ = _loc3_ % 3;
            _loc1_.x = _loc2_ * _loc1_.width + 7;
            _loc1_.y = _loc4_ * (_loc1_.height + 3) + 5;
            addToContent(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
         _totalPage = Math.ceil(model.totalShopArray.length / 9);
         _totalPage = _totalPage > 0 ? _totalPage : 1;
      }
      
      private function getOutTime() : String
      {
         var _loc1_:Number = NaN;
         var _loc2_:Date = null;
         if(WishPoolManager.instance.model.endDate)
         {
            _loc1_ = WishPoolManager.instance.model.endDate.time + 86400000;
            _loc2_ = new Date(_loc1_);
            return DateFormatter.format(_loc2_,"YYYY-MM-DD hh:mm:ss");
         }
         return "";
      }
      
      private function initData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = getShowGoodsList();
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _itemList[_loc2_].data = _loc2_ < _loc1_.length ? WishPoolShopInfo(_loc1_[_loc2_]) : null;
            _loc2_++;
         }
         _pageNumTxt.text = _currentPage + "/" + _totalPage;
         _prePageBtn.enable = _currentPage != 1;
         _nextPageBtn.enable = _currentPage != _totalPage;
      }
      
      private function get model() : WishPoolModel
      {
         return WishPoolManager.instance.model;
      }
      
      private function refreshView() : void
      {
         _contributeTxt.text = WishPoolManager.instance.model.leftScore.toString();
         initData();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _signButton.addEventListener("click",__signBtnHalder);
         NotificationManager.instance.addEventListener("WISH_POOL_SHOP_SCORE_UPDATE",__updateMedal);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _signButton.removeEventListener("click",__signBtnHalder);
         NotificationManager.instance.removeEventListener("WISH_POOL_SHOP_SCORE_UPDATE",__updateMedal);
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Boolean = param1.currentTarget == _prePageBtn;
         if(_currentPage > 1 && _loc2_)
         {
            _currentPage = _currentPage - 1;
         }
         else if(!_loc2_ && _currentPage < _totalPage)
         {
            _currentPage = _currentPage + 1;
         }
         initData();
      }
      
      private function __signBtnHalder(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function getShowGoodsList() : Array
      {
         var _loc1_:int = (_currentPage - 1) * 9;
         var _loc2_:int = _loc1_ + 9;
         if(_loc2_ > model.totalShopArray.length)
         {
            _loc2_ = int(model.totalShopArray.length);
         }
         return model.totalShopArray.slice(_loc1_,_loc2_);
      }
      
      private function __updateMedal(param1:Event) : void
      {
         refreshView();
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
      
      public function show(param1:Object = null) : void
      {
         titleText = LanguageMgr.GetTranslation("WishPoolShopFrame.title");
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
      }
   }
}

