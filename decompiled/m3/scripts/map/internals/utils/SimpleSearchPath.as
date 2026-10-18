package map.internals.utils
{
   import flash.geom.Point;
   
   public class SimpleSearchPath
   {
      
      private var _titls:Object;
      
      public function SimpleSearchPath()
      {
         super();
      }
      
      public function set titls(param1:Object) : void
      {
         _titls = param1;
      }
      
      private function isWalkable(param1:int, param2:int) : Boolean
      {
         return _titls[param1 + "_" + param2] ? true : false;
      }
      
      public function optimizationPath(param1:Array) : Array
      {
         var _loc7_:Point = null;
         var _loc12_:Point = null;
         var _loc4_:Array = null;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc10_:Array = null;
         var _loc13_:int = 0;
         var _loc11_:Array = null;
         var _loc2_:Array = getSimplePath(param1);
         if(_loc2_ && _loc2_.length <= 1)
         {
            return param1;
         }
         var _loc5_:int = _loc2_.length - 1;
         if(_loc5_ < 2)
         {
            return param1;
         }
         var _loc3_:Array = [_loc2_[0]];
         var _loc14_:int = 0;
         _loc5_ = _loc2_.length - 1;
         var _loc6_:Boolean = false;
         while(_loc14_ < _loc5_)
         {
            _loc7_ = _loc2_[_loc14_];
            _loc8_ = false;
            _loc9_ = _loc5_;
            while(_loc9_ > _loc14_ + 1)
            {
               _loc12_ = _loc2_[_loc9_];
               _loc15_ = _loc7_.x - _loc12_.x;
               _loc16_ = _loc7_.y - _loc12_.y;
               if(Math.abs(_loc15_) == Math.abs(_loc16_))
               {
                  if(_loc16_ == 0)
                  {
                     break;
                  }
                  _loc4_ = obliqueSearch(_loc7_.x,_loc7_.y,_loc12_.x,_loc12_.y);
                  if(_loc4_)
                  {
                     _loc3_ = concatArray(_loc4_,_loc3_);
                     break;
                  }
               }
               else if(Math.abs(_loc15_) > Math.abs(_loc16_))
               {
                  _loc8_ = true;
                  _loc13_ = _loc15_ < 0 ? -Math.abs(_loc16_) : Math.abs(_loc16_);
                  if(Math.abs(_loc15_) > 1 || Math.abs(_loc16_) > 1)
                  {
                     _loc4_ = obliqueSearch(_loc7_.x,_loc7_.y,_loc7_.x - _loc13_,_loc12_.y);
                  }
                  if(_loc4_)
                  {
                     _loc10_ = horizontalSearch(_loc7_.x - _loc13_,_loc12_.y,_loc12_.x,_loc12_.y);
                     if(_loc10_)
                     {
                        _loc3_ = concatArray(_loc4_,_loc3_);
                        _loc3_ = concatArray(_loc10_,_loc3_);
                     }
                  }
                  else
                  {
                     _loc4_ = horizontalSearch(_loc7_.x,_loc7_.y,_loc12_.x + _loc13_,_loc7_.y);
                     if(_loc4_)
                     {
                        _loc10_ = obliqueSearch(_loc12_.x + _loc13_,_loc7_.y,_loc12_.x,_loc12_.y);
                        if(_loc10_)
                        {
                           _loc3_ = concatArray(_loc4_,_loc3_);
                           _loc3_ = concatArray(_loc10_,_loc3_);
                        }
                        else
                        {
                           _loc4_ = horizontalSearch(_loc7_.x,_loc7_.y,_loc12_.x,_loc7_.y);
                           if(_loc4_)
                           {
                              _loc10_ = verticalSearch(_loc12_.x,_loc7_.y,_loc12_.x,_loc12_.y);
                              if(_loc10_)
                              {
                                 _loc3_ = concatArray(_loc4_,_loc3_);
                                 _loc3_ = concatArray(_loc10_,_loc3_);
                              }
                           }
                           else
                           {
                              _loc4_ = verticalSearch(_loc7_.x,_loc7_.y,_loc7_.x,_loc12_.y);
                              if(_loc4_)
                              {
                                 _loc10_ = horizontalSearch(_loc7_.x,_loc12_.y,_loc12_.x,_loc12_.y);
                                 if(_loc10_)
                                 {
                                    _loc3_ = concatArray(_loc4_,_loc3_);
                                    _loc3_ = concatArray(_loc10_,_loc3_);
                                 }
                              }
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc8_ = true;
                  _loc13_ = _loc16_ < 0 ? -Math.abs(_loc15_) : Math.abs(_loc15_);
                  if(Math.abs(_loc15_) > 1 || Math.abs(_loc16_) > 1)
                  {
                     _loc4_ = obliqueSearch(_loc7_.x,_loc7_.y,_loc12_.x,_loc7_.y - _loc13_);
                  }
                  if(_loc4_)
                  {
                     _loc10_ = verticalSearch(_loc12_.x,_loc7_.y - _loc13_,_loc12_.x,_loc12_.y);
                     if(_loc10_)
                     {
                        _loc3_ = concatArray(_loc4_,_loc3_);
                        _loc3_ = concatArray(_loc10_,_loc3_);
                     }
                  }
                  else
                  {
                     _loc4_ = verticalSearch(_loc7_.x,_loc7_.y,_loc7_.x,_loc7_.y + _loc13_);
                     if(_loc4_)
                     {
                        _loc10_ = obliqueSearch(_loc7_.x,_loc7_.y + _loc13_,_loc12_.x,_loc12_.y);
                        if(_loc10_)
                        {
                           _loc3_ = concatArray(_loc4_,_loc3_);
                           _loc3_ = concatArray(_loc10_,_loc3_);
                        }
                     }
                     else
                     {
                        _loc4_ = horizontalSearch(_loc7_.x,_loc7_.y,_loc12_.x,_loc7_.y);
                        if(_loc4_)
                        {
                           _loc10_ = verticalSearch(_loc12_.x,_loc7_.y,_loc12_.x,_loc12_.y);
                           if(_loc10_)
                           {
                              _loc3_ = concatArray(_loc4_,_loc3_);
                              _loc3_ = concatArray(_loc10_,_loc3_);
                           }
                        }
                        else
                        {
                           _loc4_ = verticalSearch(_loc7_.x,_loc7_.y,_loc7_.x,_loc12_.y);
                           if(_loc4_)
                           {
                              _loc10_ = horizontalSearch(_loc7_.x,_loc12_.y,_loc12_.x,_loc12_.y);
                              if(_loc10_)
                              {
                                 _loc3_ = concatArray(_loc4_,_loc3_);
                                 _loc3_ = concatArray(_loc10_,_loc3_);
                              }
                           }
                        }
                     }
                  }
               }
               if(_loc4_ && (!_loc8_ || _loc8_ && _loc10_))
               {
                  _loc14_ = _loc9_ - 1;
                  _loc6_ = true;
                  break;
               }
               _loc6_ = false;
               _loc4_ = null;
               _loc10_ = null;
               _loc9_--;
            }
            if(!_loc6_)
            {
               if(_loc14_ + 1 < _loc5_)
               {
                  _loc12_ = _loc2_[_loc14_ + 1];
                  if(_loc7_.x == _loc12_.x)
                  {
                     _loc11_ = verticalSearch(_loc7_.x,_loc12_.y,_loc12_.x,_loc12_.y);
                  }
                  else if(_loc7_.y == _loc12_.y)
                  {
                     _loc11_ = horizontalSearch(_loc7_.x,_loc12_.y,_loc12_.x,_loc12_.y);
                  }
                  else
                  {
                     _loc11_ = obliqueSearch(_loc7_.x,_loc12_.y,_loc12_.x,_loc12_.y);
                  }
                  _loc11_;
                  _loc3_ = concatArray(_loc11_,_loc3_);
               }
            }
            _loc14_++;
         }
         return _loc3_;
      }
      
      private function concatArray(param1:Array, param2:Array) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:Point = null;
         if(!param1)
         {
            return param2;
         }
         var _loc4_:int = int(param1.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = new Point(param1[_loc5_].x,param1[_loc5_].y);
            param2.push(_loc3_);
            _loc5_++;
         }
         return param2;
      }
      
      public function getSimplePath(param1:Array) : Array
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Array = [];
         if(!param1)
         {
            return _loc2_;
         }
         var _loc5_:int = int(param1.length);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc6_ = 1;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1[_loc6_].x - param1[_loc6_ - 1].x;
            _loc8_ = param1[_loc6_].y - param1[_loc6_ - 1].y;
            if(!(_loc7_ == _loc3_ && _loc4_ == _loc8_))
            {
               _loc2_.push(new Point(param1[_loc6_ - 1].x,param1[_loc6_ - 1].y));
               _loc3_ = _loc7_;
               _loc4_ = _loc8_;
            }
            _loc6_++;
         }
         _loc2_.push(new Point(param1[_loc5_ - 1].x,param1[_loc5_ - 1].y));
         return _loc2_;
      }
      
      public function search(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc5_:Array = null;
         if(param1 == param3)
         {
            _loc5_ = verticalSearch(param1,param2,param3,param4);
         }
         else if(param2 == param4)
         {
            _loc5_ = horizontalSearch(param1,param2,param3,param4);
         }
         else
         {
            _loc5_ = obliqueSearch(param1,param2,param3,param4);
         }
         return _loc5_;
      }
      
      private function verticalSearch(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc7_:int = param2 < param4 ? 1 : -1;
         var _loc5_:Array = [new Point(param1,param2)];
         var _loc6_:int = param2 + _loc7_;
         while(_loc6_ != param4 && isWalkable(param1,_loc6_))
         {
            _loc5_.push(new Point(param1,_loc6_));
            _loc6_ += _loc7_;
         }
         if(_loc6_ == param4)
         {
            _loc5_.push(new Point(param3,param4));
            return _loc5_;
         }
         return null;
      }
      
      private function horizontalSearch(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc7_:int = param1 < param3 ? 1 : -1;
         var _loc5_:Array = [new Point(param1,param2)];
         var _loc6_:int = param1 + _loc7_;
         while(_loc6_ != param3 && isWalkable(_loc6_,param2))
         {
            _loc5_.push(new Point(_loc6_,param2));
            _loc6_ += _loc7_;
         }
         if(_loc6_ == param3)
         {
            _loc5_.push(new Point(param3,param4));
            return _loc5_;
         }
         return null;
      }
      
      private function obliqueSearch(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc5_:Array = [new Point(param1,param2)];
         var _loc8_:int = param1 < param3 ? 1 : -1;
         var _loc9_:int = param2 < param4 ? 1 : -1;
         var _loc10_:Boolean = Math.abs(param1 - param3) > Math.abs(param2 - param4) ? true : false;
         var _loc6_:int = param1 + _loc8_;
         var _loc7_:int = param2 + _loc9_;
         if(_loc10_)
         {
            while(_loc6_ != param3 && isWalkable(_loc6_,_loc7_))
            {
               _loc5_.push(new Point(_loc6_,_loc7_));
               _loc6_ += _loc8_;
               _loc7_ += _loc9_;
            }
            if(_loc6_ == param3)
            {
               _loc5_.push(new Point(param3,param4));
               return _loc5_;
            }
         }
         else
         {
            while(_loc7_ != param4 && isWalkable(_loc6_,_loc7_))
            {
               _loc5_.push(new Point(_loc6_,_loc7_));
               _loc6_ += _loc8_;
               _loc7_ += _loc9_;
            }
            if(_loc7_ == param4)
            {
               _loc5_.push(new Point(param3,param4));
               return _loc5_;
            }
         }
         return null;
      }
   }
}

