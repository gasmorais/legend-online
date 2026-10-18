package yishi.datas.consant
{
   public class SkillPriorityType
   {
      
      public static const SUPER_SKILL:int = 3;
      
      public static const SUPER_SKILL_PET:int = 4;
      
      public function SkillPriorityType()
      {
         super();
      }
      
      public static function isSuperSkill(param1:int) : Boolean
      {
         return param1 == 3;
      }
   }
}

