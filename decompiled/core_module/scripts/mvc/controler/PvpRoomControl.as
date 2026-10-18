package mvc.controler
{
   import chat.view.ChatTopBugleView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mainBar.ChatBar;
   import mainBar.TipsBar;
   import managers.RoomManager;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.manager.ArmyManager;
   import yishi.scene.BaseSceneView;
   
   public class PvpRoomControl extends BaseSceneView
   {
      
      private var _view:DisplayObject;
      
      private var _exitsTimeId:int;
      
      public function PvpRoomControl()
      {
         super();
      }
      
      private function gotoSpaceScene() : void
      {
         if(_exitsTimeId > 0)
         {
            clearInterval(_exitsTimeId);
         }
         _exitsTimeId = 0;
         SwitchPageHelp.returnToSpace({"isOpenPvpRoomList":true});
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         if(RoomManager.instance.exit)
         {
            _exitsTimeId = setInterval(gotoSpaceScene,1200);
            return;
         }
         _view = ComponentFactory.Instance.creatCustomObject("roomPVP.PVPRoomView");
         addChild(_view);
         addEvent();
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         TopToolsBar.instance.show();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         ChatBar.instance.show();
         ResourcesBar.instance.show();
         ChatTopBugleView.instance.setPos();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         this.addEventListener("addedToStage",__addToStageHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         this.removeEventListener("addedToStage",__addToStageHandler);
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         _view["resize"](StageReferance.stageWidth,StageReferance.stageHeight);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         __resizeHanlder(null);
      }
      
      private function get selfArmyId() : int
      {
         return ArmyManager.instance.army.id;
      }
      
      override public function leaving() : void
      {
         removeEvent();
         if(_view)
         {
            _view["dispose"]();
         }
         _view = null;
         MainToolBar.instance.hide();
         TipsBar.instance.hide();
         TopToolsBar.instance.hide();
         ResourcesBar.instance.hide();
         ChatBar.instance.hide();
         if(RoomManager.instance.exit)
         {
            RoomManager.instance.dispose();
         }
         MainToolBar.instance.switchToolsBarState(2);
      }
      
      override public function get SceneName() : String
      {
         return "PVP_ROOM_SCENE";
      }
      
      override public function get backSceneName() : String
      {
         return "";
      }
   }
}

