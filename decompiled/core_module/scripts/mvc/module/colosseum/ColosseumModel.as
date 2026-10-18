package mvc.module.colosseum
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class ColosseumModel extends EventDispatcher
   {
      
      public static const LONG_TIME:int = 604800000;
      
      public static const SEVRAL_DAY_TIME:int = 259200000;
      
      public static const CURRENT_DAY_TIME:int = 43200000;
      
      public static const SEVRAL_HOUER_TIME:int = 3600000;
      
      public var totalFreeCount:int;
      
      public var totalBuyCount:int;
      
      public var currentCount:int;
      
      public var currentRank:int;
      
      public var lastWinCount:int;
      
      public var leftDay:int;
      
      public var noticMsg:String;
      
      public var selectedPlayer:ThaneInfo;
      
      public var heroRankList:Vector.<ThaneInfo>;
      
      public var eventsList:Vector.<ColosseumEventData>;
      
      public var heroList:Vector.<ThaneInfo>;
      
      public function ColosseumModel(param1:IEventDispatcher = null)
      {
         super(param1);
         heroList = new Vector.<ThaneInfo>();
         heroRankList = new Vector.<ThaneInfo>();
         eventsList = new Vector.<ColosseumEventData>();
      }
      
      public function getThaneInfoById(param1:int) : ThaneInfo
      {
         for each(var _loc2_:ThaneInfo in heroList)
         {
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get remainFreeCount() : int
      {
         var _loc1_:int = totalFreeCount - currentCount;
         return _loc1_ > 0 ? _loc1_ : 0;
      }
      
      public function get remainBuyCount() : int
      {
         if(remainFreeCount > 0)
         {
            return totalBuyCount;
         }
         return totalBuyCount - (currentCount - totalFreeCount);
      }
      
      public function get currentBuyCount() : int
      {
         return totalBuyCount - remainBuyCount;
      }
      
      public function get buyCountNeedPay() : int
      {
         var _loc1_:int = (currentBuyCount + 1) * 2;
         return _loc1_ > 10 ? 10 : _loc1_;
      }
   }
}

