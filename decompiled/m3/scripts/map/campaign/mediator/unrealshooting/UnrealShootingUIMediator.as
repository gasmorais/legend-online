package map.campaign.mediator.unrealshooting
{
   import com.map.vehicle.VehicleChatController;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import mainBar.ChatBar;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.ui.unrealshooting.UnrealShootingBottomBar;
   import map.campaign.view.ui.unrealshooting.UnrealShootingBufferBuyView;
   import map.campaign.view.ui.unrealshooting.UnrealShootingMiniMapView;
   import map.campaign.view.ui.unrealshooting.UnrealShootingSortTopView;
   import map.campaign.view.ui.unrealshooting.UnrealShootingTopBar;
   import mvc.controler.UnrealShootingController;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.PathInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.FrameControllerManager;
   
   public class UnrealShootingUIMediator implements IMediator
   {
      
      private var _miniMapView:UnrealShootingMiniMapView;
      
      private var _topBar:UnrealShootingTopBar;
      
      private var _bottomBar:UnrealShootingBottomBar;
      
      private var _bufferBuyView:UnrealShootingBufferBuyView;
      
      private var _topTenView:UnrealShootingSortTopView;
      
      private var _topUILayer:Sprite;
      
      private var _controller:UnrealShootingController;
      
      private var _mapModel:CampaignMapModel;
      
      private var _selfArmyView:CampaignArmyView;
      
      private var _selfArmyInfo:CampaignArmy;
      
      private var _towerNodes:Array = [];
      
      public function UnrealShootingUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _controller = FrameControllerManager.instance.unrealShootingController;
         _mapModel = CampaignManager.instance.mapModel;
         initUI();
         addEvent();
         __resizeHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_miniMapView);
         _miniMapView = null;
         ObjectUtils.disposeObject(_topBar);
         _topBar = null;
         ObjectUtils.disposeObject(_bottomBar);
         _bottomBar = null;
         ObjectUtils.disposeObject(_bufferBuyView);
         _bufferBuyView = null;
         ObjectUtils.disposeObject(_topTenView);
         _topTenView = null;
         MainToolBar.instance.poptipButtonVisible = true;
         ChatBar.inBattleFlag = false;
         VehicleChatController.getInstance().dispose();
         ChatBar.instance.show();
         _topUILayer = null;
         _selfArmyInfo = null;
         _selfArmyView = null;
      }
      
      private function initUI() : void
      {
         _selfArmyInfo = _mapModel.selfMemberData;
         _selfArmyView = CampaignManager.instance.controller.getArmyView(_selfArmyInfo);
         _topUILayer = (CampaignManager.instance.mapView as CampaignMapView).topUILayer;
         _miniMapView = new UnrealShootingMiniMapView();
         _miniMapView.show();
         _topBar = new UnrealShootingTopBar();
         _topBar.show();
         _bottomBar = new UnrealShootingBottomBar();
         _bottomBar.show();
         _bufferBuyView = new UnrealShootingBufferBuyView();
         _bufferBuyView.show();
         _topTenView = new UnrealShootingSortTopView();
         _topTenView.show();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         var _loc4_:int = int(StageReferance.stage.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         if(_miniMapView)
         {
            _miniMapView.x = _loc4_ - _miniMapView.width;
         }
         if(_topBar)
         {
            _topBar.x = (_loc4_ - _topBar.width) * 0.5;
         }
         if(_bottomBar)
         {
            _bottomBar.x = (_loc4_ - _bottomBar.width) * 0.5;
            _bottomBar.y = _loc2_ - _bottomBar.height;
         }
         if(_bufferBuyView)
         {
            _bufferBuyView.stageResizeHandler();
         }
         if(_topTenView)
         {
            _topTenView.stageResizeHandler();
         }
         var _loc3_:int = 332;
         if(_topBar)
         {
            if(_topBar && _topBar.x < _loc3_)
            {
               _topBar.x = _loc3_;
            }
         }
         if(_bottomBar)
         {
            if(_bottomBar.x < (PathInfo.GAME_WIDTH - _bottomBar.width) * 0.5)
            {
               _bottomBar.x = (PathInfo.GAME_WIDTH - _bottomBar.width) * 0.5;
            }
         }
      }
   }
}

