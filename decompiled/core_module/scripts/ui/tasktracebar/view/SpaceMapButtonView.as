package ui.tasktracebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   
   public class SpaceMapButtonView extends Sprite
   {
      
      private var _mapBtn:IconButton;
      
      public function SpaceMapButtonView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _mapBtn = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.SpaceMapButtonView.MapBtn");
         _mapBtn.tipData = LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + ": M";
         addChild(_mapBtn);
         setVisible();
      }
      
      private function addEvent() : void
      {
         _mapBtn.addEventListener("click",__mapBtnClickHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
      }
      
      private function removeEvent() : void
      {
         _mapBtn.removeEventListener("click",__mapBtnClickHandler);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
      }
      
      private function __mapBtnClickHandler(param1:MouseEvent) : void
      {
         if(inSpaceScene)
         {
            FrameControllerManager.instance.openControllerByInfo("space");
         }
         else if(inPetLand)
         {
            FrameControllerManager.instance.openControllerByInfo("space",3);
         }
         else if(inMineral)
         {
            FrameControllerManager.instance.openControllerByInfo("space",4);
         }
         else if(inGodsEvening)
         {
            FrameControllerManager.instance.openControllerByInfo("space",7);
         }
         ShowTipManager.Instance.showTip(_mapBtn);
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         setVisible();
      }
      
      private function setVisible() : void
      {
         if(inSpaceScene || inPetLand || inMineral || inGodsEvening)
         {
            visible = true;
         }
         else
         {
            visible = false;
         }
      }
      
      private function get inSpaceScene() : Boolean
      {
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return true;
         }
         return false;
      }
      
      private function get inPetLand() : Boolean
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE" && WorldBossHelper.checkPetLand(CampaignManager.instance.mapId))
         {
            return true;
         }
         return false;
      }
      
      private function get inMineral() : Boolean
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE" && WorldBossHelper.checkMineral(CampaignManager.instance.mapId))
         {
            return true;
         }
         return false;
      }
      
      private function get inGodsEvening() : Boolean
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE" && WorldBossHelper.checkGodsEvening(CampaignManager.instance.mapId))
         {
            return true;
         }
         return false;
      }
      
      public function getMapBtn() : IconButton
      {
         return _mapBtn;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_mapBtn)
         {
            ObjectUtils.disposeObject(_mapBtn);
            _mapBtn = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

