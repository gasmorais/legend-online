package farm
{
   import bag.helper.BagHelper;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.farm.FarmPetInfoMsg;
   import com.road.yishi.proto.farm.FriendFarmStateMsg;
   import com.road.yishi.proto.farm.LoadFarmRsp;
   import farm.data.FriendFarmStateInfo;
   import farm.data.PetLandInfo;
   import farm.view.FarmInfoView;
   import farm.view.FarmMapView;
   import farm.view.FarmResourcesView;
   import farm.view.FarmToolbar;
   import flash.display.MovieClip;
   import flash.events.Event;
   import mainBar.ChatBar;
   import ui.maintoolbar.MainToolBar;
   import water.view.FarmFriendListView;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.scene.BaseSceneView;
   import yishi.service.managers.SocketManager;
   
   public class FarmSceneView extends BaseSceneView
   {
      
      private var _farmMap:FarmMapView;
      
      private var _friendListView:FarmFriendListView;
      
      private var _farmInfoView:FarmInfoView;
      
      private var _farmToolbar:FarmToolbar;
      
      private var _farmResourcesView:FarmResourcesView;
      
      public function FarmSceneView()
      {
         super();
      }
      
      override public function get SceneName() : String
      {
         return "FARM";
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         _farmMap = new FarmMapView();
         _friendListView = new FarmFriendListView();
         _farmInfoView = new FarmInfoView();
         _farmToolbar = new FarmToolbar();
         _farmResourcesView = new FarmResourcesView();
         setViewPos();
         FarmManager.instance.model.defaultSelectedUserInfo();
         addChild(_farmMap);
         addChild(_friendListView);
         addChild(_farmInfoView);
         addChild(_farmToolbar);
         addChild(_farmResourcesView);
         var _loc3_:MovieClip = ComponentFactory.Instance.creat("asset.core.cursor.FeedIconAsset");
         CursorManagerII.instance.registerCursor("FARM_FEED",_loc3_);
         addEvent();
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         MainToolBar.instance.show();
         MainToolBar.instance.updateFriendNoticeBtnPos(false);
         ChatBar.instance.show();
      }
      
      override public function leaving() : void
      {
         removeEvent();
         CursorManagerII.instance.unregisterCursor("FARM_FEED");
         if(_farmMap)
         {
            _farmMap.dispose();
         }
         _farmMap = null;
         if(_friendListView)
         {
            _friendListView.dispose();
         }
         _friendListView = null;
         if(_farmInfoView)
         {
            _farmInfoView.dispose();
         }
         _farmInfoView = null;
         if(_farmToolbar)
         {
            _farmToolbar.dispose();
         }
         _farmToolbar = null;
         if(_farmResourcesView)
         {
            _farmResourcesView.dispose();
         }
         _farmResourcesView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         LayerManager.Instance.clearGameMenuLayer();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4190,__getFriendFarmStateHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4190,__getFriendFarmStateHandler);
      }
      
      private function __getFriendFarmStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:FriendFarmStateInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:LoadFarmRsp = new LoadFarmRsp();
         _loc2_ = _loc4_.readBody(_loc2_) as LoadFarmRsp;
         for each(var _loc3_:FriendFarmStateMsg in _loc2_.friendFarmState)
         {
            _loc5_ = FarmManager.instance.model.getFarmStateInfo(_loc3_.userId);
            _loc5_.beginChanges();
            _loc5_.canFarmSteal = _loc3_.isPlantReap;
            _loc5_.canPastureSteal = _loc3_.isAnimalReap;
            _loc5_.canGivePower = _loc3_.isChargeEnergy;
            _loc5_.canRevive = _loc3_.isRevive;
            _loc5_.canWorm = _loc3_.isWorm;
            _loc5_.canWeed = _loc3_.isGrass;
            _loc5_.canFeed = _loc3_.isFeed;
            _loc5_.canFeedLivestock = _loc3_.isFeedLivestock;
            _loc5_.canPacify = _loc3_.isPacify;
            _loc5_.canCure = _loc3_.isCure;
            _loc5_.commitChanges();
         }
      }
      
      private function readPetInfoMsg(param1:PetLandInfo, param2:FarmPetInfoMsg) : PetLandInfo
      {
         if(!param1 || !param2)
         {
            return param1;
         }
         param1.userId = param2.userId;
         param1.petId = param2.petId;
         param1.name = param2.petName;
         if(param2.quality < 26)
         {
            param1.quality = (param2.quality - 1) / 5 + 1;
         }
         else
         {
            param1.quality = (param2.quality - 1) / 5;
         }
         param1.pos = param2.pos;
         param1.petTemplateId = param2.petTemplateId;
         param1.beginTime = param2.beginTime;
         param1.endTime = param2.endTime;
         param1.lastFeedRegion = param2.state;
         return param1;
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         setViewPos();
      }
      
      private function setViewPos() : void
      {
         if(_farmMap)
         {
            _farmMap.x = (StageReferance.stageWidth - _farmMap.width) * 0.5;
            _farmMap.y = (StageReferance.stageHeight - _farmMap.height) * 0.5;
         }
         if(_friendListView)
         {
            _friendListView.x = StageReferance.stageWidth - _friendListView.width;
            _friendListView.y = (StageReferance.stageHeight - _friendListView.height) / 4;
         }
         if(_farmInfoView)
         {
            _farmInfoView.x = 0;
            _farmInfoView.y = 0;
         }
         if(_farmToolbar)
         {
            _farmToolbar.x = StageReferance.stageWidth - _farmToolbar.width - 30;
            _farmToolbar.y = _friendListView.y + _friendListView.height + 20;
         }
         if(_farmResourcesView)
         {
            _farmResourcesView.x = (StageReferance.stageWidth - _farmResourcesView.width) / 2;
            _farmResourcesView.y = 0;
         }
      }
      
      public function get farmMap() : FarmMapView
      {
         return _farmMap;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

