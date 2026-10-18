package com.map.vehicle.data
{
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class UseSkillInfo
   {
      
      public var casterId:int;
      
      private var _skillId:int;
      
      public var effectX:int;
      
      public var effectY:int;
      
      public var npcHurt:Vector.<HurtData> = new Vector.<HurtData>();
      
      public var playerHurt:Vector.<HurtData> = new Vector.<HurtData>();
      
      public var skillTemplate:VehicleSkillTempInfo;
      
      public function UseSkillInfo()
      {
         super();
      }
      
      public function get skillId() : int
      {
         return _skillId;
      }
      
      public function set skillId(param1:int) : void
      {
         _skillId = param1;
         skillTemplate = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(skillId);
      }
   }
}

