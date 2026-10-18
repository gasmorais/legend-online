package map.internals.transaction
{
   import battle.transaction.TransactionBase;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   
   public class PlayerMovieClipTransaction extends TransactionBase
   {
      
      public function PlayerMovieClipTransaction()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
         NotificationManager.instance.dispatchEvent(new SLGSocketEvent("U_PLAY_MOVIE",_pkg));
      }
      
      override public function getCode() : int
      {
         return 143;
      }
   }
}

