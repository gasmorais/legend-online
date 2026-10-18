package map.internals.findPath
{
   import flash.geom.Point;
   import map.internals.data.CampaignNode;
   
   public class AcorrsLineGrid
   {
      
      private var _findPath8:IFindPath;
      
      private var _mapModel:Object;
      
      private var minDistance:int = 6;
      
      private var nodes:Array;
      
      private var nodeWidth:Number;
      
      private var nodeHeight:Number;
      
      private var _k:Number;
      
      private var _b:Number;
      
      private var _isPanX:Boolean = false;
      
      private var _panXvalue:int;
      
      private var _isPanY:Boolean = false;
      
      private var _panYvalue:int;
      
      private var node:Point;
      
      private var _checkCornerPoint:Point = new Point();
      
      public function AcorrsLineGrid(param1:IFindPath, param2:Object)
      {
         super();
         nodeWidth = 20;
         nodeHeight = 20;
         _findPath8 = param1;
         _mapModel = param2;
      }
      
      private static function getMinInt(param1:int, param2:int) : int
      {
         if(param1 < param2)
         {
            return param1;
         }
         return param2;
      }
      
      private static function getMaxInt(param1:int, param2:int) : int
      {
         if(param1 > param2)
         {
            return param1;
         }
         return param2;
      }
      
      public function getPsnode2(param1:Array) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:Point = null;
         var _loc10_:Boolean = false;
         var _loc11_:CampaignNode = null;
         var _loc8_:Point = null;
         var _loc13_:Array = [];
         if(!param1)
         {
            return _loc13_;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc13_.push(param1[_loc6_]);
            _loc6_++;
         }
         var _loc12_:uint = param1.length;
         if(_loc12_ < 3)
         {
            return param1;
         }
         var _loc2_:Array = [];
         var _loc14_:Point = param1[0] as Point;
         var _loc9_:Point = param1[_loc12_ - 1] as Point;
         var _loc4_:uint = 0;
         _loc2_.push(_loc14_);
         var _loc5_:int = 0;
         while(_loc14_ != _loc9_)
         {
            _loc5_ = _loc12_ - 1;
            while(_loc5_ > _loc4_)
            {
               _loc3_ = param1[_loc5_] as Point;
               _loc10_ = _loc5_ - _loc4_ == 1;
               if(_loc10_ || isCorrsed(_loc14_,_loc3_))
               {
                  _loc14_ = _loc3_;
                  _loc4_ = uint(_loc5_);
                  _loc2_.push(_loc3_);
                  break;
               }
               _loc5_--;
            }
         }
         var _loc7_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc13_.length)
         {
            _loc3_ = _loc13_[_loc5_] as Point;
            if(_mapModel.hasOwnProperty("getNotHandlerNodeByXY"))
            {
               _loc11_ = _mapModel.getNotHandlerNodeByXY(_loc3_.x,_loc3_.y);
               if(_loc11_)
               {
                  if(_loc11_.resetPosX > 0 && _loc11_.resetPosY > 0)
                  {
                     _loc7_.push(new Point(_loc11_.resetPosX,_loc11_.resetPosY));
                  }
                  else if(_loc5_ > 0)
                  {
                     _loc8_ = _loc13_[_loc5_ - 1] as Point;
                     if(_loc7_.indexOf(_loc8_) == -1)
                     {
                        _loc7_.push(_loc8_);
                     }
                  }
                  if(_loc7_.indexOf(_loc3_) == -1)
                  {
                     _loc7_.push(_loc3_);
                  }
               }
               if(_loc2_.indexOf(_loc3_) >= 0 && _loc7_.indexOf(_loc3_) == -1)
               {
                  _loc7_.push(_loc3_);
               }
            }
            else if(_loc2_.indexOf(_loc3_) >= 0)
            {
               _loc7_.push(_loc3_);
            }
            _loc5_++;
         }
         return buildPath(_loc7_);
      }
      
      private function buildPath(param1:Array) : Array
      {
         var _loc2_:Point = null;
         var _loc4_:Point = null;
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc5_:Array = [];
         _loc6_ = 1;
         while(_loc6_ < param1.length)
         {
            _loc2_ = param1[_loc6_ - 1] as Point;
            _loc4_ = param1[_loc6_] as Point;
            _loc5_ = spliceLine(_loc2_,_loc4_);
            if(pointTest(_loc3_,_loc5_[0]))
            {
               _loc3_.pop();
            }
            _loc3_ = _loc3_.concat(_loc5_);
            _loc6_++;
         }
         if(pointTest(_loc3_,_loc4_))
         {
            _loc3_.pop();
         }
         _loc3_.push(_loc4_);
         return _loc3_;
      }
      
      private function pointTest(param1:Array, param2:Point) : Boolean
      {
         if(param1.length > 0 && param1[param1.length - 1].x == param2.x && param1[param1.length - 1].y == param2.y)
         {
            return true;
         }
         return false;
      }
      
      private function spliceLine(param1:Point, param2:Point) : Array
      {
         var _loc7_:int = 0;
         var _loc4_:Point = null;
         var _loc5_:Array = [];
         var _loc3_:Number = Point.distance(param1,param2);
         if(_loc3_ < minDistance)
         {
            _loc5_.push(param1);
            return _loc5_;
         }
         var _loc6_:int = _loc3_ / minDistance;
         _loc7_ = 0;
         while(_loc7_ <= _loc6_)
         {
            _loc4_ = Point.interpolate(param2,param1,_loc7_ / _loc6_);
            _loc4_.x = int(_loc4_.x);
            _loc4_.y = int(_loc4_.y);
            _loc5_.push(_loc4_);
            _loc7_++;
         }
         return _loc5_;
      }
      
      private function isCorrsed(param1:Point, param2:Point) : Boolean
      {
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc16_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         var _loc13_:int = 0;
         if(!param1 || !param2)
         {
            return false;
         }
         _isPanX = param1.y == param2.y;
         _isPanY = param1.x == param2.x;
         if(_isPanX || _isPanY)
         {
            if(_isPanX)
            {
               _panXvalue = param1.y * nodeHeight;
            }
            if(_isPanY)
            {
               _panYvalue = param1.x * nodeWidth;
            }
         }
         else
         {
            _k = (param2.y - param1.y) * nodeHeight / ((param2.x - param1.x) * nodeWidth);
            _b = param2.y * nodeHeight - param2.x * nodeWidth * _k;
         }
         var _loc15_:int = getMinInt(param2.x,param1.x);
         var _loc9_:int = getMaxInt(param2.x,param1.x);
         var _loc14_:int = getMinInt(param1.y,param2.y);
         var _loc6_:int = getMaxInt(param1.y,param2.y);
         var _loc4_:int = _loc15_ * nodeWidth;
         var _loc5_:int = _loc9_ * nodeWidth;
         var _loc3_:int = _loc14_ * nodeHeight;
         var _loc7_:int = _loc6_ * nodeHeight;
         node = param1.x < param2.x ? param1 : param2;
         _loc13_ = _loc15_;
         while(_loc13_ <= _loc9_)
         {
            _loc10_ = _loc13_ * nodeWidth + 1;
            _loc16_ = _loc10_ / 20;
            if(_loc10_ >= _loc4_ && _loc10_ <= _loc5_)
            {
               _loc12_ = getPy(_loc10_);
               _loc8_ = _loc12_ / 20;
               _loc11_ = getNodeValueByGridXY(_loc16_,_loc8_);
               if(_loc11_ == 1)
               {
                  return false;
               }
               _checkCornerPoint.x = _loc10_;
               _checkCornerPoint.y = _loc12_;
               if(checkCorner(_checkCornerPoint))
               {
                  return false;
               }
               node = new Point(int(_loc10_ / 20),int(_loc12_ / 20));
            }
            _loc10_ = (_loc13_ + 1) * nodeWidth - 1;
            _loc16_ = _loc10_ / 20;
            if(_loc10_ >= _loc4_ && _loc10_ <= _loc5_)
            {
               _loc12_ = getPy(_loc10_);
               _loc8_ = _loc12_ / 20;
               _loc11_ = getNodeValueByGridXY(_loc16_,_loc8_);
               if(_loc11_ == 1)
               {
                  return false;
               }
               _checkCornerPoint.x = _loc10_;
               _checkCornerPoint.y = _loc12_;
               if(checkCorner(_checkCornerPoint))
               {
                  return false;
               }
               node = new Point(int(_loc10_ / 20),int(_loc12_ / 20));
            }
            _loc13_++;
         }
         _loc11_ = param1.y < param2.y ? getNodeValueByGridXY(param1.x,param1.y) : getNodeValueByGridXY(param2.x,param2.y);
         _loc13_ = _loc14_;
         while(_loc13_ <= _loc6_)
         {
            _loc12_ = _loc13_ * nodeHeight + 1;
            _loc8_ = _loc12_ / 20;
            if(_loc12_ >= _loc3_ && _loc12_ <= _loc7_)
            {
               _loc10_ = getPx(_loc12_);
               _loc16_ = _loc10_ / 20;
               _loc11_ = getNodeValueByGridXY(_loc16_,_loc8_);
               if(_loc11_ == 1)
               {
                  return false;
               }
               _checkCornerPoint.x = _loc10_;
               _checkCornerPoint.y = _loc12_;
               if(checkCorner(_checkCornerPoint))
               {
                  return false;
               }
               node = new Point(int(_loc10_ / 20),int(_loc12_ / 20));
            }
            _loc12_ = (_loc13_ + 1) * nodeHeight - 1;
            _loc8_ = _loc12_ / 20;
            if(_loc12_ >= _loc3_ && _loc12_ <= _loc7_)
            {
               _loc10_ = getPx(_loc12_);
               _loc16_ = _loc10_ / 20;
               _loc11_ = getNodeValueByGridXY(_loc16_,_loc8_);
               if(_loc11_ == 1)
               {
                  return false;
               }
               _checkCornerPoint.x = _loc10_;
               _checkCornerPoint.y = _loc12_;
               if(checkCorner(_checkCornerPoint))
               {
                  return false;
               }
               node = new Point(int(_loc10_ / 20),int(_loc12_ / 20));
            }
            _loc13_++;
         }
         return true;
      }
      
      private function getPx(param1:Number) : Number
      {
         if(_isPanY)
         {
            return _panYvalue;
         }
         return (param1 - _b) / _k;
      }
      
      private function getPy(param1:Number) : Number
      {
         if(_isPanX)
         {
            return _panXvalue;
         }
         return _k * param1 + _b;
      }
      
      private function checkCorner(param1:Point) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = getface(param1);
         switch(_loc2_ - -4)
         {
            case 0:
               _loc3_ = getNodeValueByXY(param1.x + 1,param1.y);
               _loc4_ = getNodeValueByXY(param1.x,param1.y + 1);
               break;
            case 2:
               _loc3_ = getNodeValueByXY(param1.x - 1,param1.y);
               _loc4_ = getNodeValueByXY(param1.x,param1.y + 1);
               break;
            case 6:
               _loc3_ = getNodeValueByXY(param1.x + 1,param1.y);
               _loc4_ = getNodeValueByXY(param1.x,param1.y + 1);
               break;
            case 8:
               _loc3_ = getNodeValueByXY(param1.x - 1,param1.y);
               _loc4_ = getNodeValueByXY(param1.x,param1.y - 1);
               break;
            default:
               return false;
         }
         if(_loc3_ == 1 && _loc4_ == 1)
         {
            return true;
         }
         return false;
      }
      
      private function getface(param1:Point) : int
      {
         return int((param1.y - node.y) * 3 + (param1.x - node.x));
      }
      
      private function getNodeValueByXY(param1:Number, param2:Number) : int
      {
         return _findPath8.map[int(param2 / nodeHeight)][int(param1 / nodeHeight)].value;
      }
      
      private function getNodeValueByGridXY(param1:int, param2:int) : int
      {
         return _findPath8.map[param2][param1].value;
      }
      
      public function set findPath8(param1:IFindPath) : void
      {
         _findPath8 = param1;
      }
      
      public function getPsnode(param1:Array) : Array
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:Array = getStraightLine(param1);
         return getStraightLine(_loc2_);
      }
      
      private function getStraightLine(param1:Array) : Array
      {
         var _loc6_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:Array = null;
         if(param1.length <= 2)
         {
            return param1;
         }
         var _loc4_:int = int(param1.length);
         var _loc7_:int = 0;
         var _loc8_:int = _loc4_ - 1;
         var _loc5_:Array = [param1[0]];
         while(_loc7_ != _loc8_)
         {
            _loc6_ = param1[_loc7_];
            _loc2_ = param1[_loc8_];
            _loc3_ = findPoints(_loc6_,_loc2_);
            if(_loc3_)
            {
               _loc5_.push(param1[_loc8_]);
               _loc7_ = _loc8_;
               _loc8_ = _loc4_ - 1;
            }
            else
            {
               _loc8_ = (_loc8_ + _loc7_) / 2;
            }
         }
         if(_loc5_.length == 1)
         {
            return param1;
         }
         return _loc5_;
      }
      
      private function findPoints(param1:Point, param2:Point) : Array
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:Number = NaN;
         var _loc8_:int = 0;
         var _loc3_:Array = [];
         if(param1.x == param2.x)
         {
            _loc5_ = Math.max(param1.y,param2.y);
            _loc7_ = _loc4_ = Math.min(param1.y,param2.y);
            while(_loc7_ < _loc5_)
            {
               if(!isWalkable(param1.x,_loc7_))
               {
                  return null;
               }
               _loc7_++;
            }
         }
         else
         {
            _loc9_ = (param2.y - param1.y) / (param2.x - param1.x);
            if(Math.abs(param2.x - param1.x) < Math.abs(param2.y - param1.y))
            {
               _loc8_ = param2.y > param1.y ? 1 : -1;
               _loc7_ = param1.y;
               while(true)
               {
                  if(_loc7_ != param2.y)
                  {
                     _loc6_ = (_loc7_ - param1.y) / _loc9_ + param1.x;
                     if(!isWalkable(_loc6_,_loc7_))
                     {
                        break;
                     }
                     _loc7_ += _loc8_;
                     continue;
                  }
               }
               return null;
            }
            _loc8_ = param2.x > param1.x ? 1 : -1;
            _loc6_ = param1.x;
            while(_loc6_ != param2.x)
            {
               _loc7_ = (_loc6_ - param1.x) * _loc9_ + param1.y;
               if(!isWalkable(_loc6_,_loc7_))
               {
                  return null;
               }
               _loc6_ += _loc8_;
            }
         }
         return _loc3_;
      }
      
      private function isWalkable(param1:int, param2:int) : Boolean
      {
         return getNodeValueByGridXY(param1,param2) != 1;
      }
      
      public function dispose() : void
      {
         if(_findPath8)
         {
            _findPath8["dispose"]();
         }
         _findPath8 = null;
         _mapModel = null;
         _checkCornerPoint = null;
         node = null;
      }
   }
}

