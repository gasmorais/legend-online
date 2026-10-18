package map.internals.effect
{
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class Earthquake
   {
      
      private static const FRAME_RATE:int = 25;
      
      private static var _timer:Timer;
      
      private static var _displayObject:DisplayObject;
      
      private static var _originalX:int;
      
      private static var _originalY:int;
      
      private static var _intensity:int;
      
      private static var _intensityOffset:int;
      
      public function Earthquake()
      {
         super();
      }
      
      public static function go(param1:DisplayObject, param2:Number = 10, param3:Number = 1) : void
      {
         if(_timer)
         {
            _timer.stop();
         }
         _displayObject = param1;
         _originalX = param1.x;
         _originalY = param1.y;
         _intensity = param2;
         _intensityOffset = param2 / 2;
         var _loc4_:int = 40;
         var _loc5_:int = param3 * 1000 / _loc4_;
         _timer = new Timer(_loc4_,_loc5_);
         _timer.addEventListener("timer",quake);
         _timer.addEventListener("timerComplete",resetImage);
         _timer.start();
      }
      
      private static function quake(param1:TimerEvent) : void
      {
         var _loc3_:int = _originalX + Math.random() * _intensity - _intensityOffset;
         var _loc2_:int = _originalY + Math.random() * _intensity - _intensityOffset;
         _displayObject.x = _loc3_;
         _displayObject.y = _loc2_;
      }
      
      private static function resetImage(param1:TimerEvent = null) : void
      {
         _displayObject.x = _originalX;
         _displayObject.y = _originalY;
         cleanup();
      }
      
      private static function cleanup() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",quake);
            _timer.removeEventListener("timerComplete",resetImage);
         }
         _timer = null;
         _displayObject = null;
      }
   }
}

