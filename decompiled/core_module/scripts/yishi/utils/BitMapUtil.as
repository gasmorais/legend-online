package yishi.utils
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class BitMapUtil
   {
      
      public function BitMapUtil()
      {
         super();
      }
      
      public static function scaleBitmapData(param1:BitmapData, param2:Number, param3:Number) : BitmapData
      {
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(param2,param3);
         var _loc4_:BitmapData = new BitmapData(param2 * param1.width,param3 * param1.height,true,0);
         _loc4_.draw(param1,_loc5_);
         return _loc4_;
      }
      
      public static function flipHorizontal(param1:BitmapData, param2:Boolean = true, param3:uint = 0) : BitmapData
      {
         var _loc5_:Matrix = new Matrix();
         _loc5_.a = -1;
         _loc5_.tx = param1.width;
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height,param2,param3);
         _loc4_.draw(param1,_loc5_);
         return _loc4_;
      }
      
      public static function flipVertical(param1:BitmapData, param2:Boolean = true, param3:uint = 0) : BitmapData
      {
         var _loc5_:Matrix = new Matrix();
         _loc5_.d = -1;
         _loc5_.ty = param1.height;
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height,param2,param3);
         _loc4_.draw(param1,_loc5_);
         return _loc4_;
      }
   }
}

