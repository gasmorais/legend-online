package yishi.manager
{
   import com.road.yishi.proto.active.LuckExchangeInfoListMsg;
   import com.road.yishi.proto.active.LuckExchangeOpMsg;
   import com.road.yishi.proto.active.LuckExchangeTempListMsg;
   import com.road.yishi.proto.active.LuckExchangeTempMsg;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class LuckyExchangeManager
   {
      
      private static var _instance:LuckyExchangeManager;
      
      public static const SURE:int = 1;
      
      public static const RANDOM2:int = 2;
      
      public static const PERCENT:int = 3;
      
      public static const RANDOM:int = 4;
      
      private var _tempList:LuckExchangeTempListMsg;
      
      private var _dataList:LuckExchangeInfoListMsg;
      
      public var isLuckyExchangeOpen:Boolean;
      
      public function LuckyExchangeManager()
      {
         super();
      }
      
      public static function get instance() : LuckyExchangeManager
      {
         if(!_instance)
         {
            _instance = new LuckyExchangeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 363,__luckyTempHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 364,__luckyDataHandler);
      }
      
      private function __luckyTempHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LuckExchangeTempListMsg = new LuckExchangeTempListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LuckExchangeTempListMsg;
         _tempList = _loc2_;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("LUCKY_TEMP_CHANGE"));
      }
      
      private function __luckyDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LuckExchangeInfoListMsg = new LuckExchangeInfoListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LuckExchangeInfoListMsg;
         _dataList = _loc2_;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("LUCKY_INFO_CHANGE"));
      }
      
      public function get showData() : Array
      {
         var _loc2_:Date = null;
         var _loc4_:Date = null;
         var _loc3_:Number = NaN;
         var _loc1_:int = 0;
         var _loc5_:Array = [];
         var _loc6_:Array = LuckyExchangeManager.instance.tempList;
         _loc1_ = 0;
         while(_loc1_ < _loc6_.length)
         {
            _loc2_ = DateFormatter.parse(_loc6_[_loc1_].startTime,"YYYY-MM-DD hh:mm:ss");
            _loc3_ = _loc2_.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
            if(_loc3_ <= 0)
            {
               _loc4_ = DateFormatter.parse(_loc6_[_loc1_].endTime,"YYYY-MM-DD hh:mm:ss");
               _loc3_ = _loc4_.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
               if(_loc3_ >= 0)
               {
                  _loc5_.push(_loc6_[_loc1_]);
               }
            }
            _loc1_++;
         }
         return _loc5_;
      }
      
      public function get tempList() : Array
      {
         if(_tempList)
         {
            return _tempList.luckExchange;
         }
         return [];
      }
      
      public function getGoodsByRare(param1:LuckExchangeTempMsg) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.dropItems.length)
         {
            if(param1.dropItems[_loc3_].rare)
            {
               _loc2_.push(param1.dropItems[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getGoodsByDropType(param1:LuckExchangeTempMsg, param2:int) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.dropItems.length)
         {
            if(param1.dropItems[_loc4_].dropType == param2)
            {
               _loc3_.push(param1.dropItems[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getLuckyValueById(param1:String) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _dataList.luckExchangeInfo.length)
         {
            if(_dataList.luckExchangeInfo[_loc2_].exchangeId == param1)
            {
               return _dataList.luckExchangeInfo[_loc2_].currentLuckValue;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function set getLuckExchangeInfoListMsg(param1:LuckExchangeInfoListMsg) : void
      {
         _dataList = param1;
      }
      
      public function OperateLuckyExchange(param1:String, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9610);
         var _loc3_:LuckExchangeOpMsg = new LuckExchangeOpMsg();
         _loc3_.exchangeId = param1;
         _loc3_.exchangeCount = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

