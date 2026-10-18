package battle.transaction
{
   import battle.BattleManager;
   import com.road.yishi.proto.battle.AwakeInfoMsg;
   import com.road.yishi.proto.battle.AwakeMsg;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.manager.NotificationManager;
   
   public class BattleAwakenTransaction extends BattleBaseTransaction
   {
      
      private var battleModel:BattleModel;
      
      public function BattleAwakenTransaction()
      {
         super();
         battleModel = BattleManager.getInstance().battleModel;
      }
      
      override public function configure(param1:Object) : void
      {
         var _loc3_:RoleInfo = null;
         var _loc4_:HeroRoleInfo = null;
         super.configure(param1);
         if(!_pkg)
         {
            return;
         }
         var _loc2_:AwakeMsg = new AwakeMsg();
         _loc2_ = _pkg.readBody(_loc2_) as AwakeMsg;
         if(!battleModel)
         {
            return;
         }
         if(battleModel.isChildBattle)
         {
            return;
         }
         if(battleModel.battleType == 3845)
         {
            return;
         }
         for each(var _loc5_:AwakeInfoMsg in _loc2_.awake)
         {
            if(_loc5_.hasAwake && _loc5_.hasLivingId)
            {
               _loc3_ = battleModel.getRoleById(_loc5_.livingId);
               if(_loc3_ && _loc3_ is HeroRoleInfo)
               {
                  _loc4_ = _loc3_ as HeroRoleInfo;
                  _loc4_.updateAwaken(_loc5_.awake);
                  if(BattleManager.getInstance().battleModel.selfHero == _loc4_ && _loc4_.awaken == 0 && _loc4_.isPetState)
                  {
                     NotificationManager.instance.sendNotification("SKILL_ENABLE",false);
                  }
               }
            }
         }
      }
      
      override public function getCode() : int
      {
         return 4600;
      }
   }
}

