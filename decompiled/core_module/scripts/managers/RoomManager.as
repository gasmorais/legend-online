package managers
{
   import battle.BattleManager;
   import chat.datas.ChatData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.army.ArmyFightPosEditListMsg;
   import com.road.yishi.proto.army.HeroEquUpdatedMsg;
   import com.road.yishi.proto.room.ChangeMasterRspMsg;
   import com.road.yishi.proto.room.EditRoomRspMsg;
   import com.road.yishi.proto.room.KillPlayerRspMsg;
   import com.road.yishi.proto.room.PlaceStateRspMsg;
   import com.road.yishi.proto.room.PlayerReadyRspMsg;
   import com.road.yishi.proto.room.PlayerReadyRspMsg.PlayerReady;
   import com.road.yishi.proto.room.RoomExitRspMsg;
   import com.road.yishi.proto.room.RoomPlayerListMsg;
   import com.road.yishi.proto.room.RoomPlayerMsg;
   import com.road.yishi.proto.room.RoomReqMsg;
   import com.road.yishi.proto.room.RoomStateRspMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import map.campaign.data.CampaignArmy;
   import mvc.controler.RoomControl;
   import mvc.module.room.RoomInfo;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class RoomManager
   {
      
      public static var loginToRoomFlag:Boolean;
      
      private static var _instance:RoomManager;
      
      public var exit:Boolean;
      
      private var _roomInfo:RoomInfo;
      
      public var controller:RoomControl;
      
      public function RoomManager()
      {
         super();
      }
      
      public static function get instance() : RoomManager
      {
         if(!_instance)
         {
            _instance = new RoomManager();
         }
         return _instance;
      }
      
      public function get roomInfo() : RoomInfo
      {
         return _roomInfo;
      }
      
      public function setup(param1:RoomInfo) : void
      {
         exit = false;
         if(param1.roomType == 1)
         {
            BattleManager.preScene = "PVP_ROOM_SCENE";
         }
         else if(param1.roomType == 0)
         {
            BattleManager.preScene = "PVE_ROOM_SCENE";
         }
         else if(param1.roomType == 5)
         {
            BattleManager.preScene = "MULTILORDS_ROOM";
         }
         else if(param1.roomType == 8)
         {
            BattleManager.preScene = "MATELORDS_ROOM";
         }
         else if(param1.roomType == 9)
         {
            BattleManager.preScene = "ARESLORDS_ROOM";
         }
         else if(param1.roomType == 14)
         {
            BattleManager.preScene = "APEX_ROOM";
         }
         else if(param1.roomType == 15)
         {
            BattleManager.preScene = "GLORY_GAME_SCENE";
         }
         else if(param1.roomType == 16)
         {
            BattleManager.preScene = "THESE_Double_PVP_SCENE";
         }
         _roomInfo = param1;
         SocketManager.instance.addEventListener("SLGSocketEvent" + 120,__roomMemberHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4186,__requestTeamPosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 32,__updateRoomInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 28,__campaingkillOutHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4984,__crossCampaingkillOutHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 24,__updateReaderStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 15,__returnRoomHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 121,__updateHouseOwnerHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 25,__updateRoomStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 17,__roomPlaceStateChangeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 149,__otherHeroInfoChange);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4994,__crossMatchComfirmHandler);
         NotificationManager.instance.addEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
      }
      
      public function dispose() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 120,__roomMemberHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4186,__requestTeamPosHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 32,__updateRoomInfoHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 28,__campaingkillOutHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4984,__crossCampaingkillOutHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 24,__updateReaderStateHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 15,__returnRoomHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 121,__updateHouseOwnerHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 25,__updateRoomStateHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 17,__roomPlaceStateChangeHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 149,__otherHeroInfoChange);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4994,__crossMatchComfirmHandler);
         NotificationManager.instance.removeEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
         _roomInfo = null;
         controller = null;
         _instance = null;
         if(BattleManager.preScene == "PVP_ROOM_SCENE" || BattleManager.preScene == "PVE_ROOM_SCENE" || BattleManager.preScene == "MATELORDS_ROOM" || BattleManager.preScene == "ARESLORDS_ROOM" || BattleManager.preScene == "APEX_ROOM" || BattleManager.preScene == "GLORY_GAME_SCENE" || BattleManager.preScene == "GAME_HALL_SCENE" || BattleManager.preScene == "THESE_Double_PVP_SCENE")
         {
            BattleManager.preScene = "";
         }
         ArmyManager.instance.thane.inviteContent = "";
      }
      
      private function __playerChatHandler(param1:NotificationEvent) : void
      {
         var _loc3_:ChatData = param1.data as ChatData;
         if(_loc3_.channel != 6 && _loc3_.channel != 8)
         {
            return;
         }
         var _loc2_:CampaignArmy = _roomInfo.getPlayerByUserId(_loc3_.uid,_loc3_.serverName);
         if(_loc2_)
         {
            _loc2_.chatData = _loc3_;
         }
      }
      
      private function __otherHeroInfoChange(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:HeroEquUpdatedMsg = new HeroEquUpdatedMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as HeroEquUpdatedMsg;
         var _loc5_:int = _loc2_.playerId;
         var _loc3_:CampaignArmy = roomInfo.getPlayerByUserId(_loc5_,"");
         if(_loc3_ && _loc3_.baseHero)
         {
            _loc3_.baseHero.beginChanges();
            _loc3_.baseHero.armsEquipAvata = _loc2_.armStr;
            _loc3_.baseHero.bodyEquipAvata = _loc2_.clothStr;
            _loc3_.baseHero.wingAvata = _loc2_.wing;
            _loc3_.baseHero.hairFashionAvata = _loc2_.hat;
            _loc3_.baseHero.armsFashionAvata = _loc2_.fashionArm;
            _loc3_.baseHero.bodyFashionAvata = _loc2_.fashionCloth;
            _loc3_.baseHero.hideFashion = _loc2_.hide;
            _loc3_.baseHero.appellId = _loc2_.appellId;
            _loc3_.baseHero.vocationGrades = _loc2_.transGrade;
            _loc3_.baseHero.vocationIndex = _loc2_.changeBranch;
            _loc3_.baseHero.commit();
         }
      }
      
      private function __roomMemberHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomPlayerListMsg = new RoomPlayerListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RoomPlayerListMsg;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.roomPlayer.length)
         {
            readMember(_loc2_.roomPlayer[_loc3_] as RoomPlayerMsg);
            _loc3_++;
         }
      }
      
      private function __requestTeamPosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyFightPosEditListMsg = new ArmyFightPosEditListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ArmyFightPosEditListMsg;
         roomInfo.armyFightPos = _loc2_.armyFightPos;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function readMember(param1:RoomPlayerMsg) : void
      {
         var _loc7_:ThaneInfo = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc11_:int = 0;
         var _loc9_:Array = null;
         var _loc5_:* = null;
         var _loc6_:Array = null;
         _roomInfo.id = param1.roomId;
         _roomInfo.curCount = param1.count;
         var _loc4_:CampaignArmy = roomInfo.getPlayerByUserId(param1.playerId,param1.serverName);
         if(!_loc4_)
         {
            _loc4_ = new CampaignArmy();
         }
         _loc4_.pos = param1.currentRoomIndex;
         _loc4_.roomState = param1.playerState;
         var _loc8_:int = param1.heroId;
         var _loc10_:int = param1.playerId;
         if(_loc10_ == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            _loc7_ = thane;
            _loc4_.baseHero = _loc7_;
         }
         else
         {
            _loc7_ = _loc4_.baseHero;
         }
         _loc7_.id = _loc8_;
         _loc7_.theseusMultiPvpRankName = param1.theseusMultiPvpRankName;
         _loc7_.theseusMultiPvpIntegral = param1.theseusMultiPvpIntegral;
         _loc7_.userId = _loc10_;
         _loc7_.IsVipAndNoExpirt = param1.isVip;
         _loc7_.vipType = param1.vipType;
         _loc7_.grades = param1.grades;
         _loc7_.nickName = param1.nickName;
         _loc7_.templateId = param1.templateId;
         _loc7_.headId = param1.headId;
         _loc7_.armsEquipAvata = param1.arm;
         _loc7_.bodyEquipAvata = param1.cloth;
         param1.hasWing && (_loc7_.wingAvata = param1.wing);
         _loc7_.hairFashionAvata = param1.hat;
         _loc7_.armsFashionAvata = param1.fashionArm;
         _loc7_.bodyFashionAvata = param1.fashionCloth;
         _loc7_.hideFashion = param1.hide;
         _loc7_.attackProrerty.totalConatArmy;
         _loc7_.changeShapeId = param1.changeShapeId;
         _loc7_.state = param1.onlineState ? 7 : 0;
         _loc7_.honer = param1.geste;
         _loc7_.appellId = param1.appellid;
         if(param1.hasDragonGrade)
         {
            _loc9_ = param1.dragonGrade.split("|");
            for each(_loc5_ in _loc9_)
            {
               _loc6_ = _loc5_.split(",");
               if(int(_loc6_[0]) > _loc2_)
               {
                  _loc2_ = int(_loc6_[0]);
                  _loc3_ = int(_loc6_[1]);
                  _loc11_ = int(_loc6_[2]);
               }
            }
            _loc7_.dragonSoulType = _loc2_;
            _loc7_.dragonSoulGrade = _loc3_;
            _loc7_.dragonSoulGp = _loc11_;
         }
         if(param1.hasTransferGrade)
         {
            _loc7_.vocationGrades = param1.transferGrade;
         }
         if(param1.hasChangeBranch)
         {
            _loc7_.vocationIndex = param1.changeBranch;
         }
         if(param1.hasIsBackPlayer)
         {
            _loc7_.isBackPlayer = param1.isBackPlayer;
         }
         _loc4_.userId = _loc10_;
         _loc4_.id = param1.armyId;
         _loc4_.combatPower = param1.fightingCapacity;
         _loc4_.curPosX = param1.curPosX;
         _loc4_.curPosY = param1.curPosY;
         _loc4_.mapId = param1.campaignId;
         _loc4_.online = param1.onlineState;
         _loc4_.isNoGet = param1.isNoGet;
         if(param1.hasMountTempId)
         {
            _loc4_.mountTemplateId = param1.mountTempId;
         }
         if(param1.hasMountGrade)
         {
            _loc4_.mountGrade = param1.mountGrade;
         }
         if(param1.hasVehicleTemplateId)
         {
            _loc7_.vehicleTempId = param1.vehicleTemplateId;
         }
         if(param1.hasPetName)
         {
            _loc4_.petInfo.petName = param1.petName;
            _loc7_.petName = param1.petName;
         }
         if(param1.hasPetQuqlity)
         {
            if(param1.petQuqlity < 26)
            {
               _loc4_.petInfo.petQuaity = (param1.petQuqlity - 1) / 5 + 1;
               _loc7_.petQuaity = (param1.petQuqlity - 1) / 5 + 1;
            }
            else
            {
               _loc4_.petInfo.petQuaity = (param1.petQuqlity - 1) / 5;
               _loc7_.petQuaity = (param1.petQuqlity - 1) / 5;
            }
            _loc4_.petInfo.petTemQuality = param1.petQuqlity;
            _loc7_.temQuality = param1.petQuqlity;
         }
         if(param1.hasPetTemplateId)
         {
            _loc7_.petTemplateId = param1.petTemplateId;
            _loc4_.petInfo.petTemplateId = param1.petTemplateId;
         }
         if(param1.hasChildName)
         {
            _loc4_.childrenInfo.childrenName = param1.childName;
            _loc7_.childrenName = param1.childName;
         }
         if(param1.hasChildJob)
         {
            _loc4_.childrenInfo.childrenJob = param1.childJob;
            _loc7_.childrenJob = param1.childJob;
         }
         if(param1.hasChildSex)
         {
            _loc4_.childrenInfo.childrenSex = param1.childSex;
            _loc7_.childrenSex = param1.childSex;
         }
         if(param1.hasGrowthGrade)
         {
            _loc4_.childrenInfo.childrenGrade = param1.growthGrade;
            _loc7_.childrenGrade = param1.growthGrade;
         }
         if(param1.hasChildFightcap)
         {
            _loc4_.childrenInfo.childrenFightPower = param1.childFightcap;
            _loc7_.childrenFightPower = param1.childFightcap;
         }
         if(param1.hasGroupType)
         {
            _loc7_.leagueRankGroup = param1.groupType;
         }
         if(param1.hasRank)
         {
            _loc7_.leagueRankIndex = param1.rank;
         }
         _loc7_.consortiaID = param1.consortiaId;
         _loc7_.consortiaName = param1.consortiaName;
         _roomInfo.addArmy(_loc4_);
         _roomInfo.commit();
      }
      
      private function __updateRoomInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:EditRoomRspMsg = new EditRoomRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as EditRoomRspMsg;
         var _loc7_:int = _loc2_.roomId;
         var _loc4_:int = _loc2_.startCampaignId;
         var _loc5_:int = _loc2_.masterId;
         var _loc3_:int = _loc2_.count;
         var _loc8_:int = _loc2_.capacity;
         if(_roomInfo.id == _loc7_)
         {
            _roomInfo.houseOwnerId = _loc5_;
            _roomInfo.campaignId = _loc4_;
            _roomInfo.curCount = _loc3_;
            _roomInfo.capacity = _loc8_;
            _roomInfo.password = _loc2_.passWord;
            _roomInfo.commit();
            NotificationManager.instance.dispatchEvent(new NotificationEvent("ROOM_SELECT_CHANGE",_roomInfo));
            ArmyManager.instance.thane.inviteContent = "";
         }
      }
      
      private function __campaingkillOutHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Object = null;
         var _loc5_:String = null;
         var _loc4_:CampaignArmy = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:KillPlayerRspMsg = new KillPlayerRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as KillPlayerRspMsg;
         var _loc8_:int = _loc2_.roomId;
         var _loc7_:int = _loc2_.killedPlayerId;
         if(_roomInfo && _loc8_ == _roomInfo.id)
         {
            if(_loc7_ == selfPlayerInfo.userId)
            {
               exit = true;
               _loc5_ = SceneManager.instance.currentType;
               if(_loc5_ == "PVE_ROOM_SCENE")
               {
                  _loc3_ = {"isOpenPveRoomList":true};
               }
               else if(_loc5_ == "PVP_ROOM_SCENE")
               {
                  _loc3_ = {"isOpenPvpRoomList":true};
               }
               else if(_roomInfo.roomType == 2)
               {
                  NotificationManager.instance.sendNotification("VEHICLE_ROOM_KILL_OUT",_loc7_);
                  dispose();
                  return;
               }
               SwitchPageHelp.returnToSpace(_loc3_);
            }
            else
            {
               _loc4_ = _roomInfo.removePlayerByUserId(_loc7_,"");
               if(_loc4_)
               {
                  NotificationManager.instance.sendNotification("roomKillOut",_loc4_.id);
               }
            }
         }
         _roomInfo.commit();
      }
      
      private function __updateReaderStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:CampaignArmy = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerReadyRspMsg = new PlayerReadyRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as PlayerReadyRspMsg;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.readyState.length)
         {
            _loc7_ = (_loc2_.readyState[_loc5_] as PlayerReady).playerId;
            _loc3_ = (_loc2_.readyState[_loc5_] as PlayerReady).readyState;
            _loc4_ = _roomInfo.getPlayerByUserId(_loc7_,"");
            if(_loc4_)
            {
               _loc4_.roomState = _loc3_;
               _loc4_.commit();
            }
            _loc5_++;
         }
         _roomInfo.commit();
      }
      
      private function __returnRoomHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomExitRspMsg = new RoomExitRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RoomExitRspMsg;
         var _loc6_:int = _loc2_.playerId;
         if(_roomInfo)
         {
            _roomInfo.removePlayerByUserId(_loc6_,"");
            if(_loc6_ == selfPlayerInfo.userId)
            {
               exit = true;
               _loc4_ = SceneManager.instance.currentType;
               if(_loc4_ == "PVE_ROOM_SCENE")
               {
                  _loc3_ = {"isOpenPveRoomList":true};
               }
               else if(_loc4_ == "PVP_ROOM_SCENE")
               {
                  _loc3_ = {"isOpenPvpRoomList":true};
               }
               SwitchPageHelp.returnToSpace(_loc3_);
            }
            _roomInfo.commit();
         }
      }
      
      private function __updateHouseOwnerHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:CampaignArmy = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChangeMasterRspMsg = new ChangeMasterRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ChangeMasterRspMsg;
         _roomInfo.isCross = _loc2_.isCross;
         if(!_loc2_.isCross)
         {
            _loc6_ = _loc2_.roomId;
         }
         var _loc4_:int = _loc2_.masterId;
         if(_roomInfo)
         {
            _roomInfo.houseOwnerId = _loc4_;
            if(_loc2_.isCross && _loc2_.hasServerName)
            {
               _roomInfo.serverName = _loc2_.serverName;
            }
            _roomInfo.commit();
            _loc3_ = _roomInfo.getPlayerByUserId(_loc4_,_roomInfo.serverName);
            if(_loc3_)
            {
               _loc3_.commit();
            }
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_UPDATA_ROOM_OWNER"));
      }
      
      private function __updateRoomStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomStateRspMsg = new RoomStateRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RoomStateRspMsg;
         var _loc3_:int = _loc2_.roomState;
         _roomInfo.roomState = _loc3_;
         _roomInfo.commit();
      }
      
      private function __roomPlaceStateChangeHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlaceStateRspMsg = new PlaceStateRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as PlaceStateRspMsg;
         var _loc4_:int = int(_loc2_.placeState.length);
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_[_loc5_] = _loc2_.placeState[_loc5_];
            _loc5_++;
         }
         roomInfo.placesState = _loc3_;
      }
      
      private function __crossCampaingkillOutHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomReqMsg = new RoomReqMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RoomReqMsg;
         var _loc3_:Frame = ComponentFactory.Instance.creatComponentByStylename("crossCampaign.CrossCampaignKillOutFrame");
         _loc3_["content"] = _loc2_.password;
         _loc3_["show"]();
      }
      
      private function __crossMatchComfirmHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PropertyMsg;
         var _loc4_:Object = {};
         _loc4_.leftBoss = _loc2_.param1;
         _loc4_.totalBoss = _loc2_.param2;
         _loc4_.campaignName = _loc2_.param4;
         _loc4_.campaignUid = _loc2_.param5;
         _loc4_.roomId = _loc2_.param6;
         var _loc3_:Frame = ComponentFactory.Instance.creatComponentByStylename("room.crossPve.CrossMatchAlertFrame");
         _loc3_["data"] = _loc4_;
         _loc3_["show"]();
      }
      
      public function get selfPlayerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function requestSpacetimeInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9653);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

