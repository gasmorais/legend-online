package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   
   public class GoddessAdvaceTempInfo
   {
      
      public var Type:int;
      
      public var Level:int;
      
      public var Star:int;
      
      public var NeedItemId:int;
      
      public var NeedGp:int;
      
      public var AddPer:int;
      
      public var SkillId:int;
      
      public var InitBelief:int;
      
      public var ActionBelief:int;
      
      public var NeedGrade:int;
      
      public var Quality:int = 1;
      
      public function GoddessAdvaceTempInfo()
      {
         super();
      }
      
      public function get skillTemp() : SkillTempInfo
      {
         return TempleteManager.instance.getSkillTemplateInfoById(SkillId);
      }
   }
}

