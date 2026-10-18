package mvc.module.singlepass
{
   import events.SinglePassEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.playerinfo.RankInfo;
   import yishi.manager.TempleteManager;
   
   public class SinglePassModel extends EventDispatcher
   {
      
      public static const CAMPAIGN_TEMPLATE_ID:int = 40001;
      
      public static const PROP_TEMPLATE_ID:int = 3140001;
      
      public static const BUGLE_TEMPLATE_ID:int = 3150001;
      
      public static const MIN_FLOOR:int = 1;
      
      public static const MAX_FLOOR:int = 10;
      
      public static const TOLLGATE_PER_FLOOR:int = 10;
      
      public static const JUDGE_MAX:int = 5;
      
      public static const REWARD_LIMIT:int = 5;
      
      public static const FIGHT_FRAME:int = 1;
      
      public static const BUGLE_FRAME:int = 2;
      
      public static const FLOOR_STR:Array = [undefined,"Ⅰ","Ⅱ","Ⅲ","Ⅳ","Ⅴ","Ⅵ","Ⅶ","Ⅷ","Ⅸ","Ⅹ"];
      
      public var selectArea:int = 1;
      
      public var selectIndex:int = 0;
      
      public var lastIndex:int = 0;
      
      private var _area:int;
      
      private var _maxIndex:int;
      
      private var _areaReward:String;
      
      private var _count:int;
      
      private var _itemCount:int;
      
      private var _areaRewardArray:Array;
      
      private var _rankInfos:Vector.<RankInfo>;
      
      private var _orderList:Vector.<SinglePassOrderInfo>;
      
      private var _cardInfos:Vector.<SinglePassCardInfo>;
      
      private var _maxCount:int;
      
      private var _bugleCount:int;
      
      private var _floors:Array;
      
      public function SinglePassModel()
      {
         var _loc1_:SinglePassCardInfo = null;
         var _loc2_:int = 0;
         super();
         _rankInfos = new Vector.<RankInfo>();
         _orderList = new Vector.<SinglePassOrderInfo>();
         _cardInfos = new Vector.<SinglePassCardInfo>();
         _maxCount = int(TempleteManager.instance.getConfigInfoByConfigName("SinglePass_Count").ConfigValue);
         _bugleCount = 2;
         _loc2_ = 1;
         while(_loc2_ <= 10 * 10)
         {
            _loc1_ = new SinglePassCardInfo();
            _loc1_.tollgate = _loc2_;
            _cardInfos.push(_loc1_);
            _loc2_++;
         }
         initFloors();
      }
      
      public function getCardInfoByIndex(param1:int) : SinglePassCardInfo
      {
         return _cardInfos[param1 - 1];
      }
      
      public function getCardInfoByFloor(param1:int) : Vector.<SinglePassCardInfo>
      {
         var _loc4_:int = 0;
         if(param1 < 1)
         {
            param1 = 1;
         }
         var _loc2_:int = param1 * 10;
         var _loc3_:Vector.<SinglePassCardInfo> = new Vector.<SinglePassCardInfo>();
         _loc4_ = _loc2_ - 10;
         while(_loc4_ < _loc2_)
         {
            _loc3_.push(_cardInfos[_loc4_]);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function get cardInfos() : Vector.<SinglePassCardInfo>
      {
         return _cardInfos;
      }
      
      public function get maxCount() : int
      {
         return _maxCount;
      }
      
      public function get bugleCount() : int
      {
         return _bugleCount;
      }
      
      public function get areaRewardArray() : Array
      {
         return _areaRewardArray;
      }
      
      public function get area() : int
      {
         return _area;
      }
      
      public function set area(param1:int) : void
      {
         if(_area != param1)
         {
            _area = param1;
         }
      }
      
      public function get maxIndex() : int
      {
         return _maxIndex;
      }
      
      public function set maxIndex(param1:int) : void
      {
         if(_maxIndex != param1)
         {
            _maxIndex = param1;
         }
      }
      
      public function get areaReward() : String
      {
         return _areaReward;
      }
      
      public function set areaReward(param1:String) : void
      {
         if(_areaReward != param1)
         {
            _areaReward = param1;
            _areaRewardArray = _areaReward.split(",");
         }
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         if(_count != param1)
         {
            _count = param1;
         }
      }
      
      public function get itemCount() : int
      {
         return _itemCount;
      }
      
      public function set itemCount(param1:int) : void
      {
         if(_itemCount != param1)
         {
            _itemCount = param1;
         }
      }
      
      public function get floors() : Array
      {
         return _floors;
      }
      
      public function initFloors() : void
      {
         var _loc1_:int = 0;
         _floors = [];
         _loc1_ = 1;
         for(; _loc1_ < area; _loc1_++)
         {
            if(areaReward && areaReward.indexOf(_loc1_.toString()) != -1)
            {
               if(isAllMaxJudgeByFloor(_loc1_))
               {
                  continue;
               }
            }
            _floors.push(_loc1_);
         }
         _floors.push(area);
      }
      
      public function isAllMaxJudgeByFloor(param1:int) : Boolean
      {
         var _loc4_:int = param1 * 10;
         var _loc2_:int = _loc4_ - 10 + 1;
         for each(var _loc3_:SinglePassCardInfo in _cardInfos)
         {
            if(_loc3_.tollgate >= _loc2_ && _loc3_.tollgate <= _loc4_)
            {
               if(_loc3_.judge != 5)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function isMaxJudge(param1:int) : Boolean
      {
         for each(var _loc2_:SinglePassCardInfo in _cardInfos)
         {
            if(_loc2_.tollgate == param1 && _loc2_.judge == 5)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get orderList() : Vector.<SinglePassOrderInfo>
      {
         return _orderList;
      }
      
      public function updateOrderList() : void
      {
         dispatchEvent(new SinglePassEvent("ORDERDATA_LOAD_COMPLETE",this));
      }
      
      public function updateBugleInfo(param1:SinglePassBugleInfo) : void
      {
         dispatchEvent(new SinglePassEvent("UPDATE_BUGLE_INFO",param1));
      }
      
      public function updateBugleRewards(param1:SinglePassBugleInfo) : void
      {
         dispatchEvent(new SinglePassEvent("UPDATE_BUGLE_REWARDS",param1));
      }
      
      public function commit() : void
      {
         dispatchEvent(new SinglePassEvent("SINGLEPASS_INFO_UPDATE",this));
      }
   }
}

