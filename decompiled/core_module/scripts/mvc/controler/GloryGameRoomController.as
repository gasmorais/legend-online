package mvc.controler
{
   import bag.helper.BagHelper;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mainBar.ChatBar;
   import managers.RoomManager;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.scene.BaseSceneView;
   
   public class GloryGameRoomController extends BaseSceneView
   {
      
      private var _roomView:DisplayObject;
      
      private var _exitsTimeId:int;
      
      public function GloryGameRoomController()
      {
         super();
      }
      
      private function gotoSpaceScene() : void
      {
         if(_exitsTimeId > 0)
         {
            clearInterval(_exitsTimeId);
            _exitsTimeId = 0;
         }
         RoomManager.instance.dispose();
         SwitchPageHelp.returnToSpace({"isOpenPveRoomList":true});
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         if(RoomManager.instance.exit)
         {
            _exitsTimeId = setInterval(gotoSpaceScene,1200);
            return;
         }
         _roomView = ComponentFactory.Instance.creatCustomObject("gloryGame.GloryGameRoomView");
         addChild(_roomView);
         addEvent();
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         ResourcesBar.instance.show();
         MainToolBar.instance.show();
         ChatBar.instance.show();
         TopToolsBar.instance.show();
      }
      
      override public function leaving() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_roomView);
         _roomView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         ChatBar.instance.hide();
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         LayerManager.Instance.clearGameMenuLayer();
         TopToolsBar.instance.hide();
         if(RoomManager.instance.exit)
         {
            RoomManager.instance.dispose();
         }
         super.leaving();
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function get SceneName() : String
      {
         return "GLORY_GAME_SCENE";
      }
   }
}

