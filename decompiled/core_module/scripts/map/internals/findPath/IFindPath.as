package map.internals.findPath
{
   import flash.geom.Point;
   
   public interface IFindPath
   {
      
      function get map() : Array;
      
      function get path() : Array;
      
      function find(param1:Point, param2:Point) : Array;
   }
}

