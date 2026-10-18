package managers
{
   import com.road.yishi.proto.consortiaplay.MinosDataMsg;
   import com.road.yishi.proto.consortiaplay.MinosLevelMsg;
   import com.road.yishi.proto.consortiaplay.MinosMapMsg;
   import com.road.yishi.proto.consortiaplay.MinosNodeMsg;
   import com.road.yishi.proto.consortiaplay.MinosPlayerMsg;
   import com.road.yishi.proto.consortiaplay.MinosRankListMsg;
   import com.road.yishi.proto.consortiaplay.MinosRankMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import flash.utils.Dictionary;
   import mvc.module.minos.MinosLevelInfo;
   import mvc.module.minos.MinosModel;
   import mvc.module.minos.MinosNodeInfo;
   import mvc.module.minos.MinosPlayerInfo;
   import mvc.module.minos.MinosRankInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   
   public class MinosManager
   {
      
      private static var _ins:MinosManager;
      
      private var _model:MinosModel;
      
      public function MinosManager()
      {
         super();
         _model = new MinosModel();
      }
      
      public static function get ins() : MinosManager
      {
         if(_ins == null)
         {
            _ins = new MinosManager();
         }
         return _ins;
      }
      
      public function get model() : MinosModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model.posInit();
         SocketManager.instance.addEventListener("SLGSocketEvent" + 552,__seasonDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 553,__lvDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 554,__mapNodeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 555,__mapNodeUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 556,__playInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 557,__rankDataHandler);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            _model.reset();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __rankDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:MinosRankInfo = null;
         var _loc6_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:MinosRankListMsg = new MinosRankListMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as MinosRankListMsg;
         var _loc7_:Array = [];
         var _loc9_:Dictionary = _model.rankDic;
         for each(var _loc3_:MinosRankMsg in _loc2_.ranks)
         {
            _loc4_ = _loc9_[_loc3_.userId];
            if(_loc4_ == null)
            {
               _loc4_ = new MinosRankInfo();
               _loc9_[_loc3_.userId] = _loc4_;
            }
            _loc4_.userId = _loc3_.userId;
            _loc4_.nickName = _loc3_.nickName;
            _loc4_.fightPower = _loc3_.fightPower;
            _loc4_.vipGrade = _loc3_.vipGrade;
            _loc4_.feat = _loc3_.feat;
            _loc7_.push(_loc4_);
         }
         _loc7_.sortOn("feat",0x10 | 2);
         var _loc5_:int = int(_loc7_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc7_[_loc6_];
            _loc4_.rank = _loc6_ + 1;
            _loc6_++;
         }
         NotificationManager.instance.sendNotification("minos_EVENT_RANK_UPDATE",_loc7_);
      }
      
      private function __playInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MinosPlayerMsg = new MinosPlayerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MinosPlayerMsg;
         var _loc4_:MinosPlayerInfo = _model.playInfo;
         _loc4_.feat = _loc2_.feat;
         _loc4_.challengeCount = _loc2_.challengeCount;
         _loc4_.buyCount = _loc2_.buyCount;
         _loc4_.levelRewardInfo = _loc2_.levelRewardInfo;
         _loc4_.featRewardInfo = _loc2_.featRewardInfo;
         NotificationManager.instance.sendNotification("minos_EVENT_PALYER_UPDATE");
      }
      
      private function __mapNodeUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MinosMapMsg = new MinosMapMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MinosMapMsg;
         var _loc3_:Array = readNodeInfo(_loc2_);
         NotificationManager.instance.sendNotification("minos_EVENT_NODE_UPDATE",[_loc2_.id,_loc3_,"update"]);
      }
      
      private function __mapNodeHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MinosMapMsg = new MinosMapMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MinosMapMsg;
         var _loc3_:Array = readNodeInfo(_loc2_);
         NotificationManager.instance.sendNotification("minos_EVENT_NODE_UPDATE",[_loc2_.id,_loc3_,"init"]);
      }
      
      private function readNodeInfo(param1:MinosMapMsg) : Array
      {
         var _loc4_:MinosNodeInfo = null;
         var _loc7_:String = null;
         var _loc3_:int = param1.id;
         var _loc5_:Dictionary = _model.getMapLvNodes(_loc3_);
         var _loc6_:Array = [];
         for each(var _loc2_:MinosNodeMsg in param1.nodes)
         {
            _loc7_ = _loc2_.x + "_" + _loc2_.y;
            _loc4_ = _loc5_[_loc7_];
            if(_loc4_ == null)
            {
               _loc4_ = new MinosNodeInfo();
               _loc5_[_loc7_] = _loc4_;
            }
            _loc4_.lv = _loc3_;
            _loc4_.x = _loc2_.x;
            _loc4_.y = _loc2_.y;
            _loc4_.id = _loc2_.id;
            _loc4_.isOpen = _loc2_.isOpen;
            _loc4_.progress = _loc2_.progress;
            _loc6_.push(_loc4_);
         }
         return _loc6_;
      }
      
      private function __lvDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MinosLevelMsg = new MinosLevelMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MinosLevelMsg;
         readLvInfo(_loc2_);
         NotificationManager.instance.sendNotification("minos_EVENT_LV_UPDATE");
      }
      
      private function readLvInfo(param1:MinosLevelMsg) : void
      {
         var _loc2_:MinosLevelInfo = _model.mapLvInfoDic[param1.id];
         if(_loc2_ == null)
         {
            _loc2_ = new MinosLevelInfo();
            _model.mapLvInfoDic[param1.id] = _loc2_;
         }
         _loc2_.id = param1.id;
         _loc2_.progress = param1.progress;
         _loc2_.progressMax = param1.progressMax;
         _loc2_.killNpc = param1.killNpc;
         _loc2_.npcMax = param1.npcMax;
         _loc2_.killBoss = param1.killBoss;
         _loc2_.bossMax = param1.bossMax;
         _loc2_.killInfo = param1.killInfo;
      }
      
      private function __seasonDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MinosDataMsg = new MinosDataMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MinosDataMsg;
         _model.seasonId = _loc2_.seasonId;
         _model.beginTime = _loc2_.beginTime;
         _model.endTime = _loc2_.endTime;
         _model.state = _loc2_.state;
         for each(var _loc4_:MinosLevelMsg in _loc2_.levels)
         {
            readLvInfo(_loc4_);
         }
         NotificationManager.instance.sendNotification("minos_EVENT_LV_UPDATE");
      }
      
      public function doSomething(param1:int, param2:int = 1, param3:int = -1, param4:int = -1, param5:int = -1) : void
      {
         var _loc7_:PackageOut = new PackageOut(9729);
         var _loc6_:PlayerOpMsg = new PlayerOpMsg();
         _loc6_.op = param1;
         _loc6_.index = param2;
         _loc6_.id = param3;
         _loc6_.pos = param4;
         _loc6_.type = param5;
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc6_);
      }
   }
}

