package artifact
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArtifactManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class ArtifactFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObject;
      
      private var _shopView:ArtifactShopView;
      
      private var _shopBoxView:ArtifactBoxView;
      
      private var _progressBar:ArtifactProgressView;
      
      public function ArtifactFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,875,620);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("view.ArtifactFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.artifact.back");
         _shopView = ComponentFactory.Instance.creat("artifact.ArtifactShopView");
         _shopBoxView = ComponentFactory.Instance.creat("artifact.ArtifactBoxView");
         _progressBar = ComponentFactory.Instance.creat("artifact.ArtifactProgressView");
         addToContent(_bg);
         addToContent(_shopView);
         addToContent(_shopBoxView);
         addToContent(_progressBar);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("ARTIFACT_TEMP_REFRESH",__refreshHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("ARTIFACT_TEMP_REFRESH",__refreshHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __refreshHandler(param1:NotificationEvent = null) : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_shopView);
         _shopView = null;
         ObjectUtils.disposeObject(_shopBoxView);
         _shopBoxView = null;
         ObjectUtils.disposeObject(_progressBar);
         _progressBar = null;
         initView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         var _loc1_:Boolean = false;
         if(ArtifactManager.instance.openArtifact)
         {
            _loc1_ = true;
         }
         if(FrameControllerManager.instance.artifactControler.artifactOpen && _loc1_)
         {
            return;
         }
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_shopView);
         _shopView = null;
         ObjectUtils.disposeObject(_shopBoxView);
         _shopBoxView = null;
         ObjectUtils.disposeObject(_progressBar);
         _progressBar = null;
         super.dispose();
      }
   }
}

