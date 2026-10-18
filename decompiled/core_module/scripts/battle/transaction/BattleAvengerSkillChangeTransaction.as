package battle.transaction
{
   import battle.BattleManager;
   import com.road.yishi.proto.avenger.AvengerBattleSkillMsg;
   import yishi.datas.BattleModel;
   import yishi.events.RoleEvent;
   
   public class BattleAvengerSkillChangeTransaction extends TransactionBase
   {
      
      public function BattleAvengerSkillChangeTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         super.configure(param1);
         var _loc2_:AvengerBattleSkillMsg = new AvengerBattleSkillMsg();
         _loc2_ = _pkg.readBody(_loc2_) as AvengerBattleSkillMsg;
         if(battleModel && battleModel.selfHero)
         {
            battleModel.selfHero.avengerFightSkills = _loc2_.avengerSkills;
            battleModel.selfHero.avengerAllSkills = _loc2_.avengerAllSkills;
            battleModel.selfHero.avengerWaitSec = _loc2_.avengerLeftCd;
            battleModel.selfHero.dispatchEvent(new RoleEvent("AVENGER_SKILL_CHANGE",null));
         }
      }
      
      override public function getCode() : int
      {
         return 4591;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
   }
}

