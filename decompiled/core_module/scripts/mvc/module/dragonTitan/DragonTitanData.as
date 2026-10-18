package mvc.module.dragonTitan
{
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class DragonTitanData
   {
      
      public var userId:int;
      
      public var templateId:int = 0;
      
      public var starExp:int = 0;
      
      public var starLevel:int = 0;
      
      public var devourTitan:Array = [];
      
      public var skillId:Array = [];
      
      public var attack:int = 0;
      
      public var defence:int = 0;
      
      public var magicAttack:int = 0;
      
      public var magicDefence:int = 0;
      
      public var live:int = 0;
      
      public var forceHit:int = 0;
      
      public var parry:int = 0;
      
      public var strength:int = 0;
      
      public var tenacity:int = 0;
      
      public var reduceResi:int = 0;
      
      public var fireResi:int = 0;
      
      public var waterResi:int = 0;
      
      public var electResi:int = 0;
      
      public var windResi:int = 0;
      
      public var darkResi:int = 0;
      
      public var lightResi:int = 0;
      
      public var penetrate:int = 0;
      
      public var stunAttr:int = 0;
      
      public function DragonTitanData()
      {
         super();
      }
      
      public function getSteps() : int
      {
         return starLevel / 10;
      }
      
      public function getStars() : int
      {
         return starLevel % 10;
      }
      
      public function getSkillTempInfoByTitanId(param1:int) : SkillTempInfo
      {
         if(param1 <= 0)
         {
            return null;
         }
         var _loc3_:DragonTitanTempInfo = TempleteManager.instance.titanTemplateCate.getTemplateById(param1);
         return TempleteManager.instance.getSkillById(parseInt(_loc3_.SkillIds));
      }
   }
}

