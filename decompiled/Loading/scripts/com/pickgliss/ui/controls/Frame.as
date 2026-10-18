package com.pickgliss.ui.controls
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.geom.OuterRectPos;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class Frame extends Component
   {
      
      public static const P_backgound:String = "backgound";
      
      public static const P_closeButton:String = "closeButton";
      
      public static const P_closeButton_Enable:String = "P_closeButton_Enable";
      
      public static const P_closeInnerRect:String = "closeInnerRect";
      
      public static const P_containerX:String = "containerX";
      
      public static const P_containerY:String = "containerY";
      
      public static const P_disposeChildren:String = "disposeChildren";
      
      public static const P_moveEnable:String = "moveEnable";
      
      public static const P_moveInnerRect:String = "moveInnerRect";
      
      public static const P_title:String = "title";
      
      public static const P_titleText:String = "titleText";
      
      public static var closeSoundFunc:Function;
      
      public static var submitSoundFunc:Function;
      
      private static var _openCount:int = 0;
      
      public static const P_titleOuterRectPos:String = "titleOuterRectPos";
      
      public static const P_escEnable:String = "escEnable";
      
      public static const P_enterEnable:String = "enterEnable";
      
      public var frameType:uint;
      
      protected var _backStyle:String;
      
      protected var _backgound:DisplayObject;
      
      protected var _closeButton:BaseButton;
      
      protected var _closeButtonEnable:Boolean;
      
      protected var _closeInnerRect:InnerRectangle;
      
      protected var _closeInnerRectString:String;
      
      protected var _closestyle:String;
      
      protected var _container:Sprite;
      
      protected var _containerPosString:String;
      
      protected var _containerX:Number;
      
      protected var _containerY:Number;
      
      protected var _moveEnable:Boolean;
      
      protected var _moveInnerRect:InnerRectangle;
      
      protected var _moveInnerRectString:String = "";
      
      protected var _moveRect:Sprite;
      
      protected var _title:TextField;
      
      protected var _titleStyle:String;
      
      protected var _titleText:String = "";
      
      protected var _disposeChildren:Boolean = true;
      
      protected var _titleOuterRectPosString:String;
      
      protected var _titleOuterRectPos:OuterRectPos;
      
      protected var _escEnable:Boolean;
      
      protected var _enterEnable:Boolean;
      
      public function Frame()
      {
         super();
         addEventListener("addedToStage",__onAddToStage);
         addEventListener("mouseDown",__onMouseClickSetFocus);
      }
      
      public static function get hasOpenFrame() : Boolean
      {
         return _openCount > 0;
      }
      
      public static function set hasOpenFrame(param1:Boolean) : void
      {
         param1 ? _openCount++ : int(_openCount--);
         _openCount < 0 ? (_openCount = 0) : _openCount;
      }
      
      protected function __onMouseClickSetFocus(param1:MouseEvent) : void
      {
         StageReferance.stage.focus = param1.target as InteractiveObject;
      }
      
      public function addToContent(param1:DisplayObject) : void
      {
         _container.addChild(param1);
      }
      
      public function addToContentAt(param1:DisplayObject, param2:int) : void
      {
         _container.addChildAt(param1,param2);
      }
      
      public function set backStyle(param1:String) : void
      {
         if(_backStyle == param1)
         {
            return;
         }
         _backStyle = param1;
         backgound = ComponentFactory.Instance.creat(_backStyle);
      }
      
      public function get backStyle() : String
      {
         return _backStyle;
      }
      
      public function set backgound(param1:DisplayObject) : void
      {
         if(_backgound == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_backgound);
         _backgound = param1;
         if(_backgound is InteractiveObject)
         {
            InteractiveObject(_backgound).mouseEnabled = true;
         }
         onPropertiesChanged("backgound");
      }
      
      public function get closeButton() : BaseButton
      {
         return _closeButton;
      }
      
      public function set closeButton(param1:BaseButton) : void
      {
         if(_closeButton == param1)
         {
            return;
         }
         if(_closeButton)
         {
            _closeButton.removeEventListener("click",__onCloseClick);
         }
         ObjectUtils.disposeObject(_closeButton);
         _closeButton = param1;
         onPropertiesChanged("closeButton");
      }
      
      public function set closeInnerRectString(param1:String) : void
      {
         if(_closeInnerRectString == param1)
         {
            return;
         }
         _closeInnerRectString = param1;
         _closeInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_closeInnerRectString));
         onPropertiesChanged("closeInnerRect");
      }
      
      public function get closeInnerRectString() : String
      {
         return _closeInnerRectString;
      }
      
      public function set closestyle(param1:String) : void
      {
         if(_closestyle == param1)
         {
            return;
         }
         _closestyle = param1;
         closeButton = ComponentFactory.Instance.creat(_closestyle);
      }
      
      public function get closestyle() : String
      {
         return _closestyle;
      }
      
      public function set containerX(param1:Number) : void
      {
         if(_containerX == param1)
         {
            return;
         }
         _containerX = param1;
         onPropertiesChanged("containerX");
      }
      
      public function get containerX() : Number
      {
         return _containerX;
      }
      
      public function set containerY(param1:Number) : void
      {
         if(_containerY == param1)
         {
            return;
         }
         _containerY = param1;
         onPropertiesChanged("containerY");
      }
      
      public function get containerY() : Number
      {
         return _containerY;
      }
      
      public function set titleOuterRectPosString(param1:String) : void
      {
         if(_titleOuterRectPosString == param1)
         {
            return;
         }
         _titleOuterRectPosString = param1;
         _titleOuterRectPos = ClassUtils.CreatInstance("com.pickgliss.geom.OuterRectPos",ComponentFactory.parasArgs(_titleOuterRectPosString));
         onPropertiesChanged("titleOuterRectPos");
      }
      
      public function get titleOuterRectPosString() : String
      {
         return _titleOuterRectPosString;
      }
      
      override public function dispose() : void
      {
         var _loc1_:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(_loc1_ && contains(_loc1_))
         {
            StageReferance.stage.focus = null;
         }
         StageReferance.stage.removeEventListener("mouseUp",__onFrameMoveStop);
         StageReferance.stage.removeEventListener("mouseMove",__onMoveWindow);
         removeEventListener("keyDown",__onKeyDown);
         removeEventListener("mouseDown",__onMouseClickSetFocus);
         removeEventListener("addedToStage",__onAddToStage);
         if(stage)
         {
            hasOpenFrame = false;
         }
         if(_backgound)
         {
            ObjectUtils.disposeObject(_backgound);
         }
         _backgound = null;
         if(_closeButton)
         {
            _closeButton.removeEventListener("click",__onCloseClick);
            ObjectUtils.disposeObject(_closeButton);
         }
         _closeButton = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_disposeChildren)
         {
            ObjectUtils.disposeAllChildren(_container);
         }
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         if(_moveRect)
         {
            _moveRect.removeEventListener("mouseDown",__onFrameMoveStart);
         }
         ObjectUtils.disposeObject(_moveRect);
         _moveRect = null;
         super.dispose();
      }
      
      public function get disposeChildren() : Boolean
      {
         return _disposeChildren;
      }
      
      public function set disposeChildren(param1:Boolean) : void
      {
         if(_disposeChildren == param1)
         {
            return;
         }
         _disposeChildren = param1;
         onPropertiesChanged("disposeChildren");
      }
      
      public function set moveEnable(param1:Boolean) : void
      {
         if(_moveEnable == param1)
         {
            return;
         }
         _moveEnable = param1;
         onPropertiesChanged("moveEnable");
      }
      
      public function set moveInnerRectString(param1:String) : void
      {
         if(_moveInnerRectString == param1)
         {
            return;
         }
         _moveInnerRectString = param1;
         _moveInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_moveInnerRectString));
         onPropertiesChanged("moveInnerRect");
      }
      
      public function get moveInnerRectString() : String
      {
         return _moveInnerRectString;
      }
      
      public function set title(param1:TextField) : void
      {
         if(_title == param1)
         {
            return;
         }
         _title = param1;
         onPropertiesChanged("title");
      }
      
      public function set titleStyle(param1:String) : void
      {
         if(_titleStyle == param1)
         {
            return;
         }
         _titleStyle = param1;
         title = ComponentFactory.Instance.creat(_titleStyle);
      }
      
      public function get titleStyle() : String
      {
         return _titleStyle;
      }
      
      public function set titleText(param1:String) : void
      {
         if(_titleText == param1)
         {
            return;
         }
         _titleText = param1;
         onPropertiesChanged("titleText");
      }
      
      public function get titleText() : String
      {
         return _titleText;
      }
      
      protected function __onAddToStage(param1:Event) : void
      {
         hasOpenFrame = true;
         if(!checkInputTxt())
         {
            stage.focus = this;
         }
      }
      
      private function checkInputTxt() : Boolean
      {
         if(!StageReferance.stage)
         {
            return false;
         }
         var _loc1_:FilterFrameText = StageReferance.stage.focus as FilterFrameText;
         if(_loc1_ && _loc1_.type == "input")
         {
            return true;
         }
         return false;
      }
      
      protected function __onCloseClick(param1:MouseEvent) : void
      {
         if(closeSoundFunc is Function)
         {
            closeSoundFunc();
         }
         onResponse(0);
      }
      
      protected function __onKeyDown(param1:KeyboardEvent) : void
      {
         if(!StageReferance.keyBoardEnable)
         {
            return;
         }
         var _loc2_:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(DisplayUtils.isTargetOrContain(_loc2_,this))
         {
            if(param1.keyCode == 13 && enterEnable)
            {
               submitSoundFunc();
               if(_loc2_ is TextField && TextField(_loc2_).type == "input" && Boolean(TextField(_loc2_).multiline))
               {
                  return;
               }
               onResponse(2);
               param1.stopImmediatePropagation();
            }
            else if(param1.keyCode == 27 && escEnable)
            {
               closeSoundFunc();
               onResponse(1);
               param1.stopImmediatePropagation();
            }
         }
      }
      
      public function set escEnable(param1:Boolean) : void
      {
         if(_escEnable == param1)
         {
            return;
         }
         _escEnable = param1;
         onPropertiesChanged("escEnable");
      }
      
      public function get escEnable() : Boolean
      {
         return _escEnable;
      }
      
      public function set enterEnable(param1:Boolean) : void
      {
         if(_enterEnable == param1)
         {
            return;
         }
         _enterEnable = param1;
         onPropertiesChanged("enterEnable");
      }
      
      public function get enterEnable() : Boolean
      {
         return _enterEnable;
      }
      
      protected function onResponse(param1:int, param2:Boolean = true) : void
      {
         dispatchEvent(new FrameEvent(param1,param2));
      }
      
      protected function __onFrameMoveStart(param1:MouseEvent) : void
      {
         StageReferance.stage.addEventListener("mouseMove",__onMoveWindow);
         StageReferance.stage.addEventListener("mouseUp",__onFrameMoveStop);
         startDrag();
      }
      
      protected function __onFrameMoveStop(param1:MouseEvent) : void
      {
         dispatchEvent(new ComponentEvent("FRAME_MOVE_COMPLETE"));
         StageReferance.stage.removeEventListener("mouseUp",__onFrameMoveStop);
         StageReferance.stage.removeEventListener("mouseMove",__onMoveWindow);
         stopDrag();
      }
      
      override protected function addChildren() : void
      {
         if(_backgound)
         {
            addChild(_backgound);
         }
         addChild(_container);
         if(_title)
         {
            addChild(_title);
         }
         addChild(_moveRect);
         if(_closeButton)
         {
            addChild(_closeButton);
         }
      }
      
      override protected function init() : void
      {
         if(_container == null)
         {
            _container = new Sprite();
         }
         if(_moveRect == null)
         {
            _moveRect = new Sprite();
         }
         super.init();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if((_changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["backgound"]) && _backgound != null)
         {
            _backgound.width = _width;
            _backgound.height = _height;
            updateClosePos();
         }
         if(_changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["moveInnerRect"])
         {
            updateMoveRect();
         }
         if(_changedPropeties["closeButton"])
         {
            _closeButton.addEventListener("click",__onCloseClick);
         }
         if(_changedPropeties["closeButton"] || _changedPropeties["closeInnerRect"])
         {
            updateClosePos();
         }
         if(_changedPropeties["containerX"] || _changedPropeties["containerY"])
         {
            updateContainerPos();
         }
         if(_changedPropeties["titleOuterRectPos"] || _changedPropeties["titleText"] || _changedPropeties["height"] || _changedPropeties["width"])
         {
            if(_title != null)
            {
               _title.text = _titleText;
            }
            updateTitlePos();
         }
         if(_changedPropeties["moveEnable"])
         {
            if(_moveEnable)
            {
               _moveRect.addEventListener("mouseDown",__onFrameMoveStart);
            }
            else
            {
               _moveRect.removeEventListener("mouseDown",__onFrameMoveStart);
            }
         }
         if(_changedPropeties["P_closeButton_Enable"])
         {
            if(_closeButton)
            {
               _closeButton.enable = _closeButtonEnable;
            }
         }
         if(_escEnable || _enterEnable)
         {
            addEventListener("keyDown",__onKeyDown);
         }
         else
         {
            removeEventListener("keyDown",__onKeyDown);
         }
      }
      
      protected function updateClosePos() : void
      {
         if(_closeButton && _closeInnerRect)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_closeButton,_closeInnerRect,_width,_height);
         }
      }
      
      protected function updateContainerPos() : void
      {
         _container.x = _containerX;
         _container.y = _containerY;
      }
      
      protected function updateMoveRect() : void
      {
         if(_moveInnerRect == null)
         {
            return;
         }
         var _loc1_:Rectangle = _moveInnerRect.getInnerRect(_width,_height);
         _moveRect.graphics.clear();
         _moveRect.graphics.beginFill(0,0);
         _moveRect.graphics.drawRect(_loc1_.x,_loc1_.y,_loc1_.width,_loc1_.height);
         _moveRect.graphics.endFill();
      }
      
      protected function updateTitlePos() : void
      {
         if(_title == null)
         {
            return;
         }
         if(_titleOuterRectPos == null)
         {
            return;
         }
         var _loc1_:Point = _titleOuterRectPos.getPos(_title.width,_title.height,_width,_height);
         _title.x = _loc1_.x;
         _title.y = _loc1_.y;
      }
      
      protected function __onMoveWindow(param1:MouseEvent) : void
      {
         if(!DisplayUtils.isInTheStage(new Point(param1.localX,param1.localY),this))
         {
            __onFrameMoveStop(null);
         }
      }
      
      public function get closeButtonEnable() : Boolean
      {
         return _closeButtonEnable;
      }
      
      public function set closeButtonEnable(param1:Boolean) : void
      {
         _closeButtonEnable = param1;
         onPropertiesChanged("P_closeButton_Enable");
      }
   }
}

