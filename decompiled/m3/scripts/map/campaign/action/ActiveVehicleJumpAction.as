package map.campaign.action
{
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.ActiveVehicleArmyView;
   import yishi.actions.map.MapBaseAction;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.interfaces.IAction;
   import yishi.scene.SceneManager;
   
   public class ActiveVehicleJumpAction extends MapBaseAction
   {
      
      private var _shooter:ActiveVehicleArmyView;
      
      private var _skillId:int;
      
      private var _model:CampaignMapModel;
      
      private var _mapView:CampaignMapView;
      
      private var _controller:CampaignMapController;
      
      private var _skillTempInfo:VehicleSkillTempInfo;
      
      private var _attackArmyInfo:CampaignArmy;
      
      private var _startTime:int;
      
      public function ActiveVehicleJumpAction(param1:ActiveVehicleArmyView)
      {
         super();
         _shooter = param1;
         _attackArmyInfo = _shooter.data;
         _model = CampaignManager.instance.mapModel;
         _mapView = CampaignManager.instance.mapView;
         _controller = CampaignManager.instance.controller;
      }
      
      override public function dispose() : void
      {
         if(_shooter)
         {
            _shooter.isJump = false;
         }
         if(_attackArmyInfo)
         {
            _attackArmyInfo.isJumping = false;
            _attackArmyInfo = null;
         }
         _skillId = 0;
         _skillTempInfo = null;
         _model = null;
         _mapView = null;
         _controller = null;
         _shooter = null;
         super.dispose();
      }
      
      override public function prepare() : void
      {
         if(finished)
         {
            return;
         }
         _attackArmyInfo.isJumping = true;
         _shooter.isJump = true;
         _shooter.changeBodyState();
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            finished = true;
         }
         if(_shooter && _shooter.tank)
         {
            if(_shooter.tank.currentLabel.indexOf(ActiveVehicleArmyView.JUMP) == -1)
            {
               _attackArmyInfo.isJumping = false;
               _shooter.isJump = false;
               _shooter.changeBodyState();
               finished = true;
            }
         }
         super.update();
      }
      
      override public function get type() : String
      {
         return "ActiveVehicleJumpAction";
      }
      
      override public function filter(param1:IAction) : Boolean
      {
         if(param1 is ActiveVehicleJumpAction)
         {
            return true;
         }
         return false;
      }
   }
}

