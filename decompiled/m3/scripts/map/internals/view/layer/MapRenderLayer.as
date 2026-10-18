package map.internals.view.layer
{
   import com.pickgliss.ui.ComponentSetting;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import map.campaign.CampaignManager;
   import map.internals.MapData;
   import map.internals.library.MapElmsLibrary;
   
   public class MapRenderLayer
   {
      
      private var _bitmap:Bitmap;
      
      private var _displayBitmap:Bitmap;
      
      private var _parent:Sprite;
      
      private var _data:Object;
      
      private var _indexArray:Array;
      
      private var _backUrl:String = "";
      
      private var _elmsData:MapElmsLibrary;
      
      protected var _renderMatrix:Matrix = new Matrix();
      
      private var rotateCount:int;
      
      private var _renderSmoothing:Boolean = true;
      
      public function MapRenderLayer(param1:Sprite, param2:BitmapData = null, param3:String = "auto", param4:Boolean = false)
      {
         super();
         _parent = param1;
         _renderSmoothing = param4;
         _bitmap = new Bitmap(param2,param3,param4);
         param1.addChild(_bitmap);
      }
      
      public function addChild(param1:DisplayObject) : DisplayObject
      {
         _parent.addChild(param1);
         return param1;
      }
      
      public function get bitmap() : Bitmap
      {
         return _bitmap;
      }
      
      public function get displayBitmap() : Bitmap
      {
         return _displayBitmap;
      }
      
      private function __onScreenRend(param1:Event) : void
      {
      }
      
      public function set backUrl(param1:String) : void
      {
         _backUrl = param1;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         if(_backUrl == "")
         {
            getBackId(param1);
         }
         initRender(param1);
      }
      
      private function initRender(param1:Object) : void
      {
         if(CampaignManager.instance.mapModel)
         {
            if(CampaignManager.instance.mapModel.mapTempInfo.Id == MapData.mapId && MapData.mapBitmap)
            {
               resetBitmap();
               return;
            }
         }
         MapData.clearData();
         _indexArray = [];
         for each(var _loc3_:Object in param1)
         {
            for each(var _loc2_:Array in _loc3_)
            {
               _indexArray = _indexArray.concat(_loc2_);
            }
         }
         _indexArray = _indexArray.sortOn("baseNum",16);
         render();
      }
      
      private function resetBitmap() : void
      {
         if(_bitmap)
         {
            if(_bitmap.parent)
            {
               _bitmap.parent.removeChild(_bitmap);
            }
            if(_bitmap.bitmapData)
            {
               _bitmap.bitmapData.dispose();
            }
         }
         _bitmap = MapData.mapBitmap;
         addChild(_bitmap);
      }
      
      private function getBackId(param1:Object) : void
      {
         var _loc4_:BitmapData = null;
         var _loc2_:Boolean = false;
         for each(var _loc5_:Object in param1)
         {
            for each(var _loc3_:Array in _loc5_)
            {
               for each(var _loc6_:Object in _loc3_)
               {
                  if(!_backUrl && _loc6_["baseNum"] == 101)
                  {
                     _backUrl = _loc6_["url"];
                     _loc4_ = getBitmapDataById(_backUrl) as BitmapData;
                     if(_loc4_)
                     {
                        break;
                     }
                  }
               }
            }
            if(_loc4_)
            {
               break;
            }
         }
      }
      
      public function set elmsDatas(param1:MapElmsLibrary) : void
      {
         _elmsData = param1;
      }
      
      private function render() : void
      {
         var _loc2_:Object = null;
         var _loc5_:BitmapData = null;
         var _loc3_:int = 0;
         var _loc1_:Rectangle = new Rectangle();
         var _loc4_:Point = new Point();
         _bitmap.bitmapData.lock();
         drawBack();
         _loc3_ = 0;
         while(_loc3_ < _indexArray.length)
         {
            _loc2_ = _indexArray[_loc3_];
            if(_loc2_["baseNum"] > 101)
            {
               _loc5_ = getBitmapDataById(_loc2_.url);
               if(_loc5_)
               {
                  if(_loc2_.rotation == 0)
                  {
                     _loc4_.x = _loc2_.x;
                     _loc4_.y = _loc2_.y;
                     _loc1_.width = _loc5_.width;
                     _loc1_.height = _loc5_.height;
                     _bitmap.bitmapData.copyPixels(_loc5_,_loc1_,_loc4_,null,null,true);
                  }
                  else
                  {
                     _renderMatrix.identity();
                     rotateCount = rotateCount + 1;
                     _renderMatrix.translate(0,0);
                     if(_loc2_.rotation != 0)
                     {
                        _renderMatrix.rotate(_loc2_.rotation / 180 * 3.14159);
                     }
                     _renderMatrix.translate(_loc2_.x,_loc2_.y);
                     _bitmap.bitmapData.draw(_loc5_,_renderMatrix,null,null,null,_renderSmoothing);
                  }
               }
            }
            _loc3_++;
         }
         _bitmap.bitmapData.unlock();
         _bitmap.cacheAsBitmap = false;
         _bitmap.opaqueBackground = 0;
      }
      
      private function drawBack() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Rectangle = new Rectangle();
         var _loc5_:Point = new Point();
         var _loc2_:BitmapData = getBitmapDataById(_backUrl) as BitmapData;
         if(!_loc2_)
         {
            return;
         }
         _loc1_.width = _loc2_.width;
         _loc1_.height = _loc2_.height;
         _loc3_ = 0;
         while(_loc3_ < _bitmap.width)
         {
            _loc4_ = 0;
            while(_loc4_ < _bitmap.height)
            {
               _loc5_.x = _loc3_;
               _loc5_.y = _loc4_;
               _bitmap.bitmapData.copyPixels(_loc2_,_loc1_,_loc5_);
               _loc4_ += _loc2_.height;
            }
            _loc3_ += _loc2_.width;
            _loc3_;
         }
         _loc1_ = null;
         _loc5_ = null;
         _loc2_ = null;
      }
      
      private function getBitmapDataById(param1:String) : BitmapData
      {
         return _elmsData.getElementByPath(ComponentSetting.RESOURCE_PATH + param1) as BitmapData;
      }
      
      public function dispose() : void
      {
         if(_bitmap)
         {
            if(_bitmap.parent)
            {
               _bitmap.parent.removeChild(_bitmap);
            }
         }
         _bitmap = null;
         _indexArray = null;
      }
   }
}

