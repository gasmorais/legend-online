package com.speedEngine.components.ui2D
{
   import com.speedEngine.components.manager.UIFactory;
   import com.speedEngine.game.Director;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   
   public class AlertView extends TinyUI
   {
      
      public static var TITLECHANGE:String = "titlechange";
      
      public static var RECTCHANGE:String = "rectChange";
      
      public static var MINMAXCHANGE:String = "minmaxChange";
      
      public static var SET_ATTRIBUTE:String = "set_attribute";
      
      private var _container:TinyUI;
      
      protected var _downPoint:Point = new Point();
      
      protected var _tX:int;
      
      protected var _tY:int;
      
      private var _btnX:int;
      
      private var _btnY:int;
      
      private var _textX:int;
      
      private var _textY:int;
      
      private var _moveState:int = 2;
      
      private var _maxX:int;
      
      private var _maxY:int;
      
      private var _minX:int;
      
      private var _minY:int;
      
      private var _downRect:Rectangle;
      
      private var _textField:SimpleTextField = new SimpleTextField(new TextFormat("黑体",25,16711680));
      
      private var _containerPath:String;
      
      protected var _isDown:Boolean = false;
      
      private var _closeCallBack:Function;
      
      protected var _closeBtn:SimpleButton;
      
      protected var _bg:SimpleImage;
      
      protected var _mc:SimpleMovieClip;
      
      private var _moveMax:int = 100;
      
      private var _isCenter:Boolean = true;
      
      protected var _uiLayer:TinyUI = new TinyUI();
      
      private var _canMove:Boolean = false;
      
      private var _mcX:int;
      
      private var _mcY:int;
      
      private var _mcWidth:int;
      
      private var _mcHeight:int;
      
      private var _movieGroup:MovieGroup;
      
      private var _setWidth:Number = 0;
      
      private var _setHeight:Number = 0;
      
      public function AlertView()
      {
         super();
         this.addEventListener("addedToStage",__onAddStage);
         this.addEventListener("removedFromStage",__removeStage);
         downRect = new Rectangle(0,0,100,40);
         _textField.autoSize = "left";
         isCenter = true;
      }
      
      protected function __removeStage(param1:Event) : void
      {
         removeEvent();
      }
      
      protected function __onMouseUp(param1:MouseEvent) : void
      {
         _isDown = false;
         Director.instance.stage2d.removeEventListener("mouseMove",__onMouseMove);
         Director.instance.stage2d.removeEventListener("mouseUp",__onMouseUp);
      }
      
      override public function get numChildren() : int
      {
         return _uiLayer.numChildren;
      }
      
      protected function __onMouseMove(param1:MouseEvent) : void
      {
         var _loc5_:Point = null;
         var _loc4_:Point = null;
         var _loc3_:Point = null;
         var _loc2_:Point = null;
         if(_isDown && canMove)
         {
            this.x = _tX + param1.stageX - _downPoint.x;
            this.y = _tY + param1.stageY - _downPoint.y;
            _loc4_ = this.parent.globalToLocal(new Point(0,0));
            _loc3_ = this.parent.globalToLocal(new Point(stage.stageWidth,stage.stageHeight));
            switch(moveState)
            {
               case 0:
                  if(this.x + width > _loc3_.x)
                  {
                     this.x = _loc3_.x - width;
                  }
                  else if(this.x < _loc4_.x)
                  {
                     this.x = _loc4_.x;
                  }
                  if(this.y + height > _loc3_.y)
                  {
                     this.y = _loc3_.y - height;
                  }
                  else if(this.y < _loc4_.y)
                  {
                     this.y = _loc4_.y;
                  }
                  break;
               case 1:
                  _loc2_ = this.localToGlobal(new Point(downRect.x,downRect.y));
                  _loc5_ = this.parent.globalToLocal(_loc2_);
                  if(_loc5_.x + downRect.width > _loc3_.x)
                  {
                     this.x = _loc3_.x - _loc5_.x;
                  }
                  else if(_loc5_.x < _loc4_.x)
                  {
                     this.x = _loc4_.x - _loc5_.x;
                  }
                  if(_loc5_.y + downRect.height > _loc3_.y)
                  {
                     this.y = _loc3_.y - _loc5_.y - downRect.height;
                  }
                  else if(_loc5_.y < _loc4_.y)
                  {
                     this.y = _loc4_.y - _loc5_.y;
                  }
                  break;
               case 2:
                  if(this.x > maxX)
                  {
                     this.x = maxX;
                  }
                  else if(this.x < minX)
                  {
                     this.x = minX;
                  }
                  if(this.y > maxY)
                  {
                     this.y = maxY;
                     break;
                  }
                  if(this.y < minY)
                  {
                     this.y = minY;
                  }
            }
         }
      }
      
      override public function getBoundRect(param1:DisplayObject = null) : Rectangle
      {
         if(_container)
         {
            return _container.getBoundRect(param1);
         }
         return super.getBoundRect(param1);
      }
      
      protected function isPointIn(param1:int, param2:int) : Boolean
      {
         var _loc4_:Point = new Point(param1,param2);
         var _loc5_:Point = this.localToGlobal(new Point(0,0));
         var _loc3_:Rectangle = new Rectangle(_loc5_.x,_loc5_.y,this.width,this.height);
         return _loc3_.containsPoint(_loc4_);
      }
      
      protected function __onMouseDown(param1:MouseEvent) : void
      {
         var _loc3_:Point = null;
         var _loc2_:Point = null;
         if(!isPointIn(param1.stageX,param1.stageY))
         {
            return;
         }
         if(this.parent)
         {
            this.parent.addChild(this);
            _loc3_ = new Point(param1.stageX,param1.stageY);
            _loc2_ = this.globalToLocal(_loc3_);
            if(!_downRect.containsPoint(_loc2_))
            {
               return;
            }
            _isDown = true;
            _downPoint.x = param1.stageX;
            _downPoint.y = param1.stageY;
            _tX = this.x;
            _tY = this.y;
            Director.instance.stage2d.addEventListener("mouseUp",__onMouseUp);
            Director.instance.stage2d.addEventListener("mouseMove",__onMouseMove);
         }
      }
      
      protected function __onAddStage(param1:Event) : void
      {
         if(_canMove)
         {
            initEvent();
         }
      }
      
      protected function initEvent() : void
      {
         this.addEventListener("mouseDown",__onMouseDown);
         this.addEventListener("mouseMove",__onMouseOver);
         this.addEventListener("rollOut",__onRollOut);
      }
      
      protected function __onRollOut(param1:MouseEvent) : void
      {
         if(_isDown)
         {
            return;
         }
         Mouse.cursor = "auto";
         Director.instance.stage2d.removeEventListener("mouseMove",__onMouseMove);
         Director.instance.stage2d.removeEventListener("mouseUp",__onMouseUp);
      }
      
      protected function __onMouseOver(param1:MouseEvent) : void
      {
         var _loc3_:Point = null;
         if(_isDown && canMove)
         {
            return;
         }
         _loc3_ = new Point(param1.stageX,param1.stageY);
         var _loc2_:Point = this.globalToLocal(_loc3_);
         if(_downRect.containsPoint(_loc2_))
         {
            Mouse.cursor = "hand";
         }
         else
         {
            Mouse.cursor = "auto";
         }
      }
      
      protected function removeEvent() : void
      {
         this.removeEventListener("mouseDown",__onMouseDown);
         this.removeEventListener("mouseMove",__onMouseOver);
         this.removeEventListener("rollOut",__onRollOut);
         Director.instance.stage2d.removeEventListener("mouseMove",__onMouseMove);
         Director.instance.stage2d.removeEventListener("mouseUp",__onMouseUp);
      }
      
      override public function __onAfterProp() : void
      {
         super.__onAfterProp();
      }
      
      override public function dispose() : void
      {
         if(_container)
         {
            _container.dispose();
            _container.removeChildren();
            if(_container.parent == this)
            {
               super.removeChild(_container);
            }
            removeChildren();
         }
         removeEvent();
         this.removeEventListener("addedToStage",__onAddStage);
         this.removeEventListener("removedFromStage",__removeStage);
         _closeCallBack = null;
         super.dispose();
      }
      
      public function getChildByNameFrom(param1:String, param2:DisplayObjectContainer = null) : TinyUI
      {
         var _loc5_:TinyUI = null;
         var _loc7_:TinyUI = null;
         var _loc6_:int = 0;
         var _loc3_:TinyUI = null;
         if(param2 == null)
         {
            param2 = this;
         }
         var _loc4_:int = param2.numChildren;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = param2.getChildAt(_loc6_) as TinyUI;
            if(_loc5_)
            {
               if(_loc5_.name == param1)
               {
                  _loc7_ = _loc5_;
               }
               else if(_loc5_.numChildren > 0)
               {
                  _loc3_ = getChildByNameFrom(param1,_loc5_);
                  _loc7_ = _loc3_ != null ? _loc3_ : _loc7_;
               }
            }
            _loc6_++;
         }
         return _loc7_;
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         return _uiLayer.addChildAt(param1,param2);
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         return _uiLayer.removeChildAt(param1);
      }
      
      override public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         _uiLayer.setChildIndex(param1,param2);
      }
      
      override public function swapChildrenAt(param1:int, param2:int) : void
      {
         _uiLayer.swapChildrenAt(param1,param2);
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         return _uiLayer.addChild(param1);
      }
      
      override public function contains(param1:DisplayObject) : Boolean
      {
         return _uiLayer.contains(param1);
      }
      
      override public function getChildAt(param1:int) : DisplayObject
      {
         return _uiLayer.getChildAt(param1);
      }
      
      override public function getChildByName(param1:String) : DisplayObject
      {
         return _uiLayer.getChildByName(param1);
      }
      
      override public function getChildIndex(param1:DisplayObject) : int
      {
         return _uiLayer.getChildIndex(param1);
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         return _uiLayer.removeChild(param1);
      }
      
      override public function removeChildren(param1:int = 0, param2:int = 2147483647) : void
      {
         _uiLayer.removeChildren(param1,param2);
      }
      
      override public function swapChildren(param1:DisplayObject, param2:DisplayObject) : void
      {
         _uiLayer.swapChildren(param1,param2);
      }
      
      public function set title(param1:String) : void
      {
         _textField.text = param1;
         validate(TITLECHANGE);
      }
      
      public function get title() : String
      {
         return _textField.text;
      }
      
      public function get container() : TinyUI
      {
         return _container;
      }
      
      public function set container(param1:TinyUI) : void
      {
         _container = param1;
         _closeBtn = getChildByNameFrom("closeBtn",_container) as SimpleButton;
         _bg = getChildByNameFrom("bg",_container) as SimpleImage;
         _mc = getChildByNameFrom("mc",_container) as SimpleMovieClip;
         if(_mc)
         {
            if(_movieGroup && _movieGroup.parent == this)
            {
               _movieGroup.dispose();
               _movieGroup.removeChildren();
               _container.removeChild(_movieGroup);
            }
            _movieGroup = new MovieGroup(_mc);
            _container.addChild(_movieGroup);
         }
         super.addChildAt(_container,0);
         _container.addChild(_uiLayer);
         validate(SET_ATTRIBUTE);
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         _setWidth = param1;
         validate(SET_ATTRIBUTE);
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         _setHeight = param1;
         validate(SET_ATTRIBUTE);
      }
      
      override public function get height() : Number
      {
         if(_container)
         {
            return _container.height;
         }
         return super.height;
      }
      
      override public function get width() : Number
      {
         if(_container)
         {
            return _container.width;
         }
         return super.width;
      }
      
      public function get closeCallBack() : Function
      {
         return _closeCallBack;
      }
      
      public function set closeCallBack(param1:Function) : void
      {
         _closeCallBack = param1;
         validate(SET_ATTRIBUTE);
      }
      
      public function get textField() : SimpleTextField
      {
         return _textField;
      }
      
      public function set textField(param1:SimpleTextField) : void
      {
         _textField = param1;
      }
      
      public function get containerPath() : String
      {
         return _containerPath;
      }
      
      public function set containerPath(param1:String) : void
      {
         _containerPath = param1;
         container = UIFactory.instance.createUI(_containerPath) as TinyUI;
      }
      
      override public function render() : void
      {
         var _loc2_:Point = null;
         var _loc1_:Point = null;
         super.render();
         if(validateDic[SET_ATTRIBUTE])
         {
            setAttribute();
         }
         if(validateDic[TITLECHANGE])
         {
            if(_textField.parent == container)
            {
               container.removeChild(_textField);
            }
            if(_textX != -1)
            {
               if(_bg)
               {
                  _textField.x = _bg.width - _textField.width >> 1;
               }
            }
            else
            {
               _textField.x = _textX;
            }
            _textField.y = _textY;
            _container.addChild(_textField);
         }
         if(_closeBtn)
         {
            _closeBtn.x = btnX;
            _closeBtn.y = btnY;
         }
         if(_mc)
         {
            setMC();
         }
         if(validateDic[RECTCHANGE])
         {
            if(!validateDic[MINMAXCHANGE] && moveState == 2 && stage)
            {
               _loc2_ = this.parent.globalToLocal(new Point(0,0));
               _loc1_ = this.parent.globalToLocal(new Point(stage.stageWidth,stage.stageHeight));
               if(downRect.width < _moveMax)
               {
                  _moveMax = downRect.width;
               }
               _maxX = _loc1_.x - downRect.x - _moveMax;
               _minX = _loc2_.x - downRect.width - downRect.x + _moveMax;
               _maxY = _loc1_.y - downRect.y - downRect.height;
               _minY = _loc2_.y - downRect.y;
            }
         }
         if(validateDic[STYLE])
         {
            layout();
         }
      }
      
      private function setAttribute() : void
      {
         if(_closeBtn)
         {
            _closeBtn.onClickCallBack = _closeCallBack;
         }
         if(_closeBtn)
         {
            _container.addChild(_closeBtn);
         }
         _container.addChild(_textField);
         if(_bg)
         {
            _bg.height = _setHeight;
            _bg.width = _setWidth;
         }
      }
      
      private function setMC() : void
      {
         if(_movieGroup)
         {
            _movieGroup.x = _mcX;
            _movieGroup.y = _mcY;
         }
      }
      
      private function layout() : void
      {
         if(isCenter)
         {
            container.x = this.width - container.width >> 1;
            container.y = this.height - container.height >> 1;
         }
      }
      
      public function get btnX() : int
      {
         return _btnX;
      }
      
      public function set btnX(param1:int) : void
      {
         _btnX = param1;
         validate(STYLE);
      }
      
      public function get btnY() : int
      {
         return _btnY;
      }
      
      public function set btnY(param1:int) : void
      {
         _btnY = param1;
         validate(STYLE);
      }
      
      public function get textX() : int
      {
         return _textX;
      }
      
      public function set textX(param1:int) : void
      {
         _textX = param1;
      }
      
      public function get textY() : int
      {
         return _textY;
      }
      
      public function set textY(param1:int) : void
      {
         _textY = param1;
      }
      
      public function get downRect() : Rectangle
      {
         return _downRect;
      }
      
      public function set downRect(param1:Rectangle) : void
      {
         _downRect = param1;
         validate(RECTCHANGE);
      }
      
      public function get maxX() : int
      {
         return _maxX;
      }
      
      public function set maxX(param1:int) : void
      {
         _maxX = param1;
         validate(MINMAXCHANGE);
      }
      
      public function get maxY() : int
      {
         return _maxY;
      }
      
      public function set maxY(param1:int) : void
      {
         _maxY = param1;
         validate(MINMAXCHANGE);
      }
      
      public function get minX() : int
      {
         return _minX;
      }
      
      public function set minX(param1:int) : void
      {
         _minX = param1;
         validate(MINMAXCHANGE);
      }
      
      public function get minY() : int
      {
         return _minY;
      }
      
      public function set minY(param1:int) : void
      {
         _minY = param1;
         validate(MINMAXCHANGE);
      }
      
      public function get moveState() : int
      {
         return _moveState;
      }
      
      public function set moveState(param1:int) : void
      {
         _moveState = param1;
      }
      
      public function get isCenter() : Boolean
      {
         return _isCenter;
      }
      
      public function set isCenter(param1:Boolean) : void
      {
         _isCenter = param1;
         validate(STYLE);
      }
      
      public function get canMove() : Boolean
      {
         return _canMove;
      }
      
      public function set canMove(param1:Boolean) : void
      {
         _canMove = param1;
         if(!_canMove)
         {
            removeEvent();
         }
         else
         {
            initEvent();
         }
      }
      
      public function get mcX() : int
      {
         return _mcX;
      }
      
      public function set mcX(param1:int) : void
      {
         _mcX = param1;
      }
      
      public function get mcY() : int
      {
         return _mcY;
      }
      
      public function set mcY(param1:int) : void
      {
         _mcY = param1;
      }
      
      public function get mcWidth() : int
      {
         if(_movieGroup)
         {
            return _movieGroup.groupWidth;
         }
         return 0;
      }
      
      public function set mcWidth(param1:int) : void
      {
         if(_movieGroup)
         {
            _movieGroup.groupWidth = param1;
         }
      }
      
      public function get mcHeight() : int
      {
         if(_movieGroup)
         {
            return _movieGroup.groupHeight;
         }
         return 0;
      }
      
      public function set mcHeight(param1:int) : void
      {
         if(_movieGroup)
         {
            _movieGroup.groupHeight = param1;
         }
      }
   }
}

