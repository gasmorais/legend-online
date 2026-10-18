package map.campaign.view.physics
{
   import map.campaign.data.CampaignArmy;
   
   public class HouseArmyView extends CampaignArmyView
   {
      
      public function HouseArmyView()
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      override protected function showAvatar(param1:CampaignArmy) : void
      {
         param1.mountTemplateId = 0;
         super.showAvatar(param1);
      }
   }
}

