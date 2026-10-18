package com.map.vehicle.data
{
   import com.map.vehicle.events.VehicleEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class VehicleSkillInfo extends EventDispatcher
   {
      
      public static const LOCK:int = 0;
      
      public static const UNLOCK:int = 1;
      
      public static const USED:int = 2;
      
      public var state:int = 0;
      
      public var templateId:int;
      
      public var count:int;
      
      public var pos:int;
      
      public var shortCutKey:uint;
      
      public var lastTime:Number;
      
      public function VehicleSkillInfo()
      {
         super();
      }
      
      public function get icon() : String
      {
         if(tempalte)
         {
            return tempalte.Icons;
         }
         return "";
      }
      
      public function get tempalte() : VehicleSkillTempInfo
      {
         return TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(templateId);
      }
      
      public function commit() : void
      {
         dispatchEvent(new VehicleEvent("SKILL_INFO_CHANGE",this));
      }
   }
}

