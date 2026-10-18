package com.pickgliss.ui.controls.list
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntDimension;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.geom.IntRectangle;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.cell.IListCellFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.IViewprot;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   [Event(name="listItemClick",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemDoubleclick",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemMouseDown",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemMouseUp",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemRollOver",type="com.pickgliss.events.ListItemEvent")]
   [Event(name="listItemRollOut",type="com.pickgliss.events.ListItemEvent")]
   public class List extends Component implements IViewprot, ListDataListener
   {
      
      public static const AUTO_INCREMENT:int = -2147483648;
      
      public static const P_cellFactory:String = "cellFactory";
      
      public static const P_horizontalBlockIncrement:String = "horizontalBlockIncrement";
      
      public static const P_horizontalUnitIncrement:String = "horizontalUnitIncrement";
      
      public static const P_model:String = "model";
      
      public static const P_verticalBlockIncrement:String = "verticalBlockIncrement";
      
      public static const P_verticalUnitIncrement:String = "verticalUnitIncrement";
      
      public static const P_viewPosition:String = "viewPosition";
      
      public static const P_viewSize:String = "viewSize";
      
      protected var _cells:Vector.<IListCell>;
      
      protected var _cellsContainer:Sprite;
      
      protected var _factory:IListCellFactory;
      
      protected var _firstVisibleIndex:int;
      
      protected var _firstVisibleIndexOffset:int;
      
      protected var _horizontalBlockIncrement:int = ComponentSetting.SCROLL_BLOCK_INCREMENT;
      
      protected var _horizontalUnitIncrement:int = ComponentSetting.SCROLL_UINT_INCREMENT;
      
      protected var _lastVisibleIndex:int;
      
      protected var _lastVisibleIndexOffset:int;
      
      protected var _maskShape:Shape;
      
      protected var _model:IListModel;
      
      protected var _mouseActiveObjectShape:Shape;
      
      protected var _verticalBlockIncrement:int = ComponentSetting.SCROLL_BLOCK_INCREMENT;
      
      protected var _verticalUnitIncrement:int = ComponentSetting.SCROLL_UINT_INCREMENT;
      
      protected var _viewHeight:int;
      
      protected var _viewPosition:IntPoint;
      
      protected var _viewWidth:int;
      
      protected var _viewWidthNoCount:int;
      
      protected var _visibleCellWidth:int;
      
      protected var _visibleRowCount:int;
      
      protected var _currentSelectedIndex:int = -1;
      
      public function List()
      {
         super();
      }
      
      public function addStateListener(param1:Function, param2:int = 0, param3:Boolean = false) : void
      {
         addEventListener("stateChange",param1,false,param2);
      }
      
      public function get cellFactory() : IListCellFactory
      {
         return _factory;
      }
      
      public function set cellFactory(param1:IListCellFactory) : void
      {
         if(_factory == param1)
         {
            return;
         }
         _factory = param1;
         onPropertiesChanged("cellFactory");
      }
      
      public function contentsChanged(param1:ListDataEvent) : void
      {
         if(param1.getIndex0() >= _firstVisibleIndex && param1.getIndex0() <= _lastVisibleIndex || param1.getIndex1() >= _firstVisibleIndex && param1.getIndex1() <= _lastVisibleIndex || _lastVisibleIndex == -1)
         {
            updateListView();
         }
      }
      
      override public function dispose() : void
      {
         _mouseActiveObjectShape.graphics.clear();
         _mouseActiveObjectShape = null;
         _maskShape.graphics.clear();
         _maskShape = null;
         removeAllCell();
         _cells = null;
         if(_model)
         {
            _model.removeListDataListener(this);
         }
         _model = null;
         super.dispose();
      }
      
      public function getExtentSize() : IntDimension
      {
         return new IntDimension(_width,_height);
      }
      
      public function getViewSize() : IntDimension
      {
         return new IntDimension(_viewWidth,_viewHeight);
      }
      
      public function getViewportPane() : Component
      {
         return this;
      }
      
      public function get horizontalBlockIncrement() : int
      {
         return _horizontalBlockIncrement;
      }
      
      public function set horizontalBlockIncrement(param1:int) : void
      {
         if(_horizontalBlockIncrement == param1)
         {
            return;
         }
         _horizontalBlockIncrement = param1;
         onPropertiesChanged("horizontalBlockIncrement");
      }
      
      public function get horizontalUnitIncrement() : int
      {
         return _horizontalUnitIncrement;
      }
      
      public function set horizontalUnitIncrement(param1:int) : void
      {
         if(_horizontalUnitIncrement == param1)
         {
            return;
         }
         _horizontalUnitIncrement = param1;
         onPropertiesChanged("horizontalUnitIncrement");
      }
      
      public function intervalAdded(param1:ListDataEvent) : void
      {
         refreshViewSize();
         onPropertiesChanged("viewSize");
         if(param1.getIndex1() <= _lastVisibleIndex || _lastVisibleIndex == -1 || _viewHeight < _height)
         {
            updateListView();
         }
      }
      
      public function intervalRemoved(param1:ListDataEvent) : void
      {
         refreshViewSize();
         onPropertiesChanged("viewSize");
         if(param1.getIndex1() <= _lastVisibleIndex || _lastVisibleIndex == -1 || _viewHeight < _height)
         {
            updateListView();
         }
      }
      
      public function isSelectedIndex(param1:int) : Boolean
      {
         return _currentSelectedIndex == param1;
      }
      
      public function get model() : IListModel
      {
         return _model;
      }
      
      public function set model(param1:IListModel) : void
      {
         if(param1 != model)
         {
            if(_model)
            {
               _model.removeListDataListener(this);
            }
            _model = param1;
            _model.addListDataListener(this);
            onPropertiesChanged("model");
         }
      }
      
      public function removeStateListener(param1:Function) : void
      {
         removeEventListener("stateChange",param1);
      }
      
      public function scrollRectToVisible(param1:IntRectangle) : void
      {
         viewPosition = new IntPoint(param1.x,param1.y);
      }
      
      public function scrollToIndex(param1:int) : void
      {
         if(param1 < 0 || param1 >= model.getSize())
         {
            return;
         }
         var _loc2_:IntPoint = new IntPoint();
         _loc2_.x = 0;
         _loc2_.y = param1 * _factory.getCellHeight();
         viewPosition = _loc2_;
      }
      
      public function setListData(param1:Array) : void
      {
         var _loc2_:IListModel = new VectorListModel(param1);
         model = _loc2_;
      }
      
      public function setViewportTestSize(param1:IntDimension) : void
      {
      }
      
      public function updateListView() : void
      {
         if(_factory == null)
         {
            return;
         }
         createCells();
         updateShowMask();
         updatePos();
      }
      
      public function get verticalBlockIncrement() : int
      {
         return _verticalBlockIncrement;
      }
      
      public function set verticalBlockIncrement(param1:int) : void
      {
         if(_verticalBlockIncrement == param1)
         {
            return;
         }
         _verticalBlockIncrement = param1;
         onPropertiesChanged("verticalBlockIncrement");
      }
      
      public function get verticalUnitIncrement() : int
      {
         return _verticalUnitIncrement;
      }
      
      public function set verticalUnitIncrement(param1:int) : void
      {
         if(_verticalUnitIncrement == param1)
         {
            return;
         }
         _verticalUnitIncrement = param1;
         onPropertiesChanged("verticalUnitIncrement");
      }
      
      public function get viewPosition() : IntPoint
      {
         return _viewPosition;
      }
      
      public function set viewPosition(param1:IntPoint) : void
      {
         if(_viewPosition.equals(restrictionViewPos(param1)))
         {
            return;
         }
         _viewPosition.setLocation(param1);
         onPropertiesChanged("viewPosition");
      }
      
      protected function __onItemInteractive(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:IListCell = param1.currentTarget as IListCell;
         var _loc2_:int = _model.indexOf(_loc4_.getCellValue());
         switch(param1.type)
         {
            case "click":
               _loc3_ = "listItemClick";
               _currentSelectedIndex = _loc2_;
               updateListView();
               break;
            case "doubleClick":
               _loc3_ = "listItemDoubleclick";
               break;
            case "mouseDown":
               _loc3_ = "listItemMouseDown";
               break;
            case "mouseUp":
               _loc3_ = "listItemMouseUp";
               break;
            case "rollOver":
               _loc3_ = "listItemRollOver";
               break;
            case "rollOut":
               _loc3_ = "listItemRollOut";
         }
         dispatchEvent(new ListItemEvent(_loc4_,_loc4_.getCellValue(),_loc3_,_loc2_,param1));
      }
      
      public function get currentSelectedIndex() : int
      {
         return _currentSelectedIndex;
      }
      
      protected function addCellToContainer(param1:IListCell) : void
      {
         param1.addEventListener("click",__onItemInteractive);
         param1.addEventListener("mouseDown",__onItemInteractive);
         param1.addEventListener("mouseUp",__onItemInteractive);
         param1.addEventListener("rollOver",__onItemInteractive);
         param1.addEventListener("rollOut",__onItemInteractive);
         param1.addEventListener("doubleClick",__onItemInteractive);
         _cells.push(_cellsContainer.addChild(param1.asDisplayObject()));
      }
      
      public function set updateItemWidth(param1:int) : void
      {
         for each(var _loc2_:Object in _cells)
         {
            _loc2_["updateItemWidth"] = param1;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_mouseActiveObjectShape);
         addChild(_maskShape);
         addChild(_cellsContainer);
      }
      
      protected function creatMaskShape() : void
      {
         _maskShape = new Shape();
         _maskShape.graphics.beginFill(16711680,1);
         _maskShape.graphics.drawRect(0,0,100,100);
         _maskShape.graphics.endFill();
         _mouseActiveObjectShape = new Shape();
         _mouseActiveObjectShape.graphics.beginFill(16711680,0);
         _mouseActiveObjectShape.graphics.drawRect(0,0,100,100);
         _mouseActiveObjectShape.graphics.endFill();
      }
      
      protected function createCells() : void
      {
         if(_factory.isShareCells())
         {
            createCellsWhenShareCells();
         }
         else
         {
            createCellsWhenNotShareCells();
         }
      }
      
      protected function createCellsWhenNotShareCells() : void
      {
      }
      
      protected function createCellsWhenShareCells() : void
      {
         var _loc4_:int = 0;
         var _loc6_:IListCell = null;
         var _loc8_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = undefined;
         var _loc7_:int = _factory.getCellHeight();
         var _loc2_:int = Math.floor(_height / _loc7_) + 2;
         _viewWidth = _factory.getViewWidthNoCount();
         if(_factory.isAllCellHasSameHeight())
         {
            _viewHeight = _model.getSize() * _loc7_;
         }
         else
         {
            _viewHeight = _model.getAllCellHeight();
         }
         if(_cells.length == _loc2_)
         {
            return;
         }
         if(_cells.length < _loc2_)
         {
            _loc1_ = _loc2_ - _cells.length;
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc6_ = createNewCell();
               _loc8_ = Math.max(_loc6_.width,_loc8_);
               addCellToContainer(_loc6_);
               _loc4_++;
            }
         }
         else if(_cells.length > _loc2_)
         {
            _loc5_ = _loc2_;
            _loc3_ = _cells.splice(_loc5_,_cells.length - _loc5_);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               removeCellFromContainer(_loc3_[_loc4_]);
               _loc4_++;
            }
         }
      }
      
      protected function createNewCell() : IListCell
      {
         if(_factory == null)
         {
            return null;
         }
         return _factory.createNewCell();
      }
      
      protected function fireStateChanged(param1:Boolean = true) : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      protected function getListCellModelHeight(param1:int) : int
      {
         return 0;
      }
      
      protected function getViewMaxPos() : IntPoint
      {
         var _loc3_:IntDimension = getExtentSize();
         var _loc1_:IntDimension = getViewSize();
         var _loc2_:IntPoint = new IntPoint(_loc1_.width - _loc3_.width,_loc1_.height - _loc3_.height);
         if(_loc2_.x < 0)
         {
            _loc2_.x = 0;
         }
         if(_loc2_.y < 0)
         {
            _loc2_.y = 0;
         }
         return _loc2_;
      }
      
      override protected function init() : void
      {
         creatMaskShape();
         _cellsContainer = new Sprite();
         addChild(_cellsContainer);
         _viewPosition = new IntPoint(0,0);
         _firstVisibleIndex = 0;
         _lastVisibleIndex = -1;
         _firstVisibleIndexOffset = 0;
         _lastVisibleIndexOffset = 0;
         _visibleRowCount = -1;
         _visibleCellWidth = -1;
         _cells = new Vector.<IListCell>();
         super.init();
         _model = new VectorListModel();
         _model.addListDataListener(this);
      }
      
      protected function layoutWhenShareCellsHasNotSameHeight() : void
      {
         var _loc7_:int = 0;
         var _loc9_:IListCell = null;
         var _loc4_:int = 0;
         createCellsWhenShareCells();
         restrictionViewPos(_viewPosition);
         var _loc5_:int = _viewPosition.x;
         var _loc6_:int = _viewPosition.y;
         var _loc1_:int = _model.getStartIndexByPosY(_loc6_);
         var _loc8_:int = _model.getSize();
         var _loc2_:int = -_loc5_;
         var _loc3_:int = _height;
         if(_loc8_ < 0)
         {
            _lastVisibleIndex = -1;
         }
         _loc7_ = 0;
         while(_loc7_ < _cells.length)
         {
            _loc9_ = _cells[_loc7_];
            _loc4_ = _loc1_ + _loc7_;
            if(_loc4_ < _loc8_)
            {
               _loc9_.setCellValue(_model.getElementAt(_loc4_));
               _loc9_.setListCellStatus(this,isSelectedIndex(_loc4_),_loc4_);
               _loc9_.visible = true;
               _loc9_.x = _loc2_;
               _loc9_.y = _model.getCellPosFromIndex(_loc4_) - _loc6_;
               if(_loc9_.y < _loc3_)
               {
                  _lastVisibleIndex = _loc4_;
               }
            }
            else
            {
               _loc9_.visible = false;
            }
            _loc7_++;
         }
         _firstVisibleIndex = _loc1_;
      }
      
      protected function layoutWhenShareCellsHasSameHeight() : void
      {
         var _loc8_:int = 0;
         var _loc11_:IListCell = null;
         var _loc5_:int = 0;
         createCellsWhenShareCells();
         restrictionViewPos(_viewPosition);
         var _loc6_:int = _viewPosition.x;
         var _loc7_:int = _viewPosition.y;
         var _loc12_:int = _factory.getCellHeight();
         var _loc1_:int = Math.floor(_loc7_ / _loc12_);
         var _loc9_:int = _loc1_ * _loc12_ - _loc7_;
         var _loc10_:int = _model.getSize();
         var _loc2_:int = -_loc6_;
         var _loc3_:int = _loc9_;
         var _loc4_:int = _height;
         if(_loc10_ < 0)
         {
            _lastVisibleIndex = -1;
         }
         _loc8_ = 0;
         while(_loc8_ < _cells.length)
         {
            _loc11_ = _cells[_loc8_];
            _loc5_ = _loc1_ + _loc8_;
            if(_loc5_ < _loc10_)
            {
               _loc11_.setCellValue(_model.getElementAt(_loc5_));
               _loc11_.setListCellStatus(this,isSelectedIndex(_loc5_),_loc5_);
               _loc11_.visible = true;
               _loc11_.x = _loc2_;
               _loc11_.y = _loc3_;
               if(_loc3_ < _loc4_)
               {
                  _lastVisibleIndex = _loc5_;
               }
               _loc3_ += _loc12_;
            }
            else
            {
               _loc11_.visible = false;
            }
            _loc8_++;
         }
         _firstVisibleIndex = _loc1_;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         var _loc1_:Boolean = false;
         _cellsContainer.mask = _maskShape;
         if(_changedPropeties["model"] || _changedPropeties["cellFactory"] || _changedPropeties["viewPosition"] || _changedPropeties["width"] || _changedPropeties["height"])
         {
            if(_changedPropeties["cellFactory"])
            {
               removeAllCell();
            }
            _loc1_ = true;
         }
         if(_loc1_)
         {
            updateListView();
         }
         if(_changedPropeties["verticalBlockIncrement"] || _changedPropeties["verticalUnitIncrement"] || _changedPropeties["horizontalBlockIncrement"] || _changedPropeties["horizontalUnitIncrement"] || _changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["viewPosition"] || _changedPropeties["viewSize"])
         {
            fireStateChanged();
         }
      }
      
      protected function refreshViewSize() : void
      {
         if(_factory.isShareCells())
         {
            _viewWidth = _factory.getViewWidthNoCount();
            if(_factory.isAllCellHasSameHeight())
            {
               _viewHeight = _model.getSize() * _factory.getCellHeight();
            }
            else
            {
               _viewHeight = _model.getAllCellHeight();
            }
         }
      }
      
      protected function removeAllCell() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _cells.length)
         {
            removeCellFromContainer(_cells[_loc1_]);
            _loc1_++;
         }
         _cells = new Vector.<IListCell>();
      }
      
      public function set defaultSelectItemByCellValue(param1:*) : void
      {
         var _loc2_:int = _model.indexOf(param1);
         var _loc3_:IListCell = getItemByValue(param1);
         if(_loc3_ == null)
         {
            scrollToIndex(_loc2_);
            _loc3_ = getItemByValue(param1);
         }
         if(_loc3_ != null)
         {
            _currentSelectedIndex = _loc2_;
            _loc3_.dispatchEvent(new MouseEvent("click"));
            return;
         }
         dispatchEvent(new ListItemEvent(null,null,"listItemClick",-1));
      }
      
      public function getItemByValue(param1:Object) : IListCell
      {
         for each(var _loc2_:IListCell in _cells)
         {
            if(_loc2_.getCellValue() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      protected function removeCellFromContainer(param1:IListCell) : void
      {
         param1.removeEventListener("click",__onItemInteractive);
         param1.removeEventListener("mouseDown",__onItemInteractive);
         param1.removeEventListener("mouseUp",__onItemInteractive);
         param1.removeEventListener("rollOver",__onItemInteractive);
         param1.removeEventListener("rollOut",__onItemInteractive);
         param1.removeEventListener("doubleClick",__onItemInteractive);
         ObjectUtils.disposeObject(param1);
      }
      
      protected function restrictionViewPos(param1:IntPoint) : IntPoint
      {
         var _loc2_:IntPoint = getViewMaxPos();
         param1.x = Math.max(0,Math.min(_loc2_.x,param1.x));
         param1.y = Math.max(0,Math.min(_loc2_.y,param1.y));
         return param1;
      }
      
      protected function updatePos() : void
      {
         if(_factory.isShareCells())
         {
            if(_factory.isAllCellHasSameHeight())
            {
               layoutWhenShareCellsHasSameHeight();
            }
            else
            {
               layoutWhenShareCellsHasNotSameHeight();
            }
         }
      }
      
      protected function updateShowMask() : void
      {
         _mouseActiveObjectShape.width = _maskShape.width = _width;
         _mouseActiveObjectShape.height = _maskShape.height = _height;
      }
      
      public function get viewHeight() : Number
      {
         return _viewHeight;
      }
   }
}

