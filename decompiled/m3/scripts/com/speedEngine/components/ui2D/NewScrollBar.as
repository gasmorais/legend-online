package com.speedEngine.components.ui2D
{
   import com.speedEngine.components.ui2D.controls.IViewPort;
   import com.speedEngine.components.ui2D.controls.ScrollbarView;
   import com.speedEngine.game.Director;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class NewScrollBar extends TinyUI
   {
      
      protected static const INIT:String = "init";
      
      protected static const SHOWCHANG:String = "showchange";
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
      
      private var _view:IViewPort;
      
      private var _barView:ScrollbarView;
      
      private var _barLayoutType:String;
      
      private var _maxShow:int;
      
      private var _showHeight:Number;
      
      private var _showWidth:Number;
      
      private var _mask:Shape = new Shape();
      
      private var _barX:int = 2147483647;
      
      private var _barY:int = 2147483647;
      
      private var _xmlViewPath:String;
      
      private var _dynamicShow:Boolean = true;
      
      public function NewScrollBar()
      {
         super();
         barLayoutType = "vertical";
      }
      
      override public function getBoundRect(param1:DisplayObject = null) : Rectangle
      {
         var _loc2_:Rectangle = super.getBoundRect(param1);
         _loc2_.width = _showWidth;
         _loc2_.height = _showHeight;
         return _loc2_;
      }
      
      protected function setProperty() : void
      {
         if(_barView == null)
         {
            _barView = new ScrollbarView();
         }
         _barView.MaxHeight = _view.getMaxHeight();
         _barView.MaxWidth = _view.getMaxWidth();
         _barView.updatePercent = updatePercent;
         var _loc1_:Sprite = _view as Sprite;
         _loc1_.mask = _mask;
         _loc1_.parent ? __onAddToStage(null) : _loc1_.addEventListener("addedToStage",__onAddToStage);
         Director.instance.addEvent(_loc1_,"resize",__onResize);
         Director.instance.addEvent(_loc1_,"removedFromStage",__onRemoveOnStage);
         Director.instance.addEvent(Director.instance.stage2d,"mouseWheel",__onMouseWheel);
      }
      
      public function removeEvent() : void
      {
         var _loc1_:Sprite = _view as Sprite;
         Director.instance.removeEvent(_loc1_,"resize",__onResize);
         Director.instance.removeEvent(_loc1_,"removedFromStage",__onRemoveOnStage);
         Director.instance.removeEvent(Director.instance.stage2d,"mouseWheel",__onMouseWheel);
      }
      
      private function __onMouseWheel(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = _view as Sprite;
         if(_loc2_)
         {
            if(_loc2_.getBounds(Director.instance.stage2d).contains(param1.stageX,param1.stageY))
            {
               _barView.__onWheel(param1);
            }
            else if(_barView && _barView.getBounds(Director.instance.stage2d).contains(param1.stageX,param1.stageY))
            {
               _barView.__onWheel(param1);
            }
         }
      }
      
      private function __onRemoveOnStage(param1:Event) : void
      {
         var _loc2_:Sprite = _view as Sprite;
         Director.instance.removeEvent(_loc2_,"resize",__onResize);
         Director.instance.removeEvent(_loc2_,"removedFromStage",__onRemoveOnStage);
      }
      
      protected function changShowSize() : void
      {
         _barView.showHeight = _showHeight;
         _barView.showWidth = _showWidth;
         switch(barLayoutType)
         {
            case "horizontal":
               _maxShow = _view.getMaxWidth() - _showWidth;
               break;
            case "vertical":
               _maxShow = _view.getMaxHeight() - _showHeight;
         }
         if(_maxShow <= 0 && _dynamicShow)
         {
            _barView.visible = false;
         }
         else
         {
            _barView.visible = true;
         }
         if(_barX == 2147483647 && layoutType == "vertical")
         {
            _barView.x = _showWidth;
         }
         if(_barY == 2147483647 && layoutType == "horizontal")
         {
            _barView.y = _showHeight;
         }
         _mask.graphics.clear();
         _mask.graphics.beginFill(16711680);
         _mask.graphics.drawRect(0,0,_showWidth,_showHeight);
         _mask.graphics.endFill();
         addChild(_mask);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function render() : void
      {
         super.render();
         if(validateDic["init"])
         {
            setProperty();
            if(validateDic["showchange"] == false)
            {
               changShowSize();
            }
         }
         if(validateDic["showchange"])
         {
            changShowSize();
         }
         if(validateDic[STYLE])
         {
            _barView.x = barX;
            _barView.y = barY;
            _barView.barLayoutType = barLayoutType;
         }
      }
      
      public function get percent() : Number
      {
         return _barView.percent;
      }
      
      public function set percent(param1:Number) : void
      {
         _barView.percent = param1;
      }
      
      public function updatePercent(param1:Number) : void
      {
         switch(barLayoutType)
         {
            case "horizontal":
               _view.setScrollH(param1 * _maxShow * -1);
               break;
            case "vertical":
               _view.setScrollV(param1 * _maxShow * -1);
         }
      }
      
      public function get view() : IViewPort
      {
         return _view;
      }
      
      public function set view(param1:IViewPort) : void
      {
         var _loc2_:Sprite = null;
         if(param1 == null && _view)
         {
            _loc2_ = _view as Sprite;
            _loc2_.mask = null;
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
            return;
         }
         _view = param1;
         validate("init");
      }
      
      protected function __onResize(param1:Event) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         _barView.MaxHeight = _view.getMaxHeight();
         _barView.MaxWidth = _view.getMaxWidth();
         switch(barLayoutType)
         {
            case "horizontal":
               _maxShow = _view.getMaxWidth() - _showWidth;
               break;
            case "vertical":
               _maxShow = _view.getMaxHeight() - _showHeight;
         }
         if(_maxShow <= 0 && _dynamicShow)
         {
            _barView.visible = false;
         }
         else
         {
            _barView.visible = true;
         }
         percent = percent;
      }
      
      protected function __onAddToStage(param1:Event) : void
      {
         var _loc2_:Sprite = _view as Sprite;
         addChild(_barView);
         _loc2_.parent.addChild(this);
         _loc2_.removeEventListener("addedToStage",__onAddToStage);
      }
      
      public function get barLayoutType() : String
      {
         return _barLayoutType;
      }
      
      public function set barLayoutType(param1:String) : void
      {
         _barLayoutType = param1;
         validate(STYLE);
      }
      
      public function get showHeight() : Number
      {
         return _showHeight;
      }
      
      public function set showHeight(param1:Number) : void
      {
         _showHeight = param1;
         validate("showchange");
      }
      
      public function get showWidth() : Number
      {
         return _showWidth;
      }
      
      public function set showWidth(param1:Number) : void
      {
         _showWidth = param1;
         validate("showchange");
      }
      
      public function get barView() : ScrollbarView
      {
         return _barView;
      }
      
      public function set barView(param1:ScrollbarView) : void
      {
         _barView = param1;
         validate("init");
      }
      
      public function get barX() : int
      {
         return _barView.x;
      }
      
      public function set barX(param1:int) : void
      {
         _barView.x = param1;
         _barX = param1;
      }
      
      public function get barY() : int
      {
         return _barView.y;
      }
      
      public function set barY(param1:int) : void
      {
         _barView.y = param1;
         _barY = param1;
      }
      
      public function get dynamicShow() : Boolean
      {
         return _dynamicShow;
      }
      
      public function set dynamicShow(param1:Boolean) : void
      {
         _dynamicShow = param1;
      }
      
      public function get xmlViewPath() : String
      {
         return _xmlViewPath;
      }
      
      public function set xmlViewPath(param1:String) : void
      {
         if(_barView == null)
         {
            barView = new ScrollbarView();
         }
         _xmlViewPath = param1;
         barView.xmlViewPath = _xmlViewPath;
      }
   }
}

