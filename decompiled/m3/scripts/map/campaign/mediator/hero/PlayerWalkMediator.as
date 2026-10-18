package map.campaign.mediator.hero
{
   import com.pickgliss.utils.SoundManager;
   import events.ObjectsEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import managers.TreasureMapManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.view.physics.CampaignArmyView;
   import map.net.MapSocketOuterManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   
   public class PlayerWalkMediator implements IMediator
   {
      
      private var _target:CampaignArmyView;
      
      private var _data:CampaignArmy;
      
      private var _sendPosRate:int;
      
      private var _lastTime:int = 0;
      
      private var _nextPoint:Point;
      
      private var _walkPath:Array;
      
      public function PlayerWalkMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as CampaignArmyView;
         _data = _target.data;
         _target.addEventListener("walkOver",__walkOverHandler);
         _target.addEventListener("WALK_NEXT",__walkNextHandler);
         _target.info.addEventListener("updatePaths",__updatePathHandler);
         NotificationManager.instance.addEventListener("sendCampaignArrive",__playerArriveHandler);
         _sendPosRate = 7;
         _walkPath = [];
         var _loc2_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkWorldBoss(_loc2_) || Boolean(WorldBossHelper.checkPvp(_loc2_)) || Boolean(WorldBossHelper.checkForbiddenBoss(_loc2_)))
         {
            _sendPosRate = 14;
         }
         else if(WorldBossHelper.checkActiveVehicle(_loc2_))
         {
            _sendPosRate = 2;
         }
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("sendCampaignArrive",__playerArriveHandler);
         if(_target)
         {
            _target.info.removeEventListener("updatePaths",__updatePathHandler);
            _target.removeEventListener("walkOver",__walkOverHandler);
            _target.removeEventListener("WALK_NEXT",__walkNextHandler);
         }
         _target = null;
         _data = null;
      }
      
      private function __updatePathHandler(param1:Event) : void
      {
         if(_target.info.pathInfo && _target.info.pathInfo.length > 0)
         {
            _nextPoint = _target.info.pathInfo[0];
         }
         else
         {
            _nextPoint = null;
         }
      }
      
      private function __playerArriveHandler(param1:Event) : void
      {
         sendPath();
      }
      
      private function sendPath() : void
      {
         if(_walkPath.length > 0)
         {
            if(WorldBossHelper.checkActiveVehicle(mapModel.mapId))
            {
               CampaignSocketOutManager.instance.sendSnowBallActiveVehicleArmyMove(_target.data.userId,_walkPath,_data.baseHero.serviceName);
            }
            else
            {
               MapSocketOuterManager.sendCampaignArmyMove(_target.data.id,_walkPath,_target.data.mapId);
            }
            _walkPath.length = 0;
         }
      }
      
      private function __walkNextHandler(param1:ObjectsEvent) : void
      {
         var _loc2_:Point = param1.data.point;
         _nextPoint = _loc2_.clone();
         pushPathStep();
         if(_walkPath.length >= _sendPosRate)
         {
            sendPath();
         }
         if(WorldBossHelper.checkMonopoly(mapModel.mapId))
         {
            return;
         }
         if(!WorldBossHelper.checkPetLand(mapModel.mapId))
         {
            if(CampaignArmyViewHelper.selfArmyEvent(_data.userId,_target.aiInfo,_target,_loc2_,false,_data.isDie))
            {
               _target.aiInfo.pathInfo = [];
               return;
            }
            mapModel.updateFog(_target.x,_target.y,4);
         }
      }
      
      private function pushPathStep() : void
      {
         var _loc3_:Point = null;
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         if(_nextPoint)
         {
            if(_walkPath.length > 0)
            {
               _loc3_ = _walkPath[_walkPath.length - 1];
               if(Point.distance(_loc3_,_nextPoint) >= 2)
               {
               }
            }
            if(_walkPath.length >= 2)
            {
               _loc1_ = _walkPath[_walkPath.length - 1];
               _loc2_ = _walkPath[_walkPath.length - 2];
               if(isNeighborPoint(_nextPoint,_loc1_) && isNeighborPoint(_nextPoint,_loc2_))
               {
                  _walkPath.pop();
               }
            }
            _walkPath.push(_nextPoint);
            _nextPoint = null;
         }
      }
      
      private function isNeighborPoint(param1:Point, param2:Point) : Boolean
      {
         var _loc3_:int = Math.abs(param1.x - param2.x);
         var _loc4_:int = Math.abs(param1.y - param2.y);
         return _loc3_ <= 1 && _loc4_ <= 1;
      }
      
      private function copyArray(param1:Array, param2:int, param3:int) : Array
      {
         var _loc6_:int = 0;
         if(param2 > 0)
         {
            param2 -= 1;
         }
         var _loc5_:int = param2 + param3;
         if(_loc5_ >= param1.length)
         {
            _loc5_ = int(param1.length);
         }
         var _loc4_:Array = [];
         _loc6_ = param2;
         while(_loc6_ < _loc5_)
         {
            _loc4_.push(param1[_loc6_]);
            _loc6_++;
         }
         return _loc4_;
      }
      
      private function __walkOverHandler(param1:ObjectsEvent) : void
      {
         pushPathStep();
         sendPath();
         CampaignManager.instance.mapModel.updateWalkTarget(null);
         if(_target.aiInfo.pathInfo && _target.aiInfo.pathInfo.length > 0)
         {
            SoundManager.instance.play("001");
            if(WorldBossHelper.checkPetLand(mapModel.mapId) && Boolean(TreasureMapManager.instance.checkReinforce()))
            {
               return;
            }
            if(CampaignArmyViewHelper.selfArmyToEnd(_target.aiInfo,_target))
            {
               return;
            }
            if(WorldBossHelper.checkSvs(mapModel.mapId))
            {
               CampaignArmyViewHelper.checkSvsArmy();
            }
         }
         mapModel.updateFog(_target.x,_target.y,4);
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      protected function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
   }
}

