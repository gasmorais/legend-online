package crisis.ui
{
   import crisis.ui.item.PlaneCrisisPointItem;
   import events.ObjectsEvent;
   import flash.geom.Point;
   import mvc.module.crisis.PlaneCrisisModel;
   import yishi.events.AiEvents;
   import yishi.interfaces.IMediator;
   import yishi.manager.PlaneCrisisManager;
   
   public class PlaneCrisisWarkMediator implements IMediator
   {
      
      private var _target:PlaneCrisisArmyView;
      
      private var _walkPath:Array;
      
      private var _nextPoint:Point;
      
      public function PlaneCrisisWarkMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as PlaneCrisisArmyView;
         _target.aiInfo.addEventListener("walkOver",__walkOverHandler);
         _target.aiInfo.addEventListener("WALK_NEXT",__walkNextHandler);
         _target.aiInfo.addEventListener("updatePaths",__updatePathHandler);
         _walkPath = [];
      }
      
      private function __updatePathHandler(param1:AiEvents) : void
      {
         if(_target.aiInfo.pathInfo && _target.aiInfo.pathInfo.length > 0)
         {
            _nextPoint = _target.aiInfo.pathInfo[0];
            _target.visible = true;
         }
         else
         {
            _nextPoint = null;
         }
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
      }
      
      private function __walkOverHandler(param1:ObjectsEvent) : void
      {
         var _loc2_:PlaneCrisisPointItem = null;
         pushPathStep();
         if(_target.aiInfo.pathInfo && _target.aiInfo.pathInfo.length > 0)
         {
            _loc2_ = model.nodeItemDic[_target.data.standNodeId];
            _target.visible = _loc2_.isCanShowAvater;
         }
      }
      
      private function get model() : PlaneCrisisModel
      {
         return PlaneCrisisManager.Instance.model;
      }
      
      private function __walkNextHandler(param1:ObjectsEvent) : void
      {
         var _loc2_:Point = param1.data.point;
         _nextPoint = _loc2_.clone();
         pushPathStep();
      }
      
      private function pushPathStep() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         if(!_nextPoint)
         {
            return;
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
   }
}

