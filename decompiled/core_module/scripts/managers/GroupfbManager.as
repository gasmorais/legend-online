package managers
{
   import com.pickgliss.ui.ComponentFactory;
   import com.road.yishi.proto.room.MatchStateMsg;
   import com.road.yishi.proto.room.TeamPlayerMsg;
   import com.road.yishi.proto.room.TeamRoomListMsg;
   import com.road.yishi.proto.room.TeamRoomMsg;
   import events.FreedomTeamEvent;
   import manager.LanguageMgr;
   import mvc.module.groupfb.GroupfbModel;
   import mvc.module.groupfb.GroupfbPlayerInfo;
   import mvc.module.groupfb.GroupfbRoomInfo;
   import mvc.module.groupfb.GroupfbSender;
   import ui.toptoolbar.TopToolsBar;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   
   public class GroupfbManager
   {
      
      private static var _instance:GroupfbManager;
      
      private var _model:GroupfbModel;
      
      public function GroupfbManager()
      {
         super();
         if(_model == null)
         {
            _model = new GroupfbModel();
         }
      }
      
      public static function get instance() : GroupfbManager
      {
         if(!_instance)
         {
            _instance = new GroupfbManager();
         }
         return _instance;
      }
      
      public function get model() : GroupfbModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4784,__campaignSwitch);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4785,__roomListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4786,__playerState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4791,__serachRoomResultHandler);
      }
      
      private function __serachRoomResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc5_:* = undefined;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TeamRoomMsg = new TeamRoomMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TeamRoomMsg;
         var _loc9_:GroupfbRoomInfo = model.getRoomInfoById(_loc2_.id);
         if(_loc9_)
         {
            _loc9_.passWord = _loc2_.pwd;
         }
         if(_loc2_.isInvite)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            _loc8_ = LanguageMgr.GetTranslation("groupfb.GroupfbTeam.RoomEnter.confirm",_loc2_.id);
            if(_loc2_.bossCount < 0)
            {
               _loc8_ += "\n" + LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum2");
            }
            else
            {
               _loc8_ += "\n" + LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum",_loc2_.bossCount);
            }
            SimpleAlertHelper.instance.data = [inviteBackCall,_loc2_.id];
         }
         else if(_loc2_.pwd)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswordFrame");
            _loc5_.backCall = passWordBackCall;
            _loc5_.show(_loc2_.id);
         }
         else
         {
            GroupfbSender.enterGroup(_loc2_.id,"",false);
         }
      }
      
      private function passWordBackCall(param1:int, param2:String) : void
      {
         GroupfbSender.enterGroup(param1,param2,false);
      }
      
      private function inviteBackCall(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            GroupfbSender.enterGroup(param3,"",true,!param2);
         }
      }
      
      private function __campaignSwitch(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MatchStateMsg = new MatchStateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MatchStateMsg;
         if(model.switchFlag != _loc2_.matchState)
         {
            model.switchFlag = _loc2_.matchState;
            TopToolsBar.instance.show();
         }
      }
      
      private function __roomListHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:GroupfbRoomInfo = null;
         var _loc3_:TeamRoomMsg = null;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TeamRoomListMsg = new TeamRoomListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TeamRoomListMsg;
         for each(_loc6_ in model.roomList)
         {
            _loc6_.isNew = false;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.roomList.length)
         {
            _loc3_ = _loc2_.roomList[_loc4_] as TeamRoomMsg;
            if(_loc3_.roomState != 3)
            {
               _loc6_ = model.getRoomInfoById(_loc3_.id);
               if(_loc6_ == null)
               {
                  _loc6_ = new GroupfbRoomInfo();
                  model.roomList.push(_loc6_);
               }
               _loc6_.id = _loc3_.id;
               _loc6_.name = _loc3_.name;
               _loc6_.count = _loc3_.count;
               _loc6_.total = _loc3_.capacity;
               _loc6_.passWord = _loc3_.pwd;
               _loc6_.state = _loc3_.roomState;
               _loc6_.isNew = true;
            }
            _loc4_++;
         }
         for each(_loc6_ in model.roomList)
         {
            if(_loc6_.isNew == false)
            {
               model.roomList.splice(model.roomList.indexOf(_loc6_),1);
            }
         }
         MsgMan.notifyObserver("PVPRoomListEvent.GROUP_ROOMLIST_UPDATE");
      }
      
      private function __playerState(param1:SLGSocketEvent) : void
      {
         var _loc3_:GroupfbPlayerInfo = null;
         var _loc4_:* = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TeamRoomMsg = new TeamRoomMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TeamRoomMsg;
         var _loc5_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:GroupfbRoomInfo = model.getRoomInfoById(_loc2_.id);
         if(_loc8_ == null)
         {
            _loc8_ = new GroupfbRoomInfo();
            model.roomList.push(_loc8_);
         }
         else if(model.hasGroupTeam)
         {
            _loc5_ = true;
         }
         if(_loc8_)
         {
            _loc8_.id = _loc2_.id;
            _loc8_.name = _loc2_.name;
            _loc8_.count = _loc2_.count;
            _loc8_.total = _loc2_.capacity;
            _loc8_.state = _loc2_.roomState;
            _loc8_.passWord = _loc2_.pwd;
            _loc8_.captainId = _loc2_.masterId;
            model.selfTeam = _loc8_;
            _loc8_.list.length = 0;
            if(_loc2_.infos)
            {
               for each(_loc4_ in _loc2_.infos)
               {
                  if(_loc4_.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
                  {
                     _loc7_ = true;
                  }
                  _loc3_ = new GroupfbPlayerInfo();
                  _loc3_.templateId = _loc4_.templateid;
                  _loc3_.userId = _loc4_.userId;
                  _loc3_.nickName = _loc4_.nickName;
                  _loc3_.job = _loc4_.job;
                  _loc3_.consortiaName = _loc4_.consortiaName;
                  _loc3_.grades = _loc4_.grade;
                  _loc3_.fightCapacity = _loc4_.fightPower;
                  _loc3_.team = _loc4_.team;
                  _loc3_.pos = _loc4_.fightPos;
                  _loc3_.state = _loc4_.readyState;
                  _loc3_.headID = _loc4_.headId;
                  _loc3_.isOnline = _loc4_.isOnline;
                  _loc3_.isNoGet = _loc4_.isNoGet;
                  _loc8_.list.push(_loc3_);
               }
            }
            if(_loc7_ && !_loc5_)
            {
               if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
               {
               }
            }
            MsgMan.notifyObserver("PVPRoomListEvent.GROUP_ROOM_UPDATE",_loc8_);
            NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
         }
      }
   }
}

