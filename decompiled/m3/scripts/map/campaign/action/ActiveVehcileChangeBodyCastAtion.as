package map.campaign.action
{
   import map.campaign.data.CampaignArmy;
   import yishi.actions.map.MapBaseAction;
   import yishi.interfaces.IAction;
   import yishi.scene.SceneManager;
   
   public class ActiveVehcileChangeBodyCastAtion extends MapBaseAction
   {
      
      private var _armyInfo:CampaignArmy;
      
      public function ActiveVehcileChangeBodyCastAtion(param1:CampaignArmy)
      {
         super();
         _armyInfo = param1;
      }
      
      override public function prepare() : void
      {
         if(finished)
         {
            return;
         }
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            finished = true;
         }
         if(_armyInfo.activeCurHp <= 0)
         {
            finished = true;
         }
         if(_armyInfo.isStun)
         {
            finished = true;
         }
         super.update();
      }
      
      override public function dispose() : void
      {
         _armyInfo = null;
         finished = true;
         super.dispose();
      }
      
      override public function get type() : String
      {
         return "ActiveVehcileChangeBodyCastAtion";
      }
      
      override public function replace(param1:IAction) : Boolean
      {
         if(param1 is ActiveVehicleJumpCastAction)
         {
            return true;
         }
         if(param1 is ActiveVehicleJumpAction)
         {
            return true;
         }
         return false;
      }
      
      override public function filter(param1:IAction) : Boolean
      {
         if(param1 is ActiveVehcileChangeBodyCastAtion)
         {
            return true;
         }
         return false;
      }
   }
}

