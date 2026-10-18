package yishi.utils
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class PixelCalculater
   {
      
      private static var _instance:PixelCalculater;
      
      public function PixelCalculater()
      {
         super();
      }
      
      public static function get instance() : PixelCalculater
      {
         if(!_instance)
         {
            _instance = new PixelCalculater();
         }
         return _instance;
      }
      
      public function getTopUnopaque(param1:DisplayObject) : Point
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:* = 0;
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         var _loc2_:Rectangle = param1.getBounds(param1);
         var _loc6_:Matrix = new Matrix(1,0,0,1,-_loc2_.left,-_loc2_.top);
         _loc3_.draw(param1,_loc6_);
         _loc4_ = 0;
         loop0:
         while(_loc4_ < _loc3_.height)
         {
            _loc5_ = 0;
            while(true)
            {
               if(_loc5_ >= _loc3_.width)
               {
                  _loc4_++;
                  continue loop0;
               }
               _loc7_ = _loc3_.getPixel32(_loc5_,_loc4_);
               if(_loc7_ > 0)
               {
                  break;
               }
               _loc5_++;
            }
            return new Point(_loc5_,_loc4_);
         }
         return new Point(0,0);
      }
   }
}

