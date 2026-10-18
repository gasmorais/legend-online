package mvc.module.buildings
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.manager.TempleteManager;
   
   public class BuildInfo
   {
      
      public var templateId:int;
      
      private var _sonType:int;
      
      public var buildingId:int;
      
      public var property1:int;
      
      public var property2:int;
      
      public var loadTime:int;
      
      public var result:Boolean;
      
      public var template:BuildingTempInfo;
      
      public function BuildInfo()
      {
         super();
      }
      
      public function get sonType() : int
      {
         return templeteInfo.SonType;
      }
      
      public function set sonType(param1:int) : void
      {
         _sonType = param1;
      }
      
      public function get templeteInfo() : BuildingTempInfo
      {
         if(templateId > 100)
         {
            return TempleteManager.instance.buildTemplateCate.getTemplateByID(templateId);
         }
         return template;
      }
      
      public function get nextTemplateInfo() : BuildingTempInfo
      {
         return TempleteManager.instance.buildTemplateCate.getTemplateByID(templeteInfo.NextGradeTemplateId);
      }
      
      public function synchronization(param1:BuildInfo) : void
      {
         this.templateId = param1.templateId;
         this.property1 = param1.property1;
         this.property2 = param1.property2;
      }
      
      public function getNextNeedResource(param1:BuildingTempInfo) : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary();
         _loc2_["CrystalsConsume"] = param1.CrystalsConsume;
         _loc2_["GoldConsume"] = param1.GoldConsume;
         _loc2_["PopuliationConsume"] = param1.PopuliationConsume;
         return _loc2_;
      }
   }
}

