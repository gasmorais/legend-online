package map.campaign.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import map.campaign.view.ui.TrailView;
   import ui.tasktracebar.TaskTraceBar;
   import yishi.interfaces.IMediator;
   
   public class TrailMapMediator implements IMediator
   {
      
      private var _trailView:TrailView;
      
      public function TrailMapMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _trailView = new TrailView();
         LayerManager.Instance.addToLayer(_trailView,4,false,false,0,3);
         TaskTraceBar.instance.hide();
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         __stageResizeHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         if(_trailView)
         {
            _trailView.dispose();
         }
         _trailView = null;
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         _trailView.x = StageReferance.stageWidth - 100;
         _trailView.y = 150;
      }
   }
}

