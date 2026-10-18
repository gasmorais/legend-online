package battle.transaction
{
   import battle.BattleManager;
   import battle.handler.IPackageHandler;
   import battle.handler.ReinforceHandler;
   
   public class ReinfoTransaction extends TransactionBase
   {
      
      public function ReinfoTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         if(BattleManager.selfDie)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.isFinishNow)
         {
            return;
         }
         super.configure(param1);
         var _loc2_:IPackageHandler = new ReinforceHandler();
         _loc2_.handle(_pkg);
      }
      
      override public function getCode() : int
      {
         return 72;
      }
      
      override public function handlePackage() : void
      {
      }
   }
}

