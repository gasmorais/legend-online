package battle.transaction
{
   import battle.BattleManager;
   import com.road.yishi.proto.battle.AttackModeMsg;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   
   public class AttackModeTransaction extends TransactionBase
   {
      
      public function AttackModeTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         super.configure(param1);
         var _loc2_:AttackModeMsg = new AttackModeMsg();
         _loc2_ = _pkg.readBody(_loc2_) as AttackModeMsg;
         var _loc3_:RoleInfo = battleModel.getRoleInfoByUserId(_loc2_.userId);
         var _loc4_:int = _loc2_.heroSp;
         if(_loc3_)
         {
            battleModel.setAttackModelById(_loc3_.livingId,_loc2_.mode);
            if(_loc3_ == battleModel.selfHero)
            {
               battleModel.actionCount = _loc2_.fmTurn;
               if(_loc4_ > 0)
               {
                  HeroRoleInfo(_loc3_).updateSp(HeroRoleInfo(_loc3_).sp + _loc4_);
               }
            }
         }
      }
      
      override public function getCode() : int
      {
         return 77;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
   }
}

