package mvc.module.goddess
{
   import yishi.datas.templates.GoddessTempInfo;
   import yishi.manager.TempleteManager;
   
   public class GoddessFormationInfo
   {
      
      public var userId:int;
      
      public var formationId:int;
      
      public var templateId:int;
      
      public var grade:int;
      
      public var gradeGp:int;
      
      public function GoddessFormationInfo()
      {
         super();
      }
      
      public function get template() : GoddessTempInfo
      {
         return TempleteManager.instance.goddessTempCate.getTemplateById(templateId);
      }
   }
}

