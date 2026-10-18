package com.pickgliss.utils
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class PNGHitAreaFactory
   {
      
      private static var points1:Vector.<Point>;
      
      private static var points2:Vector.<Point>;
      
      private static var coord:Vector.<Number>;
      
      private static var commands:Vector.<int>;
      
      public function PNGHitAreaFactory()
      {
         super();
      }
      
      public static function drawHitArea(param1:Bitmap) : Sprite
      {
         getPointAroundImage(param1);
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16711680);
         _loc2_.graphics.drawPath(commands,coord);
         _loc2_.graphics.endFill();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         commands.length = coord.length = 0;
         return _loc2_;
      }
      
      public static function getPointAroundImage(param1:Bitmap, param2:int = 0, param3:int = 0) : Array
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc16_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         points1 = new Vector.<Point>();
         points2 = new Vector.<Point>();
         commands = new Vector.<int>();
         coord = new Vector.<Number>();
         var _loc14_:int = param1.width;
         var _loc6_:int = param1.height;
         var _loc13_:int = param2;
         var _loc15_:int = param3;
         _loc7_ = 1;
         while(_loc7_ <= _loc14_)
         {
            _loc8_ = 1;
            while(_loc8_ <= _loc6_)
            {
               _loc16_ = uint(param1.bitmapData.getPixel32(_loc7_,_loc8_) >> 24 & 0xFF);
               if(_loc16_ != 0)
               {
                  points1.push(new Point(_loc7_ + _loc13_,_loc8_ + _loc15_));
                  break;
               }
               _loc8_++;
            }
            _loc9_ = _loc6_;
            while(_loc9_ > 0)
            {
               _loc10_ = uint(param1.bitmapData.getPixel32(_loc7_,_loc9_) >> 24 & 0xFF);
               if(_loc10_ != 0 && _loc7_ != _loc9_)
               {
                  points2.unshift(new Point(_loc7_ + _loc13_,_loc9_ + _loc15_));
                  break;
               }
               _loc9_--;
            }
            _loc7_++;
         }
         for each(var _loc4_:Point in points1)
         {
            coord.push(_loc4_.x);
            coord.push(_loc4_.y);
         }
         for each(var _loc5_:Point in points2)
         {
            coord.push(_loc5_.x);
            coord.push(_loc5_.y);
         }
         var _loc12_:uint = points1.length + points2.length;
         commands.push(1);
         _loc11_ = 1;
         while(_loc11_ < _loc12_)
         {
            commands.push(2);
            _loc11_++;
         }
         points1.length = points2.length = 0;
         return [commands,coord];
      }
   }
}

