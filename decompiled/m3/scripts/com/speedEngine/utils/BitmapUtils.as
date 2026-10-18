package com.speedEngine.utils
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class BitmapUtils
   {
      
      private static var _maskShape:Shape;
      
      private static var _curX:Number;
      
      private static var _curY:Number;
      
      private static var _rowNumber:Number;
      
      private static var _rowWitdh:Number;
      
      private static var _rowHeight:Number;
      
      private static var _frameStep:Number;
      
      private static var _curRow:Number = 0;
      
      private static var _sleepSecond:int = 0;
      
      private static var _callBack:Function;
      
      private static var _timer:Timer;
      
      private static var _isMask:String;
      
      private static var _zeroPoint:Point = new Point();
      
      public function BitmapUtils()
      {
         super();
      }
      
      public static function updateColor(param1:BitmapData, param2:Number) : BitmapData
      {
         if(!param1 || isNaN(param2))
         {
            return param1;
         }
         var _loc5_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         var _loc3_:BitmapData = param1.clone();
         var _loc4_:ColorTransform = getHightlightColorTransfrom(param2);
         if(_loc4_)
         {
            _loc3_.draw(param1,null,_loc4_,null,null,true);
         }
         _loc5_.draw(param1,null,getColorTransfromByColor(param2));
         _loc5_.draw(_loc3_,null,null,"hardlight");
         _loc3_.dispose();
         _loc3_ = null;
         return _loc5_;
      }
      
      public static function getHightlightColorTransfrom(param1:uint) : ColorTransform
      {
         var _loc5_:uint = uint(param1 >> 16 & 0xFF);
         var _loc2_:uint = uint(param1 >> 8 & 0xFF);
         var _loc4_:uint = uint(param1 & 0xFF);
         var _loc7_:uint = uint(param1 >> 24 & 0xFF);
         var _loc9_:int = int(_loc5_);
         var _loc8_:int = int(_loc2_);
         var _loc6_:int = int(_loc4_);
         var _loc3_:Boolean = false;
         if(!(_loc9_ == _loc8_ || _loc9_ == _loc6_ || _loc8_ == _loc6_))
         {
            if(_loc9_ > _loc8_)
            {
               if(_loc9_ > _loc6_)
               {
                  _loc9_ = 50;
                  _loc8_ = 0;
                  _loc6_ = 0;
                  _loc3_ = true;
               }
               else
               {
                  _loc9_ = 0;
                  _loc8_ = 0;
                  _loc6_ = 50;
                  _loc3_ = true;
               }
            }
            else if(_loc8_ > _loc6_)
            {
               _loc9_ = 10;
               _loc8_ = 30;
               _loc6_ = 30;
               _loc3_ = true;
            }
            else
            {
               _loc9_ = 0;
               _loc8_ = 0;
               _loc6_ = 50;
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            return new ColorTransform(1,1,1,1,_loc9_,_loc8_,_loc6_,0);
         }
         return null;
      }
      
      public static function discolor(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc2_.matrix = [0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
         param1.applyFilter(param1,param1.rect,_zeroPoint,_loc2_);
      }
      
      public static function lightDown(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc2_.matrix = [0.7,0,0,0,0,0,0.7,0,0,0,0,0,0.7,0,0,0,0,0,1,0];
         param1.applyFilter(param1,param1.rect,_zeroPoint,_loc2_);
      }
      
      public static function light(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc2_.matrix = [1.2,0,0,0,0,0,1.2,0,0,0,0,0,1.2,0,0,0,0,0,1,0];
         param1.applyFilter(param1,param1.rect,_zeroPoint,_loc2_);
      }
      
      public static function setBitmapDataGray(param1:BitmapData) : void
      {
         var _loc5_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:Vector.<uint> = param1.getVector(param1.rect);
         var _loc4_:uint = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = uint(_loc3_[_loc5_] << 16 >>> 24);
            _loc3_[_loc5_] = _loc2_ << 16 | _loc2_ << 8 | _loc2_;
            _loc5_++;
         }
         param1.setVector(param1.rect,_loc3_);
      }
      
      public static function getColorTransfromByColor(param1:uint) : ColorTransform
      {
         var _loc4_:uint = uint(param1 >> 16 & 0xFF);
         var _loc2_:uint = uint(param1 >> 8 & 0xFF);
         var _loc3_:uint = uint(param1 & 0xFF);
         var _loc5_:uint = uint(param1 >> 24 & 0xFF);
         if(!(_loc4_ == _loc2_ || _loc4_ == _loc3_ || _loc2_ == _loc3_))
         {
            if(_loc4_ < _loc2_ && _loc4_ < _loc3_)
            {
               if(_loc2_ < _loc3_)
               {
                  _loc2_ += 40;
                  _loc3_ += 10;
               }
               else
               {
                  _loc2_ += 40;
                  _loc3_ += 10;
               }
            }
            else if(_loc2_ < _loc4_ && _loc2_ < _loc3_)
            {
               if(_loc4_ < _loc3_)
               {
                  _loc4_ += 40;
                  _loc3_ += 10;
               }
               else
               {
                  _loc4_ += 40;
                  _loc3_ += 10;
               }
            }
            else if(_loc3_ < _loc2_ && _loc3_ < _loc4_)
            {
               if(_loc2_ < _loc4_)
               {
                  _loc2_ += 40;
                  _loc4_ += 10;
               }
               else
               {
                  _loc2_ += 40;
                  _loc4_ += 10;
               }
            }
         }
         return new ColorTransform(0,0,0,1,_loc4_,_loc2_,_loc3_,0);
      }
      
      public static function maskMovie(param1:DisplayObject, param2:Shape, param3:String, param4:Number, param5:Number, param6:Number, param7:Number, param8:int, param9:Function) : void
      {
         if(!param1 && !param1.parent)
         {
            return;
         }
         _callBack = param9;
         _maskShape = param2;
         _isMask = param3;
         _curX = 0;
         _curY = 0;
         _rowNumber = param4;
         _rowWitdh = param5;
         _rowHeight = param6;
         _sleepSecond = param8;
         _frameStep = param7;
         _curRow = 0;
         if(_isMask == "true")
         {
            param1.parent.addChild(_maskShape);
            param1.mask = _maskShape;
            _maskShape.addEventListener("enterFrame",onMaskMovieEnerFrame);
         }
         else
         {
            param1.mask = null;
            _timer = new Timer(_sleepSecond * 1000);
            _timer.addEventListener("timer",onMaskMovieTimer);
            _timer.start();
         }
      }
      
      private static function onMaskMovieEnerFrame(param1:Event) : void
      {
         _maskShape.graphics.beginFill(0);
         _maskShape.graphics.drawRect(_curX,_curY,_frameStep,_rowHeight);
         _maskShape.graphics.endFill();
         _curX += _frameStep;
         if(_curX >= _rowWitdh)
         {
            _curRow = _curRow + 1;
            _curX = 0;
            _curY = _curRow * _rowHeight;
         }
         if(_curRow >= _rowNumber)
         {
            _maskShape.removeEventListener("enterFrame",onMaskMovieEnerFrame);
            if(_callBack == null)
            {
               return;
            }
            if(_sleepSecond > 0)
            {
               _timer = new Timer(_sleepSecond * 1000);
               _timer.addEventListener("timer",onMaskMovieTimer);
               _timer.start();
            }
            else
            {
               if(_maskShape.parent)
               {
                  _maskShape.parent.removeChild(_maskShape);
               }
               _maskShape = null;
               _callBack();
            }
         }
      }
      
      private static function onMaskMovieTimer(param1:TimerEvent) : void
      {
         _timer.stop();
         _timer.removeEventListener("timerComplete",onMaskMovieTimer);
         _timer = null;
         if(_maskShape && _maskShape.parent)
         {
            _maskShape.parent.removeChild(_maskShape);
         }
         _maskShape = null;
         if(_callBack != null)
         {
            _callBack();
         }
      }
      
      public static function reverseBtimapData(param1:BitmapData) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = param1.width;
         var _loc4_:int = param1.height;
         var _loc3_:Vector.<uint> = param1.getVector(new Rectangle(0,0,_loc2_,_loc4_));
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            param1.setVector(new Rectangle(0,_loc5_,_loc2_,1),_loc3_.splice(0,_loc2_).reverse());
            _loc5_++;
         }
      }
      
      private static function returnBitmapData(param1:int, param2:int) : BitmapData
      {
         if(param1 <= 0 || param2 <= 0)
         {
            return null;
         }
         return new BitmapData(param1,param2,true,16777215);
      }
      
      private static function cpoyBitmapData(param1:Rectangle, param2:BitmapData, param3:BitmapData, param4:Point) : void
      {
         if(!param3 || !param2)
         {
            return;
         }
         param3.copyPixels(param2,param1,param4);
      }
      
      public static function getScale9Image(param1:BitmapData, param2:int, param3:int, param4:Rectangle) : BitmapData
      {
         var _loc18_:int = 0;
         var _loc20_:int = 0;
         if(!param1)
         {
            return null;
         }
         var _loc19_:int = param2;
         var _loc8_:int = param3;
         var _loc5_:Number = param4.y;
         var _loc12_:Number = param4.y + param4.height;
         var _loc14_:Number = param4.x;
         var _loc9_:Number = param4.x + param4.width;
         var _loc21_:BitmapData = returnBitmapData(_loc14_,_loc5_);
         var _loc23_:BitmapData = returnBitmapData(_loc14_,param1.height - _loc12_);
         var _loc17_:BitmapData = returnBitmapData(param1.width - _loc9_,_loc5_);
         var _loc24_:BitmapData = returnBitmapData(param1.width - _loc9_,param1.height - _loc12_);
         var _loc11_:BitmapData = returnBitmapData(_loc9_ - _loc14_,_loc5_);
         var _loc7_:BitmapData = returnBitmapData(_loc14_,_loc12_ - _loc5_);
         var _loc6_:BitmapData = returnBitmapData(param1.width - _loc9_,_loc12_ - _loc5_);
         var _loc22_:BitmapData = returnBitmapData(_loc9_ - _loc14_,param1.height - _loc12_);
         var _loc13_:BitmapData = returnBitmapData(_loc9_ - _loc14_,_loc12_ - _loc5_);
         var _loc25_:BitmapData = new BitmapData(_loc19_,_loc8_);
         _loc25_.lock();
         var _loc10_:Rectangle = new Rectangle(0,0,0,0);
         if(_loc21_)
         {
            _loc10_.setTo(0,0,_loc21_.width,_loc21_.height);
            cpoyBitmapData(_loc10_,param1,_loc21_,new Point(0,0));
         }
         if(_loc23_)
         {
            _loc10_.setTo(0,_loc12_,_loc23_.width,_loc23_.height);
            cpoyBitmapData(_loc10_,param1,_loc23_,new Point(0,0));
         }
         if(_loc17_)
         {
            _loc10_.setTo(_loc9_,0,_loc17_.width,_loc17_.height);
            cpoyBitmapData(_loc10_,param1,_loc17_,new Point(0,0));
         }
         if(_loc24_)
         {
            _loc10_.setTo(_loc9_,_loc12_,_loc24_.width,_loc24_.height);
            cpoyBitmapData(_loc10_,param1,_loc24_,new Point(0,0));
         }
         if(_loc11_)
         {
            _loc10_.setTo(_loc14_,0,_loc11_.width,_loc11_.height);
            cpoyBitmapData(_loc10_,param1,_loc11_,new Point(0,0));
         }
         if(_loc7_)
         {
            _loc10_.setTo(0,_loc5_,_loc7_.width,_loc7_.height);
            cpoyBitmapData(_loc10_,param1,_loc7_,new Point(0,0));
         }
         if(_loc6_)
         {
            _loc10_.setTo(_loc9_,_loc5_,_loc6_.width,_loc6_.height);
            cpoyBitmapData(_loc10_,param1,_loc6_,new Point(0,0));
         }
         if(_loc22_)
         {
            _loc10_.setTo(_loc14_,_loc12_,_loc22_.width,_loc22_.height);
            cpoyBitmapData(_loc10_,param1,_loc22_,new Point(0,0));
         }
         if(_loc13_)
         {
            _loc10_.setTo(_loc14_,_loc5_,_loc13_.width,_loc13_.height);
            cpoyBitmapData(_loc10_,param1,_loc13_,new Point(0,0));
         }
         if(_loc21_)
         {
            cpoyBitmapData(_loc21_.rect,_loc21_,_loc25_,new Point(0,0));
         }
         _loc18_ = _loc21_ ? _loc21_.width : 0;
         _loc20_ = _loc19_ - (_loc17_ ? _loc17_.width : 0);
         while(_loc18_ < _loc20_ && _loc11_)
         {
            cpoyBitmapData(_loc11_.rect,_loc11_,_loc25_,new Point(_loc18_,0));
            _loc18_ += _loc11_.width;
         }
         if(_loc17_)
         {
            cpoyBitmapData(_loc17_.rect,_loc17_,_loc25_,new Point(_loc20_,0));
         }
         _loc18_ = _loc21_ ? _loc21_.height : 0;
         _loc20_ = _loc8_ - (_loc23_ ? _loc23_.height : 0);
         while(_loc18_ < _loc20_ && _loc7_)
         {
            cpoyBitmapData(_loc7_.rect,_loc7_,_loc25_,new Point(0,_loc18_));
            _loc18_ += _loc7_.height;
         }
         _loc20_ = _loc19_ - (_loc6_ ? _loc6_.width : 0);
         var _loc16_:int = _loc11_ ? _loc11_.height : 0;
         var _loc15_:int = _loc8_ - (_loc22_ ? _loc22_.height : 0);
         while(_loc16_ < _loc15_ && _loc13_)
         {
            _loc18_ = _loc7_ ? _loc7_.width : 0;
            while(_loc18_ < _loc20_ && _loc13_)
            {
               cpoyBitmapData(_loc13_.rect,_loc13_,_loc25_,new Point(_loc18_,_loc16_));
               _loc18_ += _loc13_.width;
            }
            _loc16_ += _loc13_.height;
         }
         _loc20_ = _loc8_ - (_loc24_ ? _loc24_.height : 0);
         _loc18_ = _loc19_ - (_loc6_ ? _loc6_.width : 0);
         _loc16_ = _loc17_ ? _loc17_.height : 0;
         while(_loc16_ < _loc20_ && _loc6_)
         {
            cpoyBitmapData(_loc6_.rect,_loc6_,_loc25_,new Point(_loc18_,_loc16_));
            _loc16_ += _loc6_.height;
         }
         _loc18_ = _loc8_ - (_loc23_ ? _loc23_.height : 0);
         if(_loc23_)
         {
            cpoyBitmapData(_loc23_.rect,_loc23_,_loc25_,new Point(0,_loc18_));
         }
         _loc18_ = _loc23_ ? _loc23_.width : 0;
         _loc20_ = _loc19_ - (_loc24_ ? _loc24_.width : 0);
         _loc16_ = _loc8_ - (_loc22_ ? _loc22_.height : 0);
         while(_loc18_ < _loc20_ && _loc22_)
         {
            cpoyBitmapData(_loc22_.rect,_loc22_,_loc25_,new Point(_loc18_,_loc16_));
            _loc18_ += _loc22_.width;
         }
         if(_loc24_)
         {
            cpoyBitmapData(_loc24_.rect,_loc24_,_loc25_,new Point(_loc20_,_loc16_));
         }
         disposeBitmapData(_loc21_);
         disposeBitmapData(_loc23_);
         disposeBitmapData(_loc17_);
         disposeBitmapData(_loc24_);
         disposeBitmapData(_loc11_);
         disposeBitmapData(_loc7_);
         disposeBitmapData(_loc6_);
         disposeBitmapData(_loc22_);
         disposeBitmapData(_loc13_);
         _loc25_.unlock();
         return _loc25_;
      }
      
      public static function disposeBitmapData(param1:BitmapData) : void
      {
         if(param1)
         {
            param1.dispose();
         }
      }
   }
}

