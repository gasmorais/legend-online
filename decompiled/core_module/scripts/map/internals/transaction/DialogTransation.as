package map.internals.transaction
{
   import battle.transaction.TransactionBase;
   import yishi.manager.NotificationManager;
   
   public class DialogTransation extends TransactionBase
   {
      
      public function DialogTransation()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
         _pkg.position = 20;
         NotificationManager.instance.sendNotification("SLGSocketEvent" + (138).toString(),_pkg);
      }
      
      override public function getCode() : int
      {
         return 138;
      }
   }
}

