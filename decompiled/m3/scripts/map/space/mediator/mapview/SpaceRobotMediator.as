package map.space.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.SpaceNode;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.data.SpaceArmy;
   import map.space.helper.mapview.SpaceMapViewHelper;
   import map.space.view.SpaceSceneMapView;
   import map.space.view.layer.SpaceWalkLayer;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.SharedManager;
   import yishi.manager.SpaceTemplateManager;
   
   public class SpaceRobotMediator implements IMediator, IEnterFrame
   {
      
      public static const ROBOT_CHECK_TICK:int = 30000;
      
      private var _target:Sprite;
      
      private var _mapView:SpaceSceneMapView;
      
      private var _model:SpaceModel;
      
      private var _walkLayer:SpaceWalkLayer;
      
      private var _robots:Array;
      
      private var _visibleRobots:Array;
      
      private var _inited:Boolean = false;
      
      private var _nodeInfos:Array;
      
      private var _count:int;
      
      private var _lastTime:int;
      
      private var _checkTime:int;
      
      public function SpaceRobotMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as Sprite;
         _mapView = SpaceManager.instance.mapView;
         _model = SpaceManager.instance.model;
         _walkLayer = _mapView.walkLayer;
         _visibleRobots = [];
         _robots = [];
         _nodeInfos = [];
         _nodeInfos.push(_model.getMapNodeById(1));
         _nodeInfos.push(_model.getMapNodeById(2));
         _nodeInfos.push(_model.getMapNodeById(6));
         if(_mapView)
         {
            _mapView.addEventListener("MOVE_SCENET_END",__moveSceneHandler);
         }
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function unregister(param1:Object) : void
      {
         if(_mapView)
         {
            _mapView.removeEventListener("MOVE_SCENET_END",__moveSceneHandler);
         }
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _mapView = null;
         _model = null;
         _walkLayer = null;
         _visibleRobots = null;
         _robots = null;
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Rectangle = null;
         var _loc4_:* = null;
         var _loc2_:Boolean = false;
         var _loc3_:Object = null;
         if(!_inited && Boolean(SpaceTemplateManager.instance.robotInited))
         {
            _robots = SpaceTemplateManager.instance.robots;
            _inited = true;
         }
         _count = _count + 1;
         if(_count > 25)
         {
            _count = 0;
            _loc1_ = SpaceMapViewHelper.getCurrentMapRect(_mapView);
            if(_model.selfArmy)
            {
               for each(_loc4_ in _visibleRobots)
               {
                  _loc3_ = CampaignManager.instance.controller.getArmyView(_loc4_);
                  if(!(!_loc4_.isAdded || !_loc3_))
                  {
                     _loc2_ = getPlaying(_loc3_,_loc1_);
                     if(_loc2_)
                     {
                        _model.moveToUnVisible(_loc4_);
                     }
                  }
               }
            }
         }
         addRobot();
      }
      
      private function __moveSceneHandler(param1:CampaignMapEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         var _loc2_:Rectangle = SpaceMapViewHelper.getCurrentMapRect(_mapView);
         if(_model.selfArmy)
         {
            for each(_loc5_ in _visibleRobots)
            {
               _loc4_ = CampaignManager.instance.controller.getArmyView(_loc5_);
               if(!(!_loc5_.isAdded || !_loc4_))
               {
                  _loc3_ = getPlaying(_loc4_,_loc2_);
                  if(_loc3_)
                  {
                     _model.moveToUnVisible(_loc5_);
                  }
               }
            }
         }
      }
      
      private function addRobot() : void
      {
         var _loc4_:int = 0;
         var _loc6_:SpaceArmy = null;
         var _loc2_:Boolean = false;
         var _loc1_:Rectangle = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         _checkTime = getTimer();
         if(_checkTime - _lastTime > 30000)
         {
            _loc1_ = SpaceMapViewHelper.getCurrentMapRect(_mapView);
            _loc2_ = selfOutOfRectTest();
            if(_loc2_)
            {
               return;
            }
            if(_inited && _robots.length > 0 && _walkLayer.needRobotCount > 0)
            {
               _loc3_ = 0;
               _loc5_ = 0;
               while(_loc5_ < _robots.length)
               {
                  _loc6_ = _robots[_loc5_];
                  if(_loc6_)
                  {
                     if(!_loc6_.isAdded)
                     {
                        if(_loc3_ <= _walkLayer.needRobotCount)
                        {
                           if(_visibleRobots.indexOf(_loc6_) == -1)
                           {
                              _loc2_ = robotOutOfRectTest(_loc6_,_loc1_);
                              if(!_loc2_)
                              {
                                 _model.moveToVisible(_loc6_);
                                 _visibleRobots.push(_loc6_);
                                 _loc3_++;
                              }
                           }
                        }
                     }
                  }
                  _loc5_++;
               }
            }
            _lastTime = _checkTime;
         }
      }
      
      private function checkArmyPlaying(param1:Sprite, param2:Rectangle, param3:SpaceArmy) : void
      {
         if(!param1 || !param1.hasOwnProperty("isPlaying"))
         {
            return;
         }
         var _loc4_:Boolean = getPlaying(param1,param2);
         if(!SharedManager.instance.hideOthers)
         {
            param1["isPlaying"] = !_loc4_;
         }
         if(_loc4_)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
         else if(!param1.parent)
         {
            SpaceManager.instance.controller.walkLayer.addChild(param1);
         }
      }
      
      private function selfOutOfRectTest() : Boolean
      {
         var _loc2_:SpaceNode = null;
         var _loc1_:int = 0;
         var _loc3_:Object = SpaceManager.instance.controller.getArmyView(_model.selfArmy);
         if(!_loc3_)
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < _nodeInfos.length)
         {
            _loc2_ = _nodeInfos[_loc1_] as SpaceNode;
            if(Math.abs(_loc3_.x - _loc2_.x) <= StageReferance.gameStageWidth / 2 && Math.abs(_loc3_.y - _loc2_.y) <= StageReferance.gameStageHeight / 2)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function getPlaying(param1:Object, param2:Rectangle) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1.x < param2.x - StageReferance.gameStageWidth / 2 - param1.width - 100)
         {
            _loc3_ = true;
         }
         else if(param1.x > param2.x + StageReferance.gameStageWidth / 2 + 100)
         {
            _loc3_ = true;
         }
         else if(param1.y < param2.y - StageReferance.stageHeight / 2 - param1.height - 100)
         {
            _loc3_ = true;
         }
         else if(param1.y > param2.y + StageReferance.stageHeight / 2 + 100)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function robotOutOfRectTest(param1:SpaceArmy, param2:Rectangle) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1.curPosX * 20 < param2.x - StageReferance.gameStageWidth / 2 - 100)
         {
            _loc3_ = true;
         }
         else if(param1.curPosX * 20 > param2.x + StageReferance.gameStageWidth / 2 + 100)
         {
            _loc3_ = true;
         }
         else if(param1.curPosY * 20 < param2.y - StageReferance.stageHeight / 2 - 100)
         {
            _loc3_ = true;
         }
         else if(param1.curPosY * 20 > param2.y + StageReferance.stageHeight / 2 + 100)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
   }
}

