package areslords
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.areslords.AresLordsPlayerInfo;
   import mvc.module.areslords.AresLordsStartInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.AresLordsManager;
   import yishi.manager.FrameControllerManager;
   
   public class AresLordsStartFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _title1:Image;
      
      private var _title2:Image;
      
      private var _myMedal:ScaleFrameImage;
      
      private var _shopBtn:IconButton;
      
      private var _rankBtn:BaseButton;
      
      private var _rewardBtn:BaseButton;
      
      private var _startBtn:BaseButton;
      
      private var _startBtnEff:MovieImage;
      
      private var _myTxt:FilterFrameText;
      
      private var _time:Image;
      
      private var _timeTxt:FilterFrameText;
      
      private var _roundTxt:FilterFrameText;
      
      private var _leftTxt:FilterFrameText;
      
      private var _list:ListPanel;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _front:MutipleImage;
      
      private var _clickTime:int;
      
      private var _rankList:Vector.<AresLordsPlayerInfo>;
      
      private var _page:int = 0;
      
      private var _maxPage:int;
      
      private const PagePerNum:int = 5;
      
      private var _groupScore:Array = ConfigInfoManager.instance.getAresTeamScore();
      
      public function AresLordsStartFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameBg");
         _title1 = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameTitle1");
         _title2 = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameTitle2");
         _myMedal = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameMyMedal");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameShopBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameRankBtn");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameRewardBtn");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameStartBtn");
         _startBtnEff = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameStartEff");
         _myTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameMyTxt");
         _time = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameTime");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameTimeTxt");
         _roundTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameRoundTxt");
         _leftTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameLeftTxt");
         _list = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameRankList");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFramePageTxt");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameNextPageBtn");
         _front = ComponentFactory.Instance.creatComponentByStylename("areslords.StartFrameFront");
         addToContent(_bg);
         addToContent(_myMedal);
         addToContent(_shopBtn);
         addToContent(_rankBtn);
         addToContent(_rewardBtn);
         addToContent(_startBtn);
         addToContent(_startBtnEff);
         addToContent(_myTxt);
         addToContent(_time);
         addToContent(_timeTxt);
         addToContent(_roundTxt);
         addToContent(_leftTxt);
         addToContent(_list);
         addToContent(_pageNumTxt);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_front);
         addToContent(_title1);
         addToContent(_title2);
         titleText = LanguageMgr.GetTranslation("areslords.title");
         _list.vectorListModel.clear();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _list.vectorListModel.append(null);
            _loc1_++;
         }
         _list.list.updateListView();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _shopBtn.addEventListener("click",__shopBtnClickHandler);
         _rankBtn.addEventListener("click",__rankBtnClickHandler);
         _rewardBtn.addEventListener("click",__rewardBtnClickHandler);
         _startBtn.addEventListener("click",__startBtnClickHandler);
         _prePageBtn.addEventListener("click",__pagePreBtnClickHandler);
         _nextPageBtn.addEventListener("click",__pageNextBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _shopBtn.removeEventListener("click",__shopBtnClickHandler);
         _rankBtn.removeEventListener("click",__rankBtnClickHandler);
         _rewardBtn.removeEventListener("click",__rewardBtnClickHandler);
         _startBtn.removeEventListener("click",__startBtnClickHandler);
         _prePageBtn.removeEventListener("click",__pagePreBtnClickHandler);
         _nextPageBtn.removeEventListener("click",__pageNextBtnClickHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title1);
         _title1 = null;
         ObjectUtils.disposeObject(_title2);
         _title2 = null;
         ObjectUtils.disposeObject(_myMedal);
         _myMedal = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeViolentMc(_startBtnEff);
         _startBtnEff = null;
         ObjectUtils.disposeObject(_myTxt);
         _myTxt = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_roundTxt);
         _roundTxt = null;
         ObjectUtils.disposeObject(_leftTxt);
         _leftTxt = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_front);
         _front = null;
         _rankList = null;
         _groupScore = null;
         super.dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __shopBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",10);
      }
      
      private function __rankBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         AresLordsManager.instance.requestRankInfo();
         FrameControllerManager.instance.openControllerByInfo("areslords",2);
      }
      
      private function __rewardBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("areslords",3);
      }
      
      private function __startBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ - _clickTime < 3000)
         {
            return;
         }
         SoundManager.instance.play("016",true);
         _clickTime = _loc2_;
         AresLordsManager.instance.requestEnterRoom();
      }
      
      private function __pagePreBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.max(1,_page - 1);
         if(_loc2_ != _page)
         {
            currentPage = _loc2_;
         }
      }
      
      private function __pageNextBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.min(_maxPage,_page + 1);
         if(_loc2_ != _page)
         {
            currentPage = _loc2_;
         }
      }
      
      public function set data(param1:AresLordsStartInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1)
         {
            if(param1.isOpen)
            {
               _time.visible = false;
               _timeTxt.text = "";
               if(param1.currentTurn < param1.maxTurnCount)
               {
                  _roundTxt.text = LanguageMgr.GetTranslation("areslords.StartFrame.round",param1.warIndex,param1.currentTurn + 1,param1.maxTurnCount);
               }
               else
               {
                  _roundTxt.text = LanguageMgr.GetTranslation("areslords.StartFrame.round",param1.warIndex,param1.currentTurn,param1.maxTurnCount);
               }
            }
            else
            {
               _time.visible = true;
               _timeTxt.text = param1.openTime + "";
               _roundTxt.text = "";
            }
            _leftTxt.text = LanguageMgr.GetTranslation("areslords.StartFrame.left",param1.leftWarIndex);
            _myMedal.setFrame(param1.teamType + 1);
            _loc2_ = LanguageMgr.GetTranslation("areslords.GroupName.full" + (param1.teamType + 1));
            if(param1.teamType < 5)
            {
               _loc3_ = LanguageMgr.GetTranslation("areslords.GroupName.full" + (param1.teamType + 2));
               _myMedal.tipData = LanguageMgr.GetTranslation("areslords.StartFrame.groupTipNext",_loc3_,_groupScore[param1.teamType] - param1.totalScore);
            }
            else
            {
               _myMedal.tipData = LanguageMgr.GetTranslation("areslords.StartFrame.groupTip",_loc2_,param1.totalScore);
            }
            _myTxt.htmlText = LanguageMgr.GetTranslation("areslords.StartFrame.myScore",_loc2_,param1.totalScore);
            _rankList = param1.rankList;
            _maxPage = Math.max(Math.ceil(_rankList.length / 5),1);
            currentPage = Math.max(Math.min(_page,_maxPage),1);
         }
      }
      
      public function set currentPage(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _page = param1;
         _pageNumTxt.text = _page + "/" + _maxPage;
         _prePageBtn.enable = _page != 1;
         _nextPageBtn.enable = _page != _maxPage;
         _list.vectorListModel.clear();
         var _loc2_:Vector.<AresLordsPlayerInfo> = _rankList.slice((_page - 1) * 5,_page * 5);
         _loc4_ = 0;
         _loc3_ = int(_loc2_.length);
         while(_loc4_ < _loc3_)
         {
            _list.vectorListModel.append(_loc2_[_loc4_]);
            _loc4_++;
         }
         _list.list.updateListView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,884,640);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
   }
}

