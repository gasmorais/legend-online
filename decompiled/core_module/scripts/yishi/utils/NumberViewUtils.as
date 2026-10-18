package yishi.utils
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class NumberViewUtils
   {
      
      private static const sharedRect:Rectangle = new Rectangle();
      
      private static const sharedPt:Point = new Point();
      
      public function NumberViewUtils()
      {
         super();
      }
      
      public static function printNumber(param1:int, param2:Sprite, param3:BitmapData, param4:String = "0123456789.", param5:int = 0, param6:int = 0) : void
      {
         var _loc9_:int = 0;
         var _loc20_:BitmapData = null;
         var _loc19_:String = null;
         var _loc10_:int = 0;
         var _loc12_:BitmapData = null;
         var _loc16_:Rectangle = null;
         var _loc18_:Rectangle = null;
         var _loc8_:Bitmap = null;
         ObjectUtils.disposeAllChildren(param2);
         var _loc15_:String = param1.toString();
         var _loc13_:int = param3.width / param4.length;
         var _loc11_:int = param3.height;
         var _loc14_:Rectangle = new Rectangle(0,0,_loc13_,_loc11_);
         var _loc17_:int = 0;
         if(param6 == 1)
         {
            _loc17_ = -((_loc15_.length - 1) * (_loc13_ + param5) + _loc13_) >> 1;
         }
         else if(param6 == 2)
         {
            _loc17_ = -((_loc15_.length - 1) * (_loc13_ + param5) + _loc13_);
         }
         var _loc7_:Point = new Point();
         var _loc21_:Dictionary = new Dictionary(true);
         _loc9_ = 0;
         while(_loc9_ < _loc15_.length)
         {
            _loc19_ = _loc15_.charAt(_loc9_);
            if(_loc19_ in _loc21_)
            {
               _loc20_ = _loc21_[_loc19_] as BitmapData;
            }
            else
            {
               _loc10_ = param4.indexOf(_loc19_);
               _loc14_.x = _loc10_ * _loc14_.width;
               _loc12_ = new BitmapData(_loc14_.width,_loc14_.height,true,0);
               _loc12_.copyPixels(param3,_loc14_,_loc7_);
               _loc16_ = _loc12_.getColorBoundsRect(4278190080,0,false);
               _loc18_ = new Rectangle(_loc16_.x,0,_loc16_.width,_loc11_);
               _loc20_ = new BitmapData(_loc16_.width,_loc11_,true,0);
               _loc20_.copyPixels(_loc12_,_loc18_,_loc7_);
               _loc21_[_loc19_] = _loc20_;
               _loc12_.dispose();
            }
            _loc8_ = new Bitmap(_loc20_);
            _loc8_.x = _loc17_;
            _loc17_ = _loc17_ + param5 + _loc13_;
            param2.addChild(_loc8_);
            _loc9_++;
         }
         ObjectUtils.clearDictionary(_loc21_);
      }
      
      public static function refreshBitmap(param1:String, param2:BitmapData, param3:Number, param4:Number, param5:int, param6:int, param7:String, param8:Bitmap) : DisplayObject
      {
         var _loc12_:Boolean = false;
         var _loc16_:BitmapData = null;
         var _loc13_:Rectangle = null;
         var _loc10_:int = 0;
         var _loc17_:String = null;
         var _loc11_:int = 0;
         sharedRect.setTo(0,0,param3,param4);
         sharedPt.setTo(0,0);
         var _loc9_:int = param1.length;
         var _loc14_:int = param3;
         var _loc15_:int = param4;
         _loc14_ = (_loc9_ - 1) * param5 + param3;
         if(param8.width != _loc14_ || param8.bitmapData == null)
         {
            _loc12_ = true;
         }
         if(_loc12_)
         {
            ObjectUtils.disposeObject(param8.bitmapData);
            _loc16_ = new BitmapData(_loc14_,_loc15_,true,0);
         }
         else
         {
            _loc16_ = param8.bitmapData;
            _loc13_ = new Rectangle(0,0,_loc16_.width,_loc16_.height);
            _loc16_.fillRect(_loc13_,0);
         }
         _loc16_.lock();
         _loc10_ = 0;
         while(_loc10_ < _loc9_)
         {
            _loc17_ = param1.charAt(_loc10_);
            _loc11_ = param7.indexOf(_loc17_);
            sharedRect.x = _loc11_ * param6;
            _loc16_.copyPixels(param2,sharedRect,sharedPt,null,null,true);
            sharedPt.x += param5;
            _loc10_++;
         }
         _loc16_.unlock();
         param8.bitmapData = _loc16_;
         return param8;
      }
      
      public static function refreshValueY(param1:String, param2:Sprite, param3:BitmapData, param4:Number = 30, param5:Number = 36, param6:int = 25, param7:int = 36, param8:String = "0123456789.") : void
      {
         var _loc10_:int = 0;
         var _loc13_:String = null;
         var _loc11_:int = 0;
         var _loc12_:Bitmap = null;
         removeTimeView(param2);
         var _loc9_:Component = new Component();
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            _loc13_ = param1.substr(_loc10_,1);
            _loc11_ = param8.indexOf(_loc13_);
            _loc12_ = getBit(param3,param4,param5,0,_loc11_ * param7);
            _loc12_.y = _loc10_ * param6;
            _loc9_.addChild(_loc12_);
            _loc10_++;
         }
         param2.addChild(_loc9_);
         if(Number(param1) < 0)
         {
            removeTimeView(param2);
         }
      }
      
      public static function getNumberBitMap(param1:int, param2:BitmapData, param3:Number = 30, param4:Number = 36, param5:int = 36, param6:String = "0123456789.") : Bitmap
      {
         var _loc7_:String = String(param1);
         var _loc8_:int = param6.indexOf(_loc7_);
         return getBit(param2,param3,param4,0,_loc8_ * param5);
      }
      
      public static function refreshValue(param1:Number, param2:Sprite, param3:BitmapData, param4:Number = 30, param5:Number = 36, param6:int = 25, param7:int = 30, param8:String = "0123456789.", param9:Boolean = false) : void
      {
         var _loc11_:int = 0;
         var _loc15_:String = null;
         var _loc12_:int = 0;
         var _loc13_:Bitmap = null;
         removeTimeView(param2);
         var _loc14_:String = String(param1);
         if(param9)
         {
            if(param1 < 10 && param1 >= 0)
            {
               _loc14_ = "0" + _loc14_;
            }
         }
         var _loc10_:Component = new Component();
         _loc11_ = 0;
         while(_loc11_ < _loc14_.length)
         {
            _loc15_ = _loc14_.substr(_loc11_,1);
            _loc12_ = param8.indexOf(_loc15_);
            _loc13_ = getBit(param3,param4,param5,_loc12_ * param7,0);
            _loc13_.smoothing = true;
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
      
      public static function getNumberView(param1:Number, param2:Sprite, param3:BitmapData, param4:Number = 30, param5:Number = 36, param6:int = 25, param7:int = 30, param8:String = "0123456789.", param9:int = 2) : void
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
         var _loc10_:Component = new Component();
         _loc10_.beginChanges();
         _loc11_ = 0;
         while(_loc11_ < _loc14_.length)
         {
            _loc15_ = _loc14_.substr(_loc11_,1);
            _loc12_ = param8.indexOf(_loc15_);
            _loc13_ = getBit(param3,param4,param5,_loc12_ * param7,0);
            _loc13_.smoothing = true;
            _loc13_.x = _loc11_ * param6;
            _loc10_.addChild(_loc13_);
            _loc11_++;
         }
         _loc10_.commitChanges();
         param2.addChild(_loc10_);
         if(param1 < 0)
         {
            removeTimeView(param2);
         }
      }
      
      private static function removeTimeView(param1:Sprite) : void
      {
         ObjectUtils.removeChildAllChildren(param1);
      }
      
      public static function refreshTimeValue(param1:String, param2:Sprite, param3:BitmapData, param4:Number = 30, param5:Number = 36, param6:int = 25, param7:int = 30, param8:String = "0123456789.") : void
      {
         var _loc10_:int = 0;
         var _loc13_:String = null;
         var _loc11_:int = 0;
         var _loc12_:Bitmap = null;
         removeTimeView(param2);
         var _loc9_:Component = new Component();
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            _loc13_ = param1.substr(_loc10_,1);
            _loc11_ = param8.indexOf(_loc13_);
            _loc12_ = getBit(param3,param4,param5,_loc11_ * param7,0);
            _loc12_.x = _loc10_ * param6;
            _loc9_.addChild(_loc12_);
            _loc10_++;
         }
         param2.addChild(_loc9_);
      }
      
      private static function getBit(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : Bitmap
      {
         var _loc8_:Bitmap = new Bitmap(new BitmapData(param2,param3,true,0));
         var _loc6_:Rectangle = new Rectangle(param4,param5,param2,param3);
         var _loc7_:Point = new Point(0,0);
         _loc8_.bitmapData.copyPixels(param1,_loc6_,_loc7_,null,null,true);
         return _loc8_;
      }
      
      public static function refreshAddStrValue(param1:Number, param2:Sprite, param3:BitmapData, param4:Number = 30, param5:Number = 36, param6:int = 25, param7:int = 30, param8:String = "0123456789.", param9:Bitmap = null) : void
      {
         var _loc11_:int = 0;
         var _loc15_:String = null;
         var _loc12_:int = 0;
         var _loc13_:Bitmap = null;
         removeTimeView(param2);
         var _loc14_:String = String(int(param1));
         var _loc10_:Component = new Component();
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
         if(param9)
         {
            param9.x = _loc10_.displayWidth;
            param2.addChild(param9);
         }
         if(param1 < 0)
         {
            removeTimeView(param2);
         }
      }
      
      public static function randomAtoB(param1:int, param2:int) : int
      {
         return Math.random() * (param2 - param1) + param1;
      }
   }
}

