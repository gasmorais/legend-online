package map.campaign.mediator.layer
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.CampaignMapView;
   import yishi.interfaces.IMediator;
   import yishi.utils.WorldBossHelper;
   
   public class WalkTargetMediator implements IMediator
   {
      
      private static const fogUpLayer:int = 1;
      
      private static const npcDownLayer:int = 2;
      
      private var _walkTarget:MovieClip;
      
      private var _curLayer:int;
      
      public function WalkTargetMediator()
      {
         super();
         _walkTarget = ComponentFactory.Instance.creatCustomObject("asset.campaign.WalkTargetEffectAsset");
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
      }
      
      public function register(param1:Object) : void
      {
         mapModel.addEventListener("LOCAL_UPDATE_FOG",__updateFogDataHandler);
         mapModel.addEventListener("SYN_FOG_DATA",__updateFogDataHandler);
         mapModel.addEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         mapModel.removeEventListener("LOCAL_UPDATE_FOG",__updateFogDataHandler);
         mapModel.removeEventListener("SYN_FOG_DATA",__updateFogDataHandler);
         mapModel.removeEventListener("UPDATE_WALK_TARGET",__updateWalkTargetHandler);
         if(_walkTarget)
         {
            _walkTarget.stop();
            if(_walkTarget.parent)
            {
               _walkTarget.parent.removeChild(_walkTarget);
            }
         }
         _walkTarget = null;
      }
      
      private function __updateFogDataHandler(param1:CampaignMapEvent) : void
      {
         if(WorldBossHelper.checkFogMap(mapModel.mapId))
         {
            return;
         }
         var _loc2_:Object = param1.data;
         setWalkTargetDepth(new Point(_loc2_.x,_loc2_.y));
      }
      
      private function __updateWalkTargetHandler(param1:CampaignMapEvent) : void
      {
         if(!_walkTarget)
         {
            return;
         }
         var _loc2_:Point = param1.data as Point;
         if(_loc2_)
         {
            _walkTarget.x = _loc2_.x;
            _walkTarget.y = _loc2_.y;
            if(_walkTarget)
            {
               _walkTarget.gotoAndPlay(1);
            }
            _walkTarget.visible = true;
            setWalkTargetDepth(_loc2_);
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
      
      private function setWalkTargetDepth(param1:Point) : void
      {
         var _loc2_:Boolean = false;
         if(WorldBossHelper.fogNoExits(mapModel.mapId))
         {
            _loc2_ = false;
         }
         else
         {
            _loc2_ = mapView.fogLayer ? mapView.fogLayer.checkFogEmpty(param1.x,param1.y) : false;
         }
         _loc2_ ? mapView.addChild(_walkTarget) : mapView.mainBuidingLayer.centerLayer.addChild(_walkTarget);
      }
      
      private function get mapView() : CampaignMapView
      {
         return CampaignManager.instance.mapView;
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
   }
}

