package yishi.utils
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class ShakeCircle
   {
      
      private var _t:Number;
      
      private var _dobj:DisplayObject;
      
      private var _r:Number;
      
      private var _centerPoint:Point = new Point();
      
      private var _shakeCount:int;
      
      private var _currentShakeCount:int;
      
      public function ShakeCircle(param1:DisplayObject, param2:Number = 3, param3:int = 7)
      {
         super();
         _dobj = param1;
         _r = param2;
         _currentShakeCount = _shakeCount = param3;
         _centerPoint.x = param1.x;
         _centerPoint.y = param1.y;
      }
      
      public function shake() : void
      {
         stop();
         _currentShakeCount = _shakeCount;
         _dobj.addEventListener("enterFrame",__enterFrame);
         updataPosition();
      }
      
      private function updataPosition() : void
      {
         _t = Math.random() * 3.141592653589793 * 2;
         _dobj.x = _r * Math.sin(_t) + _centerPoint.x;
         _dobj.y = _r * Math.cos(_t) + _centerPoint.y;
      }
      
      protected function __enterFrame(param1:Event) : void
      {
         updataPosition();
         _currentShakeCount = _currentShakeCount - 1;
         if(_currentShakeCount <= 0)
         {
            stop();
         }
      }
      
      public function stop() : void
      {
         _dobj.x = _centerPoint.x;
         _dobj.y = _centerPoint.y;
         _dobj.removeEventListener("enterFrame",__enterFrame);
      }
   }
}

