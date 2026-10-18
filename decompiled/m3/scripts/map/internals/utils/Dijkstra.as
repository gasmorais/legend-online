package map.internals.utils
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.view.tips.MessageTipManager;
   
   public class Dijkstra
   {
      
      private static const MAX_DISTANCE:int = 99999;
      
      private var _startKey:String;
      
      private var _endKey:String;
      
      private var _nodes:Object;
      
      private var _close1List:Array;
      
      private var _close2List:Array;
      
      private var _close3List:Array;
      
      private var _close4List:Array;
      
      private var _pathList:Array;
      
      private var _impassMap:Dictionary;
      
      private var _kLine:Number;
      
      private var _bLine:Number;
      
      private var _minDistance:int;
      
      private var _reg:RegExp = /,/;
      
      public function Dijkstra()
      {
         super();
      }
      
      public function findShortedPoint(param1:String, param2:String, param3:Object) : Array
      {
         _startKey = param1.replace(_reg,"_");
         _endKey = param2.replace(_reg,"_");
         _nodes = param3;
         if(_startKey == _endKey)
         {
            return [_startKey];
         }
         var _loc4_:String = "";
         if(!param3[param1])
         {
            _loc4_ = LanguageMgr.GetTranslation("map.internals.utils.Dijkstra.command01");
            MessageTipManager.instance().show(_loc4_);
            return [_startKey];
         }
         if(!param3[param2])
         {
            _loc4_ = LanguageMgr.GetTranslation("map.internals.utils.Dijkstra.command02");
            MessageTipManager.instance().show(_loc4_);
            return [_startKey];
         }
         _pathList = [];
         init();
         return _pathList;
      }
      
      private function init() : void
      {
         var _loc11_:Array = null;
         var _loc4_:int = 0;
         var _loc12_:Array = null;
         var _loc3_:int = 0;
         var _loc13_:Array = null;
         var _loc2_:int = 0;
         var _loc14_:Array = null;
         var _loc1_:int = 0;
         lineRelated(stringToPoint(_startKey),stringToPoint(_endKey));
         _close1List = [];
         _close2List = [];
         var _loc8_:NodeII = new NodeII();
         _loc8_.name = _startKey;
         _loc8_.parent = null;
         _loc8_.distance = 0;
         _close1List.push(_loc8_);
         _close2List.push(_loc8_);
         _close3List = [];
         _close4List = [];
         var _loc5_:NodeII = new NodeII();
         _loc5_.name = _endKey;
         _loc5_.parent = null;
         _loc5_.distance = 0;
         _close3List.push(_loc5_);
         _close4List.push(_loc5_);
         findStartPoint(_close1List,_endKey,1);
         findStartPoint(_close2List,_endKey,-1);
         findStartPoint(_close3List,_startKey,1);
         findStartPoint(_close4List,_startKey,-1);
         var _loc6_:Object = {"distance":99999};
         if(_close1List.length != 1 && (_close1List[_close1List.length - 1].name == _startKey || _close1List[0].name == _startKey))
         {
            _impassMap = new Dictionary();
            _loc11_ = startSearch(_close1List,_endKey,_nodes);
            _loc4_ = int(_loc11_.length > 1 ? _loc11_[_loc11_.length - 1].distance : 99999);
            _loc6_ = {
               "path":_loc11_,
               "distance":_loc4_
            };
         }
         var _loc9_:Object = {"distance":99999};
         if(_close2List.length != 1 && (_close2List[_close2List.length - 1].name == _endKey || _close2List[0].name == _endKey))
         {
            _impassMap = new Dictionary();
            _loc12_ = startSearch(_close2List,_endKey,_nodes);
            _loc3_ = int(_loc12_.length > 1 ? _loc12_[_loc12_.length - 1].distance : 99999);
            _loc9_ = {
               "path":_loc12_,
               "distance":_loc3_
            };
         }
         var _loc7_:Object = {"distance":99999};
         if(_close3List.length != 1 && (_close3List[_close3List.length - 1].name == _startKey || _close3List[0].name == _startKey))
         {
            _impassMap = new Dictionary();
            _loc13_ = startSearch(_close3List,_startKey,_nodes);
            _loc2_ = int(_loc13_.length > 1 ? _loc13_[_loc13_.length - 1].distance : 99999);
            _loc7_ = {
               "path":_loc13_,
               "distance":_loc2_
            };
         }
         var _loc10_:Object = {"distance":99999};
         if(_close4List.length != 1 && (_close4List[_close4List.length - 1].name == _endKey || _close4List[0].name == _endKey))
         {
            _impassMap = new Dictionary();
            _loc14_ = startSearch(_close4List,_startKey,_nodes);
            _loc1_ = int(_loc14_.length > 1 ? _loc14_[_loc14_.length - 1].distance : 99999);
            _loc10_ = {
               "path":_loc14_,
               "distance":_loc1_
            };
         }
         var _loc15_:Object = {};
         _loc15_ = _loc6_.distance >= _loc9_.distance ? _loc9_ : _loc6_;
         _loc15_ = _loc15_.distance >= _loc7_.distance ? _loc7_ : _loc15_;
         _loc15_ = _loc15_.distance >= _loc10_.distance ? _loc10_ : _loc15_;
         _minDistance = _loc15_.distance;
         if(_loc15_.distance != 99999)
         {
            _pathList = getPathList(_loc15_.path,_loc15_.path[_loc15_.path.length - 1].name);
         }
         if(_pathList[0] == _endKey)
         {
            _pathList = _pathList.reverse();
         }
      }
      
      private function findStartPoint(param1:Array, param2:String, param3:int) : void
      {
         var _loc5_:NodeII = param1[0];
         var _loc4_:NodeII = new NodeII("",null,99999);
         for(var _loc6_:String in _nodes[_loc5_.name])
         {
            if(posToLine(stringToPoint(_loc6_)) == param3)
            {
               if(_loc4_.name == "")
               {
                  _loc4_.name = _loc6_;
                  _loc4_.parent = _loc5_;
                  _loc4_.distance = _loc5_.distance + int(_nodes[_loc5_.name][_loc6_]);
               }
               else if(getAngle(stringToPoint(_loc5_.name),stringToPoint(param2),stringToPoint(_loc4_.name)) > getAngle(stringToPoint(_loc5_.name),stringToPoint(param2),stringToPoint(_loc6_)))
               {
                  _loc4_.name = _loc6_;
                  _loc4_.parent = _loc5_;
                  _loc4_.distance = _loc5_.distance + int(_nodes[_loc5_.name][_loc6_]);
               }
            }
         }
         if(_loc4_.name != "")
         {
            param1.push(_loc4_);
         }
      }
      
      private function startSearch(param1:Array, param2:String, param3:Object) : Array
      {
         var _loc6_:NodeII = null;
         var _loc4_:NodeII = null;
         var _loc5_:Object = null;
         while(param1[param1.length - 1].name != param2)
         {
            _loc6_ = param1[param1.length - 1];
            _loc4_ = new NodeII("",null,99999);
            for(var _loc7_:String in param3[_loc6_.name])
            {
               if(isInpass(_loc6_.name,_loc7_))
               {
                  if(!isInClose(param1,_loc7_))
                  {
                     if(_loc4_.name == "")
                     {
                        _loc4_.name = _loc7_;
                        _loc4_.parent = _loc6_;
                        _loc4_.distance = _loc6_.distance + int(param3[_loc6_.name][_loc7_]);
                     }
                     else if(getAngle(stringToPoint(_loc6_.name),stringToPoint(param2),stringToPoint(_loc4_.name)) > getAngle(stringToPoint(_loc6_.name),stringToPoint(param2),stringToPoint(_loc7_)))
                     {
                        _loc4_.name = _loc7_;
                        _loc4_.parent = _loc6_;
                        _loc4_.distance = _loc6_.distance + int(param3[_loc6_.name][_loc7_]);
                     }
                  }
               }
            }
            if(_loc4_.name == "")
            {
               if(_loc6_.parent != null)
               {
                  _loc5_ = {};
                  _loc5_[_loc6_.name] = param3[_loc6_.parent.name][_loc6_.name];
                  _impassMap[_loc6_.parent.name] = _loc5_;
                  param1.splice(param1.length - 1,1);
               }
            }
            else
            {
               param1.push(_loc4_);
            }
         }
         return param1;
      }
      
      private function isInClose(param1:Array, param2:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].name == param2)
            {
               _loc4_ = true;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      private function isInpass(param1:String, param2:String) : Boolean
      {
         var _loc3_:Boolean = true;
         if(_impassMap[param1] != null && _impassMap[param1].hasOwnProperty(param2))
         {
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      private function getAngle(param1:Point, param2:Point, param3:Point) : Number
      {
         var _loc4_:Number = distancePoint(param1,param3);
         var _loc5_:Number = distancePoint(param1,param2);
         var _loc6_:Number = distancePoint(param3,param2);
         return Math.acos((Math.pow(_loc4_,2) + Math.pow(_loc5_,2) - Math.pow(_loc6_,2)) / (2 * _loc4_ * _loc5_));
      }
      
      private function distancePoint(param1:Point, param2:Point) : Number
      {
         return Math.sqrt(Math.pow(param1.x - param2.x,2) + Math.pow(param1.y - param2.y,2));
      }
      
      private function stringToPoint(param1:String) : Point
      {
         var _loc2_:Array = param1.split("_");
         return new Point(int(_loc2_[0]),int(_loc2_[1]));
      }
      
      private function posToLine(param1:Point) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Number = _kLine * param1.x - param1.y + _bLine;
         if(_loc3_ > 0)
         {
            _loc2_ = 1;
         }
         else if(_loc3_ == 0)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = -1;
         }
         return _loc2_;
      }
      
      private function lineRelated(param1:Point, param2:Point) : void
      {
         _kLine = (param1.y - param2.y) / (param1.x - param2.x);
         _bLine = param1.y - _kLine * param1.x;
      }
      
      private function getPathList(param1:Array, param2:String) : Array
      {
         var _loc4_:NodeII = null;
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            if(param2 == param1[_loc5_].name)
            {
               _loc4_ = param1[_loc5_];
               break;
            }
            _loc5_++;
         }
         _loc3_.push(_loc4_.name);
         while(param1[0].name != _loc4_.parent.name)
         {
            _loc4_ = _loc4_.parent;
            _loc3_.push(_loc4_.name);
         }
         _loc3_.push(param1[0].name);
         return _loc3_.reverse();
      }
      
      public function get minDistance() : int
      {
         return _minDistance;
      }
   }
}

class NodeII
{
   
   public var parent:NodeII;
   
   public var name:String;
   
   public var distance:int;
   
   public function NodeII(param1:String = "", param2:NodeII = null, param3:int = 99999)
   {
      super();
      this.name = param1;
      this.parent = param2;
      this.distance = param3;
   }
}
