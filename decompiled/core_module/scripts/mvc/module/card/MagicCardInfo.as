package mvc.module.card
{
   import yishi.datas.templates.MagicCardTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class MagicCardInfo
   {
      
      public var templateId:int;
      
      public var grades:int;
      
      public var gp:int;
      
      public var pos:int;
      
      public var skillTempIds:String;
      
      public var types:int;
      
      public var templateName:String;
      
      public var isActive:Boolean;
      
      public function MagicCardInfo()
      {
         super();
      }
      
      public function get magicCardTemplate() : MagicCardTemplateInfo
      {
         return TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(types,pos,grades);
      }
   }
}

