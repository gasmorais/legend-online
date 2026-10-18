package yishi.datas.battle
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BattleCooldownModel
   {
      
      public var templateId:int;
      
      public var cooldown:int;
      
      public var appearCoolDown:int;
      
      public var coolType:int;
      
      private var _timer:Timer;
      
      public function BattleCooldownModel()
      {
         super();
      }
      
      public function start() : void
      {
         _timer = new Timer(1000);
         _timer.addEventListener("timer",onTimer);
         _timer.start();
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         if(cooldown > 1)
         {
            cooldown = cooldown - 1;
         }
         if(appearCoolDown > 1)
         {
            appearCoolDown = appearCoolDown - 1;
         }
         if(cooldown <= 1 && appearCoolDown <= 1)
         {
            stop();
         }
      }
      
      public function stop() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTimer);
            _timer = null;
         }
      }
   }
}

