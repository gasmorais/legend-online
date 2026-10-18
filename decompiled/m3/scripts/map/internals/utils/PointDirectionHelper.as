package map.internals.utils
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class PointDirectionHelper
   {
      
      public static const L_T:String = "L_T";
      
      public static const T:String = "T";
      
      public static const R_T:String = "R_T";
      
      public static const R:String = "R";
      
      public static const R_B:String = "R_B";
      
      public static const B:String = "B";
      
      public static const L_B:String = "L_B";
      
      public static const L:String = "L";
      
      private static var _pointDic:Dictionary;
      
      public function PointDirectionHelper()
      {
         super();
      }
      
      public static function getPointsBy(param1:Point, param2:Point) : Array
      {
         var _loc3_:String = getDirectionType(param1,param2);
         return getPointsByType(_loc3_);
      }
      
      public static function getPointBy8Dier() : Array
      {
         if(!_pointDic)
         {
            initPoint();
         }
         var _loc1_:Array = [];
         for each(var _loc2_:Array in _pointDic)
         {
            _loc1_ = _loc1_.concat(_loc2_);
         }
         return _loc1_;
      }
      
      public static function getDirectionType(param1:Point, param2:Point) : String
      {
         if(param1.x > param2.x)
         {
            if(param1.y < param2.y)
            {
               return "L_B";
            }
            if(param1.y == param2.y)
            {
               return "L";
            }
            return "L_T";
         }
         if(param1.x < param2.x)
         {
            if(param1.y < param2.y)
            {
               return "R_B";
            }
            if(param1.y == param2.y)
            {
               return "R";
            }
            return "R_T";
         }
         if(param1.y < param2.y)
         {
            return "B";
         }
         if(param1.y > param2.y)
         {
            return "T";
         }
         return "";
      }
      
      private static function getPointsByType(param1:String) : Array
      {
         if(!_pointDic)
         {
            initPoint();
         }
         return _pointDic[param1] as Array;
      }
      
      private static function initPoint() : void
      {
         var _loc1_:Point = null;
         _pointDic = new Dictionary();
         var _loc2_:Array = [];
         _loc1_ = new Point(-2,-2);
         _loc2_.push(_loc1_);
         _loc1_ = new Point(-2,-1);
         _loc2_.push(_loc1_);
         _loc1_ = new Point(-1,-2);
         _loc2_.push(_loc1_);
         _pointDic["L_T"] = _loc2_;
         _loc2_ = [];
         _loc1_ = new Point(0,-2);
         _loc2_.push(_loc1_);
         _pointDic["T"] = _loc2_;
         _loc2_ = [];
         _loc1_ = new Point(1,-2);
         _loc2_.push(_loc1_);
         _loc1_ = new Point(2,-2);
         _loc2_.push(_loc1_);
         _loc1_ = new Point(2,-1);
         _loc2_.push(_loc1_);
         _pointDic["R_T"] = _loc2_;
         _loc2_ = [];
         _loc1_ = new Point(-2,0);
         _loc2_.push(_loc1_);
         _pointDic["L"] = _loc2_;
         _loc2_ = [];
         _loc1_ = new Point(-2,1);
         _loc2_.push(_loc1_);
         _loc1_ = new Point(-2,2);
         _loc2_.push(_loc1_);
         _loc1_ = new Point(-1,2);
         _loc2_.push(_loc1_);
         _pointDic["L_B"] = _loc2_;
         _loc2_ = [];
         _loc1_ = new Point(0,2);
         _loc2_.push(_loc1_);
         _pointDic["B"] = _loc2_;
         _loc2_ = [];
         _loc1_ = new Point(1,2);
         _loc2_.push(_loc1_);
         _loc1_ = new Point(2,2);
         _loc2_.push(_loc1_);
         _loc1_ = new Point(2,1);
         _loc2_.push(_loc1_);
         _pointDic["R_B"] = _loc2_;
         _loc2_ = [];
         _loc1_ = new Point(2,0);
         _loc2_.push(_loc1_);
         _pointDic["R"] = _loc2_;
      }
   }
}

