package gamehall
{
   import chat.view.ChatTopBugleView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import gamehall.room.GameHallSceneView;
   import mainBar.ChatBar;
   import mainBar.SmallMapBar;
   import mainBar.TipsBar;
   import managers.ChallengeManager;
   import managers.GameHallManager;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.SwitchPageHelp;
   import yishi.events.SceneViewEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.BaseSceneView;
   
   public class GameHallSceneController extends BaseSceneView
   {
      
      private var _view:GameHallSceneView;
      
      private var _exitsTimeId:int;
      
      public function GameHallSceneController()
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
         SwitchPageHelp.returnToSpace({"isOpenGameHall":true});
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         if(GameHallManager.instance.exit)
         {
            _exitsTimeId = setInterval(gotoSpaceScene,1200);
            return;
         }
         LayerManager.Instance.clearnGameDynamic();
         initView();
         addEvent();
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         TopToolsBar.instance.hide();
         TaskTraceBar.instance.hide();
         QueueBar.instance.hide();
         SmallMapBar.instance.hide();
         ChatTopBugleView.instance.setPos();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         ChatBar.instance.show();
         ResourcesBar.instance.show();
         ChallengeManager.instance.isShowFrame = false;
      }
      
      override public function leaving() : void
      {
         GameHallManager.loginToGameHallFlag = false;
         removeEvent();
         uninitView();
         TopToolsBar.instance.hide();
         MainToolBar.instance.hide();
         TipsBar.instance.hide();
         ResourcesBar.instance.hide();
         ChatBar.instance.hide();
      }
      
      private function initView() : void
      {
         _view = new GameHallSceneView();
         addChild(_view);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
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
      
      public function quitScene() : void
      {
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         if(_view)
         {
            _view.resize(StageReferance.stageWidth,StageReferance.stageHeight);
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         if(_view)
         {
            _view.addToStage(param1);
         }
         __resizeHanlder(null);
         NotificationManager.instance.dispatchEvent(new SceneViewEvent("addToStage","GAME_HALL_SCENE"));
      }
      
      private function get selfArmyId() : int
      {
         return ArmyManager.instance.army.id;
      }
      
      override public function get SceneName() : String
      {
         return "GAME_HALL_SCENE";
      }
   }
}

