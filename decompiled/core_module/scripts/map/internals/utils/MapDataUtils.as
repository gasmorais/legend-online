package map.internals.utils
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class MapDataUtils
   {
      
      public function MapDataUtils()
      {
         super();
      }
      
      public static function getTiles(param1:int, param2:int, param3:int, param4:int) : Point
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _loc5_ = Math.floor(param3 / param1);
         _loc6_ = Math.floor(param4 / param2);
         return new Point(_loc5_,_loc6_);
      }
      
      public static function getFileName(param1:int, param2:int, param3:int = 1000, param4:int = 1000) : String
      {
         var _loc5_:int = Math.floor(param1 / param3);
         var _loc6_:int = Math.floor(param2 / param4);
         return _loc5_ + "," + _loc6_;
      }
      
      public static function getTitleFileName(param1:int, param2:int, param3:int = 1000, param4:int = 1000) : String
      {
         var _loc5_:int = Math.floor(param1 / param3);
         var _loc6_:int = Math.floor(param2 / param4);
         return _loc5_ + "_" + _loc6_;
      }
      
      public static function getStartPoint(param1:String) : Point
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:int = _loc2_[0] * 1000;
         var _loc4_:int = _loc2_[1] * 1000;
         var _loc5_:Point = new Point(_loc3_,_loc4_);
         _loc2_ = null;
         return _loc5_;
      }
      
      public static function updateSeparatorByArray(param1:Array, param2:String = "_", param3:String = ",") : Array
      {
         var _loc5_:int = 0;
         var _loc4_:RegExp = new RegExp(param2);
         var _loc6_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_[_loc5_] = param1[_loc5_].toString().replace(_loc4_,param3);
            _loc5_++;
         }
         return _loc6_;
      }
      
      public static function stringToPoint(param1:String) : Point
      {
         var _loc2_:Array = param1.split("_");
         return new Point(int(_loc2_[0]),int(_loc2_[1]));
      }
      
      public static function getComponentMovieByKey(param1:String) : MovieClip
      {
         return ComponentFactory.Instance.creatCustomObject(param1);
      }
      
      public static function getPathDistance(param1:Array) : Number
      {
         var _loc3_:int = 0;
         var _loc2_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length - 1)
         {
            _loc2_ += Point.distance(param1[_loc3_],param1[_loc3_ + 1]);
            _loc3_++;
         }
         return _loc2_ * 20;
      }
      
      public static function addStandPoint(param1:Array) : Array
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc2_:Point = new Point();
         _loc2_.x = (param1[param1.length - 1] as Point).x - 3;
         _loc2_.y = (param1[param1.length - 1] as Point).y + 2;
         param1.push(_loc2_);
         var _loc5_:int = 5;
         while(_loc5_ >= 0)
         {
            _loc3_ = param1[param1.length - _loc5_ - 2] as Point;
            _loc4_ = param1[param1.length - _loc5_ - 3] as Point;
            if(_loc3_ && _loc4_)
            {
               if(_loc4_.x - _loc3_.x > 0)
               {
                  if(_loc3_.x - _loc2_.x < 0)
                  {
                     param1.splice(param1.length - 2,++_loc5_);
                     continue;
                  }
               }
               else if(_loc3_.x - _loc2_.x > 0)
               {
                  param1.splice(param1.length - 2,++_loc5_);
                  continue;
               }
               if(_loc4_.y - _loc3_.y > 0)
               {
                  if(_loc3_.y - _loc2_.y < 0)
                  {
                     param1.splice(param1.length - 2,++_loc5_);
                     continue;
                  }
               }
               else if(_loc3_.y - _loc2_.y > 0)
               {
                  param1.splice(param1.length - 2,++_loc5_);
                  continue;
               }
            }
            _loc5_--;
         }
         param1.push(_loc2_);
         param1.push(_loc2_);
         return param1;
      }
   }
}

