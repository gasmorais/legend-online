package com.map.vehicle
{
   import chat.ChatSocketOutManager;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.mediator.MapCameraMediator;
   import com.map.vehicle.mediator.VehicleUIMediator;
   import com.map.vehicle.mediator.VehicleWalkTargetMediator;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.map.vehicle.objects.TankAvatarView;
   import com.map.vehicle.utils.WalkRectScanUtils;
   import com.road.mapengine.ai.astar.AIManager;
   import com.road.mapengine.bitmap.EngineManager;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.campaign.preload.PreCampaignData;
   import map.internals.MapData;
   import map.internals.library.MapElmsLibrary;
   import ui.maintoolbar.MainToolBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.scene.BaseSceneView;
   import yishi.view.community.LoadingSceneView;
   
   public class VehicleSceneController extends BaseSceneView
   {
      
      private var _campaignSendTimeId:int;
      
      private var _logicWorld:VehicleView;
      
      private var _model:VehicleModel;
      
      private var _preLoad:PreCampaignData;
      
      private var _preLoadingOver:Boolean;
      
      private var _rectScanUtils:WalkRectScanUtils;
      
      private var key:String;
      
      public function VehicleSceneController()
      {
         super();
         VGlobal.scene = this;
      }
      
      override public function get SceneName() : String
      {
         return "VEHICLE";
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         AIManager.instance.data = _model;
         ChatSocketOutManager.sceneChat = _model;
         var _loc3_:Array = [MapCameraMediator,VehicleWalkTargetMediator,VehicleUIMediator];
         key = MediatorMananger.instance.registerMediatorList(_loc3_,this,"aaaa");
         _logicWorld = new VehicleView(this);
         VGlobal.logicWorld = _logicWorld;
         _logicWorld.model = _model;
         EngineManager.instance.setup(_logicWorld);
         _rectScanUtils = new WalkRectScanUtils();
         KeyBoardRegister.instance.vehicleFlag = true;
         NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",6);
      }
      
      override public function enterOver() : void
      {
         MainToolBar.instance.poptipButtonVisible = false;
         MainToolBar.instance.hide();
         TopToolsBar.instance.hide();
         TaskTraceBar.instance.hide();
         VehicleChatController.getInstance().start();
      }
      
      public function getWalkable(param1:int, param2:int) : Boolean
      {
         return _model.getPointValue(param1,param2);
      }
      
      override public function leaving() : void
      {
         KeyBoardRegister.instance.vehicleFlag = false;
         MainToolBar.instance.poptipButtonVisible = true;
         MediatorMananger.instance.unregisterMediatorList(key,this);
         EngineManager.instance.dispose();
         _logicWorld.dispose();
         VehicleChatController.getInstance().dispose();
         SkillEffectFactory.instance.dispose();
         VehicleSocketManager.instance.dispose();
         MapElmsLibrary.instance.unLock();
         _model = null;
         _logicWorld = null;
         _rectScanUtils = null;
         VGlobal.logicWorld = null;
         VGlobal.model = null;
         VGlobal.scene = null;
         _preLoad = null;
         ChatSocketOutManager.sceneChat = null;
      }
      
      public function moveVehicleToPos(param1:Number, param2:Number) : void
      {
         if(!_model.selfVehicleInfo)
         {
            return;
         }
         if(_model.selfVehicleInfo.isStun)
         {
            return;
         }
         var _loc6_:TankAvatarView = _model.selfVehicleInfo.logicView as TankAvatarView;
         if(!_loc6_)
         {
            return;
         }
         var _loc4_:Point = new Point(_loc6_.x,_loc6_.y);
         var _loc8_:Point = new Point(param1,param2);
         var _loc7_:Point = getStartPoint(_loc6_.x,_loc6_.y,_loc8_);
         var _loc5_:Point = new Point(int(_loc7_.x / 20),int(_loc7_.y / 20));
         initRectScan();
         var _loc9_:Point = _rectScanUtils.walkRectScan(_loc8_,_loc5_,_loc4_);
         _loc9_ = new Point(int(_loc9_.x / 20),int(_loc9_.y / 20));
         var _loc3_:Array = AIManager.instance.find(_loc5_,_loc9_);
         if(_loc3_)
         {
            if(_loc3_.length > 0)
            {
               _loc3_.shift();
            }
            _loc6_.path = _loc3_;
         }
         NotificationManager.instance.dispatchEvent(new VehicleEvent("UPDATE_WALK_TARGET",new Point(_loc9_.x * 20,_loc9_.y * 20)));
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         VehicleSocketManager.instance.setup(true);
         VehicleSocketManager.instance.controller = this;
         _model = VehicleSocketManager.instance.model;
         MapElmsLibrary.instance.lock();
         SkillEffectFactory.instance.setup();
         if(MapData.mapId == _model.mapTempInfo.Id && MapData.mapBitmap && _model.mapTielsData)
         {
            preLoadingOver();
         }
         else
         {
            if(_model.createType == 3)
            {
               _preLoadingOver = false;
               _campaignSendTimeId = setInterval(showLoading,1500);
            }
            _preLoad = new PreCampaignData(_model);
            _preLoad.syncBackCall(preLoadingOver);
         }
      }
      
      public function get vehicleWorld() : VehicleView
      {
         return _logicWorld;
      }
      
      override protected function preLoadingOver() : void
      {
         _preLoadingOver = true;
         super.preLoadingOver();
      }
      
      private function getStartPoint(param1:int, param2:int, param3:Point) : Point
      {
         if(getWalkable(param1 / 20,param2 / 20))
         {
            return new Point(param1,param2);
         }
         var _loc4_:Point = _model.getNeighborII(param1 / 20,param2 / 20);
         _loc4_.x *= 20;
         _loc4_.y *= 20;
         return _loc4_;
      }
      
      private function initRectScan() : void
      {
         _rectScanUtils.outWidth = _model.mapTempInfo.Width / 20;
         _rectScanUtils.outHeight = _model.mapTempInfo.Height / 20;
         _rectScanUtils.getWalkable = getWalkable;
      }
      
      private function preLoadFunction() : void
      {
      }
      
      private function showLoading() : void
      {
         if(_campaignSendTimeId > 0)
         {
            clearInterval(_campaignSendTimeId);
         }
         _campaignSendTimeId = 0;
         if(!_preLoadingOver)
         {
            LoadingSceneView.instance.show();
         }
      }
   }
}

