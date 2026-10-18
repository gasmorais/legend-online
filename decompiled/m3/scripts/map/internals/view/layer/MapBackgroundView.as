package map.internals.view.layer
{
   import com.pickgliss.ui.ComponentSetting;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.utils.getTimer;
   import map.internals.library.MapElmsLibrary;
   
   public class MapBackgroundView extends Shape
   {
      
      private var _source:BitmapData;
      
      private var _mapWidth:int;
      
      private var _mapHeight:int;
      
      public function MapBackgroundView()
      {
         super();
         this.scrollRect = null;
      }
      
      public function set mapHeight(param1:int) : void
      {
         _mapHeight = param1;
      }
      
      public function set mapWidth(param1:int) : void
      {
         _mapWidth = param1;
      }
      
      public function set path(param1:String) : void
      {
         drawBackGround(MapElmsLibrary.instance.getElementByPath(ComponentSetting.RESOURCE_PATH + param1) as BitmapData);
      }
      
      private function drawBackGround(param1:BitmapData) : void
      {
         _source = param1;
         if(!this.stage)
         {
            return;
         }
         draw();
      }
      
      private function draw() : void
      {
         var _loc3_:int = getTimer();
         var _loc1_:int = this.stage.stageWidth;
         var _loc2_:int = this.stage.stageHeight;
         if(!_source)
         {
            return;
         }
         this.graphics.clear();
         this.graphics.beginBitmapFill(_source,null,true,true);
         if(_mapWidth > 5000 || _mapHeight > 5000)
         {
            this.graphics.drawRect(-100,-100,_loc1_ + 300,_loc2_ + 300);
         }
         else
         {
            this.graphics.drawRect(0,0,_mapWidth,_mapHeight);
         }
         this.graphics.endFill();
         this.cacheAsBitmap = true;
      }
      
      public function resize() : void
      {
         if(_source)
         {
            draw();
         }
      }
      
      public function dispose() : void
      {
         _source = null;
         this.graphics.clear();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

