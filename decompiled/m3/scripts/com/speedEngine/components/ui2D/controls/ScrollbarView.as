package com.speedEngine.components.ui2D.controls
{
   import com.speedEngine.components.manager.UIFactory;
   import com.speedEngine.components.ui2D.SimpleButton;
   import com.speedEngine.components.ui2D.SimpleImage;
   import com.speedEngine.components.ui2D.TinyUI;
   import com.speedEngine.game.Director;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ScrollbarView extends TinyUI
   {
      
      protected static const SHOWCHANG:String = "showchange";
      
      private var _upButton:SimpleButton;
      
      private var _downButton:SimpleButton;
      
      private var _bg:SimpleImage;
      
      private var _scrollButton:SimpleButton;
      
      private var _scrollIcon:SimpleImage;
      
      private var _container:TinyUI;
      
      private var _xmlViewPath:String;
      
      private var _barLayoutType:String = "vertical";
      
      private var _gap:int;
      
      private var _MaxMoveLen:int = 500;
      
      private var _downPoint:Point = new Point();
      
      private var _percent:Number = 0;
      
      private var _MaxHeight:Number;
      
      private var _MaxWidth:Number;
      
      private var _showWidth:Number;
      
      private var _showHeight:Number;
      
      private var _maxMove:Number;
      
      private var _updatePercent:Function;
      
      private var _controlBtnWidth:int;
      
      private var _controlBtnHeight:int;
      
      private var _tempPercent:Number;
      
      private var _minLen:int = 24;
      
      public function ScrollbarView()
      {
         super();
      }
      
      public function initEvent() : void
      {
         upButton.onClickCallBack = onAction;
         downButton.onClickCallBack = onAction;
         Director.instance.addEvent(scrollButton,"mouseDown",onAction);
      }
      
      public function removeEvent() : void
      {
         upButton.onClickCallBack = null;
         downButton.onClickCallBack = null;
         Director.instance.removeEvent(scrollButton,"mouseDown",onAction);
      }
      
      protected function changeMaxWH() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:int = 0;
         switch(_barLayoutType)
         {
            case "horizontal":
               _loc2_ = showWidth / MaxWidth;
               _loc2_ = _loc2_ > 1 ? 1 : _loc2_;
               _controlBtnWidth = upButton.width;
               _loc1_ = _loc2_ * (width - 2 * _controlBtnWidth);
               scrollButton.width = _loc1_ < _minLen ? _minLen : _loc1_;
               _scrollIcon.x = scrollButton.width - _scrollIcon.width >> 1;
               _maxMove = showWidth - 2 * _controlBtnWidth - scrollButton.width;
               break;
            case "vertical":
               _loc2_ = showHeight / MaxHeight;
               _loc2_ = _loc2_ > 1 ? 1 : _loc2_;
               _controlBtnHeight = upButton.height;
               _loc1_ = _loc2_ * (showHeight - 2 * _controlBtnHeight);
               scrollButton.height = _loc1_ < _minLen ? _minLen : _loc1_;
               _scrollIcon.y = scrollButton.height - _scrollIcon.height >> 1;
               _maxMove = showHeight - 2 * _controlBtnHeight - scrollButton.height;
         }
         percent = _percent;
      }
      
      public function __onWheel(param1:MouseEvent) : void
      {
         var _temp_1:*;
         var _temp_3:*;
         param1.delta > 0 ? (_temp_1 = §§findproperty(percent),percent = percent - 0.1) : (_temp_3 = §§findproperty(percent),percent = percent + 0.1);
      }
      
      private function onAction(param1:MouseEvent) : void
      {
         if(_maxMove <= 0)
         {
            return;
         }
         switch(param1.currentTarget)
         {
            case upButton:
               percent -= 0.1;
               break;
            case downButton:
               percent += 0.1;
               break;
            case scrollButton:
               _tempPercent = _percent;
               _downPoint.x = param1.stageX;
               _downPoint.y = param1.stageY;
               Director.instance.addEvent(Director.instance.stage2d,"mouseMove",onMove);
               Director.instance.addEvent(Director.instance.stage2d,"mouseUp",onUp);
         }
      }
      
      protected function onUp(param1:MouseEvent) : void
      {
         Director.instance.removeEvent(Director.instance.stage2d,"mouseMove",onMove);
         Director.instance.removeEvent(Director.instance.stage2d,"mouseUp",onUp);
      }
      
      protected function onMove(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         switch(_barLayoutType)
         {
            case "horizontal":
               _loc3_ = param1.stageX - _downPoint.x;
               percent = _tempPercent + _loc3_ / _maxMove;
               break;
            case "vertical":
               _loc2_ = param1.stageY - _downPoint.y;
               percent = _tempPercent + _loc2_ / _maxMove;
         }
      }
      
      override public function render() : void
      {
         super.render();
         if(validateDic["showchange"])
         {
            switch(_barLayoutType)
            {
               case "horizontal":
                  _MaxMoveLen = _showWidth;
                  break;
               case "vertical":
                  _MaxMoveLen = _showHeight;
            }
            changeMaxWH();
            layout();
            percent = _percent;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
      
      public function get xmlViewPath() : String
      {
         return _xmlViewPath;
      }
      
      public function set xmlViewPath(param1:String) : void
      {
         if(param1 != null && _xmlViewPath != param1)
         {
            _xmlViewPath = param1;
            container = UIFactory.instance.createUI(_xmlViewPath) as TinyUI;
         }
      }
      
      public function get container() : TinyUI
      {
         return _container;
      }
      
      public function set container(param1:TinyUI) : void
      {
         if(_container)
         {
            _container.dispose();
         }
         _container = param1;
         upButton = _container.getChildByPath("root.upbutton") as SimpleButton;
         downButton = _container.getChildByPath("root.downbutton") as SimpleButton;
         bg = _container.getChildByPath("root.bg") as SimpleImage;
         scrollButton = _container.getChildByPath("root.scrollbutton") as SimpleButton;
         _scrollIcon = scrollButton.getChildByPath("scrollicon") as SimpleImage;
         initEvent();
         addChild(_container);
      }
      
      public function layout() : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         switch(_barLayoutType)
         {
            case "horizontal":
               bg.y = 0;
               bg.x = 0;
               _loc1_ = bg.height;
               downButton.y = _loc1_ - downButton.height >> 1;
               scrollButton.y = _loc1_ - scrollButton.height >> 1;
               upButton.y = _loc1_ - upButton.height >> 1;
               _scrollIcon.y = _loc1_ - _scrollIcon.height >> 1;
               _loc3_ = showWidth / MaxWidth;
               _loc3_ = _loc3_ > 1 ? 1 : _loc3_;
               _controlBtnWidth = upButton.width;
               upButton.x = 0;
               bg.width = showWidth;
               downButton.x = showWidth - _controlBtnWidth;
               scrollButton.width = _loc3_ * (width - 2 * _controlBtnWidth);
               _scrollIcon.x = scrollButton.width - _scrollIcon.width >> 1;
               _maxMove = showWidth - 2 * _controlBtnWidth - scrollButton.width;
               break;
            case "vertical":
               bg.x = 0;
               bg.y = 0;
               _loc2_ = bg.width;
               downButton.x = _loc2_ - downButton.width >> 1;
               scrollButton.x = _loc2_ - scrollButton.width >> 1;
               upButton.x = _loc2_ - upButton.width >> 1;
               _scrollIcon.x = _loc2_ - _scrollIcon.width >> 1;
               _loc3_ = showHeight / MaxHeight;
               _loc3_ = _loc3_ > 1 ? 1 : _loc3_;
               _controlBtnHeight = upButton.height;
               upButton.y = 0;
               bg.height = showHeight;
               scrollButton.height = _loc3_ * (showHeight - 2 * _controlBtnHeight);
               downButton.y = showHeight - _controlBtnHeight;
               _scrollIcon.y = scrollButton.height - _scrollIcon.height >> 1;
               _maxMove = showHeight - 2 * _controlBtnHeight - scrollButton.height;
         }
      }
      
      public function get upButton() : SimpleButton
      {
         return _upButton;
      }
      
      public function set upButton(param1:SimpleButton) : void
      {
         _upButton = param1;
      }
      
      public function get downButton() : SimpleButton
      {
         return _downButton;
      }
      
      public function set downButton(param1:SimpleButton) : void
      {
         _downButton = param1;
      }
      
      public function get bg() : SimpleImage
      {
         return _bg;
      }
      
      public function set bg(param1:SimpleImage) : void
      {
         _bg = param1;
      }
      
      public function get scrollButton() : SimpleButton
      {
         return _scrollButton;
      }
      
      public function set scrollButton(param1:SimpleButton) : void
      {
         _scrollButton = param1;
      }
      
      public function get percent() : Number
      {
         return _percent;
      }
      
      public function set percent(param1:Number) : void
      {
         param1 = param1 < 0 ? 0 : (param1 > 1 ? 1 : param1);
         _percent = param1;
         switch(_barLayoutType)
         {
            case "horizontal":
               scrollButton.x = _percent * _maxMove + _controlBtnWidth;
               break;
            case "vertical":
               scrollButton.y = _percent * _maxMove + _controlBtnHeight;
         }
         if(_updatePercent != null)
         {
            _updatePercent(_maxMove > 0 ? param1 : 0);
         }
      }
      
      public function get MaxHeight() : Number
      {
         return _MaxHeight;
      }
      
      public function set MaxHeight(param1:Number) : void
      {
         _MaxHeight = param1;
         changeMaxWH();
      }
      
      public function get MaxWidth() : Number
      {
         return _MaxWidth;
      }
      
      public function set MaxWidth(param1:Number) : void
      {
         _MaxWidth = param1;
         changeMaxWH();
      }
      
      public function get showWidth() : Number
      {
         return _showWidth;
      }
      
      public function set showWidth(param1:Number) : void
      {
         _showWidth = param1;
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
      
      public function get updatePercent() : Function
      {
         return _updatePercent;
      }
      
      public function set updatePercent(param1:Function) : void
      {
         _updatePercent = param1;
      }
      
      public function get barLayoutType() : String
      {
         return _barLayoutType;
      }
      
      public function set barLayoutType(param1:String) : void
      {
         _barLayoutType = param1;
      }
      
      public function get minLen() : int
      {
         return _minLen;
      }
      
      public function set minLen(param1:int) : void
      {
         _minLen = param1;
      }
   }
}

