package map.campaign
{
   import battle.BattleManager;
   import com.pickgliss.loader.DomainResourceLoad;
   import com.road.yishi.proto.bloodyrealm.BloodyRealmCampaignInfoMsg;
   import com.road.yishi.proto.campaign.CampaignNodeListMsg;
   import com.road.yishi.proto.campaign.CampaignNodeMsg;
   import com.road.yishi.proto.room.RoomEnterMsg;
   import com.road.yishi.proto.room.RoomPlayerMsg;
   import com.road.yishi.proto.vehicle.PlayerVehicleListMsg;
   import com.road.yishi.proto.vehicle.PlayerVehicleMsg;
   import farm.FarmManager;
   import managers.RoomManager;
   import map.campaign.data.ActiveVehicleModel;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.DeepPrisonModel;
   import map.campaign.data.FantasyMatrixModel;
   import map.campaign.data.MarketModel;
   import map.campaign.data.MineralModel;
   import map.campaign.data.PetBossModel;
   import map.campaign.data.PvpWarFightModel;
   import map.campaign.data.TrialModel;
   import map.campaign.data.skill.MapBuffHurtData;
   import map.campaign.event.CampaignEvent;
   import map.internals.data.ArmyChildrenInfo;
   import map.internals.data.ArmyPetInfo;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicInfo;
   import mvc.module.room.RoomInfo;
   import mvc.module.singlecampaign.SingleCampaignModel;
   import mvc.module.worldboss.WorldBossModel;
   import yishi.GlobalConfig;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.WorldBossHelper;
   import yzhkof.debug.log;
   
   public class CampaignManager
   {
      
      public static const ROOM_STATE:uint = 1;
      
      public static const MAP_STATE:uint = 2;
      
      public static var CampaignOverState:Boolean;
      
      private static var _instance:CampaignManager;
      
      public var exit:Boolean = false;
      
      private var _mapModel:CampaignMapModel;
      
      private var _worldBossModel:WorldBossModel;
      
      private var _pvpWarFightModel:PvpWarFightModel;
      
      private var _trialModel:TrialModel;
      
      private var _mineralModel:MineralModel;
      
      private var _marketModel:MarketModel;
      
      private var _petBossModel:PetBossModel;
      
      private var _activeVehicleModel:ActiveVehicleModel;
      
      private var _fantasyMatrixModel:FantasyMatrixModel;
      
      private var _singleCampaignModel:SingleCampaignModel;
      
      private var _deepPrisonModel:DeepPrisonModel;
      
      public var childWarHasSkillArr:Array;
      
      public var mapId:int = 0;
      
      public var bloodyCurrentWave:int = 0;
      
      public var mapView:*;
      
      public var controller:*;
      
      public function CampaignManager()
      {
         super();
      }
      
      public static function get instance() : CampaignManager
      {
         if(!_instance)
         {
            _instance = new CampaignManager();
         }
         return _instance;
      }
      
      public function get petBossModel() : PetBossModel
      {
         if(_petBossModel == null)
         {
            _petBossModel = new PetBossModel();
         }
         return _petBossModel;
      }
      
      public function get mineralModel() : MineralModel
      {
         return _mineralModel;
      }
      
      public function get marketModel() : MarketModel
      {
         return _marketModel;
      }
      
      public function get trialModel() : TrialModel
      {
         return _trialModel;
      }
      
      public function get worldBossModel() : WorldBossModel
      {
         return _worldBossModel;
      }
      
      public function get mapModel() : CampaignMapModel
      {
         return _mapModel;
      }
      
      public function get pvpWarFightModel() : PvpWarFightModel
      {
         return _pvpWarFightModel;
      }
      
      public function get activeVehicleModel() : ActiveVehicleModel
      {
         return _activeVehicleModel;
      }
      
      public function get fantasyMatrixModel() : FantasyMatrixModel
      {
         return _fantasyMatrixModel;
      }
      
      public function get deepPrisonModel() : DeepPrisonModel
      {
         return _deepPrisonModel;
      }
      
      public function get singleCampaignModel() : SingleCampaignModel
      {
         return _singleCampaignModel;
      }
      
      public function setup(param1:int) : void
      {
         if(mapId == param1 && exit == false)
         {
            return;
         }
         if(_mapModel)
         {
            dispose();
         }
         mapId = param1;
         CampaignOverState = false;
         exit = false;
         _mapModel = new CampaignMapModel();
         _mapModel.mapId = param1;
         _worldBossModel = new WorldBossModel();
         _trialModel = new TrialModel();
         _pvpWarFightModel = new PvpWarFightModel(param1);
         if(WorldBossHelper.checkActiveVehicle(mapId))
         {
            _activeVehicleModel = new ActiveVehicleModel();
         }
         _fantasyMatrixModel = new FantasyMatrixModel();
         if(WorldBossHelper.checkPve())
         {
            _singleCampaignModel = new SingleCampaignModel();
            _singleCampaignModel.mapId = mapId;
         }
         if(WorldBossHelper.checkMineral(mapId))
         {
            _mineralModel = new MineralModel();
         }
         if(WorldBossHelper.checkMarket(mapId))
         {
            _marketModel = new MarketModel();
         }
         if(WorldBossHelper.checkDeepPrison(mapId))
         {
            _deepPrisonModel = new DeepPrisonModel();
         }
         BattleManager.preScene = "CAMPAIGN_MAP_SCENE";
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.listener(21,__campaignStartHandler);
         SocketManager.instance.listener(127,__campaignDataHandler);
         SocketManager.instance.listener(335,bloodyRealmInfoHandle);
         SocketManager.instance.listener(4517,__playersHpHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.unlistener(21,__campaignStartHandler);
         SocketManager.instance.unlistener(127,__campaignDataHandler);
         SocketManager.instance.unlistener(335,bloodyRealmInfoHandle);
         SocketManager.instance.unlistener(4517,__playersHpHandler);
      }
      
      private function bloodyRealmInfoHandle(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BloodyRealmCampaignInfoMsg = new BloodyRealmCampaignInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BloodyRealmCampaignInfoMsg;
         if(bloodyCurrentWave != _loc2_.currentWare)
         {
            NotificationManager.instance.sendNotification("RANDOM_CAMPAIGN_WAVE_CHANGE");
         }
         bloodyCurrentWave = _loc2_.currentWare;
         NotificationManager.instance.sendNotification("RANDOM_CAMPAIGN_UPDATE_TIME");
      }
      
      private function __campaignDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignNodeListMsg = new CampaignNodeListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as CampaignNodeListMsg;
         var _loc4_:Array = [];
         for each(var _loc3_:CampaignNodeMsg in _loc2_.node)
         {
            _loc4_.push(readNodeInfo(_loc3_));
         }
         log({},_loc2_.node.length + "节点数据 size : " + _loc4_.length);
         mapModel.mapNodesData = _loc4_;
      }
      
      private function readNodeInfo(param1:CampaignNodeMsg, param2:Boolean = false) : CampaignNode
      {
         var _loc3_:CampaignNode = null;
         if(param2)
         {
            _loc3_ = mapModel.getMapNodesById(param1.nodeId);
         }
         if(!_loc3_)
         {
            _loc3_ = new CampaignNode();
         }
         var _loc4_:PhysicInfo = new PhysicInfo();
         _loc4_.id = param1.nodeId;
         _loc3_.nodeId = param1.campDataId;
         _loc4_.names = param1.nodeName;
         _loc4_.types = param1.masterType;
         _loc3_.sonType = param1.sonType;
         _loc3_.preNodeIds = param1.preNodeIds;
         _loc3_.nextNodeIds = param1.nextNodeIds;
         _loc4_.state = param1.state;
         _loc4_.posX = param1.posX;
         _loc4_.posY = param1.posY;
         _loc3_.curPosX = param1.curX;
         _loc3_.curPosY = param1.curY;
         _loc4_.grade = param1.level;
         _loc3_.attackTypes = param1.attackTypes;
         _loc3_.nameColor = param1.nameColor;
         _loc3_.toward = param1.toward;
         _loc3_.resource = param1.resource;
         _loc3_.resetPosX = param1.resetX;
         _loc3_.resetPosY = param1.resetY;
         _loc3_.visitUserIds = param1.visitUserIds;
         _loc3_.fixX = param1.fixX;
         _loc3_.fixY = param1.fixY;
         _loc3_.handlerRange = param1.handlerRange;
         _loc3_.heroTemplateId = param1.heroTempId;
         _loc3_.sizeType = param1.sizeType;
         _loc3_.fightCapaity = param1.fightCapaity;
         _loc3_.param1 = param1.param1;
         _loc3_.param2 = param1.param2;
         _loc3_.param3 = param1.param3;
         _loc3_.param4 = param1.param4;
         _loc3_.armyId = param1.armyId;
         if(param1.hasParam5)
         {
            _loc3_.param5 = param1.param5;
         }
         _loc3_.param6 = param1.param6;
         _loc3_.demonLeftCount = param1.currentCount;
         _loc3_.info = _loc4_;
         if(_loc4_.types == 1001 && _loc4_.state == 20)
         {
            FarmManager.instance.model.bigBonFireIsOpen = true;
         }
         return _loc3_;
      }
      
      private function __playersHpHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:CampaignArmy = null;
         var _loc4_:CampaignNode = null;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         var _loc6_:MapBuffHurtData = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerVehicleListMsg = new PlayerVehicleListMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as PlayerVehicleListMsg;
         var _loc9_:CampaignArmy = mapModel.selfMemberData;
         if(WorldBossHelper.checkSteel(mapModel.mapId))
         {
            for each(_loc7_ in _loc2_.vehicles)
            {
               if(!_loc7_.hasPlayerId && _loc7_.hasTemplateId)
               {
                  _loc4_ = mapModel.getMapNodeByNodeId(_loc7_.templateId);
                  if(_loc4_)
                  {
                     _loc4_.totalHp = _loc7_.grade;
                     _loc4_.curHp = _loc7_.hp;
                  }
               }
               else
               {
                  _loc3_ = mapModel.getUserArmyByUserId(_loc7_.playerId,_loc7_.serverName);
                  if(_loc3_)
                  {
                     if(_loc7_.hasTemplateId && _loc7_.hasAppellId)
                     {
                        _loc3_.updateSteelInfo(_loc7_.templateId,_loc7_.appellId);
                     }
                     _loc3_.updateArmyHpInfo(_loc7_.hp,_loc7_.grade);
                  }
               }
            }
         }
         else if(WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            for each(_loc7_ in _loc2_.vehicles)
            {
               if(!_loc7_.hasPlayerId && _loc7_.hasTemplateId)
               {
                  _loc4_ = mapModel.getMapNodeByNodeId(_loc7_.npcNodeId);
                  if(_loc4_)
                  {
                     _loc4_.totalHp = _loc7_.maxHp;
                     _loc4_.curHp = _loc7_.hp;
                     for each(_loc5_ in _loc7_.buffState)
                     {
                        _loc6_ = new MapBuffHurtData();
                        _loc6_.buffId = _loc5_;
                        if(_loc4_.info.types == 99998)
                        {
                           _loc4_.updateBuff(_loc6_);
                        }
                        if(_loc6_.buffTemplate)
                        {
                           log({},_loc6_.buffTemplate.Name);
                        }
                     }
                  }
               }
               else
               {
                  _loc3_ = mapModel.getUserArmyByUserId(_loc7_.playerId,_loc7_.serverName);
                  if(_loc3_)
                  {
                     if(_loc7_.hasTemplateId && _loc7_.hasDefaultSkills)
                     {
                        _loc3_.activeLastTempId = _loc7_.templateId;
                        _loc3_.updateActiveInfo(_loc7_.templateId,_loc7_.defaultSkills);
                     }
                     _loc3_.updateArmyHpInfo(_loc7_.hp,_loc7_.maxHp);
                     _loc3_.updateActiveVehicleHoldKeyState(_loc7_.isHoldKey);
                     for each(_loc5_ in _loc7_.buffState)
                     {
                        _loc6_ = new MapBuffHurtData();
                        _loc6_.buffId = _loc5_;
                        _loc3_.updateBuffActive(_loc6_);
                        if(_loc6_.buffTemplate)
                        {
                           log({},_loc6_.buffTemplate.Name);
                        }
                     }
                     if(_loc7_.hasTeam)
                     {
                        _loc3_.activeTeamId = _loc7_.team;
                     }
                     if(_loc7_.hasX)
                     {
                        _loc3_.curPosX = _loc7_.x;
                     }
                     if(_loc7_.hasY)
                     {
                        _loc3_.curPosY = _loc7_.y;
                     }
                     if(_loc7_.hasHp)
                     {
                        _loc3_.activeCurHp = _loc7_.hp;
                     }
                     if(_loc7_.hasRebornTime)
                     {
                        _loc3_.rebornTime = _loc7_.rebornTime;
                     }
                  }
               }
            }
         }
         else if(WorldBossHelper.checkUnrealShooting(mapModel.mapId))
         {
            for each(_loc7_ in _loc2_.vehicles)
            {
               if(!_loc7_.hasPlayerId && _loc7_.hasTemplateId)
               {
                  _loc4_ = mapModel.getMapNodeByNodeId(_loc7_.templateId);
                  if(_loc4_)
                  {
                     _loc4_.totalHp = _loc7_.maxHp;
                     _loc4_.curHp = _loc7_.hp;
                     for each(_loc5_ in _loc7_.buffState)
                     {
                        _loc6_ = new MapBuffHurtData();
                        _loc6_.buffId = _loc5_;
                        if(_loc4_.info.types == 206)
                        {
                           _loc4_.beHurt(_loc6_);
                        }
                        else
                        {
                           _loc4_.updateBuff(_loc6_);
                        }
                        if(_loc6_.buffTemplate)
                        {
                           log({},_loc6_.buffTemplate.Name);
                        }
                     }
                  }
               }
               else
               {
                  _loc3_ = mapModel.getUserArmyByUserId(_loc7_.playerId,_loc7_.serverName);
                  if(_loc3_)
                  {
                     if(_loc7_.hasTemplateId && _loc7_.hasDefaultSkills)
                     {
                        _loc3_.updateUnrealShootingInfo(_loc7_.templateId,_loc7_.defaultSkills);
                     }
                     _loc3_.updateArmyHpInfo(_loc7_.hp,_loc7_.maxHp);
                     _loc3_.updateUnrealShootingHoldKeyState(_loc7_.isHoldKey);
                     for each(_loc5_ in _loc7_.buffState)
                     {
                        _loc6_ = new MapBuffHurtData();
                        _loc6_.buffId = _loc5_;
                        _loc3_.updateBuffUnrealShooting(_loc6_);
                        if(_loc6_.buffTemplate)
                        {
                           log({},_loc6_.buffTemplate.Name);
                        }
                     }
                  }
               }
            }
         }
         else
         {
            for each(_loc7_ in _loc2_.vehicles)
            {
               if(!_loc7_.hasPlayerId && _loc7_.hasNpcNodeId)
               {
                  _loc4_ = mapModel.getMapNodeByNodeId(_loc7_.npcNodeId);
                  if(_loc4_)
                  {
                     if(_loc4_.param2 == 6)
                     {
                        _loc4_.totalHp = _loc7_.grade;
                        _loc4_.curHp = _loc7_.hp;
                        _loc3_ = mapModel.findArmyInNode(_loc7_.npcNodeId);
                        if(_loc3_)
                        {
                           _loc3_.updateNodeHpInfo(_loc7_.hp,_loc7_.grade);
                        }
                     }
                     else if(_loc4_.param2 == 7)
                     {
                        _loc4_.tempData = _loc7_.vip;
                        _loc4_.totalHp = _loc7_.grade;
                        _loc4_.curHp = _loc7_.hp;
                        if(_loc7_.vip != 0)
                        {
                           if(_loc9_ && _loc9_.mountNodeId == _loc7_.npcNodeId)
                           {
                              _loc9_.updateNodeHpInfo(_loc7_.hp,_loc7_.grade);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc3_ = mapModel.getUserArmyByUserId(_loc7_.playerId,_loc7_.serverName);
                  if(_loc3_)
                  {
                     _loc3_.updateArmyHpInfo(_loc7_.hp,_loc7_.grade);
                  }
               }
            }
         }
      }
      
      private function __campaignStartHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomEnterMsg = new RoomEnterMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RoomEnterMsg;
         if(_loc2_.result <= 0)
         {
            return;
         }
         for each(var _loc3_:RoomPlayerMsg in _loc2_.player)
         {
            readMember(_loc3_);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function readMember(param1:RoomPlayerMsg) : void
      {
         var _loc13_:CampaignArmy = null;
         var _loc4_:ThaneInfo = null;
         var _loc11_:ArmyPetInfo = null;
         var _loc6_:ArmyChildrenInfo = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc17_:int = 0;
         var _loc5_:Array = null;
         var _loc14_:* = null;
         var _loc15_:Array = null;
         var _loc7_:int = param1.playerId;
         var _loc3_:String = param1.hasServerName ? param1.serverName : "";
         if(roomInfo)
         {
            roomInfo.id = param1.roomId;
            roomInfo.curCount = param1.count;
            _loc13_ = roomInfo.getPlayerByUserId(_loc7_,_loc3_);
         }
         var _loc12_:int = param1.currentRoomIndex;
         var _loc2_:int = param1.playerState;
         var _loc16_:int = param1.heroId;
         if(!_loc13_)
         {
            _loc13_ = new CampaignArmy();
            _loc4_ = new ThaneInfo();
         }
         else
         {
            _loc4_ = _loc13_.baseHero;
         }
         _loc11_ = _loc13_.petInfo;
         _loc6_ = _loc13_.childrenInfo;
         _loc4_.beginChanges();
         _loc13_.isNoGet = param1.isNoGet;
         if(PlayerManager.instance.currentPlayerModel.userInfo.userId == param1.playerId)
         {
            GlobalConfig.isGet = !param1.isNoGet;
         }
         _loc13_.pos = _loc12_;
         _loc13_.roomState = _loc2_;
         _loc4_.id = _loc16_;
         _loc13_.userId = _loc7_;
         _loc4_.uuid = param1.playerUuid;
         _loc4_.userId = _loc7_;
         _loc4_.IsVipAndNoExpirt = param1.isVip;
         _loc4_.vipType = param1.vipType;
         _loc4_.grades = param1.grades;
         _loc13_.nickName = param1.nickName;
         _loc13_.setTranseferWait(false,0,0);
         _loc4_.nickName = _loc13_.nickName;
         _loc4_.templateId = param1.templateId;
         _loc4_.headId = param1.headId;
         _loc4_.armsEquipAvata = param1.arm;
         _loc4_.bodyEquipAvata = param1.cloth;
         param1.hasWing && (_loc4_.wingAvata = param1.wing);
         _loc4_.hairFashionAvata = param1.hat;
         _loc4_.armsFashionAvata = param1.fashionArm;
         _loc4_.bodyFashionAvata = param1.fashionCloth;
         _loc4_.hideFashion = param1.hide;
         _loc4_.changeShapeId = param1.changeShapeId;
         _loc4_.fightingCapacity = param1.fightingCapacity;
         _loc4_.honer = param1.geste;
         _loc4_.headId = param1.headId;
         _loc4_.fateSkill = param1.fateSkills;
         if(param1.hasDragonGrade)
         {
            _loc5_ = param1.dragonGrade.split("|");
            for each(_loc14_ in _loc5_)
            {
               _loc15_ = _loc14_.split(",");
               if(int(_loc15_[0]) > _loc8_)
               {
                  _loc8_ = int(_loc15_[0]);
                  _loc9_ = int(_loc15_[1]);
                  _loc17_ = int(_loc15_[2]);
               }
            }
            _loc4_.dragonSoulType = _loc8_;
            _loc4_.dragonSoulGrade = _loc9_;
            _loc4_.dragonSoulGp = _loc17_;
         }
         if(param1.hasTransferGrade)
         {
            _loc4_.vocationGrades = param1.transferGrade;
         }
         if(param1.hasChangeBranch)
         {
            _loc4_.vocationIndex = param1.changeBranch;
         }
         if(param1.hasIsBackPlayer)
         {
            _loc4_.isBackPlayer = param1.isBackPlayer;
         }
         _loc13_.id = param1.armyId;
         _loc13_.combatPower = param1.fightingCapacity;
         _loc13_.curPosX = param1.curPosX;
         _loc13_.curPosY = param1.curPosY;
         _loc13_.state = param1.armyState;
         _loc13_.teamId = param1.teamId;
         _loc13_.bufferTempId = param1.bufferTempId;
         _loc4_.appellId = param1.appellid;
         _loc4_.avengerGrade = param1.avengerGrade;
         if(param1.hasServerName)
         {
            _loc4_.serviceName = param1.serverName;
         }
         if(param1.hasMountTempId)
         {
            _loc13_.mountTemplateId = param1.mountTempId;
         }
         param1.hasMountGrade && (_loc13_.mountGrade = param1.mountGrade);
         if(param1.hasPetName)
         {
            _loc11_.petName = param1.petName;
            _loc4_.petName = param1.petName;
         }
         if(param1.hasPetQuqlity)
         {
            if(param1.petQuqlity < 26)
            {
               _loc11_.petQuaity = (param1.petQuqlity - 1) / 5 + 1;
               _loc4_.petQuaity = (param1.petQuqlity - 1) / 5 + 1;
            }
            else
            {
               _loc11_.petQuaity = (param1.petQuqlity - 1) / 5;
               _loc4_.petQuaity = (param1.petQuqlity - 1) / 5;
            }
            _loc11_.petTemQuality = param1.petQuqlity;
            _loc4_.temQuality = param1.petQuqlity;
         }
         if(param1.hasPetTemplateId)
         {
            _loc11_.petTemplateId = param1.petTemplateId;
            _loc4_.petTemplateId = param1.petTemplateId;
         }
         if(param1.hasChildName)
         {
            _loc6_.childrenName = param1.childName;
            _loc4_.childrenName = param1.childName;
         }
         if(param1.hasChildJob)
         {
            _loc6_.childrenJob = param1.childJob;
            _loc4_.childrenJob = param1.childJob;
         }
         if(param1.hasChildSex)
         {
            _loc6_.childrenSex = param1.childSex;
            _loc4_.childrenSex = param1.childSex;
         }
         if(param1.hasGrowthGrade)
         {
            _loc6_.childrenGrade = param1.growthGrade;
            _loc4_.childrenGrade = param1.growthGrade;
         }
         if(param1.hasGrowthGrade2)
         {
            _loc6_.growthGrade2 = param1.growthGrade2;
            _loc4_.growthGrade2 = param1.growthGrade2;
         }
         if(param1.hasChildFightcap)
         {
            _loc13_.childrenInfo.childrenFightPower = param1.childFightcap;
            _loc4_.childrenFightPower = param1.childFightcap;
         }
         if(param1.hasMonsterId)
         {
            _loc13_.monsterInfo.monsterTemplateId = param1.monsterId;
            _loc4_.monsterTempteId = param1.monsterId;
         }
         if(param1.hasHide)
         {
            _loc4_.hideFashion = param1.hide;
         }
         if(param1.hasFashionArm)
         {
            _loc4_.armsFashionAvata = param1.fashionArm;
         }
         if(param1.hasFashionCloth)
         {
            _loc4_.bodyFashionAvata = param1.fashionCloth;
         }
         if(param1.hasHat)
         {
            _loc4_.hairFashionAvata = param1.hat;
         }
         var _loc10_:Boolean = false;
         if(_loc13_.mapId > 0 && _loc13_.mapId != param1.campaignId)
         {
            _loc10_ = true;
         }
         _loc13_.mapId = param1.campaignId;
         _loc13_.online = param1.onlineState;
         _loc4_.state = param1.onlineState ? 7 : 0;
         _loc4_.consortiaID = param1.consortiaId;
         _loc4_.consortiaName = param1.consortiaName;
         _loc13_.baseHero = _loc4_;
         if(roomInfo)
         {
            roomInfo.addArmy(_loc13_,false);
         }
         mapModel.addUserArmy(_loc13_,_loc10_);
         _loc4_.commit();
         _loc11_.commit();
         _loc6_.commit();
         _loc13_.commit();
      }
      
      public function dispose() : void
      {
         removeEvent();
         mapId = 0;
         NotificationManager.instance.dispatchEvent(new CampaignEvent("CAMPAIGN_OVER",null));
         CampaignOverState = false;
         BattleModel.allowAutoFight = true;
         CampaignMapModel.inMazeFlag = false;
         CampaignMapModel.isHangUp = false;
         if(mapView && mapView.hasOwnProperty("dispose"))
         {
            mapView.dispose();
         }
         exit = true;
         PlayerManager.instance.loginState = 0;
         BattleManager.preScene = SwitchPageHelp.returnScene;
         if(_mapModel)
         {
            _mapModel.exit = true;
         }
         _mapModel = null;
         _worldBossModel = null;
         _mineralModel = null;
         _marketModel = null;
         _trialModel = null;
         _activeVehicleModel = null;
         _fantasyMatrixModel = null;
         _singleCampaignModel = null;
         mapView = null;
         DomainResourceLoad.loaderContext = null;
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
   }
}

