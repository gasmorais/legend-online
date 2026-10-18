package battle.skillsys.skills
{
   import battle.BattleManager;
   import battle.view.roles.RoleViewBase;
   import yishi.utils.TimerUtils;
   
   public class SpecialActionSkill105 extends CommonActionSkill
   {
      
      public function SpecialActionSkill105()
      {
         super();
      }
      
      override protected function startRun() : void
      {
         addPrepareGas();
         super.startRun();
      }
      
      private function addPrepareGas() : void
      {
         var clearCollection:* = function():void
         {
            heroView.removeCollectionEffect();
         };
         var heroView:RoleViewBase = RoleViewBase(BattleManager.getInstance().battleMap.rolesDict[BattleManager.getInstance().battleModel.selfHero.livingId]);
         heroView.addCollectionEffect();
         TimerUtils.setTimeout(clearCollection,2000);
      }
   }
}

