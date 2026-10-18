package map.campaign.mediator.mapview
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import mvc.module.consortia.ConsortiaSecretInfo;
   import utils.LogicUtils;
   import yishi.manager.ConsortiaManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   
   public class ConsortiaSecretSortView extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _numberBitmap:BitmapData;
      
      private var _myRankContiner:Component;
      
      private var _myScoreContiner:Component;
      
      private var _firstBtn:BaseButton;
      
      private var _lastBtn:BaseButton;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBack:Bitmap;
      
      private var _pageText:FilterFrameText;
      
      private var _pageCount:int = 10;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<ConsortiaSecretSortItem>;
      
      private var _showState:Boolean = true;
      
      public function ConsortiaSecretSortView()
      {
         super();
         initView();
         initListView();
         addEvent();
         _pageNumMax = Math.ceil(secretInfo.rankList.length / _pageCount);
         currentPageNum = 1;
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortView.back");
         _numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.ConsortiaSecretSortView.numberBitmap");
         _myRankContiner = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortView.myRankContiner");
         _myScoreContiner = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortView.myScoreContiner");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortView.vbox");
         _pageBack = ComponentFactory.Instance.creatBitmap("asset.core.pageBg");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortView.ListPageText");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortView.ListFirstBtn");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortView.ListLastBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortView.ListPreBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretSortView.ListNextBtn");
         addChild(_back);
         addChild(_vbox);
         addChild(_myRankContiner);
         addChild(_myScoreContiner);
         addChild(_pageBack);
         _pageBack.x = 90;
         _pageBack.y = 398;
         _pageBack.width = 68;
         addChild(_pageText);
         addChild(_firstBtn);
         addChild(_lastBtn);
         addChild(_preBtn);
         addChild(_nextBtn);
         this.visible = true;
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaSecretSortItem = null;
         _itemList = new Vector.<ConsortiaSecretSortItem>();
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = new ConsortiaSecretSortItem();
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _firstBtn.addEventListener("click",__onFirstPageHandler);
         _lastBtn.addEventListener("click",__onLastPageHandler);
         _preBtn.addEventListener("click",__onPrePageHandler);
         _nextBtn.addEventListener("click",__onNextPageHandler);
         secretInfo.addEventListener("SECRET_SORT_UPDATE",__updateSortHandler);
      }
      
      private function removeEvent() : void
      {
         _firstBtn.removeEventListener("click",__onFirstPageHandler);
         _lastBtn.removeEventListener("click",__onLastPageHandler);
         _preBtn.removeEventListener("click",__onPrePageHandler);
         _nextBtn.removeEventListener("click",__onNextPageHandler);
         secretInfo.removeEventListener("SECRET_SORT_UPDATE",__updateSortHandler);
      }
      
      private function __updateSortHandler(param1:ConsortiaEvent) : void
      {
         _pageNumMax = Math.ceil(secretInfo.rankList.length / _pageCount);
         if(currentPageNum <= 0)
         {
            currentPageNum = 1;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaSecretSortItem = null;
         if(secretInfo.mySelfSortInfo)
         {
            NumberViewUtils.refreshValue(secretInfo.mySelfSortInfo.secretOrder,_myRankContiner,_numberBitmap,11,14,9,11,"0123456789");
            NumberViewUtils.refreshValue(secretInfo.mySelfSortInfo.secretScore,_myScoreContiner,_numberBitmap,11,14,9,11,"0123456789");
         }
         else
         {
            NumberViewUtils.refreshValue(0,_myRankContiner,_numberBitmap,11,14,9,11,"0123456789");
            NumberViewUtils.refreshValue(0,_myScoreContiner,_numberBitmap,11,14,9,11,"0123456789");
         }
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = _itemList[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = new ConsortiaSecretSortItem();
               _itemList[_loc2_] = _loc1_;
            }
            _loc1_.data = _loc2_ < currentList.length ? currentList[_loc2_] : null;
            _loc2_++;
         }
      }
      
      private function __onFirstPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = 1;
         refreshView();
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = _pageNumMax;
         refreshView();
      }
      
      private function __onPrePageHandler(param1:MouseEvent) : void
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
         if(_pageNumMax <= 0)
         {
            _firstBtn.enable = _lastBtn.enable = false;
            _preBtn.enable = _nextBtn.enable = false;
            _pageText.text = "0/0";
         }
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
         if(_firstBtn && _preBtn)
         {
            _firstBtn.enable = _preBtn.enable = currentPageNum > 1;
         }
         if(_lastBtn && _nextBtn)
         {
            _lastBtn.enable = _nextBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageText)
         {
            _pageText.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function get currentList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = (currentPageNum - 1) * _pageCount;
         var _loc3_:int = Math.min(_loc1_ + _pageCount,secretInfo.rankList.length);
         return secretInfo.rankList.slice(_loc1_,_loc3_);
      }
      
      public function get secretInfo() : ConsortiaSecretInfo
      {
         return ConsortiaManager.instance.model.secretInfo;
      }
      
      public function set showState(param1:Boolean) : void
      {
         if(_showState == param1)
         {
            return;
         }
         _showState = param1;
         if(_showState)
         {
            this.visible = true;
            doShow();
         }
         else
         {
            doHide();
         }
      }
      
      public function get showState() : Boolean
      {
         return _showState;
      }
      
      private function doShow() : void
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":StageReferance.stageWidth - 240});
      }
      
      private function doHide() : void
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{
            "x":StageReferance.stageWidth,
            "onComplete":__onMoveComplete
         });
      }
      
      private function __onMoveComplete() : void
      {
         this.visible = false;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_numberBitmap)
         {
            ObjectUtils.disposeObject(_numberBitmap);
         }
         _numberBitmap = null;
         if(_myScoreContiner)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_myRankContiner)
         {
            ObjectUtils.disposeObject(_myRankContiner);
         }
         _myRankContiner = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_pageBack)
         {
            ObjectUtils.disposeObject(_pageBack);
         }
         _pageBack = null;
         if(_pageText)
         {
            ObjectUtils.disposeObject(_pageText);
         }
         _pageText = null;
         if(_firstBtn)
         {
            ObjectUtils.disposeObject(_firstBtn);
         }
         _firstBtn = null;
         if(_lastBtn)
         {
            ObjectUtils.disposeObject(_lastBtn);
         }
         _lastBtn = null;
         if(_preBtn)
         {
            ObjectUtils.disposeObject(_preBtn);
         }
         _preBtn = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         super.dispose();
      }
   }
}

