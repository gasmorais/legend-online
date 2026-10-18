package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.consortiaplay.ChessPvpBoardMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpBoardOpMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpBoardResultMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpBoardUpdateMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpBoxMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpGroupMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpGroupRankMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpRankListMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpRankMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpRecordListMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpRecordMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpRoleMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpTeamMsg;
   import com.road.yishi.proto.consortiaplay.ChessPvpUserMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import flash.utils.Dictionary;
   import mvc.module.chesspvp.ChessPvpBoardInfo;
   import mvc.module.chesspvp.ChessPvpGroupInfo;
   import mvc.module.chesspvp.ChessPvpModel;
   import mvc.module.chesspvp.ChessPvpOp;
   import mvc.module.chesspvp.ChesspvpBoxInfo;
   import mvc.module.chesspvp.ChesspvpRankInfo;
   import mvc.module.chesspvp.ChesspvpRecordInfo;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   import mvc.module.chesspvp.ChesspvpTeamInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   
   public class ChessPvpManager
   {
      
      private static var _ins:ChessPvpManager;
      
      private var _model:ChessPvpModel;
      
      private var _SelfKey:String;
      
      public function ChessPvpManager()
      {
         super();
         _model = new ChessPvpModel();
      }
      
      public static function get Instance() : ChessPvpManager
      {
         if(_ins == null)
         {
            _ins = new ChessPvpManager();
         }
         return _ins;
      }
      
      public function get model() : ChessPvpModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _SelfKey = PlayerManager.instance.currentPlayerModel.playerInfo.userId + "_" + PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         SocketManager.instance.addEventListener("SLGSocketEvent" + 561,__pvpMatchDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 562,__rankHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 563,__recordHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 564,__pvpBattleDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 565,__pvpBattleUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 566,__pvpBattleResultHandler);
      }
      
      private function __pvpBattleResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChessPvpBoardResultMsg = new ChessPvpBoardResultMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChessPvpBoardResultMsg;
         readTeam(_loc2_.teams);
         _model.result = _loc2_.result;
         if(FrameControllerManager.instance.chessPvpCtl.frame != null)
         {
            FrameControllerManager.instance.openControllerByInfo("chesspvp",3);
         }
         else
         {
            _model.needAlertResult = true;
         }
      }
      
      private function __pvpMatchDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ChessPvpGroupInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChessPvpMsg = new ChessPvpMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ChessPvpMsg;
         var _loc4_:int = _loc2_.op;
         var _loc6_:ChessPvpGroupMsg = _loc2_.group;
         if(_loc6_)
         {
            _loc5_ = _model.selfGroupInfo;
            _loc5_.op = _loc6_.op;
            _loc5_.currTime = _loc6_.currTime;
            _loc5_.beginTime = _loc6_.beginTime;
            _loc5_.endTime = _loc6_.endTime;
            _loc5_.group = _loc6_.group;
            _loc5_.score = _loc6_.score;
            _loc5_.state = _loc6_.state;
            _loc5_.rivalName = _loc6_.rivalName;
            _loc5_.rivalServerName = _loc6_.rivalServerName;
            _loc5_.rivalScore = _loc6_.rivalScore;
            _loc5_.isSignUp = _loc6_.isSignUp;
            _loc5_.rank = _loc6_.rank;
         }
         var _loc8_:Dictionary = _model.chessTypeDic;
         if(_loc4_ == ChessPvpOp.OP_OPEN)
         {
            _model.clean();
         }
         for each(var _loc3_:ChessPvpUserMsg in _loc2_.userList)
         {
            _loc8_[_loc3_.userId] = _loc3_.chessType;
         }
         NotificationManager.instance.sendNotification(ChessPvpOp.EVENT_OP_FUN,[_loc4_]);
      }
      
      private function __rankHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ChesspvpRankInfo = null;
         var _loc6_:Array = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChessPvpRankListMsg = new ChessPvpRankListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ChessPvpRankListMsg;
         var _loc9_:Dictionary = new Dictionary();
         for each(var _loc5_:ChessPvpGroupRankMsg in _loc2_.groups)
         {
            _loc6_ = [];
            _loc9_[_loc5_.group] = _loc6_;
            for each(var _loc8_:ChessPvpRankMsg in _loc5_.ranks)
            {
               _loc4_ = new ChesspvpRankInfo();
               _loc4_.rank = _loc8_.rank;
               _loc4_.name = _loc8_.name;
               _loc4_.serverName = _loc8_.serverName;
               _loc4_.score = _loc8_.score;
               _loc4_.fightPower = Int64Utils.int64ToNumber(_loc8_.fightPower);
               _loc6_.push(_loc4_);
            }
         }
         _model.rankTime = _loc2_.rankTime;
         var _loc3_:int = ChessPvpOp.OP_VIEW_RANK;
         NotificationManager.instance.sendNotification(ChessPvpOp.EVENT_OP_FUN,[_loc3_,_loc9_]);
      }
      
      private function __recordHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChessPvpRecordListMsg = new ChessPvpRecordListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ChessPvpRecordListMsg;
         var _loc4_:Array = [];
         readRecord(_loc2_.currWeek,_loc4_);
         _loc4_.sortOn("sortNum",0x10 | 2);
         var _loc6_:Array = [];
         readRecord(_loc2_.lastWeek,_loc6_);
         _loc6_.sortOn("sortNum",0x10 | 2);
         var _loc3_:int = ChessPvpOp.OP_VIEW_RECORD;
         NotificationManager.instance.sendNotification(ChessPvpOp.EVENT_OP_FUN,[_loc3_,_loc4_,_loc6_]);
      }
      
      private function readRecord(param1:Array, param2:Array) : void
      {
         var _loc6_:ChesspvpRecordInfo = null;
         var _loc3_:ChessPvpRecordMsg = null;
         var _loc5_:int = 0;
         var _loc4_:int = int(param1 ? param1.length : 0);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = param1[_loc5_];
            _loc6_ = new ChesspvpRecordInfo();
            _loc6_.recordDate = _loc3_.recordDate;
            _loc6_.result = _loc3_.result;
            _loc6_.group = _loc3_.group;
            _loc6_.name = _loc3_.name;
            _loc6_.serverName = _loc3_.serverName;
            _loc6_.addScore = _loc3_.addScore;
            _loc6_.rivalGroup = _loc3_.rivalGroup;
            _loc6_.rivalName = _loc3_.rivalName;
            _loc6_.rivalServerName = _loc3_.rivalServerName;
            _loc6_.rivalAddScore = _loc3_.rivalAddScore;
            param2.push(_loc6_);
            _loc5_++;
         }
      }
      
      private function __pvpBattleDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChessPvpBoardMsg = new ChessPvpBoardMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ChessPvpBoardMsg;
         var _loc3_:ChessPvpBoardInfo = _model.boradInfo;
         _loc3_.boardUid = _loc2_.boardUid;
         _loc3_.currTime = _loc2_.currTime;
         _loc3_.endTime = _loc2_.endTime;
         readTeam(_loc2_.teams);
         readBox(_loc2_.boxes);
         readRole(_loc2_.roles);
         FrameControllerManager.instance.openControllerByInfo("chesspvp",1);
      }
      
      private function readTeam(param1:Array) : void
      {
         var _loc4_:ChesspvpTeamInfo = null;
         var _loc3_:ChessPvpBoardInfo = _model.boradInfo;
         for each(var _loc2_:ChessPvpTeamMsg in param1)
         {
            _loc4_ = _loc3_.teamDic[_loc2_.team];
            if(_loc4_ == null)
            {
               _loc4_ = new ChesspvpTeamInfo();
               _loc3_.teamDic.add(_loc2_.team,_loc4_);
            }
            _loc4_.team = _loc2_.team;
            _loc4_.name = _loc2_.name;
            _loc4_.serverName = _loc2_.serverName;
            _loc4_.score = _loc2_.score;
            _loc4_.group = _loc2_.group;
            _loc4_.addScore = _loc2_.addScore;
         }
      }
      
      private function readBox(param1:Array) : void
      {
         var _loc2_:ChesspvpBoxInfo = null;
         var _loc4_:ChessPvpBoardInfo = _model.boradInfo;
         for each(var _loc3_:ChessPvpBoxMsg in param1)
         {
            _loc2_ = _loc4_.boxDic[_loc3_.pos];
            if(_loc2_ == null)
            {
               _loc2_ = new ChesspvpBoxInfo();
               _loc4_.boxDic.add(_loc3_.pos,_loc2_);
            }
            _loc2_.pos = _loc3_.pos;
            _loc2_.buffId = _loc3_.buffId;
            _loc2_.team = _loc3_.team;
            _loc2_.copyBlackList(_loc3_.blackList);
            _loc2_.copyWhiteList(_loc3_.whiteList);
         }
      }
      
      private function readRole(param1:Array) : void
      {
         var _loc4_:ChesspvpRoleInfo = null;
         var _loc6_:String = null;
         var _loc7_:ChessPvpBoardInfo = _model.boradInfo;
         var _loc5_:int = -1;
         var _loc2_:Array = [];
         for each(var _loc3_:ChessPvpRoleMsg in param1)
         {
            _loc4_ = _loc7_.roleDic[_loc3_.roleId];
            if(_loc4_ == null)
            {
               _loc4_ = new ChesspvpRoleInfo();
               _loc7_.roleDic.add(_loc3_.roleId,_loc4_);
            }
            _loc4_.livingID = _loc3_.roleId;
            _loc4_.userID = _loc3_.userId;
            _loc4_.servername = _loc3_.serverName;
            _loc4_.nikeName = _loc3_.nickName;
            _loc4_.team = _loc3_.team;
            _loc4_.currPos = _loc3_.currPos;
            _loc4_.targetPos = _loc3_.targetPos;
            _loc4_.chessType = _loc3_.chessType;
            _loc4_.movePassTime = _loc3_.movePassTime;
            _loc4_.needMoveTime = _loc3_.moveTotalTime;
            _loc4_.reiverTime = _loc3_.reiverTime;
            _loc4_.reiverCd = _loc3_.reiverCd;
            _loc4_.firstMove = _loc3_.firstMove;
            _loc4_.waitCd = _loc3_.waitCd;
            _loc4_.state = _loc3_.state;
            _loc4_.color = 3;
            _loc6_ = _loc3_.userId + "_" + _loc3_.serverName;
            if(_loc6_ == _SelfKey)
            {
               _model.selfInfo = _loc4_;
               _loc4_.color = 1;
               _loc5_ = _loc4_.team;
            }
            _loc2_.push(_loc4_);
         }
         if(_loc5_ == -1 && _model.selfInfo)
         {
            _loc5_ = _model.selfInfo.team;
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.team == _loc5_ && _loc4_.color == 3)
            {
               _loc4_.color = 2;
            }
         }
      }
      
      private function __pvpBattleUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChessPvpBoardUpdateMsg = new ChessPvpBoardUpdateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChessPvpBoardUpdateMsg;
         readTeam(_loc2_.teams);
         readBox(_loc2_.boxes);
         readRole(_loc2_.roles);
         NotificationManager.instance.sendNotification(ChessPvpOp.EVENT_CHESS_UPDATE);
      }
      
      public function operFun(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9730);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = param1;
         _loc4_.userId = param2;
         _loc4_.type = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function operChess(param1:int, param2:String, param3:int, param4:String, param5:int = -1, param6:int = -1) : void
      {
         var _loc8_:PackageOut = new PackageOut(25232);
         var _loc7_:ChessPvpBoardOpMsg = new ChessPvpBoardOpMsg();
         _loc7_.op = param1;
         _loc7_.boardUid = param2;
         _loc7_.userId = param3;
         _loc7_.serverName = param4;
         _loc7_.targePos = param5;
         _loc7_.chessType = param6;
         SocketManager.instance.socket.sendProtobuffer(_loc8_,_loc7_);
      }
   }
}

