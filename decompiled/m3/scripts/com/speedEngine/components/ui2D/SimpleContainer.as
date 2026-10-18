package com.speedEngine.components.ui2D
{
   import flash.display.DisplayObject;
   
   public class SimpleContainer extends TinyUI
   {
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
      
      public static const TILED:String = "Tiled";
      
      public var data:*;
      
      private var _layout:String;
      
      private var _childs:Array = [];
      
      private var _isScroll:Boolean = true;
      
      protected var _hCount:int = 1;
      
      protected var _vCount:int = 0;
      
      protected var _hSpace:int = 1;
      
      protected var _vSpace:int = 1;
      
      private var _vWidth:Number = 50;
      
      private var _vHeight:Number = 100;
      
      protected var _isDynamicSpace:Boolean = true;
      
      public function SimpleContainer()
      {
         super();
      }
      
      public function get length() : int
      {
         return _childs.length;
      }
      
      public function set showHeight(param1:Number) : void
      {
         _vHeight = param1;
      }
      
      public function get showHeight() : Number
      {
         return _vHeight;
      }
      
      public function get showWidth() : Number
      {
         return _vWidth;
      }
      
      public function set showWidth(param1:Number) : void
      {
         _vWidth = param1;
      }
      
      public function get isScroll() : Boolean
      {
         return _isScroll;
      }
      
      public function get childs() : Array
      {
         return _childs;
      }
      
      public function get isDynamicSpace() : Boolean
      {
         return _isDynamicSpace;
      }
      
      public function set isDynamicSpace(param1:Boolean) : void
      {
         _isDynamicSpace = param1;
      }
      
      public function get vCount() : int
      {
         return _vCount;
      }
      
      public function set vCount(param1:int) : void
      {
         _vCount = param1;
         updatePos();
      }
      
      public function get hCount() : int
      {
         return _hCount;
      }
      
      public function set hCount(param1:int) : void
      {
         _hCount = param1;
         updatePos();
      }
      
      public function get vSpace() : int
      {
         return _vSpace;
      }
      
      public function set vSpace(param1:int) : void
      {
         _vSpace = param1;
         updatePos();
      }
      
      public function get hSpace() : int
      {
         return _hSpace;
      }
      
      public function set hSpace(param1:int) : void
      {
         _hSpace = param1;
         updatePos();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         if(contains(param1) || _layout == null)
         {
            return super.addChild(param1);
         }
         super.addChild(param1);
         if(_childs == null)
         {
            _childs = [];
         }
         _childs.push(param1);
         setNextPos(param1,_childs.length - 2);
         return param1;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(_childs.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_childs[_loc3_] == param1)
            {
               _childs.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         updatePos(_loc3_);
         super.removeChild(param1);
         return param1;
      }
      
      public function updatePos(param1:int = 0) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(_childs.length);
         _loc3_ = param1;
         while(_loc3_ < _loc2_)
         {
            setNextPos(_childs[_loc3_],_loc3_ - 1);
            _loc3_++;
         }
      }
      
      protected function setNextPos(param1:DisplayObject, param2:int = -1) : void
      {
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         if(param2 >= 0 && _childs.length > 0)
         {
            if(_childs[param2].visible == false)
            {
               _loc4_ = 0;
            }
            else if(_isDynamicSpace)
            {
               _loc4_ = _childs[param2].width + hSpace;
            }
            else
            {
               _loc4_ = hSpace;
            }
            _loc7_ = _childs[param2].x + _loc4_;
            _loc6_ = Number(_childs[param2].y);
            if(hCount > 0)
            {
               _loc3_ = param2 % hCount;
            }
            else
            {
               _loc3_ = param2;
            }
            if(hCount > 0 && _loc3_ + 1 >= hCount)
            {
               if(_childs[param2].visible == false)
               {
                  _loc5_ = 0;
               }
               else if(_isDynamicSpace)
               {
                  _loc5_ = _childs[param2].height + vSpace;
               }
               else
               {
                  _loc5_ = vSpace;
               }
               _loc7_ = 0;
               _loc6_ += _loc5_;
            }
         }
         else
         {
            _loc7_ = 0;
            _loc6_ = 0;
         }
         param1.x = _loc7_;
         param1.y = _loc6_;
      }
      
      override public function removeChildren(param1:int = 0, param2:int = 2147483647) : void
      {
         super.removeChildren(param1,param2);
         var _loc4_:int = int(_childs.length);
         if(_loc4_ - 1 > param2)
         {
            _loc4_ = param2 + 1;
         }
         var _loc3_:int = _loc4_ - param1;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         _childs.splice(param1,_loc3_);
         updatePos();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_isScroll && this.numChildren > 0)
         {
            removeChildren();
         }
         if(_childs)
         {
            _childs.splice(0,_childs.length);
            _childs = null;
         }
      }
      
      public function get layout() : String
      {
         return _layout;
      }
      
      public function set layout(param1:String) : void
      {
         _layout = param1;
      }
   }
}

