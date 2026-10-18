package gamehall.room.mediator
{
   import com.pickgliss.utils.SoundManager;
   import events.ObjectsEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallArmy;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.AiEvents;
   import yishi.interfaces.IMediator;
   import yishi.manager.PlayerManager;
   import yzhkof.debug.log;
   
   public class GameHallPlayerWalkMediator implements IMediator
   {
      
      private var _target:Object;
      
      private var _data:GameHallArmy;
      
      private var _model:GameHallModel;
      
      private var _sendPosRate:int;
      
      private var _nextPoint:Point;
      
      private var _lastTime:int = 0;
      
      private var _walkPath:Array;
      
      public function GameHallPlayerWalkMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         _data = _target.data;
         _model = GameHallManager.instance.model;
         _target.aiInfo.addEventListener("walkOver",__walkOverHandler);
         _target.aiInfo.addEventListener("WALK_NEXT",__walkNextHandler);
         _target.aiInfo.addEventListener("updatePaths",__updatePathHandler);
         _sendPosRate = 7;
         _walkPath = [];
      }
      
      public function unregister(param1:Object) : void
      {
         if(_target && _target.aiInfo)
         {
            _target.aiInfo.removeEventListener("updatePaths",__updatePathHandler);
            _target.aiInfo.removeEventListener("walkOver",__walkOverHandler);
            _target.aiInfo.removeEventListener("WALK_NEXT",__walkNextHandler);
         }
         _target = null;
         _data = null;
         _model = null;
      }
      
      private function __updatePathHandler(param1:AiEvents) : void
      {
         if(_target.aiInfo.pathInfo && _target.aiInfo.pathInfo.length > 0)
         {
            _nextPoint = _target.aiInfo.pathInfo[0];
         }
         else
         {
            _nextPoint = null;
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
      }
      
      private function pushPathStep() : void
      {
         var _loc3_:Point = null;
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         if(!_nextPoint)
         {
            return;
         }
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
      
      private function isNeighborPoint(param1:Point, param2:Point) : Boolean
      {
         var _loc3_:int = Math.abs(param1.x - param2.x);
         var _loc4_:int = Math.abs(param1.y - param2.y);
         return _loc3_ <= 1 && _loc4_ <= 1;
      }
      
      private function sendPath() : void
      {
         var _loc1_:String = "";
         for each(var _loc2_:Point in _walkPath)
         {
            _loc1_ += _loc2_.x + "_" + _loc2_.y + ", ";
         }
         var _loc3_:int = getTimer();
         var _loc4_:int = _loc3_ - _lastTime;
         _lastTime = _loc3_;
         log("",_loc1_ + "::::time=" + _loc4_);
         if(_walkPath.length > 0)
         {
            GameHallManager.instance.teamMove(_walkPath);
            _walkPath.length = 0;
         }
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
         _model.updateWalkTarget(null);
         if(_target.aiInfo.pathInfo && _target.aiInfo.pathInfo.length > 0)
         {
            SoundManager.instance.play("001");
         }
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

