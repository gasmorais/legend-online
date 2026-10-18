package com.speedEngine.components.ui2D
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class SimpleTab extends TinyUI
   {
      
      private var _tabButtons:Vector.<DoubleButton> = new Vector.<DoubleButton>(0);
      
      private var _containers:Vector.<TinyUI> = new Vector.<TinyUI>(0);
      
      private var _selecttView:TinyUI;
      
      private var _selectButton:DoubleButton;
      
      private var _align:String = "top";
      
      private var _gap:int = 5;
      
      private var _viewGap:int = 0;
      
      private var _mIndex:int = 0;
      
      private var _viewWidth:int = 0;
      
      private var _viewHeight:int = 0;
      
      private var _buttonX:int = 0;
      
      private var _buttonY:int = 0;
      
      private var _containerX:int = 0;
      
      private var _containerY:int = 0;
      
      protected var _buttonWidth:int;
      
      protected var _buttonHeight:int;
      
      private var _changeCallBack:Function;
      
      public function SimpleTab()
      {
         super();
      }
      
      override public function __onAfterProp() : void
      {
         super.__onAfterProp();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeChildren();
         _tabButtons.splice(0,_tabButtons.length);
         _containers.splice(0,_containers.length);
         _changeCallBack = null;
      }
      
      override public function render() : void
      {
         super.render();
         if(validateDic[STYLE])
         {
            layout();
            index = _mIndex;
         }
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         if(param1 is DoubleButton)
         {
            _tabButtons.push(param1);
            (param1 as DoubleButton).onClickCallBack = actionFunction;
         }
         else
         {
            if(!(param1 is TinyUI))
            {
               return null;
            }
            _containers.push(param1);
            param1.visible = false;
         }
         super.addChild(param1);
         validate(STYLE);
         return param1;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         super.removeChild(param1);
         var _loc2_:int = -1;
         if(param1 is DoubleButton)
         {
            _loc2_ = _tabButtons.indexOf(param1 as DoubleButton);
            _tabButtons.splice(_loc2_,1);
         }
         else
         {
            if(!(param1 is TinyUI))
            {
               return null;
            }
            _loc2_ = _containers.indexOf(param1 as DoubleButton);
            _containers.splice(_loc2_,1);
         }
         validate(STYLE);
         return param1;
      }
      
      private function actionFunction(param1:Event) : void
      {
         var _loc2_:DoubleButton = param1.currentTarget as DoubleButton;
         var _loc3_:int = _tabButtons.indexOf(_loc2_);
         index = _loc3_;
      }
      
      private function layout() : void
      {
         var _loc7_:DoubleButton = null;
         var _loc4_:TinyUI = null;
         var _loc9_:int = 0;
         var _loc5_:int = _buttonX;
         var _loc6_:int = _buttonY;
         var _loc8_:int = _containerX;
         var _loc10_:int = _containerY;
         var _loc1_:int = int(_tabButtons.length);
         var _loc3_:int = _loc5_;
         var _loc2_:int = _loc6_;
         _loc9_ = 0;
         while(_loc9_ < _loc1_)
         {
            _loc7_ = _tabButtons[_loc9_];
            _loc4_ = _containers[_loc9_];
            _buttonWidth = _buttonWidth > _loc7_.width ? _buttonWidth : _loc7_.width;
            _buttonHeight = _buttonHeight > _loc7_.height ? _buttonHeight : _loc7_.height;
            _loc9_++;
         }
         switch(_align)
         {
            case "top":
               _loc10_ += _buttonHeight + _viewGap;
               break;
            case "left":
               _loc8_ += _buttonWidth + _viewGap;
               break;
            case "right":
               _loc5_ += viewWidth;
               break;
            case "bottom":
               _loc6_ += viewHeight;
         }
         _loc3_ = _loc5_;
         _loc2_ = _loc6_;
         _loc9_ = 0;
         while(_loc9_ < _loc1_)
         {
            _loc7_ = _tabButtons[_loc9_];
            _loc4_ = _containers[_loc9_];
            _loc7_.x = _loc3_;
            _loc7_.y = _loc2_;
            _loc4_.x = _loc8_;
            _loc4_.y = _loc10_;
            if(_align == "top" || _align == "bottom")
            {
               _loc3_ += _loc7_.width + _gap;
               _loc7_.y = _loc6_;
            }
            else
            {
               _loc2_ += _loc7_.height + _gap;
               _loc7_.x = _loc5_;
            }
            _loc9_++;
         }
      }
      
      public function get index() : int
      {
         return _mIndex;
      }
      
      public function set index(param1:int) : void
      {
         if(param1 > -1 && _mIndex < _tabButtons.length)
         {
            if(index == param1 && _selectButton)
            {
               _selectButton.isSelected = true;
               return;
            }
            _mIndex = param1;
            if(_selecttView)
            {
               _selecttView.visible = false;
               _selectButton.isSelected = false;
            }
            _selectButton = _tabButtons[_mIndex];
            _selecttView = _containers[_mIndex];
            _selectButton.isSelected = true;
            _selecttView.visible = true;
            if(_changeCallBack != null)
            {
               _changeCallBack.call(null,_mIndex);
            }
         }
      }
      
      public function get align() : String
      {
         return _align;
      }
      
      public function set align(param1:String) : void
      {
         _align = param1;
      }
      
      public function get gap() : int
      {
         return _gap;
      }
      
      public function set gap(param1:int) : void
      {
         _gap = param1;
      }
      
      public function get viewGap() : int
      {
         return _viewGap;
      }
      
      public function set viewGap(param1:int) : void
      {
         _viewGap = param1;
      }
      
      public function get selecttView() : TinyUI
      {
         return _selecttView;
      }
      
      public function get selectButton() : DoubleButton
      {
         return _selectButton;
      }
      
      public function get tabButtons() : Vector.<DoubleButton>
      {
         return _tabButtons;
      }
      
      public function get containers() : Vector.<TinyUI>
      {
         return _containers;
      }
      
      public function get viewWidth() : int
      {
         return _viewWidth;
      }
      
      public function set viewWidth(param1:int) : void
      {
         _viewWidth = param1;
      }
      
      public function get viewHeight() : int
      {
         return _viewHeight;
      }
      
      public function set viewHeight(param1:int) : void
      {
         _viewHeight = param1;
      }
      
      public function get buttonX() : int
      {
         return _buttonX;
      }
      
      public function set buttonX(param1:int) : void
      {
         _buttonX = param1;
      }
      
      public function get buttonY() : int
      {
         return _buttonY;
      }
      
      public function set buttonY(param1:int) : void
      {
         _buttonY = param1;
      }
      
      public function get containerX() : int
      {
         return _containerX;
      }
      
      public function set containerX(param1:int) : void
      {
         _containerX = param1;
      }
      
      public function get containerY() : int
      {
         return _containerY;
      }
      
      public function set containerY(param1:int) : void
      {
         _containerY = param1;
      }
      
      public function get changeCallBack() : Function
      {
         return _changeCallBack;
      }
      
      public function set changeCallBack(param1:Function) : void
      {
         _changeCallBack = param1;
      }
   }
}

