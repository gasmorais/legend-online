package yishi.manager
{
   import com.road.yishi.proto.bingo.BingoBuyInfoMsg;
   import com.road.yishi.proto.bingo.BingoCardTempMsg;
   import com.road.yishi.proto.bingo.BingoDataMsg;
   import com.road.yishi.proto.bingo.BingoInfoDataMsg;
   import com.road.yishi.proto.bingo.BingoLotteryNotifyMsg;
   import com.road.yishi.proto.bingo.BingoOpMsg;
   import com.road.yishi.proto.bingo.BingoRespMsg;
   import com.road.yishi.proto.bingo.BingoResultDataMsg;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yishi.actions.map.BingoDelayAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class BingoManager
   {
      
      private static var _instance:BingoManager;
      
      private var _buyInfo:BingoBuyInfoMsg;
      
      private var _cardTempArr:Array = [];
      
      private var _resultMsg:BingoResultDataMsg;
      
      private var _snapDataArr:Array = [];
      
      private var _resultDataArr:Array = [];
      
      private var _globalBuyArr:Array = [];
      
      private var _currentPond:int;
      
      private var _eventDate:String = "";
      
      private var _op:int;
      
      private var _priorityArr:Array = [];
      
      private var _timer:Timer;
      
      private var _bingoEffect:Boolean = false;
      
      public var isPlaying:Array = [0,0,0,0];
      
      public function BingoManager()
      {
         super();
      }
      
      public static function get instance() : BingoManager
      {
         if(!_instance)
         {
            _instance = new BingoManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 386,__bingoHandler);
         _timer = new Timer(200);
         _timer.addEventListener("timer",__timeUpdateHandler);
         _timer.start();
      }
      
      private function __bingoHandler(param1:SLGSocketEvent) : void
      {
         var _loc11_:BingoDataMsg = null;
         var _loc12_:BingoInfoDataMsg = null;
         var _loc5_:int = 0;
         var _loc4_:BingoDataMsg = null;
         var _loc6_:BingoInfoDataMsg = null;
         var _loc8_:int = 0;
         var _loc3_:BingoDataMsg = null;
         var _loc9_:BingoLotteryNotifyMsg = null;
         var _loc15_:int = 0;
         var _loc10_:BingoResultDataMsg = null;
         var _loc14_:Boolean = false;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:BingoOpMsg = new BingoOpMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as BingoOpMsg;
         _op = _loc2_.op;
         var _loc13_:BingoRespMsg = _loc2_.resData;
         if(_loc2_.op == 0)
         {
            _loc11_ = new BingoDataMsg();
            _loc11_.readExternal(_loc13_.data);
            _buyInfo = _loc11_.buyInfo;
            _globalBuyArr = _loc11_.globalBuyInfo;
            _currentPond = _loc11_.currentPond;
            _loc12_ = _loc11_.dataInfo;
            if(!_loc12_.currentData)
            {
               return;
            }
            _eventDate = _loc12_.currentData.eventData;
            _cardTempArr = _loc12_.currentData.cardTemp.sortOn("cardId",16);
            _resultMsg = _loc12_.currentData.resultData;
            if(_loc11_.currentDataResult)
            {
               _resultMsg = _loc11_.currentDataResult;
            }
            _snapDataArr = [];
            _resultDataArr = [];
            _loc5_ = 0;
            while(_loc5_ < _loc12_.historyData.length)
            {
               if(_loc12_.historyData[_loc5_].resultSnap)
               {
                  _snapDataArr.push(_loc12_.historyData[_loc5_].resultSnap);
                  _resultDataArr.push(_loc12_.historyData[_loc5_].resultData);
               }
               _loc5_++;
            }
            if(_loc12_.currentData.resultSnap)
            {
               _snapDataArr.push(_loc12_.currentData.resultSnap);
               _resultDataArr.push(_loc12_.currentData.resultData);
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("BALL_TEMP_UPDATE"));
         }
         else if(_loc2_.op == 6)
         {
            _loc4_ = new BingoDataMsg();
            _loc4_.readExternal(_loc13_.data);
            _loc6_ = _loc4_.dataInfo;
            _resultMsg = _loc6_.currentData.resultData;
            _snapDataArr = [];
            _resultDataArr = [];
            _loc8_ = 0;
            while(_loc8_ < _loc6_.historyData.length)
            {
               if(_loc6_.historyData[_loc8_].resultSnap)
               {
                  _snapDataArr.push(_loc6_.historyData[_loc8_].resultSnap);
                  _resultDataArr.push(_loc6_.historyData[_loc8_].resultData);
               }
               _loc8_++;
            }
            if(_loc6_.currentData.resultSnap)
            {
               _snapDataArr.push(_loc6_.currentData.resultSnap);
               _resultDataArr.push(_loc6_.currentData.resultData);
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("BALL_TEMP_UPDATE"));
         }
         else if(_loc2_.op == 1)
         {
            _loc3_ = new BingoDataMsg();
            _loc3_.readExternal(_loc13_.data);
            _buyInfo = _loc3_.buyInfo;
            _globalBuyArr = _loc3_.globalBuyInfo;
            _currentPond = _loc3_.currentPond;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("BALL_BUY"));
         }
         else if(_loc2_.op == 4)
         {
            _loc9_ = new BingoLotteryNotifyMsg();
            _loc9_.readExternal(_loc13_.data);
            _loc15_ = _loc9_.calledNum;
            _loc10_ = _loc9_.data;
            _loc14_ = _loc9_.luckNum;
            if(!_resultMsg)
            {
               _resultMsg = _loc10_;
            }
            else
            {
               _resultMsg.lotteryNum = _loc10_.lotteryNum;
               _resultMsg.luckNum = _loc10_.luckNum;
               _resultMsg.rankData = _loc10_.rankData;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("BALL_START",{
               "num":_loc15_,
               "resultMsg":_loc10_,
               "luckNum":_loc14_
            }));
            if(!_bingoEffect)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("BALL_EFFECT"));
               _bingoEffect = true;
            }
         }
      }
      
      private function __timeUpdateHandler(param1:TimerEvent) : void
      {
         var _loc2_:BingoDelayAction = null;
         if(_priorityArr.length > 0)
         {
            _loc2_ = _priorityArr.shift();
            _loc2_.handOut();
         }
      }
      
      public function get op() : int
      {
         return _op;
      }
      
      public function get buyInfo() : BingoBuyInfoMsg
      {
         return _buyInfo;
      }
      
      public function get cardTempArr() : Array
      {
         return _cardTempArr;
      }
      
      public function get resultMsg() : BingoResultDataMsg
      {
         return _resultMsg;
      }
      
      public function get snapDataArr() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         _loc3_ = _loc2_;
         while(_loc3_ < _snapDataArr.length)
         {
            _loc1_.push(_snapDataArr[_loc3_]);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get resultDataArr() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         _loc3_ = _loc2_;
         while(_loc3_ < _resultDataArr.length)
         {
            _loc1_.push(_resultDataArr[_loc3_]);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get globalBuyArr() : Array
      {
         return _globalBuyArr;
      }
      
      public function get currentPond() : int
      {
         return _currentPond;
      }
      
      public function get eventDate() : String
      {
         return _eventDate;
      }
      
      public function getCardTempById(param1:int) : BingoCardTempMsg
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < cardTempArr.length)
         {
            if(cardTempArr[_loc2_].cardId == param1)
            {
               return cardTempArr[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function OperateBingo(param1:int, param2:int = 0, param3:int = 0, param4:String = "") : void
      {
         var _loc6_:PackageOut = new PackageOut(9625);
         var _loc5_:BingoOpMsg = new BingoOpMsg();
         _loc5_.op = param1;
         _loc5_.param1 = param2;
         _loc5_.param2 = param3;
         _loc5_.param3 = param4;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
   }
}

