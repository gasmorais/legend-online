package yishi.utils
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class GraphicsUtils
   {
      
      public function GraphicsUtils()
      {
         super();
      }
      
      public static function drawSector(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Sprite
      {
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Sprite = new Sprite();
         var _loc8_:Number = param3;
         var _loc9_:Number = 0;
         if(param4 != 0)
         {
            _loc8_ = Math.cos(param4 * 3.141592653589793 / 180) * param3;
            _loc9_ = Math.sin(param4 * 3.141592653589793 / 180) * param3;
         }
         _loc14_.graphics.beginFill(16776960,1);
         _loc14_.graphics.moveTo(param1,param2);
         _loc14_.graphics.lineTo(param1 + _loc8_,param2 - _loc9_);
         var _loc6_:Number = param5 * 3.141592653589793 / 180 / param5;
         var _loc10_:Number = Math.cos(_loc6_);
         var _loc15_:Number = Math.sin(_loc6_);
         var _loc7_:Number = 0;
         _loc11_ = 0;
         while(_loc11_ < param5)
         {
            _loc12_ = _loc10_ * _loc8_ - _loc15_ * _loc9_;
            _loc13_ = _loc10_ * _loc9_ + _loc15_ * _loc8_;
            _loc8_ = _loc12_;
            _loc9_ = _loc13_;
            _loc14_.graphics.lineTo(_loc8_ + param1,-_loc9_ + param2);
            _loc11_++;
         }
         _loc14_.graphics.lineTo(param1,param2);
         _loc14_.graphics.endFill();
         return _loc14_;
      }
      
      public static function drawDisplayMask(param1:DisplayObject) : DisplayObject
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc7_:Number = NaN;
         var _loc8_:BitmapData = new BitmapData(param1.width,param1.height,true,16711680);
         _loc8_.draw(param1);
         var _loc6_:Shape = new Shape();
         _loc6_.cacheAsBitmap = true;
         _loc3_ = 0;
         while(_loc3_ < _loc8_.width)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc8_.height)
            {
               _loc2_ = _loc8_.getPixel32(_loc3_,_loc4_);
               _loc5_ = uint(_loc2_ >> 24 & 0xFF);
               _loc7_ = _loc5_ / 255;
               if(_loc2_ > 0)
               {
                  _loc6_.graphics.beginFill(0,_loc7_);
                  _loc6_.graphics.drawCircle(_loc3_,_loc4_,1);
               }
               _loc4_++;
            }
            _loc3_++;
         }
         _loc8_.dispose();
         _loc8_ = null;
         return _loc6_;
      }
      
      public static function changeSectorAngle(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         param1.graphics.clear();
         var _loc9_:Number = param4;
         var _loc10_:Number = 0;
         if(param5 != 0)
         {
            _loc9_ = Math.cos(param5 * 3.141592653589793 / 180) * param4;
            _loc10_ = Math.sin(param5 * 3.141592653589793 / 180) * param4;
         }
         param1.graphics.beginFill(16776960,1);
         param1.graphics.moveTo(param2,param3);
         param1.graphics.lineTo(param2 + _loc9_,param3 - _loc10_);
         var _loc7_:Number = param6 * 3.141592653589793 / 180 / param6;
         var _loc11_:Number = Math.cos(_loc7_);
         var _loc15_:Number = Math.sin(_loc7_);
         var _loc8_:Number = 0;
         _loc12_ = 0;
         while(_loc12_ < param6)
         {
            _loc13_ = _loc11_ * _loc9_ - _loc15_ * _loc10_;
            _loc14_ = _loc11_ * _loc10_ + _loc15_ * _loc9_;
            _loc9_ = _loc13_;
            _loc10_ = _loc14_;
            param1.graphics.lineTo(_loc9_ + param2,-_loc10_ + param3);
            _loc12_++;
         }
         param1.graphics.lineTo(param2,param3);
         param1.graphics.endFill();
      }
   }
}

