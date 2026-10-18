package mvc.controler
{
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.unrealshooting.UnrealShootingMsg;
   import com.road.yishi.proto.unrealshooting.UnrealShootingPlayerMsg;
   import flash.utils.getTimer;
   import map.campaign.data.UnrealShootingModel;
   import map.campaign.data.UnrealShootingUserInfo;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   
   public class UnrealShootingController extends FrameController
   {
      
      public static const RANK_LIST:int = 1;
      
      public static const GAMEOVER_REPORT:int = 2;
      
      private var _model:UnrealShootingModel;
      
      private var _isInUnrealShootingFrame:Boolean = false;
      
      private const GAMESTATE_CLOSE:int = 0;
      
      private const GAMESTATE_MATCH:int = 1;
      
      private const GAMESTATE_PLAY:int = 2;
      
      private const GAMESTATE_SHOW:int = 3;
      
      private const ENTER_MATCH_ROOM:int = 1;
      
      private const REFRESH_MATCH_ROOM:int = 2;
      
      private const LEAVE_MATCH_ROOM:int = 3;
      
      private const C_ENTER:int = 1;
      
      private const C_SELECT_TEMPLATE:int = 2;
      
      private const C_CONFIRM_TEMPLATE:int = 3;
      
      private const C_BUY_BUFF:int = 4;
      
      private const C_WEEK_ORDER:int = 5;
      
      private const C_LEAVE_MATCH:int = 6;
      
      public function UnrealShootingController()
      {
         super();
         _model = new UnrealShootingModel();
         addEvent();
      }
      
      public function get model() : UnrealShootingModel
      {
         return _model;
      }
      
      public function set isInUnrealShootingFrame(param1:Boolean) : void
      {
         _isInUnrealShootingFrame = param1;
      }
      
      public function get isInUnrealShootingFrame() : Boolean
      {
         return _isInUnrealShootingFrame;
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "unrealshooting.UnrealShootingRankListFrame";
            case 2:
               return "unrealshooting.UnrealShootingGameOverFrame";
            default:
               return "unrealshooting.UnrealShootingFrame";
         }
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == 2)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4836,__unrealActiveStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4829,__unrealMainInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4828,__unrealShootingInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4830,__updateUnrealScoreHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4835,__weekOrderHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4836,__unrealActiveStateHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4829,__unrealMainInfoHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4828,__unrealShootingInfoHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4830,__updateUnrealScoreHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4835,__weekOrderHandler);
      }
      
      private function __unrealActiveStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:UnrealShootingMsg = new UnrealShootingMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as UnrealShootingMsg;
         _model.enterCount = _loc2_.enterCount;
         if(_loc2_.gameState == 1)
         {
            _model.showUnrealShootingBtn = true;
            _model.shineUnrealShootingBtn = true;
            TopToolsBar.instance.unrealshootingState = 2;
         }
         else if(_loc2_.gameState == 2)
         {
            _model.showUnrealShootingBtn = true;
            _model.shineUnrealShootingBtn = false;
            TopToolsBar.instance.unrealshootingState = 1;
         }
         else if(_loc2_.gameState == 3)
         {
            _model.showUnrealShootingBtn = true;
            _model.shineUnrealShootingBtn = false;
            TopToolsBar.instance.unrealshootingState = 0;
         }
         else
         {
            _model.showUnrealShootingBtn = false;
            _model.shineUnrealShootingBtn = false;
            TopToolsBar.instance.unrealshootingState = 0;
         }
         _model.commit();
      }
      
      private function __unrealMainInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:UnrealShootingUserInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:UnrealShootingMsg = new UnrealShootingMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as UnrealShootingMsg;
         var _loc4_:Array = [];
         _model.currentTime = getTimer();
         _model.leftTime = _loc2_.leftTime;
         if(_loc2_.param1 == 1)
         {
            SceneManager.instance.setScene("UNREAL_SHOOTING_ROOM");
         }
         else if(_loc2_.param1 == 3)
         {
            SwitchPageHelp.returnToSpace();
         }
         for each(_loc5_ in _loc2_.list)
         {
            _loc3_ = new UnrealShootingUserInfo();
            _loc3_.userId = _loc5_.userId;
            _loc3_.nickName = _loc5_.nickName;
            _loc3_.serverName = _loc5_.serverName;
            _loc3_.rank = _loc5_.rank;
            _loc3_.templateId = _loc5_.templateId;
            _loc4_.push(_loc3_);
            if(playerInfo.serviceName == _loc5_.serverName && playerInfo.userId == _loc5_.userId)
            {
               if(_loc5_.param1 == 1)
               {
                  _model.isLocked = true;
               }
               else
               {
                  _model.isLocked = false;
               }
            }
         }
         _loc4_.sort(sortUserByRank);
         _model.playerList = _loc4_;
      }
      
      private function __unrealShootingInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:UnrealShootingUserInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:UnrealShootingMsg = new UnrealShootingMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as UnrealShootingMsg;
         var _loc4_:Array = [];
         _model.selfPoint = _loc2_.param1;
         _model.selfScore = _loc2_.score;
         _model.leftTime = _loc2_.leftTime;
         for each(_loc5_ in _loc2_.list)
         {
            _loc3_ = new UnrealShootingUserInfo();
            _loc3_.userId = _loc5_.userId;
            _loc3_.nickName = _loc5_.nickName;
            _loc3_.serverName = _loc5_.serverName;
            _loc3_.score = _loc5_.score;
            _loc3_.killNum = _loc5_.killNum;
            _loc3_.team = _loc5_.team;
            _loc3_.itemCount = _loc5_.itemCount;
            _loc4_.push(_loc3_);
            if(playerInfo.serviceName == _loc5_.serverName && playerInfo.userId == _loc5_.userId)
            {
               _model.selfTeam = _loc5_.team;
            }
         }
         _loc4_.sort(sortUserByScore);
         _model.rankDetailList = _loc4_;
         _model.infoChange();
      }
      
      private function __updateUnrealScoreHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:UnrealShootingUserInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:UnrealShootingMsg = new UnrealShootingMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as UnrealShootingMsg;
         var _loc4_:Array = [];
         _model.teamScoreBlue = 0;
         _model.teamScoreRed = 0;
         for each(_loc5_ in _loc2_.list)
         {
            _loc3_ = new UnrealShootingUserInfo();
            _loc3_.userId = _loc5_.userId;
            _loc3_.nickName = _loc5_.nickName;
            _loc3_.serverName = _loc5_.serverName;
            _loc3_.score = _loc5_.score;
            _loc3_.killNum = _loc5_.killNum;
            _loc3_.team = _loc5_.team;
            _loc3_.itemCount = _loc5_.itemCount;
            _loc4_.push(_loc3_);
            if(playerInfo.serviceName == _loc5_.serverName && playerInfo.userId == _loc5_.userId)
            {
               _model.selfScore = _loc5_.score;
               _model.selfPoint = _loc5_.itemCount;
               _model.selfTeam = _loc5_.team;
            }
            if(_loc5_.team == 1)
            {
               _model.teamScoreBlue += _loc5_.score;
            }
            else if(_loc5_.team == 2)
            {
               _model.teamScoreRed += _loc5_.score;
            }
         }
         _loc4_.sort(sortUserByScore);
         _model.rankDetailList = _loc4_;
      }
      
      private function __weekOrderHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:UnrealShootingUserInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:UnrealShootingMsg = new UnrealShootingMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as UnrealShootingMsg;
         var _loc6_:Array = [];
         _loc3_ = new UnrealShootingUserInfo();
         _loc3_.userId = _loc2_.userId;
         _loc3_.nickName = _loc2_.param4;
         _loc3_.serverName = _loc2_.param3;
         _loc3_.rank = _loc2_.param1;
         _loc3_.fightPower = _loc2_.param2;
         _loc3_.score = _loc2_.score;
         _model.myRankInfo = _loc3_;
         for each(_loc4_ in _loc2_.list)
         {
            _loc3_ = new UnrealShootingUserInfo();
            _loc3_.uuid = _loc4_.uuid;
            _loc3_.userId = _loc4_.userId;
            _loc3_.rank = _loc4_.rank;
            _loc3_.nickName = _loc4_.nickName;
            _loc3_.serverName = _loc4_.serverName;
            _loc3_.score = _loc4_.score;
            _loc3_.fightPower = _loc4_.fightPower;
            _loc6_.push(_loc3_);
         }
         _loc6_.sort(sortUserByRank);
         _model.finalOrderList = _loc6_;
      }
      
      private function sortUserByScore(param1:UnrealShootingUserInfo, param2:UnrealShootingUserInfo) : int
      {
         if(param1.score > param2.score)
         {
            return -1;
         }
         if(param1.score < param2.score)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortUserByRank(param1:UnrealShootingUserInfo, param2:UnrealShootingUserInfo) : int
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
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function sendUnrealShootingEnter() : void
      {
         var _loc2_:PackageOut = new PackageOut(9662);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendUnrealShootingSelectTemplate(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(9662);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 2;
         _loc2_.param2 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendUnrealShootingConfirmTemplate(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(9662);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 3;
         _loc2_.param2 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendUnrealShootingBuyBuff(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(9662);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 4;
         _loc2_.param2 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendUnrealShootingWeekOrderQuery() : void
      {
         var _loc2_:PackageOut = new PackageOut(9662);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 5;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendUnrealShootingLeaveMatch() : void
      {
         var _loc2_:PackageOut = new PackageOut(9662);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 6;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
   }
}

