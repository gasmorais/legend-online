package archaeology
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.archeology.ArchaeologyModel;
   import yishi.manager.ArchaeologyManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class ArchaeologyBookFrame extends Frame
   {
      
      private var _lastPageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageCount:int = 3;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<ArchaeologyBookItem>;
      
      public function ArchaeologyBookFrame()
      {
         super();
         initView();
         addEvent();
         initListView();
         _pageNumMax = Math.ceil(model.getBookArr().length / _pageCount);
         currentPageNum = 1;
         refreshView();
      }
      
      private function initView() : void
      {
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookFrame.lookPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookFrame.lookPageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookFrame.lookLastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookFrame.lookNextPageBtn");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookFrame.vbox");
         addToContent(_lastPageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_vbox);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ArchaeologyBookItem = null;
         _itemList = new Vector.<ArchaeologyBookItem>();
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = new ArchaeologyBookItem();
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _lastPageBtn.addEventListener("click",__onLastPageHandler);
         _nextPageBtn.addEventListener("click",__onNextPageHandler);
         MsgMan.addObserver("ARCHAEOLOGY_BOOK_DATA",this,__updateBookStateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _lastPageBtn.removeEventListener("click",__onLastPageHandler);
         _nextPageBtn.removeEventListener("click",__onNextPageHandler);
         MsgMan.removeObserver("ARCHAEOLOGY_BOOK_DATA",this,__updateBookStateHandler);
      }
      
      private function __updateBookStateHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ArchaeologyBookItem = null;
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = _itemList[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = new ArchaeologyBookItem();
               _itemList[_loc2_] = _loc1_;
            }
            _loc1_.data = _loc2_ < currentList.length ? currentList[_loc2_] : null;
            _loc2_++;
         }
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshView();
      }
      
      private function __onNextPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshView();
      }
      
      public function get currentPageNum() : int
      {
         return _currentPageNum;
      }
      
      public function set currentPageNum(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         if(param1 > _pageNumMax)
         {
            return;
         }
         _currentPageNum = param1;
         updatePageInfo();
      }
      
      private function updatePageInfo() : void
      {
         if(_lastPageBtn)
         {
            _lastPageBtn.enable = currentPageNum > 1;
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageTxt)
         {
            _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function get currentList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = (currentPageNum - 1) * _pageCount;
         var _loc3_:int = Math.min(_loc1_ + _pageCount,model.getBookArr().length);
         return model.getBookArr().slice(_loc1_,_loc3_);
      }
      
      private function get model() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         titleText = LanguageMgr.GetTranslation("ArchaeologyBookFrame.titleText.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_pageBg)
         {
            ObjectUtils.disposeObject(_pageBg);
         }
         _pageBg = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_lastPageBtn)
         {
            ObjectUtils.disposeObject(_lastPageBtn);
         }
         _lastPageBtn = null;
         if(_nextPageBtn)
         {
            ObjectUtils.disposeObject(_nextPageBtn);
         }
         _nextPageBtn = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_itemList)
         {
            for(var _loc1_:String in _itemList)
            {
               ObjectUtils.disposeObject(_itemList[_loc1_]);
               _itemList[_loc1_] = null;
            }
            _itemList = null;
         }
         super.dispose();
      }
   }
}

