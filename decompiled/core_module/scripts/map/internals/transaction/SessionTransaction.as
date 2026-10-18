package map.internals.transaction
{
   import battle.transaction.TransactionBase;
   import yishi.manager.NotificationManager;
   
   public class SessionTransaction extends TransactionBase
   {
      
      public function SessionTransaction()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
         _pkg.position = 20;
         NotificationManager.instance.sendNotification("SLGSocketEvent" + (126).toString(),_pkg);
      }
      
      override public function getCode() : int
      {
         return 126;
      }
   }
}

