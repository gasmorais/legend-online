package yishi.manager
{
   import com.road.yishi.proto.braveleg.BraveLegInfoMsg;
   import com.road.yishi.proto.braveleg.BraveLegListMsg;
   import com.road.yishi.proto.braveleg.InspireTeamInfoMsg;
   import events.BraveLegEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.EclipticPalaceManager;
   import managers.GroupfbManager;
   import managers.MarryManager;
   import managers.MopupManager;
   import mvc.module.braveleg.BraveLegModel;
   import mvc.module.braveleg.BraveLegPlayerInfo;
   import mvc.module.braveleg.BraveLegRankInfo;
   import mvc.module.braveleg.BraveLegSignUpInfo;
   import mvc.module.braveleg.BraveLegTeamInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class BraveLegManager
   {
      
      private static var _instance:BraveLegManager;
      
      public static const CLIENT_OP_OPENTABLE:uint = 1;
      
      public static const CLIENT_OP_REQUTSIGN:uint = 2;
      
      public static const CLIENT_OP_CREATTEAM:uint = 3;
      
      public static const CLIENT_OP_LEAVETEAM:uint = 4;
      
      public static const CLIENT_OP_KILLSTEAM:uint = 5;
      
      public static const CLIENT_OP_LISTTEAMS:uint = 6;
      
      public static const CLIENT_OP_INVITEING:uint = 7;
      
      public static const CLIENT_OP_RANKSLIST:uint = 8;
      
      public static const CLIENT_OP_PLAYERLIST:uint = 9;
      
      public static const CLIENT_OP_INSPIRE:uint = 10;
      
      public static const CLIENT_OP_EDITTEAM:uint = 11;
      
      public static const CLIENT_OP_CHANGE_INSPIRE:uint = 12;
      
      private var _model:BraveLegModel;
      
      public function BraveLegManager()
      {
         super();
      }
      
      public static function get instance() : BraveLegManager
      {
         _instance ||= new BraveLegManager();
         return _instance;
      }
      
      public function get model() : BraveLegModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new BraveLegModel();
      }
      
      public function hasTeam() : Boolean
      {
         return _model.teamInfo != null;
      }
      
      public function requestViewInfo() : void
      {
         if(ArmyManager.instance.thane.grades < 40)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.bravelegShopPrompt",40));
            return;
         }
         var _loc2_:PackageOut = new PackageOut(9619);
         var _loc1_:BraveLegListMsg = new BraveLegListMsg();
         _loc1_.op = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestSignUp() : void
      {
         var _loc2_:PackageOut = new PackageOut(9619);
         var _loc1_:BraveLegListMsg = new BraveLegListMsg();
         _loc1_.op = 2;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestRankInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(9619);
         var _loc1_:BraveLegListMsg = new BraveLegListMsg();
         _loc1_.op = 8;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestCreateTeam(param1:String = null, param2:Boolean = false) : void
      {
         if(!_model.isOpen && !param2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str01"));
            return;
         }
         if(!_model.isSign && !param2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str02"));
            return;
         }
         var _loc4_:PackageOut = new PackageOut(9619);
         var _loc3_:BraveLegListMsg = new BraveLegListMsg();
         _loc3_.op = 3;
         if(param1 != null)
         {
            _loc3_.uid = param1;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function requestLeaveTeam() : void
      {
         var _loc2_:PackageOut = new PackageOut(9619);
         var _loc1_:BraveLegListMsg = new BraveLegListMsg();
         _loc1_.op = 4;
         if(_model.teamInfo)
         {
            _model.teamInfo.destroy();
            _model.teamInfo = null;
         }
         _model.teamList.length = 0;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestKillTeammate(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9619);
         var _loc2_:BraveLegListMsg = new BraveLegListMsg();
         _loc2_.op = 5;
         _loc2_.userId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function requestTeamList() : void
      {
         var _loc2_:PackageOut = new PackageOut(9619);
         var _loc1_:BraveLegListMsg = new BraveLegListMsg();
         _loc1_.op = 6;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestInviteList() : void
      {
         var _loc2_:PackageOut = new PackageOut(9619);
         var _loc1_:BraveLegListMsg = new BraveLegListMsg();
         _loc1_.op = 9;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestInviteFriend(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9619);
         var _loc2_:BraveLegListMsg = new BraveLegListMsg();
         _loc2_.op = 7;
         _loc2_.userId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function requestRankList() : void
      {
         var _loc2_:PackageOut = new PackageOut(9619);
         var _loc1_:BraveLegListMsg = new BraveLegListMsg();
         _loc1_.op = 8;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function requestInspireTeam(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9619);
         var _loc2_:BraveLegListMsg = new BraveLegListMsg();
         _loc2_.op = 10;
         _loc2_.groupId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function requestEditTeam(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9619);
         var _loc3_:BraveLegListMsg = new BraveLegListMsg();
         _loc3_.op = 11;
         _loc3_.userId = param1;
         _loc3_.groupId = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function requestChangeInspire(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9619);
         var _loc3_:BraveLegListMsg = new BraveLegListMsg();
         _loc3_.op = 12;
         _loc3_.groupId = param1;
         _loc3_.skillMasterType = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function clearRankInfo() : void
      {
         _model.rankInfo.clear();
      }
      
      private function addEvent() : void
      {
      }
      
      private function __viewInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BraveLegListMsg = new BraveLegListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BraveLegListMsg;
         resovleBaseInfo(_loc2_);
         if(_model.teamInfo)
         {
            _model.teamInfo.destroy();
            _model.teamInfo = null;
         }
         _model.teamList.length = 0;
         NotificationManager.instance.dispatchEvent(new BraveLegEvent("BraveLegEvent.CLOSE_TEAM"));
         if(SceneManager.instance.currentType == "SPACE_SCENE" || SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            FrameControllerManager.instance.openControllerByInfo("braveleg",{
               "tab":0,
               "refresh":true
            },resovleSignUpInfo(_loc2_));
            if(_model.isOpen)
            {
               requestTeamList();
            }
         }
      }
      
      private function __teamInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BraveLegListMsg = new BraveLegListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BraveLegListMsg;
         NotificationManager.instance.dispatchEvent(new BraveLegEvent("BraveLegEvent.CLOSE_SIGNUP"));
         resovleTeamInfo(_loc2_);
         if(SceneManager.instance.currentType == "SPACE_SCENE" || SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            FrameControllerManager.instance.openControllerByInfo("braveleg",{
               "tab":1,
               "refresh":true
            },_model.teamInfo);
         }
      }
      
      private function __teamListInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:BraveLegPlayerInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:BraveLegListMsg = new BraveLegListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as BraveLegListMsg;
         _model.teamList.length = 0;
         _loc4_ = 0;
         _loc3_ = int(_loc2_.info.length);
         while(_loc4_ < _loc3_)
         {
            _loc6_ = resovlePlayerInfo(_loc2_.info[_loc4_]);
            _loc6_.teammateNum = _loc2_.info[_loc4_].result;
            _model.teamList.push(_loc6_);
            _loc4_++;
         }
         _model.dispatchEvent(new BraveLegEvent("BraveLegEvent.TEAMLIST_UPDATE",_model.teamList));
      }
      
      private function __inviteInfoHandler(param1:SLGSocketEvent) : void
      {
         var pkg:PackageIn;
         var msg:BraveLegInfoMsg;
         var confirm:String;
         var cancel:String;
         var prompt:String;
         var content:String;
         var e:SLGSocketEvent = param1;
         var conformInvite:* = function(param1:Boolean, param2:Boolean):void
         {
            if(param1)
            {
               requestCreateTeam(msg.uid,true);
            }
         };
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "VEHICLE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            return;
         }
         if(SceneManager.instance.currentType == "CROSS_GUILD_SCENE")
         {
            return;
         }
         if(FrameControllerManager.instance.pokerControler.showPoker)
         {
            return;
         }
         if(ChildManager.instance.arenaModel.isInChildArena)
         {
            return;
         }
         if(EclipticPalaceManager.instance.model.openEclipticPalaceFrame)
         {
            return;
         }
         if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            return;
         }
         if(FrameControllerManager.instance.dreamArenaController.dreamArenaMatching)
         {
            return;
         }
         if(AnswerManager.Instance.frameIsOpen)
         {
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            return;
         }
         if(MarryManager.instance.model.lockScreen)
         {
            return;
         }
         if(GroupfbManager.instance.model.hasGroupTeam)
         {
            return;
         }
         if(FrameControllerManager.instance.outyardControler.isOutyardMapApply)
         {
            return;
         }
         pkg = e.data as PackageIn;
         msg = new BraveLegInfoMsg();
         msg = pkg.readBody(msg) as BraveLegInfoMsg;
         SimpleAlertHelper.instance.data = [conformInvite];
         confirm = LanguageMgr.GetTranslation("public.confirm");
         cancel = LanguageMgr.GetTranslation("public.cancel");
         prompt = LanguageMgr.GetTranslation("public.prompt");
         content = LanguageMgr.GetTranslation("braveleg.Dialog.invite",msg.nickName);
         SimpleAlertHelper.instance.popAlerFrame(prompt,content,confirm,cancel);
      }
      
      private function __rankInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BraveLegListMsg = new BraveLegListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BraveLegListMsg;
         resovleRankInfo(_loc2_);
         _model.dispatchEvent(new BraveLegEvent("BraveLegEvent.RANK_INFO"));
      }
      
      private function __playerListInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BraveLegListMsg = new BraveLegListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BraveLegListMsg;
         resovleInviteInfo(_loc2_);
         _model.dispatchEvent(new BraveLegEvent("BraveLegEvent.INVITE_INFO"));
      }
      
      private function __teamInspireInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:InspireTeamInfoMsg = new InspireTeamInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as InspireTeamInfoMsg;
         if(_model.teamInfo)
         {
            _model.teamInfo.inspire.groupType1 = _loc2_.groupType1;
            _model.teamInfo.inspire.groupType2 = _loc2_.groupType2;
            _model.teamInfo.inspire.groupType3 = _loc2_.groupType3;
            _model.teamInfo.inspire.groupGrade1 = _loc2_.groupGrade1;
            _model.teamInfo.inspire.groupGrade2 = _loc2_.groupGrade2;
            _model.teamInfo.inspire.groupGrade3 = _loc2_.groupGrade3;
            _model.teamInfo.inspireCount = _loc2_.inspireCount;
            _model.teamInfo.maxInspireCount = _loc2_.maxInspireCount;
            _model.dispatchEvent(new BraveLegEvent("BraveLegEvent.TEAM_INSPIRE",_model.teamInfo.inspire));
         }
      }
      
      private function resovleBaseInfo(param1:BraveLegListMsg) : void
      {
         if(param1.hasIsSign)
         {
            _model.isSign = param1.isSign;
         }
         if(param1.hasIsOpen)
         {
            _model.isOpen = param1.isOpen;
         }
         if(param1.hasIsOver)
         {
            _model.isOver = param1.isOver;
         }
      }
      
      private function resovleSignUpInfo(param1:BraveLegListMsg) : BraveLegSignUpInfo
      {
         var _loc6_:BraveLegPlayerInfo = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:BraveLegPlayerInfo = null;
         var _loc5_:BraveLegSignUpInfo = new BraveLegSignUpInfo();
         _loc5_.openTime = param1.openTime;
         _loc5_.isSign = param1.isSign;
         _loc5_.isOpen = param1.isOpen;
         _loc5_.season = param1.season;
         _loc5_.warIndex = param1.warIndex;
         _loc5_.currentTurn = param1.currentTurn;
         _loc5_.maxTurnCount = param1.maxTurnCount;
         _loc5_.totalScore = param1.totalScore;
         _loc5_.teamType = param1.teamType;
         _loc5_.order = param1.order;
         _loc5_.isOver = param1.isOver;
         _loc5_.leftWarIndex = param1.leftWarIndex;
         _loc5_.topList = new Vector.<BraveLegPlayerInfo>();
         _loc4_ = 0;
         _loc2_ = int(param1.info.length);
         while(_loc4_ < _loc2_)
         {
            _loc6_ = resovlePlayerInfo(param1.info[_loc4_]);
            _loc5_.topList.push(_loc6_);
            _loc4_++;
         }
         _loc5_.topList.sort(sortByRank);
         while(_loc5_.topList.length % 5 != 0 || _loc5_.topList.length == 0)
         {
            _loc3_ = new BraveLegPlayerInfo();
            _loc3_.rankOrder = _loc5_.topList.length + 1;
            _loc3_.nickName = null;
            _loc5_.topList.push(_loc3_);
         }
         return _loc5_;
      }
      
      private function resovleTeamInfo(param1:BraveLegListMsg) : BraveLegTeamInfo
      {
         var _loc7_:BraveLegPlayerInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_model.teamInfo == null)
         {
            _model.teamInfo = new BraveLegTeamInfo();
         }
         var _loc6_:BraveLegTeamInfo = _model.teamInfo;
         _model.teamInfo.isMaster = false;
         _loc6_.currentTurn = param1.currentTurn;
         _loc6_.maxTurnCount = param1.maxTurnCount;
         _loc6_.leftTime = param1.leftTime;
         _loc6_.teammate.length = 0;
         var _loc5_:int = PlayerManager.instance.currentPlayerModel.userInfo.userId;
         _loc3_ = 0;
         _loc2_ = int(param1.info.length);
         while(_loc3_ < _loc2_)
         {
            _loc7_ = resovlePlayerInfo(param1.info[_loc3_]);
            if(_loc7_.userId == _loc5_)
            {
               _model.teamInfo.isMaster = _loc7_.isMaster;
            }
            _loc6_.teammate.push(_loc7_);
            _loc3_++;
         }
         _loc6_.teammate.sort(sortByMaster);
         _loc4_ = 0;
         while(_loc4_ < _loc6_.teammate.length)
         {
            _loc6_.teammate[_loc4_].pos = _loc4_ + 1;
            _loc4_++;
         }
         return _loc6_;
      }
      
      private function resovlePlayerInfo(param1:BraveLegInfoMsg) : BraveLegPlayerInfo
      {
         var _loc2_:BraveLegPlayerInfo = new BraveLegPlayerInfo();
         _loc2_.uid = param1.uid;
         _loc2_.userId = param1.userId;
         _loc2_.serverName = param1.serverName;
         _loc2_.nickName = param1.nickName;
         _loc2_.headId = param1.headId;
         _loc2_.grades = param1.grades;
         _loc2_.fightPower = param1.fightPower;
         _loc2_.teamType = param1.teamType;
         _loc2_.totalScore = param1.totalScore;
         _loc2_.rankOrder = param1.rankOrder;
         _loc2_.groupId = param1.groupId;
         _loc2_.isMaster = param1.isMaster;
         _loc2_.sexJob = param1.sexJob;
         return _loc2_;
      }
      
      private function resovleInviteInfo(param1:BraveLegListMsg) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:BraveLegPlayerInfo = null;
         _model.inviteList.length = 0;
         _loc3_ = 0;
         _loc2_ = int(param1.info.length);
         while(_loc3_ < _loc2_)
         {
            _loc4_ = resovlePlayerInfo(param1.info[_loc3_]);
            _model.inviteList.push(_loc4_);
            _loc3_++;
         }
         _model.inviteList.sort(sortByLevel);
      }
      
      private function resovleRankInfo(param1:BraveLegListMsg) : BraveLegRankInfo
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:BraveLegPlayerInfo = null;
         var _loc4_:BraveLegRankInfo = _model.rankInfo;
         _loc4_.clear();
         _loc4_.order = param1.order;
         _loc4_.teamType = param1.teamType;
         _loc4_.totalScore = param1.totalScore;
         _loc4_.lastUpdate = param1.openTime;
         _loc3_ = 0;
         _loc2_ = int(param1.info.length);
         while(_loc3_ < _loc2_)
         {
            _loc5_ = resovlePlayerInfo(param1.info[_loc3_]);
            _loc4_.rankList.push(_loc5_);
            _loc3_++;
         }
         return _loc4_;
      }
      
      private function sortByRank(param1:Object, param2:Object) : int
      {
         return param1.rankOrder - param2.rankOrder;
      }
      
      private function sortByLevel(param1:Object, param2:Object) : int
      {
         return param2.grades - param1.grades;
      }
      
      private function sortByMaster(param1:Object, param2:Object) : int
      {
         if(param1.isMaster)
         {
            return -1;
         }
         if(param2.isMaster)
         {
            return 1;
         }
         return param2.userId - param1.userId;
      }
   }
}

