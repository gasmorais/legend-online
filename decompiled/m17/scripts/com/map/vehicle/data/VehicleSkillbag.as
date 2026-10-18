package com.map.vehicle.data
{
   import com.map.vehicle.events.VehicleEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class VehicleSkillbag extends EventDispatcher
   {
      
      private var _skillDict:Dictionary = new Dictionary(true);
      
      private var _dic:Dictionary = new Dictionary(true);
      
      public function VehicleSkillbag()
      {
         var _loc1_:int = 0;
         super();
         _loc1_ = 1;
         while(_loc1_ < 4)
         {
            _skillDict[_loc1_] = new VehicleSkillInfo();
            _loc1_++;
         }
         _dic[49] = 1;
         _dic[50] = 2;
         _dic[81] = 3;
      }
      
      public function init(param1:PlayerVehicleInfo) : void
      {
         var _loc2_:VehicleSkillInfo = getSkillByPos(1);
         _loc2_.templateId = param1.template.NormalSkill;
         _loc2_.count = _loc2_.tempalte.Maximum;
         _loc2_ = getSkillByPos(2);
         _loc2_.templateId = param1.template.GeniusSkill;
         _loc2_.count = _loc2_.tempalte.Maximum;
      }
      
      public function getSkillByPos(param1:int) : VehicleSkillInfo
      {
         return _skillDict[param1];
      }
      
      public function getSkillByKey(param1:uint) : VehicleSkillInfo
      {
         var _loc2_:int = int(_dic[param1]);
         return getSkillByPos(_loc2_);
      }
      
      public function getSkillInfoByTempId(param1:int) : VehicleSkillInfo
      {
         for each(var _loc2_:VehicleSkillInfo in _skillDict)
         {
            if(_loc2_.templateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function updateSkill(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:VehicleSkillInfo = getSkillInfoByTempId(param1);
         if(_loc4_)
         {
            _loc4_.count = param3;
            if(param2 == 1)
            {
               _loc4_.templateId = 0;
               _loc4_.count = 0;
            }
         }
         else
         {
            _loc4_ = _skillDict[3];
            _loc4_.templateId = param1;
            _loc4_.count = param3;
            _skillDict[3] = _loc4_;
            dispatchEvent(new VehicleEvent("CHANGE_SKILL",_loc4_));
         }
         dispatchEvent(new VehicleEvent("SKILL_INFO_CHANGE",_loc4_));
      }
      
      public function reduceSkillCount(param1:int) : void
      {
         var _loc2_:VehicleSkillInfo = getSkillInfoByTempId(param1);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.count--;
         dispatchEvent(new VehicleEvent("SKILL_INFO_CHANGE",_loc2_));
      }
      
      public function skillStartCD(param1:int) : void
      {
         var _loc2_:VehicleSkillInfo = getSkillInfoByTempId(param1);
         if(_loc2_)
         {
            _loc2_.lastTime = getTimer();
            dispatchEvent(new VehicleEvent("START_CD",param1));
         }
      }
   }
}

