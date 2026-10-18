package map.campaign.mediator.emedream
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.ui.pvpmap.PvpPlayerRiverView;
   import yishi.interfaces.IMediator;
   
   public class EmeDreamRiverMediator implements IMediator
   {
      
      private var _riverView:PvpPlayerRiverView;
      
      private var _selfArmy:CampaignArmy;
      
      public function EmeDreamRiverMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         if(_selfArmy)
         {
            _selfArmy.addEventListener("IS_DIE",__dieHandler);
            StageReferance.stage.addEventListener("resize",__resizeHandler);
            __dieHandler(null);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("IS_DIE",__dieHandler);
         }
         _selfArmy = null;
         if(_riverView)
         {
            _riverView.dispose();
         }
         _riverView = null;
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         if(_riverView)
         {
            _riverView.x = StageReferance.stageWidth - _riverView.width >> 1;
            _riverView.y = StageReferance.stageHeight - _riverView.height - 55;
         }
      }
      
      private function __dieHandler(param1:CampaignMapEvent) : void
      {
         if(CampaignArmyState.checkDied(_selfArmy.isDie))
         {
            if(!_riverView)
            {
               _riverView = new PvpPlayerRiverView();
            }
            _riverView.riverTime = _selfArmy.riverTime / 1000;
            LayerManager.Instance.addToLayer(_riverView,4,false,false,0,2);
            _riverView.x = StageReferance.stageWidth - _riverView.width >> 1;
            _riverView.y = StageReferance.stageHeight - _riverView.height - 55;
         }
         else
         {
            if(_riverView)
            {
               _riverView.dispose();
            }
            _riverView = null;
         }
      }
   }
}

