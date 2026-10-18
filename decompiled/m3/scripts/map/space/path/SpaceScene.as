package map.space.path
{
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class SpaceScene extends EventDispatcher
   {
      
      private var _hitTester:SpacePathIHitTester;
      
      private var _pathSearcher:SpacePathIPathSearcher;
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function SpaceScene(param1:Number = 100000)
      {
         super();
         this._pathSearcher = new SpacePathRoboSearcher(20,param1,8);
         this._x = 0;
         this._y = 0;
      }
      
      public function get HitTester() : SpacePathIHitTester
      {
         return _hitTester;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set position(param1:Point) : void
      {
         if(param1.x != _x || param1.y != _y)
         {
            this._x = param1.x;
            this._y = param1.y;
         }
      }
      
      public function get position() : Point
      {
         return new Point(_x,_y);
      }
      
      public function setPathSearcher(param1:SpacePathIPathSearcher) : void
      {
         _pathSearcher = param1;
      }
      
      public function setHitTester(param1:SpacePathIHitTester) : void
      {
         _hitTester = param1;
      }
      
      public function hit(param1:Point) : Boolean
      {
         return _hitTester.isHit(param1);
      }
      
      public function searchPath(param1:Point, param2:Point) : Array
      {
         return _pathSearcher.search(param1,param2,_hitTester);
      }
      
      public function localToGlobal(param1:Point) : Point
      {
         return new Point(param1.x + _x,param1.y + _y);
      }
      
      public function globalToLocal(param1:Point) : Point
      {
         return new Point(param1.x - _x,param1.y - _y);
      }
      
      public function dispose() : void
      {
         _hitTester = null;
         _pathSearcher = null;
      }
   }
}

