package map.campaign.view.physics
{
   import managers.MonopolySocketOutManager;
   import map.campaign.data.CampaignArmy;
   import yishi.events.NotificationEvent;
   
   public class MonopolyArmyView extends CampaignArmyView
   {
      
      private var _isLock:Boolean = false;
      
      public function MonopolyArmyView()
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      override protected function showAvatar(param1:CampaignArmy) : void
      {
         isMonopoly = true;
         super.showAvatar(param1);
      }
      
      override protected function __lockKeyHandler(param1:NotificationEvent) : void
      {
         super.__lockKeyHandler(param1);
         _isLock = true;
      }
      
      override protected function walkOver() : void
      {
         if(!_isLock)
         {
            MonopolySocketOutManager.sendTriggerEvent();
         }
         super.walkOver();
      }
      
      override protected function setFireView() : void
      {
      }
      
      override protected function clearFireView() : void
      {
      }
   }
}

