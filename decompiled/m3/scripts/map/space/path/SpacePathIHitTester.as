package map.space.path
{
   import flash.geom.Point;
   
   public interface SpacePathIHitTester
   {
      
      function isHit(param1:Point) : Boolean;
      
      function getNextMoveAblePoint(param1:Point, param2:Number, param3:Number, param4:Number) : Point;
   }
}

