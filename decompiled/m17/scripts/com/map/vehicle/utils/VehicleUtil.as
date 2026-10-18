package com.map.vehicle.utils
{
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class VehicleUtil
   {
      
      public function VehicleUtil()
      {
         super();
      }
      
      public static function getSkillTemplate(param1:int) : VehicleSkillTempInfo
      {
         return TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(param1);
      }
      
      public static function getVehicleObjectTemplate(param1:int) : VehicleObjectTempInfo
      {
         return TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(param1);
      }
      
      public static function getBuffTemplate(param1:int) : VehicleSkillBuffTemplate
      {
         return TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(param1);
      }
   }
}

