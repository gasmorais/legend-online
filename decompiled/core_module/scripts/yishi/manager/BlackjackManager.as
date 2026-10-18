package yishi.manager
{
   import com.road.yishi.proto.blackjack.BlackJackBoardMsg;
   import com.road.yishi.proto.blackjack.BlackJackDataMsg;
   import com.road.yishi.proto.blackjack.BlackJackExchangeMsg;
   import com.road.yishi.proto.blackjack.BlackJackExchangeNoticeMsg;
   import com.road.yishi.proto.blackjack.BlackJackListMsg;
   import com.road.yishi.proto.blackjack.BlackJackMsg;
   import com.road.yishi.proto.blackjack.BlackJackReqMsg;
   import flash.utils.Dictionary;
   import mvc.module.blackjack.BlackjackBoardInfo;
   import mvc.module.blackjack.BlackjackExchangeInfo;
   import mvc.module.blackjack.BlackjackTempInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class BlackjackManager
   {
      
      private static var _instance:BlackjackManager;
      
      private var _blackTempDic:Dictionary;
      
      private var _blackExchangeDic:Dictionary;
      
      private var _blackjackMsgArr:Array = [];
      
      private var _blackjackBoardInfo:BlackjackBoardInfo;
      
      private var _op:int;
      
      private var _param1:int;
      
      private var _score:int;
      
      public function BlackjackManager()
      {
         super();
      }
      
      public static function get instance() : BlackjackManager
      {
         if(!_instance)
         {
            _instance = new BlackjackManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 268,__blackTempHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 269,__blackRecordHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 271,__exchangeMsgHandler);
      }
      
      private function __blackTempHandler(param1:SLGSocketEvent) : void
      {
         var _loc9_:BlackJackMsg = null;
         var _loc4_:BlackJackExchangeMsg = null;
         var _loc5_:BlackjackTempInfo = null;
         var _loc3_:BlackjackExchangeInfo = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:BlackJackListMsg = new BlackJackListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as BlackJackListMsg;
         _blackTempDic = new Dictionary();
         _blackExchangeDic = new Dictionary();
         _loc6_ = 0;
         while(_loc6_ < _loc2_.blackJack.length)
         {
            _loc9_ = _loc2_.blackJack[_loc6_] as BlackJackMsg;
            _loc5_ = new BlackjackTempInfo();
            _loc5_.id = _loc9_.iD;
            _loc5_.cost = _loc9_.cost;
            _loc5_.winItemReward = _loc9_.winItemReward;
            _loc5_.generalItemReward = _loc9_.generalItemReward;
            _loc5_.winScoreReward = _loc9_.winScoreReward;
            _loc5_.generalScoreReward = _loc9_.generalScoreReward;
            _loc5_.changeCardCost = _loc9_.changeCardCost;
            _blackTempDic[_loc5_.id] = _loc5_;
            _loc6_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc2_.blackJackExchange.length)
         {
            _loc4_ = _loc2_.blackJackExchange[_loc8_] as BlackJackExchangeMsg;
            _loc3_ = new BlackjackExchangeInfo();
            _loc3_.id = _loc4_.id;
            _loc3_.score = _loc4_.score;
            _loc3_.rewardItems = _loc4_.rewardItems;
            _blackExchangeDic[_loc3_.id] = _loc3_;
            _loc8_++;
         }
      }
      
      private function __blackRecordHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BlackJackDataMsg = new BlackJackDataMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BlackJackDataMsg;
         _op = _loc2_.op;
         _param1 = _loc2_.param1;
         _score = _loc2_.score;
         var _loc4_:BlackJackBoardMsg = _loc2_.board;
         if(!_blackjackBoardInfo)
         {
            _blackjackBoardInfo = new BlackjackBoardInfo();
         }
         _blackjackBoardInfo.bankerCard = [];
         _blackjackBoardInfo.playerCard = [];
         if(_loc4_)
         {
            _blackjackBoardInfo.rewardId = _loc4_.rewardId;
            _blackjackBoardInfo.banker_card = _loc4_.bankerCard;
            _blackjackBoardInfo.player_card = _loc4_.playerCard;
            _blackjackBoardInfo.stoped = _loc4_.stoped;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("BLACKJACK_RECORD",{
            "op":_op,
            "param1":_param1,
            "score":_score,
            "board":_blackjackBoardInfo
         }));
      }
      
      private function __exchangeMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:BlackJackExchangeNoticeMsg = new BlackJackExchangeNoticeMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as BlackJackExchangeNoticeMsg;
         _blackjackMsgArr = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.exchangeMessage.length)
         {
            _blackjackMsgArr.push(_loc2_.exchangeMessage[_loc3_]);
            _loc3_++;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("BLACKJACK_EXCHANGE_RECORD"));
      }
      
      public function get blackTempDic() : Dictionary
      {
         return _blackTempDic;
      }
      
      public function get blackExchangeDic() : Dictionary
      {
         return _blackExchangeDic;
      }
      
      public function get op() : int
      {
         return _op;
      }
      
      public function set op(param1:int) : void
      {
         _op = param1;
      }
      
      public function get param1() : int
      {
         return _param1;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get blackjackBoardInfo() : BlackjackBoardInfo
      {
         return _blackjackBoardInfo;
      }
      
      public function get blackjackMsgArr() : Array
      {
         return _blackjackMsgArr;
      }
      
      public function OperateBlackjack(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9565);
         var _loc3_:BlackJackReqMsg = new BlackJackReqMsg();
         _loc3_.op = param1;
         _loc3_.param1 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

