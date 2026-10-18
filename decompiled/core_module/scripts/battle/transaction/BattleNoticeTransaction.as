package battle.transaction
{
   import battle.BattleManager;
   import com.road.yishi.proto.battle.BattleNoticeMsg;
   import yishi.datas.BattleModel;
   
   public class BattleNoticeTransaction extends TransactionBase
   {
      
      public function BattleNoticeTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         super.configure(param1);
         var _loc2_:BattleNoticeMsg = new BattleNoticeMsg();
         _loc2_ = _pkg.readBody(_loc2_) as BattleNoticeMsg;
         if(battleModel && battleModel.battleId == _loc2_.battleId)
         {
            battleModel.hurtUpStart(_loc2_.countDown,_loc2_.damageImprove,_loc2_.damageAddition);
         }
      }
      
      override public function getCode() : int
      {
         return 4361;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
   }
}

