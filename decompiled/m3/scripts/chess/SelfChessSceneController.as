package chess
{
   import bag.helper.BagHelper;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.SmallMapBar;
   import mainBar.TimeBoxView;
   import mainBar.TipsBar;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.scene.BaseSceneView;
   
   public class SelfChessSceneController extends BaseSceneView
   {
      
      private var _view:SelfChessSceneView;
      
      public function SelfChessSceneController()
      {
         super();
      }
      
      private function initView() : void
      {
         _view = new SelfChessSceneView();
         addChild(_view);
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      override public function get SceneName() : String
      {
         return "SELF_CHESS_SCENE";
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         LayerManager.Instance.clearnGameDynamic();
         QueueBar.instance.hide();
         TopToolsBar.instance.hide();
         MainToolBar.instance.hide();
         TaskTraceBar.instance.hide();
         TimeBoxView.instance.hide();
         SmallMapBar.instance.hide();
         initView();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         MainToolBar.instance.poptipButtonVisible = false;
      }
      
      override public function leaving() : void
      {
         MainToolBar.instance.hide();
         TipsBar.instance.hide();
         FullBar.instance.hide();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         KeyBoardRegister.instance.keyEnable = true;
         MainToolBar.instance.poptipButtonVisible = true;
         ObjectUtils.disposeObject(_view);
         _view = null;
      }
   }
}

