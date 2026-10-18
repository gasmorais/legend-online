package map.campaign.mediator.pvp
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.PvpWarFightInfo;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.event.PvpWarFightEvent;
   import map.campaign.view.ui.pvpmap.PvpMapRightView;
   import map.campaign.view.ui.pvpmap.PvpMapTopCenterView;
   import map.campaign.view.ui.pvpmap.PvpPlayerRiverView;
   import ui.toptoolbar.TopToolsBar;
   import yishi.interfaces.IMediator;
   
   public class PvpUIMediator implements IMediator
   {
      
      private var _topCenterUI:PvpMapTopCenterView;
      
      private var _rightUI:PvpMapRightView;
      
      private var _pvpWarFightInfo:PvpWarFightInfo;
      
      private var _riverView:PvpPlayerRiverView;
      
      private var _selfArmy:CampaignArmy;
      
      public function PvpUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _pvpWarFightInfo = pvpWarFightInfo;
         _topCenterUI = new PvpMapTopCenterView();
         _rightUI = new PvpMapRightView();
         LayerManager.Instance.addToLayer(_topCenterUI,4,false);
         LayerManager.Instance.addToLayer(_rightUI,4,false);
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         _pvpWarFightInfo.addEventListener("PVP_WAR_FIGHT_INFO_CHAGE",__pvpWarFightInfoHandler);
         TopToolsBar.instance.setBloodIconEnable = false;
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         _selfArmy.addEventListener("IS_DIE",__dieHandler);
         __dieHandler(null);
         __pvpWarFightInfoHandler(null);
         __resizeHandler(null);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _topCenterUI.y = 10;
         _topCenterUI.x = (StageReferance.stageWidth - _topCenterUI.width) / 2 >> 0;
         _rightUI.x = StageReferance.stageWidth - _rightUI.width - 10 >> 0;
         _rightUI.y = 245;
         if(_riverView)
         {
            _riverView.x = StageReferance.stageWidth - _riverView.width >> 1;
            _riverView.y = StageReferance.stageHeight - _riverView.height - 55;
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_topCenterUI)
         {
            _topCenterUI.dispose();
         }
         _topCenterUI = null;
         if(_rightUI)
         {
            _rightUI.dispose();
         }
         _rightUI = null;
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         _pvpWarFightInfo.removeEventListener("PVP_WAR_FIGHT_INFO_CHAGE",__pvpWarFightInfoHandler);
         TopToolsBar.instance.setBloodIconEnable = true;
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
      
      private function __dieHandler(param1:CampaignMapEvent) : void
      {
         if(CampaignArmyState.checkDied(_selfArmy.isDie))
         {
            if(!_riverView)
            {
               _riverView = new PvpPlayerRiverView();
            }
            _riverView.riverTime = _selfArmy.riverTime / 1000;
            LayerManager.Instance.addToLayer(_riverView,4,false);
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
      
      private function __pvpWarFightInfoHandler(param1:PvpWarFightEvent) : void
      {
         _topCenterUI.data = pvpWarFightInfo;
         _rightUI.data = pvpWarFightInfo;
      }
      
      private function get pvpWarFightInfo() : PvpWarFightInfo
      {
         return CampaignManager.instance.pvpWarFightModel.pvpWarFightInfo;
      }
   }
}

