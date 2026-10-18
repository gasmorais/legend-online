package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import utils.LogicUtils;
   import yishi.view.community.PageListBaseCell;
   
   public class PageList extends Component
   {
      
      private var _xNum:int = 1;
      
      private var _yNum:int = 1;
      
      private var _xSpace:int = 0;
      
      private var _ySpace:int = 0;
      
      private var _renderStyle:String;
      
      private var _data:Array;
      
      private var _renderClass:Class;
      
      private var _pageSize:int = -1;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = -1;
      
      private var _selectIndex:int = -1;
      
      private var _cacheItems:Array = [];
      
      private var _showItems:Array = [];
      
      public var selectHandler:Function;
      
      public var updateCompleteHandler:Function;
      
      private var _pageSwitchTab:PageSwitchTab;
      
      private var _pageSwitchTabLink:String;
      
      public var selectedEnabled:Boolean = true;
      
      public function PageList()
      {
         super();
      }
      
      public function set xy(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         this.x = _loc2_[0];
         this.y = _loc2_[1];
      }
      
      public function get selectIndex() : int
      {
         return _selectIndex;
      }
      
      public function set selectIndex(param1:int) : void
      {
         if(_selectIndex != param1)
         {
            _selectIndex = param1;
            updateView();
         }
      }
      
      public function gotoNextPage() : void
      {
         _currentPage += 1;
         _currentPage = _currentPage > totalPage ? 1 : _currentPage;
         updateView();
      }
      
      public function gotoPreviousPage() : void
      {
         _currentPage -= 1;
         _currentPage = _currentPage < 1 ? totalPage : _currentPage;
         updateView();
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function get totalPage() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_totalPage == -1)
         {
            _loc1_ = int(_data.length);
            _loc2_ = _loc1_ / _pageSize;
            _totalPage = _loc1_ % _pageSize == 0 ? _loc2_ : _loc2_ + 1;
         }
         return _totalPage;
      }
      
      public function get pageStr() : String
      {
         return currentPage + "/" + totalPage;
      }
      
      public function set data(param1:Array) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         updateView();
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function refresh() : void
      {
         updateView();
      }
      
      public function set xNum(param1:int) : void
      {
         if(_xNum != param1)
         {
            _xNum = param1;
            _pageSize = _xNum * _yNum;
            _currentPage = 1;
            _totalPage = -1;
            updateView();
         }
      }
      
      public function set yNum(param1:int) : void
      {
         if(_yNum != param1)
         {
            _yNum = param1;
            _pageSize = _xNum * _yNum;
            _currentPage = 1;
            _totalPage = -1;
            updateView();
         }
      }
      
      public function set xyNum(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         this.xNum = _loc2_[0];
         this.yNum = _loc2_[1];
      }
      
      public function get pageSize() : int
      {
         return _pageSize;
      }
      
      public function set xSpace(param1:int) : void
      {
         if(_xSpace != param1)
         {
            _xSpace = param1;
            updateView();
         }
      }
      
      public function set ySpace(param1:int) : void
      {
         if(_ySpace != param1)
         {
            _ySpace = param1;
            updateView();
         }
      }
      
      public function set xySpace(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         this.xSpace = _loc2_[0];
         this.ySpace = _loc2_[1];
      }
      
      public function get xySpace() : String
      {
         return this._xSpace + "," + this._ySpace;
      }
      
      public function set renderStyle(param1:String) : void
      {
         if(!_renderStyle != param1)
         {
            _renderStyle = param1;
            _renderClass = ClassUtils.getDefinition(param1) as Class;
            _currentPage = 1;
            updateView();
         }
      }
      
      private function updateView() : void
      {
         if(_renderClass && _data)
         {
            LogicUtils.addToRender(this,render);
         }
      }
      
      private function render() : void
      {
         var _loc3_:PageListBaseCell = null;
         var _loc5_:int = 0;
         setCellStateByIndex(_selectIndex,false);
         var _loc6_:Array = getPageData();
         var _loc1_:int = int(_showItems.length);
         var _loc4_:int = int(_loc6_.length);
         var _loc2_:int = _loc4_ - _loc1_;
         if(_loc2_ > 0)
         {
            while(_loc2_ > 0)
            {
               _loc3_ = getItem();
               _showItems.push(_loc3_);
               addChild(_loc3_);
               _loc2_--;
            }
         }
         else if(_loc2_ < 0)
         {
            while(_loc2_ < 0)
            {
               storeItem(_showItems.pop());
               _loc2_++;
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _showItems[_loc5_];
            _loc3_.data = _loc6_[_loc5_];
            _loc3_.index = (_currentPage - 1) * _pageSize + _loc5_;
            _loc3_.x = _loc5_ % _xNum * (_loc3_.width + _xSpace);
            _loc3_.y = int(_loc5_ / _xNum) * (_loc3_.height + _ySpace);
            if(_loc3_.index == _selectIndex)
            {
               _loc3_.selected = true;
            }
            _loc5_++;
         }
         if(pageSwitchTab)
         {
            pageSwitchTab.text = this.pageStr;
            if(!pageSwitchTab.parent)
            {
               this.parent.addChild(pageSwitchTab);
            }
            setSwitchEnabled();
         }
         if(updateCompleteHandler != null)
         {
            updateCompleteHandler();
         }
      }
      
      private function setSwitchEnabled() : void
      {
         var _loc1_:Boolean = true;
         if(_currentPage == 1)
         {
            _loc1_ = false;
         }
         pageSwitchTab.leftBtnEnabled = _loc1_;
         _loc1_ = true;
         if(_currentPage == totalPage)
         {
            _loc1_ = false;
         }
         pageSwitchTab.rightBtnEnabled = _loc1_;
      }
      
      private function getPageData() : Array
      {
         _currentPage = _currentPage > totalPage ? totalPage : _currentPage;
         _currentPage = _currentPage < 1 ? 1 : _currentPage;
         var _loc1_:int = (_currentPage - 1) * _pageSize;
         var _loc2_:int = _currentPage * _pageSize;
         return _data.slice(_loc1_,_loc2_);
      }
      
      private function __mouseHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:PageListBaseCell = param1.currentTarget as PageListBaseCell;
         if(_loc2_)
         {
            if(_loc2_.index == _selectIndex)
            {
               return;
            }
            _loc3_ = param1.type;
            if(_loc3_ == "mouseOver")
            {
               _loc2_.mouseOverHandler(param1);
            }
            else if(_loc3_ == "mouseOut")
            {
               _loc2_.mouseOutHandler(param1);
            }
         }
      }
      
      protected function __mouseUpHandler(param1:MouseEvent) : void
      {
         if(!selectedEnabled)
         {
            return;
         }
         var _loc2_:PageListBaseCell = param1.currentTarget as PageListBaseCell;
         if(_loc2_)
         {
            if(_loc2_.index == _selectIndex)
            {
               return;
            }
            setCellStateByIndex(_selectIndex,false);
            _selectIndex = _loc2_.index;
            _loc2_.selected = true;
            if(selectHandler != null)
            {
               selectHandler(_data[_selectIndex]);
            }
         }
      }
      
      private function setCellStateByIndex(param1:int, param2:Boolean) : void
      {
         var _loc3_:PageListBaseCell = null;
         if(param1 > -1)
         {
            param1 %= _pageSize;
            _loc3_ = _showItems[param1];
            if(_loc3_)
            {
               _loc3_.selected = param2;
            }
         }
      }
      
      public function set pageSwitchTabLink(param1:String) : void
      {
         if(_pageSwitchTabLink != param1)
         {
            _pageSwitchTabLink = param1;
            pageSwitchTab = ComponentFactory.Instance.creatComponentByStylename(param1);
         }
      }
      
      public function get pageSwitchTab() : PageSwitchTab
      {
         return _pageSwitchTab;
      }
      
      public function set pageSwitchTab(param1:PageSwitchTab) : void
      {
         if(_pageSwitchTab)
         {
            ObjectUtils.disposeObject(_pageSwitchTab);
         }
         if(param1)
         {
            _pageSwitchTab = param1;
            _pageSwitchTab.leftBtnClickHandler = switchTabLeftClickHandler;
            _pageSwitchTab.rightBtnClickHandler = switchTabRightClickHandler;
            updateView();
         }
      }
      
      private function switchTabLeftClickHandler() : void
      {
         this.gotoPreviousPage();
      }
      
      private function switchTabRightClickHandler() : void
      {
         this.gotoNextPage();
      }
      
      override public function dispose() : void
      {
         _data = null;
         _renderClass = null;
         LogicUtils.disposeDisplayCollection(_cacheItems);
         _cacheItems = null;
         LogicUtils.disposeDisplayCollection(_showItems,removeEvent);
         _showItems = null;
         selectHandler = null;
         updateCompleteHandler = null;
         ObjectUtils.disposeObject(_pageSwitchTab);
         _pageSwitchTab = null;
         super.dispose();
      }
      
      private function removeEvent(param1:PageListBaseCell) : void
      {
         param1.removeEventListener("mouseUp",__mouseUpHandler);
         param1.removeEventListener("mouseOver",__mouseHandler);
         param1.removeEventListener("mouseOut",__mouseHandler);
      }
      
      private function getItem() : PageListBaseCell
      {
         var _loc1_:PageListBaseCell = _cacheItems.length > 0 ? _cacheItems.pop() : new _renderClass();
         _loc1_.addEventListener("mouseUp",__mouseUpHandler);
         _loc1_.addEventListener("mouseOver",__mouseHandler);
         _loc1_.addEventListener("mouseOut",__mouseHandler);
         return _loc1_;
      }
      
      private function storeItem(param1:PageListBaseCell) : void
      {
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         removeEvent(param1);
         _cacheItems.push(param1);
      }
   }
}

