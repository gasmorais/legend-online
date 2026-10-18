package battle.transaction
{
   import yishi.comm.PackageIn;
   import yishi.interfaces.ISocketTransaction;
   
   public class BattleBaseTransaction implements ISocketTransaction
   {
      
      protected var _pkg:PackageIn;
      
      public function BattleBaseTransaction()
      {
         super();
      }
      
      public function disposeWhenComplete() : Boolean
      {
         return false;
      }
      
      public function isHandleInQueue() : Boolean
      {
         return false;
      }
      
      public function getCode() : int
      {
         throw new Error("getCode()");
      }
      
      public function handlePackage() : void
      {
      }
      
      public function execute(param1:Object = null) : void
      {
      }
      
      public function configure(param1:Object) : void
      {
         if(_pkg)
         {
            _pkg = null;
         }
         _pkg = param1 as PackageIn;
      }
      
      public function finish() : void
      {
      }
      
      public function get isFinished() : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
      }
   }
}

