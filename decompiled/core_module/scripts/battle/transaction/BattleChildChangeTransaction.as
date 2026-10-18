package battle.transaction
{
   import battle.BattleManager;
   import com.road.yishi.proto.battle.AwakeInfoMsg;
   import com.road.yishi.proto.battle.AwakeMsg;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.manager.NotificationManager;
   
   public class BattleChildChangeTransaction extends BattleBaseTransaction
   {
      
      public function BattleChildChangeTransaction()
      {
         super();
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
         for each(var _loc5_:AwakeInfoMsg in _loc2_.awake)
         {
            if(_loc5_.hasAwake && _loc5_.hasLivingId)
            {
               _loc3_ = battleModel.getRoleById(_loc5_.livingId);
               _loc4_ = _loc3_ as HeroRoleInfo;
               if(_loc4_ && _loc4_.isChildFake)
               {
                  _loc4_.updateChildAwaken(_loc5_.awake);
                  if(battleModel.selfHero == _loc4_ && _loc4_.awaken == 0 && _loc4_.isChildFake && battleModel.isChildBattle)
                  {
                     NotificationManager.instance.sendNotification("SKILL_ENABLE",false);
                  }
                  if(battleModel.selfChildHeroInfo && battleModel.selfChildHeroInfo == _loc4_ && battleModel.isChildBattle)
                  {
                     _loc4_.updateChildChangeValue(_loc5_.childAwake);
                     NotificationManager.instance.sendNotification("CHILD_AWAKE_SKILL");
                  }
               }
            }
         }
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      override public function getCode() : int
      {
         return 4752;
      }
   }
}

