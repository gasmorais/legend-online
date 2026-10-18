package utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CopyBitmapDataUtils
   {
      
      public function CopyBitmapDataUtils()
      {
         super();
      }
      
      public function getNumberView(param1:int, param2:Sprite, param3:BitmapData, param4:Number = 30, param5:Number = 36, param6:int = 25, param7:int = 30, param8:String = "0123456789.", param9:int = 2) : void
      {
         var _loc11_:int = 0;
         var _loc15_:String = null;
         var _loc12_:int = 0;
         var _loc13_:Bitmap = null;
         removeTimeView(param2);
         var _loc14_:String = param1 + "";
         if(param9 == 2)
         {
            _loc14_ = param1 < 10 ? "0" + param1 : "" + param1;
         }
         var _loc10_:Sprite = new Sprite();
         _loc11_ = 0;
         while(_loc11_ < _loc14_.length)
         {
            _loc15_ = _loc14_.substr(_loc11_,1);
            _loc12_ = param8.indexOf(_loc15_);
            _loc13_ = getBit(param3,param4,param5,_loc12_ * param7,0);
            _loc13_.x = _loc11_ * param6;
            _loc10_.addChild(_loc13_);
            _loc11_++;
         }
         param2.addChild(_loc10_);
         if(param1 < 0)
         {
            removeTimeView(param2);
         }
      }
      
      private function removeTimeView(param1:Sprite) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      private function getBit(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : Bitmap
      {
         var _loc8_:Bitmap = new Bitmap(new BitmapData(param2,param3,true,0));
         var _loc6_:Rectangle = new Rectangle(param4,param5,param2,param3);
         var _loc7_:Point = new Point(0,0);
         _loc8_.bitmapData.copyPixels(param1,_loc6_,_loc7_,null,null,true);
         return _loc8_;
      }
   }
}

