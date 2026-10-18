package finaldefense
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import finaldefense.view.FinalDefenseBottomView;
   import finaldefense.view.FinalDefenseGameStarView;
   import finaldefense.view.FinalDefensePowerPrgView;
   import finaldefense.view.FinalDefenseRightView;
   import finaldefense.view.FinalDefenseTopView;
   import finaldefense.view.FinalDefenseView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import mainBar.ChatBar;
   import managers.FinalDefenseManager;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   
   public class FinalDefenseScene extends BaseSceneView
   {
      
      private var _bg:Bitmap;
      
      private var _powerPressView:FinalDefensePowerPrgView;
      
      private var _topView:FinalDefenseTopView;
      
      private var _rightView:FinalDefenseRightView;
      
      private var _buttomView:FinalDefenseBottomView;
      
      private var _gameStarView:FinalDefenseGameStarView;
      
      private var _view:FinalDefenseView;
      
      public function FinalDefenseScene()
      {
         super();
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         initView();
         initEvent();
         KeyBoardRegister.instance.keyEnable = false;
         FinalDefenseManager.ins.getInfo();
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         MainToolBar.instance.updateFriendNoticeBtnPos(false);
         MainToolBar.instance.show();
         ChatBar.instance.show();
         ResourcesBar.instance.show();
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         SceneManager.instance.isEnterFullScene = true;
         __resizeHanlder();
      }
      
      private function __resizeHanlder(param1:Event = null) : void
      {
         x = (StageReferance.gameStageWidth - width) / 2;
         y = (StageReferance.gameStageHeight - height) / 2;
      }
      
      override public function get SceneName() : String
      {
         return "FINAL_DEFENSE_SCENE";
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.finaldefense.bg");
         _view = ComponentFactory.Instance.creatCustomObject("finaldefense.FinalDefenseView");
         _powerPressView = ComponentFactory.Instance.creatCustomObject("finaldefense.FinalDefensePowerPrgView");
         _topView = ComponentFactory.Instance.creatCustomObject("finaldefense.FinalDefenseTopView");
         _rightView = ComponentFactory.Instance.creatCustomObject("finaldefense.FinalDefenseRightView");
         _buttomView = ComponentFactory.Instance.creatCustomObject("finaldefense.FinalDefenseBottomView");
         _gameStarView = ComponentFactory.Instance.creatCustomObject("finaldefense.FinalDefenseGameStarView");
         addChild(_bg);
         addChild(_view);
         addChild(_powerPressView);
         addChild(_topView);
         addChild(_rightView);
         addChild(_buttomView);
         addChild(_gameStarView);
         this.scrollRect = new Rectangle(0,0,_bg.width,_bg.height);
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_INFO",onInfo);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_ROUND_OVER",onRoundOver);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_INFO",onInfo);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_ROUND_OVER",onRoundOver);
      }
      
      private function onRoundOver(param1:NotificationEvent) : void
      {
         if(_gameStarView != null)
         {
            addChild(_gameStarView);
         }
      }
      
      private function onInfo(param1:Event) : void
      {
         updateView();
      }
      
      public function updateView() : void
      {
         if(_powerPressView != null)
         {
            _powerPressView.updateView();
         }
         if(_topView != null)
         {
            _topView.updateView();
         }
         if(_rightView != null)
         {
            _rightView.updateView();
         }
         if(_buttomView != null)
         {
            _buttomView.updateView();
         }
         if(_gameStarView != null)
         {
            _gameStarView.updateView();
         }
      }
      
      override public function leaving() : void
      {
         FinalDefenseManager.ins.exitGame();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         SceneManager.instance.isEnterFullScene = false;
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         FinalDefenseManager.ins.cleanData();
         dispose();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_powerPressView);
         _powerPressView = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_buttomView);
         _buttomView = null;
         ObjectUtils.disposeObject(_gameStarView);
         _gameStarView = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

