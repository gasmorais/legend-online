package map.internals.constant
{
   import flash.geom.Point;
   
   public class MapGrid
   {
      
      public static const GRID_WIDTH:Number = 2.5;
      
      public static const GRID_HEIGHT:Number = 2.5;
      
      public function MapGrid()
      {
         super();
      }
      
      public static function getConvertWidth(param1:int) : int
      {
         return int(param1 / 2.5);
      }
      
      public static function getConvertHeight(param1:int) : int
      {
         return int(param1 / 2.5);
      }
      
      public static function getConvertPoint(param1:Point) : Point
      {
         return new Point(int(param1.x / 2.5),int(param1.y / 2.5));
      }
      
      public static function getPositionString(param1:String) : String
      {
         return getConvertWidth(int(param1.split(",")[0])) + "," + getConvertHeight(int(param1.split(",")[1]));
      }
   }
}

