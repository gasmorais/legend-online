package cultureactive
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.culture.CultureOrdersMsg;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.culture.CultureModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.CultureActiveManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.StringHelper;
   
   public class CultureActiveSortFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _titleBg:MutipleImage;
      
      private var sortTextImage:ScaleFrameImage;
      
      private var scoreTextImage:ScaleFrameImage;
      
      private var myOrderText:FilterFrameText;
      
      private var myScoreText:FilterFrameText;
      
      private var desNoteText:FilterFrameText;
      
      private var fallLinkTxt:FilterFrameText;
      
      private var scoreBg:DisplayObject;
      
      private var orderText:FilterFrameText;
      
      private var guildNameText:FilterFrameText;
      
      private var serverNameText:FilterFrameText;
      
      private var scoreText:FilterFrameText;
      
      private var _lastPageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageCount:int = 10;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<CultureActiveSortItem>;
      
      private var showType:int;
      
      private var curTargetArr:Array;
      
      private var _proptip:CultureActiveSortRewardView;
      
      public function CultureActiveSortFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,454,542);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:CultureActiveSortItem = null;
         titleText = LanguageMgr.GetTranslation("cultureactive.CultureActiveSortFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("cultureactive.RankFrameBg");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("cultureactive.RankFrameTitleBg");
         orderText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.orderText");
         guildNameText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.guildNameText");
         serverNameText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.serverNameText");
         scoreText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.scoreText");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.vbox");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.lookPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.lookPageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.lookLastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.lookNextPageBtn");
         sortTextImage = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.sortTextImage");
         scoreTextImage = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.scoreTextImage");
         scoreBg = ComponentFactory.Instance.creatComponentByStylename("cultureactive.RankFrameScoreBg");
         myOrderText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.myOrderText");
         myScoreText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.myScoreText");
         desNoteText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.desNoteText");
         fallLinkTxt = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortFrame.fallItemsLinkTxt");
         addToContent(_bg);
         addToContent(_titleBg);
         addToContent(orderText);
         addToContent(guildNameText);
         addToContent(serverNameText);
         addToContent(scoreText);
         addToContent(_vbox);
         addToContent(_lastPageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(sortTextImage);
         addToContent(scoreTextImage);
         addToContent(scoreBg);
         addToContent(myOrderText);
         addToContent(myScoreText);
         addToContent(desNoteText);
         addToContent(fallLinkTxt);
         _itemList = new Vector.<CultureActiveSortItem>();
         _loc3_ = 0;
         while(_loc3_ < _pageCount)
         {
            _loc2_ = new CultureActiveSortItem(showType);
            _vbox.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc3_++;
         }
         orderText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.rankText");
         scoreText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.scoreText");
         var _loc1_:String = LanguageMgr.GetTranslation("CultureActiveSortFrame.fallLink");
         fallLinkTxt.htmlText = "<a href =\'event: \'><u><b>" + _loc1_ + " </b></u></a>";
         fallLinkTxt.mouseEnabled = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _lastPageBtn.addEventListener("click",__onLastPageHandler);
         _nextPageBtn.addEventListener("click",__onNextPageHandler);
         fallLinkTxt.addEventListener("click",__fallLinkHandler);
         NotificationManager.instance.addEventListener("CULTURE_RANK_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_lastPageBtn)
         {
            _lastPageBtn.removeEventListener("click",__onLastPageHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__onNextPageHandler);
         }
         if(fallLinkTxt)
         {
            fallLinkTxt.removeEventListener("click",__fallLinkHandler);
         }
         NotificationManager.instance.removeEventListener("CULTURE_RANK_UPDATE",__updateViewHandler);
      }
      
      private function __fallLinkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_proptip)
         {
            ObjectUtils.disposeObject(_proptip);
         }
         _proptip = null;
         _proptip = new CultureActiveSortRewardView();
         _proptip.tipData = CultureActiveManager.instance.rankMsg.orderReward;
         LayerManager.Instance.addToLayer(_proptip,7);
         var _loc2_:Point = new Point(fallLinkTxt.width,0);
         _loc2_ = fallLinkTxt.localToGlobal(_loc2_);
         _proptip.x = _loc2_.x + 45;
         _proptip.y = _loc2_.y - 272;
         if(_proptip.x + _proptip.width > StageReferance.stageWidth)
         {
            _proptip.x = StageReferance.stageWidth - _proptip.width;
         }
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:CultureActiveSortItem = null;
         curTargetArr = CultureActiveManager.instance.rankMsgArr;
         var _loc2_:CultureModel = CultureActiveManager.instance.model;
         _pageNumMax = Math.ceil(curTargetArr.length / _pageCount);
         if(currentPageNum <= 0)
         {
            currentPageNum = 1;
         }
         _loc3_ = 0;
         while(_loc3_ < _pageCount)
         {
            _loc1_ = _itemList[_loc3_];
            if(!_loc1_)
            {
               _loc1_ = new CultureActiveSortItem(showType);
               _itemList[_loc3_] = _loc1_;
            }
            else
            {
               _loc1_.sortType = showType;
            }
            _loc1_.data = _loc3_ < currentList.length ? currentList[_loc3_] : null;
            _loc3_++;
         }
         sortTextImage.setFrame(showType);
         scoreTextImage.setFrame(showType);
         if(showType == 3)
         {
            scoreTextImage.x = 157;
         }
         else
         {
            scoreTextImage.x = 212;
         }
         guildNameText.text = "";
         serverNameText.text = "";
         switch(showType - 1)
         {
            case 0:
               _titleBg.imageRectString = "0|432|0|34|13,68|22|3|28|13,68|22|3|28|13,300|22|3|28|13";
               desNoteText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.desNoteText1");
               guildNameText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.nickText");
               guildNameText.x = 122;
               break;
            case 1:
               desNoteText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.desNoteText2",_loc2_.needScore1);
               guildNameText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.ConsortiaName");
               serverNameText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverText");
               break;
            case 2:
               _titleBg.imageRectString = "0|432|0|34|13,68|22|3|28|13,68|22|3|28|13,300|22|3|28|13";
               desNoteText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.desNoteText3",_loc2_.needScore2);
               serverNameText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverText");
               serverNameText.x = 134;
         }
         var _loc4_:CultureOrdersMsg = CultureActiveManager.instance.rankMsg;
         myOrderText.text = _loc4_.myOrder.toString();
         myScoreText.text = _loc4_.myScore.toString();
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
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:int) : void
      {
         showType = param1;
         CultureActiveManager.instance.OperateCultureReq(3,0,0,0,showType);
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(sortTextImage);
         sortTextImage = null;
         ObjectUtils.disposeObject(scoreTextImage);
         scoreTextImage = null;
         ObjectUtils.disposeObject(myOrderText);
         myOrderText = null;
         ObjectUtils.disposeObject(myScoreText);
         myScoreText = null;
         ObjectUtils.disposeObject(desNoteText);
         desNoteText = null;
         ObjectUtils.disposeObject(fallLinkTxt);
         fallLinkTxt = null;
         ObjectUtils.disposeObject(scoreBg);
         scoreBg = null;
         ObjectUtils.disposeObject(orderText);
         orderText = null;
         ObjectUtils.disposeObject(guildNameText);
         guildNameText = null;
         ObjectUtils.disposeObject(serverNameText);
         serverNameText = null;
         ObjectUtils.disposeObject(scoreText);
         scoreText = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         ObjectUtils.disposeObject(_proptip);
         _proptip = null;
         super.dispose();
      }
   }
}

