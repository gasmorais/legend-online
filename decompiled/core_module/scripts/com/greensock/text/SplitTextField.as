package com.greensock.text
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   
   public class SplitTextField extends Sprite
   {
      
      public static const version:Number = 0.62;
      
      public static const TYPE_CHARACTERS:String = "characters";
      
      public static const TYPE_WORDS:String = "words";
      
      public static const TYPE_LINES:String = "lines";
      
      private static const _propNames:Array = ["embedFonts","alpha","antiAliasType","blendMode","filters","focusRect","gridFitType","mouseEnabled","sharpness","selectable","textColor","thickness"];
      
      private var _splitType:String;
      
      private var _regOffsetX:Number;
      
      private var _regOffsetY:Number;
      
      private var _source:TextField;
      
      public var textFields:Array;
      
      public function SplitTextField(param1:TextField = null, param2:String = "characters", param3:Number = 0, param4:Number = 0)
      {
         super();
         _source = param1;
         _splitType = param2;
         _regOffsetX = param3;
         _regOffsetY = param4;
         this.mouseChildren = false;
         this.textFields = [];
         if(param1)
         {
            update();
         }
      }
      
      public static function split(param1:TextField, param2:String = "characters", param3:DisplayObjectContainer = null, param4:Point = null) : Array
      {
         var _loc16_:Array = null;
         var _loc18_:TextField = null;
         var _loc20_:Number = NaN;
         var _loc7_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:int = 0;
         var _loc14_:* = 0;
         var _loc22_:String = null;
         var _loc8_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:TextLineMetrics = null;
         var _loc15_:Number = NaN;
         var _loc10_:TextFormat = null;
         if(param3 == null)
         {
            param3 = param1.parent;
         }
         if(param4 == null)
         {
            param4 = new Point(0,0);
         }
         var _loc11_:uint = uint(param1.parent == param3 ? param1.parent.getChildIndex(param1) : param3.numChildren);
         var _loc9_:uint = 0;
         var _loc17_:uint = uint(param1.numLines);
         var _loc19_:Rectangle = param1.getBounds(param1);
         var _loc21_:Number = _loc19_.y + param4.y;
         var _loc23_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc17_)
         {
            _loc22_ = param1.getLineText(_loc7_);
            _loc5_ = uint(param1.getLineOffset(_loc7_));
            _loc6_ = param1.getLineMetrics(_loc7_);
            if(param1.text.length > _loc5_)
            {
               _loc10_ = param1.getTextFormat(_loc5_,_loc5_ + 1);
               if(_loc10_.align == "left")
               {
                  _loc20_ = _loc19_.x + param4.x;
               }
               else if(_loc10_.align == "center")
               {
                  _loc20_ = _loc19_.x + param4.x - 2 + (param1.width - _loc6_.width) * 0.5;
               }
               else
               {
                  _loc20_ = _loc19_.x + param4.x - 4 + (param1.width - _loc6_.width);
               }
               if(param2 == "characters")
               {
                  _loc16_ = _loc22_.split("");
               }
               else if(param2 == "words")
               {
                  _loc16_ = _loc22_.split(" ").join("~#$ ~#$").split("~#$");
               }
               else
               {
                  _loc16_ = [_loc22_];
               }
               _loc8_ = _loc16_.length;
               _loc12_ = 0;
               while(_loc12_ < _loc8_)
               {
                  if(_loc16_[_loc12_].length != 0)
                  {
                     _loc18_ = new TextField();
                     _loc13_ = int(_propNames.length);
                     while(_loc13_--)
                     {
                        _loc18_[_propNames[_loc13_]] = param1[_propNames[_loc13_]];
                     }
                     _loc18_.autoSize = "left";
                     _loc18_.selectable = _loc18_.multiline = _loc18_.wordWrap = false;
                     _loc18_.text = _loc16_[_loc12_];
                     _loc14_ = uint(_loc16_[_loc12_].length);
                     _loc13_ = 0;
                     while(_loc13_ < _loc14_)
                     {
                        _loc10_ = param1.getTextFormat(_loc5_,_loc5_ + 1);
                        _loc5_ += 1;
                        _loc10_.align = "left";
                        _loc10_.leading = 0;
                        _loc18_.setTextFormat(_loc10_,_loc13_,_loc13_ + 1);
                        _loc13_++;
                     }
                     _loc18_.x = _loc20_;
                     _loc18_.y = _loc21_;
                     _loc15_ = _loc6_.ascent - _loc18_.getLineMetrics(0).ascent;
                     if(_loc15_)
                     {
                        _loc18_.y += _loc15_;
                     }
                     _loc20_ += _loc18_.textWidth;
                     if(_loc16_[_loc12_] != " " || _loc10_.underline)
                     {
                        _loc23_[_loc9_++] = _loc18_;
                     }
                  }
                  _loc12_++;
               }
               _loc21_ += _loc6_.height;
            }
            _loc7_++;
         }
         _loc12_ = _loc23_.length;
         while(_loc12_--)
         {
            param3.addChildAt(TextField(_loc23_[_loc12_]),_loc11_);
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         return _loc23_;
      }
      
      public function activate() : void
      {
         this.activated = true;
      }
      
      public function deactivate() : void
      {
         this.activated = false;
      }
      
      public function destroy() : void
      {
         this.activated = false;
         clear();
         _source = null;
      }
      
      private function update() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         var _loc3_:Point = null;
         clear();
         if(_source.parent)
         {
            _loc1_ = _source.parent;
            _loc1_.addChildAt(this,_loc1_.getChildIndex(_source));
            _loc1_.removeChild(_source);
         }
         var _loc2_:Matrix = _source.transform.matrix;
         if(_regOffsetX != 0 || _regOffsetY != 0)
         {
            _loc3_ = _loc2_.transformPoint(new Point(_regOffsetX,_regOffsetY));
            _loc2_.tx = _loc3_.x;
            _loc2_.ty = _loc3_.y;
         }
         this.transform.matrix = _loc2_;
         this.textFields = split(_source,_splitType,this,new Point(-_regOffsetX,-_regOffsetY));
      }
      
      private function clear() : void
      {
         var _loc1_:int = int(this.textFields.length);
         while(_loc1_--)
         {
            this.removeChild(this.textFields[_loc1_]);
         }
         this.textFields = [];
      }
      
      public function get source() : TextField
      {
         return _source;
      }
      
      public function set source(param1:TextField) : void
      {
         _source = param1;
         update();
      }
      
      public function get splitType() : String
      {
         return _splitType;
      }
      
      public function set splitType(param1:String) : void
      {
         _splitType = param1;
         update();
      }
      
      public function get regOffsetX() : Number
      {
         return _regOffsetX;
      }
      
      public function set regOffsetX(param1:Number) : void
      {
         _regOffsetX = param1;
         update();
      }
      
      public function get regOffsetY() : Number
      {
         return _regOffsetY;
      }
      
      public function set regOffsetY(param1:Number) : void
      {
         _regOffsetY = param1;
         update();
      }
      
      public function get activated() : Boolean
      {
         return this.parent != null;
      }
      
      public function set activated(param1:Boolean) : void
      {
         if(_source == null)
         {
            return;
         }
         if(_source.parent && param1)
         {
            _source.parent.addChildAt(this,_source.parent.getChildIndex(_source));
            _source.parent.removeChild(_source);
         }
         else if(this.parent && !param1)
         {
            this.parent.addChildAt(_source,this.parent.getChildIndex(this));
            this.parent.removeChild(this);
         }
      }
   }
}

