package childnswar
{
   import bag.helper.BagHelper;
   import childnswar.view.ChildNswarBottomView;
   import childnswar.view.ChildNswarLeftView;
   import childnswar.view.ChildNswarRightView;
   import childnswar.view.ChildNswarTopView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.Event;
   import mainBar.ChatBar;
   import ui.events.UIBarEvent;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   
   public class ChildNswarScene extends BaseSceneView
   {
      
      private var _bg:Bitmap;
      
      private var _bmask:Shape;
      
      private var _topView:ChildNswarTopView;
      
      private var _leftView:ChildNswarLeftView;
      
      private var _rightView:ChildNswarRightView;
      
      private var _bottomView:ChildNswarBottomView;
      
      public function ChildNswarScene()
      {
         super();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.sceneMap");
         _topView = new ChildNswarTopView();
         _leftView = new ChildNswarLeftView();
         _bottomView = new ChildNswarBottomView();
         _rightView = new ChildNswarRightView();
         _bmask = new Shape();
         addChild(_bg);
         addChild(_bmask);
         addChild(_topView);
         addChild(_leftView);
         addChild(_bottomView);
         addChild(_rightView);
         _leftView.x = 31;
         _leftView.y = 243;
         _rightView.y = 248;
      }
      
      override public function get SceneName() : String
      {
         return "CHILD_NS_WAR_SCENE";
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         initView();
         __resizeHanlder();
         addEvent();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         NotificationManager.instance.addEventListener("childnswarMatchEvent",matchResultHandler);
         NotificationManager.instance.addEventListener("childnswarUpdateEnterTime",sesonChangeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         NotificationManager.instance.removeEventListener("childnswarMatchEvent",matchResultHandler);
         NotificationManager.instance.removeEventListener("childnswarUpdateEnterTime",sesonChangeHandler);
      }
      
      private function sesonChangeHandler(param1:NotificationEvent) : void
      {
         _bottomView.sesonChange();
         _topView.sesonChange();
      }
      
      private function matchResultHandler(param1:NotificationEvent) : void
      {
         _bottomView.updateMatchState();
         _rightView.updateMatchState();
      }
      
      private function __resizeHanlder(param1:Event = null) : void
      {
         var _loc4_:int = int(StageReferance.stageWidth);
         var _loc5_:int = int(StageReferance.stageHeight);
         _bmask.graphics.clear();
         _bmask.graphics.beginFill(0,0.6);
         _bmask.graphics.drawRect(0,0,_loc4_,_loc5_);
         _bmask.graphics.endFill();
         var _loc2_:int = 1495;
         var _loc3_:int = 895;
         _bg.width = _loc4_ > _loc2_ ? _loc4_ : _loc2_;
         _bg.height = _loc5_ > _loc3_ ? _loc5_ : _loc3_;
         _bg.x = (_loc4_ - _bg.width) * 0.5;
         _topView.resize(_loc4_,_loc5_);
         _bottomView.resize(_loc4_,_loc5_);
         _rightView.resize(_loc4_,_loc5_);
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         MainToolBar.instance.updateFriendNoticeBtnPos(false);
         MainToolBar.instance.show();
         ResourcesBar.instance.show();
         ChatBar.instance.show();
         TopToolsBar.instance.hide();
         NotificationManager.instance.dispatchEvent(new UIBarEvent("HIDE_TASK_TRACE"));
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         MainToolBar.instance.poptipButtonVisible = false;
      }
      
      override public function leaving() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         LayerManager.Instance.clearGameMenuLayer();
         SceneManager.instance.isEnterFullScene = false;
         ChatBar.instance.chatOutPutView.showMinView();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         MainToolBar.instance.hide();
         NotificationManager.instance.dispatchEvent(new UIBarEvent("SHOW_TASK_TRACE"));
         MainToolBar.instance.poptipButtonVisible = true;
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

