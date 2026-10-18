package map.campaign.mediator.layer
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.internals.constant.NodeState;
   import map.internals.data.CampaignNode;
   import map.internals.view.hero.AvatarBaseView;
   import map.outercity.helper.mapview.MapViewHelper;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.utils.WorldBossHelper;
   
   public class ActivationMovieMediator implements IMediator, IEnterFrame
   {
      
      private var _disObject:Sprite;
      
      private var _playerLimit:Number = 100;
      
      private var _needPlayerLimit:Boolean = false;
      
      private var _model:CampaignMapModel;
      
      private var _controler:CampaignMapController;
      
      private var _walkLayer:Sprite;
      
      private var mapView:Sprite;
      
      private var _count:int;
      
      public function ActivationMovieMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _disObject = param1 as Sprite;
         _model = CampaignManager.instance.mapModel;
         _controler = CampaignManager.instance.controller;
         mapView = CampaignManager.instance.mapView;
         if(WorldBossHelper.checkPetLand(_model.mapId))
         {
            _needPlayerLimit = true;
            _playerLimit = 50;
         }
         if(mapView)
         {
            mapView.addEventListener("MOVE_SCENET_END",__moveSceneHandler);
         }
         NotificationManager.instance.addEventListener("CHECK_PLAYING",__moveSceneHandler);
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function unregister(param1:Object) : void
      {
         if(mapView)
         {
            mapView.removeEventListener("MOVE_SCENET_END",__moveSceneHandler);
         }
         NotificationManager.instance.removeEventListener("CHECK_PLAYING",__moveSceneHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         mapView = null;
         _model = null;
         _disObject = null;
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Rectangle = null;
         var _loc6_:Dictionary = null;
         var _loc5_:Object = null;
         if(!_model || Boolean(_model.exit))
         {
            return;
         }
         _count = _count + 1;
         if(_count > 25)
         {
            _count = 0;
            _loc1_ = _model.mapNodesData;
            _loc2_ = MapViewHelper.getCurrentMapRect(CampaignManager.instance.mapView);
            for each(var _loc3_:CampaignNode in _loc1_)
            {
               if(NodeState.displayState(_loc3_.info.state))
               {
                  checkNodePlaying(_loc3_.nodeView as Sprite,_loc2_,_loc3_);
               }
            }
            _loc6_ = _model.allUserArmy;
            for each(var _loc4_:CampaignArmy in _loc6_)
            {
               _loc5_ = _controler.getArmyView(_loc4_);
               checkArmyPlaying(_loc5_,_loc2_,_loc4_);
            }
         }
      }
      
      private function __moveSceneHandler(param1:Event) : void
      {
         var _loc8_:Object = null;
         var _loc7_:Object = null;
         var _loc5_:Boolean = false;
         var _loc2_:Array = _model.mapNodesData;
         var _loc3_:Rectangle = MapViewHelper.getCurrentMapRect(CampaignManager.instance.mapView);
         for each(var _loc4_:CampaignNode in _loc2_)
         {
            if(NodeState.displayState(_loc4_.info.state))
            {
               checkNodePlaying(_loc4_.nodeView as Sprite,_loc3_,_loc4_);
            }
         }
         _loc2_ = _model.staticMovies;
         for each(_loc4_ in _loc2_)
         {
            checkNodePlaying(_loc4_.nodeView as Sprite,_loc3_,_loc4_);
         }
         var _loc9_:Dictionary = _model.allUserArmy;
         for each(var _loc6_:CampaignArmy in _loc9_)
         {
            _loc8_ = _controler.getArmyView(_loc6_);
            if(_loc8_)
            {
               checkArmyPlaying(_loc8_,_loc3_,_loc6_);
            }
            else
            {
               _loc7_ = {
                  "x":_loc6_.curPosX * 20,
                  "y":_loc6_.curPosY * 20
               };
               _loc5_ = !getPlaying(_loc7_,_loc3_);
               if(_loc5_ && Boolean(_loc6_.online) && filterMap(_model.mapId))
               {
                  _model.moveToVisible(_loc6_);
               }
            }
         }
      }
      
      private function filterMap(param1:int) : Boolean
      {
         return WorldBossHelper.checkPvp(param1) || Boolean(WorldBossHelper.checkFlameTemple(param1)) || Boolean(WorldBossHelper.checkUnrealShooting(param1)) || Boolean(WorldBossHelper.checkIceFireTemple(param1)) || Boolean(WorldBossHelper.checkDuskArea(param1));
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
      
      private function checkArmyPlaying(param1:Object, param2:Rectangle, param3:CampaignArmy) : void
      {
         if(WorldBossHelper.checkGodsEvening(_model.mapId))
         {
            return;
         }
         if(!(param1 && param1 is AvatarBaseView))
         {
            return;
         }
         var _loc5_:AvatarBaseView = param1 as AvatarBaseView;
         if(!_loc5_)
         {
            return;
         }
         var _loc4_:Boolean = getPlaying(param1,param2);
         if(WorldBossHelper.checkPetLand(_model.mapId) || Boolean(WorldBossHelper.checkWorldBoss(_model.mapId)) || Boolean(WorldBossHelper.checkWedding(_model.mapId)) || Boolean(WorldBossHelper.checkConsortiaEmeDream(_model.mapId)) || Boolean(WorldBossHelper.checkForbiddenBoss(_model.mapId)) || Boolean(WorldBossHelper.checkDuskArea(_model.mapId)) || Boolean(WorldBossHelper.checkFlameTemple(_model.mapId)) || Boolean(WorldBossHelper.checkIceFireTemple(_model.mapId)))
         {
            if(SharedManager.instance.hideOthers && !_controler.checkNeedShowWhenHideOthers(param3))
            {
               _loc5_.isPlaying = false;
            }
            else
            {
               _loc5_.isPlaying = !_loc4_;
            }
         }
         else
         {
            _loc5_.isPlaying = !_loc4_;
         }
         if(_loc4_)
         {
            if(_loc5_.parent)
            {
               _loc5_.parent.removeChild(_loc5_);
            }
         }
         else if(!_loc5_.parent && param3.preParent)
         {
            param3.preParent.addChild(_loc5_);
         }
      }
      
      private function checkNodePlaying(param1:Sprite, param2:Rectangle, param3:CampaignNode) : void
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
         else if(!param1.parent && param3.preParent)
         {
            if(param3.info.types == 71 || param3.info.types == 81)
            {
               param3.preParent.addChildAt(param1,0);
            }
            else
            {
               param3.preParent.addChild(param1);
            }
         }
      }
   }
}

