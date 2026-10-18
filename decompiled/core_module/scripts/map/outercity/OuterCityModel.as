package map.outercity
{
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import map.internals.constant.ArmyState;
   import map.internals.data.BaseCastle;
   import map.internals.data.FloorMapInfo;
   import map.internals.data.MapPhysics;
   import map.internals.data.OuterCityNode;
   import map.internals.data.WildLand;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.Utils;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class OuterCityModel extends FloorMapInfo
   {
      
      private var _currentCastles:Array;
      
      private var _currentWildLand:Array;
      
      private var _allWildLand:Dictionary = new Dictionary(true);
      
      private var _allCastles:Dictionary = new Dictionary(true);
      
      public var walkTargerData:MapPhysics;
      
      private var _selectPkArmy:UserArmy;
      
      private var _staticMovies:Dictionary = new Dictionary(true);
      
      public var bossInfo:MapBossMsgInfo;
      
      private var _selfCastles:BaseCastle;
      
      public var onCollectionId:int = 0;
      
      public var archaeologyNodeList:Array = [];
      
      private var _mapNodesData:Array = [];
      
      public var isArchaeologyCollection:Boolean = false;
      
      private var _castlePool:Vector.<BaseCastle> = new Vector.<BaseCastle>();
      
      private var _allArmysDict:Dictionary = new Dictionary(true);
      
      private var _checkTempPoint:Point = new Point();
      
      private var _checkNodePoint:Point = new Point();
      
      public function OuterCityModel(param1:IEventDispatcher = null)
      {
         super(param1);
         var _loc2_:BaseArmy = ArmyManager.instance.army;
         _allArmysDict[_loc2_.id] = _loc2_;
         bossInfo = new MapBossMsgInfo();
      }
      
      public function get selfCastles() : BaseCastle
      {
         return _selfCastles;
      }
      
      public function set selfCastles(param1:BaseCastle) : void
      {
         _selfCastles = param1;
      }
      
      public function get staticMovies() : Dictionary
      {
         return _staticMovies;
      }
      
      public function addStaticMovie(param1:WildLand, param2:String) : void
      {
         _staticMovies[param2] = param1;
      }
      
      public function get selectPkArmy() : UserArmy
      {
         return _selectPkArmy;
      }
      
      public function set selectPkArmy(param1:UserArmy) : void
      {
         var _loc2_:String = null;
         _selectPkArmy = param1;
         if(selectPkArmy == null)
         {
            return;
         }
         var _loc3_:int = PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID;
         if(_loc3_ > 0 && selectPkArmy.baseHero.consortiaID == _loc3_)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.OuterCityPkMediator.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(selectPkArmy.state == 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command05");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         this.dispatchEvent(new OuterCityEvent("selectPkArmy",param1));
      }
      
      public function set currentCastles(param1:Array) : void
      {
         _currentCastles = param1;
         for each(var _loc2_:BaseCastle in param1)
         {
            addCastle(_loc2_);
         }
         this.dispatchEvent(new OuterCityEvent("currentCastles",param1));
      }
      
      private function addCastle(param1:BaseCastle) : void
      {
         var _loc2_:String = getFileName(param1.x,param1.y);
         var _loc3_:Dictionary = _allCastles[_loc2_];
         if(!_loc3_)
         {
            _loc3_ = new Dictionary(true);
         }
         _loc3_[param1.info.id] = param1;
         _allCastles[_loc2_] = _loc3_;
         if(param1.info.occupyPlayerId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            selfCastles = param1;
         }
      }
      
      private function removeCastle(param1:BaseCastle, param2:String) : void
      {
         var _loc3_:Dictionary = _allCastles[param2];
         if(_loc3_)
         {
            this.dispatchEvent(new OuterCityEvent("REMOVE_CASTLE",param1));
            delete _loc3_[param1.info.id];
         }
      }
      
      public function get allCastles() : Dictionary
      {
         return _allCastles;
      }
      
      public function get mySelfCastles() : BaseCastle
      {
         var _loc2_:BaseCastle = null;
         for each(var _loc3_:Dictionary in allCastles)
         {
            for each(var _loc1_:BaseCastle in _loc3_)
            {
               if(_loc1_.info.occupyPlayerId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
               {
                  _loc2_ = _loc1_;
               }
            }
         }
         return _loc2_;
      }
      
      public function getCastleById(param1:int, param2:int, param3:int) : BaseCastle
      {
         var _loc4_:String = getFileName(param2,param3);
         var _loc5_:Dictionary = _allCastles[_loc4_];
         if(_loc5_)
         {
            return _loc5_[param1];
         }
         return null;
      }
      
      public function getCastleByXY(param1:int, param2:int) : BaseCastle
      {
         var _loc4_:String = getFileName(param1,param2);
         var _loc5_:Dictionary = _allCastles[_loc4_];
         for each(var _loc3_:BaseCastle in _loc5_)
         {
            if(_loc3_.x == param1 && _loc3_.y == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function removesNSSCastles() : void
      {
         var _loc3_:Dictionary = null;
         for(var _loc2_:String in _allCastles)
         {
            if(nineSliceScaling.indexOf(_loc2_) == -1)
            {
               _loc3_ = _allCastles[_loc2_];
               for(var _loc1_:String in _loc3_)
               {
                  removeCastle(_loc3_[_loc1_],_loc2_);
                  delete _loc3_[_loc1_];
               }
               delete _allCastles[_loc2_];
            }
         }
      }
      
      public function get currentCastles() : Array
      {
         return _currentCastles;
      }
      
      public function get currentWildLand() : Array
      {
         return _currentWildLand;
      }
      
      public function set currentWildLand(param1:Array) : void
      {
         var _loc2_:WildLand = null;
         _currentWildLand = param1;
         for each(var _loc3_:MapPhysics in param1)
         {
            _loc2_ = getWildLandByXY(_loc3_.x + "," + _loc3_.y);
            if(_loc2_ && _loc2_.info.types != _loc3_.info.types)
            {
               removeWildLand(_loc2_);
            }
            if(_loc3_.info.state == 0)
            {
               if(_loc2_)
               {
                  removeWildLand(_loc2_);
               }
            }
            else
            {
               addWildLand(_loc3_);
            }
         }
         this.dispatchEvent(new OuterCityEvent("currentWildLand",param1));
      }
      
      public function updateWildLand(param1:MapPhysics) : void
      {
         var _loc2_:WildLand = getWildLandByXY(param1.x + "," + param1.y);
         if(_loc2_ && _loc2_.info.types != param1.info.types)
         {
            removeWildLand(_loc2_);
         }
         if(param1.info.state == 0)
         {
            _loc2_ && removeWildLand(_loc2_);
            return;
         }
         addWildLand(param1);
         this.dispatchEvent(new OuterCityEvent("currentWildLand",[param1]));
      }
      
      private function removeWildLand(param1:MapPhysics) : void
      {
         if(param1.info)
         {
            if(param1.info.types == 21)
            {
               this.dispatchEvent(new OuterCityEvent("REMOVE_NODE_NPC",param1));
            }
            else
            {
               this.dispatchEvent(new OuterCityEvent("REMOVE_NODE_MOVIE",param1));
            }
         }
         else
         {
            if(param1.nodeView)
            {
               param1.nodeView["dispose"]();
            }
            param1.nodeView = null;
         }
         var _loc2_:String = getFileName(param1.x,param1.y);
         var _loc3_:Dictionary = _allWildLand[_loc2_];
         if(_loc3_)
         {
            delete _loc3_[getPosByInfo(param1)];
         }
      }
      
      private function addWildLand(param1:MapPhysics) : void
      {
         var _loc2_:String = getFileName(param1.x,param1.y);
         var _loc3_:Dictionary = _allWildLand[_loc2_];
         if(!_loc3_)
         {
            _loc3_ = new Dictionary(true);
         }
         _loc3_[getPosByInfo(param1)] = param1;
         _allWildLand[_loc2_] = _loc3_;
      }
      
      public function get allWildLand() : Dictionary
      {
         return _allWildLand;
      }
      
      private function removesNSSWildLand() : void
      {
         var _loc3_:Dictionary = null;
         for(var _loc2_:String in _allWildLand)
         {
            if(nineSliceScaling.indexOf(_loc2_) == -1)
            {
               _loc3_ = _allWildLand[_loc2_];
               for(var _loc1_:String in _loc3_)
               {
                  removeWildLand(_loc3_[_loc1_]);
                  delete _loc3_[_loc1_];
               }
               delete _allWildLand[_loc2_];
            }
         }
      }
      
      public function getMapPhysicsById(param1:int) : MapPhysics
      {
         loop0:
         for each(var _loc2_:Dictionary in allWildLand)
         {
            var _loc5_:int = 0;
            var _loc4_:Dictionary = _loc2_;
            do
            {
               for each(var _loc3_:MapPhysics in _loc4_)
               {
               }
               continue loop0;
            }
            while(_loc3_.info.id != param1);
            return _loc3_;
         }
         return null;
      }
      
      override public function set nineSliceScaling(param1:Array) : void
      {
         super.nineSliceScaling = param1;
         removesNSSWildLand();
         removesNSSCastles();
      }
      
      private function getPosByInfo(param1:MapPhysics) : String
      {
         return param1.x + "," + param1.y;
      }
      
      public function getFileName(param1:int, param2:int, param3:int = 1000, param4:int = 1000) : String
      {
         var _loc5_:int = Math.floor(param1 / param3);
         var _loc6_:int = Math.floor(param2 / param4);
         return _loc5_ + "," + _loc6_;
      }
      
      public function addCasetInfoToPool(param1:BaseCastle) : void
      {
         if(!param1 || !param1.info)
         {
            return;
         }
         delete _allCastles[param1.info.id];
         _castlePool.push(param1);
      }
      
      public function popCastleInfo() : BaseCastle
      {
         return _castlePool.pop();
      }
      
      public function getWildLandByXY(param1:String) : WildLand
      {
         var _loc2_:Point = Utils.strToPoint(param1,",");
         var _loc3_:String = getFileName(_loc2_.x,_loc2_.y);
         var _loc4_:Dictionary = _allWildLand[_loc3_];
         if(_loc4_)
         {
            return _loc4_[_loc2_.x + "," + _loc2_.y];
         }
         return null;
      }
      
      public function getPhysicsByXY(param1:int, param2:int) : Sprite
      {
         var _loc3_:MapPhysics = null;
         var _loc5_:String = getFileName(param1,param2);
         var _loc6_:Dictionary = _allWildLand[_loc5_];
         if(_loc6_)
         {
            _loc3_ = _loc6_[param1 + "," + param2];
         }
         if(_loc3_)
         {
            return _loc3_.nodeView;
         }
         var _loc4_:BaseCastle = getCastleByXY(param1,param2);
         if(_loc4_)
         {
            return _loc4_.nodeView;
         }
         return null;
      }
      
      public function get allArmyDict() : Dictionary
      {
         return _allArmysDict;
      }
      
      public function addArmyToWorldDict(param1:BaseArmy) : void
      {
         _allArmysDict[param1.id] = param1;
      }
      
      public function removeWorldArmyById(param1:int) : BaseArmy
      {
         var _loc2_:BaseArmy = _allArmysDict[param1];
         delete _allArmysDict[param1];
         this.dispatchEvent(new OuterCityEvent("REMOVE_ARMY",_loc2_));
         return _loc2_;
      }
      
      public function getWorldArmyById(param1:int) : BaseArmy
      {
         return _allArmysDict[param1];
      }
      
      public function getWorldArmyByUserId(param1:int) : BaseArmy
      {
         for each(var _loc2_:BaseArmy in _allArmysDict)
         {
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function selfArmy() : BaseArmy
      {
         return getWorldArmyByUserId(playerInfo.userId);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function layMapArmy(param1:Array) : void
      {
         this.dispatchEvent(new OuterCityEvent("layMapArmy",param1));
      }
      
      public function returnHome(param1:int) : void
      {
         this.dispatchEvent(new OuterCityEvent("return_home",param1));
      }
      
      public function posationHandler(param1:int) : void
      {
         this.dispatchEvent(new OuterCityEvent("POSATION_POINT",param1));
      }
      
      override public function dispose() : void
      {
         _currentCastles = null;
         _currentWildLand = null;
         for each(var _loc4_:String in _allWildLand)
         {
            delete _allWildLand[_loc4_];
         }
         _allWildLand = null;
         for each(var _loc1_:String in _allCastles)
         {
            delete _allCastles[_loc1_];
         }
         for each(var _loc3_:String in _mapNodesData)
         {
            delete _mapNodesData[_loc3_];
         }
         _mapNodesData = null;
         _castlePool = null;
         _allCastles = null;
         for each(var _loc2_:String in _staticMovies)
         {
            delete _staticMovies[_loc2_];
         }
         _staticMovies = null;
         super.dispose();
      }
      
      override public function getWalkable(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = param1 / 20;
         var _loc4_:int = param2 / 20;
         return mapTielsData[_loc3_ + "_" + _loc4_] ? true : false;
      }
      
      public function checkArmy(param1:MapPhysics, param2:int) : UserArmy
      {
         var _loc3_:UserArmy = canAttackArmy(param1,param2);
         if(!_loc3_)
         {
            return null;
         }
         return _loc3_;
      }
      
      private function canAttackArmy(param1:MapPhysics, param2:int) : UserArmy
      {
         var _loc3_:String = "";
         var _loc4_:UserArmy = ArmyManager.instance.army;
         if(_loc4_ == null)
         {
            _loc3_ = LanguageMgr.GetTranslation("map.outercity.OuterCityModel.command01");
            MessageTipManager.instance().show(_loc3_,true);
         }
         else if(_loc4_.state != 0 && !ArmyState.moveState(_loc4_.state))
         {
            _loc3_ = LanguageMgr.GetTranslation("map.outercity.OuterCityModel.command02");
            MessageTipManager.instance().show(_loc3_,true);
         }
         else if(_loc4_.curPosX == param1.posX && _loc4_.curPosY == param1.posY && param2 == 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("map.outercity.OuterCityModel.command03");
            MessageTipManager.instance().show(_loc3_,true);
         }
         else
         {
            if(_loc4_.mapId > 100000 && param1.info.mapId == 100)
            {
               return _loc4_;
            }
            if(_loc4_.mapId == param1.info.mapId)
            {
               return _loc4_;
            }
            _loc3_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.OuterCitySmallMapMediator.command01");
            MessageTipManager.instance().show(_loc3_,true);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("ARMY_SYSC_CALL",null));
         }
         return null;
      }
      
      public function get mapNodesData() : Array
      {
         return _mapNodesData;
      }
      
      public function addNode(param1:OuterCityNode) : void
      {
         if(_mapNodesData.indexOf(param1) < 0)
         {
            _mapNodesData.push(param1);
         }
         this.dispatchEvent(new OuterCityEvent("currentNpcPos",_mapNodesData));
      }
      
      public function removeNode(param1:OuterCityNode) : void
      {
         var _loc3_:int = 0;
         var _loc2_:OuterCityNode = null;
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
      
      public function getMapNodeByNodeId(param1:int) : OuterCityNode
      {
         for each(var _loc2_:OuterCityNode in _mapNodesData)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getNotHandlerNodeByXY(param1:int, param2:int) : OuterCityNode
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _checkTempPoint.x = param1;
         _checkTempPoint.y = param2;
         if(!selfArmy())
         {
            return null;
         }
         for each(var _loc4_:OuterCityNode in _mapNodesData)
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
               case 92:
               case 91:
               case 71:
               case 62:
               case 63:
               case 40:
               case 141:
               case 171:
               case 67:
                  break;
               case 41:
               case 42:
                  while(true)
                  {
                     if(_loc4_.attackTypes == 1)
                     {
                        _checkNodePoint.x = Math.floor(_loc4_.nodeView.x / 20);
                        _checkNodePoint.y = Math.floor(_loc4_.nodeView.y / 20);
                        if(_loc4_.info.state == 4)
                        {
                           break;
                        }
                     }
                     if(!(_loc4_.param1 > 0 && _loc4_.param1 == _loc6_))
                     {
                        break;
                     }
                     break loop1;
                  }
                  break;
               case 53:
               case 131:
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
               case 121:
            }
         }
         return null;
      }
      
      public function getHandlerNode(param1:int, param2:int) : OuterCityNode
      {
         var _loc4_:int = 0;
         _checkTempPoint.x = param1;
         _checkTempPoint.y = param2;
         for each(var _loc3_:OuterCityNode in _mapNodesData)
         {
            switch(_loc3_.info.types)
            {
               case 41:
               case 91:
               case 1001:
               case 1002:
               case 61:
               case 63:
               case 171:
               case 62:
               case 92:
               case 111:
                  _checkNodePoint.x = _loc3_.posX;
                  _checkNodePoint.y = _loc3_.posY;
                  _loc4_ = Point.distance(_checkTempPoint,_checkNodePoint);
                  if(_loc4_ <= _loc3_.handlerRange + 2)
                  {
                     return checkPassNode(_loc3_);
                  }
            }
         }
         return null;
      }
      
      private function checkPassNode(param1:OuterCityNode) : OuterCityNode
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
      
      public function getArchaeologyNodeById(param1:int) : ArchaeologyNodeInfo
      {
         for each(var _loc2_:ArchaeologyNodeInfo in archaeologyNodeList)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

