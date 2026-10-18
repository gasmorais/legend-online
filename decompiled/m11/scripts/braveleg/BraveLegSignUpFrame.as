package braveleg
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
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.BraveLegEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.braveleg.BraveLegModel;
   import mvc.module.braveleg.BraveLegPlayerInfo;
   import mvc.module.braveleg.BraveLegSignUpInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.HeadIconCell;
   import yishi.view.tips.MessageTipManager;
   
   public class BraveLegSignUpFrame extends Frame implements IManualSize
   {
      
      private var _titleImg:Image;
      
      private var _rankTitle:Image;
      
      private var _teamListTitle:Image;
      
      private var _teamListImg1:Image;
      
      private var _teamListImg2:Image;
      
      private var _topList:ListPanel;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _timeTxt:FilterFrameText;
      
      private var _shopBtn:BaseButton;
      
      private var _rankBtn:IconButton;
      
      private var _rewardBtn:IconButton;
      
      private var _signUpBtn:IconButton;
      
      private var _createTeamBtn:IconButton;
      
      private var _head:HeadIconCell;
      
      private var _medal:ScaleFrameImage;
      
      private var _scoreImg:Image;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _fightImg:Image;
      
      private var _fightTxt:FilterFrameText;
      
      private var _teamList:ListPanel;
      
      private var _refreshBtn:IconButton;
      
      private var _clickTime:int;
      
      private var _timer:Timer;
      
      private var _timeCount:int;
      
      private var _timeMaxCount:int = 10;
      
      private var _data:BraveLegSignUpInfo;
      
      private var _model:BraveLegModel = BraveLegManager.instance.model;
      
      private var _isOpen:Boolean;
      
      private var _groupScore:Array = ConfigInfoManager.instance.getBraveLegTeamScore();
      
      private var _rankList:Vector.<BraveLegPlayerInfo>;
      
      private var _page:int = 0;
      
      private var _maxPage:int;
      
      private const PagePerNum:int = 5;
      
      public function BraveLegSignUpFrame()
      {
         super();
         initView();
         addEvent();
         BraveLegManager.instance.requestTeamList();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("braveleg.TitleImg");
         _rankTitle = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankTitleImg");
         _teamListTitle = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamListTitle");
         _teamListImg1 = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamListImg1");
         _teamListImg2 = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamListImg2");
         _topList = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpFrameTopList");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpPageTxt");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpPageBg");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpPrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpNextPageBtn");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpFrameTimeTxt");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpFrameShopBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpFrameRankBtn");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpFrameRewardBtn");
         _signUpBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpFrameSignUpBtn");
         _createTeamBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.SignUpFrameCreateTeamBtn");
         _head = ComponentFactory.Instance.creatComponentByStylename("braveleg.MyHead");
         _medal = ComponentFactory.Instance.creatComponentByStylename("braveleg.MyMedal");
         _scoreImg = ComponentFactory.Instance.creatComponentByStylename("braveleg.MyScoreImg");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.MyScoreTxt");
         _fightImg = ComponentFactory.Instance.creatComponentByStylename("braveleg.MyFightImg");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.MyFightTxt");
         _teamList = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamList");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamListRefreshBtn");
         addToContent(_titleImg);
         addToContent(_rankTitle);
         addToContent(_teamListTitle);
         addToContent(_teamListImg1);
         addToContent(_teamListImg2);
         addToContent(_topList);
         addToContent(_pageNumTxt);
         addToContent(_pageBg);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_timeTxt);
         addToContent(_shopBtn);
         addToContent(_rankBtn);
         addToContent(_rewardBtn);
         addToContent(_signUpBtn);
         addToContent(_createTeamBtn);
         addToContent(_head);
         addToContent(_medal);
         addToContent(_scoreImg);
         addToContent(_scoreTxt);
         addToContent(_fightImg);
         addToContent(_fightTxt);
         addToContent(_teamList);
         addToContent(_refreshBtn);
         _refreshBtn.enable = false;
         _timer = new Timer(1000);
         _head.headId = ArmyManager.instance.thane.snsInfo.headId;
         _fightTxt.text = ArmyManager.instance.thane.fightingCapacity + "";
         _signUpBtn.supportTipsWhenGray = true;
         _signUpBtn.enable = false;
         _createTeamBtn.supportTipsWhenGray = true;
         _createTeamBtn.enable = false;
         _rankList = new Vector.<BraveLegPlayerInfo>();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _rankList.push(null);
            _loc1_++;
         }
         _maxPage = 1;
         currentPage = 1;
         _rewardBtn.tipData = LanguageMgr.GetTranslation("braveleg.SignUp.RewardTip");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _timer.addEventListener("timer",__timeUpdateHandler);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         _shopBtn.addEventListener("click",__shopBtnClickHandler);
         _rankBtn.addEventListener("click",__rankBtnClickHandler);
         _signUpBtn.addEventListener("click",__signUpBtnClickHandler);
         _createTeamBtn.addEventListener("click",__createTeamBtnClickHandler);
         _prePageBtn.addEventListener("click",__pagePreBtnClickHandler);
         _nextPageBtn.addEventListener("click",__pageNextBtnClickHandler);
         _model.addEventListener("BraveLegEvent.TEAMLIST_UPDATE",__onUpdateTeamListHandler);
         NotificationManager.instance.addEventListener("BraveLegEvent.CLOSE_SIGNUP",__closeViewHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _timer.removeEventListener("timer",__timeUpdateHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         _shopBtn.removeEventListener("click",__shopBtnClickHandler);
         _rankBtn.removeEventListener("click",__rankBtnClickHandler);
         _signUpBtn.removeEventListener("click",__signUpBtnClickHandler);
         _createTeamBtn.removeEventListener("click",__createTeamBtnClickHandler);
         _prePageBtn.removeEventListener("click",__pagePreBtnClickHandler);
         _nextPageBtn.removeEventListener("click",__pageNextBtnClickHandler);
         _model.removeEventListener("BraveLegEvent.TEAMLIST_UPDATE",__onUpdateTeamListHandler);
         NotificationManager.instance.removeEventListener("BraveLegEvent.CLOSE_SIGNUP",__closeViewHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_rankTitle);
         _rankTitle = null;
         ObjectUtils.disposeObject(_teamListTitle);
         _teamListTitle = null;
         ObjectUtils.disposeObject(_teamListImg1);
         _teamListImg1 = null;
         ObjectUtils.disposeObject(_teamListImg2);
         _teamListImg2 = null;
         ObjectUtils.disposeObject(_topList);
         _topList = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_signUpBtn);
         _signUpBtn = null;
         ObjectUtils.disposeObject(_createTeamBtn);
         _createTeamBtn = null;
         ObjectUtils.disposeObject(_head);
         _head = null;
         ObjectUtils.disposeObject(_medal);
         _medal = null;
         ObjectUtils.disposeObject(_scoreImg);
         _scoreImg = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_fightImg);
         _fightImg = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_teamList);
         _teamList = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         if(_timer)
         {
            _timer.stop();
            _timer = null;
         }
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
      
      private function __timeUpdateHandler(param1:TimerEvent) : void
      {
         _timeCount = _timeCount - 1;
         if(_timeCount <= 0)
         {
            _timeCount = _timeMaxCount;
            BraveLegManager.instance.requestTeamList();
         }
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ - _clickTime < 1000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str06"));
            return;
         }
         SoundManager.instance.play("016",true);
         _clickTime = _loc2_;
         _timeCount = _timeMaxCount;
         BraveLegManager.instance.requestTeamList();
      }
      
      private function __shopBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",16);
      }
      
      private function __rankBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         BraveLegManager.instance.requestRankInfo();
         FrameControllerManager.instance.openControllerByInfo("braveleg",{"tab":2});
      }
      
      private function __signUpBtnClickHandler(param1:MouseEvent) : void
      {
         if(_data.isOver)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str03"));
            return;
         }
         if(_data.isSign)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str04"));
            BraveLegManager.instance.requestViewInfo();
            return;
         }
         if(_data.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str05"));
            return;
         }
         SimpleAlertHelper.instance.data = [conformSignUp];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("braveleg.Dialog.signup",ConfigInfoManager.instance.getBraveLegSignUpGold());
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function __createTeamBtnClickHandler(param1:MouseEvent) : void
      {
         if(_data.isOver)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str03"));
            return;
         }
         if(!_data.isSign)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str02"));
            return;
         }
         if(!_data.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str01"));
            return;
         }
         BraveLegManager.instance.requestCreateTeam();
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
      
      private function __onUpdateTeamListHandler(param1:BraveLegEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _teamList.beginChanges();
         _teamList.vectorListModel.clear();
         if(param1.data)
         {
            _loc3_ = 0;
            _loc2_ = int(param1.data.length);
            while(_loc3_ < _loc2_)
            {
               _teamList.vectorListModel.append(param1.data[_loc3_]);
               _loc3_++;
            }
         }
         _teamList.commitChanges();
         _teamList.list.updateListView();
      }
      
      private function __closeViewHandler(param1:BraveLegEvent) : void
      {
         dispose();
      }
      
      private function conformSignUp(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            BraveLegManager.instance.requestSignUp();
         }
      }
      
      public function set data(param1:BraveLegSignUpInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         _data = param1;
         if(param1)
         {
            _medal.setFrame(param1.teamType + 1);
            _loc2_ = LanguageMgr.GetTranslation("braveleg.GroupName.full" + (param1.teamType + 1));
            if(param1.teamType < 5)
            {
               _loc3_ = LanguageMgr.GetTranslation("braveleg.GroupName.full" + (param1.teamType + 2));
               _medal.tipData = LanguageMgr.GetTranslation("braveleg.GroupTipNext",_loc3_,_groupScore[param1.teamType] - param1.totalScore);
            }
            else
            {
               _medal.tipData = LanguageMgr.GetTranslation("braveleg.GroupTip",_loc2_,param1.totalScore);
            }
            _scoreTxt.text = param1.totalScore + "";
            _timeTxt.text = LanguageMgr.GetTranslation("braveleg.SignUp.Desc",param1.openTime,param1.leftWarIndex);
            _signUpBtn.enable = !param1.isSign;
            if(param1.isSign)
            {
               _signUpBtn.tipData = LanguageMgr.GetTranslation("braveleg.Tip.sign");
            }
            else
            {
               _signUpBtn.tipData = null;
            }
            _createTeamBtn.enable = param1.isOpen;
            if(param1.isOpen)
            {
               _createTeamBtn.tipData = null;
            }
            else
            {
               _createTeamBtn.tipData = LanguageMgr.GetTranslation("braveleg.Tip.notopen");
            }
            setOpen(param1.isOpen);
            _rankList = param1.topList;
            _maxPage = Math.max(Math.ceil(_rankList.length / 5),1);
            currentPage = Math.max(Math.min(_page,_maxPage),1);
         }
         else
         {
            setOpen(false);
         }
      }
      
      private function setOpen(param1:Boolean) : void
      {
         if(_isOpen != param1)
         {
            _isOpen = param1;
            _refreshBtn.enable = _isOpen;
            if(_isOpen)
            {
               if(!_timer.running)
               {
                  _timer.start();
               }
            }
            else
            {
               if(!_timer.running)
               {
                  _timer.stop();
               }
               _timeCount = _timeMaxCount;
            }
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
         _topList.beginChanges();
         _topList.vectorListModel.clear();
         var _loc2_:Vector.<BraveLegPlayerInfo> = _rankList.slice((_page - 1) * 5,_page * 5);
         _loc4_ = 0;
         _loc3_ = int(_loc2_.length);
         while(_loc4_ < _loc3_)
         {
            _topList.vectorListModel.append(_loc2_[_loc4_]);
            _loc4_++;
         }
         _topList.commitChanges();
         _topList.list.updateListView();
      }
      
      public function show() : void
      {
         if(parent == null)
         {
            LayerManager.Instance.addToLayer(this,3,true,true,0);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1084,625);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
   }
}

