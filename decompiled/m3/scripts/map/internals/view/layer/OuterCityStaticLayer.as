package map.internals.view.layer
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentSetting;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.campaign.CampaignManager;
   import map.internals.MapData;
   import map.internals.data.FloorMapInfo;
   import map.internals.data.MapInfo;
   import map.internals.event.OuterCityEvent;
   import map.internals.library.MapElmsLibrary;
   import map.space.SpaceManager;
   
   public class OuterCityStaticLayer extends SimpleMapLayer
   {
      
      public static const drawOff:int = 100;
      
      private var _initBackground:Boolean = true;
      
      private var _background:MapBackgroundView = new MapBackgroundView();
      
      private var _floorBitmap:Bitmap;
      
      private var _isFirst:Boolean = true;
      
      private var _isOldMap:Boolean;
      
      private var _firstTimeId:int;
      
      protected var _renderMatrix:Matrix = new Matrix();
      
      protected var _renderColorTransfrom:ColorTransform = new ColorTransform();
      
      private var _count:int;
      
      public function OuterCityStaticLayer()
      {
         addChildAt(_background,0);
         __resizeHandler(null);
         super();
         this.mouseChildren = this.mouseEnabled = false;
         this.scrollRect = null;
      }
      
      public function get floorBitmap() : Bitmap
      {
         return _floorBitmap;
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         var _loc2_:MapInfo = null;
         _isOldMap = false;
         if(_floorBitmap)
         {
            if(_floorBitmap.parent)
            {
               _floorBitmap.parent.removeChild(_floorBitmap);
            }
            _floorBitmap.bitmapData.dispose();
         }
         if(StageReferance.stageWidth <= MapData.stageWidth && StageReferance.stageHeight <= MapData.stageHeight)
         {
            _loc2_ = CampaignManager.instance.mapModel;
            if(!_loc2_)
            {
               _loc2_ = SpaceManager.instance.model;
            }
            if(_loc2_ && MapData.mapId == _loc2_.mapId && MapData.mapBitmap && checkPointEquit(_loc2_.targetPoint,MapData.movePos))
            {
               _isOldMap = true;
               _floorBitmap = MapData.mapBitmap;
            }
            else
            {
               _floorBitmap = new Bitmap(new BitmapData(StageReferance.stageWidth + 100 * 2,StageReferance.stageHeight + 100 * 2,true,0));
            }
         }
         else
         {
            _floorBitmap = new Bitmap(new BitmapData(StageReferance.stageWidth + 100 * 2,StageReferance.stageHeight + 100 * 2,true,0));
         }
         if(!_isOldMap)
         {
            MapData.clearData();
         }
         addChild(_floorBitmap);
         _floorBitmap.scrollRect = null;
      }
      
      private function checkPointEquit(param1:Point, param2:Point) : Boolean
      {
         if(param1 && param2 && param1.x == param2.x && param1.y == param2.y)
         {
            return true;
         }
         return false;
      }
      
      override public function set mapData(param1:MapInfo) : void
      {
         _model = param1 as FloorMapInfo;
         _model.addEventListener("currentConfigChange",__currentConfigChange);
      }
      
      private function __currentConfigChange(param1:OuterCityEvent) : void
      {
         upDateNextRend();
      }
      
      public function upDateNextRend() : void
      {
         if(_firstTimeId > 0)
         {
            clearInterval(_firstTimeId);
         }
         _firstTimeId = 0;
         if(_isFirst)
         {
            _firstTimeId = setInterval(upDateNextRend,500);
            _isFirst = false;
            return;
         }
         if(stage)
         {
            stage.invalidate();
            addEventListener("render",__onScreenRend);
         }
      }
      
      private function __onScreenRend(param1:Event) : void
      {
         removeEventListener("render",__onScreenRend);
         draw();
      }
      
      private function draw() : void
      {
         var _loc1_:Array = null;
         var _loc4_:Point = null;
         var _loc7_:BitmapData = null;
         _count = _count + 1;
         if(_count == 1 && _isOldMap)
         {
            drawBackground();
            return;
         }
         var _loc9_:Dictionary = _model.currentSceneFloorData;
         _floorBitmap.bitmapData.lock();
         var _loc2_:Rectangle = new Rectangle(0,0,_floorBitmap.width,_floorBitmap.height);
         var _loc8_:Point = new Point();
         _floorBitmap.bitmapData.fillRect(_loc2_,0);
         var _loc5_:Array = getLayerIndexRange();
         for each(var _loc6_ in _loc5_)
         {
            for each(var _loc3_:Object in _loc9_)
            {
               _loc1_ = _loc3_.floor[_loc6_];
               _loc4_ = _loc3_.start as Point;
               if(_loc1_)
               {
                  for each(var _loc10_:Object in _loc1_)
                  {
                     _loc7_ = MapElmsLibrary.instance.getElementByPath(ComponentSetting.RESOURCE_PATH + _loc10_.url) as BitmapData;
                     if(_loc7_)
                     {
                        _loc8_.x = _loc4_.x + _loc10_.x % 1000 + parent.x + 100;
                        _loc8_.y = _loc4_.y + _loc10_.y % 1000 + parent.y + 100;
                        _loc2_.width = _loc7_.width;
                        _loc2_.height = _loc7_.height;
                        _floorBitmap.bitmapData.copyPixels(_loc7_,_loc2_,_loc8_,null,null,true);
                     }
                  }
               }
            }
         }
         drawBackground();
         _floorBitmap.bitmapData.unlock();
         _floorBitmap.x = -parent.x - 100;
         _floorBitmap.y = -parent.y - 100;
      }
      
      private function getLayerIndexRange() : Array
      {
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc8_:Dictionary = _model.currentSceneFloorData;
         var _loc1_:Array = [];
         var _loc2_:Dictionary = new Dictionary(true);
         for each(var _loc3_:Object in _loc8_)
         {
            _loc5_ = _loc3_.floor;
            for(var _loc7_:String in _loc5_)
            {
               _loc2_[_loc7_] = _loc7_;
            }
         }
         for each(var _loc4_:String in _loc2_)
         {
            _loc6_ = int(_loc4_);
            if(_loc6_ >= 102)
            {
               _loc1_.push(_loc6_);
            }
         }
         _loc1_.sort(2 | 0x10);
         return _loc1_.reverse();
      }
      
      private function drawBackground() : void
      {
         var _loc2_:Array = null;
         var _loc4_:Dictionary = _model.currentSceneFloorData;
         if(_initBackground)
         {
            var _loc8_:int = 0;
            var _loc7_:Dictionary = _loc4_;
            for each(var _loc1_:Object in _loc7_)
            {
               _loc2_ = _loc1_.floor[101];
               if(_loc2_)
               {
                  var _loc6_:int = 0;
                  var _loc5_:Array = _loc2_;
                  for each(var _loc3_:Object in _loc5_)
                  {
                     initBackground(_loc3_.url);
                  }
               }
            }
         }
      }
      
      private function initBackground(param1:String) : void
      {
         _background.mapWidth = _model.mapTempInfo.Width;
         _background.mapHeight = _model.mapTempInfo.Height;
         _initBackground = false;
         if(_model.mapTempInfo.Width < 5000)
         {
            _background.path = "MapMaterial/floor/new_water/water04.jpg";
         }
         else
         {
            _background.path = param1;
         }
      }
      
      public function backgroundXandY(param1:int, param2:int) : void
      {
         param1 -= param1 % 100;
         param2 -= param2 % 100;
         _background.x = param1;
         _background.y = param2;
      }
      
      public function resize() : void
      {
         _background.resize();
         __resizeHandler(null);
         upDateNextRend();
      }
      
      override public function dispose() : void
      {
         if(_floorBitmap)
         {
            if(_floorBitmap.parent)
            {
               _floorBitmap.parent.removeChild(_floorBitmap);
            }
            _floorBitmap.bitmapData.dispose();
         }
         if(_model)
         {
            _model.removeEventListener("currentConfigChange",__currentConfigChange);
         }
         removeEventListener("render",__onScreenRend);
         if(_background)
         {
            _background.dispose();
         }
         _background = null;
         super.dispose();
      }
   }
}

