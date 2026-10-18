package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   
   public class StelaResistTemplateInfo
   {
      
      public var TemplateId:int;
      
      public var StelaId:int;
      
      public var StrengthLevel:int;
      
      private var _SkillId:int;
      
      private var _skillProtemp:SkillPropertyTempInfo;
      
      public function StelaResistTemplateInfo()
      {
         super();
      }
      
      public function get SkillId() : int
      {
         return _SkillId;
      }
      
      public function set SkillId(param1:int) : void
      {
         if(_SkillId == param1)
         {
            return;
         }
         _SkillId = param1;
         _skillProtemp = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_SkillId);
      }
      
      public function get skillProTempInfo() : SkillPropertyTempInfo
      {
         return _skillProtemp;
      }
   }
}

