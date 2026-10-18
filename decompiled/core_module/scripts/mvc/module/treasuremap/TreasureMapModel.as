package mvc.module.treasuremap
{
   import events.TreasureMapEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.TempleteManager;
   
   public class TreasureMapModel extends EventDispatcher
   {
      
      public static const GET_TREASUREMAP:int = 1;
      
      public static const REFRESH:int = 2;
      
      public static const EXCAVATEIMM:int = 3;
      
      public static const CONFIRM_GET_REWARD:int = 4;
      
      public static const USE_TREASUREMAP:int = 5;
      
      public static const REQUEST_TREASUREMAP:int = 6;
      
      public static const OPEN_GET_FRAME:int = 1;
      
      public static const OPEN_USE_FRAME:int = 2;
      
      public static const QUALITY_MAX:int = 3;
      
      public static const DISTANCE1:int = 15;
      
      public static const DISTANCE2:int = 40;
      
      public static const DISTANCE3:int = 80;
      
      public static const GET_TIP_DELTA:int = 60;
      
      public static const COST_TEMPLATE_ID:int = 208050;
      
      public static const REWARD_TEMPLATE_ID:int = 208028;
      
      public static const COST_ITEM_TO_POINTS:int = 5;
      
      private var _joinCount:int = 0;
      
      private var _rewardCount:int = 0;
      
      private var _index:int = 0;
      
      private var _templateIds:Array;
      
      private var _lastGetTime:int;
      
      private var _lastTreasureMap:GoodsInfo;
      
      private var _joinMax:int = 0;
      
      private var _rewardMax:int = 0;
      
      private var _useFrameOpened:Boolean = false;
      
      private var _mapFrameOpened:Boolean = false;
      
      public var reinforceTarget:Object;
      
      private var _guildFlag:Boolean = false;
      
      private var _isFirstQuest:Boolean;
      
      private var _isFirstGet:Boolean;
      
      private var _isFirstUse:Boolean;
      
      public function TreasureMapModel()
      {
         super();
         _joinMax = getConfigValue("join_tremap_count");
         _rewardMax = getConfigValue("reward_tremap_count");
      }
      
      private function getConfigValue(param1:String) : int
      {
         if(TempleteManager.instance.getConfigInfoByConfigName(param1))
         {
            return int(TempleteManager.instance.getConfigInfoByConfigName(param1).ConfigValue);
         }
         return 5;
      }
      
      public function get joinMax() : int
      {
         return _joinMax;
      }
      
      public function get rewardMax() : int
      {
         return _rewardMax;
      }
      
      public function get joinCount() : int
      {
         return _joinCount;
      }
      
      public function set joinCount(param1:int) : void
      {
         if(_joinCount != param1)
         {
            _joinCount = param1;
         }
      }
      
      public function get rewardCount() : int
      {
         return _rewardCount;
      }
      
      public function set rewardCount(param1:int) : void
      {
         if(_rewardCount != param1)
         {
            _rewardCount = param1;
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         if(_index != param1)
         {
            _index = param1;
         }
      }
      
      public function get templateIds() : Array
      {
         return _templateIds;
      }
      
      public function set templateIds(param1:Array) : void
      {
         if(_templateIds != param1)
         {
            _templateIds = param1;
         }
      }
      
      public function get lastGetTime() : int
      {
         return _lastGetTime;
      }
      
      public function set lastGetTime(param1:int) : void
      {
         if(_lastGetTime != param1)
         {
            _lastGetTime = param1;
         }
      }
      
      public function get lastTreasureMap() : GoodsInfo
      {
         return _lastTreasureMap;
      }
      
      public function set lastTreasureMap(param1:GoodsInfo) : void
      {
         if(_lastTreasureMap != param1)
         {
            _lastTreasureMap = param1;
         }
      }
      
      public function get useFrameOpened() : Boolean
      {
         return _useFrameOpened;
      }
      
      public function set useFrameOpened(param1:Boolean) : void
      {
         if(_useFrameOpened != param1)
         {
            _useFrameOpened = param1;
         }
      }
      
      public function get mapFrameOpened() : Boolean
      {
         return _mapFrameOpened;
      }
      
      public function set mapFrameOpened(param1:Boolean) : void
      {
         if(_mapFrameOpened != param1)
         {
            _mapFrameOpened = param1;
         }
      }
      
      public function commit() : void
      {
         dispatchEvent(new TreasureMapEvent("TREASURE_INFO_UPDATE",this));
      }
      
      public function get guildFlag() : Boolean
      {
         return _guildFlag;
      }
      
      public function set guildFlag(param1:Boolean) : void
      {
         _guildFlag = param1;
      }
      
      public function get isFirstQuest() : Boolean
      {
         return _isFirstQuest;
      }
      
      public function set isFirstQuest(param1:Boolean) : void
      {
         _isFirstQuest = param1;
      }
      
      public function get isFirstGet() : Boolean
      {
         return _isFirstGet;
      }
      
      public function set isFirstGet(param1:Boolean) : void
      {
         _isFirstGet = param1;
      }
      
      public function get isFirstUse() : Boolean
      {
         return _isFirstUse;
      }
      
      public function set isFirstUse(param1:Boolean) : void
      {
         _isFirstUse = param1;
      }
   }
}

