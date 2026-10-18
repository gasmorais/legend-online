package com.pickgliss.ui.controls.container
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SimpleTileList extends BoxContainer
   {
      
      public static const LIST_ITEM_CLICK:String = "LIST_ITEM_CLICK";
      
      public static const ALIGN_LEFT:String = "align_left";
      
      public static const ALIGN_RIGHT:String = "align_right";
      
      public var startPos:Point = new Point(0,0);
      
      private var _align:String;
      
      protected var _column:int;
      
      protected var _hSpace:Number;
      
      protected var _rowNum:int;
      
      protected var _vSpace:Number;
      
      private var _selectedIndex:int = -1;
      
      private var _selectedItem:DisplayObject;
      
      public function SimpleTileList(param1:int = 1, param2:String = "align_left")
      {
         super();
         _column = param1;
         _align = param2;
      }
      
      public function get align() : String
      {
         return _align;
      }
      
      public function set align(param1:String) : void
      {
         _align = param1;
      }
      
      public function set column(param1:int) : void
      {
         _column = param1;
         refreshChildPos();
      }
      
      public function get selectedItem() : DisplayObject
      {
         return _selectedItem;
      }
      
      public function get selectedIndex() : int
      {
         return _selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(_selectedIndex == param1)
         {
            return;
         }
         _selectedIndex = param1;
         _selectedItem = getChildAt(_selectedIndex);
      }
      
      public function get hSpace() : Number
      {
         return _hSpace;
      }
      
      public function set hSpace(param1:Number) : void
      {
         _hSpace = param1;
         onProppertiesUpdate();
      }
      
      public function get vSpace() : Number
      {
         return _vSpace;
      }
      
      public function set vSpace(param1:Number) : void
      {
         _vSpace = param1;
         onProppertiesUpdate();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         param1.addEventListener("click",__itemClick);
         super.addChild(param1);
         return param1;
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         if(_loc2_.parent === this)
         {
            _selectedIndex = getChildIndex(_loc2_);
            _selectedItem = _loc2_;
            dispatchEvent(new Event("LIST_ITEM_CLICK"));
         }
         else
         {
            _selectedIndex = -1;
            _selectedItem = null;
         }
      }
      
      public function resetArrange() : void
      {
         arrange();
      }
      
      override protected function arrange() : void
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:DisplayObject = null;
         caculateRows();
         var _loc9_:int = 0;
         var _loc1_:int = startPos.x;
         var _loc2_:int = startPos.y;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         _loc7_ = 0;
         loop0:
         while(_loc7_ < _rowNum)
         {
            _loc4_ = 0;
            _loc8_ = 0;
            while(true)
            {
               if(_loc8_ >= _column)
               {
                  _loc1_ = startPos.x;
                  _loc2_ += _loc4_ + _vSpace;
                  _loc7_++;
                  continue loop0;
               }
               _loc5_ = getChildAt(_loc9_++);
               if(_align == "align_left")
               {
                  _loc5_.x = _loc1_;
               }
               else if(_align == "align_right")
               {
                  _loc5_.x = width - _loc1_ - ObjectUtils.getObjectHeight(_loc5_);
               }
               _loc5_.y = _loc2_;
               _loc6_ = Math.max(_loc6_,_loc1_ + ObjectUtils.getObjectWidth(_loc5_));
               _loc3_ = Math.max(_loc3_,_loc2_ + ObjectUtils.getObjectHeight(_loc5_));
               _loc1_ += ObjectUtils.getObjectWidth(_loc5_) + _hSpace;
               if(_loc4_ < ObjectUtils.getObjectHeight(_loc5_))
               {
                  _loc4_ = ObjectUtils.getObjectHeight(_loc5_);
               }
               if(_loc9_ >= numChildren)
               {
                  break;
               }
               _loc8_++;
            }
            changeSize(_loc6_,_loc3_);
            return;
         }
         changeSize(_loc6_,_loc3_);
         dispatchEvent(new Event("resize"));
      }
      
      private function changeSize(param1:int, param2:int) : void
      {
         if(param1 != _width || param2 != _height)
         {
            width = param1;
            height = param2;
         }
      }
      
      private function caculateRows() : void
      {
         _rowNum = Math.ceil(numChildren / _column);
      }
      
      public function get rowNum() : int
      {
         return _rowNum;
      }
      
      public function get column() : int
      {
         return _column;
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         _loc2_ = 0;
         while(_loc2_ < numChildren)
         {
            _loc1_ = getChildAt(_loc2_) as DisplayObject;
            _loc1_.removeEventListener("click",__itemClick);
            _loc2_++;
         }
         super.dispose();
      }
   }
}

