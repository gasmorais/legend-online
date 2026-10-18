package planeswar
{
   import bag.helper.BagHelper;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import mainBar.ChatBar;
   import map.internals.library.MapElmsLibrary;
   import mvc.module.planeswar.PlanesWarModel;
   import planeswar.view.PlanesUiLayer;
   import planeswar.view.PlanesWarMapView;
   import ui.events.UIBarEvent;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   
   public class PlanesWarSceneView extends BaseSceneView
   {
      
      private var _black:Component;
      
      private var _uiLayer:PlanesUiLayer;
      
      private var _mapView:PlanesWarMapView;
      
      private var refuseInvite:Boolean;
      
      private var refuseTeamInvite:Boolean;
      
      private var _preLoadingOver:Boolean;
      
      private var mapLayer:Bitmap;
      
      public function PlanesWarSceneView()
      {
         super();
      }
      
      override public function get SceneName() : String
      {
         return "PLANES_WAR_SCENE";
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         model.createMapData();
         model.updateMapData();
         loadMap();
      }
      
      private function loadMap() : void
      {
         if(!model.planesWarInfo)
         {
            preLoadingOver();
         }
         var _loc1_:String = PathManager.planesMapByLandTypeAndSize(model.planesWarInfo.layerTempId,model.currentSize);
         LoaderManagerII.instance.load(_loc1_,2,10,__mapLoadComplete,null,__mapLoadError);
      }
      
      protected function __mapLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(param2)
         {
            mapLayer = param2 as Bitmap;
         }
         preLoadingOver();
      }
      
      protected function __mapLoadError(param1:LoaderInfo, param2:Object) : void
      {
         preLoadingOver();
      }
      
      override protected function preLoadingOver() : void
      {
         super.preLoadingOver();
      }
      
      private function initView() : void
      {
         _mapView = new PlanesWarMapView(mapLayer);
         _uiLayer = new PlanesUiLayer();
         _black = new Component();
         addChild(_black);
         addChild(_mapView);
         addChild(_uiLayer);
         __resizeHanlder(null);
      }
      
      private function setBack(param1:int, param2:int) : void
      {
         _black.graphics.clear();
         _black.graphics.beginFill(0,1);
         _black.graphics.drawRect(0,0,param1,param2);
         _black.graphics.endFill();
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         initView();
         addEvent();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc3_:int = int(StageReferance.stageHeight);
         _mapView.x = (_loc2_ - _mapView.width) / 2;
         _mapView.y = (_loc3_ - _mapView.height) / 2;
         setBack(_loc2_,_loc3_);
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         MainToolBar.instance.updateFriendNoticeBtnPos(false);
         MainToolBar.instance.show();
         ResourcesBar.instance.show();
         ChatBar.instance.chatOutPutView.showBottomView();
         ChatBar.instance.show();
         NotificationManager.instance.dispatchEvent(new UIBarEvent("HIDE_TASK_TRACE"));
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         MainToolBar.instance.poptipButtonVisible = false;
         sendRefuseInvite();
         PlanesWarManager.instance.updateMapAndGridInfo();
         PlanesWarManager.instance.sendDispatchEvent("PLANES_WARINFO_UPDATE");
         PlanesWarManager.instance.sendDispatchEvent("PLANES_LAYERLIST_UPDATE");
      }
      
      override public function leaving() : void
      {
         removeEvent();
         if(_black)
         {
            ObjectUtils.disposeObject(_black);
         }
         _black = null;
         if(_mapView)
         {
            ObjectUtils.disposeObject(_mapView);
         }
         _mapView = null;
         if(_uiLayer)
         {
            ObjectUtils.disposeObject(_uiLayer);
         }
         _uiLayer = null;
         MapElmsLibrary.instance.unLock();
         model.cleanMapData();
         PlanesWarManager.instance.mapView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         LayerManager.Instance.clearGameMenuLayer();
         var _loc1_:Frame = ComponentFactory.Instance.getInstanceByStyleName("worldboss.RiverNotAlert2") as Frame;
         if(_loc1_)
         {
            _loc1_.dispose();
         }
         SceneManager.instance.isEnterFullScene = false;
         ChatBar.instance.chatOutPutView.showMinView();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         MainToolBar.instance.hide();
         NotificationManager.instance.dispatchEvent(new UIBarEvent("SHOW_TASK_TRACE"));
         removeRefuseInvite();
         MainToolBar.instance.poptipButtonVisible = true;
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      private function sendRefuseInvite() : void
      {
         refuseInvite = PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite;
         refuseTeamInvite = PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite;
         if(!PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      private function removeRefuseInvite() : void
      {
         if(!refuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!refuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
   }
}

