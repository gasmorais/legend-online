package mvc.controler
{
   import com.road.yishi.proto.pvp.PvpCampaignMsg;
   import com.road.yishi.proto.pvp.PvpInfoMsg;
   import com.road.yishi.proto.pvp.PvpMsg;
   import com.road.yishi.proto.pvp.PvpUserInfoMsg;
   import com.road.yishi.proto.pvp.PvpUserMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.team.TeamInfoStateMsg;
   import com.road.yishi.proto.team.TeamStateMsg;
   import flash.utils.Dictionary;
   import map.campaign.data.SvsModel;
   import map.campaign.data.SvsServerInfo;
   import map.campaign.data.SvsUserInfo;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   
   public class SvsController extends FrameController
   {
      
      public static const ENTER_WAR:int = 1;
      
      public static const ENTER_WAR_ADD:int = 2;
      
      public static const RANK_LIST:int = 3;
      
      private var _model:SvsModel;
      
      public var _isInSvsFrame:Boolean = false;
      
      private var _userDic:Dictionary;
      
      public function SvsController()
      {
         super();
         _model = new SvsModel();
         addEvent();
      }
      
      public function set isInSvsFrame(param1:Boolean) : void
      {
         _isInSvsFrame = param1;
      }
      
      public function get isInSvsFrame() : Boolean
      {
         return _isInSvsFrame;
      }
      
      public function get model() : SvsModel
      {
         return _model;
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "svs.SvsEnterWarFrame";
            case 2:
               return "svs.SvsEnterWarAddFrame";
            case 3:
               return "svs.SvsRankListFrame";
            default:
               return "svs.SvsFrame";
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
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4743,__svsUserInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4778,__svsUserStateInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4750,__svsUserOnlineHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4744,__svsCampaignInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4755,__svsIconHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4756,__svsGroupHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4754,__svsFinalInfoHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4743,__svsUserInfoHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4778,__svsUserStateInfoHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4750,__svsUserOnlineHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4744,__svsCampaignInfoHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4755,__svsIconHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4756,__svsGroupHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4754,__svsFinalInfoHandler);
      }
      
      public function get userDic() : Dictionary
      {
         return _userDic;
      }
      
      private function __svsUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:* = null;
         var _loc3_:SvsUserInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PvpUserMsg = new PvpUserMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PvpUserMsg;
         _userDic = new Dictionary();
         var _loc4_:Array = [];
         for each(_loc6_ in _loc2_.pvpInfo)
         {
            _loc3_ = new SvsUserInfo();
            _loc3_.userId = _loc6_.userId;
            _loc3_.nickName = _loc6_.nickName;
            _loc3_.teamUid = _loc6_.teamUid;
            _loc3_.isEnterPvp = _loc6_.isEnterPvp;
            _loc3_.isExist = _loc6_.isExist;
            _loc3_.isOnline = _loc6_.isOnline;
            _loc3_.grades = _loc6_.grades;
            _loc3_.hostPlayer = _loc6_.hostPlayer;
            _loc3_.job = _loc6_.job;
            _loc3_.fightPower = _loc6_.fightPower;
            _loc3_.serverName = _loc6_.serverName;
            _loc4_.push(_loc3_);
            if(_loc3_.hostPlayer == 1)
            {
               _model.hostPlayerId = _loc3_.userId;
            }
            _userDic[_loc3_.userId] = _loc3_;
         }
         _loc4_.sortOn("fightPower",0x10 | 2);
         _model.warFightUserList = _loc4_;
         sendSvsUserInfoStateReq();
      }
      
      private function __svsUserStateInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:SvsUserInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TeamInfoStateMsg = new TeamInfoStateMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TeamInfoStateMsg;
         if(!_userDic)
         {
            return;
         }
         var _loc4_:Array = [];
         for each(_loc5_ in _loc2_.team)
         {
            _loc3_ = _userDic[_loc5_.userId] as SvsUserInfo;
            _loc3_.hasTeam = _loc5_.hasIsReject;
         }
         for each(_loc3_ in _userDic)
         {
            _loc4_.push(_loc3_);
         }
         if(_loc2_.team.length > 0)
         {
            _loc4_.sortOn("fightPower",0x10 | 2);
            _model.warFightUserList = _loc4_;
         }
      }
      
      private function __svsUserOnlineHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:* = null;
         var _loc3_:SvsUserInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PvpUserMsg = new PvpUserMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PvpUserMsg;
         var _loc4_:Array = [];
         for each(_loc6_ in _loc2_.pvpInfo)
         {
            _loc3_ = new SvsUserInfo();
            _loc3_.userId = _loc6_.userId;
            _loc3_.nickName = _loc6_.nickName;
            _loc3_.teamUid = _loc6_.teamUid;
            _loc3_.isEnterPvp = _loc6_.isEnterPvp;
            _loc3_.isExist = _loc6_.isExist;
            _loc3_.isOnline = _loc6_.isOnline;
            _loc3_.grades = _loc6_.grades;
            _loc3_.hostPlayer = _loc6_.hostPlayer;
            _loc3_.job = _loc6_.job;
            _loc3_.fightPower = _loc6_.fightPower;
            _loc4_.push(_loc3_);
         }
         _loc4_.sortOn("fightPower",0x10 | 2);
         _model.onlineUserList = _loc4_;
      }
      
      private function __svsCampaignInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PvpCampaignMsg = new PvpCampaignMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PvpCampaignMsg;
         if(_loc2_.teamId1 == 2)
         {
            _model.svsCampaignInfo.site1 = _loc2_.site2;
            _model.svsCampaignInfo.teamId1 = _loc2_.teamId2;
            _model.svsCampaignInfo.liveCount1 = _loc2_.liveCount2;
            _model.svsCampaignInfo.totalCount1 = _loc2_.totalCount2;
            _model.svsCampaignInfo.site2 = _loc2_.site1;
            _model.svsCampaignInfo.teamId2 = _loc2_.teamId1;
            _model.svsCampaignInfo.liveCount2 = _loc2_.liveCount1;
            _model.svsCampaignInfo.totalCount2 = _loc2_.totalCount1;
         }
         else
         {
            _model.svsCampaignInfo.site1 = _loc2_.site1;
            _model.svsCampaignInfo.teamId1 = _loc2_.teamId1;
            _model.svsCampaignInfo.liveCount1 = _loc2_.liveCount1;
            _model.svsCampaignInfo.totalCount1 = _loc2_.totalCount1;
            _model.svsCampaignInfo.site2 = _loc2_.site2;
            _model.svsCampaignInfo.teamId2 = _loc2_.teamId2;
            _model.svsCampaignInfo.liveCount2 = _loc2_.liveCount2;
            _model.svsCampaignInfo.totalCount2 = _loc2_.totalCount2;
         }
         _model.svsCampaignInfo.commit();
      }
      
      private function __svsIconHandler(param1:SLGSocketEvent) : void
      {
         _model.showSvsBtn = true;
         _model.commit();
      }
      
      private function __svsGroupHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PvpInfoMsg = new PvpInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PvpInfoMsg;
         _model.groupId = _loc2_.groupId;
         _model.selfServerName = _loc2_.teamName;
         _model.matchServerName = _loc2_.property1;
         _model.currentTurn = int(_loc2_.property3);
         _model.openDate = DateFormatter.parse(_loc2_.property2,"YYYY-MM-DD hh:mm:ss");
         _model.commit();
      }
      
      private function __svsFinalInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:SvsServerInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:PvpMsg = new PvpMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as PvpMsg;
         _model.selfOrder = _loc2_.param1;
         _model.selfFightPower = _loc2_.param2;
         var _loc5_:Array = [];
         for each(_loc4_ in _loc2_.pvpInfo)
         {
            _loc3_ = new SvsServerInfo();
            _loc3_.teamUid = _loc4_.teamUid;
            _loc3_.teamName = _loc4_.teamName;
            _loc3_.finalOrder = _loc4_.finalOrder;
            _loc3_.fightPower = _loc4_.fightPower;
            _loc5_.push(_loc3_);
         }
         _loc5_.sort(sortByOrder);
         _model.finalOrderList = _loc5_;
      }
      
      private function sortByOrder(param1:SvsServerInfo, param2:SvsServerInfo) : int
      {
         if(param1.finalOrder < param2.finalOrder)
         {
            return -1;
         }
         if(param1.finalOrder > param2.finalOrder)
         {
            return 1;
         }
         return 0;
      }
      
      public function sendSvsUserInfoReq() : void
      {
         var _loc1_:PackageOut = new PackageOut(8864);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      private function get selfServerName() : String
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
      }
      
      public function sendSvsUserInfoStateReq() : void
      {
         var _loc2_:PackageOut = new PackageOut(25142);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param4 = selfServerName;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendSvsUserOnlineReq() : void
      {
         var _loc1_:PackageOut = new PackageOut(8870);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function sendSvsUserInfoEdit(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8863);
         var _loc3_:PvpUserMsg = new PvpUserMsg();
         _loc3_.param1 = param1;
         _loc3_.param3 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendSvsEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(8867);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function sendSvsLocalGroupReq() : void
      {
         var _loc1_:PackageOut = new PackageOut(8874);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function sendSvsFinalInfoReq() : void
      {
         var _loc1_:PackageOut = new PackageOut(8872);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function sendImmediateWar() : void
      {
         var _loc1_:PackageOut = new PackageOut(8991);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
   }
}

