package map.internals.data
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.internals.data.template.MapTemplate;
   import map.internals.event.OuterCityEvent;
   import mvc.module.armyII.UserArmy;
   import yishi.manager.TempleteManager;
   
   public class MapInfo extends EventDispatcher
   {
      
      public static const MAX_WIDTH:int = 5000;
      
      public static const MAX_HEIGHT:int = 5000;
      
      public var exit:Boolean = false;
      
      private var _mapId:int;
      
      protected var _currentSceneFloorData:Dictionary = new Dictionary(true);
      
      public var floorData:Object;
      
      public var moviesData:Object;
      
      public var topsData:Object;
      
      private var _mapTielsData:Object;
      
      public var _targetPoint:Point;
      
      public var paths:Object;
      
      private var _nodes:Object;
      
      public var preLoaderNextMap:Boolean;
      
      private var _reg:RegExp = /,/;
      
      private var _aroundPoints:Array = [{
         "x":0,
         "y":0
      },{
         "x":-1,
         "y":0
      },{
         "x":-1,
         "y":1
      },{
         "x":-1,
         "y":-1
      },{
         "x":0,
         "y":1
      },{
         "x":0,
         "y":-1
      },{
         "x":1,
         "y":1
      },{
         "x":1,
         "y":0
      },{
         "x":1,
         "y":-1
      }];
      
      public function MapInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get mapTielsData() : Object
      {
         return _mapTielsData;
      }
      
      public function set mapTielsData(param1:Object) : void
      {
         _mapTielsData = param1;
      }
      
      public function get currentSceneFloorData() : Dictionary
      {
         return _currentSceneFloorData;
      }
      
      public function set nodes(param1:Object) : void
      {
         _nodes = param1;
      }
      
      public function get nodes() : Object
      {
         return _nodes;
      }
      
      public function get emptyNodes() : Boolean
      {
         return Boolean(_nodes);
      }
      
      public function get targetPoint() : Point
      {
         return _targetPoint;
      }
      
      public function set targetPoint(param1:Point) : void
      {
         _targetPoint = param1;
         this.dispatchEvent(new OuterCityEvent("centerPoint",param1));
      }
      
      public function get mapTempInfo() : MapTemplate
      {
         return TempleteManager.instance.mapTemplateCate.getTemplateByID(_mapId);
      }
      
      public function set mapId(param1:int) : void
      {
         _mapId = param1;
      }
      
      public function get mapId() : int
      {
         return _mapId;
      }
      
      public function getTilesById(param1:String) : Array
      {
         param1 = param1.replace(_reg,"_");
         if(param1.indexOf("data") == -1)
         {
            param1 += "data";
         }
         return mapTielsData[param1 + ".titles"];
      }
      
      public function findDijkstraPath(param1:String, param2:String) : Array
      {
         return null;
      }
      
      public function aStarPathFinder(param1:Point, param2:Point, param3:int = 25) : Array
      {
         return null;
      }
      
      public function addGarrison(param1:Point, param2:Point) : void
      {
         this.dispatchEvent(new OuterCityEvent("addGarrison",{
            "start":param1,
            "end":param2
         }));
      }
      
      public function addDijkstra(param1:Array, param2:UserArmy) : void
      {
         this.dispatchEvent(new OuterCityEvent("addDijkstra",{
            "path":param1,
            "army":param2
         }));
      }
      
      public function getWalkableValueByXY(param1:int, param2:int) : int
      {
         return mapTielsData[param1 + "_" + param2];
      }
      
      public function getAroundWalkPoint(param1:int, param2:int) : Point
      {
         var _loc5_:Boolean = false;
         param1 /= 20;
         param2 /= 20;
         var _loc3_:Point = new Point(-1,-1);
         for each(var _loc4_ in _aroundPoints)
         {
            _loc5_ = getWalkable(param1 + _loc4_.x,param2 + _loc4_.y);
            if(_loc5_)
            {
               _loc3_.x = param1 + _loc4_.x;
               _loc3_.y = param2 + _loc4_.y;
               break;
            }
         }
         if(_loc5_)
         {
            return _loc3_;
         }
         return null;
      }
      
      public function walkableValueIsPara(param1:int, param2:int, param3:int) : Boolean
      {
         return mapTielsData[param2 + "_" + param3] == param1 ? true : false;
      }
      
      public function getWalkable(param1:int, param2:int) : Boolean
      {
         return mapTielsData[param1 + "_" + param2] ? true : false;
      }
      
      public function isBarrier(param1:int, param2:int) : Boolean
      {
         return mapTielsData[param1 + "_" + param2] == 2;
      }
      
      public function dispose() : void
      {
         floorData = null;
         moviesData = null;
         topsData = null;
         _nodes = null;
         paths = null;
         _currentSceneFloorData = null;
      }
   }
}

