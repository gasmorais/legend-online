package com.map.vehicle
{
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.data.VehicleSkillbag;
   import com.map.vehicle.events.VehicleEvent;
   import flash.geom.Point;
   import map.internals.data.MapInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.interfaces.ISceneChat;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class VehicleModel extends MapInfo implements ISceneChat
   {
      
      public var blueScore:int = 0;
      
      public var bossTempId:int = 2191;
      
      public var createType:int;
      
      public var isWin:Boolean;
      
      public var myScore:int = 0;
      
      public var redScore:int = 0;
      
      private var _remainsTime:Number = 0;
      
      public var reward1:int;
      
      public var reward2:int;
      
      public var rewardExp:int;
      
      public var bossRefreshed:Boolean = false;
      
      private var _campaignId:int;
      
      private var _nodeList:Vector.<VehicleNode>;
      
      private var _playerList:SimpleDictionary;
      
      private var _selfVehicleInfo:PlayerVehicleInfo;
      
      private var _skillBag:VehicleSkillbag;
      
      private var playerInfo:PlayerInfo;
      
      private var startDate:Date = new Date();
      
      private var endDate:Date = new Date();
      
      public var campaiganStartTime:Date = new Date();
      
      public function VehicleModel(param1:int)
      {
         playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         super();
         _campaignId = param1;
         mapId = param1;
         _playerList = new SimpleDictionary(true);
         _nodeList = new Vector.<VehicleNode>();
         _skillBag = new VehicleSkillbag();
         initStartEndDate();
      }
      
      public function addNode(param1:VehicleNode) : void
      {
         if(param1.state == 1)
         {
            removeNode(param1);
            this.dispatchEvent(new VehicleEvent("REMOVE_NODE",param1));
            return;
         }
         if(!hasNode(param1))
         {
            _nodeList.push(param1);
            this.dispatchEvent(new VehicleEvent("addNode",param1));
         }
         else
         {
            this.dispatchEvent(new VehicleEvent("updateNode",param1));
         }
      }
      
      public function addPlayer(param1:PlayerVehicleInfo) : void
      {
         if(param1.playerId == playerInfo.userId)
         {
            if(!_selfVehicleInfo)
            {
               _selfVehicleInfo = param1;
               _skillBag.init(_selfVehicleInfo);
            }
         }
         if(_playerList[param1.playerId])
         {
            this.dispatchEvent(new VehicleEvent("update_player",param1));
         }
         else
         {
            _playerList.add(param1.playerId,param1);
            this.dispatchEvent(new VehicleEvent("addPlayer",param1));
         }
      }
      
      public function bossAttackNotice(param1:Point) : void
      {
         dispatchEvent(new VehicleEvent("ATTACK_NOTICE",param1));
      }
      
      public function get campaignId() : int
      {
         return _campaignId;
      }
      
      public function get currentChanelPlayerList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:PlayerVehicleInfo in _playerList)
         {
            _loc1_.push(_loc2_.playerId);
         }
         return _loc1_;
      }
      
      public function getBoss() : VehicleNode
      {
         for each(var _loc1_:VehicleNode in nodeList)
         {
            if(_loc1_.isBoss())
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getHandlerNode(param1:int, param2:int) : VehicleNode
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc7_:Point = new Point(param1,param2);
         var _loc6_:Point = new Point();
         for each(var _loc3_:VehicleNode in _nodeList)
         {
            _loc4_ = 2;
            _loc4_ = int(_loc4_ < _loc3_.handlerRange ? _loc3_.handlerRange : 2);
            _loc6_.x = _loc3_.posX;
            _loc6_.y = _loc3_.posY;
            _loc5_ = Point.distance(_loc7_,_loc6_);
            if(_loc5_ <= _loc4_ + 2 && !isPassedNode(_loc3_))
            {
               return _loc3_;
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
      
      public function getNodeByNodeId(param1:int) : VehicleNode
      {
         for each(var _loc2_:VehicleNode in nodeList)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPlayerInfo(param1:int) : PlayerVehicleInfo
      {
         return _playerList[param1];
      }
      
      public function getPointValue(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = int(mapTielsData[param1 + "_" + param2]);
         return _loc3_ > 0 && _loc3_ != 2 ? true : false;
      }
      
      public function getTeamMembers() : Array
      {
         var _loc1_:Array = [];
         if(!_selfVehicleInfo)
         {
            return _loc1_;
         }
         for each(var _loc2_:PlayerVehicleInfo in _playerList)
         {
            if(_loc2_.team == _selfVehicleInfo.team && _loc2_.playerId != _selfVehicleInfo.playerId)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("id",0x10 | 2);
         return _loc1_;
      }
      
      override public function getWalkable(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = int(mapTielsData[param1 + "_" + param2]);
         return _loc3_ > 0 && _loc3_ != 2 ? true : false;
      }
      
      public function hasNode(param1:VehicleNode) : Boolean
      {
         for each(var _loc2_:VehicleNode in _nodeList)
         {
            if(_loc2_.nodeId == param1.nodeId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isFriend(param1:int) : Boolean
      {
         if(!selfVehicleInfo)
         {
            return false;
         }
         return selfVehicleInfo.team == param1;
      }
      
      public function get nodeList() : Vector.<VehicleNode>
      {
         return _nodeList;
      }
      
      public function get playerList() : SimpleDictionary
      {
         return _playerList;
      }
      
      public function removeNode(param1:VehicleNode) : void
      {
         var _loc2_:int = _nodeList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _nodeList.splice(_loc2_,1);
            this.dispatchEvent(new VehicleEvent("REMOVE_NODE",param1));
         }
      }
      
      public function removePlayer(param1:int) : PlayerVehicleInfo
      {
         var _loc2_:PlayerVehicleInfo = _playerList[param1];
         if(_loc2_)
         {
            _playerList.del(param1);
            dispatchEvent(new VehicleEvent("remove_player",_loc2_));
         }
         return _loc2_;
      }
      
      public function get selfVehicleInfo() : PlayerVehicleInfo
      {
         return _selfVehicleInfo;
      }
      
      public function get skillBag() : VehicleSkillbag
      {
         return _skillBag;
      }
      
      public function startCountTime() : void
      {
         this.dispatchEvent(new VehicleEvent("START_COUNTTIME",this));
      }
      
      public function syncPlayerInfo() : void
      {
         this.dispatchEvent(new VehicleEvent("PLAYE_LIST_UPDATE",this));
      }
      
      public function syncScore() : void
      {
         this.dispatchEvent(new VehicleEvent("SCORE_CHANGE",this));
      }
      
      public function get teamChanelPlayerList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:PlayerVehicleInfo in _playerList)
         {
            if(_loc2_.team == selfVehicleInfo.team)
            {
               _loc1_.push(_loc2_.playerId);
            }
         }
         return _loc1_;
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
      
      private function isPassedNode(param1:VehicleNode) : Boolean
      {
         switch(param1.state - 1)
         {
            case 0:
               return true;
            default:
               return false;
         }
      }
      
      public function get remainsTime() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         if(startDate.time <= _loc2_.time && _loc2_.time < endDate.time)
         {
            _loc1_ = _remainsTime - (_loc2_.time - campaiganStartTime.time) / 1000;
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
         }
         return _loc1_;
      }
      
      private function initStartEndDate() : void
      {
         var _loc9_:Array = null;
         var _loc1_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc2_:String = null;
         var _loc7_:Array = null;
         var _loc3_:Date = null;
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("MatchOfVehicleTime");
         if(_loc4_)
         {
            _loc9_ = _loc4_.ConfigValue.split("|");
            for each(var _loc8_:String in _loc9_)
            {
               _loc1_ = _loc8_.split(",");
               _loc5_ = _loc1_[0];
               _loc6_ = _loc5_.split(":");
               startDate.time = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
               startDate.hours = parseInt(_loc6_[0]);
               startDate.minutes = parseInt(_loc6_[1]);
               startDate.seconds = 0;
               _loc2_ = _loc1_[1];
               _loc7_ = _loc2_.split(":");
               endDate.time = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
               endDate.hours = parseInt(_loc7_[0]);
               endDate.minutes = parseInt(_loc7_[1]);
               endDate.seconds = 0;
               _loc3_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
               if(startDate.time <= _loc3_.time && _loc3_.time < endDate.time)
               {
                  return;
               }
            }
         }
      }
      
      public function set remainsTime(param1:Number) : void
      {
         _remainsTime = param1;
         campaiganStartTime.time = endDate.time - param1 * 1000;
         dispatchEvent(new VehicleEvent("CAMPAIGN_TIME",this));
      }
      
      public function get riverTimeConst() : int
      {
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("revivalTime");
         var _loc1_:int = 30;
         if(_loc2_)
         {
            _loc1_ = parseInt(_loc2_.ConfigValue);
         }
         return _loc1_;
      }
   }
}

