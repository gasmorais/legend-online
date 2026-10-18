package map.space
{
   import com.road.yishi.proto.campaign.HangupAttackMsg;
   import com.road.yishi.proto.campaign.SpacePlayerMoveMsg;
   import com.road.yishi.proto.campaign.SpacePlayerMsg;
   import com.road.yishi.proto.room.RoomEnterMsg;
   import com.road.yishi.proto.room.RoomPlayerMsg;
   import managers.ChildManager;
   import managers.EclipticPalaceManager;
   import map.internals.data.PhysicInfo;
   import map.internals.data.SpaceNode;
   import map.space.data.SpaceArmy;
   import map.space.event.SpaceEvent;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SpaceMapNodeInfoTemplate;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   
   public class SpaceManager
   {
      
      private static var _instance:SpaceManager;
      
      private var _model:SpaceModel;
      
      private var _controller:*;
      
      private var _mapView:*;
      
      public var mapId:int = 0;
      
      private var _exit:Boolean = false;
      
      public var serchId:int;
      
      private var _isPopFrame:Boolean = true;
      
      private var _callback:Function = null;
      
      public function SpaceManager()
      {
         super();
      }
      
      public static function get instance() : SpaceManager
      {
         if(!_instance)
         {
            _instance = new SpaceManager();
         }
         return _instance;
      }
      
      public function get exit() : Boolean
      {
         return _exit;
      }
      
      public function set exit(param1:Boolean) : void
      {
         _exit = param1;
      }
      
      public function visitSpaceNPC(param1:int, param2:Boolean = true, param3:Function = null) : void
      {
         _isPopFrame = param2;
         _callback = param3;
         PlayerManager.instance.currentPlayerModel.spaceNodeId = param1;
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            NotificationManager.instance.dispatchEvent(new SpaceEvent("FIND_NODE",null));
         }
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function get isPopFrame() : Boolean
      {
         return _isPopFrame;
      }
      
      public function setup(param1:int) : void
      {
         if(mapId == param1 && exit == false)
         {
            return;
         }
         mapId = param1;
         exit = false;
         _model = new SpaceModel();
         _model.mapId = mapId;
         addEvent();
      }
      
      public function stop() : void
      {
         if(_mapView && _mapView.walkLayer)
         {
            _mapView.walkLayer.stop();
         }
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4597,__initPlayerListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4607,__removePlayerListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4421,__onPKRequestHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4597,__initPlayerListHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4607,__removePlayerListHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4421,__onPKRequestHandler);
      }
      
      private function __initPlayerListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomEnterMsg = new RoomEnterMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RoomEnterMsg;
         for each(_loc4_ in _loc2_.player)
         {
            readMember(_loc4_);
         }
      }
      
      private function __removePlayerListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SpacePlayerMoveMsg = new SpacePlayerMoveMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SpacePlayerMoveMsg;
         for each(var _loc3_:SpacePlayerMsg in _loc2_.players)
         {
            if(_loc3_.playerId != selfPlayerInfo.userId && SpaceManager.instance.model)
            {
               SpaceManager.instance.model.removeUserArmyByArmyId(_loc3_.playerId);
            }
         }
      }
      
      private function __onPKRequestHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HangupAttackMsg = new HangupAttackMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HangupAttackMsg;
         if(ChildManager.instance.arenaModel.isInChildArena)
         {
            return;
         }
         if(EclipticPalaceManager.instance.model.openEclipticPalaceFrame)
         {
            return;
         }
         if(FrameControllerManager.instance.dreamArenaController.dreamArenaMatching)
         {
            return;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SPACE_PK",_loc2_));
      }
      
      public function get selfPlayerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function readMember(param1:RoomPlayerMsg) : void
      {
         var _loc7_:ThaneInfo = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc11_:int = 0;
         var _loc9_:Array = null;
         var _loc5_:* = null;
         var _loc6_:Array = null;
         var _loc8_:int = param1.heroId;
         var _loc10_:int = param1.playerId;
         var _loc4_:SpaceArmy = SpaceManager.instance.model.getUserArmyByUserId(_loc10_);
         if(_loc4_ == null)
         {
            _loc4_ = new SpaceArmy();
         }
         if(_loc10_ == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            _loc7_ = thane;
            _loc4_.baseHero = _loc7_;
         }
         else
         {
            _loc7_ = _loc4_.baseHero;
         }
         _loc7_.beginChanges();
         _loc7_.id = _loc8_;
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
         _loc7_.fateSkill = param1.fateSkills;
         _loc7_.avengerGrade = param1.avengerGrade;
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
         if(param1.hasChangeBranch)
         {
            _loc7_.vocationIndex = param1.changeBranch;
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
         _loc4_.userId = _loc10_ == 0 ? param1.armyId : _loc10_;
         _loc4_.id = param1.armyId;
         _loc4_.nickName = param1.nickName;
         _loc4_.curPosX = param1.curPosX;
         _loc4_.curPosY = param1.curPosY;
         _loc4_.mapId = param1.campaignId;
         _loc4_.state = param1.armyState;
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
            _loc4_.petInfo.petTemplateId = param1.petTemplateId;
            _loc7_.petTemplateId = param1.petTemplateId;
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
            _loc4_.childrenInfo.growthGrade2 = param1.growthGrade2;
            _loc7_.childrenGrade = param1.growthGrade;
            _loc7_.growthGrade2 = param1.growthGrade2;
         }
         if(param1.hasMonsterId)
         {
            _loc4_.monsterInfo.monsterTemplateId = param1.monsterId;
            _loc7_.monsterTempteId = param1.monsterId;
         }
         _loc7_.consortiaID = param1.consortiaId;
         _loc7_.consortiaName = param1.consortiaName;
         _loc7_.commit();
         _loc4_.commit();
         _loc4_.petInfo.commit();
         SpaceManager.instance.model.addUserArmy(_loc4_);
      }
      
      public function readSpaceNodeInfo(param1:SpaceMapNodeInfoTemplate) : SpaceNode
      {
         var _loc3_:SpaceNode = new SpaceNode();
         var _loc4_:PhysicInfo = new PhysicInfo();
         var _loc2_:Array = param1.NodeName.split(",");
         _loc4_.id = param1.Id;
         _loc4_.mapId = param1.MapId;
         _loc4_.posX = param1.PosX;
         _loc4_.posY = param1.PosY;
         _loc4_.names = _loc2_[0];
         _loc4_.types = param1.MasterType;
         _loc4_.state = 1;
         _loc3_.nodeId = param1.Id;
         _loc3_.sonType = param1.SonType;
         _loc3_.npcId = param1.NPCId;
         _loc3_.curPosX = param1.PosX;
         _loc3_.curPosY = param1.PosY;
         _loc3_.resetPosX = param1.BackPosX;
         _loc3_.resetPosY = param1.BackPosY;
         _loc3_.fixX = param1.FixX;
         _loc3_.fixY = param1.FixY;
         _loc3_.moveToMapId = param1.MoveToMapId;
         _loc3_.moveToNodeId = param1.MoveToNodeId;
         _loc3_.patrolPos = param1.PatrolPos;
         _loc3_.nameColor = param1.NameColor;
         _loc3_.sizeType = param1.SizeType;
         _loc3_.toward = param1.Toward;
         _loc3_.resource = param1.Resource;
         _loc3_.handlerRange = param1.HandlerRange;
         _loc3_.dialogue = param1.Dialogue;
         _loc3_.param1 = param1.Param1;
         _loc3_.param2 = param1.Param2;
         _loc3_.param3 = param1.Param3;
         _loc3_.param4 = param1.Param4;
         _loc3_.param5 = param1.Param5;
         _loc3_.ItemExchange = param1.ItemExchange;
         if(param1.Sort != 0)
         {
            _loc3_.sort = param1.Sort;
         }
         else
         {
            _loc3_.sort = param1.Id;
         }
         if(_loc2_[1])
         {
            _loc3_.funcType = _loc2_[1];
         }
         else
         {
            _loc3_.funcType = "";
         }
         _loc3_.info = _loc4_;
         return _loc3_;
      }
      
      public function get model() : SpaceModel
      {
         return _model;
      }
      
      public function get controller() : *
      {
         return _controller;
      }
      
      public function set controller(param1:*) : void
      {
         _controller = param1;
      }
      
      public function get mapView() : *
      {
         return _mapView;
      }
      
      public function set mapView(param1:*) : void
      {
         _mapView = param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_model)
         {
            _model.dispose();
         }
         _model = null;
         exit = true;
      }
   }
}

