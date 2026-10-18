package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   
   public class DreamArenaTempInfo
   {
      
      public var TemplateId:int;
      
      public var Type:int;
      
      public var TypeTemplateId:int;
      
      public var PropertyId:int;
      
      public var Skill1:String;
      
      public var Skill2:String;
      
      public var Skill3:String;
      
      public var Skill4:String;
      
      public var PassiveSkill1:String;
      
      public var PassiveSkill2:String;
      
      public var Param1:String;
      
      public var Param2:String;
      
      public function DreamArenaTempInfo()
      {
         super();
      }
      
      public function get typeTempInfo() : Object
      {
         switch(Type - 1)
         {
            case 0:
               if(TypeTemplateId == 0)
               {
                  return null;
               }
               return TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(TypeTemplateId);
               break;
            case 1:
               return TempleteManager.instance.petTemplateCate.getTemplateById(TypeTemplateId);
            case 2:
            case 3:
               return TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(TypeTemplateId,12);
            case 4:
               return TempleteManager.instance.goddessTempCate.getTemplateById(TypeTemplateId);
            case 5:
               return TempleteManager.instance.artifactTemplateCate.getTemplateById(TypeTemplateId);
            case 6:
               return TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(TypeTemplateId,5);
            case 7:
               return TempleteManager.instance.goodsTemplateCate.getTemplateByID(TypeTemplateId);
            case 8:
               return TempleteManager.instance.getRuneTemplateByTid(TypeTemplateId);
            default:
               return null;
         }
      }
   }
}

