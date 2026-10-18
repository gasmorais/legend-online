package yishi.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class DisplayObjectUtils
   {
      
      public function DisplayObjectUtils()
      {
         super();
      }
      
      public static function createSpriteByRect(param1:Rectangle, param2:uint = 0, param3:Number = 1) : Sprite
      {
         var _loc4_:Sprite = new Sprite();
         _loc4_.graphics.beginFill(param2,param3);
         _loc4_.graphics.drawRect(param1.x,param1.y,param1.width,param1.height);
         _loc4_.graphics.endFill();
         return _loc4_;
      }
      
      public static function getDisplayPoint(param1:DisplayObject) : Bitmap
      {
         if(!param1 || param1.width == 0 || param1.height == 0)
         {
            return null;
         }
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,false,4294967295);
         _loc2_.draw(param1,null,null,null);
         return new Bitmap(_loc2_);
      }
      
      public static function IsEmpty(param1:int, param2:int, param3:BitmapData) : Boolean
      {
         return GetAlpha(param1,param2,param3) <= 150;
      }
      
      public static function GetAlpha(param1:int, param2:int, param3:BitmapData) : uint
      {
         return param3.getPixel32(param1,param2) >> 24 & 0xFF;
      }
      
      public function IsXLineEmpty(param1:int, param2:int, param3:int, param4:BitmapData) : Boolean
      {
         var _loc5_:int = 0;
         param1 = int(param1 < 0 ? 0 : param1);
         param3 = int(param1 + param3 > param4.width ? param4.width - param1 : param3);
         _loc5_ = 0;
         while(_loc5_ < param3)
         {
            if(!IsEmpty(param1 + _loc5_,param2,param4))
            {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
      
      public function IsYLineEmtpy(param1:int, param2:int, param3:int, param4:BitmapData) : Boolean
      {
         var _loc5_:int = 0;
         param2 = int(param2 < 0 ? 0 : param2);
         param3 = int(param2 + param3 > param4.height ? param4.height - param2 : param3);
         _loc5_ = 0;
         while(_loc5_ < param3)
         {
            if(!IsEmpty(param1,param2 + _loc5_,param4))
            {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
   }
}

