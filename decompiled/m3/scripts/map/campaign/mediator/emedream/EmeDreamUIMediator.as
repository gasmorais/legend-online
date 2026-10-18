package map.campaign.mediator.emedream
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import map.campaign.view.ui.emedream.EmeDreamTaskView;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.interfaces.IMediator;
   import yishi.manager.ConsortiaManager;
   
   public class EmeDreamUIMediator implements IMediator
   {
      
      private var _model:ConsortiaModel;
      
      private var _taskView:EmeDreamTaskView;
      
      public function EmeDreamUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         initUI();
      }
      
      private function initUI() : void
      {
         _model = ConsortiaManager.instance.model;
         _taskView = new EmeDreamTaskView();
         _taskView.x = StageReferance.stageWidth - 230;
         _taskView.y = 250;
         LayerManager.Instance.addToLayer(_taskView,4);
      }
      
      public function unregister(param1:Object) : void
      {
         if(_taskView)
         {
            ObjectUtils.disposeObject(_taskView);
         }
         _taskView = null;
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         _model = null;
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         if(_taskView)
         {
            _taskView.x = StageReferance.stageWidth - 230;
            _taskView.y = 250;
         }
      }
   }
}

