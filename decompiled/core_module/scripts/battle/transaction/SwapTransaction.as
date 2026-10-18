package battle.transaction
{
   import battle.handler.SwapHandler;
   
   public class SwapTransaction extends TransactionBase
   {
      
      public function SwapTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         super.configure(param1);
         new SwapHandler().handle(_pkg);
      }
      
      override public function getCode() : int
      {
         return 4793;
      }
   }
}

