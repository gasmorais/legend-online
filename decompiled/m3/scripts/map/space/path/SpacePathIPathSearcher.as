package map.space.path
{
   import flash.geom.Point;
   
   public interface SpacePathIPathSearcher
   {
      
      function search(param1:Point, param2:Point, param3:SpacePathIHitTester) : Array;
   }
}

