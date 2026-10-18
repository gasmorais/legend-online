package battle.transaction
{
   import com.road.yishi.proto.battle.BattlePrepareMsg;
   import yishi.comm.PackageIn;
   import yishi.interfaces.ISocketTransaction;
   
   public class TransactionBase implements ISocketTransaction
   {
      
      protected var _pkg:PackageIn;
      
      protected var _msgPkg:BattlePrepareMsg;
      
      public function TransactionBase()
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
         return 0;
      }
      
      public function handlePackage() : void
      {
      }
      
      public function execute(param1:Object = null) : void
      {
      }
      
      public function configure(param1:Object) : void
      {
         _pkg = param1 as PackageIn;
      }
      
      public function msgPkg(param1:Object) : void
      {
         _msgPkg = param1 as BattlePrepareMsg;
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

