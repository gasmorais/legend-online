package map.campaign.mediator.airgarden
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import map.campaign.view.ui.airgarden.AirGardenCampaignRightView;
   import map.campaign.view.ui.airgarden.AirGardenCampaignTopView;
   import yishi.interfaces.IMediator;
   
   public class AirGardenUIMediator implements IMediator
   {
      
      private var _topView:AirGardenCampaignTopView;
      
      private var _rightView:AirGardenCampaignRightView;
      
      public function AirGardenUIMediator()
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
         _topView = new AirGardenCampaignTopView();
         _topView.x = (StageReferance.stageWidth - 394) / 2;
         _topView.show();
         _rightView = new AirGardenCampaignRightView();
         _rightView.x = StageReferance.stageWidth - 202;
         _rightView.y = 200;
         _rightView.show();
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         if(_topView)
         {
            _topView.x = (StageReferance.stageWidth - 394) / 2;
         }
         if(_rightView)
         {
            _rightView.x = StageReferance.stageWidth - 202;
            _rightView.y = 200;
         }
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_topView)
         {
            ObjectUtils.disposeObject(_topView);
         }
         _topView = null;
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
      }
   }
}

