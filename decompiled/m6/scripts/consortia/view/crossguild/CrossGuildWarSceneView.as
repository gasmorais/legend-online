package consortia.view.crossguild
{
   import bag.helper.BagHelper;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.crossguild.war.CrossGuildMapView;
   import consortia.view.crossguild.war.CrossGuildUIView;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.TipsBar;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   
   public class CrossGuildWarSceneView extends BaseSceneView
   {
      
      private var _black:Component;
      
      private var _mapView:CrossGuildMapView;
      
      private var _uiView:CrossGuildUIView;
      
      public function CrossGuildWarSceneView()
      {
         super();
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      override public function get SceneName() : String
      {
         return "CROSS_GUILD_SCENE";
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         LayerManager.Instance.clearnGameDynamic();
         initView();
      }
      
      private function initView() : void
      {
         _mapView = new CrossGuildMapView();
         _uiView = new CrossGuildUIView();
         addChild(_mapView);
         addChild(_uiView);
         addEvent();
      }
      
      private function addEvent() : void
      {
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function removeEvent() : void
      {
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            CrossGuildManager.instance.model.isInCrossGuildWar = false;
            SceneManager.instance.setScene(SwitchPageHelp.returnScene);
         }
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         TopToolsBar.instance.hide();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         FullBar.instance.show();
         ChatBar.instance.show();
         ResourcesBar.instance.show();
         ChatTopBugleView.instance.setPos();
      }
      
      override public function leaving() : void
      {
         removeEvent();
         MainToolBar.instance.hide();
         TipsBar.instance.hide();
         FullBar.instance.hide();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         ObjectUtils.disposeObject(_black);
         _black = null;
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
         ObjectUtils.disposeObject(_uiView);
         _uiView = null;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

