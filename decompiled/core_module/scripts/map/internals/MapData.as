package map.internals
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MapData
   {
      
      public static var mapId:int;
      
      private static var _mapBitmap:Bitmap;
      
      public static var movePos:Point;
      
      public static var stageWidth:int;
      
      public static var stageHeight:int;
      
      private static var _thumbnail:Bitmap;
      
      public static var fogBitmapDataCache:BitmapData;
      
      private static var _petTailClips:Array;
      
      public static var petTextures:Array;
      
      public function MapData()
      {
         super();
      }
      
      public static function get thumbnail() : Bitmap
      {
         return _thumbnail;
      }
      
      public static function set thumbnail(param1:Bitmap) : void
      {
         if(_thumbnail)
         {
            ObjectUtils.disposeObject(thumbnail);
         }
         _thumbnail = param1;
      }
      
      public static function get mapBitmap() : Bitmap
      {
         return _mapBitmap;
      }
      
      public static function clearData() : void
      {
         if(_mapBitmap)
         {
            if(_mapBitmap.parent)
            {
               _mapBitmap.parent.removeChild(_mapBitmap);
            }
            _mapBitmap.bitmapData.dispose();
         }
         if(fogBitmapDataCache)
         {
            fogBitmapDataCache.dispose();
            fogBitmapDataCache = null;
         }
         _mapBitmap = null;
         movePos = null;
         mapId = 0;
         cleanPetTailClips();
      }
      
      public static function set mapBitmap(param1:Bitmap) : void
      {
         if(param1 == _mapBitmap)
         {
            return;
         }
         if(_mapBitmap)
         {
            if(_mapBitmap.parent)
            {
               _mapBitmap.parent.removeChild(_mapBitmap);
            }
            _mapBitmap.bitmapData.dispose();
         }
         if(param1 && param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         _mapBitmap = param1;
      }
      
      public static function get petTailClips() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:Bitmap = null;
         var _loc2_:BitmapData = null;
         if(!_petTailClips)
         {
            _petTailClips = [];
            _loc3_ = 1;
            while(_loc3_ < 20)
            {
               if(_loc3_ % 2 == 1)
               {
                  _loc1_ = ComponentFactory.Instance.creat("asset.map.PetTail" + _loc3_);
                  _loc2_ = _loc1_.bitmapData.clone();
                  _petTailClips[_loc3_ - 1] = _loc2_;
                  _loc1_.bitmapData.dispose();
                  _loc1_ = null;
               }
               _loc3_++;
            }
         }
         return _petTailClips;
      }
      
      private static function cleanPetTailClips() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BitmapData = null;
         if(!_petTailClips)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _petTailClips.length)
         {
            _loc1_ = _petTailClips[_loc2_] as BitmapData;
            if(_loc1_)
            {
               _loc1_.dispose();
            }
            _loc2_++;
         }
         _petTailClips = null;
      }
   }
}

