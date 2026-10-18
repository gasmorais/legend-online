package map.campaign.mediator.deepprison
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import map.campaign.view.ui.deepprison.DeepPrisonRightUIView;
   import map.campaign.view.ui.deepprison.DeepPrisonUIView;
   import yishi.interfaces.IMediator;
   
   public class DeepPrisonUIMediater implements IMediator
   {
      
      private var _view:DeepPrisonUIView;
      
      private var _rightView:DeepPrisonRightUIView;
      
      public function DeepPrisonUIMediater()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         initView();
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      private function initView() : void
      {
         _view = new DeepPrisonUIView();
         _view.x = 0;
         _view.y = 200;
         LayerManager.Instance.addToLayer(_view,4);
         _rightView = new DeepPrisonRightUIView();
         _rightView.x = StageReferance.stageWidth - 195;
         _rightView.y = 200;
         LayerManager.Instance.addToLayer(_rightView,4);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _view.x = 0;
         _view.y = 200;
         _rightView.x = StageReferance.stageWidth - 195;
         _rightView.y = 200;
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
      }
   }
}

