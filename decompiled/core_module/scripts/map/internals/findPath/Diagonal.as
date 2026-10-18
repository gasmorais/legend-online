package map.internals.findPath
{
   import flash.geom.Point;
   
   public class Diagonal
   {
      
      public function Diagonal()
      {
         super();
      }
      
      public static function eachObj(param1:Point, param2:Point) : Array
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc12_:int = 0;
         var _loc9_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc14_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc4_:int = 0;
         var _loc15_:Array = [];
         var _loc3_:int = 0;
         var _loc5_:Boolean = param1.x < param2.x == param1.y < param2.y;
         if(param1.x < param2.x)
         {
            _loc7_ = param1.x;
            _loc12_ = param1.y;
            _loc8_ = param2.x - _loc7_;
            _loc6_ = Math.abs(param2.y - _loc12_);
         }
         else
         {
            _loc7_ = param2.x;
            _loc12_ = param2.y;
            _loc8_ = param1.x - _loc7_;
            _loc6_ = Math.abs(param1.y - _loc12_);
         }
         if(_loc8_ == _loc6_)
         {
            _loc4_ = 0;
            while(_loc4_ <= _loc8_)
            {
               if(_loc5_)
               {
                  _loc15_.push(new Point(_loc7_ + _loc4_,_loc12_ + _loc4_));
               }
               else
               {
                  _loc15_.push(new Point(_loc7_ + _loc4_,_loc12_ - _loc4_));
               }
               if(_loc4_ > 0)
               {
                  if(_loc5_)
                  {
                     _loc15_.push(new Point(_loc7_ + _loc4_ - 1,_loc12_ + _loc4_));
                  }
                  else
                  {
                     _loc15_.push(new Point(_loc7_ + _loc4_ - 1,_loc12_ - _loc4_));
                  }
               }
               if(_loc4_ < _loc8_)
               {
                  if(_loc5_)
                  {
                     _loc15_.push(new Point(_loc7_ + _loc4_ + 1,_loc12_ + _loc4_));
                  }
                  else
                  {
                     _loc15_.push(new Point(_loc7_ + _loc4_ + 1,_loc12_ - _loc4_));
                  }
               }
               _loc4_++;
            }
         }
         else if(_loc8_ > _loc6_)
         {
            _loc9_ = _loc6_ / _loc8_;
            _loc15_.push(new Point(_loc7_,_loc12_));
            _loc4_ = 1;
            while(_loc4_ <= _loc8_)
            {
               _loc11_ = (_loc4_ - 0.5) * _loc9_;
               _loc10_ = (_loc4_ + 0.5) * _loc9_;
               _loc14_ = _loc11_ > _loc3_ - 0.5 && _loc11_ < _loc3_ + 0.5;
               _loc13_ = _loc10_ > _loc3_ - 0.5 && _loc10_ < _loc3_ + 0.5;
               if(_loc14_ || _loc13_)
               {
                  if(_loc5_)
                  {
                     _loc15_.push(new Point(_loc7_ + _loc4_,_loc12_ + _loc3_));
                  }
                  else
                  {
                     _loc15_.push(new Point(_loc7_ + _loc4_,_loc12_ - _loc3_));
                  }
                  if(!_loc13_)
                  {
                     _loc3_++;
                     if(_loc5_)
                     {
                        _loc15_.push(new Point(_loc7_ + _loc4_,_loc12_ + _loc3_));
                     }
                     else
                     {
                        _loc15_.push(new Point(_loc7_ + _loc4_,_loc12_ - _loc3_));
                     }
                  }
               }
               _loc4_++;
            }
         }
         else if(_loc8_ < _loc6_)
         {
            _loc9_ = _loc8_ / _loc6_;
            _loc15_.push(new Point(_loc7_,_loc12_));
            _loc4_ = 1;
            while(_loc4_ <= _loc6_)
            {
               _loc11_ = (_loc4_ - 0.5) * _loc9_;
               _loc10_ = (_loc4_ + 0.5) * _loc9_;
               _loc14_ = _loc11_ > _loc3_ - 0.5 && _loc11_ < _loc3_ + 0.5;
               _loc13_ = _loc10_ > _loc3_ - 0.5 && _loc10_ < _loc3_ + 0.5;
               if(_loc14_ || _loc13_)
               {
                  if(_loc5_)
                  {
                     _loc15_.push(new Point(_loc7_ + _loc3_,_loc12_ + _loc4_));
                  }
                  else
                  {
                     _loc15_.push(new Point(_loc7_ + _loc3_,_loc12_ - _loc4_));
                  }
                  if(!_loc13_)
                  {
                     _loc3_++;
                     if(_loc5_)
                     {
                        _loc15_.push(new Point(_loc7_ + _loc3_,_loc12_ + _loc4_));
                     }
                     else
                     {
                        _loc15_.push(new Point(_loc7_ + _loc3_,_loc12_ - _loc4_));
                     }
                  }
               }
               _loc4_++;
            }
         }
         return _loc15_;
      }
   }
}

