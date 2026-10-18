package mvc.controler
{
   import bag.helper.BagHelper;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import mainBar.ChatBar;
   import managers.RoomManager;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import unrealshooting.helper.VehicleResourceManager;
   import yishi.GameModelHelp;
   import yishi.scene.BaseSceneView;
   
   public class UnrealShootingRoomController extends BaseSceneView
   {
      
      private var _roomView:DisplayObject;
      
      public function UnrealShootingRoomController()
      {
         super();
      }
      
      override public function get SceneName() : String
      {
         return "UNREAL_SHOOTING_ROOM";
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         VehicleResourceManager.instance.setup();
         super.preLoadingStart(param1);
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         _roomView = ComponentFactory.Instance.creatCustomObject("unrealshootingroom.UnrealShootingRoomView");
         addChild(_roomView);
         addEvent();
         GameModelHelp.switchGameModel(1,true);
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         ResourcesBar.instance.hide();
         MainToolBar.instance.show();
         ChatBar.instance.show();
         TopToolsBar.instance.hide();
      }
      
      override public function leaving() : void
      {
         RoomManager.loginToRoomFlag = false;
         removeEvent();
         ObjectUtils.disposeObject(_roomView);
         _roomView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         ResourcesBar.instance.hide();
         ChatBar.instance.hide();
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         LayerManager.Instance.clearGameMenuLayer();
         TopToolsBar.instance.hide();
         VehicleResourceManager.instance.dispose();
         super.leaving();
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
   }
}

