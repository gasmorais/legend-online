package colosseum
{
   import chat.view.ChatTopBugleView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import mainBar.ChatBar;
   import mainBar.TimeBoxView;
   import mainBar.TipsBar;
   import managers.ChallengeManager;
   import mvc.module.colosseum.ColosseumModel;
   import ui.maintoolbar.MainToolBar;
   import yishi.events.SceneViewEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.BaseSceneView;
   
   public class ChallengeSceneControl extends BaseSceneView
   {
      
      public static var _model:ColosseumModel;
      
      private var _view:DisplayObject;
      
      public function ChallengeSceneControl()
      {
         super();
      }
      
      override public function get SceneName() : String
      {
         return "CHANLLENGE_ROOM_SCENE";
      }
      
      public function get model() : ColosseumModel
      {
         ChallengeManager.instance.model;
         if(!FrameControllerManager.instance.colosseumControler.model)
         {
            FrameControllerManager.instance.colosseumControler.model = new ColosseumModel();
         }
         return FrameControllerManager.instance.colosseumControler.model;
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         _view = ComponentFactory.Instance.creatCustomObject("colosseum.ChallengeView");
         addChild(_view);
         addEvent();
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         ChatTopBugleView.instance.setPos();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         ChatBar.instance.show();
         TimeBoxView.instance.hide();
         ChallengeManager.instance.initModel();
         ChallengeManager.instance.isLogin = true;
      }
      
      override public function leaving() : void
      {
         super.leaving();
         removeEvent();
         if(_view)
         {
            _view["dispose"]();
            _view.parent && _view.parent.removeChild(_view);
         }
         _view = null;
         TipsBar.instance.hide();
         ChatBar.instance.hide();
         TimeBoxView.instance.show();
         ChallengeManager.instance.dispose();
      }
      
      override public function get sceneView() : DisplayObject
      {
         return _view;
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         this.removeEventListener("addedToStage",__addToStageHandler);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         this.addEventListener("addedToStage",__addToStageHandler);
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         _view["resize"](StageReferance.stageWidth,StageReferance.stageHeight);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         __resizeHanlder(null);
         NotificationManager.instance.dispatchEvent(new SceneViewEvent("addToStage","CHANLLENGE_ROOM_SCENE"));
      }
   }
}

