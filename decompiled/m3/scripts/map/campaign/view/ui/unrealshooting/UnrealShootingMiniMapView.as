package map.campaign.view.ui.unrealshooting
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.UnrealShootingModel;
   import map.internals.data.CampaignNode;
   import mvc.controler.UnrealShootingController;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   
   public class UnrealShootingMiniMapView extends Sprite implements Disposeable, IEnterFrame
   {
      
      private var _bg:Image;
      
      private var _towerContainer:Sprite;
      
      private var _monsterContainer:Sprite;
      
      private var _heroContainer:Sprite;
      
      private var _refreshCount:int;
      
      private var _scaleX:Number;
      
      private var _scaleY:Number;
      
      private var _controller:UnrealShootingController = FrameControllerManager.instance.unrealShootingController;
      
      private var _model:UnrealShootingModel = _controller.model;
      
      private var _mapController:CampaignMapController = CampaignManager.instance.controller;
      
      private var _mapModel:CampaignMapModel = CampaignManager.instance.mapModel;
      
      public function UnrealShootingMiniMapView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingMiniMapView.Bg");
         _towerContainer = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingMiniMapView.MiniMapContainer");
         _monsterContainer = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingMiniMapView.MiniMapContainer");
         _heroContainer = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingMiniMapView.MiniMapContainer");
         _scaleX = _bg.width / _mapModel.mapTempInfo.Width;
         _scaleY = _bg.height / _mapModel.mapTempInfo.Height;
         addChild(_bg);
         addChild(_towerContainer);
         addChild(_monsterContainer);
         addChild(_heroContainer);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_towerContainer);
         _towerContainer = null;
         ObjectUtils.disposeObject(_monsterContainer);
         _monsterContainer = null;
         ObjectUtils.disposeObject(_heroContainer);
         _heroContainer = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         if(!_mapModel)
         {
            return;
         }
         _refreshCount = _refreshCount + 1;
         if(_refreshCount > 10)
         {
            _refreshCount = 0;
            refreshView();
         }
      }
      
      public function refreshView() : void
      {
         var _loc3_:Object = null;
         _heroContainer.graphics.clear();
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         for each(var _loc2_:CampaignArmy in _mapModel.allUserArmy)
         {
            _loc3_ = _mapController.getArmyView(_loc2_);
            if(_loc3_)
            {
               _loc4_ = _loc3_.x * _scaleX;
               _loc5_ = _loc3_.y * _scaleY;
               if(_loc2_ == _mapModel.selfMemberData)
               {
                  _loc6_ = true;
               }
               else
               {
                  _loc6_ = false;
               }
               if(_loc2_.teamId == 1)
               {
                  drawBlueHero(_loc4_,_loc5_,_loc6_);
               }
               else if(_loc2_.teamId == 2)
               {
                  drawRedHero(_loc4_,_loc5_,_loc6_);
               }
            }
         }
         for each(var _loc1_:CampaignNode in _mapModel.mapNodesData)
         {
            if(!(_loc1_.info.state == 8 || _loc1_.info.state == 9 || _loc1_.info.state == 0))
            {
               if(!(_loc1_.info.types != 202 && _loc1_.info.types != 203 && _loc1_.info.types != 204))
               {
                  _loc3_ = _loc1_.nodeView;
                  if(_loc3_)
                  {
                     _loc4_ = _loc3_.x * _scaleX;
                     _loc5_ = _loc3_.y * _scaleY;
                     drawMonster(_loc4_,_loc5_);
                  }
               }
            }
         }
      }
      
      private function drawBlueHero(param1:int, param2:int, param3:Boolean = false) : void
      {
         if(param3)
         {
            _heroContainer.graphics.beginFill(65280);
         }
         else
         {
            _heroContainer.graphics.beginFill(13311);
         }
         _heroContainer.graphics.drawCircle(param1,param2,3);
         _heroContainer.graphics.endFill();
      }
      
      private function drawRedHero(param1:int, param2:int, param3:Boolean = false) : void
      {
         if(param3)
         {
            _heroContainer.graphics.beginFill(65280);
         }
         else
         {
            _heroContainer.graphics.beginFill(16711680);
         }
         _heroContainer.graphics.drawRect(param1 - 2,param2 - 2,5,5);
         _heroContainer.graphics.endFill();
      }
      
      private function drawMonster(param1:int, param2:int) : void
      {
         _heroContainer.graphics.beginFill(16776960);
         _heroContainer.graphics.moveTo(param1,param2 - 3);
         _heroContainer.graphics.lineTo(param1 + 3,param2 + 3);
         _heroContainer.graphics.lineTo(param1 - 3,param2 + 3);
         _heroContainer.graphics.lineTo(param1,param2 - 3);
         _heroContainer.graphics.endFill();
      }
      
      public function stageResizeHandler() : void
      {
         x = StageReferance.stageWidth - this.width;
      }
      
      public function show() : void
      {
         stageResizeHandler();
         LayerManager.Instance.addToLayer(this,4,false,false,0,0);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

