package stararea
{
   import bag.helper.BagHelper;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.TipsBar;
   import mvc.module.stararea.StarareaManager;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.GameModelHelp;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.scene.BaseSceneView;
   
   public class StarareaController extends BaseSceneView
   {
      
      private var _view:StarareaSceneView;
      
      public function StarareaController()
      {
         super();
      }
      
      private function initView() : void
      {
         _view = new StarareaSceneView();
         addChild(_view);
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      override public function get SceneName() : String
      {
         return "STARAREA_SCENE";
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         LayerManager.Instance.clearnGameDynamic();
         GameModelHelp.switchGameModel(1);
         QueueBar.instance.hide();
         initView();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         TopToolsBar.instance.hide();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         FullBar.instance.show();
         ChatBar.instance.show();
         ResourcesBar.instance.show();
         TaskTraceBar.instance.hide();
         ChatTopBugleView.instance.setPos();
      }
      
      override public function leaving() : void
      {
         StarareaManager.instance.model.isInit = false;
         MainToolBar.instance.hide();
         TipsBar.instance.hide();
         FullBar.instance.hide();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         BagHelper.instance.stopSelling();
         TaskTraceBar.instance.show();
         ShowTipManager.Instance.removeCurrentTip();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_view);
         _view = null;
      }
   }
}

