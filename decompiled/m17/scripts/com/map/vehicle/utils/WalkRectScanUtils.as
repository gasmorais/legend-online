package com.map.vehicle.utils
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.geom.Point;
   
   public class WalkRectScanUtils implements Disposeable
   {
      
      private var _outWidth:int;
      
      private var _outHeight:int;
      
      private var _getWalkable:Function;
      
      private var _preStartPoint:Point = new Point();
      
      private var _findPathCount:int;
      
      public function WalkRectScanUtils()
      {
         super();
      }
      
      public function set getWalkable(param1:Function) : void
      {
         _getWalkable = param1;
      }
      
      public function dispose() : void
      {
         _getWalkable = null;
         _preStartPoint = null;
      }
      
      public function set outHeight(param1:int) : void
      {
         _outHeight = param1;
      }
      
      public function set outWidth(param1:int) : void
      {
         _outWidth = param1;
      }
      
      public function walkRectScan(param1:Point, param2:Point, param3:Point) : Point
      {
         var _loc4_:Point = null;
         if(_preStartPoint.equals(param1))
         {
            _findPathCount = _findPathCount + 1;
         }
         else
         {
            _preStartPoint = new Point(param1.x,param1.y);
            _findPathCount = _findPathCount + 1;
         }
         var _loc5_:int = 0;
         while(!_loc4_ && _loc5_ < _outWidth)
         {
            _loc4_ = walkRectScanImp(_loc5_,param1,param2,param3);
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function walkRectScanImp(param1:int, param2:Point, param3:Point, param4:Point) : Point
      {
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:Point = new Point(param2.x,param2.y);
         var _loc11_:Boolean = false;
         var _loc5_:Array = [];
         _loc9_ = -param1;
         while(_loc9_ <= param1)
         {
            _loc8_.x = param2.x;
            _loc8_.x += _loc9_ * 20;
            if(_loc9_ == -param1 || _loc9_ == param1)
            {
               _loc10_ = -param1;
               while(_loc10_ <= param1)
               {
                  _loc8_.y = param2.y;
                  _loc8_.y += _loc10_ * 20;
                  if(outRect(_loc8_.x / 20,_loc8_.y / 20))
                  {
                     _loc5_.push(new Point(_loc8_.x,_loc8_.y));
                  }
                  _loc10_++;
               }
            }
            else
            {
               _loc8_.y = param2.y;
               _loc8_.y += param1 * 20;
               if(outRect(_loc8_.x / 20,_loc8_.y / 20))
               {
                  _loc5_.push(new Point(_loc8_.x,_loc8_.y));
               }
               _loc8_.y = param2.y;
               _loc8_.y -= param1 * 20;
               if(outRect(_loc8_.x / 20,_loc8_.y / 20))
               {
                  _loc5_.push(new Point(_loc8_.x,_loc8_.y));
               }
            }
            _loc9_++;
         }
         _loc8_.x = param2.x;
         _loc8_.y = param2.y;
         var _loc6_:Point = getMinDistance(_loc5_,param3);
         if(!_loc6_)
         {
            return _loc6_;
         }
         var _loc7_:int = Point.distance(param4,_loc6_);
         if(_loc7_ > 14)
         {
            return _loc6_;
         }
         if(_findPathCount % 2 != 0)
         {
            if(_loc5_.length < 3)
            {
               return null;
            }
            return getMaxDistance(_loc5_,param3);
         }
         return null;
      }
      
      private function getMinDistance(param1:Array, param2:Point) : Point
      {
         if(!param1 || param1.length == 0)
         {
            return null;
         }
         var _loc4_:Point = param1[0];
         for each(var _loc3_:Point in param1)
         {
            if(Point.distance(_loc4_,param2) > Point.distance(param2,_loc3_))
            {
               _loc4_ = _loc3_;
            }
         }
         return _loc4_;
      }
      
      private function getMaxDistance(param1:Array, param2:Point) : Point
      {
         if(!param1 || param1.length == 0)
         {
            return null;
         }
         var _loc4_:Point = param1[0];
         for each(var _loc3_:Point in param1)
         {
            if(Point.distance(_loc4_,param2) < Point.distance(param2,_loc3_))
            {
               _loc4_ = _loc3_;
            }
         }
         return _loc4_;
      }
      
      private function outRect(param1:int, param2:int) : Boolean
      {
         if(param1 > _outWidth || param2 > _outHeight || param1 < 0 || param2 < 0)
         {
            return false;
         }
         return _getWalkable(param1,param2);
      }
   }
}

