package map.internals.transaction
{
   import battle.transaction.TransactionBase;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   
   public class MoveCampaignSceneTransaction extends TransactionBase
   {
      
      public function MoveCampaignSceneTransaction()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
         NotificationManager.instance.dispatchEvent(new SLGSocketEvent("SLGSocketEvent" + (142).toString(),_pkg));
      }
      
      override public function getCode() : int
      {
         return 142;
      }
   }
}

