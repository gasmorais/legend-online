package managers
{
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpFightResultMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpLeaveReportMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpMatchMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpMatchPlayerMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpRankListMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpRankMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpReportListMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpReportMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpRewardListMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpRewardMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpSeasonMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpShowListMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpShowMsg;
   import com.road.yishi.proto.pvp.TheseusMultiPvpUserMsg;
   import com.road.yishi.proto.pvp.TheseusPvpFightResultMsg;
   import com.road.yishi.proto.pvp.TheseusPvpLeaveReportMsg;
   import com.road.yishi.proto.pvp.TheseusPvpMatchMsg;
   import com.road.yishi.proto.pvp.TheseusPvpMatchPlayerMsg;
   import com.road.yishi.proto.pvp.TheseusPvpRankListMsg;
   import com.road.yishi.proto.pvp.TheseusPvpRankMsg;
   import com.road.yishi.proto.pvp.TheseusPvpReportListMsg;
   import com.road.yishi.proto.pvp.TheseusPvpReportMsg;
   import com.road.yishi.proto.pvp.TheseusPvpRewardListMsg;
   import com.road.yishi.proto.pvp.TheseusPvpRewardMsg;
   import com.road.yishi.proto.pvp.TheseusPvpSeasonMsg;
   import com.road.yishi.proto.pvp.TheseusPvpShowListMsg;
   import com.road.yishi.proto.pvp.TheseusPvpShowMsg;
   import com.road.yishi.proto.pvp.TheseusPvpUserMsg;
   import com.road.yishi.proto.room.RoomReqMsg;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpFightResultInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpLeaveReportInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpModel;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpRankInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpRewardInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpSeasonInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpShowInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpUserInfo;
   import mvc.module.theseuspvp.TheseusPvpFightResultInfo;
   import mvc.module.theseuspvp.TheseusPvpLeaveReportInfo;
   import mvc.module.theseuspvp.TheseusPvpMatchPlayerInfo;
   import mvc.module.theseuspvp.TheseusPvpModel;
   import mvc.module.theseuspvp.TheseusPvpRankInfo;
   import mvc.module.theseuspvp.TheseusPvpReportInfo;
   import mvc.module.theseuspvp.TheseusPvpRewardInfo;
   import mvc.module.theseuspvp.TheseusPvpSeasonInfo;
   import mvc.module.theseuspvp.TheseusPvpShowInfo;
   import mvc.module.theseuspvp.TheseusPvpUserInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.service.managers.SocketManager;
   
   public class TheseusPvpManager
   {
      
      public static const OP_OPEN:int = 1;
      
      public static const OP_LEAVE:int = 2;
      
      public static const OP_MATCH:int = 3;
      
      public static const OP_CANCEL_MATCH:int = 4;
      
      public static const OP_VIEW_REPORT:int = 5;
      
      public static const OP_VIEW_SHOW:int = 6;
      
      public static const OP_GET_REWARD:int = 7;
      
      public static const OP_LIKE:int = 8;
      
      public static const OP_UNLOCK_SPECIAL_REWARD:int = 9;
      
      public static const OP_GET_SPECIAL_REWARD:int = 10;
      
      public static const OP_ONEKEY_GET_SPECIAL_REWARD:int = 11;
      
      public static const OP_VIEW_RANK:int = 12;
      
      public static const OP_VIEW_REWARD:int = 13;
      
      public static const OP_ADD_MATCH_COUNT:int = 14;
      
      public static const OP_BUY_MATCH_COUNT:int = 15;
      
      public static const OP_PVP_OPEN:int = 1;
      
      public static const OP_PVP_LEAVE:int = 2;
      
      public static const OP_PVP_MATCH:int = 3;
      
      public static const OP_PVP_CANCEL_MATCH:int = 4;
      
      public static const OP_PVP_VIEW_REPORT:int = 5;
      
      public static const OP_PVP_GET_REWARD:int = 7;
      
      public static const OP_PVP_LIKE:int = 8;
      
      public static const OP_PVP_UNLOCK_SPECIAL_REWARD:int = 9;
      
      public static const OP_PVP_GET_SPECIAL_REWARD:int = 10;
      
      public static const OP_PVP_ONEKEY_GET_SPECIAL_REWARD:int = 11;
      
      public static const OP_PVP_VIEW_RANK:int = 12;
      
      public static const OP_PVP_VIEW_REWARD:int = 13;
      
      public static const OP_PVP_ADD_MATCH_COUNT:int = 14;
      
      public static const OP_PVP_BUY_MATCH_COUNT:int = 15;
      
      private static var _ins:TheseusPvpManager;
      
      private static var _time:Number;
      
      private var _model:TheseusPvpModel;
      
      private var _modeldouble:TheseusDoublePvpModel;
      
      public function TheseusPvpManager()
      {
         super();
         _model = new TheseusPvpModel();
         _modeldouble = new TheseusDoublePvpModel();
      }
      
      public static function get Instance() : TheseusPvpManager
      {
         if(_ins == null)
         {
            _ins = new TheseusPvpManager();
         }
         return _ins;
      }
      
      public static function sendPlayerState(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(5036);
         var _loc3_:RoomReqMsg = new RoomReqMsg();
         _loc3_.state = param1;
         _loc3_.isGet = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function sendRoomState(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5037);
         var _loc2_:RoomReqMsg = new RoomReqMsg();
         _loc2_.state = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function sendStartCampaignScene(param1:int = 0, param2:int = 0, param3:Function = null, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc7_:PackageOut = new PackageOut(5039);
         var _loc6_:CampaignReqMsg = new CampaignReqMsg();
         if(param2 == 1)
         {
            _loc6_.paraInt1 = param2;
         }
         _loc6_.paraBool1 = param4;
         _loc6_.paraInt2 = param1;
         _loc6_.isCross = param5;
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc6_);
      }
      
      public static function updateRoomInfo(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(5034);
         var _loc4_:RoomReqMsg = new RoomReqMsg();
         _loc4_.roomId = param1;
         _loc4_.dungeonId = param2;
         _loc4_.campaignId = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function sendRoomInvite(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5028);
         var _loc2_:RoomReqMsg = new RoomReqMsg();
         _loc2_.userId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function get model() : TheseusPvpModel
      {
         return _model;
      }
      
      public function get model1() : TheseusDoublePvpModel
      {
         return _modeldouble;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4320,__timeInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4312,__userInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4313,__rewardInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4314,__rankInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4315,__showInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4316,__reportInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4317,__leaveReportInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4318,__matchInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4319,__resultInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 583,__timeInfosdoubleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 575,__userInfosDoubleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 576,__rewardInfosDoubleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 577,__rankInfosDoubleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 578,__showInfosDoubleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 579,__reportInfosDoubleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 580,__leaveReportInfosDoubleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 581,__matchInfosDoubleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 582,__resultInfosDoubleHandler);
      }
      
      private function __timeInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusPvpSeasonMsg = new TheseusPvpSeasonMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TheseusPvpSeasonMsg;
         var _loc4_:TheseusPvpSeasonInfo = _model.seasonTimeInfo;
         _loc4_.seasonId = _loc2_.seasonId;
         _loc4_.startDate = _loc2_.startDate;
         _loc4_.stopDate = _loc2_.stopDate;
         _loc4_.closeDate = _loc2_.closeDate;
         NotificationManager.instance.sendNotification("thesepvpUpdateEnterTime");
      }
      
      private function __userInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusPvpUserMsg = new TheseusPvpUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TheseusPvpUserMsg;
         var _loc4_:TheseusPvpUserInfo = _model.selfUserInfo;
         _loc4_.op = _loc2_.op;
         _loc4_.integral = _loc2_.integral;
         _loc4_.pvpId = _loc2_.pvpId;
         _loc4_.rank = _loc2_.rank;
         _loc4_.keepWin = _loc2_.keepWin;
         _loc4_.freeCount = _loc2_.freeCount;
         _loc4_.likeInfo = _loc2_.likeInfo;
         _loc4_.specialInfo = _loc2_.specialInfo;
         _loc4_.openPaySpecial = _loc2_.openPaySpecial;
         _loc4_.redReport = _loc2_.redReport;
         _loc4_.redReward = _loc2_.redReward;
         _loc4_.maxPvpId = _loc2_.maxPvpId;
         _loc4_.addCount = _loc2_.addCount;
         _loc4_.buyCount = _loc2_.buyCount;
         NotificationManager.instance.sendNotification("theseuspvpUserInfoEvent");
      }
      
      private function __rewardInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusPvpRewardInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusPvpRewardListMsg = new TheseusPvpRewardListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TheseusPvpRewardListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:TheseusPvpRewardMsg in _loc2_.rewards)
         {
            _loc6_ = new TheseusPvpRewardInfo();
            _loc6_.templateId = _loc3_.templateId;
            _loc6_.data = _loc3_.data;
            _loc6_.state = _loc3_.state;
            _loc4_.push(_loc6_);
         }
         NotificationManager.instance.sendNotification("theseuspvpRewardEvent",_loc4_);
      }
      
      private function __rankInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusPvpRankInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusPvpRankListMsg = new TheseusPvpRankListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TheseusPvpRankListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:TheseusPvpRankMsg in _loc2_.ranks)
         {
            _loc6_ = new TheseusPvpRankInfo();
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
         NotificationManager.instance.sendNotification("theseuspvpRankEvent",_loc4_);
      }
      
      private function __showInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusPvpShowInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusPvpShowListMsg = new TheseusPvpShowListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TheseusPvpShowListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:TheseusPvpShowMsg in _loc2_.shows)
         {
            _loc6_ = new TheseusPvpShowInfo();
            _loc6_.seasonId = _loc3_.seasonId;
            _loc6_.rank = _loc3_.rank;
            _loc6_.integral = _loc3_.integral;
            _loc6_.pvpId = _loc3_.pvpId;
            _loc6_.startDate = _loc3_.startDate;
            _loc6_.stopDate = _loc3_.stopDate;
            _loc6_.playerUid = _loc3_.playerUid;
            _loc6_.nickName = _loc3_.nickName;
            _loc6_.serverName = _loc3_.serverName;
            _loc6_.arm = _loc3_.arm;
            _loc6_.cloth = _loc3_.cloth;
            _loc6_.wing = _loc3_.wing;
            _loc6_.hat = _loc3_.hat;
            _loc6_.fashionArm = _loc3_.fashionArm;
            _loc6_.fashionCloth = _loc3_.fashionCloth;
            _loc6_.isDragonTalker = _loc3_.isDragonTalker;
            _loc6_.job = _loc3_.job;
            _loc6_.fightCapacity = _loc3_.fightCapacity;
            _loc6_.vipType = _loc3_.vipType;
            _loc6_.heroTempId = _loc3_.heroTempId;
            _loc6_.updateThane();
            _loc4_.push(_loc6_);
         }
         _loc4_.sortOn("seasonId",16);
         NotificationManager.instance.sendNotification("theseuspvpShowEvent",_loc4_);
      }
      
      private function __reportInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusPvpReportInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusPvpReportListMsg = new TheseusPvpReportListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TheseusPvpReportListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:TheseusPvpReportMsg in _loc2_.reports)
         {
            _loc6_ = new TheseusPvpReportInfo();
            _loc6_.integral = _loc3_.integral;
            _loc6_.isWin = _loc3_.isWin;
            _loc6_.mode = _loc3_.mode;
            _loc6_.nickName = _loc3_.nickName;
            _loc6_.serverName = _loc3_.serverName;
            _loc6_.job = _loc3_.job;
            _loc6_.fightCapacity = _loc3_.fightCapacity;
            _loc6_.fightDate = _loc3_.fightDate;
            _loc4_.push(_loc6_);
         }
         NotificationManager.instance.sendNotification("theseuspvpReportEvent",_loc4_);
      }
      
      private function __leaveReportInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = "THESE_PVP_SCENE";
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,_loc3_,levelReportPvpSceneCall);
      }
      
      private function levelReportPvpSceneCall(param1:PackageIn) : void
      {
         var _loc2_:TheseusPvpLeaveReportMsg = new TheseusPvpLeaveReportMsg();
         _loc2_ = param1.readBody(_loc2_) as TheseusPvpLeaveReportMsg;
         var _loc3_:TheseusPvpLeaveReportInfo = _model.leaveInfo;
         _loc3_.rank = _loc2_.rank;
         _loc3_.integral = _loc2_.integral;
         _loc3_.pvpId = _loc2_.pvpId;
         _loc3_.lastRank = _loc2_.lastRank;
         _loc3_.lastIntegral = _loc2_.lastIntegral;
         _loc3_.lastPvpId = _loc2_.lastPvpId;
         FrameControllerManager.instance.openControllerByInfo("theseuspvp","BACK_REPORT",_loc3_);
      }
      
      private function __matchInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:TheseusPvpMatchPlayerInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusPvpMatchMsg = new TheseusPvpMatchMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TheseusPvpMatchMsg;
         _model.matchState = _loc2_.state;
         var _loc7_:String = "";
         var _loc5_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc4_:String = _loc5_.nickName + "_" + _loc5_.serviceName;
         for each(var _loc3_:TheseusPvpMatchPlayerMsg in _loc2_.players)
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
         }
         NotificationManager.instance.sendNotification("theseuspvpMatchEvent");
      }
      
      private function __resultInfosHandler(param1:SLGSocketEvent) : void
      {
         _model.matchState = 1;
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = "THESE_PVP_SCENE";
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,_loc3_,backPvpSceneCall);
      }
      
      private function backPvpSceneCall(param1:PackageIn) : void
      {
         var _loc2_:TheseusPvpFightResultMsg = new TheseusPvpFightResultMsg();
         _loc2_ = param1.readBody(_loc2_) as TheseusPvpFightResultMsg;
         var _loc3_:TheseusPvpFightResultInfo = _model.resultInfo;
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
         FrameControllerManager.instance.openControllerByInfo("theseuspvp","BATTLE_RESULT",_loc3_);
      }
      
      public function doSomething(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9712);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = param1;
         _loc4_.id = param2;
         _loc4_.count = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function doSomething1(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9736);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = param1;
         _loc4_.id = param2;
         _loc4_.count = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      private function __timeInfosdoubleHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusMultiPvpSeasonMsg = new TheseusMultiPvpSeasonMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TheseusMultiPvpSeasonMsg;
         var _loc4_:TheseusDoublePvpSeasonInfo = _modeldouble.seasonTimeInfo;
         _loc4_.seasonId = _loc2_.seasonId;
         _loc4_.startDate = _loc2_.startDate;
         _loc4_.stopDate = _loc2_.stopDate;
         _loc4_.closeDate = _loc2_.closeDate;
         NotificationManager.instance.sendNotification("thesedoublepvpUpdateEnterTime");
      }
      
      private function __userInfosDoubleHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusMultiPvpUserMsg = new TheseusMultiPvpUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TheseusMultiPvpUserMsg;
         var _loc4_:TheseusDoublePvpUserInfo = _modeldouble.selfUserInfo;
         _loc4_.op = _loc2_.op;
         _loc4_.integral = _loc2_.integral;
         _loc4_.pvpId = _loc2_.pvpId;
         _loc4_.rank = _loc2_.rank;
         _loc4_.keepWin = _loc2_.keepWin;
         _loc4_.freeCount = _loc2_.freeCount;
         _loc4_.likeInfo = _loc2_.likeInfo;
         _loc4_.specialInfo = _loc2_.specialInfo;
         _loc4_.openPaySpecial = _loc2_.openPaySpecial;
         _loc4_.redReport = _loc2_.redReport;
         _loc4_.redReward = _loc2_.redReward;
         _loc4_.maxPvpId = _loc2_.maxPvpId;
         _loc4_.addCount = _loc2_.addCount;
         _loc4_.buyCount = _loc2_.buyCount;
         NotificationManager.instance.sendNotification("theseusDoublepvpUserInfoEvent");
      }
      
      private function __rewardInfosDoubleHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusDoublePvpRewardInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusMultiPvpRewardListMsg = new TheseusMultiPvpRewardListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TheseusMultiPvpRewardListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:TheseusMultiPvpRewardMsg in _loc2_.rewards)
         {
            _loc6_ = new TheseusDoublePvpRewardInfo();
            _loc6_.templateId = _loc3_.templateId;
            _loc6_.data = _loc3_.data;
            _loc6_.state = _loc3_.state;
            _loc4_.push(_loc6_);
         }
         NotificationManager.instance.sendNotification("theseusDoublepvpRewardEvent",_loc4_);
      }
      
      private function __rankInfosDoubleHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusDoublePvpRankInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusMultiPvpRankListMsg = new TheseusMultiPvpRankListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TheseusMultiPvpRankListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:TheseusMultiPvpRankMsg in _loc2_.ranks)
         {
            _loc6_ = new TheseusDoublePvpRankInfo();
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
         NotificationManager.instance.sendNotification("theseusDoublepvpRankEvent",_loc4_);
      }
      
      private function __showInfosDoubleHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusDoublePvpShowInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusMultiPvpShowListMsg = new TheseusMultiPvpShowListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TheseusMultiPvpShowListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:TheseusMultiPvpShowMsg in _loc2_.shows)
         {
            _loc6_ = new TheseusDoublePvpShowInfo();
            _loc6_.seasonId = _loc3_.seasonId;
            _loc6_.rank = _loc3_.rank;
            _loc6_.integral = _loc3_.integral;
            _loc6_.pvpId = _loc3_.pvpId;
            _loc6_.startDate = _loc3_.startDate;
            _loc6_.stopDate = _loc3_.stopDate;
            _loc6_.playerUid = _loc3_.playerUid;
            _loc6_.nickName = _loc3_.nickName;
            _loc6_.serverName = _loc3_.serverName;
            _loc6_.arm = _loc3_.arm;
            _loc6_.cloth = _loc3_.cloth;
            _loc6_.wing = _loc3_.wing;
            _loc6_.hat = _loc3_.hat;
            _loc6_.fashionArm = _loc3_.fashionArm;
            _loc6_.fashionCloth = _loc3_.fashionCloth;
            _loc6_.isDragonTalker = _loc3_.isDragonTalker;
            _loc6_.job = _loc3_.job;
            _loc6_.fightCapacity = _loc3_.fightCapacity;
            _loc6_.vipType = _loc3_.vipType;
            _loc6_.heroTempId = _loc3_.heroTempId;
            _loc6_.updateThane();
            _loc4_.push(_loc6_);
         }
         _loc4_.sortOn("seasonId",16);
         NotificationManager.instance.sendNotification("theseusDoublepvpShowEvent",_loc4_);
      }
      
      private function __reportInfosDoubleHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TheseusPvpReportInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusMultiPvpReportListMsg = new TheseusMultiPvpReportListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TheseusMultiPvpReportListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:TheseusMultiPvpReportMsg in _loc2_.reports)
         {
            _loc6_ = new TheseusPvpReportInfo();
            _loc6_.integral = _loc3_.integral;
            _loc6_.isWin = _loc3_.isWin;
            _loc6_.mode = _loc3_.mode;
            _loc6_.nickName = _loc3_.nickName;
            _loc6_.serverName = _loc3_.serverName;
            _loc6_.job = _loc3_.job;
            _loc6_.fightCapacity = _loc3_.fightCapacity;
            _loc6_.fightDate = _loc3_.fightDate;
            _loc4_.push(_loc6_);
         }
         NotificationManager.instance.sendNotification("theseusDoublepvpReportEvent",_loc4_);
      }
      
      private function __leaveReportInfosDoubleHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = "THESE_Double_PVP_SCENE";
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,_loc3_,levelReportDoublePvpSceneCall);
      }
      
      private function levelReportDoublePvpSceneCall(param1:PackageIn) : void
      {
         var _loc2_:TheseusMultiPvpLeaveReportMsg = new TheseusMultiPvpLeaveReportMsg();
         _loc2_ = param1.readBody(_loc2_) as TheseusMultiPvpLeaveReportMsg;
         var _loc3_:TheseusDoublePvpLeaveReportInfo = _modeldouble.leaveInfo;
         _loc3_.rank = _loc2_.rank;
         _loc3_.integral = _loc2_.integral;
         _loc3_.pvpId = _loc2_.pvpId;
         _loc3_.lastRank = _loc2_.lastRank;
         _loc3_.lastIntegral = _loc2_.lastIntegral;
         _loc3_.lastPvpId = _loc2_.lastPvpId;
         FrameControllerManager.instance.openControllerByInfo("theseuspvp","BACK_REPORTDOUBLE",_loc3_);
      }
      
      private function __resultInfosDoubleHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = "THESE_Double_PVP_SCENE";
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,_loc3_,backPvpDoubleSceneCall);
      }
      
      private function backPvpDoubleSceneCall(param1:PackageIn) : void
      {
         var _loc2_:TheseusMultiPvpFightResultMsg = new TheseusMultiPvpFightResultMsg();
         _loc2_ = param1.readBody(_loc2_) as TheseusMultiPvpFightResultMsg;
         var _loc3_:TheseusDoublePvpFightResultInfo = _modeldouble.resultInfo;
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
         FrameControllerManager.instance.openControllerByInfo("theseuspvp","BATTLE_RESULTDOUBLE",_loc3_);
      }
      
      private function __matchInfosDoubleHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:* = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TheseusMultiPvpMatchMsg = new TheseusMultiPvpMatchMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TheseusMultiPvpMatchMsg;
         _modeldouble.matchState = _loc2_.roomType;
         var _loc5_:String = "";
         _modeldouble.matchSelfInfoArr = [];
         _modeldouble.matchOtherInfoArr = [];
         for each(var _loc3_:TheseusMultiPvpMatchPlayerMsg in _loc2_.players)
         {
            if(_loc3_.roomType == _loc2_.roomType)
            {
               _modeldouble.matchSelfInfoArr.push(_loc3_);
            }
            else
            {
               _modeldouble.matchOtherInfoArr.push(_loc3_);
            }
         }
         NotificationManager.instance.sendNotification("theseuspvpDoubleMatchEvent");
      }
   }
}

