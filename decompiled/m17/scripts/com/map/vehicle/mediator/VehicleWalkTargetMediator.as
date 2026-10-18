package com.map.vehicle.mediator
{
   import com.map.vehicle.events.VehicleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   
   public class VehicleWalkTargetMediator implements IMediator
   {
      
      private var _walkTarget:MovieClip;
      
      private var _target:Sprite;
      
      public function VehicleWalkTargetMediator()
      {
         super();
         _walkTarget = ComponentFactory.Instance.creatCustomObject("asset.campaign.WalkTargetEffectAsset");
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
         _walkTarget.stop();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as Sprite;
         NotificationManager.instance.addEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
      }
      
      private function __updateWalkTargetHandler(param1:VehicleEvent) : void
      {
         var _loc2_:Point = param1.data as Point;
         if(_loc2_)
         {
            _walkTarget.x = _loc2_.x;
            _walkTarget.y = _loc2_.y;
            _walkTarget.gotoAndPlay(1);
            _walkTarget.visible = true;
            _target.addChild(_walkTarget);
         }
         else
         {
            _walkTarget.visible = false;
            _walkTarget.stop();
            if(_walkTarget.parent)
            {
               _walkTarget.parent.removeChild(_walkTarget);
            }
         }
      }
   }
}

