package map.campaign.mediator.hero
{
   import events.ObjectsEvent;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.data.CampaignNode;
   import map.internals.view.hero.helper.HeroAvatarViewHelper;
   import yishi.events.AiEvents;
   import yishi.interfaces.IMediator;
   
   public class FollowTargetMediator implements IMediator
   {
      
      private static const initMinIndex:int = 100000;
      
      private var _curNpc:NpcAvatarView;
      
      private var _followTarge:Object;
      
      private var _minIndex:int;
      
      private var _curPath:Array;
      
      public function FollowTargetMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         var _loc2_:CampaignMapView = CampaignManager.instance.mapView;
         if(!_loc2_ || !_loc2_.walkLayer)
         {
            return;
         }
         _curNpc = param1 as NpcAvatarView;
         if(!_curNpc)
         {
            return;
         }
         _minIndex = 100000;
         var _loc4_:int = int((_curNpc.nodeInfo as CampaignNode).followTarget);
         var _loc6_:String = (_curNpc.nodeInfo as CampaignNode).followTargetServiceName;
         var _loc3_:CampaignArmy = CampaignManager.instance.mapModel.getUserArmyByArmyId(_loc4_,_loc6_);
         var _loc5_:Object = CampaignManager.instance.controller.getArmyView(_loc3_);
         if(_loc3_)
         {
            _followTarge = _loc5_;
         }
         if(!_followTarge || !_followTarge.aiInfo)
         {
            return;
         }
         _followTarge.aiInfo.addEventListener("updatePaths",__followTargerHandler);
         _followTarge.aiInfo.addEventListener("nextPoint",__nextPointHandler);
         _followTarge.addEventListener("walkOver",__targetWalkOverHandler);
         _curNpc.addEventListener("walkOver",__walkOverHandler);
         setNpcAngle(false);
         if(_followTarge.aiInfo.pathInfo)
         {
            _curPath = _followTarge.aiInfo.pathInfo;
            _minIndex = getRecentIndex(_curPath);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_followTarge)
         {
            if(_followTarge.aiInfo)
            {
               _followTarge.aiInfo.removeEventListener("updatePaths",__followTargerHandler);
               _followTarge.aiInfo.removeEventListener("nextPoint",__nextPointHandler);
            }
            _followTarge.removeEventListener("walkOver",__targetWalkOverHandler);
         }
         _curNpc.removeEventListener("walkOver",__walkOverHandler);
      }
      
      private function __followTargerHandler(param1:AiEvents) : void
      {
         _curPath = param1.data as Array;
         if(!_curPath)
         {
            return;
         }
         _minIndex = getRecentIndex(_curPath);
      }
      
      private function getRecentIndex(param1:Array) : int
      {
         var _loc7_:int = 0;
         var _loc3_:Point = null;
         var _loc5_:int = 0;
         var _loc2_:Point = new Point(int(_curNpc.x / 20),int(_curNpc.y / 20));
         var _loc4_:int = 100000;
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc3_ = param1[_loc7_];
            _loc5_ = Point.distance(_loc3_,_loc2_);
            if(_loc5_ < _loc4_)
            {
               _loc4_ = _loc5_;
               _loc6_ = _loc7_;
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      private function __nextPointHandler(param1:AiEvents) : void
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc2_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:Point = null;
         var _loc5_:Array = null;
         var _loc6_:int = param1.data as int;
         if(_loc6_ > _minIndex && _curPath)
         {
            _loc3_ = new Point(_curNpc.x,_curNpc.y);
            _loc4_ = new Point(_followTarge.x,_followTarge.y);
            if(Point.distance(_loc4_,_loc3_) < 40)
            {
               setNpcAngle();
               return;
            }
            _loc2_ = [];
            _loc7_ = _minIndex;
            while(_loc7_ < _curPath.length)
            {
               _loc2_.push(new Point(_curPath[_loc7_].x,_curPath[_loc7_].y));
               _loc7_++;
            }
            if(_loc2_.length > 0)
            {
               _loc8_ = new Point(_loc2_[0].x,_loc2_[0].y);
               _loc5_ = CampaignManager.instance.controller.searchPath(new Point(int(_loc3_.x / 20),int(_loc3_.y / 20)),_loc8_);
               if(!_loc5_)
               {
                  _loc5_ = [];
               }
               _loc5_ = _loc5_.concat(_loc2_);
               if(!_loc5_ || _loc5_.length < 1)
               {
                  return;
               }
               _curNpc.aiInfo.pathInfo = _loc5_;
               _curNpc.aiInfo.moveState = 4;
            }
            _minIndex = 100000;
         }
         else if(_minIndex != 100000 && _curPath)
         {
            setNpcAngle();
         }
      }
      
      private function __targetWalkOverHandler(param1:ObjectsEvent) : void
      {
         var _loc8_:int = 0;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc2_:int = 0;
         if(!_followTarge || !_curNpc)
         {
            return;
         }
         var _loc3_:Point = new Point(int(_followTarge.x / 20),int(_followTarge.y / 20));
         var _loc4_:Array = _curNpc.aiInfo.pathInfo.concat();
         var _loc7_:int;
         _loc8_ = _loc7_ = _loc4_.length - 1;
         while(_loc8_ > 0)
         {
            if(_loc8_ < _curNpc.aiInfo.walkIndex)
            {
               _loc4_.splice(_loc8_,1);
            }
            else
            {
               _loc5_ = _loc4_[_loc8_];
               _loc6_ = _loc4_[_loc8_ - 1];
               if(!(!_loc5_ || !_loc6_))
               {
                  _loc2_ = Point.distance(_loc3_,_loc5_);
                  if(_loc2_ > Point.distance(_loc3_,_loc6_))
                  {
                     _loc4_.pop();
                  }
                  else if(_loc2_ < 2)
                  {
                     _loc4_.pop();
                  }
               }
            }
            _loc8_--;
         }
         _curNpc.aiInfo.pathInfo = _loc4_;
      }
      
      private function __walkOverHandler(param1:ObjectsEvent) : void
      {
         setNpcAngle();
      }
      
      private function setNpcAngle(param1:Boolean = true) : void
      {
         if(!_followTarge || !_curNpc)
         {
            return;
         }
         if(param1)
         {
            _curNpc.aiInfo.pathInfo = [];
         }
         var _loc2_:Number = HeroAvatarViewHelper.twoPointAngle(_followTarge.x,_followTarge.y,_curNpc.x,_curNpc.y);
         _curNpc.avatarView.angle = _loc2_;
      }
   }
}

