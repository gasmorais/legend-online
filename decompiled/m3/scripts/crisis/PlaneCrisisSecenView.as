package crisis
{
   import bag.helper.BagHelper;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import crisis.ui.PlaneCrisisComBitData;
   import crisis.ui.PlaneCrisisMapView;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.TipsBar;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlaneCrisisManager;
   import yishi.scene.BaseSceneView;
   
   public class PlaneCrisisSecenView extends BaseSceneView
   {
      
      private var _mapView:PlaneCrisisMapView;
      
      public function PlaneCrisisSecenView()
      {
         super();
      }
      
      private function initView() : void
      {
         if(checkReady())
         {
            trace("planecrisisscence:场景资源错误",PlaneCrisisManager.Instance.model);
            return;
         }
         PlaneCrisisComBitData.Instance.setup();
         _mapView = new PlaneCrisisMapView();
         addChild(_mapView);
      }
      
      private function checkReady() : Boolean
      {
         var _loc1_:Boolean = PlaneCrisisManager.Instance.model == null;
         return _loc1_ || !ClassUtils.uiSourceDomain.hasDefinition("asset.planecrisis.CloudGray");
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      override public function get SceneName() : String
      {
         return "PLANE_CRISRIS";
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         LayerManager.Instance.clearnGameDynamic();
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
         ChatTopBugleView.instance.setPos();
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
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
         PlaneCrisisComBitData.Instance.disposeBitDatas();
         PlaneCrisisManager.Instance.reset();
      }
   }
}

