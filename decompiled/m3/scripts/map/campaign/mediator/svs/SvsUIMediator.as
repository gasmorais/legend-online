package map.campaign.mediator.svs
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.SvsCampaignInfo;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.event.SvsEvent;
   import map.campaign.view.ui.svsmap.SvsCampaignInfoView;
   import map.campaign.view.ui.svsmap.SvsManageView;
   import ui.toptoolbar.TopToolsBar;
   import yishi.interfaces.IMediator;
   import yishi.manager.FrameControllerManager;
   
   public class SvsUIMediator implements IMediator
   {
      
      private var _topCenterUI:SvsCampaignInfoView;
      
      private var _rightUI:SvsManageView;
      
      private var _svsCampaignInfo:SvsCampaignInfo;
      
      private var _selfArmy:CampaignArmy;
      
      public function SvsUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _svsCampaignInfo = FrameControllerManager.instance.svsController.model.svsCampaignInfo;
         _topCenterUI = new SvsCampaignInfoView();
         _rightUI = new SvsManageView();
         LayerManager.Instance.addToLayer(_topCenterUI,4,false);
         LayerManager.Instance.addToLayer(_rightUI,4,false,false,0,1);
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         _svsCampaignInfo.addEventListener("SVS_CAMPAIGN_INFO_CHANGE",__svsCampaignInfoHandler);
         TopToolsBar.instance.setBloodIconEnable = false;
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         _selfArmy.addEventListener("IS_DIE",__dieHandler);
         __dieHandler(null);
         __svsCampaignInfoHandler(null);
         __resizeHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         _svsCampaignInfo.removeEventListener("SVS_CAMPAIGN_INFO_CHANGE",__svsCampaignInfoHandler);
         ObjectUtils.disposeObject(_topCenterUI);
         _topCenterUI = null;
         ObjectUtils.disposeObject(_rightUI);
         _rightUI = null;
         TopToolsBar.instance.setBloodIconEnable = true;
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("IS_DIE",__dieHandler);
         }
         _selfArmy = null;
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _topCenterUI.x = (StageReferance.stageWidth - _topCenterUI.width) / 2 >> 0;
         _topCenterUI.y = 10;
         _rightUI.x = StageReferance.stageWidth - _rightUI.width - 10;
         _rightUI.y = 50;
         var _loc2_:int = 332;
         if(_topCenterUI.x < _loc2_)
         {
            _topCenterUI.x = _loc2_;
         }
      }
      
      private function __dieHandler(param1:CampaignMapEvent) : void
      {
         if(CampaignArmyState.checkDied(_selfArmy.isDie))
         {
         }
      }
      
      private function __svsCampaignInfoHandler(param1:SvsEvent) : void
      {
         _topCenterUI.data = _svsCampaignInfo;
      }
   }
}

