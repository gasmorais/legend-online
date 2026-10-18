package yishi.datas.templates
{
   public class HeroAisTemplate
   {
      
      public var ID:int;
      
      public var Skills:String;
      
      public var CrazySkill:int;
      
      public var BottomSkill:int;
      
      public var BottomSkills:String;
      
      public var DeadSkill:int;
      
      public var LessHpSkill:int;
      
      public var AngrySkill:int;
      
      public var AwakenSkill:int;
      
      public var Soldiers:String;
      
      private var _skills:Array;
      
      public function HeroAisTemplate()
      {
         super();
      }
      
      public function getSkills() : Array
      {
         if(!_skills)
         {
            _skills = [];
            addSkillIds(Skills);
            addSkillId(CrazySkill);
            addSkillId(BottomSkill);
            addSkillIds(BottomSkills);
            addSkillId(DeadSkill);
            addSkillId(LessHpSkill);
            addSkillId(AngrySkill);
            addSkillId(AwakenSkill);
         }
         return _skills;
      }
      
      private function addSkillIds(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         for each(var _loc3_:int in _loc2_)
         {
            addSkillId(_loc3_);
         }
      }
      
      private function addSkillId(param1:int) : void
      {
         if(param1 != 0 && _skills.indexOf(param1) == -1)
         {
            _skills.push(param1);
         }
      }
   }
}

