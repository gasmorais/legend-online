package mvc.module.chess
{
   import com.road.yishi.proto.chat.ChessRoomMsg;
   import com.road.yishi.proto.chat.SelfChessPlayerMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import yishi.actions.base.AlertTipAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class SelfChessManager
   {
      
      private static var _ins:SelfChessManager;
      
      public static const CHESS_OP_MATCH:int = 1;
      
      public static const CHESS_OP_MATCH_CANCEL:int = 2;
      
      public static const CHESS_OP_BUY_CHESS:int = 3;
      
      public static const CHESS_OP_DEL_CHESS:int = 4;
      
      public static const CHESS_OP_CHANGE_CHESS:int = 5;
      
      public static const CHESS_OP_REFRESH:int = 6;
      
      public static const CHESS_OP_ADD_EXP:int = 7;
      
      public static const CHESS_OP_OUT_ROOM:int = 8;
      
      public static const CHESS_OP_UPDATE_DATA:int = 9;
      
      public static const CHESS_OP_LOCK:int = 10;
      
      private var _model:SelfChessModel;
      
      public var ROOM_MAX:int;
      
      private var userId:int;
      
      private var serverName:String;
      
      public function SelfChessManager()
      {
         super();
         _model = new SelfChessModel();
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("chess_room_num");
         ROOM_MAX = int(_loc1_.ConfigValue);
         userId = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
      }
      
      public static function get Ins() : SelfChessManager
      {
         if(_ins == null)
         {
            _ins = new SelfChessManager();
         }
         return _ins;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4216,receivePlayerInfos);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4218,receiveStateInfos);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4217,receivegameOverInfos);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4219,tipInfosHandler);
      }
      
      private function tipInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         var _loc3_:String = LanguageMgr.GetTranslation("selfchess.serverTip" + _loc2_.param1);
         MessageTipManager.instance().show(_loc3_);
      }
      
      private function receivePlayerInfos(param1:SLGSocketEvent) : void
      {
         var _loc12_:SelfChessPlayerInfo = null;
         var _loc11_:String = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChessRoomMsg = new ChessRoomMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as ChessRoomMsg;
         _model.roomUuid = _loc2_.roomUuid;
         _model.round = _loc2_.round;
         _model.state = _loc2_.state;
         var _loc3_:int = _loc2_.op;
         for each(var _loc4_:SelfChessPlayerMsg in _loc2_.playerList)
         {
            _loc11_ = _loc4_.userId + "_" + _loc4_.serverName;
            _loc12_ = _model.playerList[_loc11_];
            if(_loc12_ == null)
            {
               _loc12_ = new SelfChessPlayerInfo();
               _model.playerList.add(_loc11_,_loc12_);
            }
            _loc12_.userId = _loc4_.userId;
            _loc12_.serverName = _loc4_.serverName;
            _loc12_.name = _loc4_.name;
            _loc12_.hp = _loc4_.hp;
            _loc12_.gold = _loc4_.gold;
            _loc12_.grade = _loc4_.grade;
            _loc12_.exp = _loc4_.exp;
            _loc12_.winCount = _loc4_.winCount;
            _loc12_.lock = _loc4_.lock;
            _loc12_.rank = _loc4_.rank;
            if(!_loc12_.isSelf && _loc12_.userId == userId && _loc12_.serverName == serverName)
            {
               _loc12_.isSelf = true;
            }
            _loc6_ = int(_loc4_.battleAry ? _loc4_.battleAry.length : 0);
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc5_ = int(_loc12_.battleAry[_loc8_]);
               _loc7_ = int(_loc4_.battleAry[_loc8_]);
               _loc12_.battleAry[_loc8_] = _loc7_;
               if(_loc12_.isSelf && _loc5_ != _loc7_)
               {
                  _loc9_ = true;
               }
               _loc8_++;
            }
            _loc6_ = int(_loc4_.alternateAry ? _loc4_.alternateAry.length : 0);
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc12_.alternateAry[_loc8_] = _loc4_.alternateAry[_loc8_];
               _loc8_++;
            }
            _loc6_ = int(_loc4_.cardPool ? _loc4_.cardPool.length : 0);
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc12_.cardPool[_loc8_] = _loc4_.cardPool[_loc8_];
               _loc8_++;
            }
            if(_loc9_)
            {
               _model.resetSelfJobNum();
            }
         }
         NotificationManager.instance.sendNotification("SELF_CHESS_UPDATA",_loc3_);
      }
      
      private function receiveStateInfos(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         _model.playerNum = _loc2_.param1;
         SevenYearManager.instance.model.snowTeamNum = _loc2_.param1;
         MsgMan.notifyObserver("UPDATE_SNOW_TEAM_COUNT");
      }
      
      private function receivegameOverInfos(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         var _loc4_:SelfChessGameoverInfo = new SelfChessGameoverInfo();
         _loc4_.rank = _loc2_.param1;
         _loc4_.score = _loc2_.param2;
         DelayActionsUtils.instance.addAction(new AlertTipAction(_loc4_,gameOverHandler,"SELF_CHESS_SCENE"));
      }
      
      private function gameOverHandler(param1:SelfChessGameoverInfo) : void
      {
         FrameControllerManager.instance.openControllerByInfo("selfchess",null,param1);
         _model.clear();
      }
      
      public function get model() : SelfChessModel
      {
         return _model;
      }
      
      public function sendOp(param1:int, param2:int = -1, param3:int = -1) : void
      {
         if(_model.selfInfo == null)
         {
            return;
         }
         var _loc5_:PackageOut = new PackageOut(25031);
         var _loc4_:PropertyMsg = new PropertyMsg();
         _loc4_.param1 = param1;
         _loc4_.param2 = _model.selfInfo.userId;
         _loc4_.param4 = _model.selfInfo.serverName;
         _loc4_.param5 = _model.roomUuid;
         _loc4_.param3 = param2;
         _loc4_.param11 = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendMatch(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9701);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function exitGame() : void
      {
         sendOp(8);
         _model.clear();
      }
   }
}

