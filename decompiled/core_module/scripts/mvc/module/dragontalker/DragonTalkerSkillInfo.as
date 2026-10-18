package mvc.module.dragontalker
{
   public class DragonTalkerSkillInfo
   {
      
      public var index:int;
      
      public var skillPoint:int;
      
      public var hasLearnSkill:String;
      
      public var fastKey:String;
      
      public function DragonTalkerSkillInfo()
      {
         super();
      }
      
      public function get learnSkills() : Array
      {
         return hasLearnSkill.split(",");
      }
      
      public function get fastKeySkills() : Array
      {
         return fastKey.split(",");
      }
   }
}

