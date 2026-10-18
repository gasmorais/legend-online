package mvc.module.outercityshop
{
   import events.OuterCityShopEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class OuterCityShopModel extends EventDispatcher
   {
      
      public static const MAX_BLESS_NUM:int = 10;
      
      public static const MAX_LUCKY_NUM:int = 5;
      
      public static const MAX_GOODS_NUM:int = 6;
      
      public static const MAX_LOOK_GOODS_NUM:int = 30;
      
      private var tempNeedPay:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("MapShopPoint");
      
      public var refreshNeedPoint:int = tempNeedPay ? int(tempNeedPay.ConfigValue) : 10;
      
      private var tempNeedStrategy:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("MapShopStrategy");
      
      public var refreshNeedStrategy:int = tempNeedStrategy ? int(tempNeedStrategy.ConfigValue) : 20000;
      
      private var tempNeedStrategyMax:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("MapShopStrategyMax");
      
      public var refreshNeedStrategyMax:int = tempNeedStrategyMax ? int(tempNeedStrategyMax.ConfigValue) : 1280000;
      
      public var fresh_time:Date;
      
      public var bless:int;
      
      public var fresh_count:int;
      
      public var consumePoints:int;
      
      public var goodsList:Array;
      
      private var _payType:int = 1;
      
      private var _shopLuckShowInfo:Array;
      
      public var exchangeGoodsList:Array;
      
      public var _showGoodsList:Array;
      
      public var currentPageNum:int = 6;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      public var lookGoodsList:Array;
      
      public var _showLookGoodsList:Array;
      
      public var currentLookPageNum:int = 30;
      
      private var _currentLookPage:int = 1;
      
      private var _totalLookPage:int = 1;
      
      public function OuterCityShopModel()
      {
         super();
      }
      
      public function get payType() : int
      {
         return _payType;
      }
      
      public function set payType(param1:int) : void
      {
         _payType = param1;
         dispatchEvent(new OuterCityShopEvent("PAYTYPE_CHANGE"));
      }
      
      public function commit() : void
      {
         dispatchEvent(new OuterCityShopEvent("FRESH_VIEW"));
      }
      
      public function get lastFreshTime() : Number
      {
         if(fresh_time)
         {
            return fresh_time.time / 1000 - playerModel.sysCurTimeBySecond;
         }
         return 14400;
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
         dispatchEvent(new OuterCityShopEvent("EXCHANGE_GOODS_LIST_UPDATE"));
      }
      
      public function resetData(param1:int = 1, param2:int = 6) : void
      {
         currentPage = param1;
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
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set totalPage(param1:int) : void
      {
         param1 = param1 <= _currentPage ? _currentPage : param1;
         _totalPage = param1;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get shopLuckShowInfo() : Array
      {
         return _shopLuckShowInfo;
      }
      
      public function set shopLuckShowInfo(param1:Array) : void
      {
         _shopLuckShowInfo = param1;
         dispatchEvent(new OuterCityShopEvent("UPDATE_LUCK_SHOW_INFO"));
      }
      
      public function get showLookGoodsList() : Array
      {
         if(!_showLookGoodsList)
         {
            _showLookGoodsList = [];
         }
         return _showLookGoodsList;
      }
      
      public function set showLookGoodsList(param1:Array) : void
      {
         _showLookGoodsList = param1;
         dispatchEvent(new OuterCityShopEvent("LOOK_GOODS_LIST_UPDATE"));
      }
      
      public function resetLookData(param1:int = 1, param2:int = 30) : void
      {
         currentLookPage = param1;
         currentLookPageNum = param2;
         totalLookPage = Math.ceil(lookGoodsList.length / currentLookPageNum);
      }
      
      public function updateShowLookGoodsList() : void
      {
         var _loc1_:int = (currentLookPage - 1) * currentLookPageNum;
         var _loc2_:int = _loc1_ + currentLookPageNum;
         if(_loc2_ > lookGoodsList.length)
         {
            _loc2_ = int(lookGoodsList.length);
         }
         showLookGoodsList = lookGoodsList.slice(_loc1_,_loc2_);
      }
      
      public function get currentLookPage() : int
      {
         return _currentLookPage;
      }
      
      public function set currentLookPage(param1:int) : void
      {
         param1 = int(param1 <= 0 ? 1 : param1);
         _currentLookPage = param1;
      }
      
      public function get totalLookPage() : int
      {
         return _totalLookPage;
      }
      
      public function set totalLookPage(param1:int) : void
      {
         param1 = param1 <= currentLookPage ? currentLookPage : param1;
         _totalLookPage = param1;
      }
   }
}

