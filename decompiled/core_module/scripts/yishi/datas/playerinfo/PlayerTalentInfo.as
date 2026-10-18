package yishi.datas.playerinfo
{
   import yishi.datas.templates.EffectTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public dynamic class PlayerTalentInfo
   {
      
      public var id:int;
      
      public var userId:int;
      
      public var templateId:int;
      
      public var createDate:Date = new Date();
      
      public var validityDate:Date = new Date();
      
      public var grades:int;
      
      public var needDower:int;
      
      public var isExist:Boolean;
      
      public function PlayerTalentInfo()
      {
         super();
      }
      
      public function get templateInfo() : EffectTemplateInfo
      {
         return TempleteManager.instance.effectTemplateCate.getTemplateByID(templateId);
      }
   }
}

