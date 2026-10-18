package map.outercity.helper.mapview
{
   import flash.geom.Point;
   import map.outercity.ArchaeologyNodeInfo;
   
   public class OutercityArchaeologyHelper
   {
      
      public function OutercityArchaeologyHelper()
      {
         super();
      }
      
      public static function getDirection(param1:Point, param2:Array) : Number
      {
         var _loc7_:int = 0;
         var _loc3_:ArchaeologyNodeInfo = getNearestNode(param1,param2);
         if(!_loc3_)
         {
            return 0;
         }
         var _loc5_:Number = _loc3_.y * 20 - param1.y;
         var _loc4_:Number = _loc3_.x * 20 - param1.x;
         var _loc8_:Number = Math.atan2(_loc5_,_loc4_);
         return _loc8_ * 180 / 3.141592653589793;
      }
      
      public static function getNearestNode(param1:Point, param2:Array) : ArchaeologyNodeInfo
      {
         var _loc6_:ArchaeologyNodeInfo = null;
         var _loc3_:Number = 1.7976931348623157e+308;
         var _loc4_:Point = new Point(Math.floor(param1.x / 20),Math.floor(param1.y / 20));
         for each(var _loc5_:ArchaeologyNodeInfo in param2)
         {
            if(Point.distance(_loc4_,new Point(_loc5_.x,_loc5_.y)) < _loc3_)
            {
               _loc6_ = _loc5_;
               _loc3_ = Point.distance(_loc4_,new Point(_loc6_.x,_loc6_.y));
            }
         }
         return _loc6_;
      }
      
      public static function getNearestDistance(param1:Point, param2:Array) : Number
      {
         var _loc6_:ArchaeologyNodeInfo = null;
         var _loc3_:Number = 1.7976931348623157e+308;
         var _loc4_:Point = new Point(Math.floor(param1.x / 20),Math.floor(param1.y / 20));
         for each(var _loc5_:ArchaeologyNodeInfo in param2)
         {
            if(Point.distance(_loc4_,new Point(_loc5_.x,_loc5_.y)) < _loc3_)
            {
               _loc6_ = _loc5_;
               _loc3_ = Point.distance(_loc4_,new Point(_loc6_.x,_loc6_.y));
            }
         }
         return _loc3_;
      }
      
      public static function getLightState(param1:Point, param2:Array) : int
      {
         var _loc3_:Number = getNearestDistance(param1,param2);
         if(_loc3_ < 5)
         {
            return 1;
         }
         if(_loc3_ >= 5 && _loc3_ <= 25)
         {
            return 2;
         }
         return 3;
      }
      
      public static function eqOrBigFloat(param1:Number, param2:Number, param3:Number = 1e-12) : Boolean
      {
         return param1 > param2 || eqFloat(param1,param2,param3);
      }
      
      public static function eqOrLittleFloat(param1:Number, param2:Number, param3:Number = 1e-12) : Boolean
      {
         return param1 < param2 || eqFloat(param1,param2,param3);
      }
      
      public static function eqFloat(param1:Number, param2:Number, param3:Number = 1e-12) : Boolean
      {
         return Math.abs(param1 - param2) < param3;
      }
   }
}

