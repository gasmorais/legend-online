package map.campaign.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.Event;
   import ui.tasktracebar.TaskTraceBar;
   import yishi.interfaces.IMediator;
   
   public class CampaignBuffShopMediator implements IMediator
   {
      
      public function CampaignBuffShopMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         TaskTraceBar.instance.hide();
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         __stageResizeHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
      }
   }
}

