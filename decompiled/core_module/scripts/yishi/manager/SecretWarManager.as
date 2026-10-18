package yishi.manager
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.exploitsshop.ExploitsShopPanelRespMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.secretwar.SecretWarCreateMsg;
   import com.road.yishi.proto.secretwar.SecretWarInfoMsg;
   import com.road.yishi.proto.secretwar.SecretWarMoveListMsg;
   import com.road.yishi.proto.secretwar.SecretWarMoveMsg;
   import com.road.yishi.proto.secretwar.SecretWarNodeMsg;
   import com.road.yishi.proto.secretwar.SecretWarPlayerMsg;
   import com.road.yishi.proto.secretwar.SecretWarRankListMsg;
   import com.road.yishi.proto.secretwar.SecretWarRankMsg;
   import com.road.yishi.proto.secretwar.SecretWarResultMsg;
   import com.road.yishi.proto.secretwar.SecretWarSelfMsg;
   import com.road.yishi.proto.secretwar.SecretWarUpdateMsg;
   import com.road.yishi.proto.secretwar.SecretWarUserDataMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.utils.setTimeout;
   import mvc.module.war2023.SecretWarModel;
   import mvc.module.war2023.info.SecretWarInfo;
   import mvc.module.war2023.info.SecretWarNodeInfo;
   import mvc.module.war2023.info.SecretWarRankInfo;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import mvc.module.war2023.info.SecretwarResultInfo;
   import mvc.module.war2023.info.SecretwarSelfInfo;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   
   public class SecretWarManager
   {
      
      public static var loginToSecretWarFlag:Boolean;
      
      private static var _instance:SecretWarManager;
      
      public var isOpen:Boolean;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var rewardCount:int;
      
      public var rewardShow:String = "";
      
      private var _model:SecretWarModel;
      
      private var _selfKey:String;
      
      public function SecretWarManager()
      {
         super();
         _model = new SecretWarModel();
      }
      
      public static function get Instance() : SecretWarManager
      {
         if(_instance == null)
         {
            _instance = new SecretWarManager();
         }
         return _instance;
      }
      
      public function get model() : SecretWarModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 544,__creatMapHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 545,__updateWarHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 546,__selfUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 547,__rankListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 548,__resultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 549,__moveHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__topBtnHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 550,_rewardHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 540,__exploitsShopHandler);
      }
      
      public function clear() : void
      {
         _model.restData();
      }
      
      private function __exploitsShopHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ExploitsShopPanelRespMsg = new ExploitsShopPanelRespMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ExploitsShopPanelRespMsg;
         model.shopInfo = _loc2_.shopInfo;
         model.refreshCounts = _loc2_.refreshCounts;
         NotificationManager.instance.sendNotification("secretwarShopEvent");
      }
      
      private function _rewardHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretWarUserDataMsg = new SecretWarUserDataMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SecretWarUserDataMsg;
         rewardCount = _loc2_.rewardCount;
         rewardShow = _loc2_.rewardShow;
         NotificationManager.instance.sendNotification("secretwarRewardEvent");
      }
      
      private function __topBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 4029)
         {
            isOpen = _loc2_.param7;
            openTime = _loc2_.param4;
            stopTime = _loc2_.param5;
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function __creatMapHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         _selfKey = _loc5_.userId + "_" + _loc5_.serviceName;
         _model.restData();
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretWarCreateMsg = new SecretWarCreateMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as SecretWarCreateMsg;
         readWarInfo(_loc2_.info);
         readSelfInfo(_loc2_.self);
         for each(var _loc4_:SecretWarNodeMsg in _loc2_.nodes)
         {
            readNodeInfo(_loc4_);
         }
         for each(var _loc3_:SecretWarPlayerMsg in _loc2_.players)
         {
            readPlayerInfo(_loc3_);
         }
         if(SceneManager.instance.currentType != "SECRET_WAR_SCENE")
         {
            SceneManager.instance.setScene("SECRET_WAR_SCENE");
         }
      }
      
      private function readNodeInfo(param1:SecretWarNodeMsg) : void
      {
         var _loc2_:SecretWarNodeInfo = _model.nodeInfos[param1.nodeId];
         if(_loc2_)
         {
            _loc2_.type = param1.type;
            _loc2_.cdTime = param1.cdTime;
            _loc2_.isPop = param1.isPop;
         }
      }
      
      private function readPlayerInfo(param1:SecretWarPlayerMsg) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:String = param1.userId + "_" + param1.serverName;
         var _loc2_:SecretwarPlayInfo = _model.playerList[_loc3_];
         if(!_loc2_)
         {
            _loc2_ = new SecretwarPlayInfo();
            _model.playerList[_loc3_] = _loc2_;
            if(_loc3_ == _selfKey)
            {
               _model.selfPlay = _loc2_;
            }
         }
         _loc2_.userId = param1.userId;
         _loc2_.serverName = param1.serverName;
         _loc2_.nickName = param1.nickName;
         _loc2_.camp = param1.camp;
         _loc2_.curNodeId = param1.curNodeId;
         _loc2_.toNodeId = param1.toNodeId;
         _loc2_.moveStep = param1.moveStep;
         _loc2_.headId = param1.headId;
         _loc2_.job = param1.job;
         _loc2_.fightUserId = param1.fightUserId;
         _loc2_.fightNickName = param1.fightNickName;
         _loc2_.fightServerName = param1.fightServerName;
         _loc2_.state = param1.state;
         _loc2_.cdTime = param1.cdTime;
         _model.updateNodePlayers(_loc2_);
      }
      
      private function readSelfInfo(param1:SecretWarSelfMsg) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:SecretwarSelfInfo = _model.selfInfo;
         _loc2_.camp = param1.camp;
         _loc2_.score = param1.score;
         _loc2_.honor = param1.honor;
         _loc2_.waitMove = param1.waitMove;
         NotificationManager.instance.sendNotification("secretwarUpdateSelfEvent");
      }
      
      private function readWarInfo(param1:SecretWarInfoMsg) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:SecretWarInfo = _model.warInfo;
         _loc2_.blueScore = param1.blueScore;
         _loc2_.bluePlayerCount = param1.bluePlayerCount;
         _loc2_.blueNodeCount = param1.blueNodeCount;
         _loc2_.redScore = param1.redScore;
         _loc2_.redPlayerCount = param1.redPlayerCount;
         _loc2_.redNodeCount = param1.redNodeCount;
         _loc2_.curTime = param1.curTime;
         _loc2_.preTime = param1.preTime;
         _loc2_.stopTime = param1.stopTime;
         NotificationManager.instance.sendNotification("secretwarUpdateWarEvent");
      }
      
      private function __updateWarHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretWarUpdateMsg = new SecretWarUpdateMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SecretWarUpdateMsg;
         readWarInfo(_loc2_.info);
         for each(var _loc4_:SecretWarNodeMsg in _loc2_.nodes)
         {
            readNodeInfo(_loc4_);
         }
         for each(var _loc3_:SecretWarPlayerMsg in _loc2_.players)
         {
            readPlayerInfo(_loc3_);
         }
      }
      
      private function __selfUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretWarSelfMsg = new SecretWarSelfMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SecretWarSelfMsg;
         readSelfInfo(_loc2_);
      }
      
      private function __rankListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretWarRankListMsg = new SecretWarRankListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SecretWarRankListMsg;
         var _loc5_:SecretwarResultInfo = _model.resultInfo;
         _loc5_.clear();
         for each(var _loc3_:SecretWarRankMsg in _loc2_.ranks)
         {
            readRankInfo(_loc3_);
         }
         _loc5_.doRank();
         NotificationManager.instance.sendNotification("secretwarRankListEvent");
      }
      
      private function readRankInfo(param1:SecretWarRankMsg) : void
      {
         var _loc2_:SecretWarRankInfo = new SecretWarRankInfo();
         _loc2_.rank = param1.rank;
         _loc2_.userId = param1.userId;
         _loc2_.serverName = param1.serverName;
         _loc2_.nickName = param1.nickName;
         _loc2_.job = param1.job;
         _loc2_.camp = param1.camp;
         _loc2_.kill = param1.kill;
         _loc2_.occupy = param1.occupy;
         _loc2_.score = param1.score;
         _loc2_.fightPower = param1.fightPower;
         _loc2_.isReward = param1.isReward;
         _loc2_.exploits = param1.exploits;
         _model.resultInfo.allkList.push(_loc2_);
         if(_loc2_.camp == 1)
         {
            _model.resultInfo.blueList.push(_loc2_);
         }
         else if(_loc2_.camp == 2)
         {
            _model.resultInfo.redList.push(_loc2_);
         }
      }
      
      private function __resultHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretWarResultMsg = new SecretWarResultMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SecretWarResultMsg;
         var _loc5_:SecretwarResultInfo = _model.resultInfo;
         _loc5_.winCamp = _loc2_.winCamp;
         _loc5_.blueScore = _loc2_.blueScore;
         _loc5_.redScore = _loc2_.redScore;
         _loc5_.isOver = true;
         _loc5_.clear();
         for each(var _loc3_:SecretWarRankMsg in _loc2_.ranks)
         {
            readRankInfo(_loc3_);
         }
         _loc5_.doRank();
         if(SceneManager.instance.currentType == "SECRET_WAR_SCENE")
         {
            gotoSpace();
         }
         else
         {
            setTimeout(gotoSpace,2000);
         }
      }
      
      private function gotoSpace() : void
      {
         var _loc1_:Object = {"isSecretwarResult":true};
         SwitchPageHelp.returnToSpace(_loc1_);
      }
      
      private function __moveHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:SecretwarPlayInfo = null;
         var _loc7_:String = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretWarMoveListMsg = new SecretWarMoveListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as SecretWarMoveListMsg;
         var _loc5_:Array = [];
         for each(var _loc4_:SecretWarMoveMsg in _loc2_.list)
         {
            _loc7_ = "" + _loc4_.userId + _loc4_.serverName;
            _loc3_ = _model.playerList[_loc7_];
            if(_loc3_)
            {
               _loc3_.userId = _loc4_.userId;
               _loc3_.serverName = _loc4_.serverName;
               _loc3_.nickName = _loc4_.nickName;
               _loc3_.curNodeId = _loc4_.curNodeId;
               _loc3_.toNodeId = _loc4_.toNodeId;
               _loc3_.moveStep = _loc4_.moveStep;
               _loc3_.headId = _loc4_.headId;
               _loc5_.push(_loc3_);
            }
         }
         NotificationManager.instance.sendNotification("secretwarMoveEvent",_loc5_);
      }
      
      public function gameOp(param1:int, param2:int = -1, param3:int = -1) : void
      {
         var _loc5_:PackageOut = new PackageOut(9725);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = param1;
         _loc4_.nodeId = param2;
         _loc4_.type = param3;
         sendProtoBuffer(_loc4_,_loc5_);
      }
      
      public function shopOp(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9727);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      private function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
   }
}

