package chat
{
   import battle.BattleManager;
   import chat.datas.ChatData;
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.chat.ChatChannelMsg;
   import com.road.yishi.proto.cross.CrossBigBugleMsg;
   import com.road.yishi.proto.friend.RelationGraphOpMsg;
   import flash.utils.getTimer;
   import mainBar.ChatBar;
   import managers.FreedomTeamManager;
   import managers.GameHallManager;
   import managers.GroupfbManager;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.braveleg.BraveLegPlayerInfo;
   import mvc.module.crisis.PlaneCrisisModel;
   import mvc.module.crisis.PlaneCrisisPlayerInfo;
   import mvc.module.gamehall.GameHallArmy;
   import mvc.module.gamehall.GameHallModel;
   import mvc.module.groupfb.GroupfbModel;
   import mvc.module.groupfb.GroupfbPlayerInfo;
   import mvc.module.room.RoomInfo;
   import sandbox.SandboxManager;
   import yishi.comm.PackageOut;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.interfaces.ISceneChat;
   import yishi.manager.ArmyManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.WorldBossHelper;
   
   public class ChatSocketOutManager
   {
      
      public static var sceneChat:ISceneChat;
      
      public function ChatSocketOutManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function sendChat(param1:ChatData) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc8_:PackageOut = null;
         var _loc9_:Boolean = false;
         if(ConfigManager.info.FORBIT_CHAT)
         {
            _loc6_ = ChatManager.instance.model.beginTime.time * 0.001;
            _loc7_ = ChatManager.instance.model.endTime.time * 0.001;
            _loc2_ = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
            if(_loc6_ <= _loc2_ && _loc7_ > _loc2_)
            {
               return;
            }
         }
         var _loc3_:ChatChannelMsg = new ChatChannelMsg();
         _loc3_.channel = param1.channel;
         _loc3_.encodeMsg = param1.msg;
         _loc3_.items = param1.itemList;
         _loc3_.stars = param1.starList;
         _loc3_.powcards = param1.cardList;
         _loc3_.shareTimeSpace = param1.shareSpaceList == null ? [] : param1.shareSpaceList;
         var _loc5_:String = SceneManager.instance.currentType;
         var _loc4_:int = 0;
         if(ChatBar.inBattleFlag && BattleManager.getInstance()._curJoinType == 1)
         {
            _loc9_ = false;
         }
         else
         {
            _loc9_ = initChatData(param1,_loc3_);
         }
         if(_loc9_)
         {
            _loc4_ = ChatManager.instance.model.protocalId;
            _loc8_ = new PackageOut(25024,0,_loc4_);
            ChatManager.instance.model.addSendProtocol(_loc4_,getTimer());
         }
         else
         {
            switch(_loc5_)
            {
               case "VEHICLE":
               case "CAMPAIGN_MAP_SCENE":
               case "BATTLE_SCENE":
               case "SANDBOX_SCENE":
                  if(CampaignManager.instance.mapModel && !CampaignManager.instance.exit)
                  {
                     if(CampaignManager.instance.mapModel.isCross && (6 == param1.channel || 8 == param1.channel))
                     {
                        _loc4_ = ChatManager.instance.model.protocalId;
                        _loc8_ = new PackageOut(25096,0,_loc4_);
                        ChatManager.instance.model.addSendProtocol(_loc4_,getTimer());
                        _loc3_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
                     }
                     else
                     {
                        _loc8_ = new PackageOut(15005);
                     }
                  }
                  else if(!SandboxManager.instance.exit)
                  {
                     if(6 == param1.channel || 8 == param1.channel)
                     {
                        _loc4_ = ChatManager.instance.model.protocalId;
                        _loc8_ = new PackageOut(25211,0,_loc4_);
                        ChatManager.instance.model.addSendProtocol(_loc4_,getTimer());
                        _loc3_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
                     }
                     else
                     {
                        _loc8_ = new PackageOut(15005);
                     }
                  }
                  else
                  {
                     _loc8_ = new PackageOut(15005);
                  }
                  break;
               case "GAME_HALL_SCENE":
                  _loc4_ = ChatManager.instance.model.protocalId;
                  _loc8_ = new PackageOut(15005,0,_loc4_);
                  break;
               default:
                  _loc8_ = new PackageOut(15005);
            }
         }
         param1.dispose();
         param1 = null;
         sendProtoBuffer(_loc8_,_loc3_);
      }
      
      private static function initChatData(param1:ChatData, param2:ChatChannelMsg) : Boolean
      {
         var _loc4_:RoomInfo = null;
         var _loc3_:String = SceneManager.instance.currentType;
         switch(_loc3_)
         {
            case "BATTLE_SCENE":
               if(param1.channel == 8)
               {
                  return initBattleCurrentPlayer(param2);
               }
               if(param1.channel == 6)
               {
                  initBattleTeamPlayer(param2);
               }
               else if(param1.channel == 14)
               {
                  initMapGroupTeamPlayer(param2);
               }
               break;
            case "PVE_ROOM_SCENE":
            case "PVP_ROOM_SCENE":
            case "MULTILORDS_ROOM":
            case "APEX_ROOM":
            case "GLORY_GAME_SCENE":
            case "MATELORDS_ROOM":
               if(param1.channel == 8 || param1.channel == 6)
               {
                  initRoomPlayer(param2);
               }
               break;
            case "GAME_HALL_SCENE":
               if(param1.channel == 8 || param1.channel == 6)
               {
                  initGameHallPlayer(param2);
               }
               break;
            case "PLANE_CRISRIS":
               if(param1.channel == 8 || param1.channel == 6)
               {
                  initPlaneCrisrisPlayer(param2);
               }
               break;
            case "VEHICLE":
               if(sceneChat)
               {
                  if(param1.channel == 8)
                  {
                     param2.team = param2.team.concat(sceneChat.currentChanelPlayerList);
                  }
                  else if(param1.channel == 6)
                  {
                     param2.team = param2.team.concat(sceneChat.teamChanelPlayerList);
                  }
               }
               break;
            case "CAMPAIGN_MAP_SCENE":
               if(param1.channel == 8)
               {
                  initMapCurrentPlayer(param2);
               }
               else if(param1.channel == 6)
               {
                  initMapTeamPlayer(param2);
               }
               else if(param1.channel == 14)
               {
                  initMapGroupTeamPlayer(param2);
               }
               break;
            case "SPACE_SCENE":
               if(param1.channel == 14)
               {
                  initMapGroupTeamPlayer(param2);
               }
               else if(param1.channel == 6)
               {
                  initMapTeamPlayer(param2);
               }
               break;
            default:
               _loc4_ = RoomManager.instance.roomInfo;
               if(_loc4_ && _loc4_.roomType == 2)
               {
                  initRoomPlayer(param2);
               }
         }
         if(param1.channel == 6)
         {
            initFreedomTeamPlayer(param2);
            initBraveLegTeamPlayer(param2);
         }
         return false;
      }
      
      private static function initBattleCurrentPlayer(param1:ChatChannelMsg) : Boolean
      {
         var _loc4_:BattleModel = BattleManager.getInstance().battleModel;
         var _loc5_:ThaneInfo = ArmyManager.instance.thane;
         var _loc2_:Boolean = false;
         switch(_loc4_.battleType)
         {
            case 10:
            case 308:
               _loc2_ = true;
               break;
            default:
               _loc2_ = false;
         }
         if(!_loc2_)
         {
            for each(var _loc3_:RoleInfo in _loc4_.roleList)
            {
               if(_loc3_ is HeroRoleInfo && HeroRoleInfo(_loc3_).type != 3)
               {
                  if(param1.team.indexOf(HeroRoleInfo(_loc3_).userId) < 0)
                  {
                     param1.team.push(HeroRoleInfo(_loc3_).userId);
                  }
               }
            }
         }
         param1.battleId = _loc4_.battleId;
         param1.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         return _loc2_;
      }
      
      private static function initBattleTeamPlayer(param1:ChatChannelMsg) : void
      {
         initMapTeamPlayer(param1);
         var _loc2_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc2_ && _loc2_.armyInfoLeft && _loc2_.armyInfoLeft.getHeros)
         {
            for each(var _loc3_:HeroRoleInfo in _loc2_.armyInfoLeft.getHeros)
            {
               if(param1.team.indexOf(_loc3_.userId) < 0)
               {
                  param1.team.push(_loc3_.userId);
               }
            }
         }
      }
      
      private static function initRoomPlayer(param1:ChatChannelMsg) : void
      {
         if(FreedomTeamManager.instance.hasTeam)
         {
            return;
         }
         var _loc3_:RoomInfo = RoomManager.instance.roomInfo;
         if(_loc3_)
         {
            for each(var _loc2_:CampaignArmy in _loc3_.playerList)
            {
               if(param1.team.indexOf(_loc2_.userId) < 0)
               {
                  param1.team.push(_loc2_.userId);
               }
            }
         }
      }
      
      private static function initGameHallPlayer(param1:ChatChannelMsg) : void
      {
         var _loc3_:GameHallModel = GameHallManager.instance.model;
         if(_loc3_)
         {
            for each(var _loc2_:GameHallArmy in _loc3_.allArmyDict)
            {
               if(param1.team.indexOf(_loc2_.userId) < 0)
               {
                  param1.team.push(_loc2_.userId);
               }
            }
         }
      }
      
      private static function initPlaneCrisrisPlayer(param1:ChatChannelMsg) : void
      {
         var _loc2_:PlaneCrisisModel = PlaneCrisisManager.Instance.model;
         if(_loc2_)
         {
            for each(var _loc3_:PlaneCrisisPlayerInfo in _loc2_.planeCrisisInfoDic)
            {
               if(param1.team.indexOf(_loc3_.userId) < 0)
               {
                  param1.team.push(_loc3_.userId);
               }
            }
         }
      }
      
      private static function initMapCurrentPlayer(param1:ChatChannelMsg) : void
      {
         var _loc3_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc3_)
         {
            for each(var _loc2_:CampaignArmy in _loc3_.allUserArmy)
            {
               if(param1.team.indexOf(_loc2_.userId) < 0)
               {
                  param1.team.push(_loc2_.userId);
               }
            }
         }
      }
      
      private static function initMapTeamPlayer(param1:ChatChannelMsg) : void
      {
         var _loc4_:CampaignArmy = null;
         if(FreedomTeamManager.instance.hasTeam)
         {
            return;
         }
         var _loc3_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(!_loc3_)
         {
            return;
         }
         if(groupfbModel.hasGroupTeam)
         {
            for each(var _loc5_:GroupfbPlayerInfo in groupfbModel.selfTeam.getTeamList(groupfbModel.selfTeam.selfInfo.team))
            {
               param1.team.push(_loc5_.userId);
            }
         }
         else
         {
            _loc4_ = _loc3_.selfMemberData;
            for each(var _loc2_:CampaignArmy in _loc3_.allUserArmy)
            {
               if(WorldBossHelper.checkRapidMap(_loc4_.mapId))
               {
                  if(param1.team.indexOf(_loc2_.userId) < 0)
                  {
                     param1.team.push(_loc2_.userId);
                  }
               }
               else if(_loc4_.teamId == _loc2_.teamId && param1.team.indexOf(_loc2_.userId) < 0)
               {
                  param1.team.push(_loc2_.userId);
               }
            }
         }
      }
      
      private static function initMapGroupTeamPlayer(param1:ChatChannelMsg) : void
      {
         if(FreedomTeamManager.instance.hasTeam)
         {
            return;
         }
         for each(var _loc2_:GroupfbPlayerInfo in groupfbModel.selfTeam.getAllTeamList())
         {
            if(param1.team.indexOf(_loc2_.userId) < 0)
            {
               param1.team.push(_loc2_.userId);
            }
         }
      }
      
      private static function initFreedomTeamPlayer(param1:ChatChannelMsg) : void
      {
         if(!FreedomTeamManager.instance.hasTeam)
         {
            return;
         }
         var _loc2_:int = FreedomTeamManager.instance.model.getMemberByUserId(ArmyManager.instance.thane.userId).mapId;
         if(WorldBossHelper.checkPvp(_loc2_) || WorldBossHelper.checkDuskArea(_loc2_) || WorldBossHelper.checkDuskArea(_loc2_) || WorldBossHelper.checkFlameTemple(_loc2_) || WorldBossHelper.checkSvs(_loc2_))
         {
            return;
         }
         for each(var _loc3_:BaseArmy in FreedomTeamManager.instance.model.allMembers)
         {
            if(param1.team.indexOf(_loc3_.userId) < 0 && !WorldBossHelper.checkPvp(_loc3_.mapId) && !WorldBossHelper.checkDuskArea(_loc3_.mapId) && !WorldBossHelper.checkDuskArea(_loc3_.mapId) && !WorldBossHelper.checkFlameTemple(_loc3_.mapId) && !WorldBossHelper.checkSvs(_loc3_.mapId))
            {
               param1.team.push(_loc3_.userId);
            }
         }
      }
      
      private static function initBraveLegTeamPlayer(param1:ChatChannelMsg) : void
      {
         var _loc3_:int = 0;
         if(!BraveLegManager.instance.model.teamInfo)
         {
            return;
         }
         var _loc2_:Vector.<BraveLegPlayerInfo> = BraveLegManager.instance.model.teamInfo.teammate;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1.team.indexOf(_loc2_[_loc3_].userId) == -1)
            {
               param1.team.push(_loc2_[_loc3_].userId);
            }
            _loc3_++;
         }
      }
      
      public static function sendCrossChat(param1:ChatData) : void
      {
         var _loc3_:PackageOut = new PackageOut(8623);
         var _loc2_:CrossBigBugleMsg = new CrossBigBugleMsg();
         _loc2_.content = param1.msg;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendOutyardChat(param1:ChatData) : void
      {
         var _loc3_:PackageOut = new PackageOut(9609);
         var _loc2_:RelationGraphOpMsg = new RelationGraphOpMsg();
         _loc2_.op = 5;
         _loc2_.param1 = param1.uuid;
         _loc2_.param2 = param1.msg;
         _loc2_.channel = 6;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendBugleChat(param1:ChatData) : void
      {
         var _loc3_:PackageOut = new PackageOut(5011);
         var _loc2_:ChatChannelMsg = new ChatChannelMsg();
         _loc2_.encodeMsg = param1.msg;
         _loc2_.items = param1.itemList;
         _loc2_.stars = param1.starList;
         _loc2_.powcards = param1.cardList == null ? [] : param1.cardList;
         _loc2_.shareTimeSpace = param1.shareSpaceList == null ? [] : param1.shareSpaceList;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendSmallBugleChat(param1:ChatData) : void
      {
         var _loc3_:int = ChatManager.instance.model.protocalId;
         ChatManager.instance.model.addSendProtocol(_loc3_,getTimer());
         var _loc4_:PackageOut = new PackageOut(8198,0,_loc3_);
         var _loc2_:ChatChannelMsg = new ChatChannelMsg();
         _loc2_.encodeMsg = param1.msg;
         _loc2_.items = param1.itemList;
         _loc2_.stars = param1.starList;
         _loc2_.powcards = param1.cardList == null ? [] : param1.cardList;
         _loc2_.shareTimeSpace = param1.shareSpaceList == null ? [] : param1.shareSpaceList;
         sendProtoBuffer(_loc4_,_loc2_);
      }
      
      private static function get groupfbModel() : GroupfbModel
      {
         return GroupfbManager.instance.model;
      }
      
      public static function sendSmallBugleFreeCount() : void
      {
         var _loc2_:PackageOut = new PackageOut(8705);
         var _loc1_:CampaignReqMsg = new CampaignReqMsg();
         sendProtoBuffer(_loc2_,_loc1_);
      }
   }
}

