package map.space.path
{
   import flash.geom.Point;
   import map.internals.scenePathSearcher.Geometry;
   
   public class SpacePathRoboSearcher implements SpacePathIPathSearcher
   {
      
      private static var LEFT:Number = -1;
      
      private static var RIGHT:Number = 1;
      
      private var step:Number;
      
      private var maxCount:Number;
      
      private var maxDistance:Number;
      
      private var stepTurnNum:Number;
      
      public function SpacePathRoboSearcher(param1:Number, param2:Number, param3:Number = 4)
      {
         super();
         this.step = param1;
         this.maxDistance = param2;
         maxCount = Math.ceil(param2 / param1) * 2;
         stepTurnNum = param3;
      }
      
      public function setStepTurnNum(param1:Number) : void
      {
         stepTurnNum = param1;
      }
      
      public function search(param1:Point, param2:Point, param3:SpacePathIHitTester) : Array
      {
         var _loc6_:Array = [param1,param1];
         if(param1.equals(param2))
         {
            return _loc6_;
         }
         var _loc7_:Array = [];
         var _loc5_:Array = [];
         var _loc4_:Boolean = searchWithWish(param1,param2,param3,LEFT,_loc7_);
         var _loc8_:Boolean = searchWithWish(param1,param2,param3,RIGHT,_loc5_);
         if(_loc4_ && _loc8_)
         {
            if(_loc7_.length < _loc5_.length)
            {
               return _loc7_;
            }
            return _loc5_;
         }
         if(_loc4_)
         {
            return _loc7_;
         }
         if(_loc8_)
         {
            return _loc5_;
         }
         return _loc6_;
      }
      
      private function searchWithWish(param1:Point, param2:Point, param3:SpacePathIHitTester, param4:Number, param5:Array) : Boolean
      {
         var _loc7_:Point = null;
         var _loc13_:Boolean = false;
         var _loc9_:Array = null;
         var _loc11_:Boolean = false;
         var _loc10_:Point = null;
         var _loc12_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc14_:Point = null;
         if(param3.isHit(param2))
         {
            param2 = findReversseNearestBlankPoint(param1,param2,param3);
            if(param2 == null)
            {
               return false;
            }
            if(param3.isHit(param1))
            {
               param5.push(param1);
               param5.push(param2);
               return true;
            }
         }
         else if(param3.isHit(param1))
         {
            _loc7_ = findReversseNearestBlankPoint(param2,param1,param3);
            if(_loc7_ == null)
            {
               return false;
            }
            _loc13_ = searchWithWish(_loc7_,param2,param3,param4,param5);
            if(_loc13_)
            {
               param5.splice(0,0,param1);
               return true;
            }
            return false;
         }
         if(Point.distance(param1,param2) > maxDistance)
         {
            param5.push(param1);
            param2 = findFarestBlankPoint(param1,param2,param3);
            if(param2 == null)
            {
               return false;
            }
            param5.push(param2);
            return true;
         }
         var _loc8_:Boolean = doSearchWithWish(param1,param2,param3,param4,param5);
         if(!_loc8_)
         {
            return false;
         }
         if(param5.length > 4)
         {
            _loc9_ = [];
            _loc11_ = doSearchWithWish(param2,param5[0],param3,0 - param4,_loc9_);
            if(_loc11_)
            {
               _loc10_ = Point(_loc9_[_loc9_.length - 2]);
               _loc12_ = step;
               _loc6_ = 1;
               while(_loc6_ < param5.length - 1)
               {
                  _loc14_ = Point(param5[_loc6_]);
                  if(Point.distance(_loc14_,_loc10_) < _loc12_)
                  {
                     param5.splice(1,_loc6_,_loc10_);
                     return true;
                  }
                  _loc6_++;
               }
            }
         }
         return true;
      }
      
      private function findFarestBlankPoint(param1:Point, param2:Point, param3:SpacePathIHitTester) : Point
      {
         var _loc6_:Number = NaN;
         var _loc9_:Point = null;
         if(param3.isHit(param1))
         {
            return findReversseNearestBlankPoint(param2,param1,param3);
         }
         var _loc4_:Number = countHeading(param1,param2);
         var _loc5_:Number = Point.distance(param1,param2);
         var _loc8_:Point = param1;
         while(!param3.isHit(param1))
         {
            _loc8_ = param1;
            param1 = Geometry.nextPoint(param1,_loc4_,step);
            _loc5_ -= step;
            if(_loc5_ <= 0)
            {
               return null;
            }
         }
         param1 = _loc8_;
         var _loc10_:Number = 8;
         var _loc7_:Number = 3.141592653589793 / _loc10_;
         _loc6_ = 1;
         while(_loc6_ < _loc10_)
         {
            _loc9_ = Geometry.nextPoint(param1,_loc4_ + _loc6_ * _loc7_,step * 2);
            if(!param3.isHit(_loc9_))
            {
               return _loc9_;
            }
            _loc9_ = Geometry.nextPoint(param1,_loc4_ - _loc6_ * _loc7_,step * 2);
            if(!param3.isHit(_loc9_))
            {
               return _loc9_;
            }
            _loc6_++;
         }
         return param1;
      }
      
      private function findReversseNearestBlankPoint(param1:Point, param2:Point, param3:SpacePathIHitTester) : Point
      {
         var _loc6_:Number = NaN;
         var _loc8_:Point = null;
         var _loc4_:Number = countHeading(param2,param1);
         var _loc5_:Number = Point.distance(param2,param1);
         while(param3.isHit(param2))
         {
            param2 = Geometry.nextPoint(param2,_loc4_,step);
            _loc5_ -= step;
            if(_loc5_ <= 0)
            {
               return null;
            }
         }
         var _loc9_:Number = 12;
         var _loc7_:Number = 3.141592653589793 / _loc9_;
         _loc4_ += 3.141592653589793;
         _loc6_ = 1;
         while(_loc6_ < _loc9_)
         {
            _loc8_ = Geometry.nextPoint(param2,_loc4_ + _loc6_ * _loc7_,step * 2);
            if(!param3.isHit(_loc8_))
            {
               return _loc8_;
            }
            _loc8_ = Geometry.nextPoint(param2,_loc4_ - _loc6_ * _loc7_,step * 2);
            if(!param3.isHit(_loc8_))
            {
               return _loc8_;
            }
            _loc6_++;
         }
         return param2;
      }
      
      private function doSearchWithWish(param1:Point, param2:Point, param3:SpacePathIHitTester, param4:Number, param5:Array) : Boolean
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc18_:Point = null;
         var _loc19_:Point = null;
         var _loc16_:Number = NaN;
         var _loc15_:Boolean = false;
         var _loc10_:Number = NaN;
         param5.push(param1);
         var _loc17_:Number = param4 * 3.141592653589793 / stepTurnNum;
         var _loc14_:Number = param4 * 3.141592653589793 / 2;
         var _loc9_:Number = 1;
         var _loc11_:Number = step;
         var _loc8_:Number = countHeading(param1,param2);
         var _loc7_:Number = Point.distance(param1,param2);
         while(_loc7_ > _loc11_ && _loc9_++ < maxCount)
         {
            _loc12_ = countHeading(param1,param2);
            _loc13_ = _loc8_ - _loc14_;
            _loc6_ = bearing(_loc12_,_loc13_);
            if(param4 > 0 && _loc6_ < 0 || param4 < 0 && _loc6_ > 0)
            {
               _loc13_ = _loc12_;
            }
            _loc18_ = Geometry.nextPoint(param1,_loc13_,step);
            _loc19_ = param1;
            if(param3.isHit(_loc18_))
            {
               _loc15_ = false;
               _loc10_ = 2;
               while(_loc10_ < stepTurnNum * 2)
               {
                  _loc13_ += _loc17_;
                  _loc18_ = Geometry.nextPoint(param1,_loc13_,step);
                  if(!param3.isHit(_loc18_))
                  {
                     param1 = _loc18_;
                     _loc16_ = Point.distance(param1,param2);
                     _loc15_ = true;
                     break;
                  }
                  _loc10_++;
               }
               if(!_loc15_)
               {
                  param5.splice(0);
                  return false;
               }
            }
            else
            {
               param1 = _loc18_;
               _loc16_ = Point.distance(param1,param2);
            }
            if(Math.abs(bearing(_loc8_,_loc13_)) > 0.01)
            {
               param5.push(_loc19_);
               _loc8_ = _loc13_;
            }
            _loc7_ = _loc16_;
         }
         if(_loc9_ <= maxCount)
         {
            param5.push(param2);
            return true;
         }
         return false;
      }
      
      private function countHeading(param1:Point, param2:Point) : Number
      {
         return Math.atan2(param2.y - param1.y,param2.x - param1.x);
      }
      
      private function bearing(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param2 - param1;
         _loc3_ = (_loc3_ + 3.141592653589793 * 4) % (3.141592653589793 * 2);
         if(_loc3_ < -3.141592653589793)
         {
            _loc3_ += 3.141592653589793 * 2;
         }
         else if(_loc3_ > 3.141592653589793)
         {
            _loc3_ -= 3.141592653589793 * 2;
         }
         return _loc3_;
      }
   }
}

