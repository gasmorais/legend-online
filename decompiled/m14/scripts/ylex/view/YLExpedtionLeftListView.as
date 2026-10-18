package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import mvc.module.ylex.ChildCampInfo;
   import yishi.utils.StringHelper;
   
   public class YLExpedtionLeftListView extends Component
   {
      
      private var listVbox:VBox;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageSize:int = 5;
      
      private var _currentPageNum:int;
      
      private var _pageNumMax:int = 1;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _frameType:int;
      
      private var _headList:Vector.<YLExpedtionLeftItemView>;
      
      private var _data:ChildCampInfo;
      
      public function YLExpedtionLeftListView()
      {
         super();
         initView();
         addEvent();
         currentPageNum = 1;
         var _loc2_:Array = model.nsList;
         var _loc1_:int = int(_loc2_.length);
         if(_loc1_ > 0)
         {
            _pageNumMax = Math.ceil(_loc1_ / _pageSize);
            refreshListView();
            currentPageNum = 1;
         }
      }
      
      public function get data() : ChildCampInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildCampInfo) : void
      {
         _data = param1;
         if(_data)
         {
            refreshListView();
         }
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:YLExpedtionLeftItemView = null;
         listVbox = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftListView.listVbox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftListView.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftListView.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftListView.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftListView.PageText");
         addChild(listVbox);
         addChild(_pageBg);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageTxt);
         _headList = new Vector.<YLExpedtionLeftItemView>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ylex.view.YLExpedtionLeftItemView");
            listVbox.addChild(_loc1_);
            _headList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",__preBtnClickHandler);
         _nextBtn.removeEventListener("click",__nextBtnClickHandler);
      }
      
      private function __preBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshListView();
      }
      
      private function __nextBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshListView();
      }
      
      public function refreshListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _headList[_loc2_].frameType = _frameType;
            _loc1_ = getCurrentList();
            _headList[_loc2_].ydData = _data;
            _headList[_loc2_].data = _loc2_ < _loc1_.length ? _loc1_[_loc2_] : null;
            _loc2_++;
         }
      }
      
      private function getCurrentList() : Array
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc4_:Array = model.nsList;
         if(_loc4_)
         {
            _loc1_ = (currentPageNum - 1) * _pageSize;
            _loc3_ = Math.min(_loc1_ + _pageSize,_loc4_.length);
            _loc2_ = _loc4_.slice(_loc1_,_loc3_);
         }
         return _loc2_;
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
         if(_preBtn)
         {
            _preBtn.enable = currentPageNum > 1;
         }
         if(_nextBtn)
         {
            _nextBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageTxt)
         {
            _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      public function set frameType(param1:int) : void
      {
         _frameType = param1;
         refreshListView();
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(listVbox)
         {
            ObjectUtils.disposeObject(listVbox);
         }
         listVbox = null;
         if(_pageBg)
         {
            _pageBg.dispose();
         }
         _pageBg = null;
         if(_preBtn)
         {
            _preBtn.dispose();
         }
         _preBtn = null;
         if(_nextBtn)
         {
            _nextBtn.dispose();
         }
         _nextBtn = null;
         if(_pageTxt)
         {
            _pageTxt.dispose();
         }
         _pageTxt = null;
         _headList = null;
         super.dispose();
         _data = null;
      }
   }
}

