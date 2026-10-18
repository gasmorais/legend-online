package map.campaign.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import map.campaign.view.ui.CampaignCountDownView;
   import yishi.interfaces.IMediator;
   
   public class CampaignCountDownMediator implements IMediator
   {
      
      private var countDownView:CampaignCountDownView;
      
      public function CampaignCountDownMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         if(countDownView == null)
         {
            countDownView = new CampaignCountDownView();
            LayerManager.Instance.addToLayer(countDownView,4,false,false,0,3);
         }
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         __stageResizeHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         if(countDownView)
         {
            countDownView.dispose();
         }
         countDownView = null;
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         countDownView.x = (StageReferance.stageWidth - countDownView.width) / 2;
         countDownView.y = 100;
      }
   }
}

