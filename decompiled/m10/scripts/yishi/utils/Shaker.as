package yishi.utils
{
   import battle.events.BattleEvent;
   import battle.view.map.BattleMap;
   import flash.events.Event;
   import flash.filters.BlurFilter;
   import yishi.manager.NotificationManager;
   
   public class Shaker extends LogicObject
   {
      
      private var shakeCount:int = 0;
      
      private var shakeDegree:int = 3;
      
      private var currentShakeCount:int;
      
      private var currentDegree:int;
      
      private var currentDegreeY:int;
      
      private var shakeFlag:int = 0;
      
      private var _target:BattleMap;
      
      private var _blurfilter:BlurFilter;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _age:Number = 0;
      
      public function Shaker(param1:BattleMap, param2:int = 5, param3:int = 15)
      {
         super();
         _target = param1;
         this.shakeCount = param2;
         this.shakeDegree = param3;
         currentDegree = param3;
         currentShakeCount = 0;
         _x = _target.cameraX;
         _y = _target.cameraY;
         param1.addEventListener("enterFrame",__enterFrame);
      }
      
      public function stop() : void
      {
         _target.cameraX = _x;
         _target.cameraY = _y;
         _target.removeEventListener("enterFrame",__enterFrame);
         NotificationManager.instance.dispatchEvent(new BattleEvent("shakeMapComplete",null));
      }
      
      private function __enterFrame(param1:Event) : void
      {
         _age += 0.25;
         if(_age < shakeCount)
         {
            currentDegree = -currentDegree * 0.95;
            _target.cameraX = _x + currentDegree;
            _target.cameraY = _y + currentDegree;
         }
         else
         {
            stop();
         }
      }
   }
}

