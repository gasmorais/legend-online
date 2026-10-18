package map.campaign.mediator.farm
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.farm.FriendFarmStateMsg;
   import com.road.yishi.proto.farm.LoadFarmRsp;
   import farm.FarmManager;
   import farm.data.FriendFarmStateInfo;
   import farm.view.FarmAnimalLayer;
   import farm.view.FarmAnimationLayer;
   import farm.view.FarmBuildLayer;
   import farm.view.FarmLandLayer;
   import farm.view.FarmMountLayer;
   import farm.view.FarmUILayer;
   import farm.view.FarmWalkLayer;
   import flash.display.MovieClip;
   import map.campaign.view.CampaignMapView;
   import water.view.WaterView;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.CursorManagerII;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class FarmMediator implements IMediator
   {
      
      private var _container:CampaignMapView;
      
      private var _farmAnimalLayer:FarmAnimalLayer;
      
      private var _farmWaterLayer:WaterView;
      
      private var _farmWalkLayer:FarmWalkLayer;
      
      private var _farmLandLayer:FarmLandLayer;
      
      private var _farmBuildLayer:FarmBuildLayer;
      
      private var _cursorMovieClip:MovieClip;
      
      private var _farmUILayer:FarmUILayer;
      
      private var _farmMountLayer:FarmMountLayer;
      
      private var _farmAnimationLayer:FarmAnimationLayer;
      
      private var _isAdd:Boolean;
      
      public function FarmMediator()
      {
         super();
         _farmAnimalLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmAnimalLayer");
         _farmWaterLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmWaterLayer");
         _farmWalkLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmWalkLayer");
         _farmLandLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmLandLayer");
         _farmBuildLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmBuildLayer");
         _farmMountLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmMountLayer");
         _cursorMovieClip = ComponentFactory.Instance.creat("asset.core.cursor.FeedIconAsset");
         CursorManagerII.instance.registerCursor("FARM_FEED",_cursorMovieClip);
      }
      
      public function register(param1:Object) : void
      {
         __infoHandler();
         _container = param1 as CampaignMapView;
         _container.farmLayer.addChildAt(_farmAnimalLayer,0);
         _container.farmLayer.addChildAt(_farmWalkLayer,0);
         _container.farmLayer.addChildAt(_farmBuildLayer,0);
         _container.farmLayer.addChildAt(_farmLandLayer,0);
         _container.farmLayer.addChildAt(_farmWaterLayer,0);
         _container.farmLayer.addChildAt(_farmMountLayer,0);
         _container.farmLandLayer = _farmLandLayer;
         addHouseUIView();
         FarmManager.instance.model.defaultSelectedUserInfo();
         MsgMan.addObserver("ChildEvent.HOME_INFO",this,__infoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4190,__getFriendFarmStateHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         MsgMan.removeObserver("ChildEvent.HOME_INFO",this,__infoHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4190,__getFriendFarmStateHandler);
         _container.farmLandLayer = null;
         ObjectUtils.disposeObject(_farmAnimalLayer);
         _farmAnimalLayer = null;
         ObjectUtils.disposeObject(_farmWaterLayer);
         _farmWaterLayer = null;
         ObjectUtils.disposeObject(_farmWalkLayer);
         _farmWalkLayer = null;
         ObjectUtils.disposeObject(_farmLandLayer);
         _farmLandLayer = null;
         ObjectUtils.disposeObject(_farmBuildLayer);
         _farmBuildLayer = null;
         ObjectUtils.disposeViolentMc(_cursorMovieClip);
         _cursorMovieClip = null;
         ObjectUtils.disposeObject(_farmUILayer);
         _farmUILayer = null;
         ObjectUtils.disposeObject(_farmAnimationLayer);
         _farmAnimationLayer = null;
         _container = null;
      }
      
      private function addHouseUIView() : void
      {
         if(_isAdd)
         {
            return;
         }
         _isAdd = true;
         _farmUILayer = new FarmUILayer();
         _farmAnimationLayer = new FarmAnimationLayer();
         LayerManager.Instance.addToLayer(_farmAnimationLayer,4);
         LayerManager.Instance.addToLayer(_farmUILayer,4);
      }
      
      private function __infoHandler(param1:String = "", param2:Object = null) : void
      {
      }
      
      private function __getFriendFarmStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:FriendFarmStateMsg = null;
         var _loc6_:FriendFarmStateInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:LoadFarmRsp = new LoadFarmRsp();
         _loc2_ = _loc5_.readBody(_loc2_) as LoadFarmRsp;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.friendFarmState.length)
         {
            _loc3_ = _loc2_.friendFarmState[_loc4_];
            if(playerInfo.userId != _loc3_.userId)
            {
               _loc6_ = FarmManager.instance.model.getFarmStateInfo(_loc3_.userId);
               _loc6_.beginChanges();
               _loc6_.canFarmSteal = _loc3_.isPlantReap;
               _loc6_.canPastureSteal = _loc3_.isAnimalReap;
               _loc6_.canGivePower = _loc3_.isChargeEnergy;
               _loc6_.canRevive = _loc3_.isRevive;
               _loc6_.canWorm = _loc3_.isWorm;
               _loc6_.canWeed = _loc3_.isGrass;
               _loc6_.canFeed = _loc3_.isFeed;
               _loc6_.canFeedLivestock = _loc3_.isFeedLivestock;
               _loc6_.canPacify = _loc3_.isPacify;
               _loc6_.canCure = _loc3_.isCure;
               _loc6_.commitChanges();
            }
            _loc4_++;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

