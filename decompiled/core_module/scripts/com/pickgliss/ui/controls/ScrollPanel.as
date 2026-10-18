package com.pickgliss.ui.controls
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.geom.IntDimension;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.geom.IntRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IViewprot;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ScrollPanel extends Component
   {
      
      public static const AUTO:int = 1;
      
      public static const OFF:int = 2;
      
      public static const ON:int = 0;
      
      public static const P_backgound:String = "backgound";
      
      public static const P_backgoundInnerRect:String = "backgoundInnerRect";
      
      public static const P_hScrollProxy:String = "hScrollProxy";
      
      public static const P_hScrollbar:String = "vScrollbar";
      
      public static const P_hScrollbarInnerRect:String = "hScrollbarInnerRect";
      
      public static const P_vScrollProxy:String = "vScrollProxy";
      
      public static const P_vScrollbar:String = "vScrollbar";
      
      public static const P_vScrollbarInnerRect:String = "vScrollbarInnerRect";
      
      public static const P_viewSource:String = "viewSource";
      
      public static const P_viewportInnerRect:String = "viewportInnerRect";
      
      protected var _backgound:DisplayObject;
      
      protected var _backgoundInnerRect:InnerRectangle;
      
      protected var _backgoundInnerRectString:String;
      
      protected var _backgoundStyle:String;
      
      protected var _hScrollProxy:int;
      
      protected var _hScrollbar:Scrollbar;
      
      protected var _hScrollbarInnerRect:InnerRectangle;
      
      protected var _hScrollbarInnerRectString:String;
      
      protected var _hScrollbarStyle:String;
      
      protected var _vScrollProxy:int;
      
      protected var _vScrollbar:Scrollbar;
      
      protected var _vScrollbarInnerRect:InnerRectangle;
      
      protected var _vScrollbarInnerRectString:String;
      
      protected var _vScrollbarStyle:String;
      
      protected var _viewSource:IViewprot;
      
      protected var _viewportInnerRect:InnerRectangle;
      
      protected var _viewportInnerRectString:String;
      
      public function ScrollPanel(param1:Boolean = true)
      {
         super();
         if(param1)
         {
            _viewSource = new DisplayObjectViewport();
            _viewSource.addStateListener(__onViewportStateChanged);
         }
      }
      
      public function set backgound(param1:DisplayObject) : void
      {
         if(_backgound == param1)
         {
            return;
         }
         if(_backgound)
         {
            ObjectUtils.disposeObject(_backgound);
         }
         _backgound = param1;
         onPropertiesChanged("backgound");
      }
      
      public function get backgound() : DisplayObject
      {
         return _backgound;
      }
      
      public function set backgoundInnerRectString(param1:String) : void
      {
         if(_backgoundInnerRectString == param1)
         {
            return;
         }
         _backgoundInnerRectString = param1;
         _backgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_backgoundInnerRectString));
         onPropertiesChanged("backgoundInnerRect");
      }
      
      public function get backgoundInnerRectString() : String
      {
         return _backgoundInnerRectString;
      }
      
      public function set backgoundStyle(param1:String) : void
      {
         if(_backgoundStyle == param1)
         {
            return;
         }
         _backgoundStyle = param1;
         backgound = ComponentFactory.Instance.creat(_backgoundStyle);
      }
      
      public function get backgoundStyle() : String
      {
         return _backgoundStyle;
      }
      
      public function get displayObjectViewport() : DisplayObjectViewport
      {
         return _viewSource as DisplayObjectViewport;
      }
      
      override public function dispose() : void
      {
         if(_vScrollbar)
         {
            _vScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_vScrollbar);
         }
         _vScrollbar = null;
         if(_hScrollbar)
         {
            _hScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_hScrollbar);
         }
         _hScrollbar = null;
         if(_backgound)
         {
            ObjectUtils.disposeObject(_backgound);
         }
         _backgound = null;
         if(_viewSource)
         {
            ObjectUtils.disposeObject(_viewSource);
         }
         _viewSource = null;
         removeEventListener("mouseWheel",__onMouseWheel);
         super.dispose();
      }
      
      public function getShowHScrollbarExtendHeight() : Number
      {
         var _loc1_:Rectangle = null;
         if(_height == 0 || _hScrollbarInnerRect == null)
         {
            return 0;
         }
         var _loc2_:Rectangle = _viewportInnerRect.getInnerRect(_width,_height);
         var _loc3_:Rectangle = _hScrollbarInnerRect.getInnerRect(_width,_height);
         _loc1_ = _loc2_.union(_loc3_);
         return _loc2_.height - _loc1_.height;
      }
      
      public function getVisibleRect() : IntRectangle
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:IntDimension = _viewSource.getViewSize();
         if(_hScrollbar == null)
         {
            _loc5_ = 0;
            _loc4_ = _loc2_.width;
         }
         else
         {
            _loc5_ = _hScrollbar.scrollValue;
            _loc4_ = _hScrollbar.visibleAmount;
         }
         if(_vScrollbar == null)
         {
            _loc3_ = 0;
            _loc1_ = _loc2_.height;
         }
         else
         {
            _loc3_ = _vScrollbar.scrollValue;
            _loc1_ = _vScrollbar.visibleAmount;
         }
         return new IntRectangle(_loc5_,_loc3_,_loc4_,_loc1_);
      }
      
      public function set hScrollProxy(param1:int) : void
      {
         if(_hScrollProxy == param1)
         {
            return;
         }
         _hScrollProxy = param1;
         onPropertiesChanged("hScrollProxy");
      }
      
      public function get hScrollProxy() : int
      {
         return _hScrollProxy;
      }
      
      public function get hScrollbar() : Scrollbar
      {
         return _hScrollbar;
      }
      
      public function set hScrollbar(param1:Scrollbar) : void
      {
         if(_hScrollbar == param1)
         {
            return;
         }
         if(_hScrollbar)
         {
            _hScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_hScrollbar);
         }
         _hScrollbar = param1;
         _hScrollbar.addStateListener(__onScrollValueChange);
         onPropertiesChanged("vScrollbar");
      }
      
      public function set hScrollbarInnerRectString(param1:String) : void
      {
         if(_hScrollbarInnerRectString == param1)
         {
            return;
         }
         _hScrollbarInnerRectString = param1;
         _hScrollbarInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_hScrollbarInnerRectString));
         onPropertiesChanged("hScrollbarInnerRect");
      }
      
      public function get hScrollbarInnerRectString() : String
      {
         return _hScrollbarInnerRectString;
      }
      
      public function set hScrollbarStyle(param1:String) : void
      {
         if(_hScrollbarStyle == param1)
         {
            return;
         }
         _hScrollbarStyle = param1;
         hScrollbar = ComponentFactory.Instance.creat(_hScrollbarStyle);
      }
      
      public function get hScrollbarStyle() : String
      {
         return _hScrollbarStyle;
      }
      
      public function set hUnitIncrement(param1:int) : void
      {
         _viewSource.horizontalUnitIncrement = param1;
      }
      
      public function invalidateViewport(param1:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IntPoint = null;
         if(_viewSource is DisplayObjectViewport)
         {
            if(param1)
            {
               displayObjectViewport.invalidateView();
               _loc3_ = viewPort.getViewSize().height;
               _loc2_ = new IntPoint(0,_loc3_);
               viewPort.viewPosition = _loc2_;
            }
            else
            {
               displayObjectViewport.invalidateView();
            }
         }
      }
      
      public function setView(param1:DisplayObject, param2:Boolean = false) : void
      {
         if(_viewSource is DisplayObjectViewport)
         {
            displayObjectViewport.setView(param1);
            if(param2)
            {
               displayObjectViewport.mouseEnabled = false;
            }
         }
      }
      
      public function set vScrollProxy(param1:int) : void
      {
         if(_vScrollProxy == param1)
         {
            return;
         }
         _vScrollProxy = param1;
         onPropertiesChanged("vScrollProxy");
      }
      
      public function get vScrollProxy() : int
      {
         return _vScrollProxy;
      }
      
      public function get vScrollbar() : Scrollbar
      {
         return _vScrollbar;
      }
      
      public function set vScrollbar(param1:Scrollbar) : void
      {
         if(_vScrollbar == param1)
         {
            return;
         }
         if(_vScrollbar)
         {
            _vScrollbar.removeStateListener(__onScrollValueChange);
            ObjectUtils.disposeObject(_vScrollbar);
         }
         _vScrollbar = param1;
         _vScrollbar.addStateListener(__onScrollValueChange);
         onPropertiesChanged("vScrollbar");
      }
      
      public function set vScrollbarInnerRectString(param1:String) : void
      {
         if(_vScrollbarInnerRectString == param1)
         {
            return;
         }
         _vScrollbarInnerRectString = param1;
         _vScrollbarInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_vScrollbarInnerRectString));
         onPropertiesChanged("vScrollbarInnerRect");
      }
      
      public function get vScrollbarInnerRectString() : String
      {
         return _vScrollbarInnerRectString;
      }
      
      public function set vScrollbarStyle(param1:String) : void
      {
         if(_vScrollbarStyle == param1)
         {
            return;
         }
         _vScrollbarStyle = param1;
         vScrollbar = ComponentFactory.Instance.creat(_vScrollbarStyle);
      }
      
      public function get vScrollbarStyle() : String
      {
         return _vScrollbarStyle;
      }
      
      public function set vUnitIncrement(param1:int) : void
      {
         _viewSource.verticalUnitIncrement = param1;
      }
      
      public function get viewPort() : IViewprot
      {
         return _viewSource;
      }
      
      public function set viewPort(param1:IViewprot) : void
      {
         if(_viewSource == param1)
         {
            return;
         }
         if(_viewSource)
         {
            _viewSource.removeStateListener(__onViewportStateChanged);
            ObjectUtils.disposeObject(_viewSource);
         }
         _viewSource = param1;
         _viewSource.addStateListener(__onViewportStateChanged);
         onPropertiesChanged("viewSource");
      }
      
      public function set viewportInnerRectString(param1:String) : void
      {
         if(_viewportInnerRectString == param1)
         {
            return;
         }
         _viewportInnerRectString = param1;
         _viewportInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_viewportInnerRectString));
         onPropertiesChanged("viewportInnerRect");
      }
      
      public function get viewportInnerRectString() : String
      {
         return _viewportInnerRectString;
      }
      
      protected function __onMouseWheel(param1:MouseEvent) : void
      {
         var _loc2_:IntPoint = _viewSource.viewPosition.clone();
         _loc2_.y -= param1.delta * _viewSource.verticalUnitIncrement;
         _viewSource.viewPosition = _loc2_;
      }
      
      public function scrollToTop() : void
      {
         var _loc1_:IntPoint = new IntPoint();
         _viewSource.viewPosition = _loc1_;
      }
      
      protected function __onScrollValueChange(param1:InteractiveEvent) : void
      {
         viewPort.scrollRectToVisible(getVisibleRect());
      }
      
      protected function __onViewportStateChanged(param1:InteractiveEvent) : void
      {
         syncScrollPaneWithViewport();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_backgound)
         {
            addChild(_backgound);
         }
         if(_viewSource)
         {
            addChild(_viewSource.asDisplayObject());
         }
         if(_vScrollbar)
         {
            addChild(_vScrollbar);
         }
         if(_hScrollbar)
         {
            addChild(_hScrollbar);
         }
      }
      
      override protected function init() : void
      {
         initEvent();
         super.init();
      }
      
      protected function initEvent() : void
      {
         addEventListener("mouseWheel",__onMouseWheel);
      }
      
      protected function layoutComponent() : void
      {
         if(_vScrollbar)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_vScrollbar,_vScrollbarInnerRect,_width,_height);
         }
         if(_hScrollbar)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_hScrollbar,_hScrollbarInnerRect,_width,_height);
         }
         if(_backgound)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_backgound,_backgoundInnerRect,_width,_height);
         }
         if(_viewSource)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_viewSource.asDisplayObject(),_viewportInnerRect,_width,_height);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["vScrollbarInnerRect"] || _changedPropeties["hScrollbarInnerRect"] || _changedPropeties["vScrollbar"] || _changedPropeties["vScrollbar"] || _changedPropeties["viewportInnerRect"] || _changedPropeties["viewSource"])
         {
            layoutComponent();
         }
         if(_changedPropeties["viewSource"])
         {
            syncScrollPaneWithViewport();
         }
         if(_changedPropeties["vScrollProxy"] || _changedPropeties["hScrollProxy"])
         {
            if(_vScrollbar)
            {
               _vScrollbar.visible = _vScrollProxy == 0;
            }
            if(_hScrollbar)
            {
               _hScrollbar.visible = _hScrollProxy == 0;
            }
         }
      }
      
      protected function syncScrollPaneWithViewport() : void
      {
         var _loc3_:IntDimension = null;
         var _loc1_:IntDimension = null;
         var _loc5_:IntPoint = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         if(_viewSource != null)
         {
            _loc3_ = _viewSource.getExtentSize();
            if(_loc3_.width <= 0 || _loc3_.height <= 0)
            {
               return;
            }
            _loc1_ = _viewSource.getViewSize();
            _loc5_ = _viewSource.viewPosition;
            if(_vScrollbar != null)
            {
               _loc2_ = _loc3_.height;
               _loc4_ = _loc1_.height;
               _loc6_ = Math.max(0,Math.min(_loc5_.y,_loc4_ - _loc2_));
               _vScrollbar.unitIncrement = _viewSource.verticalUnitIncrement;
               _vScrollbar.blockIncrement = _viewSource.verticalBlockIncrement;
               _vScrollbar.getModel().setRangeProperties(_loc6_,_loc2_,0,_loc4_,false);
            }
            if(_hScrollbar != null)
            {
               _loc2_ = _loc3_.width;
               _loc4_ = _loc1_.width;
               _loc6_ = Math.max(0,Math.min(_loc5_.x,_loc4_ - _loc2_));
               _hScrollbar.unitIncrement = _viewSource.horizontalUnitIncrement;
               _hScrollbar.blockIncrement = _viewSource.horizontalBlockIncrement;
               _hScrollbar.getModel().setRangeProperties(_loc6_,_loc2_,0,_loc4_,false);
            }
            updateAutoHiddenScroll();
         }
      }
      
      private function updateAutoHiddenScroll() : void
      {
         var _loc1_:Rectangle = null;
         var _loc3_:Rectangle = null;
         var _loc2_:Rectangle = null;
         var _loc4_:Rectangle = null;
         if(_vScrollbar == null && _hScrollbar == null)
         {
            return;
         }
         if(_vScrollbar != null)
         {
            if(_vScrollProxy == 1)
            {
               _vScrollbar.visible = _vScrollbar.getThumbVisible();
            }
            if(_vScrollProxy == 1 && _vScrollbar.maximum == 0)
            {
               _vScrollbar.visible = false;
            }
         }
         if(_hScrollbar)
         {
            if(_hScrollProxy == 1)
            {
               _hScrollbar.visible = _hScrollbar.getThumbVisible();
            }
            if(_hScrollProxy == 1 && _hScrollbar.maximum == 0)
            {
               _hScrollbar.visible = false;
            }
         }
         if(_vScrollProxy == 1 || _hScrollProxy == 1)
         {
            _loc3_ = _viewportInnerRect.getInnerRect(_width,_height);
            if(_vScrollbarInnerRect)
            {
               _loc2_ = _vScrollbarInnerRect.getInnerRect(_width,_height);
            }
            if(_hScrollbarInnerRect)
            {
               _loc4_ = _hScrollbarInnerRect.getInnerRect(_width,_height);
            }
            if(_vScrollbar != null)
            {
               if(!_vScrollbar.getThumbVisible() || _vScrollbar.visible == false)
               {
                  _loc1_ = _loc3_.union(_loc2_);
               }
            }
            if(_hScrollbar != null)
            {
               if(!_hScrollbar.getThumbVisible() || _hScrollbar.visible == false)
               {
                  if(_loc1_)
                  {
                     _loc1_ = _loc1_.union(_loc4_);
                  }
                  else
                  {
                     _loc1_ = _loc3_.union(_loc4_);
                  }
               }
            }
            if(_loc1_ == null)
            {
               _loc1_ = _loc3_;
            }
            _viewSource.x = _loc1_.x;
            _viewSource.y = _loc1_.y;
            _viewSource.width = _loc1_.width;
            _viewSource.height = _loc1_.height;
         }
      }
   }
}

