package battle.particle.freeze
{
   import flash.geom.Point;
   
   public class Line
   {
      
      public var startPoint:Point;
      
      public var endPoint:Point;
      
      public function Line(param1:Point, param2:Point)
      {
         super();
         startPoint = param1;
         endPoint = param2;
      }
      
      public function get len() : Number
      {
         return Math.sqrt((endPoint.x - startPoint.x) * (endPoint.x - startPoint.x) + (endPoint.y - startPoint.y) * (endPoint.y - startPoint.y));
      }
      
      public function dispose() : void
      {
         startPoint = null;
         endPoint = null;
      }
   }
}

