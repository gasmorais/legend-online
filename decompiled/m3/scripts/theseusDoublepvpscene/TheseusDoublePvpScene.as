package theseusDoublepvpscene
{
   import bag.helper.BagHelper;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mainBar.ChatBar;
   import managers.RoomManager;
   import map.campaign.CampaignSocketOutManager;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.events.SceneViewEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.BaseSceneView;
   
   public class TheseusDoublePvpScene extends BaseSceneView
   {
      
      private var _view:DisplayObject;
      
      private var _exitsTimeId:int;
      
      public function TheseusDoublePvpScene()
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
         _view = ComponentFactory.Instance.creatCustomObject("theseusDoublepvpscene.theseusDoubleRoomView");
         addChild(_view);
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
      
      public function quitRoom() : void
      {
         CampaignSocketOutManager.instance.sendReturnCampaignRoom(selfArmyId);
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         _view["resize"](StageReferance.stageWidth,StageReferance.stageHeight);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         __resizeHanlder(null);
         NotificationManager.instance.dispatchEvent(new SceneViewEvent("addToStage","THESE_Double_PVP_SCENE"));
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
      
      override public function get SceneName() : String
      {
         return "THESE_Double_PVP_SCENE";
      }
      
      override public function get sceneView() : DisplayObject
      {
         return _view;
      }
      
      override public function get backSceneName() : String
      {
         return "";
      }
   }
}

