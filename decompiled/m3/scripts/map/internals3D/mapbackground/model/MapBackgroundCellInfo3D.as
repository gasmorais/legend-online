package map.internals3D.mapbackground.model
{
   import com.speedEngine.components.bone.BoneImage;
   import flash.display.Bitmap;
   import map.internals3D.mapbackground.MapBackgroundView3D;
   import yishi.manager.PathManager;
   
   public class MapBackgroundCellInfo3D
   {
      
      public var x:int;
      
      public var y:int;
      
      public var row:int;
      
      public var col:int;
      
      public var view:Object;
      
      public var state:int;
      
      public var mapId:int;
      
      private var _offset:Number;
      
      public function MapBackgroundCellInfo3D()
      {
         super();
      }
      
      public function get offset() : Number
      {
         return _offset;
      }
      
      public function setCenterPoint(param1:int, param2:int) : void
      {
         param1 -= x;
         param2 -= y;
         _offset = Math.sqrt(param1 * param1 + param2 * param2);
      }
      
      public function get url() : String
      {
         if(MapBackgroundView3D.RENDER_MODE_3D)
         {
            return PathManager.getMapBackPaths(mapId) + "tile_" + tileName + ".png.atf";
         }
         return PathManager.getMapBackPaths(mapId) + "tile_" + tileName + ".jpg";
      }
      
      public function get tileName() : String
      {
         return row + "_" + col;
      }
      
      public function dispose() : void
      {
         if(view)
         {
            if(view.parent)
            {
               view.parent.removeChild(view);
            }
            if(view is BoneImage)
            {
               view.dispose();
            }
            else if(view is Bitmap)
            {
               Bitmap(view).bitmapData.dispose();
            }
            view = null;
         }
      }
   }
}

