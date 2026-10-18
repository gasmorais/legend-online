package yishi.manager
{
   import com.road.yishi.proto.pet.BettingRoundMsg;
   import com.road.yishi.proto.pet.PokerOpMsg;
   import com.road.yishi.proto.pet.PokerPlayerMsg;
   import com.road.yishi.proto.pet.TableActMsg;
   import com.road.yishi.proto.pet.TableActNotifyMsg;
   import com.road.yishi.proto.pet.TableBoardMsg;
   import com.road.yishi.proto.pet.TableChannelMessage;
   import com.road.yishi.proto.pet.TableInfoMsg;
   import com.road.yishi.proto.pet.TablePlayerListMsg;
   import com.road.yishi.proto.pet.TablePlayerMsg;
   import com.road.yishi.proto.pet.TablePotDivisionListMsg;
   import com.road.yishi.proto.pet.TablePotDivisionMsg;
   import com.road.yishi.proto.pet.TableStartedMsg;
   import flash.utils.Dictionary;
   import mvc.module.poker.PokerBoardInfo;
   import mvc.module.poker.PokerPlayerInfo;
   import mvc.module.poker.PokerResultHelper;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class PokerManager
   {
      
      private static var _instance:PokerManager;
      
      private var _pokerTempDic:Dictionary;
      
      private var _pokerExchangeDic:Dictionary;
      
      private var _activePlayersArr:Array = [];
      
      private var _pokerPlayerArr:Array = [];
      
      private var _boardInfo:PokerBoardInfo;
      
      private var _actorInfo:PokerPlayerInfo;
      
      private var _dealerInfo:PokerPlayerInfo;
      
      private var _opStateMsg:PokerPlayerMsg;
      
      private var _dealerPosition:int;
      
      public var pokerCash:int;
      
      public var pokerScore:int;
      
      public var openSign:Boolean = false;
      
      public function PokerManager()
      {
         super();
      }
      
      public static function get instance() : PokerManager
      {
         if(!_instance)
         {
            _instance = new PokerManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 286,__pokerTableHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 284,__pokerJoinHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 285,__playerLeaveHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 278,__boardHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 279,__handStartHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 280,__playerUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 281,__rotatedHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 282,__playerActedHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 283,__actNotifyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 287,__pokerMsgHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 289,__prizesPotHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 290,__pokerChatHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 291,__pokerQuitHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 292,__handEndHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 293,__newRoundHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 328,__startSwitchHandler);
      }
      
      private function __pokerTableHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:TablePlayerMsg = null;
         var _loc14_:PokerPlayerInfo = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TableInfoMsg = new TableInfoMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TableInfoMsg;
         var _loc9_:int = _loc2_.tableType;
         var _loc5_:int = _loc2_.bigBlind;
         var _loc4_:TablePlayerListMsg = _loc2_.players;
         var _loc10_:TablePlayerListMsg = _loc2_.activePlayers;
         var _loc11_:TablePlayerMsg = _loc2_.actor;
         var _loc13_:TableBoardMsg = _loc2_.board;
         _pokerPlayerArr = [];
         _activePlayersArr = [];
         _loc7_ = 0;
         while(_loc7_ < _loc4_.player.length)
         {
            _loc3_ = _loc4_.player[_loc7_] as TablePlayerMsg;
            _loc14_ = new PokerPlayerInfo();
            _loc14_.userId = _loc3_.userId;
            _loc14_.userName = _loc3_.userName;
            _loc14_.serverName = _loc3_.serverName;
            _loc14_.cash = _loc3_.cash;
            _loc14_.bet = _loc3_.bet;
            _loc14_.action = _loc3_.action;
            _loc14_.headId = _loc3_.headId;
            _loc14_.hasCard = _loc3_.hasCard;
            _loc14_.player_card = _loc3_.card;
            _loc14_.handType = _loc3_.handType;
            _loc14_.handValue = _loc3_.handValue;
            _loc14_.rankings = _loc3_.ranking;
            _pokerPlayerArr.push(_loc14_);
            _loc7_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc10_.player.length)
         {
            _loc3_ = _loc10_.player[_loc8_] as TablePlayerMsg;
            _loc14_ = new PokerPlayerInfo();
            _loc14_.userId = _loc3_.userId;
            _loc14_.userName = _loc3_.userName;
            _loc14_.serverName = _loc3_.serverName;
            _loc14_.cash = _loc3_.cash;
            _loc14_.bet = _loc3_.bet;
            _loc14_.action = _loc3_.action;
            _loc14_.headId = _loc3_.headId;
            _loc14_.hasCard = _loc3_.hasCard;
            _loc14_.player_card = _loc3_.card;
            _loc14_.handType = _loc3_.handType;
            _loc14_.handValue = _loc3_.handValue;
            _loc14_.rankings = _loc3_.ranking;
            _activePlayersArr.push(_loc14_);
            _loc8_++;
         }
         if(!_actorInfo)
         {
            _actorInfo = new PokerPlayerInfo();
         }
         _actorInfo.userId = _loc11_.userId;
         _actorInfo.userName = _loc11_.userName;
         _actorInfo.serverName = _loc11_.serverName;
         if(!_dealerInfo)
         {
            _dealerInfo = new PokerPlayerInfo();
         }
         _dealerPosition = _loc2_.dealerPosition;
         var _loc12_:PokerPlayerInfo = _pokerPlayerArr[_loc2_.dealerPosition];
         if(_loc12_)
         {
            _dealerInfo.userId = _loc12_.userId;
            _dealerInfo.userName = _loc12_.userName;
            _dealerInfo.serverName = _loc12_.serverName;
         }
         if(!_boardInfo)
         {
            _boardInfo = new PokerBoardInfo();
         }
         _boardInfo.bet = _loc13_.bet;
         _boardInfo.pot_arr = _loc13_.pot;
         _boardInfo.card_arr = _loc13_.card;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_TABLE"));
      }
      
      private function __pokerJoinHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PokerPlayerInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TablePlayerMsg = new TablePlayerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TablePlayerMsg;
         _loc4_ = getFirstEmptyPoker();
         if(!_loc4_)
         {
            return;
         }
         _loc4_.userId = _loc2_.userId;
         _loc4_.userName = _loc2_.userName;
         _loc4_.serverName = _loc2_.serverName;
         _loc4_.cash = _loc2_.cash;
         _loc4_.bet = _loc2_.bet;
         _loc4_.action = _loc2_.action;
         _loc4_.headId = _loc2_.headId;
         _loc4_.hasCard = _loc2_.hasCard;
         _loc4_.player_card = _loc2_.card;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_TABLE",{"idx":getPokerIdx(_loc4_)}));
      }
      
      private function __playerLeaveHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:PokerPlayerInfo = null;
         var _loc3_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TablePlayerMsg = new TablePlayerMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TablePlayerMsg;
         if(_loc2_.userId == palyerInfo.userId)
         {
            _pokerPlayerArr = [];
            _activePlayersArr = [];
            _boardInfo.totalPot = 0;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_TABLE"));
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < pokerPlayerArr.length)
            {
               _loc4_ = pokerPlayerArr[_loc3_] as PokerPlayerInfo;
               if(_loc4_.userId == _loc2_.userId && _loc4_.serverName == _loc2_.serverName)
               {
                  _loc5_ = _loc3_;
                  _loc4_.userId = 0;
               }
               _loc3_++;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_TABLE",{"idx":_loc5_}));
         }
      }
      
      private function __boardHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TableBoardMsg = new TableBoardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TableBoardMsg;
         if(!_boardInfo)
         {
            return;
         }
         _boardInfo.bet = _loc2_.bet;
         _boardInfo.minBet = _loc2_.minBet;
         _boardInfo.raises = _loc2_.raises;
         _boardInfo.card_arr = _loc2_.card;
         _boardInfo.pot_arr = _loc2_.pot;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_BOARD"));
      }
      
      private function __handStartHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:TablePlayerMsg = null;
         var _loc7_:PokerPlayerInfo = null;
         var _loc8_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TableStartedMsg = new TableStartedMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TableStartedMsg;
         _activePlayersArr = [];
         var _loc3_:TablePlayerListMsg = _loc2_.activePlayers;
         _loc8_ = 0;
         while(_loc8_ < _loc3_.player.length)
         {
            _loc4_ = _loc3_.player[_loc8_] as TablePlayerMsg;
            _loc7_ = new PokerPlayerInfo();
            _loc7_.userId = _loc4_.userId;
            _loc7_.userName = _loc4_.userName;
            _loc7_.serverName = _loc4_.serverName;
            _loc7_.cash = _loc4_.cash;
            _loc7_.bet = _loc4_.bet;
            _loc7_.action = _loc4_.action;
            _loc7_.headId = _loc4_.headId;
            _loc7_.hasCard = _loc4_.hasCard;
            _loc7_.player_card = _loc4_.card;
            _activePlayersArr.push(_loc7_);
            _loc8_++;
         }
         if(!_dealerInfo)
         {
            _dealerInfo = new PokerPlayerInfo();
         }
         _dealerPosition = _loc2_.dealerPosition;
         var _loc5_:PokerPlayerInfo = _pokerPlayerArr[_loc2_.dealerPosition];
         if(_loc5_)
         {
            _dealerInfo.userId = _loc5_.userId;
            _dealerInfo.userName = _loc5_.userName;
            _dealerInfo.serverName = _loc5_.serverName;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_HAND_START"));
      }
      
      private function __playerUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PokerPlayerInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TablePlayerMsg = new TablePlayerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TablePlayerMsg;
         _loc4_ = getPokerPlayerById(_loc2_.userId,_loc2_.serverName);
         if(!_loc4_)
         {
            return;
         }
         _loc4_.userId = _loc2_.userId;
         _loc4_.userName = _loc2_.userName;
         _loc4_.serverName = _loc2_.serverName;
         _loc4_.cash = _loc2_.cash;
         _loc4_.bet = _loc2_.bet;
         _loc4_.action = _loc2_.action;
         _loc4_.headId = _loc2_.headId;
         _loc4_.hasCard = _loc2_.hasCard;
         _loc4_.player_card = _loc2_.card;
         _loc4_.handType = _loc2_.handType;
         _loc4_.handValue = _loc2_.handValue;
         _loc4_.rankings = _loc2_.ranking;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_PLAYER_UPDATE",_loc4_));
      }
      
      private function __rotatedHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PokerPlayerInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TablePlayerMsg = new TablePlayerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TablePlayerMsg;
         _loc4_ = getPokerPlayerById(_loc2_.userId,_loc2_.serverName);
         if(!_loc4_)
         {
            return;
         }
         _actorInfo.userId = _loc2_.userId;
         _actorInfo.userName = _loc2_.userName;
         _actorInfo.serverName = _loc2_.serverName;
         _actorInfo.cash = _loc4_.cash;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_ROTATE",_actorInfo));
      }
      
      private function __playerActedHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PokerPlayerInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TablePlayerMsg = new TablePlayerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TablePlayerMsg;
         _loc4_ = getPokerPlayerById(_loc2_.userId,_loc2_.serverName);
         if(!_loc4_)
         {
            return;
         }
         _loc4_.userId = _loc2_.userId;
         _loc4_.userName = _loc2_.userName;
         _loc4_.serverName = _loc2_.serverName;
         _loc4_.cash = _loc2_.cash;
         _loc4_.bet = _loc2_.bet;
         _loc4_.action = _loc2_.action;
         _loc4_.headId = _loc2_.headId;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_PLAYER_ACTED",_loc4_));
      }
      
      private function __actNotifyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TableActNotifyMsg = new TableActNotifyMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TableActNotifyMsg;
         var _loc7_:PokerPlayerInfo = getPokerMyself();
         var _loc5_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.action.length)
         {
            _loc5_.push(_loc2_.action[_loc4_]);
            _loc4_++;
         }
         var _loc3_:int = _loc2_.minBet;
         var _loc8_:int = _loc2_.currentBet;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_ACTE_NOTIFY",{
            "info":_loc7_,
            "list":_loc5_,
            "minBet":_loc3_,
            "currentBet":_loc8_
         }));
      }
      
      private function __pokerMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PokerPlayerMsg = new PokerPlayerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PokerPlayerMsg;
         if(!_opStateMsg)
         {
            _opStateMsg = new PokerPlayerMsg();
         }
         _opStateMsg.userId = _loc2_.userId;
         _opStateMsg.userName = _loc2_.userName;
         _opStateMsg.serverName = _loc2_.serverName;
         _opStateMsg.cash = _loc2_.cash;
         _opStateMsg.state = _loc2_.state;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_PLAYER_MSG"));
      }
      
      private function __prizesPotHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:TablePotDivisionMsg = null;
         var _loc5_:PokerPlayerInfo = null;
         var _loc6_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TablePotDivisionListMsg = new TablePotDivisionListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TablePotDivisionListMsg;
         _activePlayersArr = [];
         _loc6_ = 0;
         while(_loc6_ < _loc2_.potDivision.length)
         {
            _loc3_ = _loc2_.potDivision[_loc6_] as TablePotDivisionMsg;
            _loc5_ = getPokerPlayerById(_loc3_.player.userId,_loc3_.player.serverName);
            if(_loc5_)
            {
               _loc3_.handType = _loc5_.handType;
               _loc3_.handValue = _loc5_.handValue;
               if(_loc5_.rankings.length)
               {
                  _loc3_.rankingArr = PokerResultHelper.getResultCardArr(_loc5_);
               }
            }
            _loc6_++;
         }
         _loc2_.potDivision.sort(sortFun);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POT_PRIZES_MSG",_loc2_));
      }
      
      protected function sortFun(param1:TablePotDivisionMsg, param2:TablePotDivisionMsg) : Number
      {
         if(param1.handValue > param2.handValue)
         {
            return -1;
         }
         if(param1.handValue == param2.handValue)
         {
            return 0;
         }
         return 1;
      }
      
      private function __pokerChatHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TableChannelMessage = new TableChannelMessage();
         _loc2_ = _loc3_.readBody(_loc2_) as TableChannelMessage;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_CHAT_MSG",_loc2_));
      }
      
      private function __pokerQuitHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PokerPlayerMsg = new PokerPlayerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PokerPlayerMsg;
         if(_loc2_.userId == palyerInfo.userId && _loc2_.serverName == palyerInfo.serviceName)
         {
            FrameControllerManager.instance.pokerControler.showPoker = false;
         }
      }
      
      private function __handEndHandler(param1:SLGSocketEvent) : void
      {
         _activePlayersArr = [];
         _boardInfo.bet = 0;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_HAND_END"));
      }
      
      private function __newRoundHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BettingRoundMsg = new BettingRoundMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BettingRoundMsg;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_NEW_ROUND"));
      }
      
      private function __startSwitchHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PokerOpMsg = new PokerOpMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PokerOpMsg;
         openSign = _loc2_.param3;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function get pokerTempDic() : Dictionary
      {
         return _pokerTempDic;
      }
      
      public function get pokerExchangeDic() : Dictionary
      {
         return _pokerExchangeDic;
      }
      
      public function get pokerPlayerArr() : Array
      {
         return _pokerPlayerArr;
      }
      
      public function get activePlayersArr() : Array
      {
         return _activePlayersArr;
      }
      
      public function clearPokerPlayerArr() : void
      {
         _pokerPlayerArr = [];
         _activePlayersArr = [];
      }
      
      public function get boardInfo() : PokerBoardInfo
      {
         return _boardInfo;
      }
      
      public function get actorInfo() : PokerPlayerInfo
      {
         return _actorInfo;
      }
      
      public function get dealerInfo() : PokerPlayerInfo
      {
         return _dealerInfo;
      }
      
      public function get opStateMsg() : PokerPlayerMsg
      {
         return _opStateMsg;
      }
      
      public function get dealerPosition() : int
      {
         return _dealerPosition;
      }
      
      public function getFirstEmptyPoker() : PokerPlayerInfo
      {
         var _loc2_:PokerPlayerInfo = null;
         var _loc3_:PokerPlayerInfo = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _pokerPlayerArr.length)
         {
            _loc2_ = _pokerPlayerArr[_loc1_] as PokerPlayerInfo;
            if(_loc2_.userId == 0)
            {
               _loc3_ = _loc2_;
               break;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function getPokerIdx(param1:PokerPlayerInfo) : int
      {
         var _loc3_:PokerPlayerInfo = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _pokerPlayerArr.length)
         {
            _loc3_ = _pokerPlayerArr[_loc2_] as PokerPlayerInfo;
            if(_loc3_.userId == param1.userId && _loc3_.userName == param1.userName)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getPokerPlayerById(param1:int, param2:String) : PokerPlayerInfo
      {
         var _loc4_:PokerPlayerInfo = null;
         var _loc5_:PokerPlayerInfo = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _pokerPlayerArr.length)
         {
            _loc4_ = _pokerPlayerArr[_loc3_] as PokerPlayerInfo;
            if(param1 != 0 && _loc4_.userId == param1 && _loc4_.serverName == param2)
            {
               _loc5_ = _loc4_;
            }
            _loc3_++;
         }
         return _loc5_;
      }
      
      public function getMyselfPokerIdx() : int
      {
         var _loc2_:PokerPlayerInfo = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _pokerPlayerArr.length)
         {
            _loc2_ = _pokerPlayerArr[_loc1_] as PokerPlayerInfo;
            if(_loc2_.userId == palyerInfo.userId)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
      
      public function getPokerMyself() : PokerPlayerInfo
      {
         var _loc2_:PokerPlayerInfo = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _pokerPlayerArr.length)
         {
            _loc2_ = _pokerPlayerArr[_loc1_] as PokerPlayerInfo;
            if(_loc2_.userId == palyerInfo.userId)
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return null;
      }
      
      public function checkPlayerActive() : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc2_:int = 0;
         var _loc1_:Array = PokerManager.instance.activePlayersArr;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].userId == palyerInfo.userId)
            {
               _loc3_ = true;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function getPokerPlayerNum() : int
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = PokerManager.instance.pokerPlayerArr;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].userId != 0)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get palyerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function RequestPoker(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9571);
         var _loc3_:PokerOpMsg = new PokerOpMsg();
         _loc3_.op = param1;
         _loc3_.userId = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _loc3_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         _loc3_.param1 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function StartPoker(param1:int, param2:int = 0, param3:TableChannelMessage = null) : void
      {
         var _loc5_:PackageOut = new PackageOut(25167);
         var _loc4_:PokerOpMsg = new PokerOpMsg();
         _loc4_.op = param1;
         _loc4_.userId = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _loc4_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         _loc4_.param1 = param2;
         _loc4_.msg = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function StopPoker(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(25165);
         var _loc3_:TablePlayerMsg = new TablePlayerMsg();
         _loc3_.userId = param1;
         _loc3_.serverName = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function OperatePoker(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(25166);
         var _loc3_:TableActMsg = new TableActMsg();
         _loc3_.action = param1;
         _loc3_.amount = param2;
         _loc3_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

