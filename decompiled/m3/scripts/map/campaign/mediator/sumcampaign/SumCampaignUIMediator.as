package map.campaign.mediator.sumcampaign
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import map.campaign.view.ui.sumcampaign.SumCampaignListView;
   import yishi.interfaces.IMediator;
   
   public class SumCampaignUIMediator implements IMediator
   {
      
      private var _sumCampaignListView:SumCampaignListView;
      
      public function SumCampaignUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         _sumCampaignListView = new SumCampaignListView();
         _sumCampaignListView.show();
         __resizeHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         ObjectUtils.disposeObject(_sumCampaignListView);
         _sumCampaignListView = null;
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _sumCampaignListView.x = StageReferance.gameStageWidth - _sumCampaignListView.viewWidth;
         _sumCampaignListView.y = (StageReferance.gameStageHeight - _sumCampaignListView.viewHeight) / 2;
      }
   }
}

