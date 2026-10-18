package map.space.mediator.layer
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import map.campaign.event.CampaignMapEvent;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.view.SpaceSceneMapView;
   import stage3drender.nodes.Stage3dMoviel;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import yishi.interfaces.IMediator;
   
   public class SpaceWalkTargetMediator implements IMediator
   {
      
      private static const fogUpLayer:int = 1;
      
      private static const npcDownLayer:int = 2;
      
      private var _target:Object;
      
      private var _walkTarget:Object;
      
      private var _curLayer:int;
      
      public function SpaceWalkTargetMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         _walkTarget = SpaceManager.instance.controller.walkTarget;
         model.addEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         model.removeEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
      }
      
      private function __updateWalkTargetHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:Point = param1.data as Point;
         if(_loc2_)
         {
            _walkTarget.x = _loc2_.x;
            _walkTarget.y = _loc2_.y;
            if(_walkTarget is MovieClip)
            {
               _target.addChild(_walkTarget);
            }
            else if(_walkTarget is Stage3dMoviel)
            {
               _target.addChild(_walkTarget);
               Starling.current.juggler.add(_walkTarget as IAnimatable);
            }
         }
         else
         {
            if(_walkTarget.parent)
            {
               _walkTarget.parent.removeChild(_walkTarget);
            }
            if(_walkTarget is Stage3dMoviel)
            {
               Starling.current.juggler.remove(_walkTarget as IAnimatable);
            }
         }
      }
      
      private function setWalkTargetDepth(param1:Point) : void
      {
      }
      
      private function get mapView() : SpaceSceneMapView
      {
         return SpaceManager.instance.mapView;
      }
      
      private function get model() : SpaceModel
      {
         return SpaceManager.instance.model;
      }
   }
}

