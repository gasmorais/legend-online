package vehicle.daimontrial.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import yishi.manager.PathManager;
   import yishi.view.community.BaseIconView;
   
   public class DaimonTrialLeftView extends Component
   {
      
      private var _mapNameImage:ScaleFrameImage;
      
      private var mapId:int = 3001;
      
      private var _icon:BaseIconView;
      
      public function DaimonTrialLeftView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("DaimonLeftView.MapView");
         _icon.icon = PathManager.mapInstanceBigIconPath(mapId);
         _mapNameImage = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialLeftView.MapNameImage");
         addChild(_icon);
         addChild(_mapNameImage);
      }
      
      private function unitView() : void
      {
         _icon = null;
         _mapNameImage = null;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         unitView();
         super.dispose();
      }
   }
}

