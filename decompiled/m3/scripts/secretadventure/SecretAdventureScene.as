package secretadventure
{
   import bag.helper.BagHelper;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.TipsBar;
   import mvc.module.secret.SecretAdventureModel;
   import secretadventure.item.SecretComBitData;
   import secretadventure.map.SecretAdMapView;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.templates.SecretMapLevelTemplate;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PathManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.BaseSceneView;
   
   public class SecretAdventureScene extends BaseSceneView
   {
      
      private var _mapView:SecretAdMapView;
      
      private var _mapAreaType:int;
      
      public function SecretAdventureScene()
      {
         super();
      }
      
      private function initView() : void
      {
         SecretComBitData.Instance.setup();
         _mapView = new SecretAdMapView();
         addChild(_mapView);
      }
      
      override public function get SceneName() : String
      {
         return "SECRET_ADVENTURE_SCENE";
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         LayerManager.Instance.clearnGameDynamic();
         initView();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         doLoadBg();
      }
      
      private function doLoadBg() : void
      {
         var _loc3_:int = int(model.frameInfo.mapId);
         var _loc2_:SecretMapLevelTemplate = TempleteManager.instance.secretMapCate.getTempInfo(_loc3_);
         _mapAreaType = _loc2_.Type;
         var _loc1_:String = PathManager.getSecretSource(_mapAreaType,"map.png");
         LoaderManagerII.instance.load(_loc1_,2,0,onLoadCompleteHandler);
      }
      
      private function onLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Bitmap = null;
         if(param2 is Bitmap)
         {
            _loc3_ = param2 as Bitmap;
            SecretComBitData.Instance.putBitMap(_mapAreaType,_loc3_.bitmapData);
         }
         preLoadingOver();
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
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
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
         if(parent)
         {
            parent.removeChild(this);
         }
         SecretComBitData.Instance.disposeBitDatas();
      }
   }
}

