package map.campaign.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import map.campaign.CampaignManager;
   import map.internals.view.frame.WoundInfoView;
   import yishi.interfaces.IMediator;
   
   public class WorldBossWoundMediator implements IMediator
   {
      
      private var _woundInfoView:WoundInfoView;
      
      public function WorldBossWoundMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _woundInfoView = new WoundInfoView();
         _woundInfoView.y = 182;
         _woundInfoView.model = CampaignManager.instance.worldBossModel;
         _woundInfoView.addEventListener("addedToStage",__onAddToStage);
         LayerManager.Instance.addToLayer(_woundInfoView,4,false,false,0,3);
         StageReferance.addEventListener("resize",__stageResizeHandler);
         __stageResizeHandler(null);
      }
      
      private function __onAddToStage(param1:Event) : void
      {
         if(CampaignManager.instance.exit)
         {
            unregister(null);
         }
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         _woundInfoView.x = StageReferance.stageWidth - _woundInfoView.width - 5;
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.removeEventListener("resize",__stageResizeHandler);
         if(_woundInfoView)
         {
            _woundInfoView.removeEventListener("addedToStage",__onAddToStage);
            if(_woundInfoView.parent)
            {
               _woundInfoView.parent.removeChild(_woundInfoView);
            }
            _woundInfoView.dispose();
         }
         _woundInfoView = null;
      }
   }
}

