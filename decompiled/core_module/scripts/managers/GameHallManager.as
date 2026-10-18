package managers
{
   import battle.BattleManager;
   import chat.datas.ChatData;
   import com.netease.protobuf.Message;
   import com.pickgliss.ui.ComponentFactory;
   import com.road.yishi.proto.campaign.PosMsg;
   import com.road.yishi.proto.campaign.SpacePlayerMoveMsg;
   import com.road.yishi.proto.campaign.SpacePlayerMsg;
   import com.road.yishi.proto.gamehall.GameHallMsg;
   import com.road.yishi.proto.gamehall.GameHallOpMsg;
   import com.road.yishi.proto.gamehall.GameTeamMsg;
   import com.road.yishi.proto.gamehall.GameTeamPlayerMsg;
   import com.road.yishi.proto.module.EasterLotteryMsg;
   import com.road.yishi.proto.module.EasterUserMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.team.MemberFightPos;
   import com.road.yishi.proto.team.MemberFightPosListMsg;
   import events.FreedomTeamEvent;
   import flash.geom.Point;
   import mvc.module.gamehall.GameHallArmy;
   import mvc.module.gamehall.GameHallBlessInfo;
   import mvc.module.gamehall.GameHallLotteryInfo;
   import mvc.module.gamehall.GameHallModel;
   import mvc.module.gamehall.GameHallTeamInfo;
   import mvc.module.gamehall.GameHallUserInfo;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.StringHelper;
   
   public class GameHallManager
   {
      
      private static var _instance:GameHallManager;
      
      public static var loginToGameHallFlag:Boolean;
      
      public var exit:Boolean;
      
      private var _model:GameHallModel;
      
      private const OP_TEAM_LIST:int = 1;
      
      private const OP_TEAM_INFO:int = 2;
      
      private const OP_TEAM_CREATE:int = 3;
      
      private const OP_TEAM_JOIN:int = 4;
      
      private const OP_TEAM_LEAVE:int = 5;
      
      private const OP_TEAM_KICK:int = 6;
      
      private const OP_TEAM_CAPTAIN:int = 7;
      
      private const OP_TEAM_PASSWORD:int = 8;
      
      private const OP_TEAM_GAME:int = 9;
      
      private const OP_TEAM_START:int = 10;
      
      private const OP_TEAM_INVITE_JOIN:int = 11;
      
      private const OP_TEAM_PREPARE:int = 12;
      
      private const OP_TEAM_SEARCH:int = 13;
      
      private const OP_TEAM_NO_AUTO:int = 14;
      
      private const OP_TEAM_SWITCH:int = 101;
      
      private const OP_TEAM_DELETE:int = 102;
      
      private const OP_TEAM_LOGIN:int = 103;
      
      private const OP_TEAM_UPDATE_AVATA:int = 104;
      
      private const OP_TEAM_UPDATE_STATE:int = 105;
      
      private const OP_TEAM_UPDATE_BUFF:int = 106;
      
      public function GameHallManager()
      {
         super();
         _model = new GameHallModel();
      }
      
      public static function get instance() : GameHallManager
      {
         if(!_instance)
         {
            _instance = new GameHallManager();
         }
         return _instance;
      }
      
      public function get model() : GameHallModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4561,__teamListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4562,__teamDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4563,__teamPosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4565,__teamMoveHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4585,__eastUserDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4587,__eastLotteryDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__eastBtnHandler);
      }
      
      private function __playerChatHandler(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType != "GAME_HALL_SCENE")
         {
            return;
         }
         var _loc3_:ChatData = param1.data as ChatData;
         if(exit || !model.selfArmy || !_loc3_)
         {
            return;
         }
         if(_loc3_.channel != 6 && _loc3_.channel != 8)
         {
            return;
         }
         var _loc2_:GameHallArmy = model.getUserArmyByUserId(_loc3_.uid);
         if(_loc2_)
         {
            _loc2_.chatData = _loc3_;
         }
      }
      
      private function __teamListHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:GameHallTeamInfo = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:GameHallMsg = new GameHallMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as GameHallMsg;
         var _loc6_:Vector.<GameHallTeamInfo> = new Vector.<GameHallTeamInfo>();
         for each(_loc3_ in _loc2_.teams)
         {
            _loc8_ = readTeamInfo(_loc3_);
            _loc6_.push(_loc8_);
         }
         model.teamList = _loc6_;
         model.teamList.sort(sortFun);
         model.commit();
      }
      
      private function __teamDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GameTeamMsg = new GameTeamMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GameTeamMsg;
         switch(_loc2_.op)
         {
            case 2:
               teamInfoHandler(_loc2_);
               break;
            case 3:
               teamCreateHandler(_loc2_);
               break;
            case 4:
               teamJoinHandler(_loc2_);
               break;
            case 5:
               teamLeaveHandler(_loc2_);
               break;
            case 6:
               teamKickHandler(_loc2_);
               break;
            case 7:
               teamCaptainHandler(_loc2_);
               break;
            case 8:
               teamPasswordHandler(_loc2_);
               break;
            case 9:
               teamGameHandler(_loc2_);
               break;
            case 10:
               teamStartHandler(_loc2_);
               break;
            case 11:
               teamInviteJoinHandler(_loc2_);
               break;
            case 12:
               teamPrepareHandler(_loc2_);
               break;
            case 13:
               teamSearchHandler(_loc2_);
               break;
            case 101:
               teamSwitchHandler(_loc2_);
               break;
            case 102:
               teamDeleteHandler(_loc2_);
               break;
            case 103:
               teamLoginHandler(_loc2_);
               break;
            case 104:
               teamUpdateAvataHandler(_loc2_);
               break;
            case 105:
               teamUpdateStateHandler(_loc2_);
               break;
            case 106:
               teamUpdateBufferHandler(_loc2_);
               break;
            case 14:
               teamCancelAutoHandler(_loc2_);
         }
      }
      
      private function teamInfoHandler(param1:GameTeamMsg) : void
      {
         var _loc2_:* = undefined;
         if(!StringHelper.isNullOrEmpty(param1.password))
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallSceneBottomView.passwordFrame");
            _loc2_.backCall = passWordBackCall;
            _loc2_.show(param1.teamId);
         }
         else
         {
            teamJoin(param1.teamId);
         }
      }
      
      private function passWordBackCall(param1:int, param2:String) : void
      {
         teamJoin(param1,param2);
      }
      
      private function teamCreateHandler(param1:GameTeamMsg) : void
      {
         exit = false;
         model.selfTeam = readTeamInfo(param1);
         model.captainId = model.selfTeam.captainId;
         model.gameId = param1.gameId;
         model.difficulty = param1.difficulty;
         enterGameHallScene();
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
      }
      
      private function teamJoinHandler(param1:GameTeamMsg) : void
      {
         var _loc2_:GameHallUserInfo = null;
         if(param1.players.length > 0)
         {
            _loc2_ = readUserInfo(param1.players[0],model.selfTeam);
            model.selfTeam.players.push(_loc2_);
            model.selfTeam.players.sort(sortByUserId);
            NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_SYNC",null));
         }
      }
      
      private function teamLeaveHandler(param1:GameTeamMsg) : void
      {
         var _loc2_:GameHallUserInfo = null;
         var _loc5_:Boolean = false;
         var _loc3_:int = int(model.selfTeam.players.length);
         var _loc4_:int = 0;
         if(param1.opUserId == playerInfo.userId)
         {
            exit = true;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = model.selfTeam.players[_loc4_];
               model.removeUserArmyByArmyId(_loc2_.userId);
               _loc4_++;
            }
            model.selfTeam = null;
            _loc5_ = BattleManager.getInstance().battleModel != null;
            if(!_loc5_)
            {
               SwitchPageHelp.returnToSpace();
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = model.selfTeam.players[_loc4_];
               if(_loc2_.userId == param1.opUserId)
               {
                  model.selfTeam.players.splice(_loc4_,1);
                  break;
               }
               _loc4_++;
            }
            model.removeUserArmyByArmyId(param1.opUserId);
         }
         if(model.selfTeam && model.selfTeam.players)
         {
            model.selfTeam.players.sort(sortByUserId);
         }
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_SYNC",null));
      }
      
      private function teamKickHandler(param1:GameTeamMsg) : void
      {
      }
      
      private function teamCaptainHandler(param1:GameTeamMsg) : void
      {
         model.captainId = model.selfTeam.captainId = param1.captainId;
         model.updateCaptainInfo();
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_SYNC",null));
      }
      
      private function teamPasswordHandler(param1:GameTeamMsg) : void
      {
         model.selfTeam.isLock = !StringHelper.isNullOrEmpty(param1.password);
         model.selfTeam.password = param1.password;
         model.updatePasswordInfo();
      }
      
      private function teamGameHandler(param1:GameTeamMsg) : void
      {
         model.gameId = param1.gameId;
         model.difficulty = param1.difficulty;
         model.selfTeam.difficulty = param1.difficulty;
         model.updateGameInfo();
      }
      
      private function teamStartHandler(param1:GameTeamMsg) : void
      {
      }
      
      private function teamInviteJoinHandler(param1:GameTeamMsg) : void
      {
      }
      
      private function teamPrepareHandler(param1:GameTeamMsg) : void
      {
         var _loc4_:GameTeamPlayerMsg = null;
         var _loc5_:GameHallArmy = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(param1.players.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.players[_loc3_];
            _loc5_ = model.getUserArmyByUserId(_loc4_.userId);
            if(_loc5_)
            {
               _loc5_.isPrepare = _loc4_.isPrepare;
            }
            _loc3_++;
         }
         model.updateUserInfo();
      }
      
      private function teamSearchHandler(param1:GameTeamMsg) : void
      {
         var _loc4_:GameHallTeamInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(model.teamList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = model.teamList[_loc3_];
            if(_loc4_.teamId == param1.teamId)
            {
               _loc4_ = readTeamInfo(param1);
               model.teamList[_loc3_] = _loc4_;
               break;
            }
            _loc3_++;
         }
         model.teamList.sort(sortFun);
         model.searchTeam = _loc4_;
         model.selectedGameId = _loc4_.gameId;
         model.selectedDifficulty = _loc4_.difficulty;
         model.updateSelectedGameInfo();
      }
      
      private function teamSwitchHandler(param1:GameTeamMsg) : void
      {
         var _loc2_:GameHallUserInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(model.selfTeam.players.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = model.selfTeam.players[_loc4_];
            if(_loc2_.userId != model.selfArmy.userId)
            {
               model.removeUserArmyByArmyId(_loc2_.userId);
            }
            _loc4_++;
         }
         model.selfTeam = readTeamInfo(param1);
         model.captainId = model.selfTeam.captainId;
         model.gameId = param1.gameId;
         model.difficulty = param1.difficulty;
         model.updateUserInfo();
         model.openEastView = false;
         model.updateGameInfo();
         FrameControllerManager.instance.gameHallController.closeFrame();
      }
      
      private function teamDeleteHandler(param1:GameTeamMsg) : void
      {
         var _loc4_:GameHallTeamInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(model.teamList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = model.teamList[_loc3_];
            if(_loc4_.teamId == param1.teamId)
            {
               model.teamList.splice(_loc3_,1);
               _loc4_ = null;
               break;
            }
            _loc3_++;
         }
         model.teamList.sort(sortFun);
         model.commit();
      }
      
      private function teamLoginHandler(param1:GameTeamMsg) : void
      {
         exit = false;
         model.selfTeam = readTeamInfo(param1);
         model.captainId = model.selfTeam.captainId;
         model.gameId = param1.gameId;
         model.difficulty = param1.difficulty;
         enterGameHallScene();
      }
      
      private function teamUpdateAvataHandler(param1:GameTeamMsg) : void
      {
         var _loc2_:GameTeamPlayerMsg = null;
         if(param1.players.length > 0)
         {
            _loc2_ = param1.players[0];
            readPlayerAvata(_loc2_);
         }
      }
      
      private function teamUpdateBufferHandler(param1:GameTeamMsg) : void
      {
         var _loc2_:GameHallUserInfo = null;
         var _loc3_:int = 0;
         if(param1.players.length > 0)
         {
            if(model.selfTeam)
            {
               model.selfTeam.players = new Vector.<GameHallUserInfo>();
               _loc3_ = 0;
               while(_loc3_ < param1.players.length)
               {
                  _loc2_ = readUserInfo(param1.players[_loc3_],model.selfTeam);
                  model.selfTeam.players.push(_loc2_);
                  _loc3_++;
               }
               model.selfTeam.players.sort(sortByUserId);
               model.updateBufferInfo();
            }
         }
      }
      
      private function teamCancelAutoHandler(param1:GameTeamMsg) : void
      {
         if(model.selfTeam)
         {
            model.selfTeam.autoType = param1.autoType;
            model.updateAutoBattle();
         }
      }
      
      private function sortByUserId(param1:GameHallUserInfo, param2:GameHallUserInfo) : int
      {
         if(param1 && param2)
         {
            if(param1.userId < param2.userId)
            {
               return -1;
            }
            if(param1.userId > param2.userId)
            {
               return 1;
            }
            return 0;
         }
         return 0;
      }
      
      private function teamUpdateStateHandler(param1:GameTeamMsg) : void
      {
         var _loc2_:GameTeamPlayerMsg = null;
         var _loc3_:GameHallArmy = null;
         if(param1.players.length > 0)
         {
            _loc2_ = param1.players[0];
            _loc3_ = model.getUserArmyByUserId(_loc2_.userId);
            if(_loc3_)
            {
               _loc3_.online = _loc2_.state == 7 ? true : false;
               _loc3_.commit();
            }
         }
      }
      
      protected function sortFun(param1:GameHallTeamInfo, param2:GameHallTeamInfo) : Number
      {
         if(param1.isMine && !param2.isMine)
         {
            return -1;
         }
         if(!param1.isMine && param2.isMine)
         {
            return 1;
         }
         if(param1.teamState < param2.teamState)
         {
            return -1;
         }
         if(param1.teamState > param2.teamState)
         {
            return 1;
         }
         if(param1.teamId > param2.teamId)
         {
            return -1;
         }
         if(param1.teamId < param2.teamId)
         {
            return 1;
         }
         return 0;
      }
      
      public function enterGameHallScene() : void
      {
         if(model.gameId == 4 || model.selfTeam && model.selfTeam.gameId == 4)
         {
            opEastFrame(0);
         }
         SceneManager.instance.setScene("GAME_HALL_SCENE");
      }
      
      private function __teamPosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MemberFightPosListMsg = new MemberFightPosListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MemberFightPosListMsg;
         _model.memberFightPos = _loc2_.memberPos;
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
      }
      
      private function __teamMoveHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SpacePlayerMoveMsg = new SpacePlayerMoveMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SpacePlayerMoveMsg;
         model.moveArmyTo(_loc2_);
      }
      
      private function __eastUserDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:GameHallBlessInfo = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:EasterUserMsg = new EasterUserMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as EasterUserMsg;
         model.todayHasGetNum = _loc2_.buyCount;
         model.todayHasBuyBufferNum = _loc2_.buyBuffCount;
         model.remainEffectiveNum = _loc2_.buffCount;
         if(_loc2_.openList)
         {
            model.eastOpenTemplateIdArr = _loc2_.openList;
            model.updateEastTeamLeftView();
         }
         model.wishArray = [];
         if(_loc2_.wish)
         {
            _loc7_ = _loc2_.wish.split("|");
            _loc3_ = int(_loc7_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = readGameHallBlessInfo(_loc7_[_loc5_]);
               if(_loc4_ && _loc4_.level > 0)
               {
                  model.wishLevelAllZero = false;
               }
               model.wishArray.push(_loc4_);
               _loc5_++;
            }
            model.wishArray.sort(sortByIndex);
            model.updateWishInfo();
         }
      }
      
      public function readGameHallBlessInfo(param1:String) : GameHallBlessInfo
      {
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:GameHallBlessInfo = new GameHallBlessInfo();
         if(param1)
         {
            _loc2_ = param1.split(",");
            if(_loc2_ && _loc2_[0] && _loc2_[1])
            {
               _loc4_ = int(_loc2_[0]);
               _loc3_.level = _loc2_[1];
               _loc3_.skillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_loc4_);
            }
         }
         return _loc3_;
      }
      
      private function sortByIndex(param1:GameHallBlessInfo, param2:GameHallBlessInfo) : int
      {
         var _loc3_:SkillTempInfo = null;
         var _loc4_:SkillTempInfo = null;
         if(param1 && param2)
         {
            _loc3_ = param1.skillTempInfo;
            _loc4_ = param2.skillTempInfo;
            if(_loc3_ && _loc4_)
            {
               if(_loc3_.Index < _loc4_.Index)
               {
                  return -1;
               }
               if(_loc3_.Index > _loc4_.Index)
               {
                  return 1;
               }
               return 0;
            }
         }
         return 0;
      }
      
      public function opEastFrame(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8655);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = param1;
         _loc3_.count = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      private function __eastLotteryDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:GameHallLotteryInfo = null;
         var _loc6_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:EasterLotteryMsg = new EasterLotteryMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as EasterLotteryMsg;
         model.eastInfoArr = [];
         model.num = _loc2_.num;
         if(_loc2_.lottery)
         {
            _loc4_ = _loc2_.lottery.split("|");
            _loc5_ = int(_loc4_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_ = new GameHallLotteryInfo();
               _loc3_.temlateId = _loc4_[_loc6_].split(",")[0];
               _loc3_.remainNum = _loc4_[_loc6_].split(",")[1];
               model.eastInfoArr.push(_loc3_);
               _loc6_++;
            }
            model.eastInfoArr.sort(sortByTemplateId);
            model.updateShopInfo();
         }
         model.eastLotteryIdArr = _loc2_.result;
         if(model.eastLotteryIdArr.length > 0)
         {
            FrameControllerManager.instance.openControllerByInfo("gamehall","EAST_SHOP_ANIMATION");
         }
      }
      
      private function sortByTemplateId(param1:GameHallLotteryInfo, param2:GameHallLotteryInfo) : int
      {
         if(param1 && param2)
         {
            if(param1.temlateId < param2.temlateId)
            {
               return -1;
            }
            if(param1.temlateId > param2.temlateId)
            {
               return 1;
            }
            return 0;
         }
         return 0;
      }
      
      private function __eastBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 4020)
         {
            _model.eastIsOpen = _loc2_.param7;
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function readTeamInfo(param1:GameTeamMsg) : GameHallTeamInfo
      {
         var _loc2_:GameHallUserInfo = null;
         var _loc4_:GameHallTeamInfo = new GameHallTeamInfo();
         _loc4_.teamId = param1.teamId;
         _loc4_.gameId = param1.gameId;
         _loc4_.teamState = param1.teamState;
         _loc4_.captainId = param1.captainId;
         _loc4_.isLock = !StringHelper.isNullOrEmpty(param1.password);
         _loc4_.password = param1.password;
         _loc4_.difficulty = param1.difficulty;
         _loc4_.autoType = param1.autoType;
         _loc4_.players = new Vector.<GameHallUserInfo>();
         _loc4_.isMine = false;
         for each(var _loc3_:GameTeamPlayerMsg in param1.players)
         {
            _loc2_ = readUserInfo(_loc3_,_loc4_);
            if(_loc2_.userId == playerInfo.userId)
            {
               _loc4_.isMine = true;
            }
            _loc4_.players.push(_loc2_);
         }
         _loc4_.players.sort(sortByUserId);
         return _loc4_;
      }
      
      private function readUserInfo(param1:GameTeamPlayerMsg, param2:GameHallTeamInfo) : GameHallUserInfo
      {
         var _loc3_:GameHallUserInfo = new GameHallUserInfo();
         _loc3_.userId = param1.userId;
         _loc3_.nickName = param1.nickName;
         _loc3_.grade = param1.grade;
         _loc3_.headId = param1.headId;
         _loc3_.consortiaName = param1.consortiaName;
         _loc3_.posX = param1.posX;
         _loc3_.posY = param1.posY;
         _loc3_.state = param1.state;
         if(param1.buff)
         {
            _loc3_.buffs = blessArray(param1.buff);
         }
         if(param1.avata)
         {
            readPlayerAvata(param1);
         }
         return _loc3_;
      }
      
      private function blessArray(param1:String) : Array
      {
         var _loc6_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:GameHallBlessInfo = null;
         var _loc4_:int = 0;
         var _loc5_:Array = [];
         if(param1)
         {
            _loc6_ = param1.split("|");
            if(_loc6_)
            {
               _loc2_ = int(_loc6_.length);
               _loc4_ = 0;
               while(_loc4_ < _loc2_)
               {
                  _loc3_ = readGameHallBlessInfo(_loc6_[_loc4_]);
                  _loc5_.push(_loc3_);
                  _loc4_++;
               }
            }
            _loc5_.sort(sortByIndex);
         }
         return _loc5_;
      }
      
      private function readPlayerAvata(param1:GameTeamPlayerMsg) : void
      {
         var _loc3_:ThaneInfo = null;
         var _loc4_:int = param1.userId;
         var _loc2_:GameHallArmy = model.getUserArmyByUserId(_loc4_);
         if(_loc2_ == null)
         {
            _loc2_ = new GameHallArmy();
         }
         if(_loc4_ == playerInfo.userId)
         {
            _loc3_ = thane;
            _loc2_.baseHero = _loc3_;
         }
         else
         {
            _loc3_ = _loc2_.baseHero;
         }
         _loc3_.beginChanges();
         _loc3_.userId = _loc4_;
         _loc3_.grades = param1.grade;
         _loc3_.nickName = param1.nickName;
         _loc3_.consortiaName = param1.consortiaName;
         _loc3_.templateId = param1.avata.templateId;
         _loc3_.headId = param1.headId;
         _loc3_.armsEquipAvata = param1.avata.arm;
         _loc3_.bodyEquipAvata = param1.avata.cloth;
         if(param1.avata.hasWing)
         {
            _loc3_.wingAvata = param1.avata.wing;
         }
         _loc3_.hairFashionAvata = param1.avata.hat;
         _loc3_.armsFashionAvata = param1.avata.fashionArm;
         _loc3_.bodyFashionAvata = param1.avata.fashionCloth;
         _loc3_.hideFashion = param1.avata.hide;
         _loc3_.changeShapeId = param1.avata.sharpId;
         _loc3_.fightingCapacity = param1.avata.fightCapacity;
         _loc2_.isPrepare = param1.isPrepare;
         _loc2_.online = param1.state == 7 ? true : false;
         _loc2_.userId = _loc4_;
         _loc2_.id = param1.userId;
         _loc2_.nickName = param1.nickName;
         _loc2_.curPosX = param1.posX;
         _loc2_.curPosY = param1.posY;
         if(param1.avata.hasMountId)
         {
            _loc2_.mountTemplateId = param1.avata.mountId;
         }
         _loc3_.commit();
         _loc2_.commit();
         model.addUserArmy(_loc2_);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function isOpenToday(param1:int) : Boolean
      {
         return model.isOpenToday(param1);
      }
      
      public function teamList(param1:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(8646);
         var _loc2_:GameHallOpMsg = new GameHallOpMsg();
         _loc2_.op = 1;
         _loc2_.isRefresh = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function teamInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8646);
         var _loc2_:GameHallOpMsg = new GameHallOpMsg();
         _loc2_.op = 2;
         _loc2_.teamId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function teamCreate(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8646);
         var _loc3_:GameHallOpMsg = new GameHallOpMsg();
         _loc3_.op = 3;
         _loc3_.gameId = param1;
         _loc3_.difficulty = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function teamJoin(param1:int, param2:String = "") : void
      {
         var _loc4_:PackageOut = new PackageOut(8646);
         var _loc3_:GameHallOpMsg = new GameHallOpMsg();
         _loc3_.op = 4;
         _loc3_.teamId = param1;
         _loc3_.password = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function teamLeave() : void
      {
         var _loc2_:PackageOut = new PackageOut(8646);
         var _loc1_:GameHallOpMsg = new GameHallOpMsg();
         _loc1_.op = 5;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function teamKick(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8646);
         var _loc2_:GameHallOpMsg = new GameHallOpMsg();
         _loc2_.op = 6;
         _loc2_.userId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function teamCaptain(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8646);
         var _loc2_:GameHallOpMsg = new GameHallOpMsg();
         _loc2_.op = 7;
         _loc2_.userId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function teamPassword(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8646);
         var _loc2_:GameHallOpMsg = new GameHallOpMsg();
         _loc2_.op = 8;
         _loc2_.password = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function teamGame(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8646);
         var _loc3_:GameHallOpMsg = new GameHallOpMsg();
         _loc3_.op = 9;
         _loc3_.gameId = param1;
         _loc3_.difficulty = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function teamStart(param1:Boolean = true, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8646);
         var _loc3_:GameHallOpMsg = new GameHallOpMsg();
         _loc3_.op = 10;
         _loc3_.isUseCount = param1;
         _loc3_.autoType = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function teamInviteJoin(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8646);
         var _loc2_:GameHallOpMsg = new GameHallOpMsg();
         _loc2_.op = 11;
         _loc2_.teamId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function teamPrepare(param1:Boolean = true, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(8646);
         var _loc3_:GameHallOpMsg = new GameHallOpMsg();
         _loc3_.op = 12;
         _loc3_.isPrepare = param1;
         _loc3_.isUseCount = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function teamSearch(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8646);
         var _loc2_:GameHallOpMsg = new GameHallOpMsg();
         _loc2_.op = 13;
         _loc2_.teamId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function teamCancelAutoBattle(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8646);
         var _loc2_:GameHallOpMsg = new GameHallOpMsg();
         _loc2_.op = 14;
         _loc2_.teamId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function teamInvite(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8648);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function teamMove(param1:Array) : void
      {
         var _loc6_:PosMsg = null;
         var _loc5_:PackageOut = new PackageOut(8649);
         var _loc2_:SpacePlayerMoveMsg = new SpacePlayerMoveMsg();
         var _loc4_:SpacePlayerMsg = new SpacePlayerMsg();
         _loc4_.playerId = ArmyManager.instance.army.userId;
         for each(var _loc3_:Point in param1)
         {
            _loc6_ = new PosMsg();
            _loc6_.x = _loc3_.x;
            _loc6_.y = _loc3_.y;
            _loc4_.path.push(_loc6_);
         }
         _loc2_.players.push(_loc4_);
         sendProtoBuffer(_loc5_,_loc2_);
      }
      
      public function teamPosEdit(param1:Boolean = true, param2:Array = null) : void
      {
         var _loc6_:MemberFightPos = null;
         var _loc5_:Array = [];
         if(!param1)
         {
            for each(var _loc4_:Object in param2)
            {
               _loc6_ = new MemberFightPos();
               _loc6_.memberId = _loc4_.userId;
               _loc6_.pos = _loc4_.heroPos;
               _loc5_.push(_loc6_);
            }
         }
         var _loc7_:PackageOut = new PackageOut(8647);
         var _loc3_:MemberFightPosListMsg = new MemberFightPosListMsg();
         _loc3_.isGet = param1;
         _loc3_.memberPos = _loc5_;
         sendProtoBuffer(_loc7_,_loc3_);
      }
      
      private function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketSendManager.instance.sendProtoBuffer(param1,param2);
      }
   }
}

