package mvc.controler
{
   import chat.view.ChatTopBugleView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mainBar.ChatBar;
   import mainBar.TipsBar;
   import managers.ChallengeManager;
   import managers.RoomManager;
   import map.campaign.CampaignSocketOutManager;
   import mvc.module.room.RoomInfo;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.events.SceneViewEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.BaseSceneView;
   
   public class RoomControl extends BaseSceneView
   {
      
      private var _view:DisplayObject;
      
      private var _exitsTimeId:int;
      
      private var _multiCampaignSelectFrame:Frame;
      
      public function RoomControl()
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
         SwitchPageHelp.returnToSpace({"isOpenPveRoomList":true});
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         if(RoomManager.instance.exit)
         {
            _exitsTimeId = setInterval(gotoSpaceScene,1200);
            return;
         }
         RoomManager.instance.controller = this;
         _view = ComponentFactory.Instance.creatCustomObject("room.RoomView");
         addChild(_view);
         addEvent();
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         TopToolsBar.instance.show();
         ChatTopBugleView.instance.setPos();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         ChatBar.instance.show();
         ResourcesBar.instance.show();
         ChallengeManager.instance.isShowFrame = false;
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
         NotificationManager.instance.dispatchEvent(new SceneViewEvent("addToStage","PVE_ROOM_SCENE"));
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
         ResourcesBar.instance.hide();
         TopToolsBar.instance.hide();
         ChatBar.instance.hide();
         if(RoomManager.instance.exit)
         {
            RoomManager.instance.dispose();
         }
      }
      
      override public function get SceneName() : String
      {
         return "PVE_ROOM_SCENE";
      }
      
      override public function get sceneView() : DisplayObject
      {
         return _view;
      }
      
      override public function get backSceneName() : String
      {
         return "";
      }
      
      public function openMultiCampaignSelectFrame(param1:RoomInfo) : void
      {
         if(!_multiCampaignSelectFrame)
         {
            _multiCampaignSelectFrame = ComponentFactory.Instance.creatComponentByStylename("room.InstanceSelectFrame");
            _multiCampaignSelectFrame.addEventListener("dispose",__multiCampaignSelectFrameDispose);
            _multiCampaignSelectFrame["model"] = param1;
            _multiCampaignSelectFrame["show"]();
         }
      }
      
      private function __multiCampaignSelectFrameDispose(param1:Event) : void
      {
         _multiCampaignSelectFrame.removeEventListener("dispose",__multiCampaignSelectFrameDispose);
         _multiCampaignSelectFrame = null;
      }
      
      public function closeMultiCampaignSelectFrame() : void
      {
         if(_multiCampaignSelectFrame)
         {
            _multiCampaignSelectFrame.dispose();
         }
         _multiCampaignSelectFrame = null;
      }
      
      public function get multiCampaignSelectFrame() : Frame
      {
         return _multiCampaignSelectFrame;
      }
   }
}

