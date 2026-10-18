package map.outercity.path
{
   import flash.geom.Point;
   
   public interface PathIPathSearcher
   {
      
      function search(param1:Point, param2:Point, param3:PathIHitTester) : Array;
   }
}

