package battle.transaction
{
   import com.road.yishi.proto.battle.UserStopMsg;
   import yishi.comm.PackageIn;
   
   public class BattleStopTransaction extends BattleBaseTransaction
   {
      
      public function BattleStopTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         _pkg = null;
         _pkg = param1 as PackageIn;
      }
      
      override public function getCode() : int
      {
         return 69;
      }
      
      override public function handlePackage() : void
      {
         var _loc1_:UserStopMsg = new UserStopMsg();
         _loc1_ = _pkg.readBody(_loc1_) as UserStopMsg;
         var _loc2_:int = _loc1_.type;
         var _loc3_:int = _loc1_.order;
      }
   }
}

