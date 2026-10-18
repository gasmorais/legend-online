package map.internals.data
{
   import flash.geom.Point;
   import map.internals.data.template.MapTemplate;
   
   public dynamic class MapInitData
   {
      
      public var targetPoint:Point;
      
      public var mapTempInfo:MapTemplate;
      
      public var showMapName:Boolean = true;
      
      public function MapInitData()
      {
         super();
      }
   }
}

