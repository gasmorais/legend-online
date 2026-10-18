package com.pickgliss.utils
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public final class DisplayUtils
   {
      
      private static var _grayFilter:ColorMatrixFilter;
      
      public function DisplayUtils()
      {
         super();
      }
      
      public static function drawRectShape(param1:Number, param2:Number, param3:Shape = null) : Shape
      {
         var _loc4_:Shape = null;
         if(param3 == null)
         {
            _loc4_ = new Shape();
         }
         else
         {
            _loc4_ = param3;
         }
         _loc4_.graphics.clear();
         _loc4_.graphics.beginFill(16711680,1);
         _loc4_.graphics.drawRect(0,0,param1,param2);
         _loc4_.graphics.endFill();
         return _loc4_;
      }
      
      public static function drawTextShape(param1:TextField) : DisplayObject
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
         return _loc6_;
      }
      
      public static function isInTheStage(param1:Point, param2:DisplayObjectContainer = null) : Boolean
      {
         var _loc3_:Point = param1;
         if(param2)
         {
            _loc3_ = param2.localToGlobal(param1);
         }
         if(_loc3_.x < 0 || _loc3_.y < 0 || _loc3_.x > StageReferance.stageWidth || _loc3_.y > StageReferance.stageHeight)
         {
            return false;
         }
         return true;
      }
      
      public static function layoutDisplayWithInnerRect(param1:DisplayObject, param2:InnerRectangle, param3:int, param4:int) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param1 is Component)
         {
            Component(param1).beginChanges();
         }
         var _loc5_:Rectangle = param2.getInnerRect(param3,param4);
         param1.x = _loc5_.x;
         param1.y = _loc5_.y;
         if(_loc5_.width != 0)
         {
            param1.width = _loc5_.width;
         }
         if(_loc5_.height != 0)
         {
            param1.height = _loc5_.height;
         }
         if(param1 is Component)
         {
            Component(param1).commitChanges();
         }
      }
      
      public static function fullInRect(param1:DisplayObject, param2:Rectangle, param3:Boolean = true) : Rectangle
      {
         var _loc5_:Number = NaN;
         var _loc4_:Rectangle = new Rectangle();
         if(param1.width / param2.width > param1.height / param2.height)
         {
            _loc5_ = param2.height / param1.height;
         }
         else
         {
            _loc5_ = param2.width / param1.width;
         }
         if(!param3 && _loc5_ < 1)
         {
            _loc4_ = new Rectangle(param2.x,param2.y,param1.width,param1.height);
         }
         else
         {
            _loc4_ = new Rectangle(param2.x,param2.y,param1.width * _loc5_,param1.height * _loc5_);
         }
         param1.x = _loc4_.x;
         param1.y = _loc4_.y;
         param1.width = _loc4_.width;
         param1.height = _loc4_.height;
         return _loc4_;
      }
      
      public static function setFrame(param1:DisplayObject, param2:int) : void
      {
         if(param1 is Image)
         {
            Image(param1).setFrame(param2);
         }
         else if(param1 is MovieClip)
         {
            MovieClip(param1).gotoAndStop(param2);
         }
         else if(param1 is FilterFrameText)
         {
            FilterFrameText(param1).setFrame(param2);
         }
      }
      
      public static function setDisplayObjectNotEnable(param1:DisplayObject) : void
      {
         if(param1 is InteractiveObject)
         {
            InteractiveObject(param1).mouseEnabled = false;
         }
         if(param1 is DisplayObjectContainer)
         {
            DisplayObjectContainer(param1).mouseChildren = false;
            DisplayObjectContainer(param1).mouseEnabled = false;
         }
      }
      
      public static function getTextFieldLineHeight(param1:TextField) : int
      {
         return param1.getLineMetrics(0).height;
      }
      
      public static function getTextFieldCareLinePosY(param1:TextField) : Number
      {
         var _loc5_:int = param1.caretIndex - 1;
         var _loc3_:int = param1.text.charCodeAt(_loc5_);
         var _loc2_:int = param1.getLineIndexOfChar(_loc5_);
         var _loc4_:int = 0;
         if(_loc3_ == 13)
         {
            _loc4_ = _loc2_ + 1;
         }
         else
         {
            _loc4_ = _loc2_;
         }
         return getTextFieldLineHeight(param1) * _loc4_;
      }
      
      public static function getTextFieldCareLinePosX(param1:TextField) : Number
      {
         var _loc3_:int = param1.caretIndex - 1;
         var _loc2_:Rectangle = param1.getCharBoundaries(_loc3_);
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_.x + _loc2_.width;
      }
      
      public static function getVisibleSize(param1:DisplayObject) : Rectangle
      {
         var _loc3_:Rectangle = null;
         var _loc5_:int = 2000;
         var _loc2_:BitmapData = new BitmapData(_loc5_,_loc5_,true,0);
         _loc2_.draw(param1);
         _loc3_ = _loc2_.getColorBoundsRect(4278190080,0,false);
         _loc2_.dispose();
         return new Rectangle(_loc3_.x,_loc3_.y,_loc3_.x + _loc3_.width,_loc3_.y + _loc3_.height);
      }
      
      public static function getTextFieldMaxLineWidth(param1:String, param2:TextFormat, param3:Boolean) : Number
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:TextField = new TextField();
         _loc6_.autoSize = "left";
         if(param3)
         {
            param1 = param1.replace("<BR>","\n");
            param1 = param1.replace("<Br>","\n");
            param1 = param1.replace("<bR>","\n");
            param1 = param1.replace("<br>","\n");
         }
         _loc4_ = param1.split("\n");
         var _loc7_:Number = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(param3)
            {
               _loc6_.htmlText = _loc4_[_loc5_];
            }
            else
            {
               _loc6_.text = _loc4_[_loc5_];
               _loc6_.setTextFormat(param2);
            }
            _loc7_ = Math.max(_loc7_,_loc6_.width);
            if(_loc7_ > 800)
            {
               _loc7_ = 800;
            }
            _loc5_++;
         }
         return _loc7_ + 2;
      }
      
      public static function isTargetOrContain(param1:DisplayObject, param2:DisplayObject) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1 == param2)
         {
            return true;
         }
         if(param2 is DisplayObjectContainer)
         {
            return DisplayObjectContainer(param2).contains(param1);
         }
         return false;
      }
      
      public static function getPointFromObject(param1:Point, param2:DisplayObject, param3:DisplayObject) : Point
      {
         param1 = param2.localToGlobal(param1);
         return param3.globalToLocal(param1);
      }
      
      public static function getHitArea(param1:BitmapData, param2:uint = 2) : Sprite
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:Sprite = new Sprite();
         _loc5_.graphics.beginFill(0,0);
         _loc3_ = 0;
         while(_loc3_ < param1.width)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.height)
            {
               if(param1.getPixel32(_loc3_,_loc4_))
               {
                  _loc5_.graphics.drawRect(_loc3_,_loc4_,param2,param2);
               }
               _loc4_ += param2;
            }
            _loc3_ += param2;
         }
         _loc5_.graphics.endFill();
         return _loc5_;
      }
      
      public static function get grayFilter() : ColorMatrixFilter
      {
         if(!_grayFilter)
         {
            _grayFilter = new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]);
         }
         return _grayFilter;
      }
      
      public static function handleDisplay(param1:Boolean, ... rest) : void
      {
         for each(var _loc3_:DisplayObject in rest)
         {
            if(_loc3_)
            {
               _loc3_.visible = param1;
            }
         }
      }
   }
}

