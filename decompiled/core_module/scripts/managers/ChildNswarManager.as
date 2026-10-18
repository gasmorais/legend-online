package managers
{
   import battle.BattleManager;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.pvp.ChildPvpBattleChildMsg;
   import com.road.yishi.proto.pvp.ChildPvpBattleMsg;
   import com.road.yishi.proto.pvp.ChildPvpFightResultMsg;
   import com.road.yishi.proto.pvp.ChildPvpMatchMsg;
   import com.road.yishi.proto.pvp.ChildPvpMatchPlayerMsg;
   import com.road.yishi.proto.pvp.ChildPvpRankListMsg;
   import com.road.yishi.proto.pvp.ChildPvpRankMsg;
   import com.road.yishi.proto.pvp.ChildPvpRewardListMsg;
   import com.road.yishi.proto.pvp.ChildPvpRewardMsg;
   import com.road.yishi.proto.pvp.ChildPvpSeasonMsg;
   import com.road.yishi.proto.pvp.ChildPvpUserMsg;
   import mvc.module.childnswar.ChildNswarFightResultInfo;
   import mvc.module.childnswar.ChildNswarMatchPlayInfo;
   import mvc.module.childnswar.ChildNswarModel;
   import mvc.module.childnswar.ChildNswarRankInfo;
   import mvc.module.childnswar.ChildNswarRewardInfo;
   import mvc.module.childnswar.ChildNswarSeasonInfo;
   import mvc.module.childnswar.ChildNswarUserInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   
   public class ChildNswarManager
   {
      
      private static var _ins:ChildNswarManager;
      
      public static const OP_OPEN:int = 1;
      
      public static const OP_ADD_MATCH_COUNT:int = 2;
      
      public static const OP_BUY_MATCH_COUNT:int = 3;
      
      public static const OP_MATCH:int = 4;
      
      public static const OP_CANCEL_MATCH:int = 5;
      
      public static const OP_GET_REWARD:int = 6;
      
      public static const OP_VIEW_RANK:int = 7;
      
      public static const OP_VIEW_REWARD:int = 8;
      
      public static const OP_FIGHT_SET:int = 9;
      
      private var _model:ChildNswarModel;
      
      public function ChildNswarManager()
      {
         super();
         _model = new ChildNswarModel();
      }
      
      public static function get Instance() : ChildNswarManager
      {
         if(_ins == null)
         {
            _ins = new ChildNswarManager();
         }
         return _ins;
      }
      
      public function get model() : ChildNswarModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 573,__timeInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 568,__userInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 569,__rewardInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 570,__rankInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 571,__matchInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 572,__resultInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 574,__battleInfosHandler);
      }
      
      private function __battleInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:String = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildPvpBattleMsg = new ChildPvpBattleMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ChildPvpBattleMsg;
         _model.battleInfo.battleId = _loc2_.battleId;
         _model.battleInfo.buffId = _loc2_.fightSkillId;
         var _loc3_:SimpleDictionary = _model.battleInfo.battleRoleList;
         for each(var _loc4_:ChildPvpBattleChildMsg in _loc2_.childs)
         {
            _loc6_ = _loc4_.side + "_" + _loc4_.pos;
            _loc3_.add(_loc6_,_loc4_);
         }
         NotificationManager.instance.sendNotification("childNswar.Event.Battle");
      }
      
      private function __timeInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildPvpSeasonMsg = new ChildPvpSeasonMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChildPvpSeasonMsg;
         var _loc4_:ChildNswarSeasonInfo = _model.seasonTimeInfo;
         _loc4_.seasonId = _loc2_.seasonId;
         _loc4_.seasonStartDate = _loc2_.seasonStartDate;
         _loc4_.seasonStopDate = _loc2_.seasonStopDate;
         _loc4_.matchStartDate = _loc2_.matchStartDate;
         _loc4_.matchStopDate = _loc2_.matchStopDate;
         _loc4_.totalDay = _loc2_.totalDay;
         NotificationManager.instance.sendNotification("childnswarUpdateEnterTime");
      }
      
      public function convertFightInfo(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc3_:Array = param1.split(",");
         var _loc2_:Array = [];
         _loc2_.push("-1");
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc4_ != 1)
            {
               _loc2_.push(_loc3_[_loc4_]);
            }
            else
            {
               _loc2_.push("-1");
               _loc2_.push(_loc3_[_loc4_]);
            }
            _loc4_++;
         }
         return _loc2_.join(",");
      }
      
      private function __userInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildPvpUserMsg = new ChildPvpUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChildPvpUserMsg;
         var _loc4_:ChildNswarUserInfo = _model.selfUserInfo;
         _loc4_.op = _loc2_.op;
         _loc4_.integral = _loc2_.integral;
         _loc4_.pvpId = _loc2_.pvpId;
         _loc4_.rank = _loc2_.rank;
         _loc4_.keepWin = _loc2_.keepWin;
         _loc4_.freeCount = _loc2_.freeCount;
         _loc4_.redReward = _loc2_.redReward;
         _loc4_.maxPvpId = _loc2_.maxPvpId;
         _loc4_.addCount = _loc2_.addCount;
         _loc4_.buyCount = _loc2_.buyCount;
         _loc4_.fightInfo = convertFightInfo(_loc2_.fightInfo);
         NotificationManager.instance.sendNotification("childnswarUserInfoEvent");
         if(_loc2_.op == 1)
         {
            SceneManager.instance.setScene("CHILD_NS_WAR_SCENE");
         }
      }
      
      private function __rewardInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:ChildNswarRewardInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildPvpRewardListMsg = new ChildPvpRewardListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ChildPvpRewardListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:ChildPvpRewardMsg in _loc2_.rewards)
         {
            _loc6_ = new ChildNswarRewardInfo();
            _loc6_.templateId = _loc3_.templateId;
            _loc6_.data = _loc3_.data;
            _loc6_.state = _loc3_.state;
            _loc4_.push(_loc6_);
         }
         NotificationManager.instance.sendNotification("childnswarRewardEvent",_loc4_);
      }
      
      private function __rankInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:ChildNswarRankInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildPvpRankListMsg = new ChildPvpRankListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ChildPvpRankListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:ChildPvpRankMsg in _loc2_.ranks)
         {
            _loc6_ = new ChildNswarRankInfo();
            _loc6_.rank = _loc3_.rank;
            _loc6_.integral = _loc3_.integral;
            _loc6_.pvpId = _loc3_.pvpId;
            _loc6_.nickName = _loc3_.nickName;
            _loc6_.serverName = _loc3_.serverName;
            _loc6_.job = _loc3_.job;
            _loc6_.fightCapacity = _loc3_.fightCapacity;
            _loc6_.uuid = _loc3_.uuid;
            _loc6_.site = _loc3_.site;
            _loc4_.push(_loc6_);
         }
         _loc4_.sortOn("rank",16);
         NotificationManager.instance.sendNotification("childnswarRankEvent",_loc4_);
      }
      
      private function __matchInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:ChildNswarMatchPlayInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildPvpMatchMsg = new ChildPvpMatchMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ChildPvpMatchMsg;
         _model.matchState = _loc2_.state;
         var _loc7_:String = "";
         var _loc5_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc4_:String = _loc5_.nickName + "_" + _loc5_.serviceName;
         for each(var _loc3_:ChildPvpMatchPlayerMsg in _loc2_.players)
         {
            _loc7_ = _loc3_.nickName + "_" + _loc3_.serverName;
            if(_loc4_ == _loc7_)
            {
               _loc8_ = _model.matchSelfInfo;
            }
            else
            {
               _loc8_ = _model.matchOtherInfo;
            }
            _loc8_.integral = _loc3_.integral;
            _loc8_.pvpId = _loc3_.pvpId;
            _loc8_.nickName = _loc3_.nickName;
            _loc8_.serverName = _loc3_.serverName;
            _loc8_.job = _loc3_.job;
            _loc8_.fightCapacity = _loc3_.fightCapacity;
            _loc8_.grade = _loc3_.grade;
         }
         NotificationManager.instance.sendNotification("childnswarMatchEvent");
      }
      
      private function __resultInfosHandler(param1:SLGSocketEvent) : void
      {
         _model.battleInfo.clear();
         _model.matchState = 1;
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = "CHILD_NS_WAR_SCENE";
         BattleManager.getInstance().isLockChildnswar = false;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,_loc3_,backPvpSceneCall);
      }
      
      private function backPvpSceneCall(param1:PackageIn) : void
      {
         var _loc2_:ChildPvpFightResultMsg = new ChildPvpFightResultMsg();
         _loc2_ = param1.readBody(_loc2_) as ChildPvpFightResultMsg;
         var _loc3_:ChildNswarFightResultInfo = _model.resultInfo;
         _loc3_.isWin = _loc2_.isWin;
         _loc3_.rank = _loc2_.rank;
         _loc3_.integral = _loc2_.integral;
         _loc3_.pvpId = _loc2_.pvpId;
         _loc3_.lastRank = _loc2_.lastRank;
         _loc3_.lastPvpId = _loc2_.lastPvpId;
         _loc3_.keepWin = _loc2_.keepWin;
         _loc3_.lastIntegral = _loc2_.lastIntegral;
         _loc3_.keepWinIntegral = _loc2_.keepWinIntegral;
         _loc3_.rewardInfo = _loc2_.rewardInfo;
         FrameControllerManager.instance.openControllerByInfo("childnswar","BATTLE_RESULT",_loc3_);
      }
      
      public function doSomething(param1:int, param2:int = 0, param3:int = 0, param4:String = null) : void
      {
         var _loc6_:PackageOut = new PackageOut(9732);
         var _loc5_:PlayerOpMsg = new PlayerOpMsg();
         _loc5_.op = param1;
         _loc5_.id = param2;
         _loc5_.count = param3;
         if(param4 != null)
         {
            _loc5_.param1 = param4;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
   }
}

