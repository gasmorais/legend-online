package mvc.module.luckylottery
{
   import flash.utils.Dictionary;
   
   public class LuckyLotteryModel
   {
      
      public const OP_DRAW:int = 1;
      
      public const OP_REFRESH:int = 2;
      
      public const OP_FRAME:int = 3;
      
      public var needGoodsTempId:int;
      
      public var needGoodsCount:int;
      
      public var refreshNeedTimes:int;
      
      public var startDate:String;
      
      public var endDate:String;
      
      public var specialAwardInfo:LuckyLotteryGoodsInfo;
      
      public var openLuckyLottery:Boolean;
      
      private var _respArray:Array;
      
      private var _allItemInfoDic:Dictionary;
      
      private var _allItemInfoArray:Array;
      
      public var refreshCountTimes:int;
      
      public var refreshedCountTimes:int;
      
      public function LuckyLotteryModel()
      {
         super();
      }
      
      public function get allItemInfoArray() : Array
      {
         return _allItemInfoArray;
      }
      
      public function set allItemInfoArray(param1:Array) : void
      {
         _allItemInfoArray = param1;
      }
      
      public function get respArray() : Array
      {
         return _respArray;
      }
      
      public function set respArray(param1:Array) : void
      {
         _respArray = param1;
      }
      
      public function get allItemInfoDic() : Dictionary
      {
         return _allItemInfoDic;
      }
      
      public function set allItemInfoDic(param1:Dictionary) : void
      {
         _allItemInfoDic = param1;
      }
      
      public function initAllItemInfoDic() : void
      {
         var _loc2_:LuckyLotteryGoodsInfo = null;
         var _loc3_:int = 0;
         var _loc1_:int = int(allItemInfoArray.length);
         allItemInfoDic = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = allItemInfoArray[_loc3_] as LuckyLotteryGoodsInfo;
            if(!allItemInfoDic[_loc2_.label])
            {
               allItemInfoDic[_loc2_.label] = [];
            }
            allItemInfoDic[_loc2_.label].push(_loc2_);
            _loc3_++;
         }
      }
   }
}

