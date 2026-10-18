package mvc.module.proficiency
{
   import yishi.datas.templates.ProficiencyTempInfo;
   import yishi.manager.TempleteManager;
   
   public class ProficiencyModel
   {
      
      public var proficiencyGrade:int;
      
      public var proficiencyValue:int;
      
      public function ProficiencyModel()
      {
         super();
      }
      
      public function get proficiencyTempInfo() : ProficiencyTempInfo
      {
         return TempleteManager.instance.proficiencyTempCate.getTemplateByGrade(proficiencyGrade);
      }
      
      public function get nextTempInfo() : ProficiencyTempInfo
      {
         return TempleteManager.instance.proficiencyTempCate.getTemplateByGrade(proficiencyGrade + 1);
      }
   }
}

