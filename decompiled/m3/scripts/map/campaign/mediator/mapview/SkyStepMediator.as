package map.campaign.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import map.campaign.view.ui.SkyStepView;
   import ui.tasktracebar.TaskTraceBar;
   import yishi.interfaces.IMediator;
   
   public class SkyStepMediator implements IMediator
   {
      
      private var _view:SkyStepView;
      
      public function SkyStepMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _view = new SkyStepView();
         LayerManager.Instance.addToLayer(_view,4,false,false,0,3);
         TaskTraceBar.instance.hide();
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         __stageResizeHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         if(_view)
         {
            _view.dispose();
         }
         _view = null;
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         _view.x = StageReferance.stageWidth - _view.width + 20;
         _view.y = 200;
      }
   }
}

