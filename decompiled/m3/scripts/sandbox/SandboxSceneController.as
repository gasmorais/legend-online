package sandbox
{
   import bag.helper.BagHelper;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.TipsBar;
   import map.internals.data.template.MapTemplate;
   import sandbox.daylight.DayLightSceneView;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.GameModelHelp;
   import yishi.SwitchPageHelp;
   import yishi.manager.TempleteManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   
   public class SandboxSceneController extends BaseSceneView
   {
      
      private var _sceneView:DayLightSceneView;
      
      private var _preSceneData:Object;
      
      private var _gotoCastleTimeId:int;
      
      public function SandboxSceneController()
      {
         super();
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      private function gotoOutSandbox() : Boolean
      {
         if(SandboxManager.instance.exit)
         {
            _gotoCastleTimeId = setInterval(gotoCastleScene,1000);
            return true;
         }
         return false;
      }
      
      private function gotoCastleScene() : void
      {
         if(_gotoCastleTimeId > 0)
         {
            clearInterval(_gotoCastleTimeId);
         }
         _gotoCastleTimeId = 0;
         SceneManager.instance.lock = false;
         SwitchPageHelp.returnToSpace();
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         if(gotoOutSandbox())
         {
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         _preSceneData = param2;
         _sceneView = new DayLightSceneView();
         addChild(_sceneView);
         GameModelHelp.switchGameModel(1,false,true);
         var _loc3_:MapTemplate = TempleteManager.instance.mapTemplateCate.getTemplateByID(4101);
         SoundManager.instance.dynamicPlayMusic(_loc3_.MusicPath);
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
         ChatTopBugleView.instance.setPos();
      }
      
      override public function leaving() : void
      {
         SandboxManager.loginToSandboxFlag = false;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         MainToolBar.instance.hide();
         TipsBar.instance.hide();
         FullBar.instance.hide();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
      }
      
      override public function get SceneName() : String
      {
         return "SANDBOX_SCENE";
      }
   }
}

