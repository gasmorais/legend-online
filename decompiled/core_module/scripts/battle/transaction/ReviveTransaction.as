package battle.transaction
{
   import battle.handler.ReviveHandler;
   
   public class ReviveTransaction extends TransactionBase
   {
      
      public function ReviveTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         super.configure(param1);
         new ReviveHandler().handle(_pkg);
      }
      
      override public function getCode() : int
      {
         return 4795;
      }
   }
}

