package map.campaign.data
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.army.ArmyPosUpdatedMsg;
   import com.road.yishi.proto.campaign.CampaignTakeCardsMsg;
   import com.road.yishi.proto.campaign.StandPosMsg;
   import com.road.yishi.proto.vehicle.VehicleMoveMsg;
   import com.road.yishi.proto.worldmap.PosMoveListMsg;
   import com.road.yishi.proto.worldmap.PosMoveMsg;
   import com.road.yishi.proto.worldmap.SynPlayerViewMsg;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.event.CampaignEvent;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.CampaignNode;
   import map.internals.data.ChestInfo;
   import map.internals.data.FloorMapInfo;
   import map.internals.data.MapPhysics;
   import map.internals.data.RandomBossBuffefMsgInfo;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.AStarPathFinder;
   import map.internals.utils.MapDataUtils;
   import map.internals.utils.Utils;
   import mvc.module.armyII.BaseArmy;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   import yzhkof.debug.log;
   
   public class CampaignMapModel extends FloorMapInfo
   {
      
      public static var isHangUp:Boolean;
      
      public static var inMazeFlag:Boolean;
      
      private static const fogUnitWidth:int = 110;
      
      private static const fogUnitHeight:int = 86;
      
      public var bgLayer:Object;
      
      public var createType:int;
      
      public var isCross:Boolean = false;
      
      public var steelMapIsChanged:Boolean = true;
      
      public var randomBossBuffefMsgInfo:RandomBossBuffefMsgInfo = new RandomBossBuffefMsgInfo();
      
      public var isFirstLoginCampaign:Boolean = true;
      
      private var _currentDieNodeId:int;
      
      private var _mapNodesData:Array;
      
      private var _curSysArmy:BaseArmy;
      
      private var _sysArmyList:Dictionary = new Dictionary(true);
      
      private var _userArmyList:Dictionary = new Dictionary(true);
      
      public var effectLock:Boolean = false;
      
      public var allSystemHeros:Array;
      
      public var allSystemPawns:Array;
      
      private var _leftFightTime:int;
      
      private var _attackBoss:ThaneInfo;
      
      private var _attackBossTeamList:Dictionary;
      
      public var hookleftWeay:int;
      
      private var _selectNode:CampaignNode;
      
      public var rollInfos:Array;
      
      public var bloodyRollInfos:Array;
      
      public var staticMovies:Array = [];
      
      private var _syncErrorTime:int;
      
      public var onCollectionId:int;
      
      private var _endTime:Date;
      
      private var _fogData:Array;
      
      private var _noteFogArr:Array = [];
      
      private var _selfMemberData:CampaignArmy;
      
      private var _checkTempPoint:Point = new Point();
      
      private var _checkNodePoint:Point = new Point();
      
      private var _smallMapIcon:String;
      
      private var _hideOtherPlayer:Boolean;
      
      public function CampaignMapModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      override public function set currentFloorData(param1:Array) : void
      {
         var _loc2_:Array = null;
         var _loc5_:Array = null;
         var _loc8_:* = null;
         var _loc7_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc6_:Point = null;
         switch(mapId)
         {
            case 10001:
            case 10002:
            case 10003:
            case 10004:
            case 10005:
            case 20001:
            case 20002:
            case 20003:
               if(mapTempInfo.Width > 5000 || mapTempInfo.Height > 5000)
               {
                  this.dispatchEvent(new OuterCityEvent("commitLoading",null));
               }
               _loc2_ = [];
               _loc5_ = [];
               for each(_loc8_ in moviesData)
               {
                  _loc2_ = _loc2_.concat(_loc8_);
               }
               for each(_loc8_ in topsData)
               {
                  _loc5_ = _loc5_.concat(_loc8_);
               }
               this.dispatchEvent(new OuterCityEvent("currentConfigChange",{
                  "movies":_loc2_,
                  "tops":_loc5_
               }));
               break;
            default:
               if(mapTempInfo.Width > 5000 || mapTempInfo.Height > 5000)
               {
                  super.currentFloorData = param1;
               }
               else
               {
                  for(var _loc9_:String in floorData)
                  {
                     _loc7_ = floorData[_loc9_] as Array;
                     _loc3_ = moviesData ? moviesData[_loc9_] as Array : [];
                     _loc4_ = topsData ? topsData[_loc9_] as Array : [];
                     _loc6_ = MapDataUtils.getStartPoint(_loc9_);
                     this.dispatchEvent(new OuterCityEvent("currentConfigChange",{
                        "floor":_loc7_,
                        "movies":_loc3_,
                        "tops":_loc4_,
                        "id":_loc9_,
                        "start":_loc6_
                     }));
                  }
               }
         }
      }
      
      override protected function sloveRectData(param1:String) : Object
      {
         var _loc3_:Point = Utils.getStartPoint(param1);
         var _loc4_:String = _loc3_.x + "," + _loc3_.y;
         var _loc2_:Object = {};
         _loc2_["floor"] = floorData[param1];
         if(topsData)
         {
            _loc2_["tops"] = topsData[_loc4_];
         }
         if(moviesData)
         {
            _loc2_["movies"] = moviesData[_loc4_];
         }
         return _loc2_;
      }
      
      public function get selectNode() : CampaignNode
      {
         return _selectNode;
      }
      
      public function set selectNode(param1:CampaignNode) : void
      {
         if(_selectNode == param1)
         {
            return;
         }
         _selectNode = param1;
         dispatchEvent(new CampaignEvent("SELECT_ITEM",param1));
      }
      
      public function get endTime() : Date
      {
         return _endTime;
      }
      
      public function set syncEndTime(param1:Date) : void
      {
         _endTime = param1;
      }
      
      public function get syncErrorTime() : int
      {
         return _syncErrorTime;
      }
      
      public function set syncErrorTime(param1:int) : void
      {
         _syncErrorTime = param1;
         this.dispatchEvent(new CampaignMapEvent("syncErrorTime",param1));
      }
      
      public function showOpenTimeMv() : void
      {
         this.dispatchEvent(new CampaignMapEvent("opentimemv",null));
      }
      
      public function attackBossTeam(param1:Dictionary, param2:int, param3:ThaneInfo) : void
      {
         _attackBossTeamList = param1;
         _leftFightTime = param2;
         _attackBoss = param3;
         this.dispatchEvent(new CampaignMapEvent("ATTACK_BOSS_TEMA",{
            "team":param1,
            "time":param2,
            "boss":param3
         }));
      }
      
      public function inviteAttackBoos(param1:String, param2:ThaneInfo, param3:int, param4:Point) : void
      {
         this.dispatchEvent(new CampaignMapEvent("ATTACK_BOSS_INVITE",{
            "inviteName":param1,
            "time":param3,
            "boss":param2,
            "pos":param4
         }));
      }
      
      public function addTempChestNode(param1:CampaignNode) : void
      {
         _mapNodesData.unshift(param1);
      }
      
      public function get campaignTemplate() : CampaignTemplate
      {
         var _loc1_:CampaignTemplate = TempleteManager.instance.campaignTemplateDic[mapTempInfo.CampaignId];
         if(!_loc1_)
         {
            _loc1_ = TempleteManager.instance.worldBossTemplateDict[mapTempInfo.CampaignId];
         }
         if(!_loc1_)
         {
            _loc1_ = TempleteManager.instance.pvpWarFightDic[mapTempInfo.CampaignId];
         }
         if(!_loc1_ && WorldBossHelper.checkActiveVehicle(mapTempInfo.CampaignId))
         {
            _loc1_ = TempleteManager.instance.vehicleCampaignDic[mapTempInfo.CampaignId];
         }
         return _loc1_;
      }
      
      override public function set mapId(param1:int) : void
      {
         super.mapId = param1;
      }
      
      public function get fogData() : Array
      {
         return _fogData;
      }
      
      override public function aStarPathFinder(param1:Point, param2:Point, param3:int = 25) : Array
      {
         var _loc6_:Point = new Point(int(param1.x / 20),int(param1.y / 20));
         var _loc4_:Point = new Point(int(param2.x / 20),int(param2.y / 20));
         var _loc5_:AStarPathFinder = new AStarPathFinder(mapTielsData);
         return _loc5_.find(_loc6_,_loc4_);
      }
      
      public function set fogData(param1:Array) : void
      {
         if(_fogData)
         {
            sysFogNote(param1);
            sysFogData(param1);
         }
         else
         {
            _fogData = param1;
         }
         this.dispatchEvent(new CampaignMapEvent("SYS_FOG_DATA",_fogData));
      }
      
      private function sysFogData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_];
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(_loc2_[_loc4_] > 0)
               {
                  _fogData[_loc3_][_loc4_] = _loc2_[_loc4_];
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      private function sysFogNote(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Object = null;
         _loc3_ = _noteFogArr.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = _noteFogArr[_loc3_];
            if(param1[_loc2_.x][_loc2_.y] == 1)
            {
               _noteFogArr.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      public function updateFog(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Point = null;
         if(WorldBossHelper.checkFogMap(mapId))
         {
            return;
         }
         _loc4_ = new Point(param1 + 55,param2 + 43);
         var _loc7_:int = _loc4_.y % 86;
         var _loc5_:int = (_loc4_.y - _loc7_) / 86 % 2;
         if(_loc5_ != 0)
         {
            _loc4_.x -= 110 / 2;
         }
         _loc4_.y -= _loc7_;
         var _loc6_:int = _loc4_.x % 110;
         _loc4_.x -= _loc6_;
         if(updateFogData(_loc4_.x,_loc4_.y,param3))
         {
            this.dispatchEvent(new CampaignMapEvent("LOCAL_UPDATE_FOG",{
               "x":_loc4_.x,
               "y":_loc4_.y,
               "vy":_loc5_,
               "type":param3
            }));
         }
      }
      
      private function get FogView() : *
      {
         return ModuleLoader.getDefinition("map.campaign.view.fog.FogView");
      }
      
      private function updateFogData(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc6_:Boolean = false;
         var _loc4_:int = param1 / 110;
         var _loc5_:int = param2 / 86;
         if(!_fogData)
         {
            return _loc6_;
         }
         if(_loc5_ < _fogData.length && _loc5_ >= 0)
         {
            if(_loc4_ < _fogData[_loc5_].length && _loc4_ >= 0)
            {
               if(_fogData[_loc5_][_loc4_] < param3)
               {
                  _loc6_ = true;
                  _fogData[_loc5_][_loc4_] = param3;
                  noteFog(_loc5_,_loc4_,param3);
               }
            }
         }
         return _loc6_;
      }
      
      public function checkFog(param1:int, param2:int) : Boolean
      {
         var _loc3_:Point = FogView.sloveFogPoint(param1,param2);
         param1 = _loc3_.x;
         param2 = _loc3_.y;
         var _loc4_:int = param1 / 110;
         var _loc5_:int = param2 / 86;
         if(!_fogData)
         {
            return false;
         }
         if(_loc5_ < _fogData.length && _loc5_ >= 0)
         {
            if(_loc4_ < _fogData[_loc5_].length && _loc4_ >= 0)
            {
               return _fogData[_loc5_][_loc4_] > 0;
            }
         }
         return false;
      }
      
      private function noteFog(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = Math.ceil(mapTempInfo.Width / 110);
         var _loc5_:int = param1 * _loc4_ + param2;
         _noteFogArr.push({
            "index":_loc5_,
            "value":param3
         });
         if(_noteFogArr.length >= 3)
         {
            CampaignSocketOutManager.instance.sendUpdateFogData(_noteFogArr,mapId);
            _noteFogArr.splice(0,_noteFogArr.length);
         }
      }
      
      public function syscFogNode(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = Math.floor(param1 / param3);
         var _loc5_:int = param1 % param3;
         if(!_fogData || _fogData[_loc4_] == null || _fogData[_loc4_][_loc5_] == null)
         {
            return;
         }
         var _loc6_:int = int(_fogData[_loc4_][_loc5_]);
         _fogData[_loc4_][_loc5_] = param2 > _loc6_ ? param2 : _loc6_;
         filterFogNote(param1,param2);
         var _loc7_:int = _loc5_ / 86 % 2;
         this.dispatchEvent(new CampaignMapEvent("SYN_FOG_DATA",{
            "x":_loc4_,
            "y":_loc5_,
            "vy":_loc7_,
            "type":param2
         }));
      }
      
      private function filterFogNote(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Object = null;
         if(!_noteFogArr)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _noteFogArr.length)
         {
            _loc3_ = _noteFogArr[_loc4_];
            if(param1 == _loc3_.index)
            {
               if(param2 >= _loc3_.byte)
               {
                  _noteFogArr.splice(_loc4_,1);
               }
            }
            _loc4_++;
         }
      }
      
      public function get currentDieNodeId() : int
      {
         return _currentDieNodeId;
      }
      
      public function set currentDieNodeId(param1:int) : void
      {
         _currentDieNodeId = param1;
         this.dispatchEvent(new CampaignMapEvent("NEXT_NODE_GUIDE_TIME",param1));
      }
      
      public function moveToVisible(param1:CampaignArmy) : void
      {
         dispatchEvent(new CampaignMapEvent("MOVE_TO_VISIBLE",param1));
      }
      
      public function moveToUnVisible(param1:CampaignArmy) : void
      {
         dispatchEvent(new CampaignMapEvent("MOVE_TO_UNVISIBLE",param1));
      }
      
      public function addSysArmy(param1:BaseArmy) : void
      {
         var _loc2_:String = null;
         if(isCross && param1.baseHero)
         {
            _loc2_ = param1.baseHero.serviceName + "_" + param1.id;
         }
         else
         {
            _loc2_ = "_" + param1.id;
         }
         _sysArmyList[_loc2_] = param1;
         this.dispatchEvent(new CampaignEvent("GET_SYS_ARMY_INFO",param1));
      }
      
      public function getSysArmyByArmyId(param1:int, param2:String = "") : CampaignArmy
      {
         if(!isCross || param2 == null)
         {
            param2 = "";
         }
         return _sysArmyList[param2 + "_" + param1] as CampaignArmy;
      }
      
      public function addUserArmy(param1:CampaignArmy, param2:Boolean = false) : void
      {
         var _loc3_:String = null;
         if(isCross && param1.baseHero)
         {
            _loc3_ = param1.baseHero.serviceName + "_" + param1.id;
         }
         else
         {
            _loc3_ = "_" + param1.id;
         }
         if(isSelfArmy(param1))
         {
            _selfMemberData = param1;
         }
         if(param2)
         {
            param1.angle = -1;
         }
         if(!_userArmyList[_loc3_])
         {
            _userArmyList[_loc3_] = param1;
            this.dispatchEvent(new OuterCityEvent("addGarrison",param1));
            if(isCross)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("CROSS_ADD_GOONBTN"));
            }
            return;
         }
         _userArmyList[_loc3_] = param1;
         if(param2)
         {
            this.dispatchEvent(new OuterCityEvent("addGarrison",param1,true));
         }
      }
      
      public function reset() : void
      {
         for(var _loc1_:String in _userArmyList)
         {
            delete _userArmyList[_loc1_];
         }
         _selfMemberData = null;
         if(_mapNodesData)
         {
            _mapNodesData.splice(0,_mapNodesData.length);
         }
         if(_fogData)
         {
            _fogData.splice(0,_fogData.length);
         }
      }
      
      public function isSelfArmy(param1:CampaignArmy) : Boolean
      {
         var _loc3_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         var _loc2_:String = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         if(isCross)
         {
            return param1.userId == _loc3_ && param1.baseHero.serviceName == _loc2_;
         }
         return param1.userId == _loc3_;
      }
      
      public function get selfMemberData() : CampaignArmy
      {
         return _selfMemberData;
      }
      
      public function removeUserArmyByArmyId(param1:int, param2:String = "") : CampaignArmy
      {
         if(!isCross || param2 == null)
         {
            param2 = "";
         }
         var _loc3_:CampaignArmy = _userArmyList[param2 + "_" + param1] as CampaignArmy;
         if(_loc3_)
         {
            if(isSelfArmy(_loc3_))
            {
               _selfMemberData = null;
            }
            delete _userArmyList[param2 + "_" + param1];
            if(PlayerManager.instance.currentPlayerModel.selectTarget == _loc3_)
            {
               PlayerManager.instance.currentPlayerModel.selectTarget = null;
            }
            this.dispatchEvent(new OuterCityEvent("REMOVE_ARMY",_loc3_));
            if(isCross)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("CROSS_ADD_GOONBTN"));
            }
         }
         return _loc3_;
      }
      
      public function get allUserArmy() : Dictionary
      {
         return _userArmyList;
      }
      
      public function getUserArmyByArmyId(param1:int, param2:String = "") : CampaignArmy
      {
         if(!isCross || param2 == null)
         {
            param2 = "";
         }
         return _userArmyList[param2 + "_" + param1] as CampaignArmy;
      }
      
      public function getUserArmyByUserId(param1:int, param2:String = "") : CampaignArmy
      {
         if(!isCross || param2 == null)
         {
            param2 = "";
         }
         for each(var _loc3_:CampaignArmy in _userArmyList)
         {
            if(_loc3_.userId == param1)
            {
               if(!param2)
               {
                  return _loc3_;
               }
               if(_loc3_.baseHero.serviceName == param2)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function get mapNodesData() : Array
      {
         return _mapNodesData;
      }
      
      public function addNode(param1:CampaignNode) : void
      {
         if(_mapNodesData.indexOf(param1) < 0)
         {
            _mapNodesData.push(param1);
         }
         this.dispatchEvent(new OuterCityEvent("currentNpcPos",_mapNodesData));
      }
      
      public function removeNode(param1:CampaignNode) : void
      {
         var _loc3_:int = 0;
         var _loc2_:CampaignNode = null;
         _loc3_ = 0;
         while(_loc3_ < _mapNodesData.length)
         {
            _loc2_ = _mapNodesData[_loc3_];
            if(_loc2_.info.id == param1.info.id)
            {
               _mapNodesData.splice(_loc3_,1);
            }
            _loc3_++;
         }
         this.dispatchEvent(new OuterCityEvent("REMOVE_NODE",param1));
      }
      
      public function set mapNodesData(param1:Array) : void
      {
         _mapNodesData = param1;
         this.dispatchEvent(new OuterCityEvent("currentNpcPos",param1));
      }
      
      public function set addNodes(param1:Array) : void
      {
         if(!_mapNodesData)
         {
            _mapNodesData = [];
         }
         mapNodesData = _mapNodesData.concat(param1);
         this.dispatchEvent(new OuterCityEvent("currentNpcPos",_mapNodesData));
      }
      
      public function get mapNodeStartPoint() : CampaignNode
      {
         var _loc2_:CampaignNode = null;
         var _loc4_:CampaignArmy = selfMemberData;
         for each(var _loc1_:CampaignNode in _mapNodesData)
         {
            if(_loc1_.info.types == 40)
            {
               if(!(WorldBossHelper.checkPvp(mapId) || WorldBossHelper.checkDuskArea(mapId) || WorldBossHelper.checkIceFireTemple(mapId) || WorldBossHelper.checkFlameTemple(mapId) || WorldBossHelper.checkSvs(mapId)))
               {
                  return _loc1_;
               }
               if(_loc4_ && _loc1_.param1 == _loc4_.teamId)
               {
                  return _loc1_;
               }
            }
         }
         var _loc3_:int = 9999999;
         for each(_loc1_ in _mapNodesData)
         {
            if(_loc1_.info.id < _loc3_ && _loc1_.followTarget == 0)
            {
               _loc3_ = _loc1_.info.id;
               _loc2_ = _loc1_;
            }
         }
         return _loc2_;
      }
      
      public function get mapNodeEndPoint() : CampaignNode
      {
         for each(var _loc1_:CampaignNode in _mapNodesData)
         {
            if(_loc1_.info.types == 41)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getToAttackNode() : CampaignNode
      {
         var _loc1_:CampaignNode = dieNodeSearch();
         if(!_loc1_)
         {
            _loc1_ = startNodeSearch();
         }
         return _loc1_;
      }
      
      private function dieNodeSearch() : CampaignNode
      {
         var _loc1_:CampaignNode = getMapNodesById(_currentDieNodeId);
         if(_loc1_)
         {
            if(_loc1_.info.state == 1)
            {
               return _loc1_;
            }
            return getMapNodesByNodeIds(_loc1_.nextNodeIds);
         }
         return null;
      }
      
      private function startNodeSearch() : CampaignNode
      {
         var _loc2_:CampaignNode = mapNodeStartPoint;
         if(!_loc2_)
         {
            return null;
         }
         return searchNodeByNodeId(_loc2_.nextNodeIds);
      }
      
      public function getMapNodesByNodeIds(param1:String) : CampaignNode
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:int = Math.random() * _loc2_.length;
         var _loc4_:int = int(_loc2_[_loc3_]);
         return getMapNodeByNodeId(_loc4_);
      }
      
      public function getNodeBySindId(param1:String) : CampaignNode
      {
         for each(var _loc2_:CampaignNode in _mapNodesData)
         {
            if(_loc2_.info is ChestInfo)
            {
               if((_loc2_.info as ChestInfo).signId == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getMapNodesById(param1:int) : CampaignNode
      {
         for each(var _loc2_:CampaignNode in _mapNodesData)
         {
            if(_loc2_.info.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMapNodesByType(param1:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_:CampaignNode in _mapNodesData)
         {
            if(_loc2_.info.types == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getMapNodeByNodeId(param1:int) : CampaignNode
      {
         for each(var _loc2_:CampaignNode in _mapNodesData)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getNodeById(param1:int) : DisplayObject
      {
         for each(var _loc2_:CampaignNode in mapNodesData)
         {
            if(_loc2_.info.id == param1)
            {
               return _loc2_.nodeView;
            }
         }
         return null;
      }
      
      public function getNodeByNodeId(param1:int) : DisplayObject
      {
         for each(var _loc2_:CampaignNode in mapNodesData)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_.nodeView;
            }
         }
         return null;
      }
      
      private function searchNodeByNodeId(param1:String) : CampaignNode
      {
         var _loc4_:int = 0;
         var _loc3_:CampaignNode = null;
         if(!param1)
         {
            return null;
         }
         var _loc2_:Array = param1.split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = getMapNodeByNodeId(_loc2_[_loc4_]);
            if(_loc3_ && _loc3_.info.state != 1)
            {
               if(_loc3_.nextNodeIds != "" && _loc3_.nextNodeIds != null)
               {
                  _loc3_ = searchNodeByNodeId(_loc3_.nextNodeIds);
               }
            }
            if(_loc3_ && _loc3_.info.state == 1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function removeMapNodeByInfo(param1:MapPhysics) : void
      {
         var _loc2_:int = _mapNodesData.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _mapNodesData.splice(_loc2_,1);
         }
      }
      
      public function checkNodesPass(param1:Array) : Array
      {
         var _loc3_:String = null;
         if(!param1)
         {
            return null;
         }
         var _loc2_:Array = [];
         var _loc4_:RegExp = /_/;
         do
         {
            _loc3_ = param1.shift();
            _loc3_ = _loc3_.replace(_loc4_,",");
            _loc2_.push(_loc3_);
         }
         while(checkNodePass(_loc3_) && param1.length > 0);
         if(param1.length > 0)
         {
            _loc2_.push(param1.shift());
         }
         return _loc2_;
      }
      
      private function checkNodePass(param1:String) : Boolean
      {
         for each(var _loc2_:CampaignNode in _mapNodesData)
         {
            if(param1 == _loc2_.posX + "," + _loc2_.posY)
            {
               if(_loc2_.info.state == 2 || _loc2_.info.state == 8)
               {
                  return true;
               }
               break;
            }
         }
         return false;
      }
      
      public function getNotHandlerNodeByXY(param1:int, param2:int) : CampaignNode
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _checkTempPoint.x = param1;
         _checkTempPoint.y = param2;
         var _loc7_:CampaignArmy = selfMemberData;
         if(!_loc7_)
         {
            return null;
         }
         var _loc6_:int = _loc7_.teamId;
         for each(var _loc4_:CampaignNode in _mapNodesData)
         {
            _loc5_ = 2;
            if(_loc5_ < _loc4_.handlerRange)
            {
               _loc5_ = _loc4_.handlerRange;
            }
            _checkNodePoint.x = _loc4_.posX;
            _checkNodePoint.y = _loc4_.posY;
            loop1:
            switch(_loc4_.info.types)
            {
               case 61:
                  if(WorldBossHelper.checkConsortiaEmeDream(mapId))
                  {
                     break;
                  }
                  break;
               case 41:
                  if(campaignTemplate.Types == 13)
                  {
                     break;
                  }
                  if(campaignTemplate.Types == 23)
                  {
                     break;
                  }
                  if(campaignTemplate.Types == 24)
                  {
                     break;
                  }
               case 42:
                  if(campaignTemplate.Types != 13)
                  {
                     if(campaignTemplate.Types == 23)
                     {
                        break;
                     }
                     if(campaignTemplate.Types == 24)
                     {
                        break;
                     }
                     if(WorldBossHelper.checkDuskArea(mapId))
                     {
                        break;
                     }
                     if(WorldBossHelper.checkIceFireTemple(mapId))
                     {
                        break;
                     }
                  }
                  break;
                  if(!WorldBossHelper.checkDeepPrison(mapId))
                  {
                     while(true)
                     {
                        if(_loc4_.attackTypes == 1)
                        {
                           if(WorldBossHelper.checkPvp(mapId))
                           {
                              break loop1;
                           }
                           if(WorldBossHelper.checkFlameTemple(mapId))
                           {
                              break loop1;
                           }
                           if(WorldBossHelper.checkSvs(mapId))
                           {
                              break loop1;
                           }
                           _checkNodePoint.x = Math.floor(_loc4_.nodeView.x / 20);
                           _checkNodePoint.y = Math.floor(_loc4_.nodeView.y / 20);
                           if(_loc4_.info.state == 4)
                           {
                              break;
                           }
                        }
                        else
                        {
                           if(WorldBossHelper.checkConsortiaEmeDream(mapId))
                           {
                              if(_loc4_.info.state == 4)
                              {
                                 break loop1;
                              }
                              _checkNodePoint.x = Math.floor(_loc4_.nodeView.x / 20);
                              _checkNodePoint.y = Math.floor(_loc4_.nodeView.y / 20);
                           }
                           if(WorldBossHelper.checkGodsEvening(mapId))
                           {
                              break loop1;
                           }
                        }
                        if(!(_loc4_.param1 > 0 && _loc4_.param1 == _loc6_))
                        {
                           if(!CampaignArmyState.checkDied(selfMemberData.isDie))
                           {
                              break;
                           }
                        }
                        break loop1;
                     }
                     break;
                  }
                  break;
               case 53:
                  if(!(WorldBossHelper.checkPvp(mapId) && selfMemberData.teamId != _loc4_.param1))
                  {
                     if(WorldBossHelper.checkDuskArea(mapId) && selfMemberData.teamId != _loc4_.param1)
                     {
                        break;
                     }
                     if(WorldBossHelper.checkIceFireTemple(mapId) && selfMemberData.teamId != _loc4_.param1)
                     {
                        break;
                     }
                     if(WorldBossHelper.checkFlameTemple(mapId) && selfMemberData.teamId != _loc4_.param1)
                     {
                        break;
                     }
                  }
                  break;
                  if(!(WorldBossHelper.checkSvs(mapId) && selfMemberData.teamId != _loc4_.param1))
                  {
                     break;
                  }
                  break;
               case 121:
                  if(_loc6_ == _loc4_.param1 && CampaignArmyState.checkDied(selfMemberData.isDie))
                  {
                     break;
                  }
                  break;
               case 131:
                  if(!(_loc6_ == _loc4_.param1 && !CampaignArmyState.checkIsFlameState(selfMemberData.isDie)))
                  {
                     break;
                  }
                  break;
               case 151:
                  if(!(_loc6_ == _loc4_.param1 || _loc4_.info.state == 4))
                  {
                     _checkNodePoint.x = Math.floor(_loc4_.nodeView.x / 20);
                     _checkNodePoint.y = Math.floor(_loc4_.nodeView.y / 20);
                  }
                  break;
               case 181:
                  if(_loc4_.info.state == 4)
                  {
                     break;
                  }
               default:
                  _loc3_ = Point.distance(_checkTempPoint,_checkNodePoint);
                  if(_loc3_ <= _loc5_)
                  {
                     _loc4_ = checkPassNode(_loc4_);
                     if(_loc4_)
                     {
                        return _loc4_;
                     }
                  }
                  break;
               case 92:
               case 91:
               case 71:
               case 62:
               case 63:
               case 40:
               case 1101:
               case 141:
               case 171:
               case 111:
               case 1102:
               case 191:
               case 192:
               case 193:
               case 194:
               case 195:
               case 196:
               case 197:
               case 99999:
               case 67:
               case 1001:
               case 1002:
               case 1003:
               case 202:
               case 203:
               case 204:
               case 205:
               case 206:
               case 99998:
               case 207:
            }
         }
         return null;
      }
      
      public function getHandlerNode(param1:int, param2:int) : CampaignNode
      {
         var _loc4_:int = 0;
         _checkTempPoint.x = param1;
         _checkTempPoint.y = param2;
         for each(var _loc3_:CampaignNode in _mapNodesData)
         {
            switch(_loc3_.info.types)
            {
               case 41:
                  if(campaignTemplate.Types == 13)
                  {
                     if(CampaignArmyState.checkDied(selfMemberData.isDie))
                     {
                        break;
                     }
                  }
                  break;
               case 91:
               case 1001:
               case 1002:
                  if(!(WorldBossHelper.checkPvp(mapId) || WorldBossHelper.checkFlameTemple(mapId) || WorldBossHelper.checkSvs(mapId) || WorldBossHelper.checkDuskArea(mapId) || WorldBossHelper.checkIceFireTemple(mapId) || WorldBossHelper.checkConsortiaEmeDream(mapId)))
                  {
                     break;
                  }
                  if(onCollectionId == _loc3_.nodeId)
                  {
                     break;
                  }
               case 61:
               case 63:
               case 171:
               case 62:
               case 92:
               case 111:
                  if(!(WorldBossHelper.checkPetLand(mapId) && _loc3_.info.types == 61))
                  {
                     if(!(WorldBossHelper.checkWedding(mapId) && _loc3_.param1 != 1 && _loc3_.param1 != 2 && _loc3_.param1 != 3 && _loc3_.param1 != 8))
                     {
                        _checkNodePoint.x = _loc3_.posX;
                        _checkNodePoint.y = _loc3_.posY;
                        _loc4_ = Point.distance(_checkTempPoint,_checkNodePoint);
                        if(_loc4_ <= _loc3_.handlerRange + 2)
                        {
                           return checkPassNode(_loc3_);
                        }
                     }
                  }
                  break;
               case 1003:
                  _checkNodePoint.x = _loc3_.posX;
                  _checkNodePoint.y = _loc3_.posY;
                  _loc4_ = Point.distance(_checkTempPoint,_checkNodePoint);
                  if(_loc4_ <= _loc3_.handlerRange + 2)
                  {
                     if(checkPassNode(_loc3_))
                     {
                        return _loc3_;
                     }
                  }
                  break;
               case 202:
               case 203:
               case 99998:
                  if(!(WorldBossHelper.checkUnrealShooting(mapId) && (_loc3_.info.types == 202 || _loc3_.info.types == 203) && _loc3_.info.state != 1))
                  {
                     if(!(WorldBossHelper.checkActiveVehicle(mapId) && _loc3_.info.types == 99998))
                     {
                        _loc4_ = Point.distance(_checkTempPoint,_checkNodePoint);
                        if(_loc4_ <= _loc3_.handlerRange + 2)
                        {
                           if(checkPassNode(_loc3_))
                           {
                              return _loc3_;
                           }
                        }
                     }
                  }
            }
         }
         return null;
      }
      
      private function checkPassNode(param1:CampaignNode) : CampaignNode
      {
         switch(param1.info.state)
         {
            case 0:
            case 2:
            case 8:
               return null;
            default:
               return param1;
         }
      }
      
      public function chckeNpcFriendState(param1:CampaignNode) : Boolean
      {
         if(param1.info.types == 42)
         {
            if(param1.param1 > 0 && param1.param1 == selfMemberData.teamId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getNeighborIII(param1:int, param2:int) : Point
      {
         var _loc3_:Point = null;
         var _loc4_:int = 1;
         while(true)
         {
            _loc3_ = find(_loc4_,param1,param2);
            if(_loc3_ && !getMapNodesByPoint(_loc3_))
            {
               break;
            }
            if(++_loc4_ > 400)
            {
               return null;
            }
         }
         return _loc3_;
      }
      
      public function getMapNodesByPoint(param1:Point) : CampaignNode
      {
         var _loc3_:Point = new Point(param1.x * 20,param1.y * 20);
         for each(var _loc2_:CampaignNode in _mapNodesData)
         {
            if(_loc2_.x == _loc3_.x && _loc2_.y == _loc3_.y)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getNeighborII(param1:int, param2:int) : Point
      {
         var _loc4_:int = 0;
         var _loc3_:Point = null;
         _loc4_ = 1;
         while(_loc4_ < 10)
         {
            _loc3_ = find(_loc4_,param1,param2);
            if(_loc3_)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      private function find(param1:int, param2:int, param3:int) : Point
      {
         var _loc4_:int = 0;
         _loc4_ = -param1;
         while(_loc4_ < param1)
         {
            if(getPointValue(param2 + _loc4_,param3 + param1))
            {
               return new Point(param2 + _loc4_,param3 + param1);
            }
            if(getPointValue(param2 + _loc4_,param3 - param1))
            {
               return new Point(param2 + _loc4_,param3 - param1);
            }
            if(getPointValue(param2 + param1,param3 + _loc4_))
            {
               return new Point(param2 + param1,param3 + _loc4_);
            }
            if(getPointValue(param2 - param1,param3 + _loc4_))
            {
               return new Point(param2 - param1,param3 + _loc4_);
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getNeighbor(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         if(getPointValue(param1 - 20,param2))
         {
            _loc3_.push(new Point(param1 - 20,param2));
         }
         if(getPointValue(param1 + 20,param2))
         {
            _loc3_.push(new Point(param1 + 20,param2));
         }
         if(getPointValue(param1,param2 - 20))
         {
            _loc3_.push(new Point(param1,param2 - 20));
         }
         if(getPointValue(param1,param2 + 20))
         {
            _loc3_.push(new Point(param1,param2 + 20));
         }
         return _loc3_;
      }
      
      public function getPointValue(param1:int, param2:int) : Boolean
      {
         return mapTielsData[param1 + "_" + param2] ? true : false;
      }
      
      public function moveArmyToRange(param1:int, param2:Array) : void
      {
         this.dispatchEvent(new CampaignEvent("MOVE_ARMY_TO_RANGE",{
            "id":param1,
            "range":param2
         }));
      }
      
      public function get smallMapState() : String
      {
         return _smallMapIcon;
      }
      
      public function standPos(param1:StandPosMsg) : void
      {
         this.dispatchEvent(new CampaignEvent("STANDPOS",param1));
      }
      
      public function moveNpc(param1:*) : void
      {
         this.dispatchEvent(new CampaignEvent("MOVE_NPC",param1));
      }
      
      public function npcChase(param1:*) : void
      {
         this.dispatchEvent(new CampaignEvent("NPC_CHASE",param1));
      }
      
      public function set takeCardsMsg(param1:CampaignTakeCardsMsg) : void
      {
         this.dispatchEvent(new CampaignMapEvent("UPDATE_CHEST_INFO",param1));
      }
      
      public function movePathsArmy(param1:PosMoveMsg) : void
      {
         var _loc2_:CampaignArmy = null;
         this.dispatchEvent(new CampaignMapEvent("MOVE_PATHS_ARMY",param1));
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = getUserArmyByArmyId(param1.armyId,param1.serverName);
            if(_loc2_ == selfMemberData)
            {
               log({},"服务器");
            }
            if(_loc2_)
            {
               _loc2_.curPosX = param1.routes[0].x / 20;
               _loc2_.curPosY = param1.routes[0].y / 20;
               _loc2_.needInit = true;
            }
         }
      }
      
      public function movePathsArmyList(param1:PosMoveListMsg) : void
      {
         this.dispatchEvent(new CampaignMapEvent("MOVE_PATHS_ARMY_LIST",param1));
      }
      
      public function synCampaignView(param1:SynPlayerViewMsg) : void
      {
         this.dispatchEvent(new CampaignMapEvent("SYN_CAMPAIGN_VIEW",param1));
      }
      
      public function gotoPosArmy(param1:ArmyPosUpdatedMsg) : void
      {
         var _loc2_:CampaignArmy = getUserArmyByArmyId(param1.armyId,param1.serverName);
         if(_loc2_ && SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            _loc2_.curPosX = param1.curPosX;
            _loc2_.curPosY = param1.curPosY;
         }
         this.dispatchEvent(new CampaignMapEvent("GO_TO_POS",param1));
      }
      
      public function updateWalkTarget(param1:Point) : void
      {
         this.dispatchEvent(new CampaignMapEvent("UPDATE_WALK_TARGET",param1));
      }
      
      public function getSendNode() : CampaignNode
      {
         for each(var _loc1_:CampaignNode in mapNodesData)
         {
            if(_loc1_.info.types == 63 || _loc1_.info.types == 41 || _loc1_.info.types == 62 || _loc1_.info.types == 171)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getPlayerIds() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:CampaignArmy in allUserArmy)
         {
            if(selfMemberData.teamId == _loc2_.teamId)
            {
               _loc1_.push(_loc2_.userId);
            }
         }
         return _loc1_;
      }
      
      public function getArmysByState(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:CampaignArmy in _userArmyList)
         {
            if(_loc3_.isDie == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(bgLayer);
         bgLayer = null;
         while(staticMovies.length > 0)
         {
            staticMovies.pop();
         }
         if(rollInfos)
         {
            rollInfos = null;
         }
         super.dispose();
      }
      
      public function findArmyInNode(param1:int) : CampaignArmy
      {
         for each(var _loc2_:CampaignArmy in allUserArmy)
         {
            if(_loc2_.mountNodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function bossAttackNotice(param1:Point) : void
      {
         this.dispatchEvent(new CampaignMapEvent("ATTACK_BOSS_NOTICE",param1));
      }
      
      public function moveActiveVehiclePaths(param1:VehicleMoveMsg) : void
      {
         var _loc2_:CampaignArmy = null;
         this.dispatchEvent(new CampaignMapEvent("ACTIVEVEHICLE_MOVE_PATH",param1));
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = getUserArmyByArmyId(param1.playerId);
            if(_loc2_ == selfMemberData)
            {
               log({},"服务器");
            }
            if(_loc2_)
            {
               _loc2_.curPosX = param1.path[0].x / 20;
               _loc2_.curPosY = param1.path[0].y / 20;
               _loc2_.needInit = true;
            }
         }
      }
      
      public function getBaseTowerUnrealShooting(param1:int) : CampaignNode
      {
         for each(var _loc2_:CampaignNode in mapNodesData)
         {
            if(_loc2_.info.types == 206 && _loc2_.param2 == 1 && _loc2_.param1 == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getTowerListUnrealShooting() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:CampaignNode in mapNodesData)
         {
            if(_loc2_.info.types == 206)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get hideOtherPlayer() : Boolean
      {
         return _hideOtherPlayer;
      }
      
      public function set hideOtherPlayer(param1:Boolean) : void
      {
         _hideOtherPlayer = param1;
         NotificationManager.instance.sendNotification("HIDE_OTHERS",param1);
      }
   }
}

