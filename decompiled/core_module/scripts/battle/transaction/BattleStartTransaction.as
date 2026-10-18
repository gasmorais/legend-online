package battle.transaction
{
   import battle.BattleManager;
   import com.road.yishi.proto.battle.BattleStartMsg;
   import yishi.comm.PackageIn;
   
   public class BattleStartTransaction extends BattleBaseTransaction
   {
      
      public function BattleStartTransaction()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
      }
      
      override public function configure(param1:Object) : void
      {
         _pkg = param1 as PackageIn;
         var _loc2_:BattleStartMsg = new BattleStartMsg();
         _loc2_ = _pkg.readBody(_loc2_) as BattleStartMsg;
         var _loc3_:int = _loc2_.frame;
         BattleManager.getInstance().synchronization = _loc3_;
         var _loc4_:int = _loc2_.mainType;
         BattleManager.getInstance().battleModel.battleType = _loc4_;
         BattleManager.getInstance().battleModel.started = true;
         BattleManager.getInstance().battleModel.hurtUpStart(_loc2_.countDown);
      }
      
      override public function getCode() : int
      {
         return 156;
      }
   }
}

