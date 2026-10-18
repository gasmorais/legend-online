package map.space
{
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.SpacePlayerMoveMsg;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.FloorMapInfo;
   import map.internals.data.SpaceNode;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.Utils;
   import map.space.data.SpaceArmy;
   import yishi.SwitchPageHelp;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class SpaceModel extends FloorMapInfo
   {
      
      public var bgLayer:Object;
      
      private var _allArmysDict:Dictionary;
      
      private var _mapNodesData:Array;
      
      private var _checkTempPoint:Point;
      
      private var _checkNodePoint:Point;
      
      private var _glowTarget:Sprite;
      
      public var staticMovies:Array;
      
      public var selectNode:SpaceNode;
      
      public var checkNodeId:int;
      
      public var nextPoint:Point;
      
      public var onCollectionId:int = 0;
      
      public var currentSceneMovies:Array = [];
      
      public var currentSceneTops:Array = [];
      
      public function SpaceModel(param1:IEventDispatcher = null)
      {
         super(param1);
         _allArmysDict = new Dictionary(true);
         _mapNodesData = [];
         _checkTempPoint = new Point();
         _checkNodePoint = new Point();
         staticMovies = [];
      }
      
      override public function set currentFloorData(param1:Array) : void
      {
         var _loc2_:* = null;
         if(mapTempInfo.Width > 5000 || mapTempInfo.Height > 5000)
         {
            this.dispatchEvent(new OuterCityEvent("commitLoading",null));
         }
         currentSceneMovies = [];
         currentSceneTops = [];
         for each(_loc2_ in moviesData)
         {
            currentSceneMovies = currentSceneMovies.concat(_loc2_);
         }
         for each(_loc2_ in topsData)
         {
            currentSceneTops = currentSceneTops.concat(_loc2_);
         }
         this.dispatchEvent(new OuterCityEvent("currentConfigChange",{
            "movies":currentSceneMovies,
            "tops":currentSceneTops
         }));
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
      
      public function moveToVisible(param1:SpaceArmy) : void
      {
         dispatchEvent(new CampaignMapEvent("MOVE_TO_VISIBLE",param1));
      }
      
      public function moveToUnVisible(param1:SpaceArmy) : void
      {
         dispatchEvent(new CampaignMapEvent("MOVE_TO_UNVISIBLE",param1));
      }
      
      public function addUserArmy(param1:SpaceArmy) : void
      {
         if(!_allArmysDict[param1.userId])
         {
            _allArmysDict[param1.userId] = param1;
            dispatchEvent(new OuterCityEvent("addGarrison",param1));
         }
         else
         {
            _allArmysDict[param1.userId] = param1;
         }
      }
      
      public function removeUserArmyByArmyId(param1:int) : SpaceArmy
      {
         var _loc2_:SpaceArmy = _allArmysDict[param1];
         if(_loc2_)
         {
            delete _allArmysDict[param1];
            dispatchEvent(new OuterCityEvent("REMOVE_ARMY",_loc2_));
         }
         return _loc2_;
      }
      
      public function getUserArmyByUserId(param1:int) : SpaceArmy
      {
         return _allArmysDict[param1];
      }
      
      public function get glowTarget() : Sprite
      {
         return _glowTarget;
      }
      
      public function set glowTarget(param1:Sprite) : void
      {
         if(_glowTarget == param1)
         {
            return;
         }
         if(_glowTarget && _glowTarget.hasOwnProperty("setNormalFilter"))
         {
            _glowTarget["setNormalFilter"]();
            _glowTarget = null;
         }
         _glowTarget = param1;
         if(_glowTarget && _glowTarget.hasOwnProperty("setGlowFilter"))
         {
            _glowTarget["setGlowFilter"]();
         }
      }
      
      public function isFlying(param1:int) : Boolean
      {
         if(!mapTielsData)
         {
            return false;
         }
         var _loc2_:MountTemplate = TempleteManager.instance.mountTemplateDic[param1];
         if(_loc2_ && (_loc2_.IsFly == 1 || _loc2_.isBuyFly))
         {
            return true;
         }
         return false;
      }
      
      public function canLand(param1:int = 0) : Boolean
      {
         if(!mapTielsData)
         {
            return true;
         }
         if(SwitchPageHelp.isInCampaign)
         {
            return true;
         }
         if(SwitchPageHelp.isInSpace)
         {
            if(!isOnObstacle)
            {
               return true;
            }
         }
         else if(!PlayerManager.instance.currentPlayerModel.isOnObstacle)
         {
            return true;
         }
         if(isFlying(param1))
         {
            return true;
         }
         return false;
      }
      
      public function updateWalkTarget(param1:Point) : void
      {
         dispatchEvent(new CampaignMapEvent("UPDATE_WALK_TARGET",param1));
      }
      
      public function get selfArmy() : SpaceArmy
      {
         return getUserArmyByUserId(ArmyManager.instance.army.userId);
      }
      
      public function get allArmyDict() : Dictionary
      {
         return _allArmysDict;
      }
      
      public function moveArmyTo(param1:SpacePlayerMoveMsg) : void
      {
         dispatchEvent(new CampaignMapEvent("MOVE_PATHS_ARMY",param1));
      }
      
      override public function getWalkable(param1:int, param2:int) : Boolean
      {
         return mapTielsData[param1 + "_" + param2] ? true : false;
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
      
      public function get isOnObstacle() : Boolean
      {
         if(!SpaceManager.instance.controller)
         {
            return false;
         }
         if(!selfArmy)
         {
            return false;
         }
         var _loc1_:Object = SpaceManager.instance.controller.getArmyView(selfArmy);
         return armyIsOnObstacle(_loc1_);
      }
      
      public function armyIsOnObstacle(param1:Object) : Boolean
      {
         if(!SpaceManager.instance.controller)
         {
            return false;
         }
         if(!mapTielsData)
         {
            return false;
         }
         if(!param1)
         {
            return false;
         }
         if(getPointValue(param1.x / 20,param1.y / 20))
         {
            return false;
         }
         var _loc2_:Point = find(2,int(param1.x / 20),int(param1.y / 20));
         if(_loc2_)
         {
            return false;
         }
         return true;
      }
      
      public function getPointValue(param1:int, param2:int) : Boolean
      {
         var _loc3_:Boolean = false;
         if(mapTielsData[param1 + "_" + param2])
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function buildMapNodesData() : void
      {
         for each(var _loc1_:SpaceNode in mapNodesData)
         {
            if(_loc1_.info.types != 1)
            {
               _loc1_.initHandlerRangePoints(this);
            }
         }
      }
      
      public function get mapNodesData() : Array
      {
         return _mapNodesData;
      }
      
      public function addNode(param1:SpaceNode) : void
      {
         if(_mapNodesData.indexOf(param1) < 0)
         {
            _mapNodesData.push(param1);
         }
         this.dispatchEvent(new OuterCityEvent("currentNpcPos",_mapNodesData));
      }
      
      public function removeNode(param1:SpaceNode) : void
      {
         var _loc3_:int = 0;
         var _loc2_:SpaceNode = null;
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
         mapNodesData = _mapNodesData.concat(param1);
      }
      
      public function getHandlerNode(param1:int, param2:int) : SpaceNode
      {
         var _loc4_:int = 0;
         _checkTempPoint.x = param1;
         _checkTempPoint.y = param2;
         for each(var _loc3_:SpaceNode in _mapNodesData)
         {
            switch(_loc3_.info.types)
            {
               case 1:
               case 40:
                  break;
               default:
                  _checkNodePoint.x = _loc3_.posX;
                  _checkNodePoint.y = _loc3_.posY;
                  _loc4_ = Point.distance(_checkTempPoint,_checkNodePoint);
                  if(_loc4_ <= _loc3_.handlerRange)
                  {
                     return _loc3_;
                  }
            }
         }
         return null;
      }
      
      public function getMapNodeById(param1:int) : SpaceNode
      {
         for each(var _loc2_:SpaceNode in _mapNodesData)
         {
            if(_loc2_.info.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMapNodesByPoint(param1:Point) : SpaceNode
      {
         var _loc3_:Point = new Point(param1.x * 20,param1.y * 20);
         for each(var _loc2_:SpaceNode in _mapNodesData)
         {
            if(_loc2_.x == _loc3_.x && _loc2_.y == _loc3_.y)
            {
               return _loc2_;
            }
         }
         return null;
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
      
      override public function getAroundWalkPoint(param1:int, param2:int) : Point
      {
         if(!selfArmy)
         {
            return null;
         }
         var _loc3_:Boolean = isFlying(selfArmy.mountTemplateId);
         if(_loc3_)
         {
            return new Point(param1 / 20,param2 / 20);
         }
         return super.getAroundWalkPoint(param1,param2);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(bgLayer);
         bgLayer = null;
         while(staticMovies.length > 0)
         {
            staticMovies.pop();
         }
         staticMovies = null;
         super.dispose();
      }
   }
}

