package map.internals.utils
{
   import flash.geom.Point;
   
   public class PathPointUtils
   {
      
      public function PathPointUtils()
      {
         super();
      }
      
      public static function findPoints(param1:Point, param2:Point) : Array
      {
         var _loc12_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:Array = [];
         var _loc13_:int = param1.x;
         var _loc8_:int = param1.y;
         var _loc11_:int = param2.x;
         var _loc4_:int = param2.y;
         var _loc6_:int = param2.x - param1.x;
         var _loc3_:int = param2.y - param1.y;
         var _loc9_:int = 0;
         if(_loc6_ < 0)
         {
            _loc12_ = -1;
         }
         else
         {
            _loc12_ = 1;
         }
         if(_loc3_ < 0)
         {
            _loc5_ = -1;
         }
         else
         {
            _loc5_ = 1;
         }
         _loc6_ = Math.abs(_loc6_ * 2);
         _loc3_ = Math.abs(_loc3_ * 2);
         _loc10_.push(new Point(_loc13_,_loc8_));
         if(_loc6_ > _loc3_)
         {
            _loc7_ = _loc3_ - _loc6_ / 2;
            while(_loc13_ != _loc11_)
            {
               if(_loc7_ >= 0)
               {
                  _loc8_ += _loc5_;
                  _loc7_ -= _loc6_;
               }
               _loc13_ += _loc12_;
               _loc7_ += _loc3_;
               _loc10_.push(new Point(_loc13_,_loc8_));
               _loc9_++;
            }
         }
         else
         {
            _loc7_ = _loc6_ - _loc3_ / 2;
            while(_loc8_ != _loc4_)
            {
               if(_loc7_ >= 0)
               {
                  _loc13_ += _loc12_;
                  _loc7_ -= _loc3_;
               }
               _loc8_ += _loc5_;
               _loc7_ += _loc6_;
               _loc10_.push(new Point(_loc13_,_loc8_));
               _loc9_++;
            }
         }
         return _loc10_;
      }
      
      public static function optimizePath(param1:Array) : Array
      {
         var _loc3_:Point = null;
         var _loc2_:Point = null;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         if(param1.length <= 2)
         {
            return param1.concat();
         }
         var _loc8_:Array = [param1[0]];
         _loc6_ = 1;
         while(_loc6_ < param1.length)
         {
            _loc3_ = param1[_loc6_ - 1] as Point;
            _loc2_ = param1[_loc6_] as Point;
            if((_loc2_.x - _loc3_.x) * (_loc2_.y - _loc3_.y) != 0 || _loc6_ == param1.length - 1)
            {
               _loc8_.push(_loc2_);
            }
            _loc6_++;
         }
         var _loc4_:Array = [param1[0]];
         var _loc5_:Number = Infinity;
         _loc6_ = 1;
         while(_loc6_ < _loc8_.length)
         {
            _loc3_ = _loc8_[_loc6_ - 1] as Point;
            _loc2_ = _loc8_[_loc6_] as Point;
            if(_loc3_.x == _loc2_.x)
            {
               _loc7_ = Infinity;
            }
            else
            {
               _loc7_ = (_loc2_.y - _loc3_.y) / (_loc2_.x - _loc3_.x);
            }
            if(_loc5_ != _loc7_ || _loc6_ == _loc8_.length - 1)
            {
               _loc5_ = _loc7_;
               _loc4_.push(_loc2_);
            }
            _loc6_++;
         }
         return _loc4_;
      }
   }
}

