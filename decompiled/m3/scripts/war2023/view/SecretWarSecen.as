package war2023.view
{
   import bag.helper.BagHelper;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.TipsBar;
   import mvc.module.war2023.SecretWarModel;
   import mvc.module.war2023.info.SecretWarNodeInfo;
   import mvc.module.war2023.info.SecretwarSelfInfo;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import war2023.util.SecretwarBitDataUtil;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.SecretWarManager;
   import yishi.scene.BaseSceneView;
   
   public class SecretWarSecen extends BaseSceneView
   {
      
      private var _mapView:SecretWarMapView;
      
      private var _preSceneData:Object;
      
      public function SecretWarSecen()
      {
         super();
      }
      
      private function initView() : void
      {
         SecretwarBitDataUtil.setup();
         _mapView = new SecretWarMapView();
         addChild(_mapView);
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      override public function get SceneName() : String
      {
         return "SECRET_WAR_SCENE";
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         _preSceneData = param2;
         LayerManager.Instance.clearnGameDynamic();
         initView();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function enterOver() : void
      {
         var _loc1_:SecretWarNodeInfo = null;
         super.enterOver();
         TopToolsBar.instance.hide();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         FullBar.instance.show();
         ChatBar.instance.show();
         ResourcesBar.instance.show();
         ChatTopBugleView.instance.setPos();
         var _loc2_:SecretwarSelfInfo = SecretWarManager.Instance.model.selfInfo;
         if(_loc2_.waitMove)
         {
            SecretWarManager.Instance.gameOp(3);
         }
         if(_preSceneData)
         {
            if(_preSceneData.isOpenNode)
            {
               if(model.selfPlay.toNodeId <= 0 && model.selfPlay.state != 2)
               {
                  _loc1_ = model.nodeInfos[model.selfPlay.curNodeId];
                  FrameControllerManager.instance.openControllerByInfo("secretwar",1,_loc1_);
               }
            }
         }
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      override public function leaving() : void
      {
         SecretWarManager.loginToSecretWarFlag = false;
         MainToolBar.instance.hide();
         TipsBar.instance.hide();
         FullBar.instance.hide();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         BagHelper.instance.stopSelling();
         ShowTipManager.Instance.removeCurrentTip();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
         SecretwarBitDataUtil.clear();
         _preSceneData = null;
      }
   }
}

