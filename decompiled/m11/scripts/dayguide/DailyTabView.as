package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.DayGuideEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import mvc.module.dayGuide.DailyItemInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   
   public class DailyTabView extends Sprite implements Disposeable
   {
      
      private var _largeBack:ScaleBitmapImage;
      
      private var _isShowBtn:SelectedButton;
      
      private var _isShowText:FilterFrameText;
      
      private var _titleShineBg:Scale9CornerImage;
      
      private var _activeTimeBmp:Bitmap;
      
      private var _activeNameBmp:Bitmap;
      
      private var _finishTimeBmp:Bitmap;
      
      private var _conditionBmp:Bitmap;
      
      private var _dailyItemVBox:VBox;
      
      private var _selectedData:DailyItemInfo;
      
      private var _dailyItemGroup:SelectedButtonGroup;
      
      private var _itemList:Array;
      
      private var _isFirstOpen:Boolean;
      
      private var _rightView:DailyRightView;
      
      private var _joinDailyItem:DailyItem;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageSize:int = 11;
      
      private var _currentPageNum:int;
      
      private var _pageNumMax:int = 1;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _arr:Array;
      
      public function DailyTabView()
      {
         super();
         initView();
         _isFirstOpen = true;
         initEvent();
      }
      
      private function initView() : void
      {
         _isShowBtn = ComponentFactory.Instance.creatComponentByStylename("dailty.isShowBtn");
         _isShowText = ComponentFactory.Instance.creatComponentByStylename("dailty.isShowText");
         _largeBack = ComponentFactory.Instance.creatComponentByStylename("dailyTab.largeBack");
         _titleShineBg = ComponentFactory.Instance.creatComponentByStylename("daily.titleShineBg");
         _activeTimeBmp = ComponentFactory.Instance.creatBitmap("asset.dayGuide.activeTimeBg");
         _activeNameBmp = ComponentFactory.Instance.creatBitmap("asset.dayGuide.activeNameBg");
         _finishTimeBmp = ComponentFactory.Instance.creatBitmap("asset.dayGuide.finishTimeBg");
         _conditionBmp = ComponentFactory.Instance.creatBitmap("asset.dayGuide.conditionBg");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("dayGuide.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("dayGuide.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("dayGuide.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.PageText");
         _dailyItemGroup = new SelectedButtonGroup();
         _itemList = [];
         addChild(_largeBack);
         addChild(_titleShineBg);
         addChild(_activeTimeBmp);
         addChild(_activeNameBmp);
         addChild(_finishTimeBmp);
         addChild(_conditionBmp);
         _dailyItemVBox = new VBox();
         _dailyItemVBox.y = 55;
         _dailyItemVBox.spacing = -2;
         addChild(_dailyItemVBox);
         var _loc1_:Sprite = ComponentFactory.Instance.creatCustomObject("dayGuide.pageItems");
         _loc1_.addChild(_pageBg);
         _loc1_.addChild(_preBtn);
         _loc1_.addChild(_nextBtn);
         _loc1_.addChild(_pageTxt);
         addChild(_loc1_);
      }
      
      private function getWeekData() : void
      {
         var _loc1_:Array = [];
         var _loc2_:String = LanguageMgr.GetTranslation("public.Monday");
         _loc1_.push(_loc2_);
         _loc2_ = LanguageMgr.GetTranslation("public.Tuesday");
         _loc1_.push(_loc2_);
         _loc2_ = LanguageMgr.GetTranslation("public.Wednesday");
         _loc1_.push(_loc2_);
         _loc2_ = LanguageMgr.GetTranslation("public.Thursday");
         _loc1_.push(_loc2_);
         _loc2_ = LanguageMgr.GetTranslation("public.Friday");
         _loc1_.push(_loc2_);
         _loc2_ = LanguageMgr.GetTranslation("public.Saturday");
         _loc1_.push(_loc2_);
         _loc2_ = LanguageMgr.GetTranslation("public.Sunday");
         _loc1_.push(_loc2_);
         var _loc3_:Date = new Date();
      }
      
      private function get dailyItemInfoList() : Array
      {
         return setState(DayGuideManager.instance.dailyList);
      }
      
      private function getEndHours(param1:String) : int
      {
         return int(param1.substr(6,2));
      }
      
      private function getStartHours(param1:String) : int
      {
         return int(param1.substr(0,2));
      }
      
      private function getEndMinutes(param1:String) : int
      {
         return int(param1.substr(9,2));
      }
      
      private function setState(param1:Array) : Array
      {
         var _loc3_:* = null;
         var _loc4_:int = 100;
         var _loc6_:int = 150;
         var _loc5_:int = 200;
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         for each(var _loc7_:DailyItemInfo in param1)
         {
            _loc7_.state = 0;
            if(_loc7_.currentFinsh == _loc7_.MaxCount)
            {
               _loc7_.state = 1;
               _loc7_.Sort = _loc4_;
               _loc4_++;
            }
            if(ArmyManager.instance.thane.grades < _loc7_.Levels)
            {
               _loc7_.state = 2;
               _loc7_.Sort = _loc5_;
               _loc5_++;
            }
            if(_loc7_.Type != 1)
            {
               if(_loc2_.hours >= getEndHours(_loc7_.ActiveTime) + 1)
               {
                  _loc7_.state = 1;
                  _loc7_.Sort = _loc6_;
                  _loc6_++;
               }
               if(_loc2_.hours >= getEndHours(_loc7_.ActiveTime) && _loc2_.minutes >= getEndMinutes(_loc7_.ActiveTime))
               {
                  _loc7_.state = 1;
                  _loc7_.Sort = _loc6_;
                  _loc6_++;
               }
            }
         }
         param1.sort(sortByLv);
         return param1;
      }
      
      private function sortByLv(param1:DailyItemInfo, param2:DailyItemInfo) : int
      {
         if(param1.Type == param2.Type && param1.Type == 0)
         {
            return param1.Sort - param2.Sort;
         }
         if(param1.state == param2.state && param1.Type != 0)
         {
            return param1.Levels - param2.Levels;
         }
         return param1.Sort - param2.Sort;
      }
      
      private function clearArr(param1:Array) : void
      {
         while(param1 && param1.length > 0)
         {
            ObjectUtils.disposeObject(param1.shift());
         }
      }
      
      private function refreshItemView() : void
      {
         var _loc3_:Array = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:DailyItem = null;
         if(_arr == null)
         {
            _loc3_ = dailyItemInfoList;
         }
         else
         {
            _loc3_ = _arr;
         }
         if(!_itemList)
         {
            _itemList = [];
         }
         else
         {
            clearArr(_itemList);
         }
         _dailyItemVBox.removeAllChild();
         _dailyItemGroup.removeAllItem();
         if(_loc3_.length >= 8)
         {
            _loc1_ = int(_loc3_.length);
         }
         else
         {
            _loc1_ = 8;
         }
         _loc2_ = 0;
         while(_loc2_ < _pageSize)
         {
            if((_currentPageNum - 1) * _pageSize + _loc2_ < _loc3_.length)
            {
               _loc4_ = new DailyItem();
               _loc4_.data = _loc3_[(_currentPageNum - 1) * _pageSize + _loc2_] as DailyItemInfo;
               _loc4_.setBgColour(_loc2_ % 2 + 1,_loc4_.data);
               _itemList.push(_loc4_);
               _dailyItemVBox.addChild(_loc4_);
               _dailyItemGroup.addSelectItem(_loc4_);
            }
            else
            {
               _itemList[_loc2_] = null;
            }
            _loc2_++;
         }
         if(_isFirstOpen)
         {
            __itemClickHandler(null);
         }
      }
      
      public function changePanelView() : void
      {
         var _loc4_:int = 0;
         var _loc5_:DailyItemInfo = null;
         var _loc3_:Array = dailyItemInfoList;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_] as DailyItemInfo;
            if(_loc5_.Type == 0)
            {
               _loc1_.push(_loc5_);
            }
            else
            {
               _loc2_.push(_loc5_);
            }
            _loc4_++;
         }
         if(DayGuideManager.instance.page == 0)
         {
            _pageNumMax = Math.ceil(_loc1_.length / _pageSize);
            currentPageNum = 1;
            _arr = _loc1_;
            refreshItemView();
         }
         else
         {
            _pageNumMax = Math.ceil(_loc2_.length / _pageSize);
            currentPageNum = 1;
            _arr = _loc2_;
            refreshItemView();
         }
      }
      
      private function __refreshHandler(param1:DayGuideEvent) : void
      {
         changePanelView();
      }
      
      private function initEvent() : void
      {
         DayGuideManager.instance.addEventListener("DAILY_ITEM_REFRESH",__refreshHandler);
         NotificationManager.instance.addEventListener("DAILY_ITEM_CLICK",__itemClickHandler);
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         DayGuideManager.instance.removeEventListener("DAILY_ITEM_REFRESH",__refreshHandler);
         NotificationManager.instance.removeEventListener("DAILY_ITEM_CLICK",__itemClickHandler);
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
      
      private function refreshListView() : void
      {
         refreshItemView();
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
      
      private function refresh() : void
      {
      }
      
      private function __noShowHandler(param1:MouseEvent) : void
      {
         _dailyItemVBox.removeAllChild();
         for each(var _loc2_:DailyItem in _itemList)
         {
            if(!_isShowBtn.selected)
            {
               _dailyItemVBox.addChild(_loc2_);
            }
            else if(_loc2_.data.state)
            {
               _dailyItemVBox.addChild(_loc2_);
            }
         }
      }
      
      private function __itemClickHandler(param1:DayGuideEvent) : void
      {
         _isFirstOpen = false;
         if(param1 == null)
         {
            if(dailyItemInfoList.length <= 0)
            {
               return;
            }
            _dailyItemGroup.selectIndex = 0;
            _selectedData = (_itemList[0] as DailyItem).data;
         }
         else
         {
            _selectedData = param1.data as DailyItemInfo;
         }
         if(_rightView == null)
         {
            _rightView = ComponentFactory.Instance.creatComponentByStylename("daily.RightView");
            addChild(_rightView);
         }
         _rightView.data = _selectedData;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_largeBack);
         _largeBack = null;
         ObjectUtils.disposeObject(_titleShineBg);
         _titleShineBg = null;
         ObjectUtils.disposeObject(_activeTimeBmp);
         _activeTimeBmp = null;
         ObjectUtils.disposeObject(_activeNameBmp);
         _activeNameBmp = null;
         ObjectUtils.disposeObject(_finishTimeBmp);
         _finishTimeBmp = null;
         ObjectUtils.disposeObject(_conditionBmp);
         _conditionBmp = null;
         ObjectUtils.disposeObject(_dailyItemVBox);
         _dailyItemVBox = null;
         ObjectUtils.disposeObject(_joinDailyItem);
         _joinDailyItem = null;
         ObjectUtils.disposeObject(_dailyItemGroup);
         _dailyItemGroup = null;
         ObjectUtils.disposeObject(_isShowBtn);
         _isShowBtn = null;
         ObjectUtils.disposeObject(_isShowText);
         _isShowText = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         if(_arr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _arr.length)
            {
               ObjectUtils.disposeObject(_arr[_loc1_]);
               _arr[_loc1_] = null;
               _loc1_++;
            }
            _arr = null;
         }
         _selectedData = null;
         clearArr(_itemList);
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

