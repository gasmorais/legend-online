package auction.view.buy
{
   import auction.view.common.AuctionPageControlComponent;
   import com.pickgliss.ui.controls.TitleButton;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.mall.SearchItemReqMsg;
   import events.AuctionEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mediator.AuctionMessageSender;
   import mvc.module.auction.AuctionModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.StringUtil;
   
   public class AuctionSearchControl
   {
      
      private var _searchPane:AuctionSearchPane;
      
      private var _categoryPane:AuctionCategoryPane;
      
      private var _pageControl:AuctionPageControlComponent;
      
      private var _resultPane:AuctionBuyResultPane;
      
      private var _recordDic:Dictionary = new Dictionary();
      
      private var _currentOrderBy:int = 0;
      
      private var _currentOrderType:int = 0;
      
      public function AuctionSearchControl(param1:AuctionSearchPane, param2:AuctionCategoryPane, param3:AuctionPageControlComponent, param4:AuctionBuyResultPane)
      {
         super();
         _searchPane = param1;
         _categoryPane = param2;
         _pageControl = param3;
         _resultPane = param4;
         addHandler();
      }
      
      private function addHandler() : void
      {
         _searchPane.searchBtn.addEventListener("click",onSearchBtnClick);
         _searchPane.nameInput.addEventListener("keyDown",__onkeyDownHandler);
         NotificationManager.instance.addEventListener("AUCTION_HOT_SEARCH",__hotSearchHandler);
         _pageControl.getNextBtn().addEventListener("click",searchNextPage);
         _pageControl.getPreBtn().addEventListener("click",searchPrevPage);
         _resultPane.listTitle.titleGrade.addEventListener("click",__onTitleClick);
         _resultPane.listTitle.titleTime.addEventListener("click",__onTitleClick);
         _resultPane.listTitle.titlePrice.addEventListener("click",__onTitleClick);
         _resultPane.listTitle.titleCurPrice.addEventListener("click",__onTitleClick);
         _categoryPane.addEventListener("select",onCategoryChanged);
         var _loc1_:AuctionModel = FrameControllerManager.instance.auctionController.model;
         _loc1_.addEventListener(AuctionEvent.REFRESH_FORSELL,onRefreshEvent);
      }
      
      private function __onkeyDownHandler(param1:KeyboardEvent) : void
      {
         SoundManager.instance.play("022");
         if(param1.charCode == 13)
         {
            restoreListTitle();
            search();
         }
      }
      
      private function __hotSearchHandler(param1:NotificationEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = param1.data as String;
         restoreListTitle(_loc2_);
         search(1,0,0,_loc2_);
      }
      
      private function onRefreshEvent(param1:Event) : void
      {
         search(_pageControl.getData().currentPage,_currentOrderBy,_currentOrderType);
      }
      
      public function search(param1:int = 1, param2:int = 0, param3:int = 0, param4:String = null) : void
      {
         var _loc6_:Object = null;
         var _loc5_:SearchItemReqMsg = new SearchItemReqMsg();
         if(_recordDic && _recordDic["name"])
         {
            _loc5_.itemName = _recordDic["name"];
         }
         else
         {
            _loc5_.itemName = "";
         }
         if(param4)
         {
            _loc5_.itemName = param4;
         }
         _loc6_ = _recordDic["grade"];
         if(_loc6_ && _loc6_.id != 0)
         {
            _loc5_.minLevel = _loc6_.min;
            _loc5_.maxLevel = _loc6_.max;
         }
         _loc6_ = _recordDic["quality"];
         if(_loc6_ && _loc6_.id != 0)
         {
            _loc5_.quality = _loc6_.id;
         }
         _loc6_ = _recordDic["job"];
         if(_loc6_ && _loc6_.id != 0)
         {
            _loc5_.job = _loc6_.id;
         }
         if(_recordDic["type"] != 0)
         {
            _loc5_.type = _recordDic["type"];
            if(_recordDic["sonType"] != 0)
            {
               _loc5_.sonType = _recordDic["sonType"];
            }
         }
         _loc5_.usable = _recordDic["usable"] ? true : false;
         _loc5_.page = param1;
         _loc5_.orderBy = param2;
         _loc5_.orderType = param3;
         AuctionMessageSender.search(_loc5_);
      }
      
      private function onSearchBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         restoreListTitle();
         search();
      }
      
      private function recordSearchData(param1:String = null) : void
      {
         var _loc2_:String = StringUtil.trim(_searchPane.nameInput.text);
         if(_loc2_ && _loc2_ != "" && _searchPane.nameTextClicked)
         {
            _recordDic["name"] = _loc2_;
         }
         else
         {
            _recordDic["name"] = "";
         }
         if(param1)
         {
            _recordDic["name"] = param1;
         }
         _recordDic["grade"] = _searchPane.gradeCombo.currentSelectedCellValue;
         _recordDic["quality"] = _searchPane.qualityCombo.currentSelectedCellValue;
         _recordDic["job"] = _searchPane.jobCombo.currentSelectedCellValue;
         _recordDic["usable"] = _searchPane.availableCheckBtn.selected;
         _recordDic["type"] = _categoryPane.getFirstCategoryType();
         _recordDic["sonType"] = _categoryPane.getSecondCategoryType();
      }
      
      private function searchNextPage(param1:MouseEvent) : void
      {
         search(_pageControl.getData().currentPage + 1,_currentOrderBy,_currentOrderType);
      }
      
      private function searchPrevPage(param1:MouseEvent) : void
      {
         search(_pageControl.getData().currentPage - 1,_currentOrderBy,_currentOrderType);
      }
      
      private function onCategoryChanged(param1:Event) : void
      {
         restoreListTitle();
      }
      
      public function restoreListTitle(param1:String = null) : void
      {
         _currentOrderBy = _currentOrderType = 0;
         _resultPane.listTitle.currentSelectBut(null);
         recordSearchData(param1);
         search();
      }
      
      private function __onTitleClick(param1:MouseEvent) : void
      {
         var _loc2_:TitleButton = param1.currentTarget as TitleButton;
         switch(_loc2_)
         {
            case _resultPane.listTitle.titleGrade:
               _currentOrderBy = 1;
               break;
            case _resultPane.listTitle.titleTime:
               _currentOrderBy = 2;
               break;
            case _resultPane.listTitle.titlePrice:
               _currentOrderBy = 4;
               break;
            case _resultPane.listTitle.titleCurPrice:
               _currentOrderBy = 3;
         }
         if(_resultPane.listTitle.currentSelectBut(_loc2_) == 2)
         {
            _currentOrderType = 1;
         }
         else
         {
            _currentOrderType = 2;
         }
         search(1,_currentOrderBy,_currentOrderType);
      }
      
      public function dispose() : void
      {
         _currentOrderBy = _currentOrderType = 0;
         _resultPane.listTitle.currentSelectBut(null);
         _searchPane.searchBtn.removeEventListener("click",onSearchBtnClick);
         _searchPane.nameInput.removeEventListener("keyDown",__onkeyDownHandler);
         _pageControl.getNextBtn().removeEventListener("click",searchNextPage);
         _pageControl.getPreBtn().removeEventListener("click",searchPrevPage);
         _resultPane.listTitle.titleGrade.removeEventListener("click",__onTitleClick);
         _resultPane.listTitle.titleTime.removeEventListener("click",__onTitleClick);
         _resultPane.listTitle.titlePrice.removeEventListener("click",__onTitleClick);
         _resultPane.listTitle.titleCurPrice.removeEventListener("click",__onTitleClick);
         NotificationManager.instance.removeEventListener("AUCTION_HOT_SEARCH",__hotSearchHandler);
         _categoryPane.removeEventListener("select",onCategoryChanged);
         var _loc1_:AuctionModel = FrameControllerManager.instance.auctionController.model;
         _loc1_.removeEventListener(AuctionEvent.REFRESH_FORSELL,onRefreshEvent);
      }
   }
}

