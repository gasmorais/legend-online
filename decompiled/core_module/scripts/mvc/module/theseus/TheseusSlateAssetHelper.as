package mvc.module.theseus
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class TheseusSlateAssetHelper
   {
      
      private static const ASSET_NAMES:Array = ["","TheseusGodHeaditem1","TheseusGodHeaditem2","TheseusGodHeaditem3","TheseusGodHeaditem4","TheseusGodHeaditem5","TheseusGodHeaditem6","TheseusGodHeaditem7"];
      
      private static var _bitmapCache:Object = {};
      
      public function TheseusSlateAssetHelper()
      {
         super();
      }
      
      public static function getAssetName(param1:int) : String
      {
         if(param1 >= 1 && param1 <= 7)
         {
            return ASSET_NAMES[param1];
         }
         return ASSET_NAMES[1];
      }
      
      public static function getSlateBitmap(param1:int) : Bitmap
      {
         var _loc3_:String = getAssetName(param1);
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap(_loc3_);
         if(_loc2_ && _loc2_.bitmapData)
         {
            _bitmapCache[_loc3_] = _loc2_.bitmapData;
            return new Bitmap(_loc2_.bitmapData);
         }
         return null;
      }
      
      public static function getRotatedSlateBitmap(param1:int, param2:int) : Bitmap
      {
         if(param2 == 0)
         {
            return getSlateBitmap(param1);
         }
         var _loc8_:Bitmap = getSlateBitmap(param1);
         if(!_loc8_)
         {
            return null;
         }
         var _loc7_:Number = param2 * 90 * 3.141592653589793 / 180;
         var _loc9_:Matrix = new Matrix();
         var _loc10_:Number = _loc8_.width;
         var _loc3_:Number = _loc8_.height;
         if(param2 % 2 == 1)
         {
            _loc9_.translate(-_loc10_ / 2,-_loc3_ / 2);
            _loc9_.rotate(_loc7_);
            _loc9_.translate(_loc3_ / 2,_loc10_ / 2);
         }
         else
         {
            _loc9_.translate(-_loc10_ / 2,-_loc3_ / 2);
            _loc9_.rotate(_loc7_);
            _loc9_.translate(_loc10_ / 2,_loc3_ / 2);
         }
         var _loc4_:int = param2 % 2 == 1 ? _loc3_ : _loc10_;
         var _loc6_:int = param2 % 2 == 1 ? _loc10_ : _loc3_;
         var _loc5_:BitmapData = new BitmapData(_loc4_,_loc6_,true,0);
         _loc5_.draw(_loc8_,_loc9_,null,null,null,true);
         return new Bitmap(_loc5_);
      }
      
      public static function getSlateDisplay(param1:int, param2:int) : Bitmap
      {
         return getRotatedSlateBitmap(param1,param2);
      }
      
      public static function clearCache() : void
      {
         var _loc1_:BitmapData = null;
         for(var _loc2_:String in _bitmapCache)
         {
            _loc1_ = _bitmapCache[_loc2_];
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         _bitmapCache = {};
      }
   }
}

