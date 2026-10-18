package map.space.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.constant.NodeState;
   import map.internals.data.SpaceNode;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.data.SpaceArmy;
   import map.space.helper.mapview.SpaceMapViewHelper;
   import map.space.view.SpaceSceneMapView;
   import map.space.view.physics.SpaceNpcView;
   import map.space.view.physics.SpacePhysicsView;
   import stage3drender.avatar.SpaceNpc;
   import stage3drender.nodes.SpacePhysicsNode;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.SharedManager;
   
   public class SpaceActivationMovieMediator implements IMediator, IEnterFrame
   {
      
      private var _target:Object;
      
      private var _mapView:SpaceSceneMapView;
      
      private var _model:SpaceModel;
      
      private var _count:int;
      
      private var nodeView:Object;
      
      public function SpaceActivationMovieMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         _mapView = SpaceManager.instance.mapView;
         _model = SpaceManager.instance.model;
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
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Rectangle = null;
         var _loc5_:Object = null;
         _count = _count + 1;
         if(_count > 25)
         {
            _count = 0;
            _loc1_ = SpaceManager.instance.model.mapNodesData;
            _loc2_ = SpaceMapViewHelper.getCurrentMapRect(_mapView);
            for each(var _loc3_:SpaceNode in _loc1_)
            {
               if(NodeState.displayState(_loc3_.info.state))
               {
                  nodeView = SpaceManager.instance.controller.getBuildView(_loc3_);
                  if(!nodeView)
                  {
                     nodeView = SpaceManager.instance.controller.getNpcView(_loc3_);
                  }
                  checkNodePlaying(nodeView,_loc2_,_loc3_);
               }
            }
            for each(var _loc4_:SpaceArmy in _model.allArmyDict)
            {
               _loc5_ = SpaceManager.instance.controller.getArmyView(_loc4_);
               checkArmyPlaying(_loc5_,_loc2_,_loc4_);
            }
         }
      }
      
      private function __moveSceneHandler(param1:CampaignMapEvent) : void
      {
         var _loc5_:Object = null;
         var _loc7_:Object = null;
         var _loc2_:Array = _model.mapNodesData;
         var _loc3_:Rectangle = SpaceMapViewHelper.getCurrentMapRect(_mapView);
         for each(var _loc4_:SpaceNode in _loc2_)
         {
            if(NodeState.displayState(_loc4_.info.state))
            {
               _loc5_ = SpaceManager.instance.controller.getBuildView(_loc4_);
               if(!_loc5_)
               {
                  _loc5_ = SpaceManager.instance.controller.getNpcView(_loc4_);
               }
               checkNodePlaying(_loc5_,_loc3_,_loc4_);
            }
         }
         _loc2_ = _model.staticMovies;
         for each(_loc4_ in _loc2_)
         {
            _loc5_ = SpaceManager.instance.controller.getBuildView(_loc4_);
         }
         var _loc8_:Dictionary = _model.allArmyDict;
         for each(var _loc6_:SpaceArmy in _loc8_)
         {
            _loc7_ = SpaceManager.instance.controller.getArmyView(_loc6_);
            checkArmyPlaying(_loc7_,_loc3_,_loc6_);
         }
      }
      
      private function checkArmyPlaying(param1:Object, param2:Rectangle, param3:SpaceArmy) : void
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
      
      private function checkNodePlaying(param1:Object, param2:Rectangle, param3:SpaceNode) : void
      {
         if(!param1 || !param1.hasOwnProperty("isPlaying"))
         {
            return;
         }
         var _loc4_:Boolean = getPlaying(param1,param2);
         param1["isPlaying"] = !_loc4_;
         if(_loc4_)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
         else if(!param1.parent)
         {
            if(param3.info.types == 71 || param3.info.types == 81)
            {
               if(param1 is SpaceNpcView || param1 is SpaceNpc)
               {
                  SpaceManager.instance.controller.walkLayer.addChildAt(param1,0);
               }
               else if(param1 is SpacePhysicsView || param1 is SpacePhysicsNode)
               {
                  SpaceManager.instance.controller.buildLayer.center.addChildAt(param1,0);
               }
            }
            else if(param1 is SpaceNpcView || param1 is SpaceNpc)
            {
               SpaceManager.instance.controller.walkLayer.addChild(param1);
            }
            else if(param1 is SpacePhysicsView || param1 is SpacePhysicsNode)
            {
               SpaceManager.instance.controller.buildLayer.center.addChild(param1);
            }
         }
      }
      
      private function checkStaticMoviesNodePlaying(param1:Object, param2:Rectangle, param3:SpaceNode) : void
      {
         if(!param1 || !param1.hasOwnProperty("isPlaying"))
         {
            return;
         }
         var _loc4_:Boolean = getStaticMoviesPlaying(param1,param2);
         param1["isPlaying"] = !_loc4_;
         if(_loc4_)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
         else if(!param1.parent)
         {
            if(param3.info.types == 71 || param3.info.types == 81)
            {
               if(param3.layer == 0)
               {
                  SpaceManager.instance.controller.buildLayer.bottom.addChildAt(param1,0);
               }
               else if(param3.layer == 2)
               {
                  SpaceManager.instance.controller.buildLayer.top.addChildAt(param1,0);
               }
            }
            else if(param3.layer == 0)
            {
               SpaceManager.instance.controller.buildLayer.bottom.addChild(param1);
            }
            else if(param3.layer == 2)
            {
               SpaceManager.instance.controller.buildLayer.top.addChild(param1);
            }
         }
      }
      
      private function getStaticMoviesPlaying(param1:Object, param2:Rectangle) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 100;
         var _loc5_:int = 100;
         if(param1.hasOwnProperty("getMovie") && param1["getMovie"])
         {
            _loc4_ = int(param1["getMovie"].width);
            _loc5_ = int(param1["getMovie"].height);
         }
         if(param1.x < param2.x - StageReferance.gameStageWidth / 2 - _loc4_ - 100)
         {
            _loc3_ = true;
         }
         else if(param1.x > param2.x + StageReferance.gameStageWidth / 2 + 100)
         {
            _loc3_ = true;
         }
         else if(param1.y < param2.y - StageReferance.stageHeight / 2 - _loc5_ - 100)
         {
            _loc3_ = true;
         }
         else if(param1.y > param2.y + StageReferance.stageHeight / 2 + 100)
         {
            _loc3_ = true;
         }
         return _loc3_;
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
   }
}

