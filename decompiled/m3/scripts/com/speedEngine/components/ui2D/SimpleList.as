package com.speedEngine.components.ui2D
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class SimpleList extends TinyUI
   {
      
      public static const SCROLLVALUE:String = "scrollvalue";
      
      public static const WIDTHHEIGHTCHANGE:String = "widthheightchange";
      
      protected var _childs:Array = [];
      
      private var _isScroll:Boolean = true;
      
      private var _vscrollBar:NewScrollBar;
      
      protected var _hCount:int = 1;
      
      protected var _vCount:int = 0;
      
      protected var _hSpace:int = 1;
      
      protected var _vSpace:int = 1;
      
      private var _vWidth:Number = 50;
      
      private var _vHeight:Number = 100;
      
      private var _container:TinyUI;
      
      protected var _isDynamicSpace:Boolean = true;
      
      private var _dynamicShow:Boolean = true;
      
      private var _barViewPath:String;
      
      private var _bg:SimpleImage;
      
      private var _backGround:BitmapData;
      
      private var _barX:Number;
      
      private var _barY:Number;
      
      public function SimpleList()
      {
         super();
         _container = new TinyUI();
         super.addChild(_container);
      }
      
      private function addScroll() : void
      {
         if(!_isScroll || barViewPath == null)
         {
            return;
         }
         if(_vscrollBar == null)
         {
            _vscrollBar = new NewScrollBar();
         }
         _vscrollBar.xmlViewPath = barViewPath;
         _vscrollBar.showWidth = _vWidth;
         _vscrollBar.showHeight = _vHeight;
         _vscrollBar.view = _container;
         super.addChild(_vscrollBar);
      }
      
      override public function render() : void
      {
         if(validateDic["scrollvalue"])
         {
            if(_vscrollBar)
            {
               _vscrollBar.barX = _barX;
               _vscrollBar.barY = _barY;
               _vscrollBar.dynamicShow = _dynamicShow;
            }
         }
         if(validateDic["widthheightchange"] && scrollBar)
         {
            scrollBar.showHeight = _vHeight;
            scrollBar.showWidth = _vWidth;
         }
         if(validateDic[STYLE])
         {
            updatePos();
            if(scrollBar)
            {
               scrollBar.refreshView();
            }
            if(_bg)
            {
               super.removeChild(_bg);
               if(_vscrollBar)
               {
                  if(_vscrollBar.showHeight < contentHeight)
                  {
                     _bg.height = _vscrollBar.showHeight;
                  }
                  else
                  {
                     _vscrollBar.showHeight = contentHeight;
                  }
               }
               super.addChildAt(_bg,0);
            }
         }
      }
      
      public function get length() : int
      {
         return _childs.length;
      }
      
      public function set showHeight(param1:Number) : void
      {
         _vHeight = param1;
         validate("widthheightchange");
         validate(STYLE);
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
         validate(STYLE);
         validate("widthheightchange");
      }
      
      public function get scrollBar() : NewScrollBar
      {
         return _vscrollBar;
      }
      
      public function get isScroll() : Boolean
      {
         return _isScroll;
      }
      
      public function set isScroll(param1:Boolean) : void
      {
         _isScroll = param1;
         if(_isScroll && _vscrollBar == null)
         {
            addScroll();
         }
         else if(_vscrollBar)
         {
            this.removeChild(_vscrollBar);
            _vscrollBar.view = null;
         }
      }
      
      override public function get height() : Number
      {
         if(_isScroll)
         {
            return _vHeight;
         }
         return super.height;
      }
      
      override public function get width() : Number
      {
         if(_isScroll)
         {
            return _vWidth;
         }
         return super.width;
      }
      
      override public function getBoundRect(param1:DisplayObject = null) : Rectangle
      {
         var _loc2_:Rectangle = super.getBoundRect(param1);
         if(_isScroll)
         {
            _loc2_.width = _vWidth;
            _loc2_.height = _vHeight;
         }
         return _loc2_;
      }
      
      public function get childs() : Array
      {
         return _childs;
      }
      
      public function clear() : void
      {
         _container.removeChildren();
         _childs.splice(0,0);
         _childs.length = 0;
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
         if(_childs == null)
         {
            return param1;
         }
         if(param1 == _vscrollBar || param1.name == "list_rect")
         {
            return super.addChild(param1);
         }
         if(_container.contains(param1))
         {
            return _container.addChild(param1);
         }
         _container.addChild(param1);
         _childs.push(param1);
         validate(STYLE);
         return param1;
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         if(_childs == null)
         {
            return param1;
         }
         if(param1 == _vscrollBar || param1.name == "list_rect")
         {
            return super.addChild(param1);
         }
         _container.addChildAt(param1,param2);
         _childs.splice(param2,0,param1);
         validate(STYLE);
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
         if(_container.contains(param1))
         {
            updatePos(_loc3_);
            _container.removeChild(param1);
         }
         else
         {
            super.removeChild(param1);
         }
         validate(STYLE);
         return param1;
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         var _loc3_:int = int(_childs.length);
         if(param1 < 0 || param1 >= _loc3_)
         {
            throw new Error("删除SimpleList孩子index超出范围index-->" + param1);
         }
         var _loc2_:DisplayObject = _childs[param1];
         _childs.splice(param1,1);
         updatePos(param1);
         _container.removeChild(_loc2_);
         validate(STYLE);
         return _loc2_;
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
         _container.removeChildren(param1,param2);
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
         if(_vscrollBar)
         {
            _vscrollBar.dispose();
            _vscrollBar = null;
         }
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
      
      public function get percent() : Number
      {
         return scrollBar.percent;
      }
      
      public function set percent(param1:Number) : void
      {
         scrollBar.percent = param1;
      }
      
      public function get barViewPath() : String
      {
         return _barViewPath;
      }
      
      public function set barViewPath(param1:String) : void
      {
         _barViewPath = param1;
         isScroll = true;
      }
      
      public function get barY() : int
      {
         return _barY;
      }
      
      public function set barY(param1:int) : void
      {
         _barY = param1;
         validate("scrollvalue");
      }
      
      public function get barX() : int
      {
         return _barX;
      }
      
      public function set barX(param1:int) : void
      {
         _barX = param1;
         validate("scrollvalue");
      }
      
      public function get dynamicShow() : Boolean
      {
         return _dynamicShow;
      }
      
      public function set dynamicShow(param1:Boolean) : void
      {
         _dynamicShow = param1;
         validate("scrollvalue");
      }
      
      public function get contentWidth() : Number
      {
         return _container.width;
      }
      
      public function get contentHeight() : Number
      {
         return _container.height;
      }
      
      public function get bg() : SimpleImage
      {
         return _bg;
      }
      
      public function set bg(param1:SimpleImage) : void
      {
         if(_bg && _bg.parent == this)
         {
            super.removeChild(_bg);
         }
         _bg = param1;
         if(_bg)
         {
            super.addChildAt(_bg,0);
         }
      }
      
      public function get backGround() : BitmapData
      {
         return _backGround;
      }
      
      public function set backGround(param1:BitmapData) : void
      {
         _backGround = param1;
         if(_backGround)
         {
            bg = new SimpleImage(_backGround);
         }
      }
   }
}

