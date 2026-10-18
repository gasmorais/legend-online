package map.internals.utils
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class AStarPathFinder
   {
      
      private static var _pool:Vector.<Node>;
      
      private const COST_HORIZONTAL:int = 10;
      
      private const COST_VERTICAL:int = 10;
      
      private const COST_DIAGONAL:int = 14;
      
      private var _xMapStart:int = 0;
      
      private var _yMapStart:int = 0;
      
      private var wMap:int;
      
      private var hMap:int;
      
      private var map:Array;
      
      private var openList:Vector.<Node> = new Vector.<Node>();
      
      private var closeList:Vector.<Node> = new Vector.<Node>();
      
      private var isFinded:Boolean = false;
      
      public var runTimeInMs:int = 0;
      
      private var _titls:Object;
      
      private var _allNodeDict:Dictionary = new Dictionary(true);
      
      public function AStarPathFinder(param1:Object, param2:int = 100, param3:int = 100)
      {
         var _loc5_:String = null;
         super();
         _titls = param1;
         var _loc4_:Array = [];
         for(var _loc6_:String in _allNodeDict)
         {
            _loc4_.push(_loc6_);
         }
         if(_pool)
         {
            while(_loc4_.length > 0)
            {
               _loc5_ = _loc4_.pop();
               delete _allNodeDict[_loc5_];
               _pool.push(_allNodeDict[_loc5_]);
            }
         }
         else
         {
            while(_loc4_.length > 0)
            {
               delete _allNodeDict[_loc4_.pop()];
            }
         }
         _loc4_ = null;
         if(param2 > wMap || param3 > hMap)
         {
            if(param2 > wMap)
            {
               wMap = param2;
            }
            if(param3 > hMap)
            {
               hMap = param3;
            }
            this.initMap();
         }
      }
      
      private function getNodeByXY(param1:int, param2:int) : Node
      {
         var _loc3_:Node = null;
         if(_allNodeDict[param1 + "_" + param2] == null)
         {
            if(_pool.length > 0)
            {
               _loc3_ = _pool.pop();
               _loc3_.update(param1,param2);
            }
            else
            {
               _loc3_ = new Node(param1,param2);
            }
            _allNodeDict[param1 + "_" + param2] = _loc3_;
         }
         return _allNodeDict[param1 + "_" + param2];
      }
      
      public function find(param1:Point, param2:Point) : Array
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Array = null;
         var _loc7_:Node = getNodeByXY(param1.x,param1.y);
         var _loc9_:Node = getNodeByXY(param2.x,param2.y);
         openList.push(_loc7_);
         while(openList.length > 0)
         {
            _loc7_ = openList.shift();
            _loc7_.isInOpen = false;
            _loc7_.isInClose = true;
            this.closeList.push(_loc7_);
            if(_loc7_.x == param2.x && _loc7_.y == param2.y)
            {
               this.isFinded = true;
               break;
            }
            _loc5_ = this.getAroundsNode(_loc7_.x,_loc7_.y);
            for each(var _loc3_:Node in _loc5_)
            {
               _loc6_ = this.getGValue(_loc7_,_loc3_);
               _loc8_ = this.getHValue(_loc7_,_loc9_,_loc3_);
               if(_loc3_.isInOpen)
               {
                  if(_loc6_ < _loc3_.g)
                  {
                     _loc3_.g = _loc6_;
                     _loc3_.h = _loc8_;
                     _loc3_.f = _loc6_ + _loc8_;
                     _loc3_.parentNode = _loc7_;
                  }
               }
               else
               {
                  _loc3_.g = _loc6_;
                  _loc3_.h = _loc8_;
                  _loc3_.f = _loc6_ + _loc8_;
                  _loc3_.parentNode = _loc7_;
                  this.insertAndSort(_loc3_);
               }
            }
         }
         if(this.isFinded)
         {
            _loc4_ = this.createPath(param1.x,param1.y);
            this.destroyLists();
            return _loc4_;
         }
         this.destroyLists();
         return null;
      }
      
      private function filerPath(param1:Array) : Array
      {
         var _loc4_:Point = null;
         var _loc3_:Point = null;
         var _loc2_:Point = null;
         var _loc6_:Boolean = false;
         var _loc5_:int = 0;
         if(!param1 && param1.length == 0)
         {
            return null;
         }
         _loc5_ = 1;
         while(_loc5_ < param1.length - 1)
         {
            _loc4_ = param1[_loc5_ - 1] as Point;
            _loc3_ = param1[_loc5_] as Point;
            _loc2_ = param1[_loc5_ + 1] as Point;
            if(_loc4_.x == _loc2_.x && _loc4_.x != _loc3_.x)
            {
               _loc3_.x = _loc4_.x;
            }
            else if(_loc4_.y == _loc2_.y && _loc4_.y != _loc3_.y)
            {
               _loc3_.y = _loc4_.y;
            }
            _loc5_++;
         }
         return param1;
      }
      
      private function createPath(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:Node = this.closeList.pop();
         while(_loc4_.x != param1 || _loc4_.y != param2)
         {
            _loc3_.unshift(new Point(_loc4_.x,_loc4_.y));
            _loc4_ = _loc4_.parentNode;
         }
         _loc3_.unshift(new Point(_loc4_.x,_loc4_.y));
         return _loc3_;
      }
      
      private function findAndSort(param1:Node) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(this.openList.length);
         if(_loc3_ < 1)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(param1.x == this.openList[_loc2_].x && param1.y == this.openList[_loc2_].y)
            {
               this.openList.splice(_loc2_,1);
               _loc3_--;
               _loc2_--;
            }
            _loc2_++;
         }
      }
      
      private function insertAndSort(param1:Node) : void
      {
         var _loc2_:int = 0;
         param1.isInOpen = true;
         var _loc3_:int = int(this.openList.length);
         if(_loc3_ == 0)
         {
            this.openList.push(param1);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(param1.f <= this.openList[_loc2_].f)
               {
                  this.openList.splice(_loc2_,0,param1);
                  return;
               }
               _loc2_++;
            }
            this.openList.push(param1);
         }
      }
      
      private function getGValue(param1:Node, param2:Node) : int
      {
         var _loc3_:int = 0;
         if(param1.y == param2.y)
         {
            _loc3_ = param1.g + 10;
         }
         else if(param1.x == param2.x)
         {
            _loc3_ = param1.g + 10;
         }
         else
         {
            _loc3_ = param1.g + 14;
         }
         return _loc3_;
      }
      
      private function getHValue(param1:Node, param2:Node, param3:Node) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = Math.abs(param3.x - param2.x) * (10 - 5);
         _loc5_ = Math.abs(param3.y - param2.y) * (10 - 5);
         return _loc4_ + _loc5_;
      }
      
      private function getAroundsNode(param1:int, param2:int) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         _loc4_ = param1 - 1;
         _loc5_ = param2;
         if(isWalkable(_loc4_,_loc5_) && !getPointIsClose(_loc4_,_loc5_))
         {
            _loc3_.push(getNodeByXY(_loc4_,_loc5_));
         }
         _loc4_ = param1 - 1;
         _loc5_ = param2 - 1;
         if(isWalkable(_loc4_,_loc5_) && !getPointIsClose(_loc4_,_loc5_))
         {
            _loc3_.push(getNodeByXY(_loc4_,_loc5_));
         }
         _loc4_ = param1;
         _loc5_ = param2 - 1;
         if(isWalkable(_loc4_,_loc5_) && !getPointIsClose(_loc4_,_loc5_))
         {
            _loc3_.push(getNodeByXY(_loc4_,_loc5_));
         }
         _loc4_ = param1 + 1;
         _loc5_ = param2 - 1;
         if(isWalkable(_loc4_,_loc5_) && !getPointIsClose(_loc4_,_loc5_))
         {
            _loc3_.push(getNodeByXY(_loc4_,_loc5_));
         }
         _loc4_ = param1 + 1;
         _loc5_ = param2;
         if(isWalkable(_loc4_,_loc5_) && !getPointIsClose(_loc4_,_loc5_))
         {
            _loc3_.push(getNodeByXY(_loc4_,_loc5_));
         }
         _loc4_ = param1 + 1;
         _loc5_ = param2 + 1;
         if(isWalkable(_loc4_,_loc5_) && !getPointIsClose(_loc4_,_loc5_))
         {
            _loc3_.push(getNodeByXY(_loc4_,_loc5_));
         }
         _loc4_ = param1;
         _loc5_ = param2 + 1;
         if(isWalkable(_loc4_,_loc5_) && !getPointIsClose(_loc4_,_loc5_))
         {
            _loc3_.push(getNodeByXY(_loc4_,_loc5_));
         }
         _loc4_ = param1 - 1;
         _loc5_ = param2 + 1;
         if(isWalkable(_loc4_,_loc5_) && !getPointIsClose(_loc4_,_loc5_))
         {
            _loc3_.push(getNodeByXY(_loc4_,_loc5_));
         }
         return _loc3_;
      }
      
      private function getPointIsClose(param1:int, param2:int) : Boolean
      {
         return _allNodeDict[param1 + "_" + param2] == null ? false : _allNodeDict[param1 + "_" + param2].isInClose;
      }
      
      private function isWalkable(param1:int, param2:int) : Boolean
      {
         if(param1 < this._xMapStart || param1 >= this.wMap || param2 < this._yMapStart || param2 >= this.hMap)
         {
            return false;
         }
         return _titls[param1 + "_" + param2] ? true : false;
      }
      
      private function initMap() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_pool)
         {
            return;
         }
         _pool = new Vector.<Node>();
         _loc2_ = this._yMapStart;
         while(_loc2_ < this.hMap)
         {
            _loc1_ = this._xMapStart;
            while(_loc1_ < this.wMap)
            {
               _pool.push(new Node(_loc1_,_loc2_));
               _loc1_++;
            }
            _loc2_++;
         }
      }
      
      public function set yMapStart(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         _yMapStart = param1;
      }
      
      public function get yMapStart() : int
      {
         return _yMapStart;
      }
      
      public function set xMapStart(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         _xMapStart = param1;
      }
      
      public function get xMapStart() : int
      {
         return _xMapStart;
      }
      
      private function destroyLists() : void
      {
         this.closeList = null;
         this.openList = null;
         this.map = null;
      }
   }
}

