package battle.handler
{
   import battle.BattleManager;
   import battle.data.SkillData;
   import battle.skillsys.skills.BaseSkill;
   import battle.skillsys.skills.SkillFactory;
   
   public class SkillHandlerII
   {
      
      private var _skill:BaseSkill;
      
      public function SkillHandlerII(param1:SkillData)
      {
         super();
         _skill = SkillFactory.createSkillByData(param1);
      }
      
      public function handler() : void
      {
         BattleManager.getInstance().getSkillSystem().addSkill(_skill);
      }
      
      public function getSkill() : BaseSkill
      {
         if(!_skill)
         {
            throw new Error("SkillHandlerII  getSkill Error ,please check！！！");
         }
         return _skill;
      }
   }
}

