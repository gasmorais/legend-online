package mvc.module.auction
{
   import events.MysteryShopEvent;
   import flash.events.EventDispatcher;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class MysteryShopModel extends EventDispatcher
   {
      
      protected static const BUY_COUNTS:String = "BUY_COUNTS";
      
      protected static const BUY_SUCCESS:String = "BUY_SUCCESS";
      
      protected static const LAST_REFRESH_TIME:String = "LAST_REFRESH_TIME";
      
      protected static const CONSUME_POINTS:String = "CONSUME_POINTS";
      
      public static const AUTO_REFRESH_INTERVAL:uint = 14400;
      
      public static var isFirstPay:Boolean = true;
      
      public static const MAX_GOODS_NUM:int = 6;
      
      public static const MAX_RARE_GOODS_NUM:int = 8;
      
      private var _lastRefreshTime:Date;
      
      private var _buyCount:int;
      
      private var tempNeedPay:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("ShopFresh_NeedDiamond");
      
      public var refreshRewardNeedPay:int = int(tempNeedPay.ConfigValue);
      
      private var _maxBuyCount:int;
      
      private var _remainTime:Number;
      
      private var _buyResult:int;
      
      public var goodsList:Array;
      
      public var rareGoodsList:Array;
      
      public var luckyPlayerList:Array;
      
      private var _consumePoints:int;
      
      public var exchangeGoodsList:Array;
      
      public var _showGoodsList:Array;
      
      public var currentPageNum:int = 6;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      protected var _changeObj:SimpleDictionary;
      
      public function MysteryShopModel()
      {
         super();
         _changeObj = new SimpleDictionary();
      }
      
      public function get consumePoints() : int
      {
         return _consumePoints;
      }
      
      public function set consumePoints(param1:int) : void
      {
         if(_consumePoints != param1)
         {
            _consumePoints = param1;
            _changeObj["CONSUME_POINTS"] = true;
         }
      }
      
      public function get showGoodsList() : Array
      {
         if(!_showGoodsList)
         {
            _showGoodsList = [];
         }
         return _showGoodsList;
      }
      
      public function set showGoodsList(param1:Array) : void
      {
         _showGoodsList = param1;
         dispatchEvent(new MysteryShopEvent("EXCHANGE_GOODS_LIST_UPDATE"));
      }
      
      public function resetData(param1:int = 1, param2:int = 6) : void
      {
         _currentPage = param1;
         currentPageNum = param2;
         totalPage = Math.ceil(exchangeGoodsList.length / currentPageNum);
      }
      
      public function updateShowGoodsList() : void
      {
         var _loc1_:int = (currentPage - 1) * currentPageNum;
         var _loc2_:int = _loc1_ + currentPageNum;
         if(_loc2_ > exchangeGoodsList.length)
         {
            _loc2_ = int(exchangeGoodsList.length);
         }
         showGoodsList = exchangeGoodsList.slice(_loc1_,_loc2_);
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         param1 = int(param1 <= 0 ? 1 : param1);
         _currentPage = param1;
         dispatchEvent(new MysteryShopEvent("EXCHANGE_PAGE_UPDATE"));
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set totalPage(param1:int) : void
      {
         param1 = param1 <= _currentPage ? _currentPage : param1;
         _totalPage = param1;
         dispatchEvent(new MysteryShopEvent("EXCHANGE_PAGE_UPDATE"));
      }
      
      public function beginChanges() : void
      {
         _changeObj.clear();
      }
      
      public function get maxBuyCount() : int
      {
         return _maxBuyCount;
      }
      
      public function set maxBuyCount(param1:int) : void
      {
         _maxBuyCount = param1;
      }
      
      public function get buyCount() : int
      {
         return _buyCount;
      }
      
      public function set buyCount(param1:int) : void
      {
         _buyCount = param1;
         _changeObj["BUY_COUNTS"] = true;
      }
      
      public function get buyResult() : int
      {
         return _buyResult;
      }
      
      public function set buyResult(param1:int) : void
      {
         _buyResult = param1;
         _changeObj["BUY_SUCCESS"] = true;
      }
      
      public function get lastRefreshTime() : Date
      {
         return _lastRefreshTime;
      }
      
      public function set lastRefreshTime(param1:Date) : void
      {
         _lastRefreshTime = param1;
         _changeObj["LAST_REFRESH_TIME"] = true;
      }
      
      public function commit() : void
      {
         if(_changeObj["BUY_SUCCESS"])
         {
            dispatchEvent(new MysteryShopEvent("MYSTERY_GOODS_BUY_RETURN"));
         }
         if(_changeObj["LAST_REFRESH_TIME"])
         {
            dispatchEvent(new MysteryShopEvent("MYSTERY_GOODS_LIST_REFRESH"));
         }
         if(_changeObj["BUY_COUNTS"])
         {
            dispatchEvent(new MysteryShopEvent("BUY_COUNTS_REFRESH"));
         }
         if(_changeObj["CONSUME_POINTS"])
         {
            dispatchEvent(new MysteryShopEvent("CONSUME_POINTS_REFRESH"));
         }
      }
      
      public function get remainTime() : Number
      {
         if(_lastRefreshTime)
         {
            _remainTime = 14400 - (playerModel.sysCurTimeBySecond - _lastRefreshTime.time / 1000);
         }
         else
         {
            _remainTime = 14400;
         }
         if(_remainTime > 0)
         {
            return _remainTime > 14400 ? 14400 : _remainTime;
         }
         return 0;
      }
      
      public function get hasRareGoods() : Boolean
      {
         var _loc1_:ShopGoodsInfo = null;
         if(!goodsList)
         {
            return false;
         }
         for each(var _loc2_:BuyGoodsInfo in goodsList)
         {
            if(_loc2_.isCanBuy != 1)
            {
               _loc1_ = TempleteManager.instance.getMysteryInfoByItemId(_loc2_.itemId);
               if(_loc1_.Rands <= 100)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

