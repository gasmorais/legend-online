package worldmap
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class WorldMapView extends Sprite
   {
      
      public static const WORLDMAP_WIDTH:int = 1500;
      
      public static const WORLDMAP_HEIGHT:int = 900;
      
      private var _bg:Bitmap;
      
      private var _grayMap:Bitmap;
      
      private var _mapMask:MovieClip;
      
      public function WorldMapView()
      {
         super();
         initView();
         mouseChildren = mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.worldmap.Bg");
         addChild(_bg);
         _grayMap = new Bitmap(_bg.bitmapData);
         _grayMap.x = _bg.x;
         _grayMap.y = _bg.y;
         addChild(_grayMap);
         _grayMap.filters = ComponentFactory.Instance.creatFilters("core.GrayFilter");
         _mapMask = ComponentFactory.Instance.creatCustomObject("asset.worldmap.MapAreaContainerMask");
         addChild(_mapMask);
         _grayMap.cacheAsBitmap = true;
         _mapMask.cacheAsBitmap = true;
         _grayMap.mask = _mapMask;
      }
      
      public function setScale() : void
      {
         this.scrollRect = new Rectangle(0,0,1000,600);
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

