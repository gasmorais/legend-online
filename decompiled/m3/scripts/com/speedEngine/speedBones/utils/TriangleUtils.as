package com.speedEngine.speedBones.utils
{
   import flash.geom.Point;
   
   public class TriangleUtils
   {
      
      private static var _pointA:Point = new Point();
      
      private static var _pointB:Point = new Point();
      
      private static var _pointC:Point = new Point();
      
      private static var _pointD:Point = new Point();
      
      private static var _point:Point = new Point();
      
      public function TriangleUtils()
      {
         super();
      }
      
      public static function check(param1:Vector.<Number>, param2:Point) : Boolean
      {
         var _loc3_:int = param1.length / 8;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _point.copyFrom(param2);
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc4_ * 8;
            _pointA.x = param1[_loc5_];
            _pointA.y = -param1[_loc5_ + 1];
            _pointB.x = param1[_loc5_ + 2];
            _pointB.y = -param1[_loc5_ + 3];
            _pointC.x = param1[_loc5_ + 4];
            _pointC.y = -param1[_loc5_ + 5];
            _pointD.x = param1[_loc5_ + 6];
            _pointD.y = -param1[_loc5_ + 7];
            if(isInsideTriangle(_pointA,_pointD,_pointB,_point))
            {
               return true;
            }
            if(isInsideTriangle(_pointB,_pointC,_pointD,_point))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private static function isInsideTriangle(param1:Point, param2:Point, param3:Point, param4:Point) : Boolean
      {
         var _loc5_:Number = (param1.x - param4.x) * (param2.y - param4.y) - (param2.x - param4.x) * (param1.y - param4.y);
         var _loc6_:Number = (param2.x - param4.x) * (param3.y - param4.y) - (param3.x - param4.x) * (param2.y - param4.y);
         var _loc7_:Number = (param3.x - param4.x) * (param1.y - param4.y) - (param1.x - param4.x) * (param3.y - param4.y);
         return sign(_loc5_) == sign(_loc6_) && sign(_loc6_) == sign(_loc7_);
      }
      
      private static function sign(param1:Number) : int
      {
         return param1 == 0 ? -1 : Math.abs(param1) / param1;
      }
   }
}

