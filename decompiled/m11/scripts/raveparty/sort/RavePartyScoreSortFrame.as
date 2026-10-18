package raveparty.sort
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.RavePartyManager;
   import mvc.module.raveparty.RavePartyModel;
   import utils.LogicUtils;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class RavePartyScoreSortFrame extends Frame
   {
      
      private var border:ScaleBitmapImage;
      
      private var sortBack:Scale9CornerImage;
      
      private var bottomBg:MutipleImage;
      
      private var sortTextImage:ScaleFrameImage;
      
      private var scoreTextImage:ScaleFrameImage;
      
      private var myOrderText:FilterFrameText;
      
      private var myScoreText:FilterFrameText;
      
      private var refreshTimeText:FilterFrameText;
      
      private var orderText:FilterFrameText;
      
      private var guildNameText:FilterFrameText;
      
      private var serverNameText:FilterFrameText;
      
      private var scoreText:FilterFrameText;
      
      private var rewardImage:Image;
      
      private var _lastPageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageCount:int = 8;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<RavePartySortItem>;
      
      private var showType:int;
      
      private var curTargetArr:Array;
      
      public function RavePartyScoreSortFrame(param1:int)
      {
         super();
         showType = param1;
         initView();
         initListView();
         addEvent();
         RavePartyManager.instance.sendRavePartyRequest(showType - 4);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.border");
         sortBack = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.sortBack");
         bottomBg = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.bottomAllBg");
         sortTextImage = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.sortTextImage");
         scoreTextImage = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.scoreTextImage");
         myOrderText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.myOrderText");
         myScoreText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.myScoreText");
         refreshTimeText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.refreshTimeText");
         orderText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.orderText");
         guildNameText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.guildNameText");
         serverNameText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.serverNameText");
         scoreText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.scoreText");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.lookPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.lookPageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.lookLastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.lookNextPageBtn");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.vbox");
         rewardImage = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreSortFrame.rewardImage");
         addToContent(border);
         addToContent(sortBack);
         addToContent(orderText);
         addToContent(guildNameText);
         addToContent(serverNameText);
         addToContent(scoreText);
         addToContent(_vbox);
         addToContent(refreshTimeText);
         addToContent(_lastPageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(bottomBg);
         addToContent(sortTextImage);
         addToContent(scoreTextImage);
         addToContent(myOrderText);
         addToContent(myScoreText);
         addToContent(rewardImage);
         orderText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.rankText");
         guildNameText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.ConsortiaName");
         serverNameText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName");
         sortTextImage.setFrame(showType - 6);
         scoreTextImage.setFrame(showType - 6);
         scoreTextImage.x = showType == 7 ? 270 : 260;
         guildNameText.visible = showType == 7 ? true : false;
         serverNameText.x = showType == 7 ? 250 : 180;
         scoreText.text = LanguageMgr.GetTranslation("RavePartyScoreSortFrame.scoreText.text" + showType);
         rewardImage.tipData = LanguageMgr.GetTranslation("PetChallengeInfoView.lookReward");
         rewardImage.buttonMode = true;
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RavePartySortItem = null;
         _itemList = new Vector.<RavePartySortItem>();
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = new RavePartySortItem(showType);
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
         rewardImage.addEventListener("click",__onLookRewardHandler);
         MsgMan.addObserver("RAVE_PARTY_SORT_UPDTAE",this,__onSortDataUpdate);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _lastPageBtn.removeEventListener("click",__onLastPageHandler);
         _nextPageBtn.removeEventListener("click",__onNextPageHandler);
         rewardImage.removeEventListener("click",__onLookRewardHandler);
         MsgMan.removeObserver("RAVE_PARTY_SORT_UPDTAE",this,__onSortDataUpdate);
      }
      
      private function __onSortDataUpdate(param1:String, param2:Object) : void
      {
         var _loc3_:int = param2 as int;
         if(showType != _loc3_)
         {
            return;
         }
         refreshView();
      }
      
      private function __onLookRewardHandler(param1:MouseEvent) : void
      {
         var _loc2_:RavePartySortRewardFrame = ComponentFactory.Instance.creatComponentByStylename("raveparty.RavePartySortRewardFrame");
         _loc2_.rewardType = showType;
         var _loc3_:Point = new Point(rewardImage.displayWidth / 2,0);
         _loc3_ = rewardImage.localToGlobal(_loc3_);
         _loc2_.x = _loc3_.x + 45;
         _loc2_.y = _loc3_.y - 320;
         _loc2_.show();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RavePartySortItem = null;
         if(showType == 7)
         {
            curTargetArr = model.guildSortList;
            refreshTimeText.text = LanguageMgr.GetTranslation("sort.view.SortRightView.lastUpdateTime") + model.guildSortUpdateTime;
            myOrderText.text = model.myGuildOrder + "";
            myScoreText.text = model.myGuildScore + "";
         }
         else
         {
            curTargetArr = model.serverSortList;
            refreshTimeText.text = LanguageMgr.GetTranslation("sort.view.SortRightView.lastUpdateTime") + model.serverSortUpdateTime;
            myOrderText.text = model.myServerOrder + "";
            myScoreText.text = model.myServerScore + "";
         }
         _pageNumMax = Math.ceil(curTargetArr.length / _pageCount);
         if(currentPageNum <= 0)
         {
            currentPageNum = 1;
         }
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = _itemList[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = new RavePartySortItem(showType);
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
         if(_pageNumMax <= 0)
         {
            _lastPageBtn.enable = _nextPageBtn.enable = false;
            _pageTxt.text = "0/0";
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
         var _loc3_:int = Math.min(_loc1_ + _pageCount,curTargetArr.length);
         return curTargetArr.slice(_loc1_,_loc3_);
      }
      
      private function get model() : RavePartyModel
      {
         return RavePartyManager.instance.model;
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
         this.titleText = LanguageMgr.GetTranslation("raveparty.RavePartyScoreSortFrame.titleText" + showType);
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(border)
         {
            ObjectUtils.disposeObject(border);
         }
         border = null;
         if(sortBack)
         {
            ObjectUtils.disposeObject(sortBack);
         }
         sortBack = null;
         if(bottomBg)
         {
            ObjectUtils.disposeObject(bottomBg);
         }
         bottomBg = null;
         if(sortTextImage)
         {
            ObjectUtils.disposeObject(sortTextImage);
         }
         sortTextImage = null;
         if(scoreTextImage)
         {
            ObjectUtils.disposeObject(scoreTextImage);
         }
         scoreTextImage = null;
         if(myOrderText)
         {
            ObjectUtils.disposeObject(myOrderText);
         }
         myOrderText = null;
         if(myScoreText)
         {
            ObjectUtils.disposeObject(myScoreText);
         }
         myScoreText = null;
         if(orderText)
         {
            ObjectUtils.disposeObject(orderText);
         }
         orderText = null;
         if(guildNameText)
         {
            ObjectUtils.disposeObject(guildNameText);
         }
         guildNameText = null;
         if(serverNameText)
         {
            ObjectUtils.disposeObject(serverNameText);
         }
         serverNameText = null;
         if(scoreText)
         {
            ObjectUtils.disposeObject(scoreText);
         }
         scoreText = null;
         if(refreshTimeText)
         {
            ObjectUtils.disposeObject(refreshTimeText);
         }
         refreshTimeText = null;
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
         if(rewardImage)
         {
            ObjectUtils.disposeObject(rewardImage);
         }
         rewardImage = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         super.dispose();
      }
   }
}

