package map.internals.utils
{
   import flash.geom.Point;
   import manager.LanguageMgr;
   
   public class PointUtils
   {
      
      public function PointUtils()
      {
         super();
      }
      
      public static function clonePoint(param1:Point) : Point
      {
         return new Point(param1.x,param1.y);
      }
      
      public static function scaleTransform(param1:Point, param2:int, param3:int) : Point
      {
         return new Point(int(param1.x / param2),int(param1.y / param3));
      }
      
      public static function scaleTransformII(param1:Point, param2:int, param3:int) : Point
      {
         return new Point(int(param1.x * param2),int(param1.y * param3));
      }
      
      public static function strToPoint(param1:String, param2:String) : Point
      {
         var _loc4_:Point = null;
         var _loc5_:String = null;
         var _loc3_:Array = param1.split(param2);
         if(_loc3_.length == 2)
         {
            _loc4_ = new Point(_loc3_[0],_loc3_[1]);
            _loc3_ = [];
            return _loc4_;
         }
         _loc5_ = LanguageMgr.GetTranslation("map.internals.utils.PointUtils.errorTip");
         throw new Error(_loc5_ + " {invalid_utf8=239}{invalid_utf8=188}? " + param1);
      }
      
      public static function XYToString(param1:int, param2:int, param3:String) : String
      {
         return param1 + param3 + param2;
      }
   }
}

