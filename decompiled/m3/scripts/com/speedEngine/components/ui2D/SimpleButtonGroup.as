package com.speedEngine.components.ui2D
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class SimpleButtonGroup extends TinyUI
   {
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
      
      public static const TILED:String = "tiled";
      
      private var _btnArr:Vector.<DoubleButton> = new Vector.<DoubleButton>(0);
      
      private var _currentIndex:int = 0;
      
      private var _layout:String = "horizontal";
      
      private var _gap:int = 10;
      
      private var _vGap:int = 0;
      
      private var _row:int = 2;
      
      private var _typicalWidth:int = 0;
      
      private var _typicalHeight:int = 0;
      
      private var _onSelectChangeHandle:Function = null;
      
      private var _allowSelectCount:int = 1;
      
      private var _currentSelectButton:DoubleButton;
      
      public function SimpleButtonGroup()
      {
         super();
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc3_:DoubleButton = param1 as DoubleButton;
         if(_loc3_ == null)
         {
            throw new Error("只能添加DoubleButton孩子");
         }
         _loc3_.onClickCallBack = onSelectChange;
         var _loc4_:int = _btnArr.indexOf(_loc3_);
         if(_loc4_ > -1)
         {
            _btnArr.splice(_loc4_,1);
         }
         _btnArr.splice(param2,0,param1);
         super.addChildAt(param1,param2);
         validate(STYLE);
         return param1;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         return addChildAt(param1,numChildren);
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:int = _btnArr.indexOf(param1 as DoubleButton);
         if(_loc2_ != -1)
         {
            return removeChildAt(_loc2_);
         }
         return null;
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         _btnArr.splice(param1,1);
         reset();
         return super.removeChildAt(param1);
      }
      
      private function onSelectChange(param1:MouseEvent) : void
      {
         var _loc2_:DoubleButton = param1.currentTarget as DoubleButton;
         var _loc3_:Boolean = false;
         if(_allowSelectCount != 1)
         {
            if(_loc2_.isSelected && getSelectCount() > _allowSelectCount)
            {
               _loc2_.isSelected = false;
               return;
            }
         }
         if(_allowSelectCount != 1)
         {
            return;
         }
         _loc3_ = _currentIndex != _btnArr.indexOf(_loc2_);
         _currentIndex = _btnArr.indexOf(_loc2_);
         if(_loc3_)
         {
            if(_onSelectChangeHandle != null)
            {
               _onSelectChangeHandle(_loc2_);
            }
            if(_currentSelectButton)
            {
               _currentSelectButton.isSelected = false;
            }
            _currentSelectButton = _loc2_;
         }
         else
         {
            _loc2_.isSelected = true;
         }
      }
      
      private function getSelectCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _btnArr.length)
         {
            if(_btnArr[_loc2_].isSelected)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_layout == "horizontal")
         {
            _loc2_ = 0;
            while(_loc2_ < _btnArr.length)
            {
               _btnArr[_loc2_].x = _loc1_ + _loc2_ * gap;
               _btnArr[_loc2_].y = 0;
               _btnArr[_loc2_].isSelected = false;
               _loc1_ += _btnArr[_loc2_].width;
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _btnArr.length)
            {
               _btnArr[_loc2_].x = 0;
               _btnArr[_loc2_].y = _loc1_ + _loc2_ * gap;
               _btnArr[_loc2_].isSelected = false;
               _loc1_ += _btnArr[_loc2_].height;
               _loc2_++;
            }
         }
         if(_btnArr.length > 0)
         {
            _currentIndex = 0;
         }
      }
      
      override public function render() : void
      {
         var _loc2_:DoubleButton = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(validateDic[STYLE])
         {
            if(_btnArr == null)
            {
               return;
            }
            _loc5_ = 0;
            _loc4_ = 0;
            _loc6_ = 0;
            while(_loc6_ < _btnArr.length)
            {
               _loc2_ = _btnArr[_loc6_];
               if(_layout == "vertical")
               {
                  _loc2_.y = _loc4_ + (_loc6_ == 0 ? 0 : gap);
                  _loc4_ = _loc2_.y + _loc2_.height;
                  _loc2_.x = 0;
               }
               else if(_layout == "horizontal")
               {
                  _loc2_.x = _loc5_ + (_loc6_ == 0 ? 0 : gap);
                  _loc5_ = _loc2_.x + _loc2_.width;
                  _loc2_.y = 0;
               }
               else if(_layout == "tiled")
               {
                  if(numChildren == 0)
                  {
                     _typicalWidth = _loc2_.width;
                     _typicalHeight = _loc2_.height;
                  }
                  _loc1_ = numChildren % row;
                  _loc3_ = numChildren / row;
                  _loc2_.x = _loc1_ * _typicalWidth + _loc1_ * gap;
                  _loc2_.y = _loc3_ * _typicalHeight + _loc3_ * vGap;
               }
               _loc6_++;
            }
            if(_currentSelectButton)
            {
               _currentSelectButton.isSelected = false;
            }
            if(_btnArr.length > 0)
            {
               _btnArr[_currentIndex].isSelected = true;
               _currentSelectButton = _btnArr[_currentIndex];
            }
         }
      }
      
      override public function dispose() : void
      {
         _btnArr.splice(0,_btnArr.length);
         _onSelectChangeHandle = null;
         super.dispose();
      }
      
      public function get gap() : int
      {
         return _gap;
      }
      
      public function set gap(param1:int) : void
      {
         _gap = param1;
      }
      
      public function get vGap() : int
      {
         return _vGap;
      }
      
      public function set vGap(param1:int) : void
      {
         _vGap = param1;
      }
      
      public function get row() : int
      {
         return _row;
      }
      
      public function set row(param1:int) : void
      {
         _row = param1;
      }
      
      public function get layout() : String
      {
         return _layout;
      }
      
      public function set layout(param1:String) : void
      {
         if(_layout == param1)
         {
            return;
         }
         _layout = param1;
         reset();
      }
      
      public function get onSelectChangeHandle() : Function
      {
         return _onSelectChangeHandle;
      }
      
      public function set onSelectChangeHandle(param1:Function) : void
      {
         _onSelectChangeHandle = param1;
      }
      
      public function get currentIndex() : int
      {
         return _currentIndex;
      }
      
      public function set currentIndex(param1:int) : void
      {
         if(_currentIndex == param1)
         {
            return;
         }
         _currentIndex = param1;
         validate(STYLE);
      }
      
      public function get allowSelectCount() : int
      {
         return _allowSelectCount;
      }
      
      public function set allowSelectCount(param1:int) : void
      {
         _allowSelectCount = param1;
      }
      
      public function get currentSelectButton() : DoubleButton
      {
         if(_currentSelectButton)
         {
            return _currentSelectButton;
         }
         return btnArr[_currentIndex];
      }
      
      public function set currentSelectButton(param1:DoubleButton) : void
      {
         _currentSelectButton = param1;
      }
      
      public function get btnArr() : Vector.<DoubleButton>
      {
         return _btnArr;
      }
   }
}

