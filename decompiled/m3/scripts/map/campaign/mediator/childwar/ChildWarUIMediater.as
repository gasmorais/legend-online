package map.campaign.mediator.childwar
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import map.campaign.view.ui.childwar.ChildWarUIView;
   import yishi.interfaces.IMediator;
   
   public class ChildWarUIMediater implements IMediator
   {
      
      private var _view:ChildWarUIView;
      
      public function ChildWarUIMediater()
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
         _view = new ChildWarUIView();
         _view.x = StageReferance.stageWidth - 265;
         _view.y = 200;
         LayerManager.Instance.addToLayer(_view,4);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _view.x = StageReferance.stageWidth - 265;
         _view.y = 200;
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
      }
   }
}

