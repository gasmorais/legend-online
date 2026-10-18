package mvc.controler
{
   import com.road.yishi.proto.steel.SteelRankDetailMsg;
   import com.road.yishi.proto.steel.SteelRankMsg;
   import com.road.yishi.proto.steel.SteelTeamInfoMsg;
   import com.road.yishi.proto.steel.SteelTeamListMsg;
   import com.road.yishi.proto.steel.SteelUserInfoMsg;
   import com.road.yishi.proto.steel.SteelUserListMsg;
   import manager.LanguageMgr;
   import map.campaign.data.SteelModel;
   import map.campaign.data.SteelTeamInfo;
   import map.campaign.data.SteelUserInfo;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.actions.steel.SteelApplyAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.PopFrameCheck;
   
   public class SteelController extends FrameController
   {
      
      public static const MEMBER:int = 1;
      
      public static const SEARCH:int = 2;
      
      public static const AUDITING:int = 3;
      
      public static const INVITE:int = 4;
      
      public static const RANK_LIST:int = 5;
      
      private var _model:SteelModel;
      
      public var _isInSteelFrame:Boolean = false;
      
      public function SteelController()
      {
         super();
         _model = new SteelModel();
         addEvent();
      }
      
      public function get model() : SteelModel
      {
         return _model;
      }
      
      public function set isInSteelFrame(param1:Boolean) : void
      {
         _isInSteelFrame = param1;
      }
      
      public function get isInSteelFrame() : Boolean
      {
         return _isInSteelFrame;
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "steel.SteelMemberFrame";
            case 2:
               return "steel.SteelSearchFrame";
            case 3:
               return "steel.SteelAuditingFrame";
            case 4:
               return "steel.SteelInviteFrame";
            case 5:
               return "steel.SteelRankListFrame";
            default:
               return "steel.SteelFrame";
         }
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4772,__myTeamInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4773,__teamCreateResultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4768,__teamListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4767,__userListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4774,__applyListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4763,__inviteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4775,__orderListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4771,__vehicleDetaileHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4765,__steelIconStateHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4772,__myTeamInfoHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4773,__teamCreateResultHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4768,__teamListHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4767,__userListHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4774,__applyListHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4763,__inviteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4775,__orderListHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4771,__vehicleDetaileHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4765,__steelIconStateHandler);
      }
      
      private function __myTeamInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SteelTeamInfoMsg;
         _model.selfTeamUid = _loc2_.teamUid;
         if(_loc2_.hasParam4)
         {
            _model.openDate = DateFormatter.parse(_loc2_.param4,"YYYY-MM-DD hh:mm:ss");
         }
         _model.commit();
      }
      
      private function __teamCreateResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SteelTeamInfoMsg;
         if(_loc2_.states == 1)
         {
            FrameControllerManager.instance.openControllerByInfo("steelmap",1);
            _model.selfTeamUid = _loc2_.teamUid;
            _model.commit();
         }
      }
      
      private function __teamListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc7_:SteelTeamInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:SteelTeamListMsg = new SteelTeamListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as SteelTeamListMsg;
         var _loc5_:Array = [];
         var _loc4_:Array = [];
         for each(_loc3_ in _loc2_.applyInfo)
         {
            _loc7_ = readTeamInfo(_loc3_);
            _loc4_.push(_loc7_);
         }
         for each(_loc3_ in _loc2_.teamInfo)
         {
            _loc7_ = readTeamInfo(_loc3_);
            _loc5_.push(_loc7_);
         }
         _loc5_.sort(sortTeamByFightPower);
         _loc4_.sort(sortTeamByFightPower);
         _model.teamList = _loc5_;
         _model.applyList = _loc4_;
      }
      
      private function __userListHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:* = null;
         var _loc3_:SteelUserInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SteelUserListMsg = new SteelUserListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SteelUserListMsg;
         _model.selfTeamName = _loc2_.param4;
         var _loc4_:Array = [];
         for each(_loc6_ in _loc2_.userInfo)
         {
            _loc3_ = readUserInfo(_loc6_);
            _loc4_.push(_loc3_);
            if(_loc3_.hostPlayer == 1)
            {
               _model.hostPlayerId = _loc3_.userId;
            }
         }
         _loc4_.sort(sortUserByFightPower);
         _model.userList = _loc4_;
      }
      
      private function __applyListHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:* = null;
         var _loc3_:SteelUserInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:SteelUserListMsg = new SteelUserListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as SteelUserListMsg;
         var _loc5_:int = Math.ceil(_loc2_.userInfo.length / 8);
         _model.recruitListTotalPage = _loc5_ < _model.recruitCurrentPage ? _model.recruitCurrentPage : _loc5_;
         var _loc4_:Array = [];
         for each(_loc7_ in _loc2_.userInfo)
         {
            _loc3_ = readUserInfo(_loc7_);
            _loc4_.push(_loc3_);
         }
         _loc4_.sort(sortUserByFightPower);
         _model.auditList = _loc4_;
      }
      
      private function __inviteHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SteelTeamInfoMsg;
         var _loc4_:String = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.TipsTxt04",_loc2_.teamName);
         PopFrameCheck.instance.addAction(new SteelApplyAction(_loc2_.teamUid,_loc4_));
      }
      
      private function __orderListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc6_:SteelTeamInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SteelTeamListMsg = new SteelTeamListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SteelTeamListMsg;
         _model.selfOrder = _loc2_.param1;
         _model.selfWinCount = _loc2_.param2;
         var _loc4_:Array = [];
         for each(_loc3_ in _loc2_.teamInfo)
         {
            _loc6_ = readTeamInfo(_loc3_);
            _loc4_.push(_loc6_);
         }
         _loc4_.sort(sortTeamByCrossOrder);
         _model.finalOrderList = _loc4_;
      }
      
      private function __vehicleDetaileHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:SteelUserInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:SteelRankDetailMsg = new SteelRankDetailMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as SteelRankDetailMsg;
         _model.steelCampaignInfo.blueTeamScore = _loc2_.blueTeamScore;
         _model.steelCampaignInfo.redTeamScore = _loc2_.redTeamScore;
         _model.selfPoint = _loc2_.score;
         var _loc5_:Array = [];
         for each(_loc3_ in _loc2_.steelRankMsg)
         {
            _loc4_ = new SteelUserInfo();
            _loc4_.userId = _loc3_.userId;
            _loc4_.nickName = _loc3_.nickName;
            _loc4_.serverName = _loc3_.serverName;
            _loc4_.job = _loc3_.job;
            _loc4_.point = _loc3_.point;
            _loc4_.rank = _loc3_.rank;
            _loc5_.push(_loc4_);
         }
         _loc5_.sort(sortUserByRank);
         _model.rankDetailList = _loc5_;
      }
      
      private function __steelIconStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SteelTeamListMsg = new SteelTeamListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SteelTeamListMsg;
         _loc2_.param1;
         _loc2_.param2;
         _model.showSteelBtn = _loc2_.param1 == 1 ? true : false;
         _model.shineSteelBtn = _loc2_.param2 == 1 ? true : false;
      }
      
      private function sortUserByFightPower(param1:SteelUserInfo, param2:SteelUserInfo) : int
      {
         if(param1.userId == _model.hostPlayerId)
         {
            return -1;
         }
         if(param2.userId == _model.hostPlayerId)
         {
            return 1;
         }
         if(param1.fightPower > param2.fightPower)
         {
            return -1;
         }
         if(param1.fightPower < param2.fightPower)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortUserByRank(param1:SteelUserInfo, param2:SteelUserInfo) : int
      {
         if(param1.rank < param2.rank)
         {
            return -1;
         }
         if(param1.rank > param2.rank)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortTeamByFightPower(param1:SteelTeamInfo, param2:SteelTeamInfo) : int
      {
         if(param1.fightPower > param2.fightPower)
         {
            return -1;
         }
         if(param1.fightPower < param2.fightPower)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortTeamByCrossOrder(param1:SteelTeamInfo, param2:SteelTeamInfo) : int
      {
         if(param1.crossOrder < param2.crossOrder)
         {
            return -1;
         }
         if(param1.crossOrder > param2.crossOrder)
         {
            return 1;
         }
         return 0;
      }
      
      private function readTeamInfo(param1:SteelTeamInfoMsg) : SteelTeamInfo
      {
         var _loc2_:SteelTeamInfo = new SteelTeamInfo();
         if(param1.hasTeamUid)
         {
            _loc2_.teamUid = param1.teamUid;
         }
         if(param1.hasTeamName)
         {
            _loc2_.teamName = param1.teamName;
         }
         if(param1.hasServerName)
         {
            _loc2_.serverName = param1.serverName;
         }
         if(param1.hasSite)
         {
            _loc2_.site = param1.site;
         }
         if(param1.hasHostNickName)
         {
            _loc2_.hostNickName = param1.hostNickName;
         }
         if(param1.hasCounts)
         {
            _loc2_.counts = param1.counts;
         }
         if(param1.hasSuccCount)
         {
            _loc2_.succCount = param1.succCount;
         }
         if(param1.hasLostCount)
         {
            _loc2_.lostCount = param1.lostCount;
         }
         if(param1.hasScoreMarks)
         {
            _loc2_.scoreMarks = param1.scoreMarks;
         }
         if(param1.hasEnterPlayers)
         {
            _loc2_.enterPlayers = param1.enterPlayers;
         }
         if(param1.hasServerId)
         {
            _loc2_.serverId = param1.serverId;
         }
         if(param1.hasGroupId)
         {
            _loc2_.groupId = param1.groupId;
         }
         if(param1.hasStates)
         {
            _loc2_.states = param1.states;
         }
         if(param1.hasCrossOrder)
         {
            _loc2_.crossOrder = param1.crossOrder;
         }
         if(param1.hasOtherSide)
         {
            _loc2_.otherSide = param1.otherSide;
         }
         if(param1.hasProperty1)
         {
            _loc2_.property1 = param1.property1;
         }
         if(param1.hasProperty2)
         {
            _loc2_.property2 = param1.property2;
         }
         if(param1.hasProperty3)
         {
            _loc2_.property3 = param1.property3;
         }
         if(param1.hasParam1)
         {
            _loc2_.param1 = param1.param1;
         }
         if(param1.hasParam2)
         {
            _loc2_.param2 = param1.param2;
         }
         if(param1.hasParam3)
         {
            _loc2_.param3 = param1.param3;
         }
         if(param1.hasParam4)
         {
            _loc2_.param4 = param1.param4;
         }
         if(param1.hasParam5)
         {
            _loc2_.param5 = param1.param5;
         }
         if(param1.hasParam6)
         {
            _loc2_.param6 = param1.param6;
         }
         if(param1.hasFightPower)
         {
            _loc2_.fightPower = param1.fightPower;
         }
         return _loc2_;
      }
      
      private function readUserInfo(param1:SteelUserInfoMsg) : SteelUserInfo
      {
         var _loc2_:SteelUserInfo = new SteelUserInfo();
         if(param1.hasTeamUid)
         {
            _loc2_.teamUid = param1.teamUid;
         }
         if(param1.hasUserId)
         {
            _loc2_.userId = param1.userId;
         }
         if(param1.hasNickName)
         {
            _loc2_.nickName = param1.nickName;
         }
         if(param1.hasGrades)
         {
            _loc2_.grades = param1.grades;
         }
         if(param1.hasJob)
         {
            _loc2_.job = param1.job;
         }
         if(param1.hasFightPower)
         {
            _loc2_.fightPower = param1.fightPower;
         }
         if(param1.hasHostPlayer)
         {
            _loc2_.hostPlayer = param1.hostPlayer;
         }
         if(param1.hasIsEnter)
         {
            _loc2_.isEnter = param1.isEnter;
         }
         if(param1.hasIsExist)
         {
            _loc2_.isExist = param1.isExist;
         }
         if(param1.hasIsOnline)
         {
            _loc2_.isOnline = param1.isOnline;
         }
         if(param1.hasProperty1)
         {
            _loc2_.property1 = param1.property1;
         }
         if(param1.hasProperty2)
         {
            _loc2_.property2 = param1.property2;
         }
         return _loc2_;
      }
      
      public function sendSteelCreateTeam() : void
      {
         var _loc2_:PackageOut = new PackageOut(8962);
         var _loc1_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc1_.param1 = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendSteelKillPlayer(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8962);
         var _loc2_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc2_.param1 = 2;
         _loc2_.param2 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendSteelInvitePlayer(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8962);
         var _loc2_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc2_.param1 = 3;
         _loc2_.param2 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendSteelApplyEnter(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8962);
         var _loc2_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc2_.param1 = 4;
         _loc2_.param4 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendSteelChangeMast(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8962);
         var _loc2_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc2_.param1 = 5;
         _loc2_.param2 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendSteelEnter() : void
      {
         var _loc2_:PackageOut = new PackageOut(8962);
         var _loc1_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc1_.param1 = 6;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendSteelListUsers() : void
      {
         var _loc2_:PackageOut = new PackageOut(8962);
         var _loc1_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc1_.param1 = 7;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendSteelListTeams() : void
      {
         var _loc2_:PackageOut = new PackageOut(8962);
         var _loc1_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc1_.param1 = 8;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendSteelInfoReq() : void
      {
         var _loc2_:PackageOut = new PackageOut(8962);
         var _loc1_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc1_.param1 = 9;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendSteelCancelApply(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8962);
         var _loc2_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc2_.param1 = 10;
         _loc2_.param4 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendSteelApplyListReq() : void
      {
         var _loc2_:PackageOut = new PackageOut(8962);
         var _loc1_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc1_.param1 = 11;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendSteelAgreeApply(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(8962);
         var _loc3_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc3_.param1 = 12;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2 ? 1 : 0;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendSteelInviteReply(param1:String, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(8962);
         var _loc3_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc3_.param1 = 13;
         _loc3_.param2 = param2 ? 1 : 0;
         _loc3_.param4 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendSteelQuit() : void
      {
         var _loc2_:PackageOut = new PackageOut(8962);
         var _loc1_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc1_.param1 = 14;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendSteelOrderListReq() : void
      {
         var _loc2_:PackageOut = new PackageOut(8962);
         var _loc1_:SteelTeamInfoMsg = new SteelTeamInfoMsg();
         _loc1_.param1 = 15;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
   }
}

