package armyII.viewII.information
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MysteryShopManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.auction.MysteryShopModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class ItemExchangeView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _titleBg:Scale9CornerImage;
      
      private var _itemBox:VBox;
      
      private var _pageBg:Bitmap;
      
      private var _prevBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _nameTitleTxt:FilterFrameText;
      
      private var _numTitleTxt:FilterFrameText;
      
      private var _timeTitleTxt:FilterFrameText;
      
      private var _gotoTitleTxt:FilterFrameText;
      
      private var _list:Array;
      
      private var data:Array;
      
      private var pageNum:int;
      
      private var num:int = 7;
      
      public var currPage:int = 1;
      
      public function ItemExchangeView()
      {
         super();
         initView();
         initEvent();
         if(ArmyManager.instance.thane.grades >= 26)
         {
            if(!mysteryShopModel.lastRefreshTime || mysteryShopModel.remainTime == 0)
            {
               mysteryShopManager.sendRefreshGoodsList(false);
            }
         }
      }
      
      public function refresh() : void
      {
         currPage = ArmyManager.instance.openCurrPage;
         initData();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GoodsExchangeItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("army.itemExchangeBg");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("army.itemExchangeTitleBg");
         _nameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("army.itemExchangeView.title.name");
         _numTitleTxt = ComponentFactory.Instance.creatComponentByStylename("army.itemExchangeView.title.num");
         _timeTitleTxt = ComponentFactory.Instance.creatComponentByStylename("army.itemExchangeView.title.time");
         _gotoTitleTxt = ComponentFactory.Instance.creatComponentByStylename("army.itemExchangeView.title.goto");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("army.itemExchangeVbox");
         _pageBg = ComponentFactory.Instance.creatBitmap("asset.army.pageNumBg");
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("army.LastPageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("army.NextPageBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("army.itemExchangePageTxt");
         addChild(_bg);
         addChild(_titleBg);
         addChild(_nameTitleTxt);
         _nameTitleTxt.text = LanguageMgr.GetTranslation("armyII.viewII.information.ItemExchangeView.title01");
         addChild(_numTitleTxt);
         _numTitleTxt.text = LanguageMgr.GetTranslation("armyII.viewII.information.ItemExchangeView.title02");
         addChild(_timeTitleTxt);
         _timeTitleTxt.text = LanguageMgr.GetTranslation("armyII.viewII.information.ItemExchangeView.title03");
         addChild(_gotoTitleTxt);
         _gotoTitleTxt.text = LanguageMgr.GetTranslation("armyII.viewII.information.ItemExchangeView.title04");
         addChild(_itemBox);
         _list = [];
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("army.GoodsExchangeItem");
            _itemBox.addChild(_loc1_);
            _list.push(_loc1_);
            _loc2_++;
         }
         addChild(_pageBg);
         addChild(_prevBtn);
         addChild(_nextBtn);
         addChild(_pageTxt);
         _pageTxt.text = "1/5";
      }
      
      private function initEvent() : void
      {
         _prevBtn.addEventListener("click",__prevBtnHandler);
         _nextBtn.addEventListener("click",__nextBtnHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",initData);
         mysteryShopModel.addEventListener("CONSUME_POINTS_REFRESH",initData);
      }
      
      private function __prevBtnHandler(param1:MouseEvent) : void
      {
         currPage -= 1;
         refreshView();
      }
      
      private function __nextBtnHandler(param1:MouseEvent) : void
      {
         currPage += 1;
         refreshView();
      }
      
      private function initData(param1:Event = null) : void
      {
         data = PlayerCurrencyManager.instance.getShowArr();
         var _loc2_:int = int(data.length);
         pageNum = _loc2_ % num == 0 ? _loc2_ / num : _loc2_ / num + 1;
         refreshView();
      }
      
      private function refreshView(param1:NotificationEvent = null) : void
      {
         var _loc2_:int = 0;
         _nextBtn.enable = true;
         _prevBtn.enable = true;
         if(pageNum <= currPage)
         {
            _nextBtn.enable = false;
            currPage = pageNum;
         }
         if(currPage <= 1)
         {
            _prevBtn.enable = false;
            currPage = 1;
         }
         if(pageNum == 0)
         {
            pageNum = 1;
         }
         _pageTxt.text = currPage + "/" + pageNum;
         _loc2_ = (currPage - 1) * num;
         while(_loc2_ < currPage * 7)
         {
            if(_loc2_ >= data.length)
            {
               (_list[_loc2_ % num] as GoodsExchangeItem).data = null;
            }
            else
            {
               (_list[_loc2_ % num] as GoodsExchangeItem).data = data[_loc2_];
            }
            _loc2_++;
         }
      }
      
      private function removeEvent() : void
      {
         _prevBtn.removeEventListener("click",__prevBtnHandler);
         _nextBtn.removeEventListener("click",__nextBtnHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",initData);
         mysteryShopModel.removeEventListener("CONSUME_POINTS_REFRESH",initData);
      }
      
      private function __refreshPlayerInfoHandler(param1:PlayerEvent) : void
      {
         initData();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get mysteryShopModel() : MysteryShopModel
      {
         return MysteryShopManager.instance.model;
      }
      
      private function get mysteryShopManager() : MysteryShopManager
      {
         return MysteryShopManager.instance;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_titleBg);
         ObjectUtils.disposeObject(_itemBox);
         ObjectUtils.disposeObject(_pageBg);
         ObjectUtils.disposeObject(_prevBtn);
         ObjectUtils.disposeObject(_nextBtn);
         ObjectUtils.disposeObject(_pageTxt);
      }
   }
}

