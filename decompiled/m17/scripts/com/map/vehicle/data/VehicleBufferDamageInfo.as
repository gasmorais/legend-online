package com.map.vehicle.data
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.manager.TempleteManager;
   
   public class VehicleBufferDamageInfo
   {
      
      public var id:int;
      
      public var isNew:Boolean = false;
      
      public var attackId:int;
      
      public var defanceId:int;
      
      public var buffId:int;
      
      public var damage:int;
      
      public var type:int = 0;
      
      public var state:int;
      
      public var isEffective:Boolean;
      
      private var _timer:Timer;
      
      public var leftTime:int;
      
      public function VehicleBufferDamageInfo()
      {
         super();
      }
      
      public function get buffTemplate() : VehicleSkillBuffTemplate
      {
         return TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(buffId);
      }
      
      public function start() : void
      {
         if(!buffTemplate)
         {
            return;
         }
         leftTime = buffTemplate.Duration / 1000;
         _timer = new Timer(1000);
         _timer.start();
         _timer.addEventListener("timer",__onTimerHandler);
      }
      
      private function __onTimerHandler(param1:TimerEvent) : void
      {
         leftTime = leftTime - 1;
         if(leftTime <= 0)
         {
            leftTime = 0;
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHandler);
            _timer = null;
         }
      }
      
      public function stop() : void
      {
         leftTime = 0;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHandler);
            _timer = null;
         }
      }
   }
}

